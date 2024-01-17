import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:menttang/src/controller/screen_layout_controller.dart';

class NavigationMenu extends GetView<ScreenLayoutController> {
  final ScreenSizeType screenSizeType;
  NavigationMenu(this.screenSizeType);


Widget menu(String menu, GestureTapCallback onTap){
  return InkWell(
    mouseCursor: MaterialStateMouseCursor.clickable,
    hoverColor: Colors.blueAccent,
    splashColor: Colors.yellow,
    highlightColor: Colors.red,
    onTap: onTap,
    child:Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
          menu,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold)
      ),
    ),);
}//menu name과

  Color getForegroundColor(Set<MaterialState> states){
    const interactiveStates = <MaterialState>{
      MaterialState.hovered,
      MaterialState.pressed,
    };
    if(states.any(interactiveStates.contains)) {
      return Color(0xff6EA6E9);
    }
    return Colors.black;
  }

  EdgeInsets getPadding(Set<MaterialState> states){
    const interactiveStates = <MaterialState>{
      MaterialState.hovered,
    };
    if(states.any(interactiveStates.contains)) {
      return EdgeInsets.only(top: 10);
    }
    return EdgeInsets.all(0);
  }

  Widget menu2(String sidemenuName, double fontsz, VoidCallback onPressed){
    return TextButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.resolveWith(getPadding),
            foregroundColor:
            MaterialStateProperty.resolveWith(getForegroundColor),
            overlayColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.transparent)
        ),

        onPressed: (){},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            sidemenuName,
            style: TextStyle(fontSize: fontsz, fontWeight: FontWeight.bold),
          ),
        )
    );}
Widget _mobileLayout(){
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Padding(
          padding: const EdgeInsets.only(left:10),
          child: Image.asset("assets/images/img.png",width: 200),

        ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(right:10),

            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  menu2("간편 메일", 18, () { }),
                 // menu2("메일 발송", 20, () { }),
                  menu2("초안 수정", 18, () { }),
                ]
            ),
          ),
        ]
    ),
  );
}


  Widget _desktopLayout(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Padding(
            padding: const EdgeInsets.only(left:10),
            child: Image.asset("assets/images/img.png",width: 200),
          ),
            Padding(
              padding: const EdgeInsets.only(right:10),
              child: Row(
                  children: [
                    menu2("간편 메일", 18, () { }),
                    //menu2("메일 발송", 16, () { }),
                    menu2("초안 수정", 18, () { }),
                  ]
              ),
            ),
          ]
      ),
    );
  }





  @override
  Widget build(BuildContext  context){
  // print("navigation rebuild"); logging
  // print(screenSizeType);
    switch(screenSizeType){

      case ScreenSizeType.MOBILE:
        return _mobileLayout();
        break;
      case ScreenSizeType.TABLET:
        return _desktopLayout();
        break;
      case ScreenSizeType.DESKTOP:
        return _desktopLayout();
        break;


    }


  }
}