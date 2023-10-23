import 'package:building_material_application/widgets/price_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';


import '../constants/constants.dart';
import '../cubits/cart_cubit/cart_cubit.dart';
import '../cubits/cubits.dart';
import '../cubits/feeds_cubit/feeds_cubit.dart';
import '../cubits/history_cubit/history_cubit.dart';
import '../cubits/theme_cubit/theme_cubit.dart';
import '../cubits/wishlist_cubit/wishlist_cubit.dart';
import '../cubits/wishlist_cubit/wishlist_states.dart';
import '../models/products_model.dart';
import '../screens/product_details_screen.dart';
import 'heart_button.dart';

class CartWidget extends StatelessWidget {
  final String productId;
  final String id;
  final int quantity;

  const CartWidget({Key? key, required this.productId, required this.quantity, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartCubit cartCubit = CartCubit.get(context);
    FeedsCubit feedsCubit = FeedsCubit.get(context);
    final ProductModel productModel = feedsCubit.findProdById(productId,HomeCubit.productsList);
    TextEditingController quantityTextController =
        TextEditingController(text: '$quantity');

    return InkWell(
        onTap: () {
          navigateTo(context,ProductDetailsScreen(productModel: productModel,));
          HistoryCubit.get(context).addProductsToHistory(productId: productId);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ThemeCubit.get(context).isDarkTheme
                ? Color(0xFF0a0d2c).withOpacity(0.9)
                : const Color(0xFFF2FDFD).withOpacity(0.9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Image.asset(
                productModel.imageUrl!,
                height: MediaQuery.of(context).size.width * 0.25,
                width: MediaQuery.of(context).size.width * 0.25,
                fit: BoxFit.fill,
              ),
              Column(
                children: [
                  Text(
                    productModel.title!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(7)),
                          child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              padding: EdgeInsets.zero,
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: () {
                                if (int.parse(quantityTextController.text) >
                                    1) {
                                  quantityTextController.text =
                                      (int.parse(quantityTextController.text) -
                                              1)
                                          .toString();
                                  HomeCubit.get(context)
                                      .emit(HomeCalculatePriceState());
                                }
                              })),
                      SizedBox(
                        width: 35,
                        child: TextFormField(
                          decoration: InputDecoration(),
                          controller: quantityTextController,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          enabled: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                          ],
                          onFieldSubmitted: (q) {
                            if (q.isEmpty) quantityTextController.text = '1';
                          },
                          onChanged: (q) {
                            // HomeCubit.get(context).calculatePrice();
                            if (q.isNotEmpty)
                              HomeCubit.get(context)
                                  .emit(HomeCalculatePriceState());
                          },
                        ),
                      ),
                      Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(7)),
                          child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.zero,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                quantityTextController.text =
                                    (int.parse(quantityTextController.text) + 1)
                                        .toString();
                                HomeCubit.get(context)
                                    .emit(HomeCalculatePriceState());
                              })),
                    ],
                  )
                ],
              ),
              Spacer(),
              Column(
                children: [
                  IconButton(
                      onPressed: () {
                        cartCubit.deleteProductsFromCart(productId: productId,context: context,quantity: quantity,id: id);
                      },
                      icon: Icon(Icons.remove_shopping_cart_outlined)),
                  HeartButton(productId: productId),
                  SizedBox(
                    height: 5,
                  ),
                  BlocConsumer<HomeCubit, HomeStates>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return PriceWidget(
                          onSale: productModel.isOnSale!,
                          price: productModel.price!,
                          salePrice: productModel.salePrice!,
                          textPrice: quantityTextController.text,
                        );
                      }),
                ],
              )
            ],
          ),
        ));
  }
}
