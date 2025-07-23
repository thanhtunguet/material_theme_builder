import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/custom_color_token.dart';
import '../services/custom_token_service.dart';
import 'color_picker_widget.dart';

class CustomTokenEditor extends StatefulWidget {
  const CustomTokenEditor({super.key});

  @override
  State<CustomTokenEditor> createState() => _CustomTokenEditorState();
}

class _CustomTokenEditorState extends State<CustomTokenEditor> {
  bool _isExpanded = false;
  bool _showPredefined = true;
  bool _showCustom = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomTokenService>(
      builder: (context, tokenService, child) {
        return Card(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.extension),
                title: const Text('Custom Color Tokens'),
                subtitle:
                    Text('${tokenService.customTokens.length} custom tokens'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () =>
                          _showAddTokenDialog(context, tokenService),
                      tooltip: 'Add Custom Token',
                    ),
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert),
                      onSelected: (value) =>
                          _handleMenuAction(value, tokenService),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'reset_predefined',
                          child: ListTile(
                            leading: Icon(Icons.refresh),
                            title: Text('Reset Predefined Tokens'),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(
                          _isExpanded ? Icons.expand_less : Icons.expand_more),
                      onPressed: () =>
                          setState(() => _isExpanded = !_isExpanded),
                    ),
                  ],
                ),
                onTap: () => setState(() => _isExpanded = !_isExpanded),
              ),
              if (_isExpanded) ...[
                const Divider(height: 1),
                _buildFilterChips(),
                if (tokenService.customTokens.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Icon(Icons.palette_outlined,
                            size: 48, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'No custom tokens yet',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Add custom color tokens that will be included in your ThemeExtension',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                else
                  _buildTokensList(tokenService),
                const SizedBox(height: 16),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          FilterChip(
            label: const Text('Predefined'),
            selected: _showPredefined,
            onSelected: (value) => setState(() => _showPredefined = value),
          ),
          const SizedBox(width: 8),
          FilterChip(
            label: const Text('Custom'),
            selected: _showCustom,
            onSelected: (value) => setState(() => _showCustom = value),
          ),
        ],
      ),
    );
  }

  Widget _buildTokensList(CustomTokenService tokenService) {
    final filteredTokens = tokenService.customTokens.where((token) {
      if (token.isPredefined && !_showPredefined) return false;
      if (!token.isPredefined && !_showCustom) return false;
      return true;
    }).toList();

    if (filteredTokens.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Text(
          'No tokens match the current filter',
          style: TextStyle(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      );
    }

    final predefinedTokens =
        filteredTokens.where((token) => token.isPredefined).toList();
    final customTokens =
        filteredTokens.where((token) => !token.isPredefined).toList();

    return Column(
      children: [
        if (predefinedTokens.isNotEmpty && _showPredefined) ...[
          _buildSectionHeader('Predefined Tokens', predefinedTokens.length),
          ...predefinedTokens.map((token) => _CustomTokenTile(
                token: token,
                onEdit: () =>
                    _showEditTokenDialog(context, tokenService, token),
                onDelete: tokenService.canRemoveToken(token.id)
                    ? () => _showDeleteDialog(context, tokenService, token)
                    : null,
              )),
        ],
        if (customTokens.isNotEmpty && _showCustom) ...[
          if (predefinedTokens.isNotEmpty) const Divider(),
          _buildSectionHeader('Custom Tokens', customTokens.length),
          ...customTokens.map((token) => _CustomTokenTile(
                token: token,
                onEdit: () =>
                    _showEditTokenDialog(context, tokenService, token),
                onDelete: () => _showDeleteDialog(context, tokenService, token),
              )),
        ],
      ],
    );
  }

  Widget _buildSectionHeader(String title, int count) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              count.toString(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleMenuAction(String action, CustomTokenService tokenService) {
    switch (action) {
      case 'reset_predefined':
        _showResetPredefinedDialog(context, tokenService);
        break;
    }
  }

  void _showResetPredefinedDialog(
      BuildContext context, CustomTokenService tokenService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Predefined Tokens'),
        content: const Text(
          'This will reset all predefined tokens to their default values. Any modifications you made to predefined tokens will be lost.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              tokenService.resetPredefinedTokens();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Predefined tokens have been reset')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.orange),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  void _showAddTokenDialog(
      BuildContext context, CustomTokenService tokenService) {
    showDialog(
      context: context,
      builder: (context) => _TokenDialog(
        title: 'Add Custom Token',
        onSave: (name, description, lightColor, darkColor) {
          tokenService.createToken(
            name: name,
            description: description,
            lightValue: lightColor,
            darkValue: darkColor,
          );
        },
        validateName: (name) => tokenService.getTokenValidationErrors(name),
      ),
    );
  }

  void _showEditTokenDialog(BuildContext context,
      CustomTokenService tokenService, CustomColorToken token) {
    showDialog(
      context: context,
      builder: (context) => _TokenDialog(
        title: 'Edit Custom Token',
        initialToken: token,
        onSave: (name, description, lightColor, darkColor) {
          tokenService.updateToken(token.copyWith(
            name: name,
            description: description,
            lightValue: lightColor,
            darkValue: darkColor,
          ));
        },
        validateName: (name) =>
            tokenService.getTokenValidationErrors(name, excludeId: token.id),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, CustomTokenService tokenService,
      CustomColorToken token) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Custom Token'),
        content: Text('Are you sure you want to delete "${token.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              tokenService.removeToken(token.id);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _CustomTokenTile extends StatelessWidget {
  final CustomColorToken token;
  final VoidCallback onEdit;
  final VoidCallback? onDelete;

  const _CustomTokenTile({
    required this.token,
    required this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Expanded(child: Text(token.name)),
          if (token.isPredefined)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .secondary
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'PREDEFINED',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (token.description.isNotEmpty) Text(token.description),
          const SizedBox(height: 4),
          Text(
            'Variable: ${token.dartVariableName}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                  color: Colors.grey[600],
                ),
          ),
        ],
      ),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 20,
            height: 10,
            decoration: BoxDecoration(
              color: token.lightValue,
              border: Border.all(color: Colors.grey[300]!),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(2)),
            ),
          ),
          Container(
            width: 20,
            height: 10,
            decoration: BoxDecoration(
              color: token.darkValue,
              border: Border.all(color: Colors.grey[300]!),
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(2)),
            ),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit, size: 20),
            onPressed: onEdit,
            tooltip: 'Edit',
          ),
          if (onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete, size: 20),
              onPressed: onDelete,
              tooltip: 'Delete',
            ),
        ],
      ),
    );
  }
}

