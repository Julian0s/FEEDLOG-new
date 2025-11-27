# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

FEEDLOG is a Flutter-based AI nutrition tracking app with a chat-first interface. Users track nutrition through natural conversation with an AI assistant powered by OpenAI GPT-4o-mini. Food data comes from the FatSecret API (155,000+ foods database).

**Key Features:**
- Chat-driven onboarding with natural language processing
- 12 languages supported with localized AI prompts
- Profile photo/avatar selection using DiceBear API
- Glassmorphism dark theme with Material 3

## Build & Run Commands

```bash
# Install dependencies
flutter pub get

# Generate Riverpod providers and other code
flutter pub run build_runner build

# Run the app
flutter run

# Analyze code for issues
flutter analyze
```

### Production Builds with API Keys

API keys should be passed at compile-time via `--dart-define`:

```bash
flutter build apk --dart-define=OPENAI_PROXY_API_KEY=xxx --dart-define=FATSECRET_CLIENT_ID=xxx --dart-define=FATSECRET_CLIENT_SECRET=xxx
```

## Architecture

### State Management
Uses **Riverpod with code generation** (`riverpod_annotation`). Providers are defined with `@riverpod` annotation and generated `.g.dart` files via `build_runner`.

### Key Architectural Patterns

1. **Service Abstraction**: Services use abstract classes with concrete implementations (e.g., `AIService` → `OpenAIService`/`MockAIService`, `FirestoreUserService` → `FirestoreUserServiceImpl`, `FatSecretService` → `FatSecretServiceImpl`)

2. **Chat-Driven Onboarding**: The onboarding flow happens within the chat interface using a state machine in `ChatNotifier`.
   - **Steps (12 total)**: welcome → name → gender → profile_photo → age → height → weight → target_weight → activity → goal → tutorial → completed
   - Language selection occurs before onboarding on first access

3. **Dynamic Chat Widgets**: Chat messages can render interactive widgets via `MessageType.widget` with `widgetType` in metadata.
   - **Widget types**: `daily_summary`, `gender_selector`, `activity_selector`, `goal_selector`, `language_selector`, `profile_photo_selector`

4. **AI Response Protocol**: AI responses can contain markers like `WIDGET:daily_summary` which the chat provider parses to inject widgets into the chat stream

5. **Localized AI Prompts**: `AIPromptService` provides dynamic system prompts based on user's language for all 12 supported languages

### Project Structure

```
lib/
├── main.dart                    # App entry, Firebase init, GoRouter setup
├── firebase_options.dart        # Firebase config by platform
├── core/
│   ├── constants/
│   │   └── avatar_constants.dart   # DiceBear avatar seeds & URL generation
│   ├── providers/
│   │   └── locale_provider.dart    # Language/locale state, profile photo notifier
│   ├── services/                   # Core business logic
│   ├── theme/                      # Glassmorphism dark theme
│   ├── utils/
│   │   └── tdee_calculator.dart    # TDEE/BMR calculation enums
│   └── widgets/
│       └── glass_container.dart    # Reusable glassmorphism component
├── features/
│   ├── auth/                       # Firebase Authentication
│   ├── chat/                       # Main chat UI and logic
│   └── onboarding/                 # NLP data extraction
└── l10n/                           # 12 language ARB files
```

### Core Services (lib/core/services/)

| Service | Purpose | Pattern |
|---------|---------|---------|
| `ai_service.dart` | OpenAI GPT-4o-mini integration for chat responses and food analysis. Toggle `useRealAPI` constant to switch between real/mock mode | Abstract + 2 impls |
| `ai_prompt_service.dart` | Dynamic system prompts for AI based on current language (12 languages) | Concrete |
| `fatsecret_service.dart` | FatSecret API for food search (155,000+ foods) and nutrition data lookup with OAuth 2.0 token caching | Abstract + impl |
| `firestore_user_service.dart` | User profile, weight tracking, goals, avatar/photo history, and language persistence in Firestore | Abstract + impl |
| `firestore_service.dart` | Chat message persistence (currently mock implementation) | Abstract + mock |

### Core Providers (lib/core/providers/)

- **locale_provider.dart**:
  - `localeProvider` - Language/locale state management with Firestore persistence
  - `UserProfilePhotoNotifier` - Manages profile photo/avatar data (avatarId, avatarUrl, photoUrl)
  - `l10n` provider for accessing translations without BuildContext
  - Helper functions: `isLocaleSupported()`, `getDeviceLocale()`

### Theme System (lib/core/theme/)

