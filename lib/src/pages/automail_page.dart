import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menttang/src/components/dropbox.dart';
import 'package:menttang/src/data/retrofit_network.dart';
import '../controller/screen_layout_controller.dart';
import 'dart:async';
import 'package:menttang/src/components/sidemenu.dart';

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
  bool isContentLoaded = false; // _contents 위젯의 로딩 상태를 관리
  bool isQuestionsAnswered = false;
  String answer1 = '';
  String answer2 = '';
  String answer3 = '';
  String answer4 = '';
  String answer5 = '';
  String answer6 = '';
  bool areAllQuestionsAnswered() {
    return answer1.isNotEmpty && answer2.isNotEmpty && answer3.isNotEmpty && answer4.isNotEmpty;
  }
  TextEditingController answer1Controller = TextEditingController();
  TextEditingController answer2Controller = TextEditingController();
  TextEditingController answer3Controller = TextEditingController();
  TextEditingController answer4Controller = TextEditingController();
  TextEditingController answer5Controller = TextEditingController();
  TextEditingController answer6Controller = TextEditingController();

  void onQuestionsAnswered() {
    setState(() {
      isQuestionsAnswered = true;
    });
  }

  void onQuestionsCompleted() {
    onQuestionsAnswered();
    initiateStreaming();
  }



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
      if (!isQuestionsAnswered) {
        return Center(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('보내는 이 정보'),
                            Text(' *', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                      Container(
                        width: 200, // 밑줄의 최대 길이 설정
                        child: TextField(
                          controller: TextEditingController(text: answer1),
                          onChanged: (value) {
                            setState(() {
                              answer1 = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: '보내는 이 정보 입력', // Placeholder 텍스트
                          ),
                          maxLines: null, // 내용에 따라 세로로 확장
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('받는 이 정보'),
                            Text(' *', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                      Container(
                        width: 200, // 밑줄의 최대 길이 설정
                        child: TextField(
                          controller: TextEditingController(text: answer2),
                          onChanged: (value) {
                            setState(() {
                              answer2 = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: '보내는 이 정보 입력', // Placeholder 텍스트
                          ),
                          maxLines: null, // 내용에 따라 세로로 확장
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('용건'),
                            Text(' *', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                      Container(
                        width: 200, // 밑줄의 최대 길이 설정
                        child: TextField(
                          controller: TextEditingController(text: answer3),
                          onChanged: (value) {
                            setState(() {
                              answer3 = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: '보내는 이 정보 입력', // Placeholder 텍스트
                          ),
                          maxLines: null, // 내용에 따라 세로로 확장
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('자세한 내용'),
                            Text(' *', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                
                      Container(
                        width: 200, // 밑줄의 최대 길이 설정
                        child: TextField(
                          controller: TextEditingController(text: answer4),
                          onChanged: (value) {
                            setState(() {
                              answer4 = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: '보내는 이 정보 입력', // Placeholder 텍스트
                          ),
                          maxLines: null, // 내용에 따라 세로로 확장
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:Text('연락처'),
                        ),
                
                      Container(
                        width: 200, // 밑줄의 최대 길이 설정
                        child: TextField(
                          controller: TextEditingController(text: answer5),
                          onChanged: (value) {
                            setState(() {
                              answer5 = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: '보내는 이 정보 입력', // Placeholder 텍스트
                          ),
                          maxLines: null, // 내용에 따라 세로로 확장
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('기타 사항'),
                      ),
                      Container(
                        width: 200, // 밑줄의 최대 길이 설정
                        child: TextField(
                          controller: TextEditingController(text: answer6),
                          onChanged: (value) {
                            setState(() {
                              answer6 = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: '보내는 이 정보 입력', // Placeholder 텍스트
                          ),
                          maxLines: null, // 내용에 따라 세로로 확장
                        ),
                      ),
                
                      // 답변이 완료되지 않았을 경우 버튼을 표시하지 않음
                    ],
                  ),
                ),
              ),

          SizedBox(height: 15,),
          areAllQuestionsAnswered()
              ? clrbutton("메일 초안 생성하기", onQuestionsCompleted)
              : Container(),
    ]
        ));
      }

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
                    SideMenu(sidemenuName: "메뉴1", fontsz:12),
                    SideMenu(sidemenuName: "메뉴2", fontsz:12),
                    Dropbox(sidemenuName: "메뉴3", fontsz:12),
                    Dropbox(sidemenuName: "메뉴4", fontsz:12),


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
                    SideMenu(sidemenuName: "메뉴1", fontsz:12),
                    SideMenu(sidemenuName: "메뉴2", fontsz:12),
                    Dropbox(sidemenuName: "메뉴3", fontsz:12),
                    Dropbox(sidemenuName: "메뉴4", fontsz:12),

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
                    SideMenu(sidemenuName: "메뉴1", fontsz:16),
                    SideMenu(sidemenuName: "메뉴2", fontsz:16),
                    Dropbox(sidemenuName: "메뉴3", fontsz:16),
                    Dropbox(sidemenuName: "메뉴4", fontsz:16),

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

  // Widget _sideMenu(String sidemenuName, double fontsz, VoidCallback onPressed){
  //   return TextButton(
  //       style: ButtonStyle(
  //           padding: MaterialStateProperty.resolveWith(getPadding),
  //           foregroundColor:
  //           MaterialStateProperty.resolveWith(getForegroundColor),
  //           overlayColor: MaterialStateProperty.resolveWith(
  //                   (states) => Colors.transparent)
  //       ),
  //
  //       onPressed: (){},
  //       child: Text(
  //         sidemenuName,
  //         style: TextStyle(fontSize: fontsz),
  //       )
  //   );}





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