// import 'package:flutter/material.dart';
// import 'package:furniture_app/screens/Login/login_screen.dart';
// import '../../../constants.dart';

// class ForgrtForm extends StatefulWidget {
//   const ForgrtForm({
//     Key key,
//   }) : super(key: key);

//   @override
//   State<ForgrtForm> createState() => _ForgrtFormState();
// }

// class _ForgrtFormState extends State<ForgrtForm> {
//   bool hidePassword = true;

//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       child: Column(
//         children: [
//           TextFormField(
//             controller: emailController,
//             keyboardType: TextInputType.emailAddress,
//             textInputAction: TextInputAction.next,
//             cursorColor: kPrimaryColor,
//             onSaved: (email) {},
//             decoration: InputDecoration(
//               hintText: "Your email",
//               prefixIcon: Padding(
//                 padding: const EdgeInsets.all(defaultPadding),
//                 child: Icon(Icons.person),
//               ),
//             ),
//           ),
//           // SizedBox(height: defaultPadding),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: defaultPadding),
//             child: TextFormField(
//               obscureText: hidePassword,
//               controller: passwordController,
//               textInputAction: TextInputAction.done,
//               cursorColor: kPrimaryColor,
//               decoration: InputDecoration(
//                 hintText: "New password",
//                 prefixIcon: Padding(
//                   padding: const EdgeInsets.all(defaultPadding),
//                   child: Icon(Icons.lock),
//                 ),
//               ),
//             ),
//           ),

//           // SizedBox(height: defaultPadding * 2),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: defaultPadding),
//             child: TextFormField(
//               obscureText: hidePassword,
//               controller: passwordController,
//               textInputAction: TextInputAction.done,
//               cursorColor: kPrimaryColor,
//               decoration: InputDecoration(
//                 hintText: "Confirm password",
//                 prefixIcon: Padding(
//                   padding: const EdgeInsets.all(defaultPadding),
//                   child: Icon(Icons.lock),
//                 ),
//               ),
//             ),
//           ),

//           SizedBox(height: defaultPadding * 2),
//           Hero(
//             tag: "login_btn",
//             child: SizedBox(
//               width: double.infinity,
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return LoginScreen();
//                       },
//                     ),
//                   );
//                 },
//                 child: Container(
//                   height: 50,
//                   decoration: BoxDecoration(
//                       color: kPrimaryColor2,
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Center(
//                     child: Text("continue".toUpperCase()),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: defaultPadding),
//         ],
//       ),
//     );
//   }
// }