class _TokenDialog extends StatefulWidget {
  final String title;
  final CustomColorToken? initialToken;
  final Function(
          String name, String description, Color lightColor, Color darkColor)
      onSave;
  final List<String> Function(String name) validateName;

  const _TokenDialog({
    required this.title,
    this.initialToken,
    required this.onSave,
    required this.validateName,
  });

  @override
  State<_TokenDialog> createState() => _TokenDialogState();
}

class _TokenDialogState extends State<_TokenDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late Color _lightColor;
  late Color _darkColor;
  List<String> _nameErrors = [];

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.initialToken?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.initialToken?.description ?? '');
    _lightColor = widget.initialToken?.lightValue ?? Colors.blue;
    _darkColor = widget.initialToken?.darkValue ?? Colors.blue[300]!;

    _nameController.addListener(_validateName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _validateName() {
    setState(() {
      _nameErrors = widget.validateName(_nameController.text);
    });
  }

  bool get _isValid =>
      _nameErrors.isEmpty && _nameController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Token Name',
                helperText: 'e.g., "Brand Primary", "Success Color"',
                errorText: _nameErrors.isNotEmpty ? _nameErrors.first : null,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                helperText: 'Describe how this color should be used',
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Light Theme Color',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () => _pickColor(context, _lightColor,
                            (color) => setState(() => _lightColor = color)),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: _lightColor,
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Center(
                            child: Icon(Icons.colorize, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Dark Theme Color',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () => _pickColor(context, _darkColor,
                            (color) => setState(() => _darkColor = color)),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: _darkColor,
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Center(
                            child: Icon(Icons.colorize, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isValid
              ? () {
                  widget.onSave(
                    _nameController.text.trim(),
                    _descriptionController.text.trim(),
                    _lightColor,
                    _darkColor,
                  );
                  Navigator.pop(context);
                }
              : null,
          child: const Text('Save'),
        ),
      ],
    );
  }

  void _pickColor(BuildContext context, Color currentColor,
      ValueChanged<Color> onColorChanged) {
    showDialog(
      context: context,
      builder: (context) => ColorPickerWidget(
        initialColor: currentColor,
        onColorChanged: onColorChanged,
      ),
    );
  }
}
