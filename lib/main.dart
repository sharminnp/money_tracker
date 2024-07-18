import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:msa_money_tracker/core/local_storage/local_storage.dart';
import 'package:msa_money_tracker/core/service/notification_service.dart';
import 'package:msa_money_tracker/data/model/expense_model.dart';
import 'package:msa_money_tracker/presentation/expense/bloc/expense_bloc/expense_bloc.dart';
import 'package:msa_money_tracker/presentation/home/bloc/home_bloc/home_bloc.dart';
import 'package:msa_money_tracker/presentation/intro/intro_page.dart';

import 'core/di/dependancy_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();
  await getIt<LocalStorage>().initHive();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(ExpenseModelAdapter());
  }
  await NotificationService().init();
  NotificationService().scheduleNotification(
    0,
    'Daily Reminder',
    'This is your daily reminder to add expenses',
    'payload',
  );
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ExpenseBloc>()),
        BlocProvider(create: (context) => getIt<HomeBloc>()),
      ],
      child: ScreenUtilInit(
        designSize: MediaQuery.of(context).size,
        child: MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const IntroPage(),
        ),
      ),
    );
  }
}
