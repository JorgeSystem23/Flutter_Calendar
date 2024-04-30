import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:calendar_projects/home.dart';
import 'package:calendar_projects/syncfusion_calendar/bloc/calendar_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>EventProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Colors.red,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
