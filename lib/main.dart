import 'package:flutter/material.dart';
import 'package:flutter_package_base/flutter_package_base.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  RxInt currentIndex = 0.obs;
  int oldIndex = 0;
  List<int> listIdScreen = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        int lastId = listIdScreen.lastOrNull();
        if (lastId != null) {
          currentIndex.value = lastId;
          listIdScreen.removeLast();
          return false;
        } else {
          if (currentIndex.value != 0) {
            currentIndex.value = 0;
            return false;
          } else {
            return true;
          }
        }
      },
      child: Scaffold(
        body: Obx(() => getWidgetById(currentIndex.value)),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.red,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "home", backgroundColor: Colors.red),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: "message"),
            BottomNavigationBarItem(icon: Icon(Icons.music_note), label: "music"),
            BottomNavigationBarItem(icon: Icon(Icons.notification_important), label: "notification"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "settings"),
          ],
          currentIndex: currentIndex.value,
          onTap: (index) {
            if (oldIndex != index) {
              listIdScreen.add(oldIndex);
              currentIndex.value = index;
              oldIndex = index;
            }
          },
        ),
      ),
    );
  }

  Widget getWidgetById(int id) {
    switch (id) {
      case 0:
        return ItemPage("home");
      case 1:
        return ItemPage("message");
      case 2:
        return ItemPage("music");
      case 3:
        return ItemPage("notification");
      case 4:
        return ItemPage("settings");
      default:
        return ItemPage("home");
    }
  }
}

class ItemPage extends StatelessWidget {
  final String title;

  ItemPage(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      child: Center(
        child: Text(title),
      ),
    );
  }
}
