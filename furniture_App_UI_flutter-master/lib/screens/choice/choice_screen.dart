import 'package:flutter/material.dart';
import 'package:furniture_app/components/bottomAppBar.dart';
import 'package:furniture_app/screens/choice/components/body.dart';
import 'package:furniture_app/size_config.dart';

class choiceScreen extends StatelessWidget {
  const choiceScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
      bottomNavigationBar: BottomAppBar1(),
    );
  }
}
