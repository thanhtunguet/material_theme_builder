import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/theme_data_model.dart';
import '../services/custom_token_service.dart';

class MobilePreviewPanel extends StatelessWidget {
  final ThemeDataModel themeModel;
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const MobilePreviewPanel({
    super.key,
    required this.themeModel,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomTokenService>(
      builder: (context, customTokenService, child) {
        final themeData = _buildThemeData(customTokenService);

        return Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Theme(
                        data: themeData,
                        child: _MobilePreview(
                          key: ValueKey(
                              'mobile_preview_${isDarkMode ? 'dark' : 'light'}'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Mobile Preview',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Row(
          children: [
            Icon(
              Icons.light_mode,
              size: 20,
              color: isDarkMode
                  ? Colors.grey
                  : Theme.of(context).colorScheme.primary,
            ),
            Switch(
              value: isDarkMode,
              onChanged: onThemeChanged,
            ),
            Icon(
              Icons.dark_mode,
              size: 20,
              color: isDarkMode
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
            ),
          ],
        ),
      ],
    );
  }

  ThemeData _buildThemeData(CustomTokenService customTokenService) {
    final baseTheme = isDarkMode ? themeModel.darkTheme : themeModel.lightTheme;

    if (customTokenService.customTokens.isEmpty) {
      return baseTheme;
    }

    try {
      final customExtension = isDarkMode
          ? customTokenService.buildDarkExtension()
          : customTokenService.buildLightExtension();

      return baseTheme.copyWith(
        extensions: <ThemeExtension<dynamic>>[
          customExtension,
        ],
      );
    } catch (e) {
      debugPrint('Error building custom theme extension: $e');
      return baseTheme;
    }
  }
}

class _MobilePreview extends StatefulWidget {
  const _MobilePreview({super.key});

  @override
  State<_MobilePreview> createState() => _MobilePreviewState();
}

class _MobilePreviewState extends State<_MobilePreview> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Material Theme'),
        centerTitle: true,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomeTab();
      case 1:
        return _buildExploreTab();
      case 2:
        return _buildProfileTab();
      default:
        return _buildHomeTab();
    }
  }

