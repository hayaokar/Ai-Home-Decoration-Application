// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../components/already_have_an_account_acheck.dart';
// import '../../constants.dart';
// import '../../components/background.dart';
// import '../Login/login_screen.dart';
// import '../choice/choice_screen.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({Key key}) : super(key: key);

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   bool hidePassword = true;

//   void _togglePasswordView() {
//     setState(() {
//       hidePassword = !hidePassword;
//     });
//   }

//   TextEditingController usernameController = TextEditingController();

//   TextEditingController passwordController = TextEditingController();

//   TextEditingController password2Controller = TextEditingController();

//   TextEditingController emailController = TextEditingController();

//   TextEditingController firstNameController = TextEditingController();

//   TextEditingController lastNameController = TextEditingController();

//   bool _isLoding = false;

//   var token;

//   void register(
//       String email, username, password, password2, firstname, lastname) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     try {
//       Response respone =
//           await post(Uri.parse("http://10.0.2.2:8000/api/register/"), body: {
//         'username': usernameController.text,
//         'password': passwordController.text,
//         'password2': password2Controller.text,
//         'email': emailController.text,
//         'first_name': firstNameController.text,
//         'last_name': lastNameController.text,
//       });
//       print(jsonDecode(respone.body.toString()));
//       print(respone.statusCode);
//       if (respone.statusCode == 200) {
//         var data = jsonDecode(respone.body.toString());
//         print(respone.statusCode);
//         print(data);
//         print(data['message']);
//         token = data['token'];
//         if (data != null) {
//           setState(() {
//             _isLoding = false;
//           });

//           sharedPreferences.setString("Authorization", data['token']);

