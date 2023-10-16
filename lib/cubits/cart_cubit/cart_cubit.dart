import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:building_material_application/constants/constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/cart_model.dart';
import 'cart_states.dart';

class CartCubit extends Cubit<CartStates>{
  CartCubit(): super(CartInitState());
  static CartCubit get(context) => BlocProvider.of(context);

  List<CartModel>? carts;

  Map<String,CartModel> cartItems ={};

   fetchProductsToCart(){

    // FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
    //   List userCartL = value.get('userCart');
    //   print(userCartL);
    //   for(int i=0;i<userCartL.length;i++){
    //     cartItems.putIfAbsent(userCartL[i]['productId'], () => CartModel.fromJson(userCartL[i]));
    //   }
    //   emit(FetchProductsToCartSuccessState());
    // }).catchError((onError){
    //   // Methods.defDialog(context: context, dialogType: DialogType.error,title:onError.toString() );
    //   print(onError.toString());
    //   emit(FetchProductsToCartErrorState());
    // });
  }

  void addProductsToCart({
    required String productId,
    required int quantity,
    required BuildContext context
}) {
    // carts.
    if(cartItems.containsKey(productId)){
      defToast(msg: 'already inCart');
      print('already inCart');
    }else{
      cartItems.putIfAbsent(productId, () => CartModel(
          id: DateTime.now().toString(),
          productId: productId, quantity: quantity));
      print(cartItems);
      emit(CartChangeItemState());

    }

  }

  void clearCart(){
    cartItems = {};
    emit(CartChangeItemState());
  }

  void deleteProductsFromCart({
    required String productId,
    required String id,
    required int quantity,
    required BuildContext context}){
    cartItems.remove(productId);
    emit(CartChangeItemState());
    // FirebaseFirestore.instance.collection('users').doc(Methods.uId).update(
    //     {
    //       'userCart': FieldValue.arrayRemove([
    //         CartModel(
    //             id: id,
    //             productId: productId, quantity: quantity).toJson()
    //       ])
    //     }).then((value) {
    //   cartItems.remove(productId);
    //   emit(CartChangeItemState());
    // }).catchError((onError){
    //   Methods.defDialog(context: context, dialogType: DialogType.error,title: onError.toString());
    //   emit(CartChangeItemErrorState());
    // });

  }

}