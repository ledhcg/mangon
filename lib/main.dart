import 'package:firebase_core/firebase_core.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/src/config/routes/app_pages.dart';
import 'package:rikedu/src/config/routes/routers.dart';
import 'package:rikedu/src/config/themes/themes.dart';
import 'package:rikedu/src/features/authentication/controllers/auth_controller.dart';
import 'package:rikedu/src/features/authentication/providers/auth_provider.dart';
import 'package:rikedu/src/features/authentication/views/login_page.dart';
import 'package:rikedu/src/features/parental_controls/views/app_usage.dart';
import 'package:rikedu/src/features/parental_controls/views/app_usage_screen.dart';
import 'package:rikedu/src/features/performance/screens/performance.dart';
import 'package:rikedu/src/features/settings/controllers/language_controller.dart';
import 'package:rikedu/src/features/settings/controllers/logout_controller.dart';
import 'package:rikedu/src/features/settings/controllers/setting_controller.dart';
import 'package:rikedu/src/features/settings/controllers/theme_controller.dart';
import 'package:rikedu/src/features/settings/providers/locale_provider.dart';
import 'package:rikedu/src/features/settings/providers/theme_provider.dart';
import 'package:rikedu/src/features/chat/views/message.dart';
import 'package:rikedu/src/features/parental_controls/views/location.dart';
import 'package:rikedu/src/features/parental_controls/views/parental_controls_page.dart';
import 'package:rikedu/src/features/settings/views/settings_page.dart';
import 'package:rikedu/src/features/timetable/views/timetable_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:rikedu/src/languages/languages.dart';
import 'package:rikedu/src/utils/service/api_service.dart';
import 'package:rikedu/src/utils/service/storage_service.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  bool isDarkMode = MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .platformBrightness ==
      Brightness.dark;

  Brightness statusBarIconBrightness =
      isDarkMode ? Brightness.light : Brightness.dark;

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: statusBarIconBrightness,
      systemNavigationBarIconBrightness: statusBarIconBrightness,
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ),
  );
  Get.put(ApiService());
  await Get.putAsync<StorageService>(() => StorageService().init());
  initializeDateFormatting('ru_RU');

  final authProvider = AuthProvider();
  final themeProvider = ThemeProvider();
  final localProvider = LocaleProvider();
  await authProvider.init();
  await themeProvider.init();
  await localProvider.init();
  await GetStorage.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // .then((value) => Get.put(AuthenticationRepository()));
  // Intl.defaultLocale = 'ru_RU';

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => themeProvider),
    ChangeNotifierProvider(create: (_) => localProvider),
    ChangeNotifierProvider(create: (_) => authProvider),
  ], child: const MainApp())
      // ChangeNotifierProvider(
      //   create: (_) => themeModeManager,
      //   child: const MainApp(),
      // ),
      );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localProvider = Provider.of<LocaleProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: RikeTheme.lightTheme,
      darkTheme: RikeTheme.darkTheme,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: authProvider.isAuthenticated ? const HomePage() : const LoginPage(),
      // initialRoute: Routes.HOME,
      getPages: AppPages.pages,
      initialBinding: AppBinding(),
      translations: LanguageStrings(),
      locale: localProvider.locale,
      fallbackLocale: localProvider.localeDefault,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _navigationPages = [
    const MainPage(),
    const TimetablePage(),
    const ParentalControlsPage(),
    const SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _navigationPages[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          bottomLeft: Radius.zero,
          bottomRight: Radius.zero,
        ),
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: GNav(
                rippleColor: Theme.of(context).colorScheme.surface,
                hoverColor: Theme.of(context).colorScheme.scrim,
                gap: 8,
                activeColor: Theme.of(context).colorScheme.onPrimary,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Theme.of(context).colorScheme.primary,
                color: Theme.of(context).colorScheme.onBackground,
                tabs: [
                  GButton(
                    icon: FluentIcons.home_24_regular,
                    text: 'Home'.tr,
                  ),
                  GButton(
                    icon: FluentIcons.calendar_ltr_24_regular,
                    text: 'Timetable'.tr,
                  ),
                  GButton(
                    icon: FluentIcons.communication_person_24_regular,
                    text: 'Parental Controls'.tr,
                  ),
                  GButton(
                    icon: FluentIcons.settings_24_regular,
                    text: 'Settings'.tr,
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FilledButton(
            onPressed: () => {Get.toNamed(Routes.LOGIN)},
            child: const Text(
              'Login',
            ),
          ),
          FilledButton(
            onPressed: () => {Get.toNamed(Routes.SETTINGS)},
            child: const Text(
              'Settings',
            ),
          ),
          FilledButton(
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MessageScreen()))
            },
            child: const Text(
              'Message',
            ),
          ),
          FilledButton(
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TimetablePage()))
            },
            child: const Text(
              'Timetable',
            ),
          ),
          FilledButton(
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RealtimeLocation()))
            },
            child: const Text(
              'Map',
            ),
          ),
          FilledButton(
            onPressed: () => {
              // Get.to(() => const TestRealtimeLocation())
              Get.toNamed(RikeRoutes.getParentalControlsRoute())
            },
            child: const Text(
              'Test Map',
            ),
          ),
          FilledButton(
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PhoneUsage()))
            },
            child: const Text(
              'Usage',
            ),
          ),
          FilledButton(
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AppUsageStats()))
            },
            child: const Text(
              'Usage',
            ),
          ),
          FilledButton(
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PerformancePage()))
            },
            child: const Text(
              'Performance',
            ),
          ),
        ],
      ),
    );
  }
}

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<SettingsController>(() => SettingsController());
    Get.lazyPut<ThemeController>(() => ThemeController());
    Get.lazyPut<LanguageController>(() => LanguageController());
    Get.lazyPut<LogoutController>(() => LogoutController());
  }
}
