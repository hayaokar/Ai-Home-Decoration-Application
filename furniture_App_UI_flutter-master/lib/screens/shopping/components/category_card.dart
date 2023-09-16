import 'package:flutter/material.dart';
import 'package:furniture_app/models/Categories.dart';
import 'package:furniture_app/screens/shopping/components/recommond_products.dart';
import '../../../constants.dart';
import '../../../models/Product.dart';
import '../../../size_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../CartScreen/cart_screen.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Padding(
      padding: EdgeInsets.all(defaultSize * 2),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryProductsScreen(
                category: category,
              ),
            ),
          );
        },
        child: SizedBox(
          width: defaultSize * 20.5,
          child: AspectRatio(
            aspectRatio: 0.83,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                ClipPath(
                  clipper: CategoryCustomShape(),
                  child: AspectRatio(
                    aspectRatio: 1.025,
                    child: Container(
                      padding: EdgeInsets.all(defaultSize * 2),
                      color: kSecondaryColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(category.name),
                          SizedBox(height: defaultSize),
                          // Text(
                          //   "${category.numOfProducts}+ Products",
                          //   style: TextStyle(
                          //     color: kTextColor.withOpacity(0.6),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AspectRatio(
                    aspectRatio: 1.15,
                    child: category.image_url != null &&
                            category.image_url.isNotEmpty
                        ? FadeInImage.assetNetwork(
                            placeholder: "assets/spinner.gif",
                            image: category.image_url,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            "assets/noImg.jpg",
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryProductsScreen extends StatefulWidget {
  final Category category;

  CategoryProductsScreen({Key key, this.category}) : super(key: key);

  @override
  _CategoryProductsScreenState createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  List<Product> categoryProducts = [];

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts(widget.category);
  }
  // http://127.0.0.1:8000/

  Future<List<Product>> fetchCategoryProducts(Category category) async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/products/category/${category.id}/'));

    if (response.statusCode == 200) {
      List<Product> responseData = (json.decode(response.body) as List)
          .map((data) => Product.fromJson(data))
          .toList();
      setState(() {
        categoryProducts = responseData;
      });
      return responseData;
    } else {
      throw Exception('Failed to fetch category products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        color: Color.fromARGB(255, 248, 177, 96).withOpacity(0.2),
        child: categoryProducts.isEmpty
            ? Center(child: Text('No Product Available'))
            : RecommandProducts(products: categoryProducts),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Center(child: Text(widget.category.name)),
      foregroundColor: Color.fromARGB(131, 87, 73, 119),
      backgroundColor: Color.fromARGB(255, 248, 177, 96).withOpacity(0.2),
      actions: <Widget>[
        Center(
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart
                    // height: SizeConfig.defaultSize * 4, //20
                    ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return CartScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(width: SizeConfig.defaultSize),
      ],
    );
  }
}

class CategoryCustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double height = size.height;
    double width = size.width;
    double cornerSize = 30;

    path.lineTo(0, height - cornerSize);
    path.quadraticBezierTo(0, height, cornerSize, height);
    path.lineTo(width - cornerSize, height);
    path.quadraticBezierTo(width, height, width, height - cornerSize);
    path.lineTo(width, cornerSize);
    path.quadraticBezierTo(width, 0, width - cornerSize, 0);
    path.lineTo(cornerSize, cornerSize * 0.75);
    path.quadraticBezierTo(0, cornerSize, 0, cornerSize * 2);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
