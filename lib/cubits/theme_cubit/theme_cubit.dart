import 'package:building_material_application/cubits/theme_cubit/theme_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ThemeCubit extends Cubit<ThemeStates>{
  ThemeCubit() : super(ThemeInitState());
  static ThemeCubit get(context) => BlocProvider.of(context);

  bool isDarkTheme = true;
   void changeTheme({bool? fromShared}) {
     if(fromShared != null){
       isDarkTheme = fromShared;
     }
     else {
       isDarkTheme = !isDarkTheme;
       // CacheHelper.saveData(key: 'isDark', value: isDarkTheme);
     }
     emit(ThemeChangeState());
  }
}