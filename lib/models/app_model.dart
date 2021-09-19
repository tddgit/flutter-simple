import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum MAIN_SCREEN {
  settings,
  conversion,
  reorderProperties,
  reorderUnits,
}

class AppModel with ChangeNotifier {
  final List<int> _conversionsOrderDrawer = List.generate(19, (index) => index);
  MAIN_SCREEN _currentScreen = MAIN_SCREEN.conversion;
  int _currentPage = 0;
  ThemeMode _currentThemeMode = ThemeMode.system;
  bool _isDarkAmoled = false;

  final Map<ThemeMode, int> _themeModeMap = {
    ThemeMode.system: 0,
    ThemeMode.dark: 1,
    ThemeMode.light: 2,
  };

  final Map<Locale, String> mapLocale = {
    const Locale('en'): 'English',
    const Locale('de'): 'Deutsch',
    const Locale('es'): 'Español',
    const Locale('fr'): 'Français',
    const Locale('hr'): 'Hrvatski',
    const Locale('it'): 'Italiano',
    const Locale('nb'): 'Norsk',
    const Locale('pt'): 'Português',
    const Locale('ru'): 'Pусский',
    const Locale('tr'): 'Türk',
  };
}
