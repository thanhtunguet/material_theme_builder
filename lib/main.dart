import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/theme_builder_screen.dart';
import 'services/custom_token_service.dart';

void main() {
  runApp(const MaterialThemeBuilderApp());
}

class MaterialThemeBuilderApp extends StatelessWidget {
  const MaterialThemeBuilderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CustomTokenService(),
      child: MaterialApp(
        title: 'Material Theme Builder',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const ThemeBuilderScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
