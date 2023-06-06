import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class SocialButton extends StatelessWidget {
  final void Function() onPressed;
    String text="";
   SocialButton({required this.onPressed,required this.text,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w,
      height: 5.h,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: HexColor("#4154FC"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        icon: FaIcon(FontAwesomeIcons.linkedinIn,color: Colors.white,),
        label: Text("LinkedIN",),
      ),
    );
  }
}