import 'package:flutter/material.dart';
import '../../../constants.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text(
        // "𝔣𝔲𝔯𝔫𝔦𝔱𝔲𝔯𝔢 𝔰𝔱𝔬𝔯𝔢",
        // "𝒻𝓊𝓇𝓃𝒾𝓉𝓊𝓇𝑒 𝓈𝓉𝑜𝓇𝑒",
        // "𝕗𝕦𝕣𝕟𝕚𝕥𝕦𝕣𝕖 𝕤𝕥𝕠𝕣𝕖",
        // "ᖴᑌᖇᑎITᑌᖇE  ᔕTOᖇE",
        // style: TextStyle(
        //     letterSpacing: -1.8,
        //     fontWeight: FontWeight.bold,
        //     shadows: <Shadow>[
        //       Shadow(
        //         offset: Offset(3.0, 3.0),
        //         blurRadius: 10.0,
        //         color: Color.fromARGB(169, 197, 154, 90),
        //       ),
        // ],
        // color: kPrimaryLightColor,
        // fontSize: 27),
        // ),
        // SizedBox(height: defaultPadding * 3),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 10,
              child: Image.asset(
                "assets/logo.png",
                width: 350,
                height: 350,
              ),
            ),
            Spacer(),
          ],
        ),
        SizedBox(height: defaultPadding * 3),
      ],
    );
  }
}
