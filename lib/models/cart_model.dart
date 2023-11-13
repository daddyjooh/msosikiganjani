import 'package:msosikiganjani/models/product_model.dart';

class CartModel {
  int? id;
  int? quantity;
  String? name;
  int? price;
  String? img;
  bool? isExit;
  String? time;
  ProductModel? productModel;

  CartModel(
      {this.id,
      this.name,
      this.price,
      this.img,
      this.isExit,
      this.time,
      this.quantity,
      this.productModel});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    isExit = json['isExit'];
    time = json['time'];
    quantity = json['quantity'];
    productModel = ProductModel.fromJson(json['productModel']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "price": this.price,
      "img": this.img,
      "quantity": this.quantity,
      "isExist": this.isExit,
      "time": this.time,
      "productModel": this.productModel!.toJson()
    };
  }
}
