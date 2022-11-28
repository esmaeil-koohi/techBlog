import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/model/article_info_model.dart';
import 'package:tec/model/tags_model.dart';
import 'package:tec/services/dio_service.dart';
import '../../model/article_model.dart';

class ManageArticleController extends GetxController {
  RxList<ArticleModel> articleList = RxList();
  RxList<TagsModel> tagList = RxList();
  RxBool loading = false.obs;
  TextEditingController titleTextEditingController = TextEditingController();
  Rx<ArticleInfoModel> articleInfoModel = ArticleInfoModel(
    image: null,
    title: 'اینجا عنوان مقاله قرار میگیرد یه عنوان جذاب انتخاب کن',
    content: '''من متن و بدنه اصلی مقاله هستم، اگه میخوای من رو
    ویرایش کنی و یه مقاله جذاب بنویسی، نوشته آبی رنگ
    بالا که نوشته"ویرایش متن اصلی مقاله" رو با انگشت لمس کن تاوارد ویرایشگر بشی
    ''',
  ).obs;

  @override
  onInit() {
    super.onInit();
    getManageArticle();
  }

  getManageArticle() async {
    loading.value = true;
    // var response = await DioService().getMethod(ApiConstant.publishedByMe+GetStorage().read(StorageKey.userId));
    var response =
        await DioService().getMethod(ApiConstant.publishedByMe + "2");
    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
      loading.value = false;
    }
  }

  updateTitle(){
    articleInfoModel.update((val) {
      val!.title = titleTextEditingController.text;
    });
  }


}
