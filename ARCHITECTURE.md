# Smart News Aggregator - Architecture Documentation

## 📋 Project Overview

Smart News App là ứng dụng tin tức được xây dựng với **Clean Architecture** và **Flutter**, tích hợp NewsAPI để hiển thị tin tức từ nhiều nguồn khác nhau.

## 🏗 Architecture

Dự án sử dụng **Clean Architecture** với 3 layers chính:

```
lib/
├── core/                          # Core utilities & configurations
│   ├── constants/                 # App constants & enums
│   ├── di/                        # Dependency Injection (GetIt)
│   ├── error/                     # Error handling (Failures & Exceptions)
│   ├── network/                   # Network utilities (Dio, NetworkInfo)
│   ├── router/                    # App routing (GoRouter)
│   ├── theme/                     # Theme configuration
│   ├── usecase/                   # Base UseCase
│   └── utils/                     # Utilities (Logger)
│
├── features/                      # Feature modules
│   ├── news/                      # Main news feature
│   │   ├── data/
│   │   │   ├── datasources/      # Remote & Local data sources
│   │   │   ├── models/           # Data models with JSON serialization
│   │   │   └── repositories/     # Repository implementations
│   │   ├── domain/
│   │   │   ├── entities/         # Business entities
│   │   │   ├── repositories/     # Repository interfaces
│   │   │   └── usecases/         # Business logic use cases
│   │   └── presentation/
│   │       ├── bloc/             # BLoC state management
│   │       ├── pages/            # UI pages
│   │       └── widgets/          # Reusable widgets
│   │
│   ├── categories/                # Category filtering feature
│   ├── bookmarks/                 # Bookmarks feature
│   └── settings/                  # Settings feature
│
├── shared/                        # Shared components
│   └── cubit/                     # App-level state (theme, locale)
│
├── app.dart                       # App widget
└── main.dart                      # Entry point
```

## 🔧 Setup Instructions

### 1. Prerequisites
- Flutter SDK: ^3.10.7
- Dart SDK: ^3.10.7

### 2. Clone & Install Dependencies

\`\`\`bash
# Navigate to project
cd news_app

# Get dependencies
flutter pub get
\`\`\`

### 3. Configure API Key

Open [lib/core/constants/app_constants.dart](lib/core/constants/app_constants.dart) and add your NewsAPI key:

\`\`\`dart
static const String newsApiKey = 'YOUR_API_KEY_HERE';
\`\`\`

Get your free API key from: https://newsapi.org/

### 4. Generate Code

Generate JSON serialization code:

\`\`\`bash
flutter pub run build_runner build --delete-conflicting-outputs
\`\`\`

### 5. Run the App

\`\`\`bash
# Run on connected device/emulator
flutter run

# Run on specific device
flutter run -d <device-id>

# Run in release mode
flutter run --release
\`\`\`

## 📦 Dependencies

### State Management
- \`flutter_bloc\`: ^8.1.6 - BLoC pattern for state management
- \`equatable\`: ^2.0.5 - Value equality

### Dependency Injection
- \`get_it\`: ^8.0.2 - Service locator

### Navigation
- \`go_router\`: ^14.6.2 - Declarative routing

### Networking
- \`dio\`: ^5.7.0 - HTTP client
- \`connectivity_plus\`: ^6.1.2 - Network connectivity

### Storage
- \`shared_preferences\`: ^2.3.3 - Local storage

### JSON Serialization
- \`json_annotation\`: ^4.9.0
- \`json_serializable\`: ^6.9.5 (dev)
- \`freezed\`: ^2.5.7 (dev)

### UI Components
- \`cached_network_image\`: ^3.4.1 - Image caching
- \`shimmer\`: ^3.0.0 - Loading skeleton
- \`url_launcher\`: ^6.3.1 - Open URLs

### Utilities
- \`logger\`: ^2.5.0 - Logging
- \`dartz\`: ^0.10.1 - Functional programming (Either)

## 🎯 Features

### ✅ Implemented
- Top headlines by category
- Search news by keywords
- News details page
- Category filtering
- Bookmarks (local storage)
- Offline caching
- Pull-to-refresh
- Infinite scrolling
- Light/Dark theme support
- Settings page

### 🚧 To Be Implemented
- Theme selection in settings
- Country selection
- Auto-refresh toggle
- Cache management
- Share functionality
- Multi-language support

## 📝 Code Generation

This project uses code generation for JSON serialization. After modifying models:

\`\`\`bash
# Generate once
flutter pub run build_runner build --delete-conflicting-outputs

# Watch for changes (development)
flutter pub run build_runner watch --delete-conflicting-outputs
\`\`\`

## 🧪 Testing

\`\`\`bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
\`\`\`

## 📱 Supported Platforms
- ✅ Android
- ✅ iOS
- ✅ Web (limited functionality)

## 🔑 Environment Variables

Create a \`.env\` file (optional, for production):

\`\`\`
NEWS_API_KEY=your_api_key_here
\`\`\`

## 🤝 Contributing

1. Follow Clean Architecture principles
2. Use BLoC for state management
3. Write tests for business logic
4. Follow Flutter style guide
5. Generate code after model changes

## 📄 License

This project is for educational purposes.

## 🔗 Resources

- [NewsAPI Documentation](https://newsapi.org/docs)
- [Flutter Documentation](https://docs.flutter.dev/)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [BLoC Pattern](https://bloclibrary.dev/)
