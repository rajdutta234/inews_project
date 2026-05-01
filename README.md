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

#### Purpose
Secure user authentication and entry point to the application. Ensures that only authenticated users can access the news feed and personalized features.

#### Screen Layout
```
┌─────────────────────────────┐
│                             │
│   [INEWS Logo/Icon]         │  ← Gradient Header Section
│   INEWS (Title)             │
│   Intelligent News Reader   │
│                             │
├─────────────────────────────┤
│ Email Field (pre-filled)    │  ← Login Form
│ Password Field              │
│ [Checkbox] Remember me      │  ← Remember Option
│   [Forgot password?] ────→  │
│                             │
│ [Sign In Button]            │  ← Primary Action
├─────────────────────────────┤
│ Demo Account Info Box       │  ← Information Display
│ • Email: demo@inews.com     │
│ • Password: Demo@123        │
│                             │
│ Available Test Accounts:    │
│ ✓ demo@inews.com [Use]     │
│ ✓ user@inews.com [Use]     │
│ ✓ test@inews.com [Use]     │
├─────────────────────────────┤
│ Terms of Service Links      │  ← Footer
│ © 2025 INEWS               │
└─────────────────────────────┘
```

#### Features & Interactions

**Email Field**:
- Pre-filled with demo account email for testing
- Input validation for email format
- Disabled during authentication process
- Shows error message for invalid email format

**Password Field**:
- Toggle button to show/hide password
- Masked input for security
- Disabled during authentication process
- Accepts passwords with special characters

**Remember Me Checkbox**:
- Persists login preference
- Keeps user logged in across app sessions
- Unchecks on logout

**Error Handling**:
- Displays clear error messages above form
- Shows alerts for:
  - Empty email or password fields
  - Invalid email format
  - Incorrect credentials
  - Account not found

**Demo Account Information**:
- Blue info box displays current demo credentials
- Lists all available test accounts
- Quick-fill buttons for each test account
- Helps new users get started immediately

**Loading State**:
- Circular progress indicator during authentication
- Sign In button becomes disabled
- Input fields become read-only
- Loading time simulates network request (~1 second)

#### User Flow
```
1. User Opens App
   ↓
2. Login Screen Displays
   ├─ Auto-fill email: demo@inews.com
   └─ Show demo account credentials
   ↓
3. User Actions:
   ├─ Manual Email Entry
   │  └─ Type email → Validates format
   ├─ Password Entry
   │  └─ Type password → Can toggle visibility
   ├─ Quick Account Fill
   │  └─ Click [Use] → Email auto-fills
   └─ Remember Me
      └─ Check/uncheck → Preference saved
   ↓
4. Click Sign In Button
   ├─ Validate both fields not empty
   ├─ Validate email format
   └─ Check credentials against database
   ↓
5. Authentication Result:
   ├─ Invalid → Show error message → Stay on login
   └─ Valid → Save session → Navigate to Home Screen
```

#### Demo Accounts
Multiple demo accounts are provided for testing different scenarios:

| Email | Password | Name | Use Case |
|-------|----------|------|----------|
| demo@inews.com | Demo@123 | Demo User | Primary demo account |
| user@inews.com | User@123 | John Doe | Secondary test account |
| test@inews.com | Test@123 | Test User | QA testing account |

#### Storage & Persistence
- User session saved in GetStorage
- Auth token cached locally
- Login preference persisted via "Remember Me"
- Session expires on logout

---

### 2. **Home Screen** (`/`)

#### Purpose
Main hub for browsing news articles, discovering content, and interacting with the news feed. Primary interface for users to consume news content.

#### Screen Layout
```
┌─────────────────────────────────┐
│ ◀  INEWS    🔍  🎛️  ⚙️         │  ← Custom App Bar
├─────────────────────────────────┤
│ ┌─────────────────────────────┐ │
│ │   [Article Image]           │ │
│ │                             │ │
│ │ Flutter 3.0 Released        │ │  ← Article Card 1
│ │ Flutter 3.0 brings new...   │ │
│ │ 📍 Delhi | 2h ago | Tech    │ │
│ │ ❤️ 🔖 💬 📤                │ │
│ └─────────────────────────────┘ │
│                                 │
│ ┌─────────────────────────────┐ │
│ │   [Article Image]           │ │
│ │                             │ │
│ │ Dart 2.17 Announced         │ │  ← Article Card 2
│ │ Dart 2.17 focuses on...     │ │
│ │ 📍 Mumbai | 4h ago | Tech   │ │
│ │ ❤️ 🔖 💬 📤                │ │
│ └─────────────────────────────┘ │
│                 ◀ ● ▶            │  ← Page Indicator
└─────────────────────────────────┘
```

#### UI Components Breakdown

**App Bar**:
```
[Back] | [INEWS Logo] | [Search Icon] | [Filter Icon] | [Settings Icon]
```
- Back button: Returns from detail view
- INEWS branding: App logo and name
- Search icon: Opens search functionality
- Filter icon: Opens category filter
- Settings icon: Navigates to settings screen

