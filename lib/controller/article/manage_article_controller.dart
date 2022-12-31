import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/constant/commands.dart';
import 'package:tec/constant/storage_const.dart';
import 'package:tec/controller/article/file_controller.dart';
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
        await DioService().getMethod(ApiUrlConstant.publishedByMe + "2");
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

  storeArticle() async{
    FilePickerController fileController = Get.find<FilePickerController>();
   loading.value = true;
   Map<String, dynamic> map = {
     ApiKeyArticleConstance.title : articleInfoModel.value.title,
     ApiKeyArticleConstance.content : articleInfoModel.value.content,
     ApiKeyArticleConstance.catId : articleInfoModel.value.catId,
     ApiKeyArticleConstance.userId : GetStorage().read(StorageKey.userId),
     ApiKeyArticleConstance.image : await dio.MultipartFile.fromFile(fileController.file.value.path!),
     ApiKeyArticleConstance.command : Commands.store,
     ApiKeyArticleConstance.tagList : '[]',
   };
   var response = await DioService().postMethod(map, ApiUrlConstant.articlePost);
   log(response.data.toString());
   loading.value = false;
  }


}
