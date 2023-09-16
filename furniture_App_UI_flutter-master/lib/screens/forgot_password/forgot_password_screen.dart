// import 'package:flutter/material.dart';
// import '../../responsive.dart';
// import '../../components/background.dart';
// import 'components/forget_text.dart';
// import 'components/forgrtForm.dart';

// class ForgotPasswordScreen extends StatefulWidget {
//   const ForgotPasswordScreen({Key key}) : super(key: key);

//   @override
//   State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
// }

// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Background(
//         child: SingleChildScrollView(
//           physics: BouncingScrollPhysics(),
//           child: Responsive(
//             mobile: const MobileLoginScreen(),
//             desktop: Row(
//               children: [
//                 const Expanded(
//                   child: Forget_text(),
//                 ),
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       SizedBox(
//                         width: 450,
//                         child: ForgrtForm(),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MobileLoginScreen extends StatelessWidget {
//   const MobileLoginScreen({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         const Forget_text(),
//         Row(
//           children: const [
//             Spacer(),
//             Expanded(
//               flex: 8,
//               child: ForgrtForm(),
//             ),
//             Spacer(),
//           ],
//         ),
//       ],
//     );
//   }
// }