**News Card Structure**:
```
┌────────────────────────────┐
│  📷 Article Image (16:9)   │  ← Hero Image
├────────────────────────────┤
│ 📌 [Tech] Category Badge   │
│                            │
│ Flutter 3.0 Released       │  ← Title (Bold, Large)
│                            │
│ Flutter 3.0 brings new     │  ← Description (Truncated)
│ features and improvements  │
│ for cross-platform dev.    │
│                            │
│ 📍 Delhi | ⏱️ 2h ago      │  ← Metadata
├────────────────────────────┤
│ ❤️ 234  🔖 45  💬 12  📤 │  ← Action Buttons
└────────────────────────────┘
```

**Card Elements**:
- **Image**: 16:9 aspect ratio article cover photo
- **Category Badge**: Colored label with category (Tech, Sports, Politics, Entertainment)
- **Title**: Bold, two-line maximum with truncation
- **Description**: Subtitle text, truncated to 2-3 lines
- **Metadata**: Location, publication time relative to now
- **Action Buttons**: Like, Bookmark, Comments, Share with counts

**Page Indicator**:
- Shows current page and total pages
- Interactive dots for quick navigation
- Updates automatically during swipe
- Visual feedback of page position

#### Features & Interactions

**Vertical Pagination**:
- Swipe up/down to navigate articles
- One article per screen view
- Smooth page transitions
- PageController manages page movement

**Like Button**:
- Heart icon toggles filled/outline
- Increments counter on like
- State persisted in memory
- Visual feedback with animation

**Bookmark Button**:
- Ribbon/flag icon toggles state
- Adds/removes from bookmarks
- Persisted to local storage
- Can be accessed later from library

**Comment Button**:
- Opens bottom sheet with comment interface
- Shows existing comments in list
- Input field to add new comment
- User can view and add multiple comments

**Share Button**:
- Opens native share dialog
- Shares article via:
  - SMS
  - Email
  - Social Media (WhatsApp, Facebook, etc.)
  - Messaging apps
  - Copy to clipboard

**Filter/Category Filtering**:
- Filter icon opens bottom sheet
- Select categories to filter
- Apply button updates feed
- Shows filtered articles only

**Search Functionality**:
- Search icon opens search field
- Type to search article titles/descriptions
- Real-time filtering as user types
- Clear button to reset search

#### Data Flow
```
Home Screen Loads
   ↓
NewsController Loads Articles
   ↓
Display Articles in PageView
   ↓
User Interactions:
   ├─ Like Article
   │  └─ Toggle like state → Save in memory → Update UI
   ├─ Bookmark Article
   │  └─ Save to GetStorage → Add to bookmarks → Update UI
   ├─ Add Comment
   │  └─ Bottom sheet opens → User types → Save to comments map
   ├─ Share Article
   │  └─ Share dialog opens → User selects platform → Share via intent
   ├─ Filter Articles
   │  └─ Select category → Filter list → Display filtered articles
   └─ Search Articles
      └─ Type keywords → Filter matching → Display results
   ↓
Tap Article Card
   ├─ Get article data
   └─ Navigate to Detail Screen with article data
```

#### State Management
```
ArticleState:
├─ newsList: List<NewsModel>           // All articles
├─ searchResults: List<NewsModel>      // Search results
├─ liked: Set<int>                     // Article IDs liked
├─ bookmarked: Set<int>                // Article IDs bookmarked
├─ comments: Map<int, List<String>>    // Comments per article
├─ currentPage: int                    // Current page index
└─ showSummary: bool                   // AI summary visibility
```

#### User Journey
```
Home Screen → Browse Articles
    ↓
    ├─→ Like/Unlike Article → State updates → Counter changes
    │
    ├─→ Add Bookmark → Saved to storage → Icon fills
    │
    ├─→ Comment → Bottom sheet → Type → Save → Display
    │
    ├─→ Share → Share dialog → Choose platform → Send
    │
    ├─→ Read Summary → Display AI summary text
    │
    ├─→ Filter → Select category → List updates
    │
    ├─→ Search → Type keywords → Filter results
    │
    └─→ Tap Article → Navigate to Detail Screen
```

---

### 3. **Article Detail Screen** (`/detail`)

#### Purpose
Display comprehensive article information and rich media content. Provides focused reading experience with additional features like summaries and TTS.

#### Screen Layout
```
┌──────────────────────────────┐
│ ◀                    🔊  📤 │  ← Header with Actions
├──────────────────────────────┤
│                              │
│   [Large Article Image]      │  ← Hero Image
│                              │
├──────────────────────────────┤
│ Flutter 3.0 Released         │  ← Article Title
│ 📍 Delhi | ⏱️ 2h ago        │  ← Metadata
│                              │
│ Flutter 3.0 is out now with  │  ← Article Description
│ exciting new features for    │
│ developers.                  │
│                              │
├──────────────────────────────┤
│ 🤖 AI SUMMARY               │  ← Summary Section
│ Flutter 3.0 is released with │
│ major cross-platform         │
│ improvements. Developers can │
│ now build faster...          │
├──────────────────────────────┤
│ 📖 FULL CONTENT             │  ← Content Section
│ Flutter 3.0 brings new       │
│ features and improvements    │
│ for cross-platform dev...    │
│                              │
│ [Scrollable content area]    │
└──────────────────────────────┘
```

