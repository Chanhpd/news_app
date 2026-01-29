# Hướng Dẫn Setup API Key

## Lỗi Hiện Tại

Bạn đang gặp lỗi **401 Unauthorized** với message `Invalid API key`:

```
I/flutter: ⛔ Error: 401 https://newsapi.org/v2/top-headlines?apiKey=YOUR_NEWS_API_KEY_HERE&country=us&page=1&pageSize=20
I/flutter: ⛔ Invalid API key
```

## Nguyên Nhân

App đang sử dụng API key giả (placeholder) `YOUR_NEWS_API_KEY_HERE` thay vì API key thật từ NewsAPI.org

## Cách Khắc Phục

### Bước 1: Đăng ký API Key miễn phí

1. Truy cập: https://newsapi.org/register
2. Điền form đăng ký (email, tên, mật khẩu)
3. Xác nhận email
4. Copy API key từ dashboard

**Lưu ý:** API key miễn phí có giới hạn:
- 100 requests/day
- Chỉ được fetch tin tức trong 1 tháng gần đây
- Không dùng cho production

### Bước 2: Thêm API Key vào App

Mở file `lib/core/constants/app_constants.dart` và thay thế:

```dart
class AppConstants {
  // TODO: Replace with your actual News API key from https://newsapi.org/
  static const String newsApiKey = 'YOUR_NEWS_API_KEY_HERE';  // <-- THAY ĐỔI DÒNG NÀY
  
  // ... rest of code
}
```

Thành:

```dart
class AppConstants {
  // TODO: Replace with your actual News API key from https://newsapi.org/
  static const String newsApiKey = 'abc123xyz456...';  // <-- ĐIỀN API KEY CỦA BẠN
  
  // ... rest of code
}
```

### Bước 3: Restart App

```bash
flutter run
```

Hoặc nhấn `r` trong terminal để hot reload (nhưng restart hoàn toàn tốt hơn).

## Kiểm Tra Kết Quả

Sau khi thêm API key đúng, bạn sẽ thấy:

```
I/flutter: 🌐 API: Response: 200 https://newsapi.org/v2/top-headlines...
I/flutter: ✅ SUCCESS: News loaded successfully
```

Thay vì:

```
I/flutter: ⛔ Error: 401 https://newsapi.org/v2/top-headlines...
I/flutter: ⛔ Invalid API key
```

## Các Tính Năng Logging Mới

Logger đã được nâng cấp với nhiều methods hữu ích:

### Basic Logging
- `logger.v()` - Verbose (🤍)
- `logger.d()` - Debug (💙)
- `logger.i()` - Info (❤️)
- `logger.w()` - Warning (💛)
- `logger.e()` - Error (❤️‍🔥)

### Feature-Specific Logging
- `logger.api()` - API calls (🌐)
- `logger.repository()` - Repository operations (💾)
- `logger.useCase()` - Use case operations (⚡)
- `logger.cubit()` - State management (🎯)
- `logger.cache()` - Cache operations (💽)
- `logger.success()` - Success messages (✅)
- `logger.userAction()` - User interactions (👤)
- `logger.navigation()` - Navigation events (🧭)
- `logger.performance()` - Performance metrics (⏱️)

### Ví dụ Sử Dụng

```dart
// Basic
logger.d('Debug message');
logger.e('Error occurred');

// Feature-specific
logger.api('Fetching news from API');
logger.cache('Saving 20 articles to cache');
logger.success('Operation completed successfully');
logger.userAction('User tapped on article');

// Performance tracking
final stopwatch = Stopwatch()..start();
await fetchNews();
logger.performance('fetchNews', stopwatch.elapsed);
// Output: ⏱️ PERFORMANCE: fetchNews took 1234ms
```

## Troubleshooting

### Vẫn lỗi 401 sau khi thêm API key?

1. Kiểm tra API key có dấu cách thừa không
2. Đảm bảo API key được active (check email xác nhận)
3. Thử copy lại API key từ dashboard
4. Hot restart app thay vì hot reload

### Lỗi 429 Too Many Requests?

Bạn đã vượt quota 100 requests/day. Đợi 24h hoặc:
1. Tạo account mới
2. Upgrade lên paid plan

### Lỗi Network/Connection?

1. Kiểm tra internet connection
2. Kiểm tra firewall/proxy
3. Thử với VPN (một số quốc gia có thể block NewsAPI)

## Alternatives cho NewsAPI

Nếu không muốn dùng NewsAPI, có thể thay thế bằng:

1. **GNews API** - https://gnews.io (100 requests/day free)
2. **The Guardian API** - https://open-platform.theguardian.com
3. **NY Times API** - https://developer.nytimes.com
4. **Currents API** - https://currentsapi.services

Cần modify `NewsRemoteDataSource` để adapt với API khác.

## Liên Hệ

Nếu gặp vấn đề khác, check:
- NewsAPI Status: https://status.newsapi.org
- NewsAPI Documentation: https://newsapi.org/docs