- **app_theme.dart**: Material 3 dark theme configuration
- **app_colors.dart**: Color palette
  - Primary: neonMint (#00FF9D), deepOcean (#0A1929), electricBlue (#00D4FF)
  - Functional: proteinRed, carbAmber, fatPurple, accentCoral
  - Glass effects: glassLight, glassMedium, glassDark
- **app_text_styles.dart**: Typography using Google Fonts (Outfit family)
  - Sizes: h1 (32px), h2 (24px), body1 (16px), body2 (14px), caption (12px)

### Avatar System (lib/core/constants/)

- **avatar_constants.dart**: DiceBear Personas API integration
  - Base URL: `https://api.dicebear.com/9.x/personas/svg`
  - 12 male + 12 female pre-defined avatar seeds
  - Functions: `generateRandomAvatars()`, `getAvatarsByGender()`, `getAvatarUrl()`

### Feature Structure (lib/features/)

#### auth/
Firebase Authentication (email/password)
- **domain/auth_service.dart**: Abstract `AuthService` with `FirebaseAuthService` implementation
  - Methods: `signIn()`, `signUp()`, `signOut()`, `resetPassword()`
  - Providers: `authServiceProvider`, `authStateChangesProvider`, `currentUserProvider`
- **presentation/**: `LoginScreen`, `SignupScreen`, `LoadingScreen`

#### chat/
Main chat UI and logic
- **domain/chat_message.dart**: Message model
  - `MessageSender`: user, ai
  - `MessageType`: text, image, widget, typing
- **presentation/providers/chat_provider.dart**: Central state management
  - Handles onboarding flow (12-step state machine)
  - Normal chat message handling with AI responses
  - FatSecret food analysis integration
  - Dynamic widget injection via `WIDGET:` markers
- **presentation/widgets/**: `chat_bubble.dart`, `typing_indicator.dart`
- **presentation/widgets/dynamic_content/**: Interactive widgets rendered in chat
  - `daily_summary_widget.dart` - Nutrition summary (calories, macros, daily progress)
  - `gender_selector_widget.dart` - Male/Female selection
  - `activity_selector_widget.dart` - Activity level (Sedentary to Very Active)
  - `goal_selector_widget.dart` - Weight goal (Lose, Maintain, Gain)
  - `language_selector_widget.dart` - 12 languages with flags in 2-column grid
  - `profile_photo_selector_widget.dart` - Avatar/photo selection with tabs (Real Photo vs Avatar), camera/gallery picker, avatar grid with reload/history

#### onboarding/
- **domain/onboarding_service.dart**: NLP extraction for user data
  - `extractName()`, `extractGender()`, `extractAge()`, `extractHeight()`, `extractWeight()`
  - `extractWeightChange()` - Detect weight updates (e.g., "perdi 1kg", "ganhei 2 quilos")
  - Supports Portuguese and English natural language parsing
  - `onboardingSteps` - 12-step flow definition
  - `getPromptForStep()` - AI prompts with localization support

### Data Flow for Nutrition Tracking

1. User sends message → `ChatNotifier.sendMessage()`
2. If onboarding: `_handleOnboardingMessage()` extracts user data via NLP
3. If normal chat: `_handleNormalMessage()` → AI analyzes food via FatSecret → generates response with optional `WIDGET:` markers

### Navigation

Uses **GoRouter** with auth-based redirects:
- `/` - ChatScreen (main interface)
- `/login` - LoginScreen
- `/signup` - SignupScreen
- `/loading` - LoadingScreen (auth state loading)

## Localization

12 languages supported via ARB files in `lib/l10n/`:
- **Languages**: English (en), Portuguese (pt), Spanish (es), French (fr), German (de), Italian (it), Chinese (zh), Japanese (ja), Russian (ru), Arabic (ar), Korean (ko), Hindi (hi)
- **Template**: `app_en.arb`
- **Generation**: Flutter's built-in localization (`flutter: generate: true` in pubspec)
- **AI Prompts**: `AIPromptService` provides localized system prompts for each language

## Key Dependencies

| Category | Packages |
|----------|----------|
| State Management | `flutter_riverpod`, `riverpod_annotation`, `go_router` |
| Firebase | `firebase_core`, `firebase_auth`, `cloud_firestore` |
| HTTP/API | `dio`, `http`, `flutter_dotenv` |
| UI | `google_fonts`, `flutter_svg`, `flutter_animate`, `gap`, `cached_network_image` |
| Localization | `flutter_localizations`, `intl` |
| Media | `image_picker` |
| Code Gen | `build_runner`, `riverpod_generator` |

## Key Enums (lib/core/utils/tdee_calculator.dart)

- `Gender`: male, female
- `ActivityLevel`: sedentary, light, moderate, active, veryActive
- `WeightGoal`: lose, maintain, gain
