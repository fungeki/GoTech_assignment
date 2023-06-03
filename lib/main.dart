import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gotech_flutter_assignment/blocs/questions/questions_bloc.dart';
import 'package:gotech_flutter_assignment/repo/sources/questions_server_datasource.dart';
import 'package:gotech_flutter_assignment/services/network.dart';
import 'package:gotech_flutter_assignment/styles/app_themedata.dart';
import 'package:gotech_flutter_assignment/ui/home/quesions_root_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiRepositoryProvider(
      providers: [
        ///
        /// Services
        ///
        RepositoryProvider<NetworkManager>(
          create: (context) => NetworkManager(),
        ),

        ///
        /// Data sources
        ///
        RepositoryProvider<QuestionsServerDatasource>(
          create: (context) =>
              QuestionsServerDatasource(context.read<NetworkManager>()),
        ),
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider<QuestionsBloc>(
            create: (context) =>
                QuestionsBloc(context.read<QuestionsServerDatasource>()))
      ], child: const MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemeData.appThemeData,
      home: const QuestionsRootScreen(),
    );
  }
}
