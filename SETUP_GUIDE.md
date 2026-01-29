# 🚀 Setup Guide - Smart News App

Hướng dẫn chi tiết từng bước để thiết lập và chạy ứng dụng Smart News.

---

## 📋 Yêu cầu hệ thống

### 1. Flutter SDK
- **Version:** 3.10.7 trở lên
- **Download:** https://docs.flutter.dev/get-started/install

### 2. IDE (Chọn 1 trong các options)
- **VS Code** + Flutter Extension (Khuyên dùng)
- **Android Studio** + Flutter Plugin
- **IntelliJ IDEA** + Flutter Plugin

### 3. Platform Tools
- **Android:** Android SDK, Android Emulator
- **iOS:** Xcode (chỉ trên macOS)
- **Web:** Chrome browser

### 4. NewsAPI Key
- **Miễn phí:** https://newsapi.org/register
- **Giới hạn:** 100 requests/ngày

---

## 🛠 Cài đặt từng bước

### Bước 1: Kiểm tra Flutter

Mở terminal và chạy:

\`\`\`bash
flutter doctor
\`\`\`

**Output mong muốn:**
\`\`\`
✓ Flutter (Channel stable, 3.10.7)
✓ Android toolchain
✓ Xcode (macOS only)
✓ VS Code
✓ Connected device
\`\`\`

Nếu có ❌, follow hướng dẫn của flutter doctor để fix.

---

### Bước 2: Clone Project

\`\`\`bash
# Clone repository
git clone <repository-url>
cd news_app

# Hoặc nếu đã có source code
cd news_app
\`\`\`

---

### Bước 3: Cài đặt Dependencies

#### Option 1: Sử dụng setup script (macOS/Linux)

\`\`\`bash
./setup.sh
\`\`\`

Script này sẽ tự động:
- Kiểm tra Flutter
- Cài đặt dependencies
- Generate code
- Kiểm tra API key
- List available devices

#### Option 2: Manual setup

\`\`\`bash
# 1. Get dependencies
flutter pub get

# 2. Generate code
flutter pub run build_runner build --delete-conflicting-outputs
\`\`\`

---

### Bước 4: Cấu hình API Key

#### 4.1. Lấy API Key

1. Truy cập: https://newsapi.org/register
2. Điền form đăng ký (email, tên, mục đích sử dụng)
3. Verify email
4. Copy API key từ dashboard

#### 4.2. Thêm API Key vào project

Mở file: \`lib/core/constants/app_constants.dart\`

\`\`\`dart
class AppConstants {
  // Thay YOUR_NEWS_API_KEY_HERE bằng API key của bạn
  static const String newsApiKey = 'YOUR_NEWS_API_KEY_HERE';
  
  // VÍ DỤ:
  // static const String newsApiKey = 'abc123def456...';
  
  // ... các constants khác
}
\`\`\`

**⚠️ LƯU Ý:**
- Không commit API key lên GitHub
- API key đã được thêm vào .gitignore
- Dùng environment variables cho production

---

### Bước 5: Kiểm tra Devices

#### 5.1. List tất cả devices

\`\`\`bash
flutter devices
\`\`\`

**Output example:**
\`\`\`
4 connected devices:

iPhone 15 Pro (mobile)     • F3B1C2D4-... • ios   • com.apple.CoreSimulator.SimRuntime.iOS-17-0
Pixel 6 API 34 (mobile)    • emulator-5554 • android-x64 • Android 14
macOS (desktop)            • macos        • darwin-arm64 • macOS 14.0
Chrome (web)               • chrome       • web-javascript • Google Chrome 120.0
\`\`\`

#### 5.2. Start emulator nếu cần

**Android:**
\`\`\`bash
# List Android emulators
flutter emulators

# Start một emulator
flutter emulators --launch <emulator-id>
\`\`\`

**iOS (macOS only):**
\`\`\`bash
# Mở iOS Simulator
open -a Simulator
\`\`\`

---

### Bước 6: Chạy App

#### 6.1. Chạy trên device mặc định

\`\`\`bash
flutter run
\`\`\`

#### 6.2. Chạy trên device cụ thể

\`\`\`bash
# Chọn device từ list
flutter run -d <device-id>

# VD: iPhone
flutter run -d "iPhone 15 Pro"

# VD: Android emulator  
flutter run -d emulator-5554

# VD: Chrome
flutter run -d chrome
\`\`\`

#### 6.3. Chạy ở chế độ khác

\`\`\`bash
# Debug mode (default)
flutter run

# Release mode (tối ưu performance)
flutter run --release

# Profile mode (cho performance profiling)
flutter run --profile
\`\`\`

---

## 🔧 Troubleshooting

### Lỗi 1: "Target of URI doesn't exist"

**Nguyên nhân:** Chưa generate code hoặc thiếu dependencies

**Giải pháp:**
\`\`\`bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
\`\`\`

---

### Lỗi 2: "Invalid API key" hoặc "Rate limit exceeded"

**Nguyên nhân:** 
- API key sai
- Vượt quá giới hạn 100 requests/ngày (free tier)

**Giải pháp:**
1. Kiểm tra lại API key trong \`app_constants.dart\`
2. Verify key tại https://newsapi.org/account
3. Chờ 24h nếu vượt rate limit
4. Consider upgrade plan nếu cần nhiều requests hơn

---

### Lỗi 3: "No devices found"

**Nguyên nhân:** Không có device/emulator nào running

**Giải pháp:**

**Android:**
\`\`\`bash
# Start emulator
flutter emulators --launch Pixel_6_API_34

# Hoặc start từ Android Studio:
# Tools > Device Manager > Play button
\`\`\`

**iOS:**
\`\`\`bash
# Mở Simulator
open -a Simulator

# Hoặc từ Xcode:
# Xcode > Open Developer Tool > Simulator
\`\`\`

**Physical Device:**
- Enable USB debugging (Android)
- Trust computer (iOS)
- Kết nối qua USB

---

### Lỗi 4: Build failed trên Android

**Giải pháp:**
\`\`\`bash
# 1. Clean build
cd android
./gradlew clean
cd ..
flutter clean

# 2. Rebuild
flutter pub get
flutter run
\`\`\`

---

### Lỗi 5: Build failed trên iOS

**Giải pháp:**
\`\`\`bash
# 1. Clean build
cd ios
rm -rf Pods
rm Podfile.lock
cd ..

# 2. Reinstall pods
cd ios
pod install
cd ..

# 3. Rebuild
flutter clean
flutter pub get
flutter run
\`\`\`

---

## 📱 Testing App

### 1. Kiểm tra Top Headlines
- Mở app → Xem danh sách tin tức
- Scroll xuống → Load more articles
- Pull down → Refresh

### 2. Kiểm tra Categories
- Tap category chips phía trên
- Chọn Technology, Sports, etc.
- Verify articles thay đổi theo category

### 3. Kiểm tra Search
- Tap search icon
- Nhập từ khóa (VD: "flutter", "apple")
- Verify kết quả tìm kiếm

### 4. Kiểm tra Article Detail
- Tap vào một article
- Xem full content
- Tap "Read Full Article" → Opens in browser

### 5. Kiểm tra Bookmarks
- Tap bookmark icon (sẽ implement sau)
- Go to bookmarks page
- Verify saved articles

### 6. Kiểm tra Offline Mode
- Load một số articles
- Bật airplane mode
- Reopen app → Verify cached articles vẫn hiển thị

---

## 🎨 Customization

### Thay đổi Theme Colors

Edit \`lib/core/theme/app_colors.dart\`:

\`\`\`dart
class AppColors {
  static const Color primary = Color(0xFF2196F3); // Đổi màu primary
  // ...
}
\`\`\`

### Thay đổi Default Country

Edit \`lib/core/constants/app_constants.dart\`:

\`\`\`dart
// Thay đổi country code (us, gb, ca, etc.)
country: 'us',  // → 'gb' cho UK
\`\`\`

### Thay đổi Page Size

\`\`\`dart
static const int pageSize = 20; // Số articles per page
\`\`\`

---

## 📝 Development Tips

### Hot Reload
- Press \`r\` trong terminal sau khi save changes
- Hoặc save file trong IDE (auto hot reload)

### Hot Restart
- Press \`R\` trong terminal
- Hoặc click hot restart icon trong IDE

### Debug Console
- Check terminal output để xem logs
- Sử dụng \`AppLogger.d()\` trong code

### Format Code
\`\`\`bash
flutter format lib/
\`\`\`

### Analyze Code
\`\`\`bash
flutter analyze
\`\`\`

---

## 🔄 Update Project

### Update Dependencies

\`\`\`bash
# Check outdated packages
flutter pub outdated

# Update all packages
flutter pub upgrade

# Update specific package
flutter pub upgrade <package_name>
\`\`\`

### Regenerate Code

Sau khi update dependencies hoặc modify models:

\`\`\`bash
flutter pub run build_runner build --delete-conflicting-outputs
\`\`\`

---

## 📚 Next Steps

1. **Add Features:** Implement bookmark functionality completely
2. **Testing:** Write unit tests & widget tests
3. **CI/CD:** Setup GitHub Actions for automated testing
4. **Deploy:** Build release APK/IPA
5. **Publish:** Submit to Play Store / App Store

---

## 🆘 Need Help?

- **Flutter Docs:** https://docs.flutter.dev/
- **NewsAPI Docs:** https://newsapi.org/docs
- **Issue Tracker:** Create issue on GitHub
- **Community:** Stack Overflow, Flutter Discord

---

## ✅ Checklist

- [ ] Flutter doctor passed
- [ ] Dependencies installed
- [ ] Code generated
- [ ] API key configured
- [ ] Device/emulator ready
- [ ] App running successfully
- [ ] All features working
- [ ] No errors in console

---

**🎉 Chúc bạn code vui vẻ!**
