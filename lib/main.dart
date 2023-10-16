import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/theme_data.dart';
import 'cubits/cart_cubit/cart_cubit.dart';
import 'cubits/feeds_cubit/feeds_cubit.dart';
import 'cubits/history_cubit/history_cubit.dart';
import 'cubits/home_cubit/home_cubit.dart';
import 'cubits/theme_cubit/theme_cubit.dart';
import 'cubits/theme_cubit/theme_states.dart';
import 'cubits/wishlist_cubit/wishlist_cubit.dart';
import 'screens/sginin_screen/sginin_screen.dart';
import 'screens/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp( MyApp(isDark: false));
  });

}

class MyApp extends StatelessWidget {
  final isDark;

  const MyApp({super.key, this.isDark});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>ThemeCubit()..changeTheme(fromShared: isDark)),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => FeedsCubit()),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => WishlistCubit()),
        BlocProvider(create: (context) => HistoryCubit()),
      ],
      child: BlocConsumer<ThemeCubit,ThemeStates>(
        listener: (context,state){},
    builder: (context,state){
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'building material',
        theme: Styles.themeData(false, context),
        darkTheme: Styles.themeData(true, context),
        themeMode: ThemeCubit.get(context).isDarkTheme? ThemeMode.dark : ThemeMode.light,
      home: const MyCustomSplashScreen(screen: SigninScreen() ),
      );}
      )
    );
  }
}


