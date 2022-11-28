import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tec/component/text_style.dart';
import 'package:tec/controller/home_screen_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constant/my_colors.dart';

class TechDivider extends StatelessWidget {
  const TechDivider({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1.5,
      color: SolidColors.dividerColor,
      indent: size.width / 6,
      endIndent: size.width / 6,
    );
  }
}

class MainTags extends StatelessWidget {
  const MainTags({Key? key, required this.textThem, required this.index})
      : super(key: key);
  final TextTheme textThem;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        gradient: LinearGradient(
          colors: GradiantColors.tags,
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        child: Row(
          children: [
            ImageIcon(
              AssetImage('assets/icons/hashtag.png'),
              color: Colors.white,
              size: 16,
              //ImageIcon(Assets.icons.hashtag.png),
            ),
            SizedBox(
              width: 6.0,
            ),
            Text(
              Get.find<HomeScreenController>().tagsList[index].title!,
              style: textThem.headline2,
            ),
          ],
        ),
      ),
    );
  }
}

myLunchUrl(String url) async {
  var uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    log('could not lunch ${uri.toString()}');
  }
}

class Loading extends StatelessWidget {

  const Loading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCube(
      color: SolidColors.primeryColor,
      size: 32.0,
    );
  }
}

AppBar appBar(String title) {
    return AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Center(child: Text(title, style: appBarTextStyle,)),
              ),],
              leading: Padding(
                padding: const EdgeInsets.only(right:16),
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 40,
                    width: 40,
                    child: Icon(Icons.keyboard_arrow_right_rounded),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: SolidColors.primeryColor.withBlue(100),
                    ),
                  ),
                ),
              ),
          );
  }

class SeeMore extends StatelessWidget {
  const SeeMore({Key? key, required this.title, required this.bodyMargin}) : super(key: key);
 final String title;
 final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    var textThem = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(right: bodyMargin, bottom: 8),
      child: Row(
        children: [
          ImageIcon(
            AssetImage('assets/icons/pencil.png'),
            color: SolidColors.seeMore,
          ),
          const SizedBox(
            width: 6.0,
          ),
          Text(
            title,
            style: textThem.headline3,
          ),
        ],
      ),
    );
  }
}
