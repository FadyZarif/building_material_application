import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../models/products_model.dart';
import '../../screens/cart_screen.dart';
import '../../screens/categories.dart';
import '../../screens/home_screen.dart';
import '../../screens/user.dart';
import 'layout_states.dart';

class LayoutCubit extends Cubit<LayoutStates>{
  LayoutCubit() : super(LayoutInitState());
  static LayoutCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    CartScreen(),
    UserScreen()
  ];
  void changeScreen({required int i}){
    currentIndex = i;
    emit(LayoutChangeScreenState());
  }

  void signOut(BuildContext context){
    emit(LayoutSignOutSuccessState());

  }
}