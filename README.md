# INEWS - Intelligent News Application

[![Flutter](https://img.shields.io/badge/Flutter-3.8+-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.8+-blue.svg)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

**INEWS** is a modern, feature-rich Flutter news application that provides users with an intelligent and personalized news reading experience. The app offers multiple ways to consume news content, including article browsing, AI-powered summaries, text-to-speech, social features, and comprehensive filtering options.

---

## 📱 Features

### Core Features
- **📰 News Feed**: Beautifully designed news article cards with images, titles, descriptions, and metadata
- **🔖 Bookmarks**: Save articles for later reading with persistent storage
- **❤️ Likes**: Like and track favorite articles
- **💬 Comments**: Add and view comments on news articles
- **📤 Share**: Share articles with friends via various sharing options
- **🔍 Search & Filter**: Search and filter news by categories and other criteria

### User Experience
- **🎨 Dark Mode**: Comfortable reading experience with full dark mode support
- **🌙 AI Summaries**: AI-powered article summaries for quick news consumption
- **🔊 Text-to-Speech**: Listen to news articles using TTS (Text-to-Speech) technology
- **⚡ Smooth Animations**: Shimmer loading effects and smooth page transitions
- **📱 Responsive Design**: Optimized for all screen sizes and devices

### App Settings
- **🔐 User Profile**: Manage user account information
- **🔔 Notifications**: Control notification preferences
- **🌓 Theme Settings**: Toggle between light and dark modes
- **💾 Persistent Storage**: Settings saved locally using GetStorage

---

## 📋 Project Structure

```
lib/
├── main.dart                    # App entry point
├── bindings/
│   └── news_binding.dart       # Dependency injection setup
├── controllers/
│   ├── auth_controller.dart    # Authentication logic
│   ├── filter_controller.dart  # Filtering and search logic
│   └── news_controller.dart    # News feed and TTS management
├── models/
│   ├── news_model.dart         # News article data model
│   └── user_model.dart         # User profile data model
├── routes/
│   ├── app_pages.dart          # Route configuration
│   └── app_routes.dart         # Route constants
├── themes/
│   └── app_theme.dart          # App theming and styling
├── utils/
│   └── watermark_util.dart     # Utility functions
├── views/
│   ├── home_view.dart          # Home/News feed screen
│   ├── detail_view.dart        # Article detail screen
│   ├── settings_view.dart      # Settings screen
│   └── login_view.dart         # Authentication screen
└── widgets/
    ├── custom_app_bar.dart     # Reusable app bar
    ├── filter_icon_button.dart # Filter button widget
    ├── news_card.dart          # News article card widget
    └── login_form.dart         # Login form widget
```

---

## 🎯 Screens & Navigation

### 1. **Login Screen** (`/login`)
**Purpose**: User authentication entry point

**Features**:
- Email and password login form
- Demo account credentials
- Input validation
- Remember me option
- Error handling and user feedback

**Demo Account**:
- **Email**: `demo@inews.com`
- **Password**: `Demo@123`

---

### 2. **Home Screen** (`/`)
**Purpose**: Main news feed display and article browsing

**Features**:
- Paginated news article cards
- Article filtering by category
- Search functionality
- Like articles
- Bookmark articles
- Comment on articles
- Share articles
- Read AI summaries
- Listen to articles (TTS)
- Pull-to-refresh functionality

**UI Components**:
- Custom app bar with branding
- Filter icon button in header
- News cards with:
  - Article image
  - Title
  - Description
  - Location
  - Time posted
  - Category badge
  - Action buttons (like, bookmark, comment, share)

---

### 3. **Article Detail Screen** (`/detail`)
**Purpose**: Display comprehensive article information

**Features**:
- Full article content
- Author and publication details
- Share button
- Back navigation
- AI-powered article summary
- Text-to-speech playback
- Related articles suggestion

**UI Components**:
- Large hero image
- Article header with metadata
- Summary section
- Full content area
- Action buttons

---

### 4. **Settings Screen** (`/settings`)
**Purpose**: App configuration and user preferences

**Features**:
- **Account Management**:
  - Edit user name
  - Edit user email
  - Logout functionality
  
- **App Preferences**:
  - Dark mode toggle
  - Notifications control
  - Sound/TTS preferences
  - Privacy settings

- **About Section**:
  - App version
  - Terms and Conditions
  - Privacy Policy
  - Contact/Support

**Persistent Storage**:
- All settings saved to local storage via GetStorage
- Auto-load on app restart

---

## 🔄 Application Workflow

### 1. **App Launch**
```
App Start
   ↓
Initialize Flutter & GetStorage
   ↓
Check Authentication Status
   ↓
Load User Preferences (Dark Mode, Settings)
   ↓
Route to Login Screen OR Home Screen
```

### 2. **Authentication Flow**
```
User Opens App
   ↓
Show Login Screen
   ↓
Enter Email & Password
   ↓
Validate Credentials
   ├─ Invalid → Show Error Message → Return to Login
   └─ Valid → Save User Session → Navigate to Home Screen
```

### 3. **News Feed Workflow**
```
Home Screen Loads
   ↓
Fetch News Articles from Controller
   ↓
Display Articles in Paginated Cards
   ↓
User Interactions:
   ├─ Like Article → Update UI & Save State
   ├─ Bookmark Article → Save to Local Storage
   ├─ Add Comment → Add to Comments List
   ├─ Share Article → Open Share Dialog
   ├─ Read Summary → Display AI Summary
   ├─ Play TTS → Listen to Article
   └─ Filter/Search → Filter News List
   ↓
Swipe to Next Page OR Tap Article
   ↓
Navigate to Detail View
```

### 4. **Detail View Workflow**
```
Article Card Tapped
   ↓
Navigate to Detail Screen
   ↓
Display Full Article Content
   ↓
User Can:
   ├─ View AI Summary
   ├─ Listen with TTS
   ├─ Share Article
   └─ Return to Home
```

### 5. **Settings & Preferences**
```
User Taps Settings
   ↓
Load Current Settings from GetStorage
   ↓
Display Settings Screen
   ↓
User Modifies:
   ├─ Dark Mode → Theme Updates App-wide
   ├─ Account Info → Edit Dialog Opens
   ├─ Notifications → Toggle & Save
   └─ Other Preferences → Save to Storage
   ↓
Changes Persist on App Restart
```

---

## 🛠️ Technologies & Dependencies

### Core Framework
- **Flutter**: 3.8.1+
- **Dart**: 3.8.1+

### State Management
- **GetX (4.7.2)**: Reactive state management and routing

### Storage & Preferences
- **get_storage (2.1.1)**: Lightweight local storage for user data and settings

### UI Components
- **cupertino_icons (1.0.8)**: iOS-style icons
- **smooth_page_indicator (1.2.1)**: Page indicator for paginated content
- **shimmer (3.0.0)**: Loading animation effects

### Features
- **flutter_tts (4.2.3)**: Text-to-speech functionality
- **share_plus (11.0.0)**: Share articles across platforms

### Development
- **flutter_lints (5.0.0)**: Dart linting and code quality

---

## 📝 Data Models

### NewsModel
```dart
NewsModel({
  required String title,           // Article title
  required String image,           // Article image URL
  required String description,     // Short description
  required String time,            // Time posted (relative)
  required String location,        // Article location
  required String summary,         // Brief summary
  String? category,               // News category (Tech, Sports, etc.)
  DateTime? dateTime,             // Publish date/time
  String? aiSummary,              // AI-generated summary
})
```

### UserModel
```dart
UserModel({
  required String email,          // User email
  required String name,           // User display name
  required String password,       // Encrypted password
  DateTime? lastLogin,            // Last login timestamp
})
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.8.1+)
- Dart SDK (3.8.1+)
- A code editor (VS Code, Android Studio, or IntelliJ IDEA)

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/inews.git
cd inews
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
flutter run
```

4. **Build for release**
```bash
# Android
flutter build apk

# iOS
flutter build ios

# Web
flutter build web
```

---

## 🔐 Authentication

### Demo Account Credentials
Use these credentials to test the app:
- **Email**: `demo@inews.com`
- **Password**: `Demo@123`

### Security Features
- ✅ Input validation
- ✅ Secure password handling
- ✅ Session management
- ✅ Local storage encryption

---

## 📚 Usage Examples

### Reading an Article
1. Open the app and log in with demo credentials
2. Browse the news feed
3. Tap on any article to view details
4. Use the "AI Summary" feature for a quick overview
5. Tap the speaker icon to listen to the article

### Saving Favorites
1. Like articles with the heart icon
2. Bookmark articles for later reading
3. Access bookmarks from the home feed

### Customizing App
1. Go to Settings
2. Toggle dark mode for comfortable reading
3. Manage notification preferences
4. Edit your profile information

### Sharing News
1. Find an interesting article
2. Tap the share button
3. Choose how you want to share (SMS, Email, Social Media, etc.)

---

## 🎨 Theming

The app includes a sophisticated theming system with:
- **Light Mode**: Clean, bright interface
- **Dark Mode**: Eye-friendly dark interface with reduced blue light
- **Custom Colors**: Deep purple accent color (#7C3AED)
- **Consistent Typography**: Material Design 3 typography scale

---

## 🔄 State Management with GetX

### Controllers
- **NewsController**: Manages news feed state, pagination, TTS
- **FilterController**: Handles search and filtering logic
- **AuthController**: Manages authentication state

### Bindings
- **NewsBinding**: Injects controllers and dependencies

---

## 📱 Platform Support

- ✅ **Android**: Tested on Android 10+
- ✅ **iOS**: Tested on iOS 13+
- ✅ **Web**: Responsive web interface
- ✅ **macOS**: Desktop support
- ✅ **Linux**: Desktop support
- ✅ **Windows**: Desktop support

---

## 🐛 Troubleshooting

### Issue: App crashes on startup
- **Solution**: Run `flutter clean && flutter pub get` and restart

### Issue: Dark mode not working
- **Solution**: Check GetStorage permissions and restart the app

### Issue: TTS not working
- **Solution**: Ensure text-to-speech engine is installed on your device

### Issue: Share button not working
- **Solution**: Verify app has permission to access system share functionality

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 👨‍💻 Developer Notes

### Code Style
- Follow Dart Style Guide
- Use meaningful variable names
- Add comments for complex logic
- Keep methods focused and single-responsibility

### Testing
- Test all authentication flows
- Verify dark mode functionality
- Test TTS on different devices
- Validate filtering and search

### Future Enhancements
- [ ] Backend API integration
- [ ] User authentication with JWT
- [ ] Real-time news updates
- [ ] Push notifications
- [ ] Offline reading capability
- [ ] User follow system
- [ ] Reading history
- [ ] Personalized recommendations
- [ ] Social feed integration
- [ ] Advanced analytics

---

## 📞 Support

For issues, feature requests, or questions:
- Create an issue on GitHub
- Contact: support@inews.com
- Documentation: https://inews-docs.example.com

---

**Made with ❤️ by the INEWS Team**
