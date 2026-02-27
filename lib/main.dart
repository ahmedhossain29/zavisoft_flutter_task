import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zavisaft_flutter_task/core/di/injector.dart';

import 'core/routes/app_routes.dart';
import 'core/routes/route_names.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(); // GetIt init

  runApp(
    MultiBlocProvider(
      providers: [

        /// 🔥 Global AuthCubit
        BlocProvider<AuthCubit>(
          create: (_) => sl<AuthCubit>()..checkLogin(),
        ),

      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'zavisoft Task',

      initialRoute: RouteNames.main,
      onGenerateRoute: AppRoutes.generate,
    );
  }
}

