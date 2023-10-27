import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:building_material_application/constants/constants.dart';
import 'package:building_material_application/widgets/def_text_form_filed.dart';
import 'package:building_material_application/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class PaymentScreen extends StatelessWidget {
  final double price;
  const PaymentScreen({Key? key, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RoundedLoadingButtonController btnController =
    RoundedLoadingButtonController();
    GlobalKey<FormState> formKey = GlobalKey();
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50,),

                Center(child: Image.asset('assets/logo.png')),
                Text('Total Price :',style: TextStyle(fontSize: 20),),
                Center(child: Text('\$ $price ',style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Colors.red))),
                SizedBox(height: 20, ),
                DefTextFormFiled(
                  labelText: 'Full Name',
                  validator: (value){
                    if(value!.isEmpty){
                      return 'please enter Full Name';
                    }
                    else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20,),
                DefTextFormFiled(
                  labelText: 'Contact',
                  validator: (value){
                    if(value!.isEmpty){
                      return 'please enter Contact';
                    }
                    else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20,),
                DefTextFormFiled(
                  labelText: 'Address',
                  validator: (value){
                    if(value!.isEmpty){
                      return 'please enter Address';
                    }
                    else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20,),
                DefTextFormFiled(
                  labelText: 'Card Number',
                  keyboardType: TextInputType.number,
                  listTextInputFormatter: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                  password: true,
                  maxLength: 16,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'please enter Card Number';
                    }
                    else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Flexible(
                      child: DefTextFormFiled(
                        labelText: 'Valid Until',
                        // textEditingController: TextEditingController(text: '/'),
                        keyboardType: TextInputType.datetime,
                        listTextInputFormatter: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9/]'),),
                          LengthLimitingTextInputFormatter(5)

                        ],
                        validator: (value){
                          if(value!.isEmpty){
                            return 'please enter Valid Until';
                          }
                          else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 10,),
                    Flexible(
                      child: DefTextFormFiled(
                        labelText: 'CVV',
                        password: true,
                        keyboardType: TextInputType.number,
                        listTextInputFormatter: [FilteringTextInputFormatter.allow(RegExp('[0-9]')),LengthLimitingTextInputFormatter(3)
                        ],
                        validator: (value){
                          if(value!.isEmpty){
                            return 'please enter CVV';
                          }
                          else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                LoadingButton(
                    controller: btnController,
                    onPressed: (){
                      FocusScope.of(context).requestFocus(FocusNode());
                      if(formKey.currentState!.validate()){
                        btnController.success();
                        Future.delayed(const Duration(seconds: 3), () {
                          btnController.reset();
                        });
                        defToast2(context: context, title: 'Successfully Paid', dialogType: DialogType.success);
                      }else{
                        btnController.error();
                        Future.delayed(const Duration(seconds: 3), () {
                          btnController.reset();
                        });
                      }
                    }
                    , text: 'Pay Now')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
