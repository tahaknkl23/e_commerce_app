import 'package:animate_do/animate_do.dart';
import 'package:e_commerce_app/widget/reuseable_button.dart';
import 'package:e_commerce_app/widget/reuseable_row_for_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
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
            Container(
              color: Colors.red,
              width: size.width,
              height: size.height * 0.6,
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.white,
                width: size.width,
                height: size.height * 0.36,
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
                        child: const ReUseAbleCartForRow(
                          text: "Sub Total",
                          price: 140.0,
                        ),
                      ),
                      FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        child: const ReUseAbleCartForRow(
                          text: "Shipping",
                          price: 140.0,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Divider(),
                      ),
                      FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        child: const ReUseAbleCartForRow(
                          text: "Total",
                          price: 500,
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
