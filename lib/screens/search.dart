import 'package:animate_do/animate_do.dart';
import 'package:e_commerce_app/data/app_data.dart';
import 'package:e_commerce_app/method/add_to_cart.dart';
import 'package:e_commerce_app/screens/details.dart';
import 'package:e_commerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../model/base_model.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    itemsOnSearch = mainList;
    super.initState();
  }

  onSearchFunc(String search) {
    setState(() {
      itemsOnSearch = mainList.where((element) => element.name.toLowerCase().contains(search)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(), //bu şu işe yarıyor ki ekrana tıklandığında klavye kapanıyor
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              FadeInUp(
                delay: const Duration(milliseconds: 50),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                  child: SizedBox(
                    width: size.width,
                    height: size.height * 0.07,
                    child: TextField(
                      controller: _controller,
                      onChanged: (value) => onSearchFunc(value),
                      style: textTheme.displaySmall?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        filled: true,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _controller.clear();
                              FocusManager.instance.primaryFocus?.unfocus();
                            });
                          },
                          icon: const Icon(Icons.close),
                        ),
                        hintStyle: textTheme.displaySmall?.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                        ),
                        hintText: "e.g.Casual Jeans",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.01,
              ),
              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: itemsOnSearch.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.62),
                  itemBuilder: (context, index) {
                    BaseModel current = itemsOnSearch[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Details(
                              data: mainList[index],
                              isCameFromMostPopularParty: false,
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            top: size.height * 0.02,
                            left: size.width * 0.01,
                            right: size.width * 0.01,
                            child: Hero(
                              tag: current.id,
                              child: Container(
                                width: size.width * 0.5,
                                height: size.height * 0.3,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  image: DecorationImage(
                                    image: AssetImage(current.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(offset: Offset(0, 4), blurRadius: 5, color: Color.fromARGB(61, 0, 0, 0)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: size.height * 0.04,
                            child: Text(
                              current.name,
                              style: textTheme.displayMedium,
                            ),
                          ),
                          Positioned(
                            bottom: size.height * 0.01,
                            child: RichText(
                              text: TextSpan(
                                text: "€ ",
                                style: textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: primaryColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: current.price.toString(),
                                    style: textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: size.height * 0.01,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: primaryColor,
                              child: IconButton(
                                onPressed: () {
                                  AddToCart.addToCart(current, context);
                                },
                                icon: const Icon(LineIcons.addToShoppingCart),
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     FadeInUp(
              //       delay: const Duration(milliseconds: 200),
              //       child: Image.asset(
              //         "assets/images/searh_fail.png",
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //     SizedBox(
              //       height: size.height * 0.01,
              //     ),
              //     FadeInUp(
              //       delay: const Duration(milliseconds: 300),
              //       child: const Text(
              //         "No results found",
              //         style: TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.w400,
              //         ),
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
