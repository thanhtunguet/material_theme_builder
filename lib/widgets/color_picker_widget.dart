import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../services/color_utils.dart';

class ColorPickerWidget extends StatefulWidget {
  final Color initialColor;
  final ValueChanged<Color> onColorChanged;
  final String title;

  const ColorPickerWidget({
    Key? key,
    required this.initialColor,
    required this.onColorChanged,
    this.title = 'Pick a color',
  }) : super(key: key);

  @override
  State<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ColorPicker(
          pickerColor: _selectedColor,
          onColorChanged: (color) {
            setState(() {
              _selectedColor = color;
            });
            widget.onColorChanged(color);
          },
          colorPickerWidth: 300,
          pickerAreaHeightPercent: 0.7,
          enableAlpha: false,
          displayThumbColor: true,
          paletteType: PaletteType.hslWithHue,
          labelTypes: const [
            ColorLabelType.rgb,
            ColorLabelType.hsv,
            ColorLabelType.hsl,
          ],
          pickerAreaBorderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        const SizedBox(height: 16),
        Container(
          width: 100,
          height: 40,
          decoration: BoxDecoration(
            color: _selectedColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              _colorToHex(_selectedColor),
              style: TextStyle(
                color: _getContrastingColor(_selectedColor),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
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

class CompactColorPicker extends StatelessWidget {
  final Color color;
  final ValueChanged<Color> onColorChanged;
  final String? label;
  final bool showLabel;

  const CompactColorPicker({
    Key? key,
    required this.color,
    required this.onColorChanged,
    this.label,
    this.showLabel = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showColorPicker(context),
      child: Container(
        height: showLabel ? 60 : 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 1,
          ),
        ),
        child: showLabel
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (label != null) ...[
                    Text(
                      label!,
                      style: TextStyle(
                        color: _getContrastingColor(color),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                  ],
                  Text(
                    _colorToHex(color),
                    style: TextStyle(
                      color: _getContrastingColor(color),
                      fontSize: 10,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              )
            : Center(
                child: Icon(
                  Icons.colorize,
                  color: _getContrastingColor(color),
                  size: 20,
                ),
              ),
      ),
    );
  }

  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(label != null ? 'Pick $label Color' : 'Pick Color'),
        content: SingleChildScrollView(
          child: ColorPickerWidget(
            initialColor: color,
            onColorChanged: onColorChanged,
            title: '',
          ),
        ),
        actions: [
          TextButton(
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