#### UI Components

**Header Bar**:
- Back arrow button (left)
- Text-to-Speech button (speaker icon)
- Share button (right)
- Translucent background for visual hierarchy

**Article Header**:
```
[Large Cover Image]
    ↓
Article Title (Bold, Large)
    ↓
Metadata Row:
├─ 📍 Location
├─ ⏱️ Time Posted
├─ 📌 Category Badge
└─ 👤 Author (if available)
    ↓
Description/Subtitle Text
```

**Summary Section**:
- Expandable card style
- AI-generated summary label
- Concise 3-4 line summary
- Can toggle expanded/collapsed view
- Distinct background color

**Content Section**:
- Full article body text
- Scrollable container
- Formatted text with proper spacing
- Images embedded in content (if available)
- Pull-to-refresh to reload

#### Features & Interactions

**Text-to-Speech (TTS)**:
- Speaker icon in header
- Taps icon → Starts reading article
- Icon changes to show active state
- User can pause/resume playback
- Speed adjustable (can be added)
- Works with device TTS engine

**Share Article**:
- Share button opens native share dialog
- Share article title and description
- Include article link (if available)
- Choose from available apps on device

**AI Summary**:
- Displays concise article summary
- Generated from full content
- Helps quick reading
- Toggle to expand/collapse
- Different styling from main content

**Back Navigation**:
- Back arrow returns to Home Screen
- Maintains scroll position in home feed
- Preserves article selection state

#### Data Flow
```
Article Detail Screen Loads
   ↓
Receive Article Data via Get.arguments
   ↓
Display Article Content
   ↓
User Interactions:
   ├─ Play TTS
   │  └─ Get article text → Start TTS engine → Audio output
   ├─ Share Article
   │  └─ Open share dialog → Select app → Send
   ├─ View Summary
   │  └─ Display/hide AI summary → Update UI
   └─ Back Button
      └─ Return to Home Screen → Restore scroll state
```

#### State Management
```
Detail Screen State:
├─ article: NewsModel?           // Current article
├─ isPlaying: bool               // TTS playing state
├─ isSummaryExpanded: bool       // Summary expanded state
└─ scrollPosition: double        // Scroll offset
```

#### User Flow
```
Article Card Tapped on Home Screen
   ↓
Article Data Passed to Detail Screen
   ↓
Detail Screen Renders
   ├─ Load article image
   ├─ Display title & metadata
   ├─ Show description
   ├─ Display AI summary
   └─ Display full content
   ↓
User Actions:
   ├─→ Read Article
   │   └─ Scroll through content
   │
   ├─→ Listen to Article
   │   └─ Click speaker → TTS starts
   │
   ├─→ Expand Summary
   │   └─ Click summary → Expand view
   │
   ├─→ Share Article
   │   └─ Click share → Choose platform → Send
   │
   └─→ Back to Feed
       └─ Click back arrow → Return to Home Screen
```

---

### 4. **Settings Screen** (`/settings`)

#### Purpose
Manage user account, preferences, and app configuration. Central hub for customization and user profile management.

#### Screen Layout
```
┌──────────────────────────────┐
│ ◀  SETTINGS       ⚙️        │  ← Header
├──────────────────────────────┤
│ ACCOUNT                      │  ← Section Title
│                              │
│ [Gradient Avatar]  Demo User │  ← User Info Card
│ demo@inews.com     [Edit]   │
│ Member since: Today          │
├──────────────────────────────┤
│ PREFERENCES                  │  ← Section Title
│                              │
│ 🌙 Dark Mode          [OFF]  │  ← Toggle
│ Use dark theme for...        │
│                              │
│ 🔔 Notifications      [ON]   │  ← Toggle
│ Receive app notif...         │
├──────────────────────────────┤
│ ABOUT                        │  ← Section Title
│                              │
│ ℹ️  App Version    1.0.0    │
│ 📄 Terms of Service →       │
│ 🔒 Privacy Policy  →        │
├──────────────────────────────┤
│ [🚪 Logout]                  │  ← Logout Button
│                              │
│ © 2025 INEWS                 │
└──────────────────────────────┘
```

#### UI Components

**Account Section**:
```
┌─ [Gradient Avatar] ─────────┐
│ User Name (Bold)             │
│ user@email.com               │
│ Member since: [Date]         │
│                [Edit Button] │
└──────────────────────────────┘
```

**Avatar**:
- Gradient background with user initial
- Different colors for different users
- Display initials in white bold text
- Circular shape with rounded corners

**User Info**:
- Display name (editable)
- Email address (editable)
- Member since date (read-only)
- Formatted date or "Today"

**Preferences Section**:
- Material Design Switch Tiles
- Icon, label, subtitle per preference
- Toggle on/off
- Settings persist to storage

**About Section**:
- Information list items
- App version display
- Links to legal documents
- Opens in browser when tapped

**Logout Button**:
- Large red button with logout icon
- Text: "Logout"
- Spans full width
- Opens confirmation dialog

#### Features & Interactions

**Edit Account**:
1. User clicks [Edit] button
2. Dialog opens with:
   - Name text field (current value pre-filled)
   - Email text field (current value pre-filled)
