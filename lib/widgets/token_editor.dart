import 'package:flutter/material.dart';

import '../constants/material_tokens.dart';
import '../models/color_token.dart';
import 'color_picker_widget.dart';

class TokenEditor extends StatefulWidget {
  final Map<String, ColorToken> lightTokens;
  final Map<String, ColorToken> darkTokens;
  final bool isDarkMode;
  final Function(String tokenName, Color color, bool isDark) onTokenChanged;
  final Function(String tokenName, bool isDark) onTokenReset;
  final Function(String category, bool isDark)? onCategoryAutoCalculate;

  const TokenEditor({
    super.key,
    required this.lightTokens,
    required this.darkTokens,
    required this.isDarkMode,
    required this.onTokenChanged,
    required this.onTokenReset,
    this.onCategoryAutoCalculate,
  });

  @override
  State<TokenEditor> createState() => _TokenEditorState();
}

class _TokenEditorState extends State<TokenEditor> {
  final Map<String, bool> _expandedCategories = {
    for (String category in MaterialTokens.tokenCategories.keys) category: false
  };
  bool _showBothModes = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Token Editor',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Row(
                  children: [
                    if (!_showBothModes) ...[
                      Text(
                        widget.isDarkMode ? 'Dark' : 'Light',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: widget.isDarkMode
                              ? Colors.grey[800]
                              : Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                    FilterChip(
                      label: Text(_showBothModes ? 'Light & Dark' : 'Single Mode'),
                      selected: _showBothModes,
                      onSelected: (value) => setState(() => _showBothModes = value),
                      avatar: Icon(
                        _showBothModes ? Icons.compare : Icons.brightness_4,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Customize individual color tokens or use the generated values',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 24),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: MaterialTokens.tokenCategories.entries.map((entry) {
                return _buildCategorySection(entry.key, entry.value);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(String category, List<String> tokens) {
    final isExpanded = _expandedCategories[category] ?? false;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _expandedCategories[category] = !isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    category,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const Spacer(),
                  if (widget.onCategoryAutoCalculate != null) ...[
                    TextButton.icon(
                      onPressed: () => _showAutoCalculateDialog(category),
                      icon: const Icon(Icons.auto_fix_high, size: 16),
                      label: const Text('Auto'),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${tokens.length}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  if (_showBothModes) ...[
                    // Show both light and dark pickers in each row
                    ...tokens.map((tokenName) {
                      final lightToken = widget.lightTokens[tokenName];
                      final darkToken = widget.darkTokens[tokenName];
                      if (lightToken == null || darkToken == null) return const SizedBox.shrink();
                      return _buildDualTokenRow(tokenName, lightToken, darkToken);
                    }),
                  ] else ...[
                    ...tokens.map((tokenName) {
                      final currentTokens = widget.isDarkMode ? widget.darkTokens : widget.lightTokens;
                      final token = currentTokens[tokenName];
                      if (token == null) return const SizedBox.shrink();
                      return _buildTokenRow(tokenName, token, widget.isDarkMode);
                    }),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTokenRow(String tokenName, ColorToken token, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tokenName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  token.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: CompactColorPicker(
                    color: token.effectiveValue,
                    onColorChanged: (color) {
                      widget.onTokenChanged(tokenName, color, isDark);
                    },
                    showLabel: false,
                  ),
                ),
                const SizedBox(width: 8),
                if (token.isCustomized)
                  IconButton(
                    onPressed: () {
                      widget.onTokenReset(tokenName, isDark);
                    },
                    icon: Icon(
                      Icons.refresh,
                      size: 18,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    tooltip: 'Reset to generated',
                    visualDensity: VisualDensity.compact,
                  )
                else
                  const SizedBox(width: 48),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: token.isCustomized
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context)
                      .colorScheme
                      .outline
                      .withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDualTokenRow(String tokenName, ColorToken lightToken, ColorToken darkToken) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tokenName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  lightToken.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Light mode color picker
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Light',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: CompactColorPicker(
                        color: lightToken.effectiveValue,
                        onColorChanged: (color) {
                          widget.onTokenChanged(tokenName, color, false);
                        },
                        showLabel: false,
                      ),
                    ),
                    const SizedBox(width: 4),
                    if (lightToken.isCustomized)
                      IconButton(
                        onPressed: () {
                          widget.onTokenReset(tokenName, false);
                        },
                        icon: Icon(
                          Icons.refresh,
                          size: 14,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        tooltip: 'Reset light to generated',
                        visualDensity: VisualDensity.compact,
                      )
                    else
                      const SizedBox(width: 32),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: lightToken.isCustomized
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context)
                                .colorScheme
                                .outline
                                .withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Dark mode color picker
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Dark',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: CompactColorPicker(
                        color: darkToken.effectiveValue,
                        onColorChanged: (color) {
                          widget.onTokenChanged(tokenName, color, true);
                        },
                        showLabel: false,
                      ),
                    ),
                    const SizedBox(width: 4),
                    if (darkToken.isCustomized)
                      IconButton(
                        onPressed: () {
                          widget.onTokenReset(tokenName, true);
                        },
                        icon: Icon(
                          Icons.refresh,
                          size: 14,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        tooltip: 'Reset dark to generated',
                        visualDensity: VisualDensity.compact,
                      )
                    else
                      const SizedBox(width: 32),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: darkToken.isCustomized
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context)
                                .colorScheme
                                .outline
                                .withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  void _showAutoCalculateDialog(String category) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Auto-Calculate $category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Choose which theme mode to auto-calculate:'),
            const SizedBox(height: 16),
            ListTile(
              leading: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                ),
              ),
              title: const Text('Light Mode Only'),
              subtitle: const Text('Reset light theme tokens to generated values'),
              onTap: () {
                Navigator.of(context).pop();
                widget.onCategoryAutoCalculate?.call(category, false);
              },
            ),
            ListTile(
              leading: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  shape: BoxShape.circle,
                ),
              ),
              title: const Text('Dark Mode Only'),
              subtitle: const Text('Reset dark theme tokens to generated values'),
              onTap: () {
                Navigator.of(context).pop();
                widget.onCategoryAutoCalculate?.call(category, true);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.compare),
              title: const Text('Both Modes'),
              subtitle: const Text('Reset both light and dark theme tokens'),
              onTap: () {
                Navigator.of(context).pop();
                widget.onCategoryAutoCalculate?.call(category, false);
                widget.onCategoryAutoCalculate?.call(category, true);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}

class TokenCategoryCard extends StatelessWidget {
  final String category;
  final List<String> tokens;
  final Map<String, ColorToken> currentTokens;
  final Function(String tokenName, Color color) onTokenChanged;
  final Function(String tokenName) onTokenReset;

  const TokenCategoryCard({
    super.key,
    required this.category,
    required this.tokens,
    required this.currentTokens,
    required this.onTokenChanged,
    required this.onTokenReset,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(
          category,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: Text('${tokens.length} tokens'),
        children: tokens.map((tokenName) {
          final token = currentTokens[tokenName];
          if (token == null) return const SizedBox.shrink();

          return ListTile(
            title: Text(tokenName),
            subtitle: Text(
              token.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            leading: CompactColorPicker(
              color: token.effectiveValue,
              onColorChanged: (color) => onTokenChanged(tokenName, color),
              showLabel: false,
            ),
            trailing: token.isCustomized
                ? IconButton(
                    onPressed: () => onTokenReset(tokenName),
                    icon: const Icon(Icons.refresh),
                    tooltip: 'Reset to default',
                  )
                : null,
          );
        }).toList(),
      ),
    );
  }
}
