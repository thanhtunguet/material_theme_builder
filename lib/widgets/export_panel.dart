import 'package:flutter/material.dart';
import '../models/theme_data_model.dart';
import '../services/export_service.dart';

class ExportPanel extends StatelessWidget {
  final ThemeDataModel themeModel;

  const ExportPanel({
    Key? key,
    required this.themeModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Export Theme',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Download your theme in various formats for different use cases',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: MediaQuery.of(context).size.width > 800 ? 2 : 1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: MediaQuery.of(context).size.width > 800 ? 3 : 4,
              children: [
                _buildExportCard(
                  context,
                  title: 'Flutter ThemeData',
                  description: 'Complete Dart code ready for Flutter projects',
                  icon: Icons.code,
                  onPressed: () => _exportFlutterTheme(context),
                ),
                _buildExportCard(
                  context,
                  title: 'JSON',
                  description: 'Structured color data for custom implementations',
                  icon: Icons.data_object,
                  onPressed: () => _exportJson(context),
                ),
                _buildExportCard(
                  context,
                  title: 'CSS Custom Properties',
                  description: 'CSS variables for web integration',
                  icon: Icons.web,
                  onPressed: () => _exportCss(context),
                ),
                _buildExportCard(
                  context,
                  title: 'Design Tokens',
                  description: 'Design system format for cross-platform use',
                  icon: Icons.palette,
                  onPressed: () => _exportDesignTokens(context),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildThemeInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildExportCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Card(
      elevation: 1,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.download,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Theme Information',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _buildInfoRow(context, 'Name', themeModel.name),
          _buildInfoRow(context, 'Description', themeModel.description.isEmpty ? 'No description' : themeModel.description),
          _buildInfoRow(context, 'Created', _formatDate(themeModel.createdAt)),
          _buildInfoRow(context, 'Updated', _formatDate(themeModel.updatedAt)),
          _buildInfoRow(context, 'Light Tokens', '${themeModel.colorSchemeModel.lightTokens.length}'),
          _buildInfoRow(context, 'Dark Tokens', '${themeModel.colorSchemeModel.darkTokens.length}'),
          _buildInfoRow(context, 'Customized Light', '${themeModel.colorSchemeModel.lightTokens.values.where((t) => t.isCustomized).length}'),
          _buildInfoRow(context, 'Customized Dark', '${themeModel.colorSchemeModel.darkTokens.values.where((t) => t.isCustomized).length}'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _exportFlutterTheme(BuildContext context) async {
    try {
      _showLoadingSnackBar(context, 'Exporting Flutter theme...');
      await ExportService.exportAsFlutterThemeData(themeModel);
      _showSuccessSnackBar(context, 'Flutter theme exported successfully!');
    } catch (e) {
      _showErrorSnackBar(context, 'Failed to export Flutter theme: ${e.toString()}');
    }
  }

  Future<void> _exportJson(BuildContext context) async {
    try {
      _showLoadingSnackBar(context, 'Exporting JSON...');
      await ExportService.exportAsJson(themeModel);
      _showSuccessSnackBar(context, 'JSON exported successfully!');
    } catch (e) {
      _showErrorSnackBar(context, 'Failed to export JSON: ${e.toString()}');
    }
  }

  Future<void> _exportCss(BuildContext context) async {
    try {
      _showLoadingSnackBar(context, 'Exporting CSS...');
      await ExportService.exportAsCssCustomProperties(themeModel);
      _showSuccessSnackBar(context, 'CSS exported successfully!');
    } catch (e) {
      _showErrorSnackBar(context, 'Failed to export CSS: ${e.toString()}');
    }
  }

  Future<void> _exportDesignTokens(BuildContext context) async {
    try {
      _showLoadingSnackBar(context, 'Exporting design tokens...');
      await ExportService.exportAsDesignTokens(themeModel);
      _showSuccessSnackBar(context, 'Design tokens exported successfully!');
    } catch (e) {
      _showErrorSnackBar(context, 'Failed to export design tokens: ${e.toString()}');
    }
  }

  void _showLoadingSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(width: 12),
            Text(message),
          ],
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 16,
            ),
            const SizedBox(width: 12),
            Text(message),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.error,
              color: Theme.of(context).colorScheme.onError,
              size: 16,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
        duration: const Duration(seconds: 5),
      ),
    );
  }
}