import 'dart:math';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../cubits/cart_cubit/cart_cubit.dart';
import '../cubits/cart_cubit/cart_states.dart';
import '../cubits/layout_cubit/layout_cubit.dart';
import '../cubits/layout_cubit/layout_states.dart';
import '../cubits/theme_cubit/theme_cubit.dart';

import 'package:badges/badges.dart' as badges;



class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartCubit cartCubit = CartCubit.get(context);
    ThemeCubit themeCubit = ThemeCubit.get(context);
    return BlocProvider(
        create: (context) => LayoutCubit(),
        child: BlocConsumer<LayoutCubit, LayoutStates>(
            listener: (context, state) {
              if (state is LayoutSignOutSuccessState) {
                // Methods.navigateToReplacement(context, SigninScreen());
              }
            },
            builder: (context, state) {
              LayoutCubit layoutCubit = LayoutCubit.get(context);
              return Scaffold(
                body: layoutCubit.screens[layoutCubit.currentIndex],
                bottomNavigationBar: ConvexAppBar.badge(
                  initialActiveIndex: 0,
                  {},
                  backgroundColor: themeCubit.isDarkTheme
                      ? Theme.of(context).cardColor
                      : Colors.white,
                  activeColor: themeCubit.isDarkTheme
                      ? Colors.lightBlue.shade200
                      : Colors.green,
                  color:
                      themeCubit.isDarkTheme ? Colors.white10 : Colors.black12,
                  shadowColor: themeCubit.isDarkTheme
                      ? Colors.lightBlue.shade200
                      : Colors.green,
                  curveSize: 90,
                  height: 50,
                  top: -20,
                  style: TabStyle.react,
                  onTap: (i) {
                    layoutCubit.changeScreen(i: i);
                  },
                  items: [
                    TabItem(
                        icon: layoutCubit.currentIndex == 0
                            ? IconlyBold.home
                            : IconlyLight.home),
                    TabItem(
                        icon: layoutCubit.currentIndex == 1
                            ? IconlyBold.category
                            : IconlyLight.category),
                    TabItem(
                      icon: badges.Badge(
                        position: badges.BadgePosition.topEnd(),
                        showBadge: true,
                        ignorePointer: false,
                        badgeContent: BlocBuilder<CartCubit, CartStates>(
                            builder: (context, state) {
                          return Text('${cartCubit.cartItems.length}',
                              style: TextStyle(color: Colors.white));
                        }),
                        badgeStyle: badges.BadgeStyle(
                          shape: badges.BadgeShape.circle,
                          badgeColor: Colors.blue,
                          padding: const EdgeInsets.all(5),
                          borderRadius: BorderRadius.circular(6),
                          badgeGradient: const badges.BadgeGradient.linear(
                            colors: [Colors.blue, Colors.yellow],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: layoutCubit.currentIndex == 2
                            ? Icon(
                                IconlyBold.buy,
                                size: 30,
                                color: themeCubit.isDarkTheme
                                    ? Colors.lightBlue.shade200
                                    : Colors.green,
                              )
                            : Icon(
                                IconlyLight.buy,
                                size: 30,
                                color: themeCubit.isDarkTheme
                                    ? Colors.white10
                                    : Colors.black12,
                              ),
                      ),
                    ),
                    TabItem(
                        icon: layoutCubit.currentIndex == 3
                            ? IconlyBold.user2
                            : IconlyLight.user2)
                  ],
                ),
              );
            }));
  }
}