//           Navigator.of(context).pushAndRemoveUntil(
//               MaterialPageRoute(
//                   builder: (BuildContext context) => choiceScreen()),
//               (Route<dynamic> route) => false);
//         }
//       } else {
//         setState(() {
//           _isLoding = false;
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
//       body: Background(
//         child: SingleChildScrollView(
//           child: Container(
//             margin: EdgeInsets.only(left: 20, right: 20, top: 30),
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 SizedBox(
//                   width: double.infinity,
//                   child: Row(
//                     children: [
//                       const Spacer(),
//                       Expanded(
//                         flex: 1,
//                         child: Image.asset("assets/sigin.png"),
//                       ),
//                       const Spacer(),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: defaultPadding * 2),
//                 TextFormField(
//                   controller: usernameController,
//                   keyboardType: TextInputType.emailAddress,
//                   textInputAction: TextInputAction.next,
//                   cursorColor: kPrimaryColor,
//                   onSaved: (userNameController) {},
//                   decoration: InputDecoration(
//                     hintText: "Your user name",
//                     prefixIcon: Padding(
//                       padding: const EdgeInsets.all(defaultPadding),
//                       child: Icon(Icons.person),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 0),
//                   child: TextFormField(
//                     controller: emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     textInputAction: TextInputAction.next,
//                     cursorColor: kPrimaryColor,
//                     onSaved: (email) {},
//                     decoration: InputDecoration(
//                       hintText: "Your email",
//                       prefixIcon: Padding(
//                         padding: const EdgeInsets.all(defaultPadding),
//                         child: Icon(Icons.email),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 0),
//                   child: TextFormField(
//                     controller: passwordController,
//                     textInputAction: TextInputAction.done,
//                     obscureText: true,
//                     cursorColor: kPrimaryColor,
//                     decoration: InputDecoration(
//                       hintText: "Your password",
//                       suffixIcon: InkWell(
//                           onTap: _togglePasswordView,
//                           child: Icon(Icons.visibility)),
//                       prefixIcon: Padding(
//                         padding: const EdgeInsets.all(defaultPadding),
//                         child: Icon(Icons.lock),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 0),
//                   child: TextFormField(
//                     controller: password2Controller,
//                     textInputAction: TextInputAction.done,
//                     obscureText: true,
//                     cursorColor: kPrimaryColor,
//                     decoration: InputDecoration(
//                       hintText: "confirm Password ",
//                       suffixIcon: InkWell(
//                           onTap: _togglePasswordView,
//                           child: Icon(Icons.visibility)),
//                       prefixIcon: Padding(
//                         padding: const EdgeInsets.all(defaultPadding),
//                         child: Icon(Icons.lock),
//                       ),
//                     ),
//                   ),
//                 ),
//                 TextFormField(
//                   controller: firstNameController,
//                   keyboardType: TextInputType.emailAddress,
//                   textInputAction: TextInputAction.next,
//                   cursorColor: kPrimaryColor,
//                   onSaved: (userNameController) {},
//                   decoration: InputDecoration(
//                     hintText: "Your first name",
//                     prefixIcon: Padding(
//                       padding: const EdgeInsets.all(defaultPadding),
//                       child: Icon(Icons.person),
//                     ),
//                   ),
//                 ),
//                 TextFormField(
//                   controller: lastNameController,
//                   keyboardType: TextInputType.emailAddress,
//                   textInputAction: TextInputAction.next,
//                   cursorColor: kPrimaryColor,
//                   onSaved: (userNameController) {},
//                   decoration: InputDecoration(
//                     hintText: "Your last name",
//                     prefixIcon: Padding(
//                       padding: const EdgeInsets.all(defaultPadding),
//                       child: Icon(Icons.person),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 50),
//                 GestureDetector(
//                   onTap: usernameController.text == "" ||
//                           emailController.text == "" ||
//                           passwordController.text == "" ||
//                           password2Controller.text == "" ||
//                           firstNameController.text == "" ||
//                           lastNameController.text == ""
//                       ? null
//                       : () {
//                           setState(() {
//                             _isLoding = true;
//                           });
//                           register(
//                             usernameController.text.toString(),
//                             emailController.text.toString(),
//                             passwordController.text.toString(),
//                             password2Controller.text.toString(),
//                             firstNameController.text.toString(),
//                             lastNameController.text.toString(),
//                           );

//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 content: Text('LOGIN Please !!'),
//                                 actions: [
//                                   TextButton(
//                                     child: Text('Cancel'),
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                   ),
//                                   TextButton(
//                                     child: Text('login'),
//                                     onPressed: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => LoginScreen(),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         },
//                   child: Container(
//                     height: 50,
//                     decoration: BoxDecoration(
//                         color: kPrimaryColor2,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Center(
//                       child: Text("Sign Up".toUpperCase()),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: defaultPadding),
//                 AlreadyHaveAnAccountCheck(
//                   login: false,
//                   press: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) {
//                           return LoginScreen();
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/already_have_an_account_acheck.dart';
import '../../constants.dart';
import '../../components/background.dart';
import '../Login/login_screen.dart';
import '../choice/choice_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool hidePassword = true;

  void _togglePasswordView() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  bool _isLoading = false;
  var token;

  Future<void> register(
      String email, username, password, password2, firstname, lastname) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      setState(() {
        _isLoading = true;
      });

      http.Response response = await http
          .post(Uri.parse("http://10.0.2.2:8000/api/register/"), body: {
        'username': username,
        'password': password,
        'password2': password2,
        'email': email,
        'first_name': firstname,
        'last_name': lastname,
      });

      print(jsonDecode(response.body.toString()));
      print(response.statusCode);

      if (response.statusCode == 201) {
        var data = jsonDecode(response.body.toString());
        print(response.statusCode);
        print(data);
        print(data['message']);
        token = data['token'];

        if (data != null) {
          //sharedPreferences.setString("Authorization", data['token']);

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen()),
              (Route<dynamic> route) => false);
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('An error occurred. Please fill all the fields correctly.'),
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
            margin: EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      const Spacer(),
                      Expanded(
                        flex: 1,
                        child: Image.asset("assets/sigin.png"),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                SizedBox(height: defaultPadding * 2),
                TextFormField(
                  controller: usernameController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  onSaved: (userNameController) {},
                  decoration: InputDecoration(
                    hintText: "Your username",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    onSaved: (email) {},
                    decoration: InputDecoration(
                      hintText: "Your email",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.email),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: TextFormField(
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      hintText: "Your password",
                      suffixIcon: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(Icons.visibility)),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.lock),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: TextFormField(
                    controller: password2Controller,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      suffixIcon: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(Icons.visibility)),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.lock),
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  controller: firstNameController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  onSaved: (userNameController) {},
                  decoration: InputDecoration(
                    hintText: "Your first name",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
                TextFormField(
                  controller: lastNameController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  onSaved: (userNameController) {},
                  decoration: InputDecoration(
                    hintText: "Your last name",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: _isLoading
                      ? null
                      : () {
                          register(
                            emailController.text.toString(),
                            usernameController.text.toString(),
                            passwordController.text.toString(),
                            password2Controller.text.toString(),
                            firstNameController.text.toString(),
                            lastNameController.text.toString(),
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
                              "Sign Up".toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
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