3. User modifies information
4. Click [Save] → Validates input → Updates profile → Shows success message
5. Click [Cancel] → Closes dialog without changes

**Edit Account Validation**:
- Name not empty
- Email valid format
- Email unique (can add later)
- Success/error feedback shown

**Dark Mode Toggle**:
- Switch tile for dark mode
- Toggle on → Theme changes app-wide
- Settings saved to GetStorage
- Persists on app restart
- Real-time theme switch

**Notifications Toggle**:
- Switch tile for notifications
- Toggle on/off → Preference saved
- Can be expanded with notification settings:
  - News notifications
  - Comment notifications
  - etc.

**Logout**:
1. User clicks Logout button
2. Confirmation dialog appears:
   - "Are you sure you want to logout?"
   - [Cancel] [Logout] buttons
3. If confirmed:
   - Clear session data
   - Clear user cache
   - Navigate to Login Screen
   - Reset app state

#### Data Flow
```
Settings Screen Loads
   ↓
Load User Data from AuthController
   ↓
Load Preferences from GetStorage
   ↓
Display All Information
   ↓
User Interactions:
   ├─ Edit Account
   │  ├─ Click [Edit]
   │  ├─ Dialog opens with current data
   │  ├─ User modifies
   │  └─ Save → Validate → Update → Show success
   │
   ├─ Toggle Dark Mode
   │  ├─ Click switch
   │  ├─ Check box value
   │  ├─ Call Get.changeTheme()
   │  └─ Save preference to storage
   │
   ├─ Toggle Notifications
   │  ├─ Click switch
   │  └─ Save preference to storage
   │
   └─ Logout
      ├─ Click Logout button
      ├─ Show confirmation dialog
      ├─ If confirmed:
      │  ├─ Clear session
      │  ├─ Clear storage auth data
      │  └─ Navigate to Login Screen
      └─ If cancelled: Stay on Settings
```

#### State Management
```
Settings Screen State:
├─ isDarkMode: bool              // Dark mode preference
├─ notificationsEnabled: bool    // Notifications preference
├─ currentUser: UserModel?       // Logged in user
├─ isLoading: bool               // Loading state
└─ errorMessage: String          // Error feedback
```

#### User Flow
```
Home Screen → Click Settings (⚙️)
   ↓
Settings Screen Loads
   ├─ Display user profile
   └─ Show current preferences
   ↓
User Actions:
   ├─→ Edit Profile
   │   ├─ Click [Edit]
   │   ├─ Dialog opens
   │   ├─ Modify name/email
   │   └─ Save changes
   │
   ├─→ Toggle Dark Mode
   │   └─ Switch on/off → Theme updates instantly
   │
   ├─→ Manage Notifications
   │   └─ Toggle switch → Preference saved
   │
   ├─→ View Legal Documents
   │   ├─ Click Terms/Privacy
   │   └─ Opens in browser
   │
   └─→ Logout
       ├─ Click Logout
       ├─ Confirm action
       └─ Return to Login Screen
```

#### Additional Settings (Expandable)

Future settings that can be added:
- **Sound Preferences**: TTS speed, voice selection
- **Language**: App language and content language
- **Privacy**: Data sharing, analytics opt-out
- **Cache Management**: Clear cache, offline content
- **Notification Settings**: Per-category notifications, quiet hours
- **Reading Preferences**: Font size, line spacing, reading mode

---

## 🔄 Complete Application Workflow

### 1. **App Initialization & Splash Flow**

```
┌─────────────────────────────────────────────────────────────┐
│                    APP START                                │
└─────────────────────────────────────────────────────────────┘
                             ↓
        ┌───────────────────────────────────────┐
        │  Initialize Flutter & WidgetsBinding  │
        └───────────────────────────────────────┘
                             ↓
        ┌───────────────────────────────────────┐
        │  Initialize GetStorage (Local DB)     │
        └───────────────────────────────────────┘
                             ↓
        ┌───────────────────────────────────────┐
        │  Load Theme Preference from Storage   │
        │  isDarkMode: true/false               │
        └───────────────────────────────────────┘
                             ↓
        ┌───────────────────────────────────────┐
        │  Check Authentication Status          │
        └───────────────────────────────────────┘
                    ↙                    ↘
           [User Logged In]       [No Active Session]
                    ↓                         ↓
        ┌─────────────────────┐  ┌──────────────────────┐
        │  Show Splash Screen │  │   Show Login Screen  │
        │  Load All Data      │  │   (Empty forms)      │
        └─────────────────────┘  └──────────────────────┘
                    ↓                         ↓
        ┌─────────────────────┐  ┌──────────────────────┐
        │  Navigate to Home   │  │ User Enters Login    │
        │  All Controllers    │  │ Credentials          │
        │  & Data Ready       │  └──────────────────────┘
        └─────────────────────┘           ↓
                                 [Continue to Login Flow]
```

#### Initialization Details
- **GetStorage Initialization**: Loads all persisted data synchronously
- **Theme Loading**: Reads isDarkMode preference and applies theme
- **Auth Check**: Verifies if user session token exists and is valid
- **Controller Setup**: Initializes all GetX controllers via bindings
- **Splash Duration**: ~2-3 seconds for visual branding

