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
                subtitle: Text('${tokenService.customTokens.length} custom tokens'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => _showAddTokenDialog(context, tokenService),
                      tooltip: 'Add Custom Token',
                    ),
                    IconButton(
                      icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                      onPressed: () => setState(() => _isExpanded = !_isExpanded),
                    ),
                  ],
                ),
                onTap: () => setState(() => _isExpanded = !_isExpanded),
              ),
              if (_isExpanded) ...[
                const Divider(height: 1),
                if (tokenService.customTokens.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Icon(Icons.palette_outlined, size: 48, color: Colors.grey),
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: tokenService.customTokens.length,
                    itemBuilder: (context, index) {
                      final token = tokenService.customTokens[index];
                      return _CustomTokenTile(
                        token: token,
                        onEdit: () => _showEditTokenDialog(context, tokenService, token),
                        onDelete: () => _showDeleteDialog(context, tokenService, token),
                      );
                    },
                  ),
                const SizedBox(height: 16),
              ],
            ],
          ),
        );
      },
    );
  }

  void _showAddTokenDialog(BuildContext context, CustomTokenService tokenService) {
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

  void _showEditTokenDialog(BuildContext context, CustomTokenService tokenService, CustomColorToken token) {
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
        validateName: (name) => tokenService.getTokenValidationErrors(name, excludeId: token.id),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, CustomTokenService tokenService, CustomColorToken token) {
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
  final VoidCallback onDelete;

  const _CustomTokenTile({
    required this.token,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(token.name),
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
              borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
            ),
          ),
          Container(
            width: 20,
            height: 10,
            decoration: BoxDecoration(
              color: token.darkValue,
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(2)),
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
  final Function(String name, String description, Color lightColor, Color darkColor) onSave;
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
    _nameController = TextEditingController(text: widget.initialToken?.name ?? '');
    _descriptionController = TextEditingController(text: widget.initialToken?.description ?? '');
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

  bool get _isValid => _nameErrors.isEmpty && _nameController.text.trim().isNotEmpty;

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
                      const Text('Light Theme Color', style: TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () => _pickColor(context, _lightColor, (color) => setState(() => _lightColor = color)),
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
                      const Text('Dark Theme Color', style: TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () => _pickColor(context, _darkColor, (color) => setState(() => _darkColor = color)),
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
          onPressed: _isValid ? () {
            widget.onSave(
              _nameController.text.trim(),
              _descriptionController.text.trim(),
              _lightColor,
              _darkColor,
            );
            Navigator.pop(context);
          } : null,
          child: const Text('Save'),
        ),
      ],
    );
  }

  void _pickColor(BuildContext context, Color currentColor, ValueChanged<Color> onColorChanged) {
    showDialog(
      context: context,
      builder: (context) => ColorPickerWidget(
        initialColor: currentColor,
        onColorChanged: onColorChanged,
      ),
    );
  }
}