import 'package:azkar/Azkary_app.dart';
import 'package:azkar/core/local_storage/shared_preferences_manager.dart';
import 'package:azkar/core/notification_helper/awesome_notification_manager.dart';
import 'package:azkar/core/theming/cubit_cahnge_themeing.dart';
import 'package:azkar/core/theming/dark_theme.dart';
import 'package:azkar/core/theming/light_theme.dart';
import 'package:azkar/features/azkar/presentation/veiw/screens/azkar_screen.dart';
import 'package:azkar/features/home/presentation/view/screens/home_screen.dart';
import 'package:azkar/features/home/presentation/view_model/prayer_times_cubit/prayper_times_cubit.dart';
import 'package:azkar/features/sabha/presentation/veiw/screens/sabha_screen.dart';
import 'package:azkar/features/settings/presentation/veiw/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    ScreenUtil.ensureScreenSize(),
    AwesomeNotificationManager.initialize(),
    SharedPreferencesManager.sharedPreferencesInitialize(),
  ]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  final themeCubit = ThemeCubit();
  await themeCubit.loadTheme();
  runApp(MyApp(
    themeCubit: themeCubit,
  ));
}

// fake commit
class MyApp extends StatefulWidget {
  final ThemeCubit themeCubit;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  const MyApp({super.key, required this.themeCubit});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 758.666),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return BlocProvider(
          create: (_) => widget.themeCubit,
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return BlocProvider(
                create: (context) => PrayerTimesCubit()..fetchPrayerTimes(),
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  themeMode: themeMode,
                  navigatorKey: MyApp.navigatorKey,
                  routes: routes,
                  localizationsDelegates: const [
                    GlobalCupertinoLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale("ar", "AE"),
                  ],
                  locale: const Locale("ar", "AE"),
                  initialRoute: '/',
                ),
              );
            },
          ),
        );
      },
    );
  }

  Map<String, WidgetBuilder> get routes => {
        '/': (context) => const MainScaffold(),
        HomeScreen.routeName: (context) => HomeScreen(),
        SettingsScreen.routeName: (context) => const SettingsScreen(),
        AzkarScreen.routeName: (context) => const AzkarScreen(),
        SabhaScreen.routeName: (context) => const SabhaScreen(),
      };
}
