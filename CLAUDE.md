## Project Overview
Create a Flutter web app that allows users to generate Material Design 3 color schemes from 4 seed colors, with the ability to customize individual color tokens or use auto-generated values.

## Architecture & Setup

### Project Structure
```
lib/
├── main.dart
├── models/
│   ├── color_scheme_model.dart
│   ├── theme_data_model.dart
│   └── color_token.dart
├── services/
│   ├── theme_generator_service.dart
│   ├── color_utils.dart
│   └── export_service.dart
├── widgets/
│   ├── color_picker_widget.dart
│   ├── seed_color_input.dart
│   ├── token_editor.dart
│   ├── preview_panel.dart
│   └── export_panel.dart
├── screens/
│   └── theme_builder_screen.dart
└── constants/
    └── material_tokens.dart
```

### Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  material_color_utilities: ^0.8.0  # For Material 3 color generation
  flex_color_picker: ^3.4.1        # Advanced color picker
  flutter_colorpicker: ^1.0.3      # Alternative color picker
  json_annotation: ^4.8.1          # JSON serialization
  provider: ^6.1.1                 # State management
  file_saver: ^0.2.9               # Export functionality
  
dev_dependencies:
  build_runner: ^2.4.9
  json_serializable: ^6.7.1
```

## Core Models

### ColorToken Model
```dart
@JsonSerializable()
class ColorToken {
  final String name;
  final String description;
  final Color defaultValue;
  Color? customValue;
  final bool isCustomizable;
  
  // Constructor and methods
  Color get effectiveValue => customValue ?? defaultValue;
  bool get isCustomized => customValue != null;
}
```

### ColorSchemeModel
```dart
@JsonSerializable()
class ColorSchemeModel {
  final Color primarySeed;
  final Color secondarySeed;
  final Color tertiarySeed;
  final Color neutralSeed;
  
  final Map<String, ColorToken> lightTokens;
  final Map<String, ColorToken> darkTokens;
  
  // Methods for generating from seeds
  // Methods for customizing individual tokens
}
```

## Key Features Implementation

### 1. Seed Color Input System
- **Four primary inputs**: Primary, Secondary, Tertiary, Neutral seed colors
- **Visual feedback**: Live preview of generated scheme
- **Validation**: Ensure colors meet accessibility requirements
- **Reset functionality**: Return to default Material 3 seeds

### 2. Material 3 Color Generation Service
```dart
class ThemeGeneratorService {
  static ColorSchemeModel generateFromSeeds({
    required Color primary,
    required Color secondary,
    required Color tertiary,
    required Color neutral,
  }) {
    // Use material_color_utilities to generate full palette
    // Create ColorToken instances for all M3 tokens
    // Handle both light and dark variants
  }
  
  static Map<String, ColorToken> generateTokenMap(ColorScheme scheme) {
    // Map all Material 3 color tokens
    // Include surface variants, outline colors, etc.
  }
}
```

### 3. Token Categories Organization
Organize color tokens into logical groups:
- **Primary colors**: primary, onPrimary, primaryContainer, onPrimaryContainer
- **Secondary colors**: secondary, onSecondary, secondaryContainer, onSecondaryContainer
- **Tertiary colors**: tertiary, onTertiary, tertiaryContainer, onTertiaryContainer
- **Error colors**: error, onError, errorContainer, onErrorContainer
- **Surface colors**: surface, onSurface, surfaceVariant, onSurfaceVariant
- **Background colors**: background, onBackground
- **Outline colors**: outline, outlineVariant
- **Additional**: shadow, scrim, inverseSurface, etc.

### 4. Individual Token Editor
```dart
class TokenEditor extends StatelessWidget {
  final String category;
  final List<ColorToken> tokens;
  final Function(String tokenName, Color color) onTokenChanged;
  
  // Expandable sections for each category
  // Individual color pickers for each token
  // Reset individual tokens to generated values
  // Visual indicators for customized vs generated tokens
}
```

### 5. Real-time Preview System
- **Component previews**: Show Material 3 components using current theme
- **Light/Dark mode toggle**: Switch between schemes instantly
- **Interactive elements**: Buttons, cards, text fields, app bars
- **Accessibility indicators**: Contrast ratios, WCAG compliance

### 6. Export Functionality
Support multiple export formats:
- **Flutter ThemeData**: Complete Dart code
- **JSON**: Structured color data
- **CSS Custom Properties**: For web integration
- **Design Tokens**: JSON format for design systems
- **Material Theme Builder format**: Compatible with Google's tool

## UI/UX Design

### Layout Structure
```
┌─────────────────────────────────────────────────────┐
│ Header: Material Theme Builder                       │
├─────────────────────────────────────────────────────┤
│ ┌─────────────────┐ ┌───────────────────────────────┐│
│ │ Seed Colors     │ │ Preview Panel                 ││
│ │ - Primary       │ │ ┌───────────┐ ┌─────────────┐ ││
│ │ - Secondary     │ │ │ Light     │ │ Dark        │ ││
│ │ - Tertiary      │ │ │ Theme     │ │ Theme       │ ││
│ │ - Neutral       │ │ └───────────┘ └─────────────┘ ││
│ └─────────────────┘ └───────────────────────────────┘│
│ ┌─────────────────────────────────────────────────────┐│
│ │ Token Editor (Expandable Sections)                  ││
│ │ ▼ Primary Colors    ▼ Secondary Colors              ││
│ │ ▼ Surface Colors    ▼ Error Colors                  ││
│ └─────────────────────────────────────────────────────┘│
│ ┌─────────────────────────────────────────────────────┐│
│ │ Export Panel                                        ││
│ └─────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────┘
```

### Responsive Design
- **Desktop**: Full side-by-side layout
- **Tablet**: Stacked sections with optimal spacing
- **Mobile**: Collapsible sections, bottom navigation

## Advanced Features

### 1. Accessibility Integration
- **Contrast validation**: Real-time WCAG AA/AAA checking
- **Color blindness simulation**: Preview for different types
- **Accessibility scoring**: Overall theme accessibility rating

### 2. Preset Management
- **Save custom themes**: Local storage of user creations
- **Popular presets**: Curated Material 3 themes
- **Import functionality**: Load existing themes

### 3. Advanced Color Tools
- **Harmony analysis**: Color relationship visualization
- **Palette generator**: Extended color variations
- **Color space conversion**: HSL, HSV, LAB support

## Implementation Phases

### Phase 1: Core Foundation (Week 1-2)
1. Set up Flutter web project with dependencies
2. Implement basic models and Material 3 generation
3. Create seed color input interface
4. Build basic preview system

### Phase 2: Token Editing (Week 3)
1. Implement comprehensive token editor
2. Add categorized color organization
3. Create individual color picker integration
4. Add reset and customization tracking

### Phase 3: Preview & Export (Week 4)
1. Build comprehensive preview components
2. Implement all export formats
3. Add light/dark mode switching
4. Create download functionality

### Phase 4: Polish & Advanced Features (Week 5)
1. Add accessibility validation
2. Implement responsive design
3. Add preset management
4. Performance optimization and testing

## Testing Strategy
- **Unit tests**: Color generation algorithms
- **Widget tests**: UI components and interactions
- **Integration tests**: End-to-end theme building workflow
- **Accessibility tests**: Screen reader and contrast validation

## Performance Considerations
- **Debounced updates**: Prevent excessive recalculation
- **Lazy loading**: Token categories load on demand
- **Efficient rebuilds**: Use Provider/setState strategically
- **Web optimization**: Code splitting for large color utilities
