# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

FEEDLOG is a Flutter-based AI nutrition tracking app with a chat-first interface. Users track nutrition through natural conversation with an AI assistant powered by OpenAI GPT-4o-mini. Food data comes from the FatSecret API (155,000+ foods database).

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

1. **Service Abstraction**: Services use abstract classes with concrete implementations (e.g., `AIService` → `OpenAIService`/`MockAIService`, `FirestoreUserService` → `FirestoreUserServiceImpl`)

2. **Chat-Driven Onboarding**: The onboarding flow happens within the chat interface using a state machine in `ChatNotifier`. Steps: welcome → gender → age → height → weight → target_weight → activity → goal → tutorial → completed

3. **Dynamic Chat Widgets**: Chat messages can render interactive widgets via `MessageType.widget` with `widgetType` in metadata. Widget types: `daily_summary`, `gender_selector`, `activity_selector`, `goal_selector`

4. **AI Response Protocol**: AI responses can contain markers like `WIDGET:daily_summary` which the chat provider parses to inject widgets into the chat stream

### Core Services (lib/core/services/)

- **ai_service.dart**: OpenAI integration for chat responses and food analysis. Toggle `useRealAPI` constant to switch between real/mock mode
- **fatsecret_service.dart**: FatSecret API for food search and nutrition data lookup
- **firestore_user_service.dart**: User profile, weight tracking, and goals persistence in Firestore
- **firestore_service.dart**: Chat message persistence (currently mock implementation)

### Feature Structure (lib/features/)

- **auth/**: Firebase Authentication (email/password). Screens: login, signup, loading
- **chat/**: Main chat UI and logic
  - `chat_provider.dart`: Central state management for chat, handles both onboarding and normal conversations
  - `chat_message.dart`: Message model with types (text, image, widget, typing)
- **onboarding/**: User data extraction from natural language (name, age, height, weight parsing)

### Data Flow for Nutrition Tracking

1. User sends message → `ChatNotifier.sendMessage()`
2. If onboarding: `_handleOnboardingMessage()` extracts user data
3. If normal chat: `_handleNormalMessage()` → AI analyzes food via FatSecret → generates response

### Navigation

Uses **GoRouter** with auth-based redirects. Routes: `/` (chat), `/login`, `/signup`, `/loading`

## Localization

12 languages supported via ARB files in `lib/l10n/`. Template: `app_en.arb`. Generated via Flutter's built-in localization (`flutter: generate: true` in pubspec).

## Key Enums (lib/core/utils/tdee_calculator.dart)

- `Gender`: male, female
- `ActivityLevel`: sedentary, light, moderate, active, veryActive
- `WeightGoal`: lose, maintain, gain
