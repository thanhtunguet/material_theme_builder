import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import '../services/color_utils.dart';

class SeedColorInput extends StatelessWidget {
  final String label;
  final String description;
  final Color value;
  final ValueChanged<Color> onChanged;
  final VoidCallback? onReset;

  const SeedColorInput({
    super.key,
    required this.label,
    required this.description,
    required this.value,
    required this.onChanged,
    this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
                if (onReset != null)
                  IconButton(
                    onPressed: onReset,
                    icon: const Icon(Icons.refresh),
                    tooltip: 'Reset to default',
                  ),
              ],
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => _showColorPicker(context),
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: value,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    _colorToHex(value),
                    style: TextStyle(
                      color: _getContrastingColor(value),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
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

  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pick $label Color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            color: value,
            onColorChanged: onChanged,
            width: 40,
            height: 40,
            borderRadius: 8,
            spacing: 5,
            runSpacing: 5,
            wheelDiameter: 200,
            heading: Text(
              'Select color',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            subheading: Text(
              'Select color shade',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            wheelSubheading: Text(
              'Selected color and its shades',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            showMaterialName: true,
            showColorName: true,
            showColorCode: true,
            copyPasteBehavior: const ColorPickerCopyPasteBehavior(
              longPressMenu: true,
            ),
            materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
            colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
            colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
            pickersEnabled: const <ColorPickerType, bool>{
              ColorPickerType.both: false,
              ColorPickerType.primary: true,
              ColorPickerType.accent: true,
              ColorPickerType.bw: false,
              ColorPickerType.custom: true,
              ColorPickerType.wheel: true,
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  String _colorToHex(Color color) {
    return ColorUtils.colorToHex(color);
  }

  Color _getContrastingColor(Color color) {
    final luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}

class SeedColorsPanel extends StatelessWidget {
  final Color primarySeed;
  final Color secondarySeed;
  final Color tertiarySeed;
  final Color neutralSeed;
  final ValueChanged<Color> onPrimaryChanged;
  final ValueChanged<Color> onSecondaryChanged;
  final ValueChanged<Color> onTertiaryChanged;
  final ValueChanged<Color> onNeutralChanged;
  final VoidCallback? onResetAll;

  const SeedColorsPanel({
    super.key,
    required this.primarySeed,
    required this.secondarySeed,
    required this.tertiarySeed,
    required this.neutralSeed,
    required this.onPrimaryChanged,
    required this.onSecondaryChanged,
    required this.onTertiaryChanged,
    required this.onNeutralChanged,
    this.onResetAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Seed Colors',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            if (onResetAll != null)
              OutlinedButton.icon(
                onPressed: onResetAll,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset All'),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'These colors will be used to generate your complete Material 3 color scheme',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: MediaQuery.of(context).size.width > 800 ? 2 : 1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: MediaQuery.of(context).size.width > 800 ? 3.2 : 3.8,
          children: [
            SeedColorInput(
              label: 'Primary',
              description: 'Main brand color used throughout the interface',
              value: primarySeed,
              onChanged: onPrimaryChanged,
              onReset: () => onPrimaryChanged(Colors.blue),
            ),
            SeedColorInput(
              label: 'Secondary',
              description: 'Accent color that complements the primary color',
              value: secondarySeed,
              onChanged: onSecondaryChanged,
              onReset: () => onSecondaryChanged(Colors.blueAccent),
            ),
            SeedColorInput(
              label: 'Tertiary',
              description: 'Additional color for contrast and variety',
              value: tertiarySeed,
              onChanged: onTertiaryChanged,
              onReset: () => onTertiaryChanged(Colors.lightBlue),
            ),
            SeedColorInput(
              label: 'Neutral',
              description: 'Neutral color used for surfaces and backgrounds',
              value: neutralSeed,
              onChanged: onNeutralChanged,
              onReset: () => onNeutralChanged(Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
