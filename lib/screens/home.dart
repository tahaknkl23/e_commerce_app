import 'package:animate_do/animate_do.dart';
import 'package:e_commerce_app/data/app_data.dart';
import 'package:e_commerce_app/model/base_model.dart';
import 'package:e_commerce_app/model/categories_model.dart';
import 'package:e_commerce_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController _controller;
  @override
  void initState() {
    _controller = PageController(initialPage: 2, viewportFraction: 0.7);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Find your",
                          style: theme.displayLarge,
                          children: [
                            TextSpan(
                              text: "Style",
                              style: theme.displayLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 45, color: primaryColor),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: const TextSpan(
                          text: "Be more beatiful with our",
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                          children: [
                            TextSpan(
                              text: " suggestions:",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 45),
                child: Container(
                  margin: const EdgeInsets.only(top: 7),
                  height: size.height * 0.14,
                  width: size.width,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: categories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        CategoriesModel current = categories[index];

                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundImage: AssetImage(current.imageUrl),
                              ),
                              SizedBox(height: size.height * 0.008),
                              Text(
                                current.title,
                                style: theme.bodyLarge,
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 550),
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: size.width,
                  height: size.height * 0.47,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: mainList.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: view(index, size, theme),
                        onTap: () {},
                      );
                    },
                  ),
                ),
              ),
              FadeInUp(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Most Popular", style: theme.displaySmall),
                      Text("View All", style: theme.headlineMedium),
                    ],
                  ),
                ),
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 750),
                child: SizedBox(
                  width: size.width,
                  height: size.height * 0.44,
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: mainList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.62),
                    itemBuilder: (context, index) {
                      BaseModel current = mainList[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Container(
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
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Text(
                                current.name,
                                style: theme.displayMedium,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: "€ ",
                                style: theme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: primaryColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: current.price.toString(),
                                    style: theme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
    );
  }

  Widget view(
    int index,
    Size size,
    TextTheme theme,
  ) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          double value = 0.0;
          if (_controller.position.haveDimensions) {
            value = index.toDouble() - (_controller.page ?? 0);
            value = (value * 0.04).clamp(-1, 1);
          }
          return Transform.rotate(angle: 3.14 * value, child: _buildCard(size, mainList[index], theme));
        });
  }

  Padding _buildCard(Size size, BaseModel data, TextTheme theme) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          Container(
            width: size.width * 0.6,
            height: size.height * 0.35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              image: DecorationImage(
                image: AssetImage(data.imageUrl),
                fit: BoxFit.cover,
              ),
              boxShadow: const [
                BoxShadow(offset: Offset(0, 4), blurRadius: 5, color: Color.fromARGB(61, 0, 0, 0)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              data.name,
              style: theme.bodyLarge,
            ),
          ),
          RichText(
            text: TextSpan(
              text: "€ ",
              style: theme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: primaryColor,
              ),
              children: [
                TextSpan(
                  text: data.price.toString(),
                  style: theme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
