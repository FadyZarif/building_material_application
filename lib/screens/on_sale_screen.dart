import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../cubits/home_cubit/home_cubit.dart';
import '../cubits/theme_cubit/theme_cubit.dart';
import '../widgets/on_sale_widget.dart';
import '../widgets/widgets.dart';

class OnSaleScreen extends StatelessWidget {
  const OnSaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isEmpty = false;
    ThemeCubit themeCubit = ThemeCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Products on sale',
          style: TextStyle(
              color: themeCubit.isDarkTheme ? Colors.blue : Colors.green),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(IconlyBroken.arrowLeft,
              color: themeCubit.isDarkTheme ? Colors.blue : Colors.green),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: isEmpty
          ?  Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Image.asset('assets/box.png'),
                    ),
                     Text(
                      'No Product On Sale yet',
                      style: TextStyle(fontSize: 40),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : GridView.count(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.92,
              children: List.generate(HomeCubit.get(context).onSaleProductsList.length, (index) =>  OnSaleWidget(productModel: HomeCubit.get(context).onSaleProductsList[index])),
            ),
    );
  }
}
