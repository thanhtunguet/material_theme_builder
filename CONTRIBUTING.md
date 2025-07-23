# Contributing to Material Theme Builder

Thank you for your interest in contributing to Material Theme Builder! This document provides guidelines and information for contributors.

## 🤝 How to Contribute

### Types of Contributions

We welcome various types of contributions:
- 🐛 **Bug fixes** - Fix issues and improve stability
- ✨ **New features** - Add new functionality or enhance existing features
- 📖 **Documentation** - Improve README, code comments, or create tutorials
- 🎨 **UI/UX improvements** - Enhance user interface and experience
- 🧪 **Testing** - Add tests or improve test coverage
- 🔧 **Performance** - Optimize performance and reduce bundle size

### Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/your-username/material_theme_builder.git
   cd material_theme_builder
   ```

3. **Set up the development environment**:
   ```bash
   flutter pub get
   flutter analyze
   flutter test
   ```

4. **Create a feature branch**:
   ```bash
   git checkout -b feature/amazing-feature
   ```

## 📋 Development Guidelines

### Code Style

- **Follow Dart/Flutter conventions**: Use `dart format` to format your code
- **Naming**: Use descriptive names for variables, functions, and classes
- **Comments**: Write clear comments for complex logic, but prefer self-documenting code
- **File organization**: Keep related code together and maintain clean imports

### Architecture Principles

- **Separation of Concerns**: Keep models, services, and UI components separate
- **State Management**: Use Provider for reactive state management
- **Error Handling**: Implement proper error handling and user feedback
- **Performance**: Consider performance implications, especially for web deployment

### Code Quality Checklist

Before submitting your contribution:
- [ ] Code follows Dart/Flutter style guidelines
- [ ] All tests pass: `flutter test`
- [ ] Code analysis passes: `flutter analyze`
- [ ] No new lint warnings or errors
- [ ] Web build works: `flutter build web`
- [ ] Manual testing completed on target platforms

## 🧪 Testing

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

### Writing Tests

- **Unit Tests**: Test business logic in services and utilities
- **Widget Tests**: Test UI components and user interactions
- **Integration Tests**: Test complete user workflows

Example test structure:
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:material_theme_builder/services/theme_generator_service.dart';

void main() {
  group('ThemeGeneratorService', () {
    test('should generate valid color scheme from seeds', () {
      // Test implementation
    });
  });
}
```

## 📝 Commit Guidelines

### Commit Message Format

Use [Conventional Commits](https://www.conventionalcommits.org/) format:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Types
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or modifying tests
- `chore`: Build process or auxiliary tool changes

### Examples
```bash
feat(tokens): add support for gradient tokens
fix(preview): resolve theme switching assertion error
docs(readme): update installation instructions
style: format code according to dart style guide
```

## 🔄 Pull Request Process

### Before Submitting

1. **Update your branch** with the latest main:
   ```bash
   git checkout main
   git pull upstream main
   git checkout your-feature-branch
   git rebase main
   ```

2. **Test thoroughly**:
   - Run full test suite
   - Test on different screen sizes
   - Verify web build works
   - Check for accessibility issues

3. **Update documentation** if needed:
   - Update README if adding new features
   - Add code comments for complex logic
   - Update CHANGELOG.md for notable changes

### Pull Request Template

When creating a pull request, include:

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Performance improvement
- [ ] Other: ___

## Testing
- [ ] Unit tests pass
- [ ] Widget tests pass
- [ ] Manual testing completed
- [ ] Web build tested

## Screenshots (if applicable)
Before/after screenshots for UI changes

## Checklist
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] No new warnings or errors
```

### Review Process

1. **Automated checks** must pass (CI/CD pipeline)
2. **Code review** by maintainers
3. **Testing** on different environments
4. **Approval** and merge

## 🐛 Bug Reports

### Before Reporting

1. **Search existing issues** to avoid duplicates
2. **Test with latest version** to ensure bug still exists
3. **Gather information**:
   - Flutter/Dart version
   - Browser and version
   - Operating system
   - Steps to reproduce

### Bug Report Template

```markdown
**Describe the bug**
Clear description of the issue

**To Reproduce**
1. Go to '...'
2. Click on '....'
3. See error

**Expected behavior**
What should happen instead

**Screenshots**
If applicable, add screenshots

**Environment:**
- Flutter version: [e.g. 3.27.4]
- Browser: [e.g. Chrome 120]
- OS: [e.g. macOS 14]

**Additional context**
Any other relevant information
```

## ✨ Feature Requests

### Before Requesting

1. **Check existing requests** to avoid duplicates
2. **Consider scope** - should it be part of core functionality?
3. **Think about implementation** - is it technically feasible?

### Feature Request Template

```markdown
**Feature Description**
Clear description of the proposed feature

**Problem Statement**
What problem does this solve?

**Proposed Solution**
How should this feature work?

**Alternatives Considered**
Other approaches you've considered

**Additional Context**
Mockups, examples, or related issues
```

## 🏗️ Development Setup

### Prerequisites

- Flutter 3.27.4+
- Dart SDK 3.6.2+
- Git
- Code editor (VS Code recommended)

### Recommended VS Code Extensions

- Dart
- Flutter
- GitLens
- Error Lens
- Prettier
- Thunder Client (for API testing)

### Environment Configuration

1. **Flutter channel**: Use stable channel
   ```bash
   flutter channel stable
   flutter upgrade
   ```

2. **Enable web support**:
   ```bash
   flutter config --enable-web
   ```

3. **Verify setup**:
   ```bash
   flutter doctor -v
   ```

## 📚 Resources

### Documentation
- [Flutter Documentation](https://docs.flutter.dev/)
- [Material Design 3](https://m3.material.io/)
- [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- [Provider Package](https://pub.dev/packages/provider)

### Tools
- [Material Theme Builder](https://m3.material.io/theme-builder) - Official Google tool
- [Flutter Inspector](https://docs.flutter.dev/tools/devtools/inspector)
- [Dart DevTools](https://docs.flutter.dev/tools/devtools)

## 🎯 Project Roadmap

### Current Focus
- Performance optimization
- Accessibility improvements
- Additional export formats
- Enhanced mobile preview

### Future Plans
- Offline support with service workers
- Advanced color harmonies
- Design system integration
- Collaborative features

## 💬 Community

### Communication Channels
- **GitHub Issues**: Bug reports and feature requests
- **GitHub Discussions**: General questions and ideas
- **Discord**: Real-time community chat
- **Twitter**: Updates and announcements

### Code of Conduct

Please note that this project is released with a [Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

---

Thank you for contributing to Material Theme Builder! 🎨✨