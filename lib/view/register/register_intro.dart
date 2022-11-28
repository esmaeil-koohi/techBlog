import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tec/controller/register_controller.dart';
import 'package:validators/validators.dart';
import '../../constant/my_strings.dart';

class RegisterIntro extends StatelessWidget {
   RegisterIntro({Key? key}) : super(key: key);

  var registerController = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    var textThem = Theme.of(context).textTheme;
    double heightSize = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/techblog.svg',
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: MyString.welcome,
                    style: textThem.headline4,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _showEmailBottomSheet(context, heightSize, textThem);
                },
                child: const Text('بزن بریم'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showEmailBottomSheet(
      BuildContext context, double heightSize, TextTheme textThem) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: heightSize / 3,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  MyString.insertYourEmail,
                  style: textThem.headline4,
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: TextField(
                    controller: registerController.emailTextEditingController,
                    onChanged: (value) {
                      print(value + "is Email : " + isEmail(value).toString());
                    },
                    style: textThem.headline5,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'techblog@gmail.com',
                      hintStyle: textThem.headline5,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    registerController.register();
                    Navigator.pop(context);
                    _activateCodeBottomSheet(context, heightSize, textThem);
                  },
                  child: Text('ادامه'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _activateCodeBottomSheet(
      BuildContext context, double heightSize, TextTheme textThem) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: heightSize / 3,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  MyString.activateCode,
                  style: textThem.headline4,
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: TextField(
                    controller: registerController.activeCodeTextEditingController,
                    onChanged: (value) {},
                    style: textThem.headline5,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: '*******',
                      hintStyle: textThem.headline5,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    registerController.verify();
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //   builder: (context) => MyCats(),
                    // ));
                  },
                  child: Text('ادامه'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
