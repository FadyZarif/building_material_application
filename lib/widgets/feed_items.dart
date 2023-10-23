import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:building_material_application/widgets/price_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';


import '../constants/constants.dart';
import '../cubits/cart_cubit/cart_cubit.dart';
import '../cubits/history_cubit/history_cubit.dart';
import '../cubits/home_cubit/home_cubit.dart';
import '../cubits/home_cubit/home_states.dart';
import '../cubits/theme_cubit/theme_cubit.dart';
import '../cubits/wishlist_cubit/wishlist_cubit.dart';
import '../cubits/wishlist_cubit/wishlist_states.dart';
import '../models/products_model.dart';
import 'heart_button.dart';

class FeedsWidget extends StatelessWidget {
  final ProductModel productModel;
  FeedsWidget({Key? key, required this.productModel}) : super(key: key);

  TextEditingController quantityTextController =
      TextEditingController(text: '1');

  @override
  Widget build(BuildContext context) {
    CartCubit cartCubit = CartCubit.get(context);
    return InkWell(
      onTap: () {
        HistoryCubit.get(context).addProductsToHistory(productId: productModel.id!);
        // navigateTo(context,ProductDetailsScreen(productModel: productModel,));
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: ThemeCubit.get(context).isDarkTheme
              ? Color(0xFF0a0d2c).withOpacity(0.9)
              : const Color(0xFFF2FDFD).withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Image.asset(productModel.imageUrl!,
              width: MediaQuery.of(context).size.width * 0.22,
              height: MediaQuery.of(context).size.width * 0.22,
              fit: BoxFit.fill,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      productModel.title!,
                      maxLines: 1,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: HeartButton(productId: productModel.id!,),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                BlocConsumer<HomeCubit,HomeStates>(
                  listener: (context, state) {},
                  builder: (context, state) {return Flexible(
                    flex: 4,
                    child: PriceWidget(
                      onSale: productModel.isOnSale!,
                      price: productModel.price!,
                      salePrice: productModel.salePrice!,
                      textPrice: quantityTextController.text,
                    ),
                  );}
                ),
                Text(
                  productModel.isPiece!?'Piece':'KG',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(),
                    controller: quantityTextController,
                    style: TextStyle(fontSize: 18),
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    enabled: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(productModel.isPiece!?'[0-9]':'[0-9.]'))
                    ],
                    onFieldSubmitted: (q){
                      if(q.isEmpty)
                        quantityTextController.text = '1';
                    },
                    onChanged: (q) {
                      // HomeCubit.get(context).calculatePrice();
                      if(q.isNotEmpty)
                        HomeCubit.get(context).emit(HomeCalculatePriceState());
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                    cartCubit.addProductsToCart(productId: productModel.id!,quantity: int.parse(quantityTextController.text) ,context: context);
                },
                child: Text(
                  'In cart',
                  style: TextStyle(
                    color: ThemeCubit.get(context).isDarkTheme
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Theme.of(context).cardColor),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    )))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