---

### 2. **Authentication Flow (Complete)**

```
┌──────────────────────────────────────────────────────────────┐
│                    LOGIN SCREEN                              │
└──────────────────────────────────────────────────────────────┘
                             ↓
        ┌────────────────────────────────────────┐
        │ Display Login Form                     │
        │ • Email field (pre-filled)             │
        │ • Password field (masked)              │
        │ • Demo account info box                │
        │ • Remember me checkbox                 │
        └────────────────────────────────────────┘
                             ↓
        ┌────────────────────────────────────────┐
        │  USER ENTERS CREDENTIALS               │
        └────────────────────────────────────────┘
                             ↓
        ┌────────────────────────────────────────┐
        │  User Clicks "Sign In" Button          │
        │  • Set isLoading = true                │
        │  • Disable form inputs                 │
        │  • Show progress indicator             │
        └────────────────────────────────────────┘
                             ↓
        ┌────────────────────────────────────────┐
        │  VALIDATION LAYER                      │
        └────────────────────────────────────────┘
                    ↙          ↓          ↘
           [Empty?]      [Valid Email?]   [Length Check]
              ↓              ↓                 ↓
         [Show Error]  [Check Format]    [Min 6 chars]
                             ↓
        ┌────────────────────────────────────────┐
        │  All Validations Passed                │
        └────────────────────────────────────────┘
                             ↓
        ┌────────────────────────────────────────┐
        │  Simulate Network Request (~1 second)  │
        │  • Check credentials against DB        │
        │  • Verify account exists               │
        │  • Verify password matches             │
        └────────────────────────────────────────┘
                    ↙                    ↘
        [Credentials Valid]      [Credentials Invalid]
                ↓                         ↓
        ┌──────────────────┐  ┌──────────────────────┐
        │ Create UserModel │  │ Show Error Message   │
        │ with:            │  │ • "Invalid email or  │
        │ - ID             │  │   password"          │
        │ - Email          │  │ • Clear password     │
        │ - Name           │  │ • Set isLoading=false│
        │ - CreatedAt      │  │ • Re-enable inputs   │
        │ - LastLogin      │  └──────────────────────┘
        └──────────────────┘           ↓
                ↓              [Return to Login Screen]
        ┌──────────────────────────────┐
        │ Save to GetStorage:          │
        │ • User JSON                  │
        │ • Auth token                 │
        │ • is_logged_in = true        │
        │ • Remember me preference     │
        └──────────────────────────────┘
                ↓
        ┌──────────────────────────────┐
        │ Update AuthController:       │
        │ • currentUser = user         │
        │ • isLoggedIn = true          │
        │ • errorMessage = ""          │
        └──────────────────────────────┘
                ↓
        ┌──────────────────────────────┐
        │ Show Success Snackbar        │
        │ "Welcome [User Name]!"       │
        └──────────────────────────────┘
                ↓
        ┌──────────────────────────────┐
        │ Navigate to Home Screen      │
        │ • Initialize NewsController  │
        │ • Load news articles         │
        │ • Setup page controller      │
        └──────────────────────────────┘
```

#### Validation Checks
1. **Email Validation**
   - Not empty
   - Valid email format (regex pattern)
   - Registered in system

2. **Password Validation**
   - Not empty
   - Minimum 6 characters
   - Matches stored password

3. **Account Validation**
   - Account exists
   - Account active
   - No login attempts exceeded

#### Error Messages
```
Scenario                  →    Error Message
─────────────────────────────────────────────
Empty email/password      →    "Email and password are required"
Invalid email format      →    "Please enter a valid email address"
Account not found         →    "Account not found. Use demo account to test."
Wrong password            →    "Invalid email or password"
Server error              →    "An error occurred: [error details]"
```

---

### 3. **Home Screen Navigation & Content Flow**

