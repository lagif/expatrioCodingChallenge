import 'package:coding_challenge/auth/widgets/auth_screen.dart';
import 'package:coding_challenge/service_locator/container.dart';
import 'package:coding_challenge/tax_info/cubits/tax_info_cubit.dart';
import 'package:coding_challenge/tax_info/widgets/tax_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/cubits/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupContainer();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => container.get<AuthCubit>()..load()),
        BlocProvider(create: (context) => container.get<TaxInfoCubit>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: themeData(),
        routes: <String, WidgetBuilder>{
          'TaxInfoScreen': (_) => const UserTaxInfoScreen(),
          'LoginScreen': (_) => const LoginScreen()
        },
        home: Scaffold(
          body: Container(
            color: Colors.white,
            child: const LoginScreen(),
          ),
        ),
      ),
    );
  }
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

ThemeData themeData() {
  return ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    canvasColor: Colors.transparent,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Color.fromRGBO(65, 171, 158, 1),
      selectionColor: Color.fromRGBO(65, 171, 158, 1),
      selectionHandleColor: Color.fromRGBO(65, 171, 158, 1),
    ),
    inputDecorationTheme: InputDecorationTheme(
      suffixIconColor: const Color.fromRGBO(65, 171, 158, 1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Colors.black, width: 0.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Color.fromRGBO(65, 171, 158, 1),
          width: 0.5,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Colors.black, width: 0.5),
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme:
        ColorScheme.fromSwatch(primarySwatch: createMaterialColor(Colors.white))
            .copyWith(
      secondary: createMaterialColor(const Color.fromRGBO(65, 171, 158, 1)),
    ),
    primaryColorDark: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 45)),
        backgroundColor:
            MaterialStateColor.resolveWith((_) => const Color(0xFF41AB9E)),
      ),
    ),
  );
}
