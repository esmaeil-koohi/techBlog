import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tec/component/decoration.dart';
import 'package:tec/component/my_componenet.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:tec/controller/register_controller.dart';
import 'package:tec/view/main_screen/home_screen.dart';
import 'package:tec/view/main_screen/profile_screen.dart';
import '../../constant/my_colors.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey();

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  RxInt selectedPageIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final TextTheme textThem = Theme.of(context).textTheme;
    double bodyMargin = size.width / 10;
    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: Drawer(
          backgroundColor: SolidColors.scafoldBg,
          child: Padding(
            padding: EdgeInsets.only(right: bodyMargin, left: bodyMargin),
            child: ListView(children: [
              DrawerHeader(
                child: Center(
                    child: Image.asset(
                  'assets/images/a11.png',
                  scale: 2,
                )),
              ),
              ListTile(
                title: Text(
                  'پروفایل کاربری',
                  style: textThem.headline4,
                ),
                onTap: () {},
              ),
              Divider(
                color: SolidColors.dividerColor,
              ),
              ListTile(
                title: Text(
                  'درباره تک بلاگ',
                  style: textThem.headline4,
                ),
                onTap: () {},
              ),
              Divider(
                color: SolidColors.dividerColor,
              ),
              ListTile(
                title: Text(
                  'اشتراک گذاری تک بلاگ',
                  style: textThem.headline4,
                ),
                onTap: () async {
                  await Share.share(MyString.shareText);
                },
              ),
              Divider(
                color: SolidColors.dividerColor,
              ),
              ListTile(
                title: Text(
                  'تک بلاگ در گیت هاب',
                  style: textThem.headline4,
                ),
                onTap: () {
                  myLunchUrl(MyString.techBlogGithubUrl);
                },
              ),
              Divider(
                color: SolidColors.dividerColor,
              ),
            ]),
          ),
        ),
        appBar: mainScreenAppBar(size),
        body: Obx(
          () => IndexedStack(
            index: selectedPageIndex.value,
            children: [
              HomeScreen(
                  size: size, textThem: textThem, bodyMargin: bodyMargin),
              ProfileScreen(
                  size: size, textThem: textThem, bodyMargin: bodyMargin),
            ],
          ),
        ),
        bottomNavigationBar: BottomNav(
          size: size,
          bodyMargin: bodyMargin,
          changeScreen: (int value) {
            selectedPageIndex.value = value;
          },
        ),
      ),
    );
  }

  AppBar mainScreenAppBar(Size size) {
    return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: SolidColors.scafoldBg,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                _key.currentState!.openDrawer();
              },
              icon: Icon(Icons.menu),
              color: Colors.black,
            ),
            Image.asset(
              'assets/images/a11.png',
              height: size.height / 13.6,
            ),
            Icon(
              Icons.search,
              color: Colors.black,
            ),
          ],
        ),
      );
  }
}

class BottomNav extends StatelessWidget {
  final Size size;
  final double bodyMargin;
  final Function(int) changeScreen;
  BottomNav({
    Key? key,
    required this.size,
    required this.bodyMargin,
    required this.changeScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / 10,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        // gradient: LinearGradient(
        //     colors: GradiantColors.bottomNavBackground,
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter),
      ),
      child: Padding(
        padding: EdgeInsets.only(right: bodyMargin, left: bodyMargin),
        child: Container(
          height: size.height / 8,
          decoration: MyDecorations.mainGradiant,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () => changeScreen(0),
                  icon: ImageIcon(
                    AssetImage('assets/icons/hicon.png'),
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {
                   Get.find<RegisterController>().toggleLogin();
                  },
                  icon: ImageIcon(
                    AssetImage('assets/icons/w.png'),
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () => changeScreen(1),
                  icon: ImageIcon(
                    AssetImage('assets/icons/user.png'),
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
