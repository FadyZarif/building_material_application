class ProductModel {
   String? id, title, imageUrl, productCategoryName;
   double? price, salePrice;
   bool? isOnSale, isPiece;

  ProductModel(
      { this.id,
         this.title,
         this.imageUrl,
         this.productCategoryName,
         this.price,
         this.salePrice,
         this.isOnSale,
         this.isPiece});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageUrl = json['imageUrl'];
    productCategoryName = json['productCategoryName'];
    price = double.parse(json['price'].toString());
    salePrice = json['salePrice'] != null? double.parse(json['salePrice'].toString()):0.1;
    isOnSale = json['isOnSale'];
    isPiece = json['isPiece'];
  }

   Map<String, dynamic> toJson() {
     return {
       'id': id,
       'title': title,
       'imageUrl': imageUrl,
       'productCategoryName': productCategoryName,
       'price': price,
       'salePrice': salePrice,
       'isOnSale': isOnSale,
       'isPiece': isPiece,
     };
   }
}

