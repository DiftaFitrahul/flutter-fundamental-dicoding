import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/bloc/favorite/favorites.dart';
import '../../controller/cubit/bottom_nav_cubit.dart';
import '../../routes/routes_name.dart';
import '../../utils/notification_helper.dart';
import '../widget/platform_widget.dart';
import './setting.dart';
import './favorite.dart';
import './home.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final NotificationHelper notificationHelper = NotificationHelper();
  @override
  void initState() {
    notificationHelper.handleSelectNotificationSubject(
        context, RoutesName.detailRestaurant);
    super.initState();
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
        androidBuilder: _bottomNavBarAndroid, iosBuilder: _bottomNavBarIOS);
  }

  Widget _bottomNavBarAndroid(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, int>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: _screens[state],
          bottomNavigationBar: BottomNavigationBar(
            items: _bottomNavBarItems,
            currentIndex: state,
            selectedItemColor: Colors.orange[900],
            onTap: (updatedIndex) {
              if (state != 1 && updatedIndex == 1) {
                context.read<FavoritesBloc>().add(FavoritesFetched());
              }

              context.read<BottomNavigationCubit>().changeIndex(updatedIndex);
            },
          ),
        );
      },
    );
  }

  Widget _bottomNavBarIOS(BuildContext context) {
    return CupertinoTabScaffold(
      resizeToAvoidBottomInset: false,
      tabBar: CupertinoTabBar(items: _bottomNavBarItems),
      tabBuilder: (_, index) => _screens[index],
    );
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const FavoriteScreen(),
    const SettingScreen()
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
        icon:
            Icon(Platform.isAndroid ? Icons.home_filled : CupertinoIcons.home),
        label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(
          Platform.isAndroid ? Icons.star_border_outlined : CupertinoIcons.star,
        ),
        label: 'Favorites'),
    BottomNavigationBarItem(
        icon:
            Icon(Platform.isAndroid ? Icons.settings : CupertinoIcons.settings),
        label: 'Settings')
  ];
}