```
┌────────────────────────────────────────────────────────────┐
│                 HOME SCREEN LOADED                         │
└────────────────────────────────────────────────────────────┘
                             ↓
        ┌──────────────────────────────────┐
        │ Initialize Controllers:          │
        │ • NewsController                 │
        │ • FilterController               │
        │ • PageController                 │
        └──────────────────────────────────┘
                             ↓
        ┌──────────────────────────────────┐
        │ Load Articles from NewsController│
        │ articles.length = 5              │
        └──────────────────────────────────┘
                             ↓
        ┌──────────────────────────────────┐
        │ Build PageView with articles     │
        │ Current page = 0                 │
        └──────────────────────────────────┘
                             ↓
        ┌────────────────────────────────────────────┐
        │            USER ACTIONS                    │
        └────────────────────────────────────────────┘
                             ↓
        ┌─────────────────────────────────────────────────────┐
        │  SWIPE UP/DOWN TO NAVIGATE ARTICLES                 │
        └─────────────────────────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ PageView Detects Swipe Direction  │
            │ • Velocity calculation            │
            │ • Page animation                  │
            │ • Page index update               │
            └───────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ onPageChanged Callback            │
            │ • Update currentPage              │
            │ • Trigger TTS (if enabled)        │
            │ • Update page indicator           │
            └───────────────────────────────────┘

        ┌─────────────────────────────────────────────────────┐
        │  LIKE BUTTON INTERACTION                            │
        └─────────────────────────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ User Taps Heart Icon              │
            └───────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ Check if already liked:           │
            │ if (liked.contains(index)) {      │
            │   liked.remove(index)  // Unlike  │
            │ } else {                          │
            │   liked.add(index)     // Like    │
            │ }                                 │
            └───────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ UI Updates:                       │
            │ • Heart becomes filled/outline    │
            │ • Counter increments/decrements   │
            │ • Animation plays                 │
            └───────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ State persisted in memory         │
            │ (Persists during session)         │
            └───────────────────────────────────┘

        ┌─────────────────────────────────────────────────────┐
        │  BOOKMARK BUTTON INTERACTION                        │
        └─────────────────────────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ User Taps Bookmark Icon           │
            └───────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ Toggle bookmark state:            │
            │ if (bookmarked.contains(idx)) {   │
            │   bookmarked.remove(idx)          │
            │ } else {                          │
            │   bookmarked.add(idx)             │
            │ }                                 │
            └───────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ Save to GetStorage:               │
            │ box.write('bookmarks', list)      │
            └───────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ UI Updates:                       │
            │ • Icon state changes              │
            │ • Toast shows "Added to bookmarks"│
            └───────────────────────────────────┘

        ┌─────────────────────────────────────────────────────┐
        │  COMMENT BUTTON INTERACTION                         │
        └─────────────────────────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ User Taps Comment Icon            │
            └───────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ Open Bottom Sheet with:           │
            │ • Existing comments list          │
            │ • Text input field                │
            │ • Send button                     │
            └───────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ User Types Comment                │
            │ • Auto-save to TextField          │
            └───────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ User Taps Send/Send Button        │
            │ • Validate not empty              │
            │ • Add to comments map             │
            │ • Clear text field                │
            │ • Update list display             │
            └───────────────────────────────────┘

        ┌─────────────────────────────────────────────────────┐
        │  SHARE BUTTON INTERACTION                           │
        └─────────────────────────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ User Taps Share Icon              │
            └───────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ Native Share Dialog Opens:        │
            │ • Available apps listed           │
            │ • Recent shares highlighted       │
            └───────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ Article Data Prepared:            │
            │ "Title: Article Name              │
            │  Description: ..."                │
            └───────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ User Selects Platform/App         │
            └───────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ Share Intent Sent                 │
            │ • OS handles actual sharing       │
            │ • Dialog closes                   │
            │ • Success feedback shown          │
            └───────────────────────────────────┘

        ┌─────────────────────────────────────────────────────┐
        │  FILTER/SEARCH INTERACTION                          │
        └─────────────────────────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ User Taps Filter Icon             │
            └───────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ Filter Bottom Sheet Opens         │
            │ • Category checkboxes             │
            │ • Apply button                    │
            └───────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ User Selects Categories          │
            │ • Tech, Sports, Politics, etc.    │
            └───────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ User Taps Apply                   │
            │ • FilterController updates        │
            │ • filteredNews list updated       │
            │ • PageView rebuilds               │
            │ • Reset to page 0                 │
            └───────────────────────────────────┘

        ┌─────────────────────────────────────────────────────┐
        │  TAP ARTICLE TO VIEW DETAILS                        │
        └─────────────────────────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ User Taps on Article Card         │
            │ • Long press detected             │
            │ • Article index captured          │
            └───────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ Get Article Data:                 │
            │ news = newsList[currentIndex]     │
            └───────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ Navigate to Detail Screen:        │
            │ Get.toNamed(                      │
            │   AppRoutes.detail,               │
            │   arguments: news                 │
            │ )                                 │
            └───────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ Detail Screen Receives Data       │
            │ Renders article content           │
            └───────────────────────────────────┘
```

---

### 4. **Detail Screen TTS & Interaction Flow**

```
┌───────────────────────────────────────────────────────────┐
│            ARTICLE DETAIL SCREEN LOADED                   │
└───────────────────────────────────────────────────────────┘
                             ↓
        ┌──────────────────────────────────┐
        │ Display Article:                 │
        │ • Load image                     │
        │ • Show title                     │
        │ • Display metadata               │
        │ • Show summary                   │
        │ • Render full content            │
        └──────────────────────────────────┘
                             ↓
        ┌────────────────────────────────────────┐
        │     USER INTERACTS WITH TTS            │
        └────────────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ User Taps Speaker Icon            │
            │ • isMuted = false                 │
            │ • isPlaying = true                │
            └───────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ Get Article Text:                 │
            │ text = article.title +            │
            │        article.description +      │
            │        article.content            │
            └───────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ Initialize FlutterTts:            │
            │ • Set language to "en-US"         │
            │ • Set speech rate (0.8-1.2)       │
            │ • Set pitch (1.0)                 │
            └───────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ Start TTS Engine:                 │
            │ flutterTts.speak(text)            │
            │ • Audio output starts             │
            │ • Speaker icon highlights         │
            │ • Status text shows "Playing..."  │
            └───────────────────────────────────┘
                             ↓
        ┌────────────────────────────────────────┐
        │  DURING TTS PLAYBACK                   │
        └────────────────────────────────────────┘
                             ↓
            ┌─────────────────────────────────────┐
            │ Update UI in Real-time:             │
            │ • Progress indicator animates       │
            │ • Time elapsed displays             │
            │ • Can scroll content while playing  │
            └─────────────────────────────────────┘
                             ↓
        ┌────────────────────────────────────────┐
        │  PAUSE/STOP TTS                        │
        └────────────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ User Taps Speaker Again           │
            │ • isMuted = true                  │
            │ • Call flutterTts.stop()          │
            └───────────────────────────────────┘
                             ↓
            ┌───────────────────────────────────┐
            │ TTS Stops:                        │
            │ • Audio output stops              │
            │ • Speaker icon un-highlights      │
            │ • State returns to idle           │
            └───────────────────────────────────┘
```

