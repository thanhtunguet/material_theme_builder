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
                        child: const _MobilePreview(),
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

    final customExtension = isDarkMode
        ? customTokenService.buildDarkExtension()
        : customTokenService.buildLightExtension();

    return baseTheme.copyWith(
      extensions: <ThemeExtension<dynamic>>[
        customExtension,
      ],
    );
  }
}

class _MobilePreview extends StatefulWidget {
  const _MobilePreview();

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
                  child: FilledButton(
                    onPressed: () {},
                    child: const Text('Filled'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
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
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Text'),
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

  Color _getContrastColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
