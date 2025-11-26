# Segurança de API Keys - FEEDLOG

## ⚠️ IMPORTANTE: Proteção de Chaves

As chaves de API estão protegidas usando **environment variables** do Dart. 

### Como Funciona

O código usa `String.fromEnvironment()` que carrega valores em **compile-time**:

```dart
const apiKey = String.fromEnvironment('OPENAI_PROXY_API_KEY', 
  defaultValue: 'chave_de_desenvolvimento');
```

### Para Desenvolvimento (Local)

As chaves já estão definidas como `defaultValue` para facilitar o desenvolvimento local. **NÃO COMMITE O ARQUIVO `.env` NO GIT!**

### Para Produção

Ao fazer build para produção, passe as variáveis:

```bash
# Android
flutter build apk --dart-define=OPENAI_PROXY_API_KEY=sua_chave_aqui --dart-define=FATSECRET_CLIENT_ID=seu_id --dart-define=FATSECRET_CLIENT_SECRET=seu_secret

# iOS  
flutter build ios --dart-define=OPENAI_PROXY_API_KEY=sua_chave_aqui --dart-define=FATSECRET_CLIENT_ID=seu_id --dart-define=FATSECRET_CLIENT_SECRET=seu_secret

# Web
flutter build web --dart-define=OPENAI_PROXY_API_KEY=sua_chave_aqui --dart-define=FATSECRET_CLIENT_ID=seu_id --dart-define=FATSECRET_CLIENT_SECRET=seu_secret
```

### Variáveis Disponíveis

- `OPENAI_PROXY_API_KEY` - Chave da OpenAI
- `OPENAI_PROXY_ENDPOINT` - Endpoint da OpenAI (default: https://api.openai.com/v1)
- `FATSECRET_CLIENT_ID` - Client ID do FatSecret
- `FATSECRET_CLIENT_SECRET` - Client Secret do FatSecret

### .gitignore

O arquivo `.env` já está no `.gitignore` para não ser versionado.

### Alternativa: Firebase Cloud Functions

Para segurança máxima, considere usar **Firebase Cloud Functions** como proxy:

1. Criar Cloud Function que chama OpenAI/FatSecret
2. App chama a Cloud Function (autenticada com Firebase Auth)
3. Chaves ficam 100% no servidor

Isso evita que as chaves fiquem no código do app (mesmo compilado).
