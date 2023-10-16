import 'package:flutter/material.dart';

import '../cubits/theme_cubit/theme_cubit.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({Key? key, required this.onSale, required this.salePrice, required this.price, required this.textPrice}) : super(key: key);
  final bool onSale ;
  final double salePrice,price;
  final String textPrice;
  @override
  Widget build(BuildContext context) {
    double userPrice = onSale? salePrice : price;
    return Row(
      children:  [
        Text(
          '\$${(userPrice * double.parse(textPrice)).toStringAsFixed(2)}',
          style: TextStyle(
            color: ThemeCubit.get(context).isDarkTheme? Colors.blue:Colors.green,
            fontSize: 22,
          ),
        ),
         if(onSale)
         const SizedBox(
          width: 5,
        ),
        if(onSale)
         Text(
          '\$${(price * int.parse(textPrice)).toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 15,
            decoration: TextDecoration.lineThrough,
          ),
        )
      ],
    );
  }
}
