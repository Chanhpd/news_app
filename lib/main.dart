import 'package:flutter/material.dart';
import 'core/di/injection.dart';
import 'core/utils/logger.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize dependencies
    await configureDependencies();
    logger.success('Dependencies configured successfully');

    runApp(const NewsApp());
  } catch (e, stackTrace) {
    logger.e('Error initializing app: $e\nStackTrace: $stackTrace');
    runApp(const ErrorApp());
  }
}

class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text('Failed to initialize app'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Restart the app
                },
                child: const Text('Restart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
