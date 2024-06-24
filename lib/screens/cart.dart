import 'package:animate_do/animate_do.dart';
import 'package:e_commerce_app/data/app_data.dart';
import 'package:e_commerce_app/main_wrapper.dart';
import 'package:e_commerce_app/model/base_model.dart';
import 'package:e_commerce_app/utils/constants.dart';
import 'package:e_commerce_app/widget/reuseable_button.dart';
import 'package:e_commerce_app/widget/reuseable_row_for_cart.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  //Calculate the total price
  double calculateTotalPrice() {
    double total = 0.0;
    if (itemsOnCart.isEmpty) {
      total = 0.0;
    } else {
      for (BaseModel data in itemsOnCart) {
        total = total + data.price * data.value;
      }
    }
    return total;
  }

  //Calculate sub total price
  int calculateSubTotal() {
    int subTotal = 0;
    if (itemsOnCart.isEmpty) {
      subTotal = 0;
    } else {
      for (BaseModel data in itemsOnCart) {
        subTotal = subTotal + data.price.round();
        subTotal = subTotal - 160;
      }
    }
    return subTotal < 0 ? 0 : subTotal;
  }

  //Calculate shipping
  double calculateShipping() {
    double shipping = 0.0;
    if (itemsOnCart.isEmpty) {
      shipping = 0.0;
      return shipping;
    } else if (itemsOnCart.length <= 4) {
      shipping = 25.99;
      return shipping;
    } else {
      shipping = 88.99;
      return shipping;
    }
  }

//delete current selected item from List
  void onDelete(BaseModel data) {
    setState(() {
      if (itemsOnCart.length == 1) {
        itemsOnCart.clear();
      } else {
        itemsOnCart.removeWhere((element) => element.id == data.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.height * 0.6,
              child: itemsOnCart.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: itemsOnCart.length,
                      itemBuilder: (context, index) {
                        var current = itemsOnCart[index];
                        return FadeInUp(
                          delay: Duration(milliseconds: 100 * index + 80),
                          child: Container(
                            margin: const EdgeInsets.all(5.0),
                            width: size.width,
                            height: size.height * 0.25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(5.0),
                                  width: size.width * 0.4,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage(current.imageUrl), fit: BoxFit.cover),
                                    boxShadow: const [
                                      BoxShadow(offset: Offset(0, 4), blurRadius: 4, color: Color.fromARGB(61, 0, 0, 0)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.52,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              current.name,
                                              style: const TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                onDelete(current);
                                              },
                                              icon: const Icon(
                                                Icons.close,
                                                color: Colors.grey,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: "€ ",
                                          style: textTheme.titleSmall?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 26,
                                            color: primaryColor,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: current.price.toString(),
                                              style: textTheme.titleSmall?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.04,
                                        child: Text(
                                          "Size = ${sizes[3]}",
                                          style: textTheme.titleSmall?.copyWith(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: size.height * 0.058,
                                        ),
                                        width: size.width * 0.4,
                                        height: size.height * 0.04,
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.all(4.0),
                                              width: size.width * 0.065,
                                              height: size.height * 0.045,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(color: Colors.grey),
                                              ),
                                              child: InkWell(
                                                borderRadius: BorderRadius.circular(10),
                                                onTap: () {
                                                  setState(() {
                                                    if (current.value > 1) {
                                                      current.value--;
                                                    } else {
                                                      onDelete(current);
                                                      current.value = 1;
                                                    }
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.remove,
                                                  size: 16,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                                              child: Text(
                                                current.value.toString(),
                                                style: textTheme.titleSmall?.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.all(4.0),
                                              width: size.width * 0.065,
                                              height: size.height * 0.045,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(color: Colors.grey),
                                              ),
                                              child: InkWell(
                                                borderRadius: BorderRadius.circular(10),
                                                onTap: () {
                                                  setState(() {
                                                    current.value >= 0 ? current.value++ : null;
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.add,
                                                  size: 16,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        FadeInUp(
                          delay: const Duration(milliseconds: 200),
                          child: const Image(
                            image: AssetImage("assets/images/empty.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        FadeInUp(
                          delay: const Duration(milliseconds: 250),
                          child: SizedBox(
                            height: size.height * 0.01,
                          ),
                        ),
                        const Text(
                          "Your cart is empty right now :( ",
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                        ),
                        FadeInUp(
                          delay: const Duration(milliseconds: 300),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainWrapper(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.shopping_bag_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.white,
                width: size.width,
                height: size.height * 0.4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
                  child: Column(
                    children: [
                      FadeInUp(
                        delay: const Duration(milliseconds: 350),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Promo/Student Code or Vourchers",
                              style: textTheme.displaySmall?.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        child: ReUseAbleCartForRow(
                          text: "Sub Total",
                          price: calculateSubTotal().toDouble(),
                        ),
                      ),
                      FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        child: ReUseAbleCartForRow(
                          text: "Shipping",
                          price: calculateShipping(),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Divider(),
                      ),
                      FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        child: ReUseAbleCartForRow(
                          text: "Total",
                          price: calculateTotalPrice(),
                        ),
                      ),
                      FadeInUp(
                        delay: const Duration(milliseconds: 550),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: ReUseAbleButton(
                            text: "CheckOut",
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Cart(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        "My Cart",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            LineIcons.user,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
