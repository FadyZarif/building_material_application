import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../models/products_model.dart';
import 'feeds_states.dart';

class FeedsCubit extends Cubit<FeedsStates>{
  FeedsCubit() : super(FeedsInitState());
  static FeedsCubit get(context) => BlocProvider.of(context);

  static  List<ProductModel> categoryProductsList=[];
  static final List<ProductModel> productsList = [
    ProductModel(
      id: 'Cooper Tupe pipe',
      title: 'Cooper Tupe pipe',
      price: 0.99,
      salePrice: 0.49,
      imageUrl: 'assets/copper/Cooper Tupe pipe.png',
      productCategoryName: 'Copper',
      isOnSale: true,
      isPiece: true,
    ),
    ProductModel(
      id: 'Cement mixer',
      title: 'Cement mixer',
      price: 0.88,
      salePrice: 0.5,
      imageUrl: 'assets/machine/Cement mixer.png',
      productCategoryName: 'Machines',
      isOnSale: false,
      isPiece: true,
    ),
    ProductModel(
      id: 'Steel pip',
      title: 'Steel pip',
      price: 1.22,
      salePrice: 0.7,
      imageUrl: 'assets/steels/Stell pip.png',
      productCategoryName: 'Steels',
      isOnSale: true,
      isPiece: true,
    ),
    ProductModel(
      id: 'Saw',
      title: 'Saw',
      price: 1.5,
      salePrice: 0.5,
      imageUrl: 'assets/tools/Saw.png',
      productCategoryName: 'Tools',
      isOnSale: true,
      isPiece: true,
    ),
    ProductModel(
      id: 'Plywood',
      title: 'Plywood',
      price: 0.99,
      salePrice: 0.4,
      imageUrl: 'assets/woods/Plywood.png',
      productCategoryName: 'Woods',
      isOnSale: false,
      isPiece: false,
    ),
    ProductModel(
      id: 'Drilling Machine',
      title: 'Drilling Machine',
      price: 0.6,
      salePrice: 0.2,
      imageUrl: 'assets/machine/Drilling Machine.png',
      productCategoryName: 'Machines',
      isOnSale: true,
      isPiece: true,
    ),
    // Vegi
    ProductModel(
      id: 'Ribbed bars',
      title: 'Ribbed bars',
      price: 0.99,
      salePrice: 0.5,
      imageUrl: 'assets/steels/Ribbed bars.png',
      productCategoryName: 'Steels',
      isOnSale: true,
      isPiece: false,
    ),
    ProductModel(
      id: 'Hammer',
      title: 'Hammer',
      price: 1.99,
      salePrice: 0.99,
      imageUrl: 'assets/tools/Hammer.png',
      productCategoryName: 'Tools',
      isOnSale: false,
      isPiece: true,
    ),
    ProductModel(
      id: 'Column wood',
      title: 'Column wood',
      price: 0.99,
      salePrice: 0.5,
      imageUrl: 'assets/woods/Column wood.jpeg',
      productCategoryName: 'Woods',
      isOnSale: false,
      isPiece: false,
    ),
    ProductModel(
      id: 'Generator',
      title: 'Generator',
      price: 1.99,
      salePrice: 0.89,
      imageUrl: 'assets/machine/Generator.png',
      productCategoryName: 'Machines',
      isOnSale: false,
      isPiece: true,
    ),
    ProductModel(
      id: 'Ladder',
      title: 'Ladder',
      price: 2.99,
      salePrice: 1.59,
      imageUrl: 'assets/steels/Ladder.png',
      productCategoryName: 'Steels',
      isOnSale: false,
      isPiece: true,
    ),
    ProductModel(
      id: 'Nail',
      title: 'Nail',
      price: 0.59,
      salePrice: 0.28,
      imageUrl: 'assets/tools/Nail.png',
      productCategoryName: 'Tools',
      isOnSale: false,
      isPiece: false,
    ),
    ProductModel(
      id: 'Tmt bars',
      title: 'Tmt bars',
      price: 0.99,
      salePrice: 0.389,
      imageUrl: 'assets/steels/Tmt bars.png',
      productCategoryName: 'Steels',
      isOnSale: false,
      isPiece: true,
    ),
    ProductModel(
      id: 'Nut',
      title: 'Nut',
      price: 0.99,
      salePrice: 0.59,
      imageUrl: 'assets/tools/Nut.png',
      productCategoryName: 'Tools',
      isOnSale: true,
      isPiece: true,
    ),
    ProductModel(
      id: 'Alloy steel',
      title: 'Alloy steel',
      price: 0.99,
      salePrice: 0.79,
      imageUrl: 'assets/steels/Alloy steel.jpeg',
      productCategoryName: 'Steels',
      isOnSale: false,
      isPiece: true,
    ),
    ProductModel(
      id: 'Screw',
      title: 'Screw',
      price: 0.99,
      salePrice: 0.57,
      imageUrl: 'assets/tools/Screw.png',
      productCategoryName: 'Tools',
      isOnSale: false,
      isPiece: false,
    ),
    ProductModel(
      id: 'Scaffolding',
      title: 'Scaffolding',
      price: 3.99,
      salePrice: 2.99,
      imageUrl: 'assets/steels/Scaffolding.png',
      productCategoryName: 'Steels',
      isOnSale: true,
      isPiece: true,
    ),
    ProductModel(
      id: 'Screw driver',
      title: 'Screw driver',
      price: 0.99,
      salePrice: 0.39,
      imageUrl: 'assets/tools/Screw driver.png',
      productCategoryName: 'Tools',
      isOnSale: true,
      isPiece: true,
    ),
    // Grains
    ProductModel(
      id: 'Spanner',
      title: 'Spanner',
      price: 0.29,
      salePrice: 0.19,
      imageUrl: 'assets/tools/Spanner.png',
      productCategoryName: 'Tools',
      isOnSale: false,
      isPiece: true,
    ),
    ProductModel(
      id: 'Peas',
      title: 'Peas',
      price: 0.99,
      salePrice: 0.49,
      imageUrl: 'assets/tools/Spirit level.png',
      productCategoryName: 'Tools',
      isOnSale: false,
      isPiece: true,
    ),
    // Herbs
    ProductModel(
      id: 'Tape measure',
      title: 'Tape measure',
      price: 6.99,
      salePrice: 4.99,
      imageUrl: 'assets/tools/Tape measure.png',
      productCategoryName: 'Tools',
      isOnSale: false,
      isPiece: true,
    ),

  ];

  // static List<ProductModel> feedsProductsList=HomeCubit.productsList;

  ProductModel findProdById(String productId,List<ProductModel> feedsProductsList) {
    return feedsProductsList.firstWhere((element) => element.id == productId);
  }

  static void changeCategoryProductsList({required String category,required List<ProductModel> feedsProductsList}){
    categoryProductsList = feedsProductsList.where((element) => element.productCategoryName==category).toList();
  }

  List<ProductModel>?filteredProductsList;

  void searchProduct({required String q,required bool category,required List<ProductModel> feedsProductsList}){
    if(category == true){
    filteredProductsList = categoryProductsList.where((element) => element.title!.toLowerCase().contains(q.toLowerCase())).toList();
    }else if(category == false){
      filteredProductsList = feedsProductsList.where((element) => element.title!.toLowerCase().contains(q.toLowerCase())).toList();
    }
    emit(FeedsSearchState());
  }


}