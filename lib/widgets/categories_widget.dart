import 'package:flutter/material.dart';


import '../constants/constants.dart';
import '../cubits/feeds_cubit/feeds_cubit.dart';
import '../cubits/home_cubit/home_cubit.dart';
import '../screens/feeds_screen.dart';

class CategoriesWidget extends StatelessWidget {
  final Color color;
  final String imgPath,catText;
  const CategoriesWidget({Key? key, required this.color, required this.imgPath, required this.catText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: (){
        FeedsCubit.changeCategoryProductsList(category: catText,feedsProductsList: HomeCubit.productsList);
        navigateTo(context, FeedsScreen(category: true,));
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 2,color: color.withOpacity(0.7))
        ),
        child: Column(
          children: [
            Container(
              width: _screenWidth*0.3,
              height: _screenWidth*0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(imgPath)),
              ),
            ),
            Text(catText,style: TextStyle(fontWeight: FontWeight.w600),)
          ],
        ),
      ),
    );
  }
}
