// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animate_do/animate_do.dart';
import 'package:e_commerce_app/utils/constants.dart';
import 'package:e_commerce_app/widget/reuseable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_app/model/base_model.dart';
import 'package:flutter/widgets.dart';

class Details extends StatefulWidget {
  const Details({
    super.key,
    required this.data,
    required this.isCameFromMostPopularParty,
  });
  final BaseModel data;
  final bool isCameFromMostPopularParty;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int selectedSize = 3;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;

    BaseModel current = widget.data;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width,
              height: size.height * 0.5,
              child: Stack(
                children: [
                  Hero(
                    tag: widget.isCameFromMostPopularParty ? current.imageUrl : current.id,
                    child: Container(
                      width: size.width,
                      height: size.height * 0.5,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(current.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: size.width,
                      height: size.height * 0.12,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradient,
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            FadeInUp(
              delay: const Duration(milliseconds: 300),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: size.width,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            current.name,
                            style: textTheme.displaySmall?.copyWith(fontSize: 23),
                          ),
                          ReUseableTextForDetails(text: current.price.toString()),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.006,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            current.star.toString(),
                            style: textTheme.headlineSmall,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "${current.review} K + review",
                            style: textTheme.headlineSmall?.copyWith(color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            FadeInUp(
              delay: const Duration(milliseconds: 300),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  bottom: 10,
                  top: 18,
                ),
                child: Text("Select Size", style: textTheme.displaySmall),
              ),
            ),
            SizedBox(
                width: size.width * 0.9,
                height: size.height * 0.08,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: sizes.length,
                  itemBuilder: (context, index) {
                    var current = sizes[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSize = index;
                        });
                      },
                      child: AnimatedContainer(
                        margin: const EdgeInsets.all(10),
                        duration: const Duration(
                          milliseconds: 300,
                        ),
                        width: size.width * 0.12,
                        decoration: BoxDecoration(
                          color: selectedSize == index ? primaryColor : Colors.transparent,
                          border: Border.all(color: primaryColor, width: 2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            current,
                            style: TextStyle(
                              color: selectedSize == index ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.favorite_border),
          color: Colors.white,
        ),
      ],
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_ios),
        color: Colors.white,
      ),
    );
  }
}
