import 'package:flutter/material.dart';

import 'core/ui/theme/theme_config.dart';
import 'pages/asset/asset_page.dart';
import 'pages/home/home_page.dart';

class TractianApp extends StatelessWidget {
  const TractianApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tractian',
      debugShowCheckedModeBanner: false,
      theme: ThemeConfig.theme,
      initialRoute: '/asset',
      routes: {
        '/home': (_) => const HomePage(),
        // '/asset': (_) => const AssetPage(),
        '/asset': (_) => const AssetPage(),
      },
    );
  }
}
