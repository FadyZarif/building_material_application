import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistModel {
   String? id, productId;

  WishlistModel({
    required this.id,
    required this.productId,
  });

  WishlistModel.fromJson(Map<String,dynamic> json){
    id=json['id'];
    productId=json['productId'];
  }

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'productId':productId,
    };
  }
}
