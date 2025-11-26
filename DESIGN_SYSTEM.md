# FEEDLOG Design System

Design system completo do FEEDLOG - App de nutrição com interface chat-first e visual LiquidGlass.

## Filosofia de Design

O FEEDLOG utiliza o conceito **LiquidGlass** - um design system baseado em glassmorphism que combina:
- Superfícies translúcidas com blur
- Gradientes sutis
- Cores neon vibrantes sobre fundos escuros
- Bordas luminosas com baixa opacidade

---

## Paleta de Cores

### Cores Primárias

| Nome | Hex | RGB | Uso |
|------|-----|-----|-----|
| **Neon Mint** | `#00FF9D` | rgb(0, 255, 157) | Cor principal, CTAs, destaques positivos |
| **Deep Ocean** | `#0A1929` | rgb(10, 25, 41) | Background principal |
| **Electric Blue** | `#00D4FF` | rgb(0, 212, 255) | Cor secundária, ícones, links |

### Cores Funcionais (Macronutrientes)

| Nome | Hex | RGB | Uso |
|------|-----|-----|-----|
| **Protein Red** | `#FF4D4D` | rgb(255, 77, 77) | Proteínas, alertas |
| **Carb Amber** | `#FFC107` | rgb(255, 193, 7) | Carboidratos |
| **Fat Purple** | `#9D4EDD` | rgb(157, 78, 221) | Gorduras |
| **Accent Coral** | `#FF6B6B` | rgb(255, 107, 107) | Destaques femininos, metas |

### Cores de Superfície (Glass)

| Nome | Valor | Uso |
|------|-------|-----|
| **Glass Light** | `rgba(255, 255, 255, 0.1)` | Bordas de containers |
| **Glass Medium** | `rgba(255, 255, 255, 0.2)` | Background de containers |
| **Glass Dark** | `rgba(0, 0, 0, 0.3)` | Backgrounds escuros |
| **Glass Highlight** | `rgba(255, 255, 255, 0.05)` | Highlights sutis |
| **Shadow** | `rgba(0, 0, 0, 0.5)` | Sombras |

### Cores de Texto

| Nome | Hex | Uso |
|------|-----|-----|
| **Text Primary** | `#FFFFFF` | Texto principal |
| **Text Secondary** | `#B0BEC5` | Texto secundário, captions |

---

## Tipografia

**Fonte:** Google Fonts - **Outfit**

| Estilo | Tamanho | Peso | Espaçamento | Line Height |
|--------|---------|------|-------------|-------------|
| **H1** | 32px | Bold (700) | -1.0 | default |
| **H2** | 24px | SemiBold (600) | default | default |
| **Body1** | 16px | Normal (400) | default | 1.5 |
| **Body2** | 14px | Normal (400) | default | 1.4 |
| **Button** | 16px | SemiBold (600) | 0.5 | default |
| **Caption** | 12px | Medium (500) | default | default |

---

## Componentes

### GlassContainer

Componente base para superfícies com efeito glassmorphism.

**Propriedades:**
- `blur`: 10.0 (default)
- `borderRadius`: 20px (default)
- `backgroundColor`: Glass Medium
- `borderColor`: Glass Light
- `padding`: 16px (default)

**Características:**
- BackdropFilter com blur gaussiano
- Gradiente diagonal (top-left → bottom-right)
- Borda de 1px com cor translúcida
- BoxShadow: offset (0, 10), blur 20px, cor Shadow

```
┌─────────────────────────────────┐
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │  ← Blur effect
│  ░░  Gradient Overlay  ░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
│  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
└─────────────────────────────────┘
         ▓▓▓▓▓▓▓▓▓▓▓                ← Shadow
```

---

### Chat Bubble

Bolhas de mensagem diferenciadas por remetente.

**AI Message:**
- Background: Glass Medium
- Border: Glass Light
- Border Radius: 20px (top), 4px (bottom-left), 20px (bottom-right)
- Avatar: Gradiente Neon Mint → Electric Blue, circular, com glow

**User Message:**
- Background: Neon Mint @ 10% opacity
- Border: Neon Mint @ 30% opacity
- Border Radius: 20px (top), 20px (bottom-left), 4px (bottom-right)
- Texto: Neon Mint
- Avatar: Glass Medium com borda Glass Light

```
AI Message:                          User Message:
┌──────────────────┐                      ┌──────────────────┐
│ 🤖 │ Mensagem    │                      │    Mensagem │ 👤 │
└────┴─────────────┘                      └─────────────┴────┘
```

---

### Avatares

**AI Avatar:**
- Tamanho: 32x32px
- Forma: Círculo
- Gradiente: Neon Mint → Electric Blue
- Glow: Neon Mint @ 30% opacity, blur 8px
- Ícone: `auto_awesome` (16px, branco)

**User Avatar:**
- Tamanho: 32x32px
- Forma: Círculo
- Background: Glass Medium
- Border: Glass Light
- Ícone: `person` (16px, branco)

---

### Typing Indicator

Indicador de digitação com animação de bounce.

