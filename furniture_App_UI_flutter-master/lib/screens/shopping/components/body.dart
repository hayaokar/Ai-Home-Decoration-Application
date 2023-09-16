import 'package:flutter/material.dart';
import 'package:furniture_app/services/fetchCategories.dart';
import 'package:furniture_app/services/fetchProducts.dart';
import 'package:furniture_app/size_config.dart';
import 'categories.dart';
import 'recommond_products.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;

    // It enables scrolling
    return Container(
      color: Color.fromARGB(255, 248, 177, 96).withOpacity(0.2),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(defaultSize * 2), //20
                child: Text(
                  "Product Categories",
                ),
              ),
              FutureBuilder(
                future: fetchCategories(),
                builder: (context, snapshot) => snapshot.hasData
                    ? Categories(categories: snapshot.data)
                    : Center(child: Image.asset("assets/ripple.gif")),
              ),
              Divider(height: 5),
              Padding(
                padding: EdgeInsets.all(defaultSize * 2), //20
                child: Text("Products"),
              ),
              // Right Now product is our demo product
              FutureBuilder(
                future: fetchProducts(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? RecommandProducts(products: snapshot.data)
                      : Center(child: Image.asset('assets/ripple.gif'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
