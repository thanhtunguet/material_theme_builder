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

  const TokenEditor({
    super.key,
    required this.lightTokens,
    required this.darkTokens,
    required this.isDarkMode,
    required this.onTokenChanged,
    required this.onTokenReset,
  });

  @override
  State<TokenEditor> createState() => _TokenEditorState();
}

class _TokenEditorState extends State<TokenEditor> {
  final Map<String, bool> _expandedCategories = {
    for (String category in MaterialTokens.tokenCategories.keys) category: false
  };

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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: MaterialTokens.tokenCategories.entries.map((entry) {
                    return _buildCategorySection(entry.key, entry.value);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(String category, List<String> tokens) {
    final isExpanded = _expandedCategories[category] ?? false;
    final currentTokens =
        widget.isDarkMode ? widget.darkTokens : widget.lightTokens;

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
                children: tokens.map((tokenName) {
                  final token = currentTokens[tokenName];
                  if (token == null) return const SizedBox.shrink();

                  return _buildTokenRow(tokenName, token);
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTokenRow(String tokenName, ColorToken token) {
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
                      widget.onTokenChanged(
                          tokenName, color, widget.isDarkMode);
                    },
                    showLabel: false,
                  ),
                ),
                const SizedBox(width: 8),
                if (token.isCustomized)
                  IconButton(
                    onPressed: () {
                      widget.onTokenReset(tokenName, widget.isDarkMode);
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
                  : Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
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
