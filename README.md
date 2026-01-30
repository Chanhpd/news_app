# 📰 Smart News Aggregator App (Flutter)

A production-ready Flutter application that aggregates news from public REST APIs with **Clean Architecture**, allowing users to browse, search, and save articles across multiple categories.

![Flutter](https://img.shields.io/badge/Flutter-3.10.7-blue)
![Dart](https://img.shields.io/badge/Dart-3.10.7-blue)
![Clean Architecture](https://img.shields.io/badge/Architecture-Clean-green)

## ⚠️ Important: Country Selection

**Not all countries have news on the free NewsAPI tier!**

**Countries with BEST coverage:**
- 🇺🇸 **United States** (default & recommended)
- 🇬🇧 **United Kingdom**  
- 🇮🇳 **India**
- 🇩🇪 **Germany**
- 🇦🇺 **Australia**

**If you see "No articles available":**
1. Open **Settings** → **Country**
2. Select **United States** or another country from the list above
3. App will reload with news from that country

📄 [Read more about country coverage](API_COUNTRIES.md)

---

## 🚀 Features

### ✅ Implemented
- ✨ **Top Headlines** - Latest news from various sources
- 🔍 **Search** - Find articles by keywords
- 📑 **Categories** - Browse by: Technology, Business, Sports, Entertainment, Health, Science
- 🔖 **Bookmarks** - Save articles for offline reading
- 📱 **Responsive UI** - Beautiful Material Design 3
- 🔄 **Pull-to-Refresh** - Keep content up-to-date
- ♾️ **Infinite Scrolling** - Load more articles automatically
- 💾 **Offline Cache** - Read news without internet
- 🌓 **Dark/Light Mode** - System-based theme support
- ⚡ **Fast & Smooth** - Optimized performance

### 🚧 Coming Soon
- 🌍 Multi-language support
- 🔔 Push notifications
- 📊 Reading statistics
- 🤖 AI-powered recommendations

---

## 🏗 Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

```
├── Presentation Layer (UI + BLoC)
│   └── Pages, Widgets, State Management
│
├── Domain Layer (Business Logic)
│   └── Entities, Use Cases, Repository Interfaces
│
├── Data Layer (Data Sources)
│   └── Models, Remote/Local Data Sources, Repository Implementation
│
└── Core (Shared)
    └── DI, Router, Theme, Utils, Constants
```

**Tech Stack:**
- **State Management:** BLoC Pattern (flutter_bloc)
- **Dependency Injection:** GetIt
- **Navigation:** GoRouter
- **Networking:** Dio
- **Storage:** SharedPreferences
- **Functional Programming:** Dartz (Either)

For detailed architecture documentation, see [ARCHITECTURE.md](ARCHITECTURE.md)

---

## 📋 Prerequisites

- Flutter SDK: `^3.10.7`
- Dart SDK: `^3.10.7`
- IDE: VS Code, Android Studio, or IntelliJ IDEA
- NewsAPI Key (free): [Get API Key](https://newsapi.org/)

---

## 🛠 Installation & Setup

### 1. Clone the Repository

\`\`\`bash
git clone <repository-url>
cd news_app
\`\`\`

### 2. Install Dependencies

\`\`\`bash
flutter pub get
\`\`\`

### 3. Configure API Key

Open [lib/core/constants/app_constants.dart](lib/core/constants/app_constants.dart):

\`\`\`dart
class AppConstants {
  static const String newsApiKey = 'YOUR_API_KEY_HERE'; // ⚠️ Add your key
  // ...
}
\`\`\`

> **Get your free API key:** https://newsapi.org/register

### 4. Generate Code

Generate JSON serialization files:

\`\`\`bash
flutter pub run build_runner build --delete-conflicting-outputs
\`\`\`

### 5. Run the App

\`\`\`bash
# Development mode
flutter run

# Release mode
flutter run --release

# Specific device
flutter devices
flutter run -d <device-id>
\`\`\`

---

## 📱 Screenshots

<!-- Add your screenshots here -->
| Home | Categories | Search | Bookmarks |
|------|------------|--------|-----------|
| ![Home](screenshots/home.png) | ![Categories](screenshots/categories.png) | ![Search](screenshots/search.png) | ![Bookmarks](screenshots/bookmarks.png) |

---

## 🔌 API Integration

### NewsAPI.org
- **Base URL:** `https://newsapi.org/v2`
- **Endpoints Used:**
  - `/top-headlines` - Get top headlines
  - `/everything` - Search articles

**Example Request:**
\`\`\`bash
GET https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=YOUR_API_KEY
\`\`\`

**Rate Limits (Free Tier):**
- 100 requests per day
- 1 request per second

### ⚠️ FREE TIER LIMITATIONS

**CRITICAL:** NewsAPI.org free tier **ONLY supports United States (US)**. All other countries return 0 articles.

#### What Works:
- ✅ **United States** - Full coverage (~28+ articles)
- ✅ Categories (Business, Tech, Sports, etc.)
- ✅ Keyword search
- ✅ 100 requests/day

#### What Doesn't Work (Free Tier):
- ❌ **All other countries** (CA, GB, AU, DE, FR, IT, IN, etc.)
- ❌ Real-time updates (15-minute delay)
- ❌ Historical articles beyond 1 month

#### Solutions:
1. **Keep using US** (recommended for free tier)
2. **Upgrade to Business Plan** ($449/month) for global coverage
3. **Use alternative APIs**: GNews.io, NewsData.io, The Guardian API

See [FREE_TIER_LIMITATIONS.md](FREE_TIER_LIMITATIONS.md) for complete details.

---

## 📦 Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| flutter_bloc | ^8.1.6 | State management |
| get_it | ^8.0.2 | Dependency injection |
| go_router | ^14.6.2 | Navigation |
| dio | ^5.7.0 | HTTP client |
| dartz | ^0.10.1 | Functional programming |
| cached_network_image | ^3.4.1 | Image caching |
| shared_preferences | ^2.3.3 | Local storage |
| connectivity_plus | ^6.1.2 | Network status |
| logger | ^2.5.0 | Logging |
| url_launcher | ^6.3.1 | Open URLs |

See [pubspec.yaml](pubspec.yaml) for full list.

---

## 🧪 Testing

\`\`\`bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# View coverage report (requires lcov)
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
\`\`\`

---

## 🏃 Development Workflow

### Code Generation
When modifying data models:

\`\`\`bash
# One-time generation
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (auto-generate on save)
flutter pub run build_runner watch --delete-conflicting-outputs
\`\`\`

### Format Code
\`\`\`bash
flutter format lib/
\`\`\`

### Analyze Code
\`\`\`bash
flutter analyze
\`\`\`

---

## 📁 Project Structure

\`\`\`
lib/
├── core/                          # Core functionality
│   ├── constants/                 # App constants
│   ├── di/                        # Dependency injection
│   ├── error/                     # Error handling
│   ├── network/                   # Network utilities
│   ├── router/                    # Routing
│   ├── theme/                     # Theming
│   └── utils/                     # Utilities
│
├── features/                      # Feature modules
│   ├── news/                      # News feature (main)
│   │   ├── data/                  # Data layer
│   │   ├── domain/                # Domain layer
│   │   └── presentation/          # Presentation layer
│   ├── bookmarks/                 # Bookmarks feature
│   ├── categories/                # Categories feature
│   └── settings/                  # Settings feature
│
├── shared/                        # Shared components
│   └── cubit/                     # App-level state
│
├── app.dart                       # App widget
└── main.dart                      # Entry point
\`\`\`

---

## 🎯 Clean Architecture Layers

### 1. **Presentation Layer**
- Pages (UI screens)
- Widgets (reusable components)
- BLoC (state management)

### 2. **Domain Layer**
- Entities (business models)
- Use Cases (business logic)
- Repository Interfaces (contracts)

### 3. **Data Layer**
- Models (data transfer objects)
- Data Sources (remote/local)
- Repository Implementations

### 4. **Core Layer**
- Dependency Injection
- Routing
- Theme
- Utilities
- Constants

---

## 🤝 Contributing

Contributions are welcome! Please follow these guidelines:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

### Code Style
- Follow [Flutter Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use Clean Architecture principles
- Write meaningful commit messages
- Add tests for new features

---

## 📝 Notes

- **API Key Security:** Never commit API keys to version control
- **Offline Support:** Articles are cached for offline reading
- **Performance:** Images are cached using `cached_network_image`
- **Error Handling:** Proper error messages with retry functionality

---

## 🐛 Troubleshooting

### Common Issues

**1. "Target of URI doesn't exist" errors**
\`\`\`bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
\`\`\`

**2. API Key not working**
- Verify your API key at https://newsapi.org/
- Check rate limits (100 requests/day for free tier)
- Ensure key is correctly set in `app_constants.dart`

**3. Build errors**
\`\`\`bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
\`\`\`

---

## 📄 License

This project is for **educational and portfolio purposes**.

---

## 🔗 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [NewsAPI Documentation](https://newsapi.org/docs)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [BLoC Pattern](https://bloclibrary.dev/)
- [GoRouter Documentation](https://pub.dev/packages/go_router)

---

## 👨‍💻 Author

Built with ❤️ using Flutter & Clean Architecture

---

## ⭐ Star this repo

If you find this project useful, please give it a star! It helps others discover it.

# news_app
