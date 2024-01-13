import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controller/screen_layout_controller.dart';

class AutomailPage extends StatelessWidget {
  final ScreenSizeType screenSizeType;
  AutomailPage(this.screenSizeType);
  final ScrollController scrollController = ScrollController();


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
             Text('좋은 글귀 모음', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
             SizedBox(height: 15,),

             Text('1. 삶이 있는 한 희망은 있다 -키케로 2. 산다는것 그것은 치열한 전투이다. -로망로랑 3. 하루에 3시간을 걸으면 7년 후에 지구를 한바퀴 돌 수 있다. -사무엘존슨 4. 언제나 현재에 집중할수 있다면 행복할것이다. -파울로 코엘료 5. 진정으로 웃으려면 고통을 참아야하며 , 나아가 고통을 즐길 줄 알아야 해 -찰리 채플린 6. 직업에서 행복을 찾아라. 아니면 행복이 무엇인지 절대 모를 것이다 -엘버트 허버드 7. 신은 용기있는자를 결코 버리지 않는다 -켄러 8. 행복의 문이 하나 닫히면 다른 문이 열린다 그러나 우리는 종종 닫힌 문을 멍하니 바라보다가 9.우리를 향해 열린 문을 보지 못하게 된다 – 헬렌켈러 10. 피할수 없으면 즐겨라 – 로버트 엘리엇 11. 단순하게 살아라. 현대인은 쓸데없는 절차와 일 때문에 얼마나 복잡한 삶을 살아가는가?-이드리스 샤흐 12. 먼저 자신을 비웃어라. 다른 사람이 당신을 비웃기 전에 – 엘사 맥스웰 13. 먼저핀꽃은 먼저진다 남보다 먼저 공을 세우려고 조급히 서둘것이 아니다 – 채근담 14. 행복한 삶을 살기위해 필요한 것은 거의 없다. -마르쿠스 아우렐리우스 안토니우스 15. 절대 어제를 후회하지 마라 . 인생은 오늘의 나 안에 있고 내일은 스스로 만드는 것이다 L.론허바드 16. 어리석은 자는 멀리서 행복을 찾고, 현명한 자는 자신의 발치에서 행복을 키워간다 -제임스 오펜하임 17. 너무 소심하고 까다롭게 자신의 행동을 고민하지 말라 . 모든 인생은 실험이다 . 더많이 실험할수록 더나아진다 – 랄프 왈도 에머슨 18. 한번의 실패와 영원한 실패를 혼동하지 마라 -F.스콧 핏제랄드 19. 내일은 내일의 태양이 뜬다 20. 피할수 없으면 즐겨라 -로버트 엘리엇 21.절대 어제를 후회하지 마라. 인생은 오늘의 내 안에 있고 내일은 스스로 만드는것이다. -L론허바드 22. 계단을 밟아야 계단 위에 올라설수 있다, -터키속담 23. 오랫동안 꿈을 그리는 사람은 마침내 그 꿈을 닮아 간다, -앙드레 말로 24. 좋은 성과를 얻으려면 한 걸음 한 걸음이 힘차고 충실하지 않으면 안 된다, -단테 25. 행복은 습관이다,그것을 몸에 지니라 -허버드',
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
    switch(screenSizeType){
      case ScreenSizeType.MOBILE:
        return _mobileLayout();
        break;
      case ScreenSizeType.TABLET:
        return _tabletLayout();
        break;
      case ScreenSizeType.DESKTOP:
        return _desktopLayout();
        break;
    }

  }

}