  Widget _buildHomeTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildCustomTokensCard(),
        const SizedBox(height: 16),
        _buildMaterialComponentsCard(),
        const SizedBox(height: 16),
        _buildTokenPairsCard(),
        const SizedBox(height: 16),
        _buildActionButtonsCard(),
      ],
    );
  }

  Widget _buildCustomTokensCard() {
    return Consumer<CustomTokenService>(
      builder: (context, customTokenService, child) {
        if (customTokenService.customTokens.isEmpty) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(Icons.extension_outlined,
                      size: 32, color: Colors.grey),
                  const SizedBox(height: 8),
                  Text(
                    'No Custom Tokens',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Add custom tokens to see them here',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.extension, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Custom Tokens',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${customTokenService.customTokens.length}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children:
                      customTokenService.customTokens.take(8).map((token) {
                    final color =
                        Theme.of(context).brightness == Brightness.light
                            ? token.lightValue
                            : token.darkValue;

                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .outline
                              .withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (token.isPredefined)
                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: _getContrastColor(color),
                                shape: BoxShape.circle,
                              ),
                            ),
                          if (token.isPredefined) const SizedBox(width: 4),
                          Text(
                            token.name,
                            style: TextStyle(
                              color: _getContrastColor(color),
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                if (customTokenService.customTokens.length > 8) ...[
                  const SizedBox(height: 8),
                  Text(
                    '+${customTokenService.customTokens.length - 8} more tokens',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMaterialComponentsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Material Components',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            // FilledButton variants
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () {},
                    child: const Text('Filled'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.star),
                    label: const Text('Filled Icon'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // ElevatedButton variants
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Elevated'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.upload),
                    label: const Text('Elevated Icon'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // OutlinedButton variants
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Outlined'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download),
                    label: const Text('Outlined Icon'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // TextButton variants
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Text'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.info),
                    label: const Text('Text Icon'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Text Field',
                hintText: 'Enter text here',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtonsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Actions & Alerts',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildChipRow('Success', Colors.green),
            const SizedBox(height: 8),
            _buildChipRow('Warning', Colors.orange),
            const SizedBox(height: 8),
            _buildChipRow('Error', Colors.red),
            const SizedBox(height: 8),
            _buildChipRow('Info', Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildChipRow(String label, Color color) {
    return Row(
      children: [
        Chip(
          label: Text(label),
          backgroundColor: color.withValues(alpha: 0.1),
          labelStyle: TextStyle(color: color),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 32,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                '$label background',
                style: TextStyle(color: color, fontSize: 12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExploreTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.explore, size: 64),
          SizedBox(height: 16),
          Text('Explore Tab'),
          Text('Preview different screens here'),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const CircleAvatar(
          radius: 50,
          child: Icon(Icons.person, size: 64),
        ),
        const SizedBox(height: 16),
        const Center(
          child: Text(
            'John Doe',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        const Center(
          child: Text('Theme Designer'),
        ),
        const SizedBox(height: 24),
        ListTile(
          leading: const Icon(Icons.palette),
          title: const Text('Color Preferences'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.help),
          title: const Text('Help & Support'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildTokenPairsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Material 3 Token Pairs',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            
            // Primary token pairs
            _buildTokenPairSection('Primary Colors', [
              _buildTokenPair('primary', 'onPrimary', 
                Theme.of(context).colorScheme.primary, 
                Theme.of(context).colorScheme.onPrimary),
              _buildTokenPair('primaryContainer', 'onPrimaryContainer', 
                Theme.of(context).colorScheme.primaryContainer, 
                Theme.of(context).colorScheme.onPrimaryContainer),
            ]),
            
            const SizedBox(height: 12),
            
            // Secondary token pairs
            _buildTokenPairSection('Secondary Colors', [
              _buildTokenPair('secondary', 'onSecondary', 
                Theme.of(context).colorScheme.secondary, 
                Theme.of(context).colorScheme.onSecondary),
              _buildTokenPair('secondaryContainer', 'onSecondaryContainer', 
                Theme.of(context).colorScheme.secondaryContainer, 
                Theme.of(context).colorScheme.onSecondaryContainer),
            ]),
            
            const SizedBox(height: 12),
            
            // Tertiary token pairs
            _buildTokenPairSection('Tertiary Colors', [
              _buildTokenPair('tertiary', 'onTertiary', 
                Theme.of(context).colorScheme.tertiary, 
                Theme.of(context).colorScheme.onTertiary),
              _buildTokenPair('tertiaryContainer', 'onTertiaryContainer', 
                Theme.of(context).colorScheme.tertiaryContainer, 
                Theme.of(context).colorScheme.onTertiaryContainer),
            ]),
            
            const SizedBox(height: 12),
            
            // Error token pairs
            _buildTokenPairSection('Error Colors', [
              _buildTokenPair('error', 'onError', 
                Theme.of(context).colorScheme.error, 
                Theme.of(context).colorScheme.onError),
              _buildTokenPair('errorContainer', 'onErrorContainer', 
                Theme.of(context).colorScheme.errorContainer, 
                Theme.of(context).colorScheme.onErrorContainer),
            ]),
            
            const SizedBox(height: 12),
            
            // Surface token pairs
            _buildTokenPairSection('Surface Colors', [
              _buildTokenPair('surface', 'onSurface', 
                Theme.of(context).colorScheme.surface, 
                Theme.of(context).colorScheme.onSurface),
              _buildTokenPair('surfaceVariant', 'onSurfaceVariant', 
                Theme.of(context).colorScheme.surfaceContainerHighest, 
                Theme.of(context).colorScheme.onSurfaceVariant),
              _buildTokenPair('inverseSurface', 'onInverseSurface', 
                Theme.of(context).colorScheme.inverseSurface, 
                Theme.of(context).colorScheme.onInverseSurface),
            ]),
            
            const SizedBox(height: 12),
            
            // Custom token pairs
            Consumer<CustomTokenService>(
              builder: (context, customTokenService, child) {
                final customPairs = _getCustomTokenPairs(customTokenService);
                if (customPairs.isEmpty) return const SizedBox.shrink();
                return _buildCustomTokenPairSection(customPairs);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTokenPairSection(String title, List<Widget> pairs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 8),
        ...pairs,
      ],
    );
  }

  Widget _buildTokenPair(String backgroundToken, String foregroundToken, 
      Color backgroundColor, Color foregroundColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  backgroundToken,
                  style: TextStyle(
                    color: foregroundColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Background token',
                  style: TextStyle(
                    color: foregroundColor.withValues(alpha: 0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 2,
            height: 32,
            color: foregroundColor.withValues(alpha: 0.3),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  foregroundToken,
                  style: TextStyle(
                    color: foregroundColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Foreground token',
                  style: TextStyle(
                    color: foregroundColor.withValues(alpha: 0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getCustomTokenPairs(CustomTokenService service) {
    final tokens = service.customTokens;
    final pairs = <Map<String, dynamic>>[];
    
    // Create a map for easy lookup
    final tokenMap = <String, dynamic>{};
    for (final token in tokens) {
      tokenMap[token.name] = token;
    }
    
    // Define known token pair patterns
    final pairPatterns = [
      {'base': 'critical', 'on': 'onCritical'},
      {'base': 'warning', 'on': 'onWarning'},
      {'base': 'success', 'on': 'onSuccess'},
      {'base': 'information', 'on': 'onInformation'},
      {'base': 'defaultColor', 'on': 'onDefault'},
      {'base': 'warningContainer', 'on': 'onWarningContainer'},
      {'base': 'successContainer', 'on': 'onSuccessContainer'},
      {'base': 'informationContainer', 'on': 'onInformationContainer'},
      {'base': 'defaultContainer', 'on': 'onDefaultContainer'},
    ];
    
    // Find matching pairs
    for (final pattern in pairPatterns) {
      final baseToken = tokenMap[pattern['base']];
      final onToken = tokenMap[pattern['on']];
      
      if (baseToken != null && onToken != null) {
        pairs.add({
          'baseToken': baseToken,
          'onToken': onToken,
          'baseName': pattern['base'],
          'onName': pattern['on'],
        });
      }
    }
    
    return pairs;
  }

  Widget _buildCustomTokenPairSection(List<Map<String, dynamic>> pairs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Custom Token Pairs',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 8),
        ...pairs.map((pair) {
          final baseToken = pair['baseToken'];
          final onToken = pair['onToken'];
          final isDark = Theme.of(context).brightness == Brightness.dark;
          final backgroundColor = isDark ? baseToken.darkValue : baseToken.lightValue;
          final foregroundColor = isDark ? onToken.darkValue : onToken.lightValue;
          
          return _buildTokenPair(
            pair['baseName'],
            pair['onName'],
            backgroundColor,
            foregroundColor,
          );
        }),
      ],
    );
  }

  Color _getContrastColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
