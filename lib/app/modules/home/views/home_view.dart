import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shopping/app/constants/index.dart';
// import 'package:shopping/app/modules/cart/views/cart_view.dart';
import 'package:shopping/app/modules/dashboard/views/dashboard_view.dart';
// import 'package:shopping/app/modules/account/views/account_view.dart';
// import 'package:shopping/app/modules/card/views/card_view.dart';
// import 'package:shopping/app/modules/dashboard/views/dashboard_view.dart';
import 'package:shopping/app/modules/home/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  List<Widget> _widgetOptions = <Widget>[
    DashboardView(),
    Container(child: Center(child: Text('News'))), // News placeholder
    // CartView(),
    Container(child: Center(child: Text('Notifications'))), // Notifications placeholder
    Container(child: Center(child: Text('Account'))), // Account placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homeController) {
      return Builder(
        builder: (context) => Scaffold(
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
              top: false, child: _widgetOptions.elementAt(controller.tabIndex)),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: BottomNavigationBar(
            onTap: homeController.changeTabIndex,
            currentIndex: homeController.tabIndex,
            selectedFontSize: 14,
            unselectedFontSize: 12,
            // selectedLabelStyle: ,
            selectedItemColor: AppColors.greenPrimary,
            unselectedItemColor: AppColors.greenPrimary,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            elevation: 0.0,
            items: [
              _bottomNavigationBarItem(
                icon: homeController.tabIndex == 0
                    ? FontAwesomeIcons.house
                    : FontAwesomeIcons.house,
                label: FlutterI18n.translate(context, "home.dashBoard"),
              ),
              _bottomNavigationBarItem(
                icon: homeController.tabIndex == 1
                    ? FontAwesomeIcons.newspaper
                    : FontAwesomeIcons.newspaper,
                label: FlutterI18n.translate(context, "home.news"),
              ),
              _bottomNavigationBarItemCard(
                icon: homeController.tabIndex == 2
                    ? FontAwesomeIcons.cartShopping
                    : FontAwesomeIcons.cartShopping,
                label: FlutterI18n.translate(context, "home.card"),
                height: 32.0,
                width: 32.0,
              ),
              _bottomNavigationBarItem(
                icon: homeController.tabIndex == 3
                    ? FontAwesomeIcons.bell
                    : FontAwesomeIcons.bell,
                label: FlutterI18n.translate(context, "home.notification"),
              ),
              _bottomNavigationBarItem(
                icon: homeController.tabIndex == 4
                    ? FontAwesomeIcons.circleUser
                    : FontAwesomeIcons.circleUser,
                label: FlutterI18n.translate(context, "home.account"),
              ),
            ],
          ),
        ),
      );
    });
  }

  _bottomNavigationBarItem({required icon, required String label}) {
    return BottomNavigationBarItem(
        icon: Container(height: 35, child: imgBottomBar(icon)),
        label: label,
        backgroundColor: AppColors.greenPrimary);
  }

  _bottomNavigationBarItemCard(
      {required icon, required String label, width, height}) {
    return BottomNavigationBarItem(
      icon: Stack(
        children: [
          Container(
            height: 35,
            child: imgBottomBar(icon),
          ),
          CircleAvatar(
            backgroundColor: Colors.black,
            radius: 10,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 9,
              child: CircleAvatar(
                backgroundColor: Colors.red,
                radius: 8,
                child: Text(
                  "5",
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
          )
        ],
      ),
      label: label,
    );
  }

  Widget imgBottomBar(icon) {
    return Icon(
      icon,
      size: 30,
    );
  }
}
