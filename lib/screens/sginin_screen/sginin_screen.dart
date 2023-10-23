




import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../layout/home_layout.dart';
import '../../widgets/def_text_form_filed.dart';
import '../../widgets/loading_button.dart';
import 'cubit/signin_cubit.dart';
import 'cubit/signin_states.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey();
    return BlocProvider(
      create: (context)=>SigninCubit(),
      child: BlocConsumer<SigninCubit,SigninStates>(
        listener: (context,state){
          if(state is SigninSuccessState){
            defToast2(
                title: 'Successfully Signin',
              context: context,
              dialogType: DialogType.success
            ).then((value) {
              navigateToReplacement(context,  const HomeLayout());
            });

          }
          if(state is SigninErrorState){
            defToast2(
              title: state.error.toString(),
                context: context,
                dialogType: DialogType.error
            );
          }
        },
        builder: (context,state){
          SigninCubit cubit = SigninCubit.get(context);
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5) 
                          ),
                          child: Image.asset('assets/logo.png'),
                        ),
                        const Text("Signin",
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                          ),),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Explor Every Things",
                          style: TextStyle(
                              fontSize: 17
                          ),),
                        const Text('Building Material App',style: TextStyle(color: Colors.red,fontSize: 18),),
                        const SizedBox(
                          height: 40,
                        ),
                        DefTextFormFiled(
                            textEditingController: emailController,
                            prefixIcon: const Icon(Icons.email_outlined),
                            labelText: 'Email',
                            validator: (value){
                              if(value!.isEmpty){
                                return 'please enter email';
                              }
                              else {
                                return null;
                              }
                            },
                            textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        DefTextFormFiled(
                            textEditingController: passwordController,
                            prefixIcon: const Icon(Icons.lock_outline),
                            labelText: 'Password',
                            password: cubit.isPassword,
                            suffixIcon:  IconButton(
                              onPressed: (){
                                cubit.changePasswordVisibility();
                              },
                              icon: Icon(cubit.suffixIcon),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'please enter password';
                              }
                              else {
                                return null;
                              }
                            },
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        LoadingButton(
                            text: 'Sign In',
                            controller: cubit.btnController,
                            onPressed: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if(formKey.currentState!.validate()){
                                cubit.userSignin(email: emailController.text, password: passwordController.text);
                              }else{
                                cubit.btnController.error();
                                Future.delayed(const Duration(seconds: 3), () {
                                  cubit.btnController.reset();
                                });
                              }
                            }
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            TextButton(
                              onPressed: () {
                                // navigateToReplacement(context,  const SignupScreen());
                              },
                              child: const Text(
                                'Register Now',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}