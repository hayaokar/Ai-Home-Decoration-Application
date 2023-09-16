import 'package:flutter/material.dart';
import 'package:furniture_app/constants.dart';
import 'package:furniture_app/size_config.dart';
// import '../admin_showProduct/adminShowProduct.dart';
import '../../models/Product.dart';
import '../CartScreen/cart_screen.dart';
import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;
  const DetailsScreen({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: buildAppBar(context),
      body: Body(product: product),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      foregroundColor: Color.fromARGB(131, 87, 73, 119),
      // backgroundColor: Color.fromARGB(255, 248, 177, 96).withOpacity(0.2),
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
