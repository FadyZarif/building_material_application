import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:building_material_application/constants/constants.dart';
import 'package:building_material_application/screens/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';


import '../cubits/cart_cubit/cart_cubit.dart';
import '../cubits/cart_cubit/cart_states.dart';
import '../cubits/cubits.dart';
import '../cubits/feeds_cubit/feeds_cubit.dart';
import '../widgets/cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartCubit cartCubit = CartCubit.get(context);
    FeedsCubit feedsCubit = FeedsCubit.get(context);
    int i = 3 ;
    double price =0 ;
    cartCubit.cartItems.forEach((key, value) {
      if(FeedsCubit.get(context).findProdById(value.productId!, HomeCubit.productsList).isOnSale ==false){
        price+= value.quantity! * FeedsCubit.get(context).findProdById(value.productId!, HomeCubit.productsList).price!;
        cartCubit.emit(CartChangeItemState());
      }else{
        price+=value.quantity! * FeedsCubit.get(context).findProdById(value.productId!, HomeCubit.productsList).salePrice!;
        cartCubit.emit(CartChangeItemState());
      }
    });

    return BlocConsumer<CartCubit,CartStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  const Text('Cart'),
                  Text('(${cartCubit.cartItems.length})'),
                ],
              ),
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
              actions: [
                IconButton(
                    onPressed: () {
                      defToast2(
                        autoHide: false,
                        context: context,
                        dialogType: DialogType.warning,
                        title: 'Clear Cart !',
                        desc: 'Your cart will be cleared!',
                        btnCancelOnPress: (){},
                        btnOkOnPress: () {
                          cartCubit.clearCart();
                        },
                      );
                    },
                    icon: Icon(
                      IconlyBroken.delete,
                      color: Colors.red,
                    ))
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.width * 0.13,
                            decoration: BoxDecoration(
                                color: ThemeCubit.get(context).isDarkTheme
                                    ? Colors.lightBlue
                                    : Colors.green,
                                borderRadius: BorderRadius.circular(12)),
                            child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.width * 0.13,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              onPressed: () {
                                if(cartCubit.cartItems.isNotEmpty){
                                  navigateTo(context, PaymentScreen(price: price));
                                }else{
                                  defToast2(context: context, title: 'cart is empty', dialogType: DialogType.error);
                                }
                              },
                              child: Text('Order Now',
                                  style: TextStyle(color: Colors.white)),
                            )),
                        Spacer(),
                        Text('Total: \$$price')
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return CartWidget(productId: cartCubit.cartItems.values.toList()[i].productId!,quantity: cartCubit.cartItems.values.toList()[i].quantity!,id:cartCubit.cartItems.values.toList()[i].id! ,);
                      },
                      separatorBuilder: (context, i) => SizedBox(
                        height: 10,
                      ),
                      itemCount: cartCubit.cartItems.length,
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
