import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CartModel {
   String? id, productId;
   int? quantity;

  CartModel({
    required this.id,
    required this.productId,
    required this.quantity,
  });

  CartModel.fromJson(Map<String, dynamic> json){
    id=json['id'];
    productId=json['productId'];
    quantity=json['quantity'];

  }

  Map<String,dynamic> toJson(){
    return {
      'id' : id,
      'productId' : productId,
      'quantity' : quantity,
    };
  }
}
