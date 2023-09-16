import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        // return Background(
        // child: Column(
        // children: <Widget>[

        //   Text(
        //     "services",
        //     style: TextStyle(
        //       fontSize: 25,
        //       fontWeight: FontWeight.bold,
        //       color: kPrimaryColor,
        //       shadows: <Shadow>[
        //         Shadow(
        //           offset: Offset(3.0, 3.0),
        //           blurRadius: 10.0,
        //           color: Color.fromARGB(169, 133, 172, 96),
        //         ),
        //       ],
        //     ),
        //   ),
        //   SizedBox(
        //     height: 60,
        //   ),
        //   Expanded(
        //     child: Padding(
        //       padding:
        //           EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2),
        //       child: GridView.builder(
        //         itemCount: recipeBundles.length,
        //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //           crossAxisCount:
        //               SizeConfig.orientation == Orientation.landscape ? 2 : 1,
        //           mainAxisSpacing: 20,
        //           crossAxisSpacing:
        //               SizeConfig.orientation == Orientation.landscape
        //                   ? SizeConfig.defaultSize * 2
        //                   : 0,
        //           childAspectRatio: 1.65,
        //         ),
        //         itemBuilder: (context, index) => RecipeBundelCard(
        //           recipeBundle: recipeBundles[index],
        //           press: () {},
        //         ),
        //       ),
        //     ),
        //   ),
        // ],
        // ),
        );
  }
}
// 