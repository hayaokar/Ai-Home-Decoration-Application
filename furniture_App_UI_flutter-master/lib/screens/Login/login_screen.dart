// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:furniture_app/components/background.dart';
// import 'package:http/http.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../components/already_have_an_account_acheck.dart';
// import '../../../constants.dart';
// import '../Signup/signup_screen.dart';
// import '../admin/admin.dart';
// import '../choice/choice_screen.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool hidePassword = true;
//   void _togglePasswordView() {
//     setState(() {
//       hidePassword = !hidePassword;
//     });
//   }

//   TextEditingController usernameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   bool _isLoding = false;
//   void login(String username, password) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

//     try {
//       Response respone = await post(
//           Uri.parse("http://10.0.2.2:8000/api/login/"),
//           body: {'username': username, 'password': password});
//       print(respone.statusCode);
//       if (respone.statusCode == 200) {
//         var data = jsonDecode(respone.body.toString());
//         print('token :');
//         print(data['token']);
//         print('message :');
//         print(data['message']);
//         if (data != null) {
//           print("statusCode : ");
//           print(respone.statusCode);
//           setState(() {
//             _isLoding = false;
//           });

//           sharedPreferences.setString("Authorization", data['token']);
//           if (data['type'] == 'normal') {
//             Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(
//                     builder: (BuildContext context) => choiceScreen()),
//                 (Route<dynamic> route) => false);
//           } else {
//             Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(
//                     builder: (BuildContext context) => DashboardScreen()),
//                 (Route<dynamic> route) => false);
//           }
//         }
//       } else {
//         setState(() {
//           _isLoding = false;
//           print("statusCode : ");
//           print(respone.statusCode);
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: Text('error'),
//                 // content: Text(
//                 //     '${respone.body}'),
//                 actions: [
//                   TextButton(
//                     child: Text('Cancel'),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               );
//             },
//           );
//         });
//         Text(respone.body);
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Background(
//       child: SingleChildScrollView(
//           child: Container(
//         //   child: Column(
//         //     children: [
//         // HeaderContainer("GoPark"),
//         // Container(
//         margin: EdgeInsets.only(left: 20, right: 20, top: 30),
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             SizedBox(
//               width: double.infinity,
//               child: Row(
//                 children: [
//                   const Spacer(),
//                   Expanded(
//                     flex: 3,
//                     child: Image.asset("assets/login.png"),
//                   ),
//                   const Spacer(),
//                 ],
//               ),
//             ),
//             TextFormField(
//               controller: usernameController,
//               keyboardType: TextInputType.emailAddress,
//               textInputAction: TextInputAction.next,
//               cursorColor: kPrimaryColor,
//               onSaved: (username) {},
//               decoration: InputDecoration(
//                 hintText: "Your username",
//                 prefixIcon: Padding(
//                   padding: const EdgeInsets.all(defaultPadding),
//                   child: Icon(Icons.person),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: defaultPadding),
//               child: TextFormField(
//                 obscureText: hidePassword,
//                 controller: passwordController,
//                 textInputAction: TextInputAction.done,
//                 cursorColor: kPrimaryColor,
//                 decoration: InputDecoration(
//                   hintText: "Your password",
//                   suffixIcon: InkWell(
//                       onTap: _togglePasswordView,
//                       child: Icon(Icons.visibility)),
//                   prefixIcon: Padding(
//                     padding: const EdgeInsets.all(defaultPadding),
//                     child: Icon(Icons.lock),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             GestureDetector(
//               onTap:
//                   usernameController.text == "" || passwordController.text == ""
//                       ? null
//                       : () {
//                           setState(() {
//                             _isLoding = true;
//                           });
//                           login(usernameController.text.toString(),
//                               passwordController.text.toString());
//                         },
//               child: Container(
//                 height: 50,
//                 decoration: BoxDecoration(
//                     color: kPrimaryColor2,
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Center(
//                   child: Text('Login'),
//                 ),
//               ),
//             ),
//             const SizedBox(height: defaultPadding),
//             AlreadyHaveAnAccountCheck(
//               press: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) {
//                       return SignUpScreen();
//                     },
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       )),
//     ));
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/background.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../Signup/signup_screen.dart';
import '../admin/admin.dart';
import '../choice/choice_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hidePassword = true;

  void _togglePasswordView() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> login(String username, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      setState(() {
        _isLoading = true;
      });

      final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/login/"),
        body: {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body.toString());
        sharedPreferences.setString("Authorization", data['token']);

        if (data['type'] == 'normal') {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => choiceScreen(),
            ),
            (Route<dynamic> route) => false,
          );
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => DashboardScreen(),
            ),
            (Route<dynamic> route) => false,
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Incorrect credentials!'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      const Spacer(),
                      Expanded(
                        flex: 3,
                        child: Image.asset("assets/login.png"),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                const SizedBox(height: 56),
                TextFormField(
                  controller: usernameController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  onSaved: (username) {},
                  decoration: InputDecoration(
                    hintText: "Your username",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: TextFormField(
                    obscureText: hidePassword,
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      hintText: "Your password",
                      suffixIcon: InkWell(
                        onTap: _togglePasswordView,
                        child: Icon(Icons.visibility),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.lock),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: _isLoading
                      ? null
                      : () {
                          login(
                            usernameController.text.toString(),
                            passwordController.text.toString(),
                          );
                        },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: kPrimaryColor2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: _isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: defaultPadding),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