- 3 círculos de 6x6px
- Cor: Text Secondary @ 60%
- Animação: 1200ms loop
- Movimento: Sinusoidal com phase shift entre círculos

---

### Daily Summary Widget

Card de resumo diário de macronutrientes.

**Container:**
- Background: Deep Ocean @ 60%
- Border: Neon Mint @ 30%
- Padding: 20px
- Animação: FadeIn + SlideX

**Macro Items:**
- Grid 2x2
- Cada item com background da cor do macro @ 10%
- Border da cor @ 20%
- Border Radius: 12px
- Padding: 12px

```
┌─────────────────────────────────┐
│  Daily Summary                   │
├────────────────┬────────────────┤
│  Calories      │  Protein       │
│  1300 kcal     │  120g Left     │
│  (Neon Mint)   │  (Protein Red) │
├────────────────┼────────────────┤
│  Carbs         │  Fat           │
│  150g Left     │  45g Left      │
│  (Carb Amber)  │  (Fat Purple)  │
└────────────────┴────────────────┘
```

---

### Selector Widgets (Gender, Activity, Goal)

Cards de seleção interativos para onboarding.

**Container:**
- GlassContainer padrão
- Padding: 16px

**Options:**
- Background não selecionado: Glass Dark
- Background selecionado: Cor do item @ 30%
- Border selecionado: Cor do item sólida
- Border não selecionado: Glass Light
- Ícone em container com cor @ 20%, border radius 8px

**Confirm Button:**
- Background ativo: Neon Mint
- Background desabilitado: Glass Medium
- Texto ativo: Dark Bg (contraste)
- Texto desabilitado: Text Secondary
- Border Radius: 12px
- Padding vertical: 16px

---

### Input Area

Área de entrada de texto no chat.

**Container:**
- GlassContainer
- Padding: horizontal 16px, vertical 8px

**Elementos:**
- Botão anexo: `add_circle_outline`, Neon Mint
- TextField: Body1, sem borda
- Placeholder: Caption style
- Botão enviar: `send`, Electric Blue

---

## Backgrounds

### Tela Principal

Gradiente radial com centro no top-left:

```dart
RadialGradient(
  center: Alignment.topLeft,
  radius: 1.5,
  colors: [
    Color(0xFF1A2C42),  // Lighter ocean
    AppColors.deepOcean, // #0A1929
  ],
)
```

### AppBar

- Transparente com BackdropFilter
- Blur: 10px (sigmaX e sigmaY)
- Overlay: Deep Ocean @ 50%

---

## Espaçamentos

| Token | Valor | Uso |
|-------|-------|-----|
| `xs` | 4px | Espaço mínimo |
| `sm` | 8px | Entre elementos relacionados |
| `md` | 12px | Padding interno de cards |
| `lg` | 16px | Padding padrão de containers |
| `xl` | 20px | Padding de widgets grandes |

---

## Border Radius

| Token | Valor | Uso |
|-------|-------|-----|
| `sm` | 8px | Ícones, badges |
| `md` | 12px | Buttons, inputs internos |
| `lg` | 20px | Cards, containers principais |

---

## Sombras

**Sombra padrão (GlassContainer):**
```dart
BoxShadow(
  color: rgba(0, 0, 0, 0.5),
  blurRadius: 20,
  offset: Offset(0, 10),
)
```

**Glow (Avatar AI):**
```dart
BoxShadow(
  color: neonMint.withOpacity(0.3),
  blurRadius: 8,
)
```

---

## Animações

| Componente | Tipo | Duração | Curva |
|------------|------|---------|-------|
| Daily Summary | FadeIn + SlideX | 200-400ms | default |
| Typing Indicator | Bounce loop | 1200ms | sinusoidal |
| Scroll to bottom | AnimateTo | 300ms | easeOut |
| Message delay | Typing simulation | 1000-3000ms | linear |

---

## Arquivos de Implementação

| Arquivo | Descrição |
|---------|-----------|
| `lib/core/theme/app_colors.dart` | Definição de cores |
| `lib/core/theme/app_text_styles.dart` | Estilos de texto |
| `lib/core/theme/app_theme.dart` | ThemeData do Material 3 |
| `lib/core/widgets/glass_container.dart` | Componente glassmorphism |
| `lib/features/chat/presentation/widgets/chat_bubble.dart` | Bolhas de chat |
| `lib/features/chat/presentation/widgets/typing_indicator.dart` | Indicador de digitação |
| `lib/features/chat/presentation/widgets/dynamic_content/*.dart` | Widgets dinâmicos |

---

## Princípios de Design

1. **Consistência**: Use sempre os tokens definidos (cores, espaçamentos, radius)
2. **Hierarquia**: Neon Mint para ações principais, Electric Blue para secundárias
3. **Feedback Visual**: Estados hover/pressed com opacidade reduzida
4. **Acessibilidade**: Contraste mínimo de 4.5:1 para texto sobre backgrounds
5. **Responsividade**: Containers flexíveis com Flexible/Expanded
6. **Animação Sutil**: Transições suaves, nunca distrativas