---

### 5. **Settings & Preference Changes Flow**

```
┌───────────────────────────────────────────────────────────┐
│              SETTINGS SCREEN OPENED                       │
└───────────────────────────────────────────────────────────┘
                             ↓
        ┌──────────────────────────────────┐
        │ Load Settings from Storage:      │
        │ • isDarkMode from box            │
        │ • notifications from box         │
        │ • User data from AuthController  │
        └──────────────────────────────────┘
                             ↓
        ┌──────────────────────────────────┐
        │ Display All Settings             │
        └──────────────────────────────────┘
                             ↓
        ┌─────────────────────────────────────────────┐
        │       EDIT ACCOUNT INTERACTION              │
        └─────────────────────────────────────────────┘
                             ↓
            ┌─────────────────────────────────┐
            │ User Taps [Edit]                │
            └─────────────────────────────────┘
                             ↓
            ┌─────────────────────────────────────────┐
            │ Edit Dialog Opens:                      │
            │ • TextFields pre-filled with current    │
            │ • Name field focuses                    │
            │ • Password field available (optional)   │
            └─────────────────────────────────────────┘
                             ↓
            ┌─────────────────────────────────┐
            │ User Modifies Information       │
            │ • Name field value changes      │
            │ • Email field value changes     │
            └─────────────────────────────────┘
                             ↓
            ┌──────────────────────────────┐
            │ User Taps Save or Cancel     │
            └──────────────────────────────┘
                ↙                        ↘
            [Cancel]                  [Save]
                ↓                         ↓
        ┌─────────────┐    ┌──────────────────────┐
        │ Dialog Close│    │ Validate Input:      │
        │ No Changes  │    │ • Name not empty     │
        └─────────────┘    │ • Email valid format │
                           │ • Email not duplicate│
                           └──────────────────────┘
                                    ↓
                           [Validation Passed]
                                    ↓
                    ┌──────────────────────────┐
                    │ Call AuthController:     │
                    │ updateProfile(           │
                    │   name: newName,         │
                    │   email: newEmail        │
                    │ )                        │
                    └──────────────────────────┘
                                    ↓
                    ┌──────────────────────────┐
                    │ Update UserModel:        │
                    │ currentUser = user.copy..│
                    │ with(...)                │
                    └──────────────────────────┘
                                    ↓
                    ┌──────────────────────────┐
                    │ Save to GetStorage:      │
                    │ box.write(               │
                    │   'auth_user',           │
                    │   user.toJson()          │
                    │ )                        │
                    └──────────────────────────┘
                                    ↓
                    ┌──────────────────────────┐
                    │ Show Success Snackbar:   │
                    │ "Profile updated"        │
                    └──────────────────────────┘
                                    ↓
                    ┌──────────────────────────┐
                    │ Dialog Closes            │
                    │ Settings Screen Updates  │
                    └──────────────────────────┘

        ┌─────────────────────────────────────────────┐
        │       DARK MODE TOGGLE INTERACTION          │
        └─────────────────────────────────────────────┘
                             ↓
            ┌─────────────────────────────────┐
            │ User Taps Switch                │
            └─────────────────────────────────┘
                             ↓
            ┌──────────────────────────────────┐
            │ Toggle isDarkMode value:         │
            │ isDarkMode = !isDarkMode         │
            └──────────────────────────────────┘
                             ↓
            ┌──────────────────────────────────┐
            │ Call GetX Theme Change:          │
            │ Get.changeTheme(                 │
            │   isDarkMode ?                   │
            │   ThemeData.dark() :             │
            │   ThemeData.light()              │
            │ )                                │
            └──────────────────────────────────┘
                             ↓
            ┌──────────────────────────────────┐
            │ Real-time UI Update:             │
            │ • App-wide theme changes         │
            │ • Colors invert                  │
            │ • Text colors adjust             │
            │ • Status bar updates             │
            └──────────────────────────────────┘
                             ↓
            ┌──────────────────────────────────┐
            │ Save Preference:                 │
            │ box.write('isDarkMode', value)   │
            └──────────────────────────────────┘
                             ↓
            ┌──────────────────────────────────┐
            │ Persists on App Restart          │
            └──────────────────────────────────┘

        ┌─────────────────────────────────────────────┐
        │       LOGOUT INTERACTION                    │
        └─────────────────────────────────────────────┘
                             ↓
            ┌─────────────────────────────────┐
            │ User Taps Logout Button         │
            └─────────────────────────────────┘
                             ↓
            ┌──────────────────────────────────┐
            │ Confirmation Dialog Opens:       │
            │ "Are you sure you want to logout?│
            │ [Cancel] [Logout]                │
            └──────────────────────────────────┘
                ↙                        ↘
            [Cancel]                  [Confirm]
                ↓                         ↓
        ┌─────────────┐    ┌──────────────────────┐
        │ Dialog Close│    │ Set isLoading = true │
        │ Stay on     │    │ Disable buttons      │
        │ Settings    │    │ Show loading spinner │
        └─────────────┘    └──────────────────────┘
                                    ↓
                    ┌──────────────────────────┐
                    │ Call AuthController:     │
                    │ logout()                 │
                    └──────────────────────────┘
                                    ↓
                    ┌──────────────────────────┐
                    │ Clear Session Data:      │
                    │ • currentUser = null     │
                    │ • isLoggedIn = false     │
                    │ • errorMessage = ""      │
                    └──────────────────────────┘
                                    ↓
                    ┌──────────────────────────┐
                    │ Clear Storage:           │
                    │ • Remove auth_user       │
                    │ • Remove is_logged_in    │
                    │ • Remove session token   │
                    └──────────────────────────┘
                                    ↓
                    ┌──────────────────────────┐
                    │ Show Success Message:    │
                    │ "Logged out successfully"│
                    └──────────────────────────┘
                                    ↓
                    ┌──────────────────────────┐
                    │ Navigate to Login:       │
                    │ Get.offAllNamed(         │
                    │   AppRoutes.login        │
                    │ )                        │
                    └──────────────────────────┘
                                    ↓
                    ┌──────────────────────────┐
                    │ Login Screen Appears     │
                    │ • Forms cleared          │
                    │ • Demo creds displayed   │
                    │ • Ready for new login    │
                    └──────────────────────────┘
```

