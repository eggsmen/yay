import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menttang/src/data/retrofit_network.dart';
import '../controller/screen_layout_controller.dart';
import 'dart:async';

class AutomailPage extends StatefulWidget {
  final ScreenSizeType screenSizeType;
  AutomailPage(this.screenSizeType);

  @override
  _AutomailPageState createState() => _AutomailPageState();
}

class _AutomailPageState extends State<AutomailPage> {
  final ScrollController scrollController = ScrollController();
  StreamSubscription<String>? dataSubscription;
  String liveData = '';
  bool isStreamCompleted = false;

  @override
  void initState() {
    super.initState();
  }

  void initiateStreaming() {
    dataSubscription?.cancel();
    dataSubscription = DataFetcher.fetchDataStream().listen((data) {
      setState(() {
        liveData += data;
      });
    }, onError: (error) {
      print('Error: $error');
    });
  }

  @override
  void dispose() {
      dataSubscription?.cancel();
  }





  Widget clrbutton(String menu, GestureTapCallback onTap){
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
  }

  Widget _contents() {
    return Scrollbar(
      thumbVisibility: true,
      controller: scrollController,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.only(right:40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15,),
              clrbutton("통신버튼", initiateStreaming),
              SizedBox(height: 15,),
              Text(liveData,
                  style: TextStyle(fontSize: 16))
            ],
          ),
        ),
      ),
    );
  }

  Widget _mobileLayout(){
    return Container(
      padding: EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _contents()),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right:5),
              child: Container(
                width: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("부메뉴", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    SizedBox(height: 8,),
                    _sideMenu("메뉴1", 12, () { }),
                    _sideMenu("메뉴2", 12, () { }),
                    _sideMenu("메뉴3", 12, () { }),
                    _sideMenu("메뉴4", 12, () { }),
                    _sideMenu("메뉴5", 12, () { }),

                  ],
                ),
              ),
            ),
          )

        ],),
    );
  }

  Widget _tabletLayout(){
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _contents()),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right:10),
              child: Container(
                width: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("부메뉴", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    SizedBox(height: 8,),
                    _sideMenu("메뉴1", 16, () { }),
                    _sideMenu("메뉴2", 16, () { }),
                    _sideMenu("메뉴3", 16, () { }),
                    _sideMenu("메뉴4", 16, () { }),
                    _sideMenu("메뉴5", 16, () { }),

                  ],
                ),
              ),
            ),
          )

        ],),
    );
  }

  Widget _desktopLayout(){
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _contents()),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("부메뉴", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    SizedBox(height: 8,),
                    _sideMenu("메뉴1", 16, () { }),
                    _sideMenu("메뉴2", 16, () { }),
                    _sideMenu("메뉴3", 16, () { }),
                    _sideMenu("메뉴4", 16, () { }),
                    _sideMenu("메뉴5", 16, () { }),

                  ],
                ),
              ),
            ),
          )

        ],),
    );
  }









  Widget smallmenu(String smallmenu, double fontsz, GestureTapCallback onTap){
    return InkWell(
      mouseCursor: MaterialStateMouseCursor.clickable,
      hoverColor: Colors.blueAccent,
      splashColor: Colors.yellow,
      highlightColor: Colors.red,
      onTap: onTap,
      child:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
            smallmenu,
            style: TextStyle(
              fontSize: fontsz,
            )
        ),
      ),);
  }

  Widget _sideMenu(String sidemenuName, double fontsz, VoidCallback onPressed){
    return TextButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.resolveWith(getPadding),
            foregroundColor:
            MaterialStateProperty.resolveWith(getForegroundColor),
            overlayColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.transparent)
        ),

        onPressed: (){},
        child: Text(
          sidemenuName,
          style: TextStyle(fontSize: fontsz),
        )
    );}





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
      return EdgeInsets.only(left: 15);
    }
    return EdgeInsets.all(0);
  }


  @override
  Widget build(BuildContext context) {
    switch(widget.screenSizeType){
      case ScreenSizeType.MOBILE:
        return _mobileLayout();
        break;
      case ScreenSizeType.TABLET:
        return _tabletLayout();
        break;
      case ScreenSizeType.DESKTOP:
        return _desktopLayout();
        break;
      default:
        return Container();
    }

  }

}