# 📊 Project Structure Summary

## Overview
Smart News App được xây dựng với **Clean Architecture**, chia thành các layers rõ ràng để dễ maintain và test.

---

## 🗂 Complete Directory Tree

\`\`\`
news_app/
│
├── lib/
│   ├── main.dart                                    # Entry point
│   ├── app.dart                                     # Root app widget
│   │
│   ├── core/                                        # Core functionality
│   │   ├── constants/
│   │   │   ├── app_constants.dart                   # App-wide constants
│   │   │   └── news_categories.dart                 # News category enum
│   │   │
│   │   ├── di/
│   │   │   └── injection.dart                       # Dependency injection (GetIt)
│   │   │
│   │   ├── error/
│   │   │   ├── exceptions.dart                      # Exception classes
│   │   │   └── failures.dart                        # Failure classes (for Either)
│   │   │
│   │   ├── network/
│   │   │   ├── dio_client.dart                      # Dio HTTP client
│   │   │   └── network_info.dart                    # Network connectivity check
│   │   │
│   │   ├── router/
│   │   │   └── app_router.dart                      # GoRouter configuration
│   │   │
│   │   ├── theme/
│   │   │   ├── app_colors.dart                      # Color palette
│   │   │   └── app_theme.dart                       # Theme data (light/dark)
│   │   │
│   │   ├── usecase/
│   │   │   └── usecase.dart                         # Base UseCase class
│   │   │
│   │   └── utils/
│   │       └── logger.dart                          # Logging utility
│   │
│   ├── features/                                    # Feature modules
│   │   │
│   │   ├── news/                                    # 📰 Main news feature
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   ├── news_local_datasource.dart   # Local cache (SharedPreferences)
│   │   │   │   │   └── news_remote_datasource.dart  # API calls (Dio)
│   │   │   │   │
│   │   │   │   ├── models/
│   │   │   │   │   ├── article_model.dart           # Article data model
│   │   │   │   │   └── article_model.g.dart         # Generated JSON serialization
│   │   │   │   │
│   │   │   │   └── repositories/
│   │   │   │       └── news_repository_impl.dart    # Repository implementation
│   │   │   │
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── article.dart                 # Article entity (pure Dart)
│   │   │   │   │
│   │   │   │   ├── repositories/
│   │   │   │   │   └── news_repository.dart         # Repository interface
│   │   │   │   │
│   │   │   │   └── usecases/
│   │   │   │       ├── get_top_headlines.dart       # Get top headlines use case
│   │   │   │       └── search_news.dart             # Search news use case
│   │   │   │
│   │   │   └── presentation/
│   │   │       ├── bloc/
│   │   │       │   ├── news_bloc.dart               # BLoC logic
│   │   │       │   ├── news_event.dart              # BLoC events
│   │   │       │   └── news_state.dart              # BLoC states
│   │   │       │
│   │   │       ├── pages/
│   │   │       │   ├── news_home_page.dart          # Home screen
│   │   │       │   ├── news_detail_page.dart        # Article detail screen
│   │   │       │   └── search_page.dart             # Search screen
│   │   │       │
│   │   │       └── widgets/
│   │   │           ├── article_card.dart            # Article list item
│   │   │           ├── article_image.dart           # Cached image widget
│   │   │           └── category_chips.dart          # Category filter chips
│   │   │
│   │   ├── categories/                              # 📑 Categories feature
│   │   │   └── presentation/
│   │   │       └── pages/
│   │   │           └── category_page.dart           # Category filtered news
│   │   │
│   │   ├── bookmarks/                               # 🔖 Bookmarks feature
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   └── bookmark_local_datasource.dart
│   │   │   │   └── repositories/
│   │   │   │       └── bookmark_repository_impl.dart
│   │   │   │
│   │   │   ├── domain/
│   │   │   │   ├── repositories/
│   │   │   │   │   └── bookmark_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── get_bookmarks.dart
│   │   │   │       ├── add_bookmark.dart
│   │   │   │       ├── remove_bookmark.dart
│   │   │   │       └── is_bookmarked.dart
│   │   │   │
│   │   │   └── presentation/
│   │   │       ├── bloc/
│   │   │       │   ├── bookmark_bloc.dart
│   │   │       │   ├── bookmark_event.dart
│   │   │       │   └── bookmark_state.dart
│   │   │       └── pages/
│   │   │           └── bookmarks_page.dart
│   │   │
│   │   └── settings/                                # ⚙️ Settings feature
│   │       └── presentation/
│   │           └── pages/
│   │               └── settings_page.dart
│   │
│   └── shared/                                      # Shared components
│       └── cubit/
│           ├── app_cubit.dart                       # App-level state (theme, locale)
│           └── app_state.dart                       # App state model
│
├── test/                                            # Tests
│   └── widget_test.dart
│
├── docs/                                            # Reference code from other project
│   └── lib/                                         # (Not part of main app)
│
├── android/                                         # Android platform code
├── ios/                                             # iOS platform code
├── web/                                             # Web platform code
│
├── pubspec.yaml                                     # Dependencies & metadata
├── analysis_options.yaml                            # Lint rules
├── .gitignore                                       # Git ignore rules
│
├── README.md                                        # Main documentation
├── ARCHITECTURE.md                                  # Architecture documentation
├── SETUP_GUIDE.md                                   # Setup instructions
├── PROJECT_STRUCTURE.md                             # This file
└── setup.sh                                         # Setup script
\`\`\`

---

## 📦 File Count by Type

| Type | Count | Purpose |
|------|-------|---------|
| **Dart files** | ~50 | Application code |
| **Generated files** | ~2 | JSON serialization |
| **Config files** | 3 | pubspec, analysis_options, .gitignore |
| **Documentation** | 4 | README, ARCHITECTURE, SETUP_GUIDE, PROJECT_STRUCTURE |
| **Scripts** | 1 | setup.sh |
| **Platform code** | N/A | android/, ios/, web/ |

---

## 🏗 Architecture Layers Breakdown

### 1. Core Layer (7 files)
- **Constants:** App configurations
- **DI:** Dependency injection setup
- **Error:** Exception & failure handling
- **Network:** HTTP client & connectivity
- **Router:** App navigation
- **Theme:** UI theming
- **Utils:** Helper functions

### 2. Features Layer (30+ files)

#### News Feature (Main)
```
news/
├── data/ (3 files)
│   ├── datasources/ (2) - API & Cache
│   ├── models/ (2) - DTO + Generated
│   └── repositories/ (1) - Implementation
│
├── domain/ (4 files)
│   ├── entities/ (1) - Business model
│   ├── repositories/ (1) - Interface
│   └── usecases/ (2) - Business logic
│
└── presentation/ (9 files)
    ├── bloc/ (3) - State management
    ├── pages/ (3) - UI screens
    └── widgets/ (3) - Reusable components
