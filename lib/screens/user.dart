import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../constants/constants.dart';
import '../cubits/layout_cubit/layout_cubit.dart';
import '../cubits/theme_cubit/theme_cubit.dart';
import '../cubits/theme_cubit/theme_states.dart';



class UserScreen extends StatelessWidget {
  UserScreen({Key? key}) : super(key: key);
  TextEditingController editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ThemeCubit themeCubit = ThemeCubit.get(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Hi,  ',
                          style: const TextStyle(
                            color: Colors.cyan,
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'MyName',
                                style: TextStyle(
                                  // color: color,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('My name is pressed');
                                  }),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Email@email.com',
                        // color: color,
                        style:TextStyle(fontSize: 18) ,
                        // isTitle: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Divider(
                  thickness: 2,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ListTiles(
              leading:IconlyBroken.profile,
              title: 'Address',
              subtitle: 'My subtitle',
              trailing: IconlyBroken.arrowRight2,
              onTap: ()async{
                await _showAddressDialog(context,editingController);
              },
            ),
            // ListTiles(
            //   leading:IconlyBroken.bag,
            //   title: 'Orders',
            //   subtitle: 'My subtitle',
            //   trailing: IconlyBroken.arrowRight2,
            //   onTap: (){
            //     navigateTo(context, OrdersScreen());
            //   },
            // ),
            // ListTiles(
            //   leading:IconlyBroken.heart,
            //   title: 'Wishlist',
            //   trailing: IconlyBroken.arrowRight2,
            //   onTap: (){
            //     navigateTo(context, WishlistScreen());
            //   },
            // ),
            // ListTiles(
            //   leading:IconlyBroken.show,
            //   title: 'Viewed',
            //   trailing: IconlyBroken.arrowRight2,
            //   onTap: (){
            //     Methods.navigateTo(context, HistoryScreen());
            //   },
            // ),
            ListTiles(
              leading:IconlyBroken.unlock,
              title: 'Forget password',
              trailing: IconlyBroken.arrowRight2,
              onTap: (){},
            ),
            BlocConsumer<ThemeCubit,ThemeStates>(
              listener: (context,state){},
              builder: (context,state){
              return SwitchListTile(
                
                title: Text('Theme'),
                secondary: Icon(themeCubit.isDarkTheme
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined),
                onChanged: (bool value) {
                  themeCubit.changeTheme();
                },
                value: themeCubit.isDarkTheme,
              );
            },
            ),
            ListTiles(
              leading:IconlyBroken.logout,
              title: 'Logout',
              trailing: IconlyBroken.arrowRight2,
              onTap: ()async{
                await _showLogoutDialog(context,);
              },
            ),
          ],
        ),
      )
    );
  }
}

Future<void> _showAddressDialog(BuildContext context,TextEditingController editingController) async{
  return await AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    borderSide:  BorderSide(
      color: ThemeCubit.get(context).isDarkTheme? Colors.lightBlue : Colors.green,
      width: 2,
    ),
    width: double.infinity,
    buttonsBorderRadius: const BorderRadius.all(
      Radius.circular(2),
    ),
    dismissOnTouchOutside: true,
    dismissOnBackKeyPress: true,
    animType: AnimType.bottomSlide,
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Text('Update Email'),
          SizedBox(height: 5,),
          TextFormField(
            controller: editingController,
            decoration: InputDecoration(hintText: 'Your address'),
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    ),
    barrierColor: Color(0x80000000),
    showCloseIcon: true,
    btnCancelOnPress: () {},
    btnOkText: 'Update',
    btnOkOnPress: () {},
  ).show();
}
Future<void> _showLogoutDialog(BuildContext context) async{
  return await AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    borderSide:  BorderSide(
      color: ThemeCubit.get(context).isDarkTheme? Colors.lightBlue : Colors.green,
      width: 2,
    ),
    width: 500,
    buttonsBorderRadius: const BorderRadius.all(
      Radius.circular(2),
    ),
    dismissOnTouchOutside: true,
    dismissOnBackKeyPress: true,
    animType: AnimType.bottomSlide,
    title: 'Sign out',
    desc: 'Do you want sign out?',
    barrierColor: Color(0x80000000),
    showCloseIcon: true,
    btnCancelOnPress: () {},
    btnOkOnPress: () {
      LayoutCubit.get(context).signOut(context);
    },
  ).show();
}

class ListTiles extends StatelessWidget {
  final IconData leading;
  final String title;
  final String? subtitle;
  final IconData trailing;
  final Function() onTap;
  const ListTiles({Key? key, required this.leading, required this.title, this.subtitle, required this.trailing, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(leading),
        ],
      ),
      title: Text(title),
      subtitle: subtitle!=null ? Text(subtitle!,style: TextStyle(fontSize: 12),):null,
      trailing: Icon(trailing),
      onTap: onTap,
    );
  }
}