---

## 🔀 State Management Architecture

### GetX Controllers & State Diagram

```
┌──────────────────────────────────────────┐
│        AuthController State              │
├──────────────────────────────────────────┤
│ currentUser: Rx<UserModel?>              │ ← Reactive user data
│ isLoggedIn: RxBool                       │ ← Authentication status
│ isLoading: RxBool                        │ ← Async operation status
│ errorMessage: RxString                   │ ← Error feedback
├──────────────────────────────────────────┤
│ Methods:                                 │
│ • login(email, password)                 │
│ • logout()                               │
│ • updateProfile(name, email)             │
│ • _loadStoredUser()                      │
└──────────────────────────────────────────┘

┌──────────────────────────────────────────┐
│        NewsController State              │
├──────────────────────────────────────────┤
│ newsList: List<NewsModel>                │ ← All articles
│ searchResults: List<NewsModel>           │ ← Search results
│ liked: Set<int>                          │ ← Liked article IDs
│ bookmarked: Set<int>                     │ ← Bookmarked IDs
│ comments: Map<int, List<String>>         │ ← Comments per article
│ currentPage: RxInt                       │ ← Current page index
│ isMuted: RxBool                          │ ← TTS mute status
│ showSummary: RxBool                      │ ← Summary visibility
├──────────────────────────────────────────┤
│ Methods:                                 │
│ • onPageChanged(index)                   │
│ • toggleMute()                           │
│ • searchNews(query)                      │
│ • _handleTTS()                           │
└──────────────────────────────────────────┘

┌──────────────────────────────────────────┐
│        FilterController State            │
├──────────────────────────────────────────┤
│ selectedCategories: Set<String>          │ ← Selected filters
│ searchQuery: RxString                    │ ← Search query
│ filteredNews: List<NewsModel>            │ ← Filtered results
├──────────────────────────────────────────┤
│ Methods:                                 │
│ • toggleCategory(cat)                    │
│ • applyFilters()                         │
│ • clearFilters()                         │
│ • search(query)                          │
└──────────────────────────────────────────┘
```

---

## 🎬 Navigation State Diagram

```
                    ┌──────────────┐
                    │  App Start   │
                    └──────────────┘
                           ↓
            ┌──────────────────────────────┐
            │ Check Authentication         │
            └──────────────────────────────┘
                ↙                        ↘
        [Not Logged In]           [Logged In]
                ↓                        ↓
        ┌──────────────┐        ┌──────────────┐
        │ Login Route  │        │ Home Route   │
        │  (/login)    │        │   (/)        │
        └──────────────┘        └──────────────┘
                ↓                        ↓
        ┌──────────────┐        ┌──────────────┐
        │ LoginView    │        │  HomeView    │
        │ LoginForm    │        │  + Settings  │
        │ Demo Accounts│        │  + Details   │
        └──────────────┘        └──────────────┘
                ↓                    ↓
            [Login]            [Navigate]
                ↓                ↙        ↘
        ┌──────────────┐    ┌────────┐  ┌──────────┐
        │ Save Session │    │Settings│  │Detail    │
        │ Go to Home   │    │View    │  │View      │
        └──────────────┘    │(/      │  │(/detail) │
                ↓           │settings)  └──────────┘
        ┌──────────────┐    └────────┘
        │ Home Screen  │
        └──────────────┘
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
