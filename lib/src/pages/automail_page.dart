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

  void onQuestionsCompleted(String a1, String a2, String a3, String a4, String a5, String a6) {
    onQuestionsAnswered();
    initiateStreaming(a1,a2,a3,a4,a5,a6);
  }



  @override
  void initState() {
    super.initState();
  }

  void initiateStreaming(String a1, String a2, String a3, String a4, String a5, String a6) {
    dataSubscription?.cancel();
    dataSubscription = DataFetcher.fetchDataStream(a1,a2,a3,a4,a5,a6).listen((data) {
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

  Widget questionField(
      String labelText,
      String hintText,
      TextEditingController controller,
      double? width,
      Function(String) onTextChanged // 상태 업데이트를 위한 콜백 함수 추가
      ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(labelText),
              Text(' *', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
        Container(
          width: width,
          child: TextField(
            controller: controller,
            onChanged: (value) {
              onTextChanged(value); // 상태 업데이트 콜백 호출
            },
            decoration: InputDecoration(
              hintText: hintText,
            ),
            maxLines: null,
          ),
        ),
      ],
    );
  }



  Widget _contents(double? questionWidth) {
      if (!isQuestionsAnswered) {
        return Center(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      questionField('보내는 이 정보', 'ex) 성균관대학교 도술학과 홍길동', answer1Controller, questionWidth, (value) {
                        setState(() {
                          answer1 = value;
                        });
                      }),
                      questionField('받는 이 정보', 'ex) 김태윤 교수님', answer2Controller, questionWidth, (value) {
                        setState(() {
                          answer2 = value;
                        });
                      }),
                      questionField('용건', 'ex) DS101 축지법개론 성적문의', answer3Controller, questionWidth, (value) {
                        setState(() {
                          answer3 = value;
                        });
                      }),
                      questionField('상세정보', 'ex) 축지법 실습 성적에 대한 피드백이 궁금함', answer4Controller, questionWidth, (value) {
                        setState(() {
                          answer4 = value;
                        });
                      }),

                      questionField('연락처', 'ex) 010-xxxx-xxxx', answer5Controller, questionWidth, (value) {
                        setState(() {
                          answer5 = value;
                        });
                      }),
                      questionField('기타 사항', 'ex) 도술대학원 진학에 관련하여 조언이 필요함', answer6Controller, questionWidth, (value) {
                        setState(() {
                          answer6 = value;
                        });
                      }),
                      // 답변이 완료되지 않았을 경우 버튼을 표시하지 않음
                    ],
                  ),
                ),
              ),

          SizedBox(height: 15,),
          areAllQuestionsAnswered()
              ? clrbutton("메일 초안 생성하기", () =>onQuestionsCompleted(
              answer1, answer2, answer3, answer4, answer5, answer6
          ))
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
          Expanded(child: _contents(200)),
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
          Expanded(child: _contents(300)),
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
          Expanded(child: _contents(400)),
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
      case ScreenSizeType.TABLET:
        return _tabletLayout();
      case ScreenSizeType.DESKTOP:
        return _desktopLayout();
      default:
        return Container();
    }

  }

}