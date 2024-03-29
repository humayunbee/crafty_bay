import 'dart:convert';

import 'package:crafty_bay/products/models/product_model.dart';

class CartModel {
  int? id;
  int? userId;
  int? productId;
  String? color;
  String? size;
  int? qty;
  String? price;
  String? createdAt;
  String? updatedAt;
  ProductModel? product;

  CartModel(
      {this.id,
      this.userId,
      this.productId,
      this.color,
      this.size,
      this.qty = 1,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.product});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    userId = json['user_id'] ?? '';
    productId = json['product_id'] ?? '';
    color = json['color'] ?? '';
    size = json['size'] ?? '';
    qty = int.tryParse(json['qty']) ?? 1;
    price = json['price'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
  }

  String toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['color'] = color;
    data['size'] = size;
    data['qty'] = qty;
    return jsonEncode(data);
  }
}
