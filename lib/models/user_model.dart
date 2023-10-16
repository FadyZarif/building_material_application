
class UserModel {
  String? name;
  String? email;
  String? uId;
  String? phone;
  String? image;
  String? token;
  String? role;
  String? city;
  List? userWish;
  List? userCart;

  UserModel({
    this.name,
    this.email,
    this.uId,
    this.phone,
    this.image,
    this.token,
    this.role,
    this.city,
    this.userWish,
    this.userCart,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    uId = json['uId'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
    role = json['role'];
    city = json['city'];
    userWish = json['userWish'];
    userCart = json['userCart'];

  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
      'phone': phone,
      'image': image,
      'token': token,
      'role': role,
      'city': city,
      'userWish': userWish,
      'userCart': userCart,
    };
  }
}
