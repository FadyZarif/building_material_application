import 'package:flutter/material.dart';

import '../cubits/theme_cubit/theme_cubit.dart';
import '../widgets/categories_widget.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> catInfo = [
      {
        'imgPath': 'assets/copper/Cooper Tupe pipe.png',
        'catText': 'Copper',
        'color':const Color(0xff53B175),
      },
      {
        'imgPath': 'assets/machine/Drilling Machine.png',
        'catText': 'Machines',
        'color':const Color(0xffF8A44C),
      },
      {
        'imgPath': 'assets/steels/Stell pip.png',
        'catText': 'Steels',
        'color': const Color(0xffF7A593),
      },
      {
        'imgPath': 'assets/tools/Saw.png',
        'catText': 'Tools',
        'color': const Color(0xffD3B0E0),
      },
      {
        'imgPath': 'assets/woods/Plywood.png',
        'catText': 'Woods',
        'color':const Color(0xffFDE598),
      },

    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        elevation: 0,
        titleSpacing: 10,
        backgroundColor: ThemeCubit.get(context).isDarkTheme? Color(0xFF00001a) : Colors.white,
        titleTextStyle: Theme.of(context).textTheme.headline6?.copyWith(color: ThemeCubit.get(context).isDarkTheme? Colors.white : Colors.black,),
      ),
      body: GridView.count(
        padding: EdgeInsetsDirectional.all(10),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1,
          children: List.generate(5, (index) => CategoriesWidget(
            color: catInfo[index]['color'],
            catText: catInfo[index]['catText'],
            imgPath: catInfo[index]['imgPath'],

          ))
      ),
    );
  }
}
