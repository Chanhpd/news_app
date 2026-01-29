import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/di/injection.dart';
import 'shared/cubit/app_cubit.dart';
import 'shared/cubit/app_state.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AppCubit>(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, appState) {
          return MaterialApp.router(
            title: 'Smart News',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: appState.themeMode,
            locale: appState.locale,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
