import 'package:flutter/material.dart';
import '../../constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don’t have an Account ? " : "Already have an Account ? ",
          style: const TextStyle(
            color: Color.fromARGB(188, 151, 81, 2),
          ),
        ),
        GestureDetector(
          onTap: press as void Function(),
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: const TextStyle(
              color: Color.fromARGB(255, 92, 49, 0),
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
