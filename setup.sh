#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}╔═══════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  Smart News App - Setup Script       ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════╝${NC}"
echo ""

# Check Flutter installation
echo -e "${YELLOW}[1/5] Checking Flutter installation...${NC}"
if ! command -v flutter &> /dev/null; then
    echo -e "${RED}❌ Flutter is not installed. Please install Flutter first.${NC}"
    echo "Visit: https://docs.flutter.dev/get-started/install"
    exit 1
fi
echo -e "${GREEN}✓ Flutter is installed${NC}"
flutter --version
echo ""

# Get dependencies
echo -e "${YELLOW}[2/5] Fetching dependencies...${NC}"
flutter pub get
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Failed to get dependencies${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Dependencies fetched successfully${NC}"
echo ""

# Generate code
echo -e "${YELLOW}[3/5] Generating code (JSON serialization)...${NC}"
flutter pub run build_runner build --delete-conflicting-outputs
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Code generation failed${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Code generated successfully${NC}"
echo ""

# Check for API key
echo -e "${YELLOW}[4/5] Checking API key configuration...${NC}"
API_KEY_FILE="lib/core/constants/app_constants.dart"
if grep -q "YOUR_NEWS_API_KEY_HERE" "$API_KEY_FILE"; then
    echo -e "${YELLOW}⚠️  WARNING: API key not configured!${NC}"
    echo "Please add your NewsAPI key in: $API_KEY_FILE"
    echo "Get your free key at: https://newsapi.org/register"
    echo ""
    read -p "Do you want to continue anyway? (y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
else
    echo -e "${GREEN}✓ API key is configured${NC}"
fi
echo ""

# List available devices
echo -e "${YELLOW}[5/5] Checking available devices...${NC}"
flutter devices
echo ""

echo -e "${GREEN}╔═══════════════════════════════════════╗${NC}"
echo -e "${GREEN}║        Setup Complete! 🎉            ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════╝${NC}"
echo ""
echo "To run the app:"
echo "  flutter run"
echo ""
echo "To run on a specific device:"
echo "  flutter run -d <device-id>"
echo ""
echo "To run in release mode:"
echo "  flutter run --release"
echo ""
