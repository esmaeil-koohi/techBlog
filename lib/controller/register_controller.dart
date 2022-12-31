import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/constant/storage_const.dart';
import 'package:tec/named_route.dart';
import 'package:tec/services/dio_service.dart';
import 'package:tec/view/main_screen/main_screen.dart';
import 'package:tec/view/register/register_intro.dart';

class RegisterController extends GetxController {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController activeCodeTextEditingController = TextEditingController();
  var email = '';
  int userId = 0;

  register() async {
    Map<String, dynamic> map = {
      'email': emailTextEditingController.text.trim(),
      'command': 'register'
    };
    var response = await DioService().postMethod(map, ApiUrlConstant.postRegister);
    debugPrint('de'+response.toString());
    email = emailTextEditingController.text.toString().trim();
    userId = response.data['user_id'];

  }

  verify() async {
    Map<String, dynamic> map = {
      'email': email,
      'user_id': userId,
      'code': activeCodeTextEditingController.text.toString().trim(),
      'command': 'verify'
    };
    debugPrint(map.toString());
    var response = await DioService().postMethod(map, ApiUrlConstant.postRegister);
    var status = response.data['response'];
    switch (status) {
      case 'verified':
        var box = GetStorage();
        box.write(StorageKey.token, response.data['token']);
        box.write(StorageKey.userId, response.data['user_id']);
        Get.offAll(MainScreen());
        break;
      case 'incorrect_code':
        Get.snackbar('خطا', 'کد فعال سازی غلط است');
        break;
      case 'expired':
        Get.snackbar('خطا', 'کد فعال سازی منقضی شده است');
        break;
    }
  }

  toggleLogin() {
    if (GetStorage().read(StorageKey.token) == null) {
      Get.to(RegisterIntro());
    } else {
      routeToWriteBottomSheet();
    }
  }

  routeToWriteBottomSheet(){
    Get.bottomSheet(
      Container(
        height: Get.height/3,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20)
              ,topRight: Radius.circular(20))
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/images/techblog.svg', height: 40,),
                  const SizedBox(width: 8,),
                  const Text('دونسته هات رو با بقیه به اشتراک بزار...'),
                ],
              ),
             const SizedBox(
                height: 8.0,
              ),
              const Text('''فکر کن !! اینجا بودنت به این معناست که یک گیگ تکنولوژی هستی
                    دونسته هات رو با جامعه گیگ های فارسی به اشتراک بزار ... 
                    '''),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(NamedRouted.routeManageArticle);
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Image.asset('assets/images/write_article.png', height: 32,),
                          const SizedBox(width: 8,),
                          const Text('مدیریت مقاله ها'),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Image.asset('assets/images/write_podcast.png', height: 32,),
                          const SizedBox(width: 8,),
                          const Text('مدیریت پادکست ها'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
}

}
