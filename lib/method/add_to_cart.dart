import 'package:advance_notification/advance_notification.dart';
import 'package:e_commerce_app/data/app_data.dart';
import 'package:e_commerce_app/model/base_model.dart';
import 'package:flutter/material.dart';

class AddToCart {
  static void addToCart(BaseModel data, BuildContext context) {
    bool contains = itemsOnCart.contains(data);

    if (contains == true) {
      ///data available on List
      const AdvanceSnackBar(
        textSize: 14.0,
        bgColor: Colors.red,
        message: "You have added this item to cart before",
        mode: Mode.ADVANCE,
        duration: Duration(seconds: 5),
      ).show(context);
    } else {
      itemsOnCart.add(data);
      const AdvanceSnackBar(
        textSize: 14.0,
        bgColor: Colors.green,
        message: "Successfully added to your cart",
        mode: Mode.ADVANCE,
        duration: Duration(seconds: 5),
      ).show(context);
    }
  }
}
