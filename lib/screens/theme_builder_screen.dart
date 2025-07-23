import 'package:flutter/material.dart';

import '../models/color_token.dart';
import '../models/theme_data_model.dart';
import '../services/theme_generator_service.dart';
import '../widgets/custom_token_editor.dart';
import '../widgets/export_panel.dart';
import '../widgets/mobile_preview_panel.dart';
import '../widgets/seed_color_input.dart';
import '../widgets/token_editor.dart';

class ThemeBuilderScreen extends StatefulWidget {
  const ThemeBuilderScreen({super.key});

  @override
  State<ThemeBuilderScreen> createState() => _ThemeBuilderScreenState();
}

class _ThemeBuilderScreenState extends State<ThemeBuilderScreen>
    with TickerProviderStateMixin {
  late ThemeDataModel _themeModel;
  bool _isDarkMode = false;
  late PageController _pageController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _tabController = TabController(length: 4, vsync: this);
    _initializeTheme();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _initializeTheme() {
    final defaultScheme = ThemeGeneratorService.getDefaultMaterialTheme();
    _themeModel = ThemeDataModel(
      colorSchemeModel: defaultScheme,
      name: 'My Material Theme',
      description: 'A custom Material Design 3 theme',
    );
  }

  void _updateSeedColor(String seedType, Color color) {
    setState(() {
      late Color primary, secondary, tertiary, neutral;

      switch (seedType) {
        case 'primary':
          primary = color;
          secondary = _themeModel.colorSchemeModel.secondarySeed;
          tertiary = _themeModel.colorSchemeModel.tertiarySeed;
          neutral = _themeModel.colorSchemeModel.neutralSeed;
          break;
        case 'secondary':
          primary = _themeModel.colorSchemeModel.primarySeed;
          secondary = color;
          tertiary = _themeModel.colorSchemeModel.tertiarySeed;
          neutral = _themeModel.colorSchemeModel.neutralSeed;
          break;
        case 'tertiary':
          primary = _themeModel.colorSchemeModel.primarySeed;
          secondary = _themeModel.colorSchemeModel.secondarySeed;
          tertiary = color;
          neutral = _themeModel.colorSchemeModel.neutralSeed;
          break;
        case 'neutral':
          primary = _themeModel.colorSchemeModel.primarySeed;
          secondary = _themeModel.colorSchemeModel.secondarySeed;
          tertiary = _themeModel.colorSchemeModel.tertiarySeed;
          neutral = color;
          break;
        default:
          return;
      }

      final newScheme = ThemeGeneratorService.generateFromSeeds(
        primary: primary,
        secondary: secondary,
        tertiary: tertiary,
        neutral: neutral,
      );

      _themeModel = _themeModel.copyWith(
        colorSchemeModel: newScheme,
        updatedAt: DateTime.now(),
      );
    });
  }

  void _updateToken(String tokenName, Color color, bool isDark) {
    setState(() {
      final tokens = isDark
          ? Map<String, ColorToken>.from(
              _themeModel.colorSchemeModel.darkTokens)
          : Map<String, ColorToken>.from(
              _themeModel.colorSchemeModel.lightTokens);

      final token = tokens[tokenName];
      if (token != null) {
        token.setCustomValue(color);

        final newColorSchemeModel = _themeModel.colorSchemeModel.copyWith(
          lightTokens: isDark ? null : tokens,
          darkTokens: isDark ? tokens : null,
        );

        _themeModel = _themeModel.copyWith(
          colorSchemeModel: newColorSchemeModel,
          updatedAt: DateTime.now(),
        );
      }
    });
  }

  void _resetToken(String tokenName, bool isDark) {
    setState(() {
      final tokens = isDark
          ? Map<String, ColorToken>.from(
              _themeModel.colorSchemeModel.darkTokens)
          : Map<String, ColorToken>.from(
              _themeModel.colorSchemeModel.lightTokens);

      final token = tokens[tokenName];
      if (token != null) {
        token.resetToDefault();

        final newColorSchemeModel = _themeModel.colorSchemeModel.copyWith(
          lightTokens: isDark ? null : tokens,
          darkTokens: isDark ? tokens : null,
        );

        _themeModel = _themeModel.copyWith(
          colorSchemeModel: newColorSchemeModel,
          updatedAt: DateTime.now(),
        );
      }
    });
  }

  void _resetAllSeeds() {
    setState(() {
      final newScheme = ThemeGeneratorService.generateFromSeeds(
        primary: Colors.blue,
        secondary: Colors.blueAccent,
        tertiary: Colors.lightBlue,
        neutral: Colors.grey,
      );

      _themeModel = _themeModel.copyWith(
        colorSchemeModel: newScheme,
        updatedAt: DateTime.now(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width >= 1200;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          _buildAppBar(),
          _buildTabBar(),
          Expanded(
            child: isWideScreen
                ? _buildWideScreenLayout()
                : _buildNarrowScreenLayout(),
          ),
        ],
      ),
    );
  }

  Widget _buildWideScreenLayout() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildSeedColorsTab(),
              _buildTokenEditorTab(),
              _buildCustomTokensTab(),
              _buildExportTab(),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height: double.infinity,
            padding: const EdgeInsets.all(24.0),
            child: MobilePreviewPanel(
              themeModel: _themeModel,
              isDarkMode: _isDarkMode,
              onThemeChanged: (isDark) {
                setState(() {
                  _isDarkMode = isDark;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNarrowScreenLayout() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildSeedColorsTab(),
        _buildTokenEditorTab(),
        _buildCustomTokensTab(),
        _buildExportTab(),
      ],
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.palette,
            size: 32,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Material Theme Builder',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                'Create custom Material Design 3 color schemes',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(
            icon: Icon(Icons.color_lens),
            text: 'Seed Colors',
          ),
          Tab(
            icon: Icon(Icons.tune),
            text: 'Token Editor',
          ),
          Tab(
            icon: Icon(Icons.extension),
            text: 'Custom Tokens',
          ),
          Tab(
            icon: Icon(Icons.download),
            text: 'Export',
          ),
        ],
        labelColor: Theme.of(context).colorScheme.primary,
        unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
        indicatorColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildSeedColorsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: SeedColorsPanel(
        primarySeed: _themeModel.colorSchemeModel.primarySeed,
        secondarySeed: _themeModel.colorSchemeModel.secondarySeed,
        tertiarySeed: _themeModel.colorSchemeModel.tertiarySeed,
        neutralSeed: _themeModel.colorSchemeModel.neutralSeed,
        onPrimaryChanged: (color) => _updateSeedColor('primary', color),
        onSecondaryChanged: (color) => _updateSeedColor('secondary', color),
        onTertiaryChanged: (color) => _updateSeedColor('tertiary', color),
        onNeutralChanged: (color) => _updateSeedColor('neutral', color),
        onResetAll: _resetAllSeeds,
      ),
    );
  }

  Widget _buildTokenEditorTab() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: TokenEditor(
        lightTokens: _themeModel.colorSchemeModel.lightTokens,
        darkTokens: _themeModel.colorSchemeModel.darkTokens,
        isDarkMode: _isDarkMode,
        onTokenChanged: _updateToken,
        onTokenReset: _resetToken,
      ),
    );
  }

  Widget _buildCustomTokensTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: const CustomTokenEditor(),
    );
  }

  Widget _buildExportTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: ExportPanel(themeModel: _themeModel),
    );
  }
}
