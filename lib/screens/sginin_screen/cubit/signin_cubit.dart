

import 'package:building_material_application/screens/sginin_screen/cubit/signin_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../constants/constants.dart';


class SigninCubit extends Cubit<SigninStates>{

  SigninCubit() : super(SigninInitialState());

  static SigninCubit get(context) => BlocProvider.of(context);

  //SigninModel? SigninModel ;


  void userSignin({required String email , required String password}){
    emit(SigninLoadingState());
    if(email == 'abdulnasser1213@gmail.com' && password == '1234567'){
      btnController.success();
      emit(SigninSuccessState());
      Future.delayed(const Duration(seconds: 3), () {
        btnController.reset();
      });
    }else{
      btnController.error();
      emit(SigninErrorState('Email or Password wrong !'));
      Future.delayed(const Duration(seconds: 3), () {
        btnController.reset();
      });
    }
  }

  bool isPassword = true;
  IconData suffixIcon = Icons.visibility;

  void changePasswordVisibility(){
    emit(SigninChangeVisibilityState());
    isPassword = !isPassword;
    if(isPassword) {
      suffixIcon = Icons.visibility;
    } else {
      suffixIcon = Icons.visibility_off;
    }
  }

  final RoundedLoadingButtonController btnController =
  RoundedLoadingButtonController();

}