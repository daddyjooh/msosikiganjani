import 'package:flutter/cupertino.dart';
import 'package:msosikiganjani/utils/dimensions.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size=0;
  TextOverflow overflow;
   BigText({Key? key,this.color = const  Color(0xFF332d2b), required this.text,this.overflow = TextOverflow.ellipsis,this.size=20,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        fontSize: size==0?Dimensions.fontSize20:size,
      ),
    );
  }
}
