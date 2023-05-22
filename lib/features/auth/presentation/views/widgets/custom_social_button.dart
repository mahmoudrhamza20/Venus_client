
import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key, required this.image, required this.imgColor,
  });
  final String image;
  final Color imgColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400,width: 1),
                shape: BoxShape.circle,
              ),
            ),
            Image.asset(image,color: imgColor,width: 35,height: 35,),
          ],
        ),
      ),
    );
  }
}