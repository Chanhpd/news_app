# 🚀 Quick Reference Guide

Hướng dẫn nhanh cho các tác vụ thường dùng trong dự án.

---

## ⚡ Quick Commands

### Setup & Install
\`\`\`bash
# Quick setup (macOS/Linux)
./setup.sh

# Manual setup
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
\`\`\`

### Run App
\`\`\`bash
# Run on default device
flutter run

# Run on specific device
flutter run -d chrome
flutter run -d "iPhone 15 Pro"
flutter run -d emulator-5554

# Release mode
flutter run --release
\`\`\`

### Development
\`\`\`bash
# Hot reload: Press 'r' in terminal
# Hot restart: Press 'R' in terminal

# Format code
flutter format lib/

# Analyze code
flutter analyze

# Clean build
flutter clean
\`\`\`

### Code Generation
\`\`\`bash
# Generate once
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (auto-generate)
flutter pub run build_runner watch
\`\`\`

### Testing
\`\`\`bash
# Run all tests
flutter test

# Run specific test
flutter test test/unit/news_bloc_test.dart

# With coverage
flutter test --coverage
\`\`\`

### Build
\`\`\`bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle

# iOS
flutter build ios --release

# Web
flutter build web
\`\`\`

---

## 📁 Common File Locations

### Add API Key
\`\`\`
lib/core/constants/app_constants.dart
→ newsApiKey = 'YOUR_KEY'
\`\`\`

### Add New Route
\`\`\`
lib/core/router/app_router.dart
→ Add GoRoute
\`\`\`

### Add New Dependency
\`\`\`
pubspec.yaml
→ Add under dependencies
→ Run: flutter pub get
\`\`\`

### Register Dependency
\`\`\`
lib/core/di/injection.dart
→ Add in configureDependencies()
\`\`\`

### Change Theme Colors
\`\`\`
lib/core/theme/app_colors.dart
→ Modify Color constants
\`\`\`

### Add New Constants
\`\`\`
lib/core/constants/app_constants.dart
→ Add static const
\`\`\`

---

## 🏗 Creating New Features

### 1. Create Feature Structure
\`\`\`bash
mkdir -p lib/features/my_feature/{data,domain,presentation}/{datasources,models,repositories,entities,usecases,bloc,pages,widgets}
\`\`\`

### 2. Create Domain Layer
\`\`\`dart
// Entity
class MyEntity extends Equatable { ... }

// Repository Interface  
abstract class MyRepository { ... }

// Use Case
class GetMyData implements UseCase<MyEntity, NoParams> { ... }
\`\`\`

### 3. Create Data Layer
\`\`\`dart
// Model (with JSON)
@JsonSerializable()
class MyModel { ... }

// Data Source
abstract class MyDataSource { ... }
class MyDataSourceImpl implements MyDataSource { ... }

// Repository Implementation
class MyRepositoryImpl implements MyRepository { ... }
\`\`\`

### 4. Create Presentation Layer
\`\`\`dart
// Events
abstract class MyEvent extends Equatable { ... }

// States
abstract class MyState extends Equatable { ... }

// BLoC
class MyBloc extends Bloc<MyEvent, MyState> { ... }

// Page
class MyPage extends StatelessWidget { ... }
\`\`\`

### 5. Register Dependencies
\`\`\`dart
// In injection.dart
getIt.registerLazySingleton<MyDataSource>(
  () => MyDataSourceImpl(),
);
// ... register all dependencies
\`\`\`

### 6. Add Route
\`\`\`dart
// In app_router.dart
GoRoute(
  path: '/my-page',
  name: 'my-page',
  builder: (context, state) => const MyPage(),
),
\`\`\`

---

## 🔧 Common Code Snippets

### BLoC Provider in Page
\`\`\`dart
BlocProvider(
  create: (_) => getIt<MyBloc>()..add(InitialEvent()),
  child: const MyView(),
)
\`\`\`

### BLoC Builder
\`\`\`dart
BlocBuilder<MyBloc, MyState>(
  builder: (context, state) {
    if (state is MyLoading) {
      return const CircularProgressIndicator();
    }
    if (state is MyLoaded) {
      return MyWidget(data: state.data);
    }
    return const SizedBox();
  },
)
\`\`\`

### Navigation
\`\`\`dart
// Push
context.push('/detail', extra: myData);

// Push named
context.pushNamed('detail', extra: myData);

// Pop
context.pop();

// Replace
context.go('/home');
\`\`\`

### Show SnackBar
\`\`\`dart
ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(content: Text('Message')),
);
\`\`\`

### Show Dialog
\`\`\`dart
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: const Text('Title'),
    content: const Text('Content'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('OK'),
      ),
    ],
  ),
);
\`\`\`

### Dependency Injection
\`\`\`dart
// Get instance
final myBloc = getIt<MyBloc>();

// Register Singleton
getIt.registerSingleton<MyService>(MyService());

// Register Lazy Singleton
getIt.registerLazySingleton<MyService>(() => MyService());

// Register Factory
getIt.registerFactory<MyBloc>(() => MyBloc());
\`\`\`

---

## 📊 Project Statistics

### File Count
- Total Dart files: ~50
- Features: 4 (News, Bookmarks, Categories, Settings)
- BLoCs: 2 (News, Bookmarks)
- Pages: ~7
- Widgets: ~5

### Lines of Code
- Core: ~500
- Features: ~2000
- Tests: TBD
- **Total: ~2500+**

---

## 🎯 Architecture Shortcuts

### Data Flow
\`\`\`
UI → Event → BLoC → UseCase → Repository → DataSource → API/Cache
                ↓
            State → UI
\`\`\`

### Dependency Direction
\`\`\`
Presentation → Domain → Data → Core
(Higher layers depend on lower layers)
\`\`\`

### Error Handling
\`\`\`dart
// Use Either<Failure, Success>
result.fold(
  (failure) => handleError(failure),
  (success) => handleSuccess(success),
);
\`\`\`

---

## 🐛 Debug Tips

### Enable Debug Logging
\`\`\`dart
// Already enabled via AppLogger
AppLogger.d('Debug message');
AppLogger.i('Info message');
AppLogger.w('Warning message');
AppLogger.e('Error message');
\`\`\`

### Check Network Requests
- Open terminal running app
- Look for Dio logs (Request/Response)

### Check BLoC States
\`\`\`dart
BlocObserver implementation in main.dart
→ Shows all events & state changes
\`\`\`

### Performance Profiling
\`\`\`bash
# Run in profile mode
flutter run --profile

# Open DevTools
flutter pub global activate devtools
flutter pub global run devtools
\`\`\`

### Memory Leaks
\`\`\`bash
# Run with --enable-vm-service
flutter run --enable-vm-service

# Use Observatory or DevTools
\`\`\`

---

## 🔑 Environment Variables

### Development
\`\`\`dart
// In app_constants.dart
static const String newsApiKey = 'dev_key_here';
\`\`\`

### Production (Recommended)
\`\`\`bash
# Create .env file
echo "NEWS_API_KEY=your_key" > .env

# Add to .gitignore
echo ".env" >> .gitignore

# Use flutter_dotenv package
# Load in main.dart
\`\`\`

---

## 📱 Device Testing

### iOS Simulator
\`\`\`bash
open -a Simulator
flutter run -d "iPhone 15 Pro"
\`\`\`

### Android Emulator
\`\`\`bash
flutter emulators
flutter emulators --launch Pixel_6_API_34
flutter run -d emulator-5554
\`\`\`

### Physical Device
\`\`\`bash
# Android: Enable USB debugging
# iOS: Trust computer

flutter devices
flutter run -d <device-id>
\`\`\`

### Web
\`\`\`bash
flutter run -d chrome
flutter run -d web-server --web-port 8080
\`\`\`

---

## 🛠 Troubleshooting Quick Fixes

### Problem: Build errors
\`\`\`bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
\`\`\`

### Problem: Hot reload not working
\`\`\`bash
# Press 'R' for hot restart
# Or restart: flutter run
\`\`\`

### Problem: Gradle issues (Android)
\`\`\`bash
cd android
./gradlew clean
cd ..
flutter run
\`\`\`

### Problem: Pod issues (iOS)
\`\`\`bash
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
flutter run
\`\`\`

### Problem: API not working
1. Check API key in app_constants.dart
2. Check internet connection
3. Check rate limits (100/day for free)
4. Test API in Postman/browser

---

## 📚 Useful Resources

### Documentation
- [Flutter Docs](https://docs.flutter.dev)
- [Dart Docs](https://dart.dev/guides)
- [NewsAPI Docs](https://newsapi.org/docs)

### Packages
- [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- [get_it](https://pub.dev/packages/get_it)
- [go_router](https://pub.dev/packages/go_router)
- [dio](https://pub.dev/packages/dio)

### Learning
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [BLoC Tutorial](https://bloclibrary.dev/#/gettingstarted)
- [Flutter Codelabs](https://docs.flutter.dev/codelabs)

---

## 🎨 UI Components Available

- ArticleCard
- ArticleImage (cached)
- CategoryChips
- LoadingIndicator (CircularProgressIndicator)
- ErrorWidget
- EmptyState

---

## ⌨️ VS Code Shortcuts

- `Cmd/Ctrl + .` - Quick Fix
- `Cmd/Ctrl + Space` - Auto-complete
- `Shift + Alt + F` - Format document
- `F2` - Rename symbol
- `F12` - Go to definition
- `Shift + F12` - Find all references

---

**💡 Pro Tip:** Keep this file open in a separate tab for quick reference during development!
