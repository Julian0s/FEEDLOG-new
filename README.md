# FEEDLOG - Chat-First Nutrition Tracker

A Flutter app that uses AI and real food databases to help you track nutrition through natural conversation.

## 🌟 Features

- **Chat-First Interface**: Talk to your nutrition assistant naturally
- **Real AI (OpenAI GPT-4o-mini)**: Intelligent, contextual responses
- **FatSecret API**: Real nutrition data from 155,000+ foods
- **LiquidGlass Design**: Premium glassmorphism UI
- **12 Languages**: PT, EN, ES, FR, DE, IT, ZH, JA, RU, AR, KO, HI
- **Dynamic Widgets**: Visual summaries appear in chat

## 🚀 Quick Start

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Setup API Keys
Your API keys are already configured in the code:
- **OpenAI**: Configured in `lib/core/services/ai_service.dart`
- **FatSecret**: Configured in `lib/core/services/fatsecret_service.dart`

### 3. Generate Code
```bash
flutter pub run build_runner build
```

### 4. Run
```bash
flutter run
```

## 💬 Try It

Type in the chat:
- "Comi 2 ovos no café da manhã" → Get nutrition data
- "Quantas calorias ainda posso comer?" → See daily summary widget
- "I ate a banana" → Works in English too

## 🏗️ Architecture

- **State Management**: Riverpod (code generation)
- **HTTP Client**: Dio
- **Navigation**: GoRouter
- **Localization**: ARB files

## 📁 Key Files

- `lib/core/services/ai_service.dart` - OpenAI integration
- `lib/core/services/fatsecret_service.dart` - Food database
- `lib/features/chat/` - Chat UI and logic
- `lib/core/theme/` - LiquidGlass design system

## 🔧 Toggle Mock/Real API

In `lib/core/services/ai_service.dart`:
```dart
const useRealAPI = true; // false for mock mode
```

## 📱 Platforms

- ✅ Android
- ✅ iOS
- ✅ Web

---

Built with Flutter 💙 | Powered by OpenAI & FatSecret
