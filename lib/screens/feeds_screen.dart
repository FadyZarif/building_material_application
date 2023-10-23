import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../cubits/feeds_cubit/feeds_cubit.dart';
import '../cubits/feeds_cubit/feeds_states.dart';
import '../cubits/home_cubit/home_cubit.dart';
import '../cubits/theme_cubit/theme_cubit.dart';
import '../widgets/feed_items.dart';

class FeedsScreen extends StatelessWidget {
  final bool? category;
  const FeedsScreen({Key? key, this.category =false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FeedsCubit feedsCubit = FeedsCubit.get(context);
    TextEditingController searchTextController = TextEditingController();
    FocusNode searchFocusNode = FocusNode();
    ThemeCubit themeCubit = ThemeCubit.get(context);
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'All Products',
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: kBottomNavigationBarHeight,
                child: TextField(
                  cursorColor: ThemeCubit.get(context).isDarkTheme
                      ? Colors.lightBlue
                      : Colors.green,
                  focusNode: searchFocusNode,
                  controller: searchTextController,
                  onChanged: (value){
                    feedsCubit.searchProduct(q: value, category: category??false,feedsProductsList: HomeCubit.productsList);

                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: ThemeCubit.get(context).isDarkTheme
                          ? Colors.lightBlue
                          : Colors.green,width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey
                          ,width: 1),
                    ),
                    hintText: 'What\'s in your mind',
                    prefixIcon: const Icon(Icons.search,color: Colors.grey,),
                    suffix: IconButton(

                      onPressed: (){
                        searchTextController.clear();
                        searchFocusNode.unfocus();
                        feedsCubit.emit(FeedsSearchState());
                      },
                      icon: const Icon(Icons.close,color: Colors.red,),
                    )

                  ),

                ),
              ),
              SizedBox(height: 20,),
              BlocConsumer<FeedsCubit,FeedsStates>(
                listener: (context,state){},
                builder: (context,state)=>GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.92,
                  children: List.generate(searchTextController.text.isNotEmpty?feedsCubit.filteredProductsList!.length:category == false?HomeCubit.productsList.length:FeedsCubit.categoryProductsList!.length, (index) => FeedsWidget(productModel:searchTextController.text.isNotEmpty?feedsCubit.filteredProductsList![index]:category == false? HomeCubit.productsList[index]:FeedsCubit.categoryProductsList![index])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
