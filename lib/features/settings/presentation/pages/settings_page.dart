import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          _buildSection(
            context,
            'Appearance',
            [
              ListTile(
                leading: const Icon(Icons.brightness_6),
                title: const Text('Theme'),
                subtitle: const Text('Light / Dark / System'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Implement theme selection
                },
              ),
            ],
          ),
          _buildSection(
            context,
            'Content',
            [
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text('Country'),
                subtitle: const Text('United States'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Implement country selection
                },
              ),
              ListTile(
                leading: const Icon(Icons.refresh),
                title: const Text('Auto Refresh'),
                subtitle: const Text('Automatically refresh news'),
                trailing: Switch(
                  value: true,
                  onChanged: (value) {
                    // TODO: Implement auto refresh toggle
                  },
                ),
              ),
            ],
          ),
          _buildSection(
            context,
            'Storage',
            [
              ListTile(
                leading: const Icon(Icons.cleaning_services),
                title: const Text('Clear Cache'),
                subtitle: const Text('Free up storage space'),
                onTap: () {
                  // TODO: Implement clear cache
                  _showClearCacheDialog(context);
                },
              ),
            ],
          ),
          _buildSection(
            context,
            'About',
            [
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Version'),
                subtitle: const Text('1.0.0'),
              ),
              ListTile(
                leading: const Icon(Icons.description),
                title: const Text('Privacy Policy'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Open privacy policy
                },
              ),
              ListTile(
                leading: const Icon(Icons.gavel),
                title: const Text('Terms of Service'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Open terms of service
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title.toUpperCase(),
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text('Are you sure you want to clear all cached data?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement clear cache
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache cleared')),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}