```

#### Bookmarks Feature
```
bookmarks/
├── data/ (2 files)
├── domain/ (5 files)
└── presentation/ (4 files)
```

#### Categories Feature
```
categories/
└── presentation/ (1 file)
```

#### Settings Feature
```
settings/
└── presentation/ (1 file)
```

### 3. Shared Layer (2 files)
- App-level state management
- Shared across all features

---

## 🔄 Data Flow

### Example: Loading Top Headlines

```
1. UI (news_home_page.dart)
   │
   ├─→ Dispatch Event (LoadTopHeadlines)
   │
2. BLoC (news_bloc.dart)
   │
   ├─→ Call UseCase (get_top_headlines.dart)
   │
3. UseCase
   │
   ├─→ Call Repository Interface (news_repository.dart)
   │
4. Repository Implementation (news_repository_impl.dart)
   │
   ├─→ Check Network (network_info.dart)
   │
   ├─→ If Online:
   │   ├─→ Remote DataSource (news_remote_datasource.dart)
   │   ├─→ API Call (Dio)
   │   ├─→ Parse JSON → Model (article_model.dart)
   │   ├─→ Cache Data (news_local_datasource.dart)
   │   └─→ Convert Model → Entity
   │
   └─→ If Offline:
       ├─→ Local DataSource (news_local_datasource.dart)
       └─→ Get Cached Data
   │
5. Return Either<Failure, List<Article>>
   │
6. BLoC emits State (NewsLoaded)
   │
7. UI rebuilds with new data
```

---

## 🎯 Key Patterns Used

### 1. **Clean Architecture**
- Separation of concerns
- Dependency inversion
- Independent of frameworks

### 2. **Repository Pattern**
- Abstract data access
- Switch data sources easily
- Easy to test

### 3. **BLoC Pattern**
- Predictable state management
- Separation of business logic & UI
- Testable

### 4. **Dependency Injection**
- Loose coupling
- Easy to mock
- Better testability

### 5. **Either (Functional Programming)**
- Explicit error handling
- Type-safe
- No exceptions in business logic

---

## 📝 Naming Conventions

### Files
- **snake_case** for all files
- Suffix with type: `_bloc`, `_state`, `_event`, `_page`, etc.

### Classes
- **PascalCase**
- Descriptive names
- Example: `NewsBloc`, `ArticleCard`, `GetTopHeadlines`

### Variables/Functions
- **camelCase**
- Example: `getTopHeadlines()`, `articleList`

### Constants
- **camelCase** for regular
- **UPPER_SNAKE_CASE** for compile-time constants

---

## 🧪 Testing Structure

```
test/
├── unit/
│   ├── core/
│   ├── features/
│   │   ├── news/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   └── bookmarks/
│   └── shared/
│
├── widget/
│   └── features/
│
└── integration/
    └── app_test.dart
```

---

## 🚀 Build Outputs

### Android
```
android/app/build/outputs/
└── apk/
    └── release/
        └── app-release.apk
```

### iOS
```
ios/build/
└── Runner.app
```

### Web
```
build/web/
├── index.html
├── main.dart.js
└── assets/
```

---

## 📊 Lines of Code (Approximate)

| Component | LOC |
|-----------|-----|
| Core | ~500 |
| News Feature | ~1500 |
| Bookmarks Feature | ~500 |
| Other Features | ~300 |
| **Total** | **~2800** |

---

## 🔗 Dependencies Graph

```
Presentation Layer
    ↓ depends on
Domain Layer
    ↓ depends on
Data Layer
    ↓ depends on
Core Layer
```

**Rule:** Higher layers can depend on lower layers, but NOT vice versa.

---

## 📈 Scalability

### Adding New Feature

1. Create feature folder: `lib/features/new_feature/`
2. Add 3 layers: `data/`, `domain/`, `presentation/`
3. Register dependencies in `injection.dart`
4. Add routes in `app_router.dart`
5. Done! ✅

### Adding New UseCase

1. Create usecase file in `domain/usecases/`
2. Implement `UseCase` interface
3. Register in `injection.dart`
4. Use in BLoC
5. Done! ✅

---

**📍 Current Status:**
- ✅ Architecture: Complete
- ✅ Core Features: Implemented
- ✅ Documentation: Complete
- 🚧 Tests: To be added
- 🚧 CI/CD: To be setup

