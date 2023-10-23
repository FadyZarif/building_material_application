import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';


import '../cubits/cart_cubit/cart_cubit.dart';
import '../cubits/cubits.dart';
import '../models/products_model.dart';
import '../widgets/heart_button.dart';
import '../widgets/price_widget.dart';
import '../widgets/widgets.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel productModel;
  const ProductDetailsScreen({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController quantityTextController =
        TextEditingController(text: '1');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        backgroundColor: ThemeCubit.get(context).isDarkTheme
            ? Color(0xFF00001a)
            : Colors.white,
        titleTextStyle: Theme.of(context).textTheme.headline6?.copyWith(
              color: ThemeCubit.get(context).isDarkTheme
                  ? Colors.white
                  : Colors.black,
            ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: FancyShimmerImage(
                imageUrl: productModel.imageUrl!,
                boxFit: BoxFit.fill,
                shimmerBackColor: Colors.grey,
                shimmerHighlightColor: Colors.white70,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                  color: ThemeCubit.get(context).isDarkTheme
                      ? const Color(0xFF0a0d2c).withOpacity(0.9)
                      : const Color(0xFFF2FDFD).withOpacity(0.9),
                borderRadius: BorderRadius.vertical(top: Radius.circular(40))
              ),
              padding: EdgeInsets.all(15),

              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        productModel.title!,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      HeartButton(productId: productModel.id!)
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      PriceWidget(
                        onSale: productModel.isOnSale!,
                        price: productModel.price!,
                        salePrice: productModel.salePrice!,
                        textPrice: '1',
                      ),
                      Text(productModel.isPiece!?'/Piece':'/Kg'),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: ThemeCubit.get(context).isDarkTheme
                                ? Colors.lightBlue
                                : Colors.green,
                            borderRadius: BorderRadius.circular(6)),
                        child: Text('Free delivery',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                                color: Colors.white)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        width: MediaQuery.of(context).size.width /4,
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
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Total',style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold),),
                          BlocConsumer<HomeCubit,HomeStates>(
                              listener: (context, state) {},
                              builder: (context, state) {return PriceWidget(
                                onSale: productModel.isOnSale!,
                                price: productModel.price!,
                                salePrice: productModel.salePrice!,
                                textPrice: quantityTextController.text,
                              );}
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                            color: ThemeCubit.get(context).isDarkTheme
                                ? Colors.lightBlue
                                : Colors.green,
                            borderRadius: BorderRadius.circular(6)),
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          onPressed: (){
                              CartCubit.get(context).addProductsToCart(productId: productModel.id!,quantity: 1,context: context );
                          },
                          child: Text('In Cart',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                  color: Colors.white)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
