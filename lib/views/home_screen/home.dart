import 'package:color_xd/const/image.dart';
import 'package:color_xd/controller/home_controller.dart';
import 'package:color_xd/views/detect_screen/detect_screen.dart';
import 'package:color_xd/views/home_screen/home_screen.dart';
import 'package:color_xd/views/profile_screen/profile_screen.dart';
import 'package:get/get.dart';
import 'package:color_xd/const/const.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
      var controller = Get.put(HomeController());
    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(icHome, width: 26), label: home),
      BottomNavigationBarItem(
          icon: Image.asset(icPlus, width: 26), label: plus),
      BottomNavigationBarItem(
          icon: Image.asset(icPro, width: 26), label: pro),
     
    ];
    var navBody = [
      const HomeScreen(),
      const DetectScreen(),
      const ProfileScreen(),
     
    ];

    return Scaffold(
      body: Column(
        children: [
          Obx(() => Expanded(
              child: navBody.elementAt(controller.currentNavIndex.value))),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.green,
          selectedLabelStyle: const TextStyle(fontFamily: semibold),
          type: BottomNavigationBarType.fixed,
          items: navbarItem,
          onTap: (value) {
            controller.currentNavIndex.value = value;
          },
        ),
      ),
    );

  }
}