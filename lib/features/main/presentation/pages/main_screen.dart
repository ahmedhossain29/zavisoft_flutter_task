import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zavisaft_flutter_task/features/main/presentation/pages/widgets/app_bottom_nav_bar.dart';
import '../../../Home/presentation/screens/home_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../cubit/main_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainCubit(),
      child: const _MainView(),
    );
  }
}

class _MainView extends StatelessWidget {
  const _MainView();

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      const ProfileScreen(),
    ];

    return BlocBuilder<MainCubit, int>(
      builder: (context, index) {
        return Scaffold(
          body: IndexedStack(
            index: index,
            children: screens,
          ),
          bottomNavigationBar: AppBottomNavBar(
            currentIndex: index,
            onTap: context.read<MainCubit>().changeTab,
          ),
        );
      },
    );
  }
}