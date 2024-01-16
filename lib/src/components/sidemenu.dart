import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  final String sidemenuName;
  final double fontsz;

  SideMenu({Key? key, required this.sidemenuName, required this.fontsz}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.resolveWith(getPadding),
                foregroundColor: MaterialStateProperty.resolveWith(getForegroundColor),
                overlayColor: MaterialStateProperty.resolveWith((states) => Colors.transparent)
            ),
            onPressed: () {
              setState(() {
                isChecked = !isChecked;
              });
            },
            child: Text(
              widget.sidemenuName,
              style: TextStyle(fontSize: widget.fontsz),
            ),
          ),
        ),
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
          activeColor: Color(0xff6EA6E9),
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          // 체크된 상태의 색상,
        ),
      ],
    );
  }

  EdgeInsets getPadding(Set<MaterialState> states){
    const interactiveStates = <MaterialState>{
      MaterialState.hovered,
    };
    if(states.any(interactiveStates.contains)) {
      return EdgeInsets.only(left: 15);
    }
    return EdgeInsets.all(0);

  }
  Color getForegroundColor(Set<MaterialState> states){
    const interactiveStates = <MaterialState>{
      MaterialState.hovered,
      MaterialState.pressed,
    };
    if(states.any(interactiveStates.contains)) {
      return Color(0xff6EA6E9);
    }
    return Colors.black;
  }}
