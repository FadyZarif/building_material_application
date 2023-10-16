import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../cubits/wishlist_cubit/wishlist_cubit.dart';
import '../cubits/wishlist_cubit/wishlist_states.dart';

class HeartButton extends StatelessWidget {
  final String productId;
  const HeartButton({Key? key, required this.productId,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistCubit,WishlistStates>(
        listener: (context, state){},
        builder:(context, state) {
          bool isInWishlist = WishlistCubit.get(context).wishlistItems.containsKey(productId);
          return InkWell(
            onTap: () {

                if(isInWishlist == false ){

                  WishlistCubit.get(context).addProductsToWishlist(productId: productId, context: context);
                }else{
                  print(WishlistCubit.get(context).findById(productId).toJson());
                  WishlistCubit.get(context).removeProductsToWishlist(productId: productId, id: WishlistCubit.get(context).findById(productId).id!, context: context);

                }
                // WishlistCubit.get(context)
                //     .addRemoveProductsToWishlist(productId: productId,id: id,context: context);
                // print(WishlistCubit.get(context).wishlistItems.length);

            },
            child: isInWishlist ?Icon(IconlyBold.heart, size: 22,color: Colors.red,): Icon(IconlyBroken.heart, size: 22,),
          );

        }
    );
  }
}
