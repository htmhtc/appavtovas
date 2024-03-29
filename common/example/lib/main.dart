import 'package:common/avtovas_common.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AppExample());
}

final class AppExample extends StatelessWidget {
  const AppExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      theme: lightTheme,
      themeData: generateThemeData(lightTheme),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            localizationsDelegates: AvtovasLocalization.localizationsDelegates,
            supportedLocales: AvtovasLocalization.supportedLocales,
            home: const Placeholder(),
            theme: context.themeData,
          );
        },
      ),
    );
  }
}
