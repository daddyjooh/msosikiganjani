import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:msosikiganjani/utils/colors.dart';
import 'package:msosikiganjani/utils/dimensions.dart';
import 'package:msosikiganjani/widgets/small_text.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key,
    required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;

  bool hidenText = true;
  double textHeight = Dimensions.screenHeight/5.63;

  @override
  void initState(){
    super.initState();
    if(widget.text.length>textHeight){
      firstHalf = widget.text.substring(0,textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt()+1,widget.text.length);
    }else{
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SmallText(color:AppColors.paraColor,size:Dimensions.fontSize16,text: firstHalf):Column(
        children: [
          SmallText(height : 1.8,color:AppColors.paraColor,size:Dimensions.fontSize16,text: hidenText?(firstHalf + "..."):(firstHalf + secondHalf)),
          InkWell(
            onTap: (){
              setState(() {
                hidenText = !hidenText;
              });
            },
            child: (
            Row(
              children: [
                SmallText(text: "Show more",color: AppColors.mainColor,),
                Icon(hidenText?Icons.arrow_drop_down:Icons.arrow_drop_up,color: AppColors.mainColor,)
              ],
            )
            ),
          )
        ],
      ),
    );
  }
}
