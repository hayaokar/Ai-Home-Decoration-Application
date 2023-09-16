import 'package:flutter/material.dart';
import 'package:furniture_app/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../../admin_showProduct/adminShowProduct.dart';
import '../../../constants.dart';
import '../../../models/Product.dart';
import '../../../size_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        height: SizeConfig.orientation == Orientation.landscape
            ? SizeConfig.screenWidth
            : SizeConfig.screenHeight - AppBar().preferredSize.height,
        child: Stack(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ProductInfo(product: product),
            //Description
            Positioned(
              top: defaultSize * 37.5,
              left: 0,
              right: 0,
              child: ProductDescription(
                product: product,
                // press: () {},
              ),
            ),
            //for image
            Positioned(
              top: defaultSize * 9.5,
              right: -defaultSize * 7.5,
              child: Hero(
                tag: product.id,
                child: product.image_url != null && product.image_url.isNotEmpty
                    ? FadeInImage.assetNetwork(
                        placeholder: "assets/spinner.gif",
                        image: product.image_url,
                        fit: BoxFit.cover,
                        height: defaultSize * 37.8, //378
                        width: defaultSize * 36.4,
                      )
                    : Image.asset(
                        "assets/noImg.jpg",
                        height: defaultSize * 37.8, //378
                        width: defaultSize * 36.4,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    TextStyle lightTextStyle = TextStyle(color: kTextColor.withOpacity(0.6));
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultSize * 2),
      height: defaultSize * 37.5, //375
      width: defaultSize *
          (SizeConfig.orientation == Orientation.landscape ? 35 : 15), //150
      // color: Colors.black45,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(product.category.toString(), style: lightTextStyle),
            SizedBox(height: defaultSize),
            Text(
              product.name,
              style: TextStyle(
                fontSize: defaultSize * 2.4, //24
                fontWeight: FontWeight.bold,
                letterSpacing: -0.8,
                height: 1.4,
              ),
            ),
            SizedBox(height: defaultSize * 2),
            Text("Form", style: lightTextStyle),
            Text(
              "\$${product.price}",
              style: TextStyle(
                fontSize: defaultSize * 1.6, //16
                fontWeight: FontWeight.bold,
                height: 1.6,
              ),
            ),
            SizedBox(height: defaultSize * 2), //20
            // Text("Available Colors", style: lightTextStyle),
            // Row(
            //   children: <Widget>[
            //     buildColorBox(
            //       defaultSize,
            //       color: Color(0xFF7BA275),
            //       isActive: true,
            //     ),
            //     buildColorBox(
            //       defaultSize,
            //       color: Color(0xFFD7D7D7),
            //     ),
            //     buildColorBox(
            //       defaultSize,
            //       color: kTextColor,
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Container buildColorBox(double defaultSize,
      {Color color, bool isActive = false}) {
    return Container(
      margin: EdgeInsets.only(top: defaultSize, right: defaultSize),
      padding: const EdgeInsets.all(5),
      height: defaultSize * 2.4,
      width: defaultSize * 2.4,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

//________________________________________________
class ProductDescription extends StatefulWidget {
  const ProductDescription({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  int quantity = 1;
  Product product;

  @override
  void initState() {
    super.initState();
    product = widget.product;
  }

  void addToCart() async {
    var url = Uri.parse('http://10.0.2.2:8000/add-to-cart/');
    final prefs = await SharedPreferences.getInstance();
    final String action = prefs.getString("Authorization");
    var response = await http.post(
      url,
      headers: {"Authorization": 'Token $action'},
      body: {
        'product': product.id.toString(),
        'quantity': quantity.toString(),
      },
    );

    if (response.statusCode == 200) {
      print('dd');
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Container(
      constraints: BoxConstraints(minHeight: defaultSize * 44),
      padding: EdgeInsets.only(
        top: defaultSize * 9, //90
        left: defaultSize * 2, //20
        right: defaultSize * 2,
      ),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 253, 225, 187),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(defaultSize * 6.2),
          topRight: Radius.circular(defaultSize * 6.2),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.product.name,
              style: TextStyle(
                fontSize: defaultSize * 1.8,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: defaultSize * 3),
            Text(
              widget.product.description,
              // widget.product.id.toString(),
              style: TextStyle(
                color: kTextColor.withOpacity(0.7),
                height: 1.5,
              ),
            ),
            SizedBox(height: defaultSize * 3),
            Center(
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (quantity > 1) {
                            quantity--;
                          }
                        });
                      },
                    ),
                    Text(
                      quantity.toString(),
                      style: TextStyle(
                        fontSize: defaultSize * 1.6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                    SizedBox(width: defaultSize),
                    FlatButton(
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: defaultSize * 1.6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: EdgeInsets.all(defaultSize * 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: kPrimaryColor2,
                      onPressed: () {
                        addToCart();

                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text('Product added sccessfully'),
                                actions: [
                                  TextButton(
                                    child: Text('Ok'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
