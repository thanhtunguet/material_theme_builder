import 'package:flutter/material.dart';
import '../models/theme_data_model.dart';

class PreviewPanel extends StatelessWidget {
  final ThemeDataModel themeModel;
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const PreviewPanel({
    Key? key,
    required this.themeModel,
    required this.isDarkMode,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = isDarkMode ? themeModel.darkTheme : themeModel.lightTheme;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Preview',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.light_mode,
                      size: 20,
                      color: isDarkMode ? Colors.grey : Theme.of(context).colorScheme.primary,
                    ),
                    Switch(
                      value: isDarkMode,
                      onChanged: onThemeChanged,
                    ),
                    Icon(
                      Icons.dark_mode,
                      size: 20,
                      color: !isDarkMode ? Colors.grey : Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Theme(
                data: themeData,
                child: Builder(
                  builder: (themedContext) => Container(
                    decoration: BoxDecoration(
                      color: themeData.colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildAppBarPreview(themedContext),
                          const SizedBox(height: 24),
                          _buildButtonsPreview(themedContext),
                          const SizedBox(height: 24),
                          _buildCardsPreview(themedContext),
                          const SizedBox(height: 24),
                          _buildInputsPreview(themedContext),
                          const SizedBox(height: 24),
                          _buildColorTokensPreview(themedContext),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBarPreview(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Icon(
              Icons.menu,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(width: 16),
            Text(
              'App Title',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(width: 16),
            Icon(
              Icons.more_vert,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonsPreview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Buttons',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Elevated'),
            ),
            FilledButton(
              onPressed: () {},
              child: const Text('Filled'),
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Outlined'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Text'),
            ),
            FloatingActionButton.small(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCardsPreview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cards',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Card Title',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This is a sample card with some content to show how it looks with the current theme.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Elevated Card',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This card has higher elevation to demonstrate shadows.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInputsPreview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Inputs',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Label',
                  hintText: 'Hint text',
                  helperText: 'Helper text',
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Focused',
                  hintText: 'This field is focused',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildColorTokensPreview(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color Tokens',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildColorToken(context, 'Primary', colorScheme.primary, colorScheme.onPrimary),
            _buildColorToken(context, 'Secondary', colorScheme.secondary, colorScheme.onSecondary),
            _buildColorToken(context, 'Tertiary', colorScheme.tertiary, colorScheme.onTertiary),
            _buildColorToken(context, 'Error', colorScheme.error, colorScheme.onError),
            _buildColorToken(context, 'Surface', colorScheme.surface, colorScheme.onSurface),
            _buildColorToken(context, 'Primary Container', colorScheme.primaryContainer, colorScheme.onPrimaryContainer),
          ],
        ),
      ],
    );
  }

  Widget _buildColorToken(BuildContext context, String label, Color backgroundColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}