import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../constant/my_colors.dart';
import '../../component/my_componenet.dart';
import '../../constant/my_strings.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
    required this.size,
    required this.textThem,
    required this.bodyMargin,
  }) : super(key: key);

  final Size size;
  final TextTheme textThem;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(top:30 ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/pro.png',
              height: 100,
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageIcon(
                    AssetImage(
                      'assets/icons/pencil.png',
                    ),
                    color: SolidColors.seeMore),
                Text(
                  MyString.imageProfileEdit,
                  style: textThem.headline3,
                )
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Text(
              'فاطمه امیری',
              style: textThem.headline4,
            ),
            Text(
              'fatemeamiri@gmail.com',
              style: textThem.headline4,
            ),
            const SizedBox(
              height: 60,
            ),
            TechDivider(size: size),
            InkWell(
              splashColor: SolidColors.primeryColor,
              child: SizedBox(
                  height: 45,
                  child: Center(
                      child: Text(
                    MyString.myFavBlog,
                    style: textThem.headline4,
                  ))),
              onTap: () {},
            ),
            TechDivider(size: size),
            InkWell(
              splashColor: SolidColors.primeryColor,
              child: SizedBox(
                  height: 45,
                  child: Center(
                      child: Text(
                    MyString.myFavPodcast,
                    style: textThem.headline4,
                  ))),
              onTap: () {},
            ),
            TechDivider(size: size),
            InkWell(
              splashColor: SolidColors.primeryColor,
              child: SizedBox(
                  height: 45,
                  child: Center(
                      child: Text(
                    MyString.logOut,
                    style: textThem.headline4,
                  ))),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
