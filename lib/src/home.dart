import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:menttang/src/components/footer.dart';
import 'package:menttang/src/components/navigation_menu.dart';
import 'package:menttang/src/controller/screen_layout_controller.dart';
import 'package:menttang/src/pages/automail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScreenLayoutController.to.builder(constraints);
          });
          return Container();
        }),
        Obx(() => Container(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1280),
            child: Column(
              children: [
                NavigationMenu(ScreenLayoutController.to.screenType.value),
                Expanded(child: AutomailPage(ScreenLayoutController.to.screenType.value)),
                Footer(),
              ],
            ),
          ),
        )),
      ]),
    );
  }
}

