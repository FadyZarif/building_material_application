import 'package:card_swiper/card_swiper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';


import '../constants/constants.dart';
import '../cubits/home_cubit/home_cubit.dart';
import '../cubits/home_cubit/home_states.dart';
import '../cubits/theme_cubit/theme_cubit.dart';
import '../widgets/feed_items.dart';
import '../widgets/on_sale_widget.dart';
import 'feeds_screen.dart';
import 'on_sale_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<String> _offerImages = [
      'assets/cover1.png',
      'assets/cover2.png',
      'assets/cover3.jpeg',
      'assets/cover4.png'
    ];
    HomeCubit homeCubit =HomeCubit.get(context);


    return Scaffold(
     body: BlocConsumer<HomeCubit,HomeStates>(

       listener: (context,state){},

       builder:(context,state) {
        return ConditionalBuilder(
          condition: true,
          builder: (context) => SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.33,
                  child: Swiper(
                    itemBuilder: (context, index) {
                      return Image.asset(
                        _offerImages[index],
                        fit: BoxFit.fill,
                      );
                    },
                    indicatorLayout: PageIndicatorLayout.SCALE,
                    autoplay: true,
                    itemCount: _offerImages.length,
                    pagination: SwiperPagination(
                        builder: DotSwiperPaginationBuilder(
                            color: Colors.white,
                            activeColor: ThemeCubit.get(context).isDarkTheme
                                ? Colors.lightBlue
                                : Colors.green)),
                    control: SwiperControl(
                        color: ThemeCubit.get(context).isDarkTheme
                            ? Colors.lightBlue
                            : Colors.green),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                TextButton(
                  onPressed: () {
                    navigateTo(context, OnSaleScreen());
                  },
                  child: Text(
                    'View all',
                    style: TextStyle(
                      color: ThemeCubit.get(context).isDarkTheme
                          ? Colors.blue
                          : Colors.green,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    RotatedBox(
                      quarterTurns: -1,
                      child: Row(
                        children: [
                          Text(
                            'On sale'.toUpperCase(),
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            IconlyBroken.discount,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Flexible(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: BlocConsumer<HomeCubit, HomeStates>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return ListView.separated(
                              itemCount: homeCubit.onSaleProductsList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) {
                                return OnSaleWidget(
                                  productModel: homeCubit.onSaleProductsList[i],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  width: 10,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Our Products',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        navigateTo(context, FeedsScreen());
                      },
                      child: Text(
                        'Browse all',
                        style: TextStyle(
                          color: ThemeCubit.get(context).isDarkTheme
                              ? Colors.blue
                              : Colors.green,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                BlocConsumer<HomeCubit, HomeStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.92,
                      children: List.generate(
                          HomeCubit.productsList.length < 4
                              ? HomeCubit.productsList.length
                              : 4,
                          (index) => FeedsWidget(
                                productModel: HomeCubit.productsList[index],
                              )),
                    );
                  },
                ),
                SizedBox(
                  height: 25,
                )
              ],
            ),
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
     )
    );
  }
}
