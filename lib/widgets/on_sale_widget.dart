import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:building_material_application/widgets/price_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';


import '../constants/constants.dart';
import '../cubits/cart_cubit/cart_cubit.dart';
import '../cubits/cart_cubit/cart_states.dart';
import '../cubits/history_cubit/history_cubit.dart';
import '../cubits/theme_cubit/theme_cubit.dart';
import '../cubits/wishlist_cubit/wishlist_states.dart';
import '../models/products_model.dart';
import 'heart_button.dart';

class OnSaleWidget extends StatelessWidget {
  final ProductModel productModel;
  const OnSaleWidget({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartCubit cartCubit = CartCubit.get(context);

    return InkWell(
      onTap: () {
        // navigateTo(context,ProductDetailsScreen(productModel: productModel,));
        HistoryCubit.get(context).addProductsToHistory(productId: productModel.id!);

      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ThemeCubit.get(context).isDarkTheme
              ? const Color(0xFF0a0d2c).withOpacity(0.9)
              : const Color(0xFFF2FDFD).withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FancyShimmerImage(
                  imageUrl: productModel.imageUrl!,
                  height: MediaQuery.of(context).size.width * 0.22,
                  width: MediaQuery.of(context).size.width * 0.22,
                  boxFit: BoxFit.fill,
                  shimmerBackColor: Colors.grey,
                  shimmerHighlightColor: Colors.white70,
                ),
                // Image.network('https://i.ibb.co/F0s3FHQ/Apricots.png',
                //   height: MediaQuery.of(context).size.width*0.22,
                //   fit: BoxFit.fill,
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      productModel.isPiece!?'1Piece':'1KG',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        BlocConsumer<CartCubit,CartStates>(
                          listener: (context, state){},
                          builder:(context, state)=> InkWell(
                            onTap: () {
                                cartCubit.addProductsToCart(productId: productModel.id!,quantity: 1 ,context: context);
                            },
                            child: cartCubit.cartItems.containsKey(productModel.id)?Icon(IconlyBold.bag2, size: 22,color: ThemeCubit.get(context).isDarkTheme?Colors.blue:Colors.green,): Icon(IconlyBroken.bag2, size: 22,color: ThemeCubit.get(context).isDarkTheme?Colors.blue:Colors.green,),
                          ),
                        ),
                        HeartButton(productId: productModel.id!,)
                      ],
                    )
                  ],
                )
              ],
            ),
            PriceWidget(
              onSale: productModel.isOnSale!,
              price: productModel.price!,
              salePrice: productModel.salePrice!,
              textPrice: '1',
            ),
            Text(
              productModel.title!,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
