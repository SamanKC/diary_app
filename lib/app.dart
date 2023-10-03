import 'package:diary_app/bloc/add_diary_bloc.dart';
import 'package:diary_app/screens/add_diary_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diary App',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider<DiaryBloc>(
        child: const AddDiaryPage(),
        create: (context) => DiaryBloc(),
      ),
    );
  }
}
