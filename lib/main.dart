import 'package:bookia/core/services/api/api_provider.dart';
import 'package:bookia/core/services/cashing/caching.dart';
import 'package:bookia/core/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:bookia/core/routes/routes.dart';

Future<void> main() async {
  ApiProvider.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Caching().init();
  runApp(const Bookia());
}

class Bookia extends StatelessWidget {
  const Bookia({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Routes.routes,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
    );
  }
}
