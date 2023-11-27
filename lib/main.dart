import 'dart:async';

import 'package:bmi_caclulator/di/get_it.dart';
import 'package:bmi_caclulator/features/bmi_count/presentation/view/bmi_calculator/emi_calculator_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
  mainFunctions();
}

Future<void> mainFunctions() async {
  unawaited(init());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const EmiCalculatorScreen(),
      ),
    );
  }
}
