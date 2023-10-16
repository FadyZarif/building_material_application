import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:building_material_application/constants/constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/wishlist_model.dart';
import '../wishlist_cubit/wishlist_states.dart';



class WishlistCubit extends Cubit<WishlistStates>{
  WishlistCubit(): super(WishlistInitState());
  static WishlistCubit get(context) => BlocProvider.of(context);
  // List<WishlistModel>? Wishlists;
  Map<String,WishlistModel> wishlistItems ={};

  fetchProductsToWish(){

    // FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
    //   List userWishL = value.get('userWish');
    //   for(int i=0;i<userWishL.length;i++){
    //     wishlistItems.putIfAbsent(userWishL[i]['productId'], () => WishlistModel.fromJson(userWishL[i]));
    //   }
    //
    //   emit(FetchProductsToWishSuccessState());
    // }).catchError((onError){
    //   // Methods.defDialog(context: context, dialogType: DialogType.error,title:onError.toString() );
    //   print(onError.toString());
    //   emit(FetchProductsToWishErrorState());
    // });
  }

  addProductsToWishlist({
    required String productId,
    required BuildContext context,

  }){
    if(wishlistItems.containsKey(productId)){
      defToast(msg: 'already inCart');
    print('already inCart');
  }else {
      String id = DateTime.now().toString();
      wishlistItems.putIfAbsent(
          productId,
              () => WishlistModel(
            id:id,
            productId: productId,
          ));
      emit(WishlistChangeItemState());

      /*FirebaseFirestore.instance.collection('users').doc(Methods.uId).update(
        {
          'userWish': FieldValue.arrayUnion([
            WishlistModel(
              id: id,
              productId: productId,).toJson()
          ])
        }).then((value) {
      wishlistItems.putIfAbsent(
          productId,
              () => WishlistModel(
            id:id,
            productId: productId,
          ));
      emit(WishlistChangeItemState());
    }).catchError((onError){
      Methods.defDialog(context: context, dialogType: DialogType.error,title: onError.toString());
    });*/
    }
  }

  removeProductsToWishlist({
    required String productId,
    required String id,
    required BuildContext context,

  }){
    wishlistItems.remove(productId);
    emit(WishlistChangeItemState());
    /*FirebaseFirestore.instance.collection('users').doc(Methods.uId).update(
        {
          'userWish': FieldValue.arrayRemove([
            WishlistModel(
                id: id,
                productId: productId).toJson()
          ])
        }).then((value) {
      wishlistItems.remove(productId);
      emit(WishlistChangeItemState());
    }).catchError((onError){
      Methods.defDialog(context: context, dialogType: DialogType.error,title: onError.toString());
    });*/
  }

  WishlistModel findById(String productId) {
    return wishlistItems[productId]!;
  }

  /*void addRemoveProductsToWishlist({
    required String productId,
    required String id,
    required BuildContext context,

  }) {
    // Wishlists.
    if(wishlistItems.containsKey(productId)){
      FirebaseFirestore.instance.collection('users').doc(Methods.uId).update(
          {
            'userWish': FieldValue.arrayRemove([
              WishlistModel(
                  id: id,
                  productId: productId).toJson()
            ])
          }).then((value) {
        wishlistItems.remove(productId);
      }).catchError((onError){
        Methods.defDialog(context: context, dialogType: DialogType.error,title: onError.toString());
      });
    }else {
      FirebaseFirestore.instance.collection('users').doc(Methods.uId).update(
          {
            'userWish': FieldValue.arrayUnion([
              WishlistModel(
                  id: DateTime.now().toString(),
                  productId: productId,).toJson()
            ])
          }).then((value) {
        wishlistItems.putIfAbsent(
            productId,
                () => WishlistModel(
              id: DateTime.now().toString(),
              productId: productId,
            ));
      }).catchError((onError){
        Methods.defDialog(context: context, dialogType: DialogType.error,title: onError.toString());
      });
    }
    emit(WishlistChangeItemState());
  }*/

  void clearWishlist(){
    wishlistItems = {};
    emit(WishlistChangeItemState());
  }



void deleteProductsFromWishlist({required String id,}){
  wishlistItems.remove(id);
  emit(WishlistChangeItemState());

}

}