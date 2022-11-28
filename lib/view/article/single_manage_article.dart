import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/component/my_componenet.dart';
import 'package:tec/controller/article/list_article_controller.dart';
import 'package:tec/controller/article/manage_article_controller.dart';
import 'package:tec/services/pick_file.dart';
import 'package:tec/view/article/article_content_editor.dart';
import 'package:tec/view/article/article_list_screen.dart';
import '../../controller/article/file_controller.dart';
import '../../controller/home_screen_controller.dart';


class SingleManageArticle extends StatelessWidget {

  var manageArticleController = Get.find<ManageArticleController>();
  FilePickerController filePickerController = Get.put(FilePickerController());
  final double sizeWith = Get.width;
  final double sizeHeight = Get.height;

  getTitle(){
    Get.defaultDialog(
      title: 'عنوان مقاله',
      titleStyle: TextStyle(
        color: SolidColors.scafoldBg,
      ),
      backgroundColor: SolidColors.primeryColor,
      radius: 8.0,
      content: TextField(
        controller: manageArticleController.titleTextEditingController,
        keyboardType: TextInputType.text ,
        style: TextStyle(
          color: SolidColors.colorTitle
        ),
        decoration: InputDecoration(
          hintText: 'اینجا بنویس',
          filled: true,
          fillColor: Colors.white
        ),
      ),
      confirm: ElevatedButton(onPressed: () {
        manageArticleController.updateTitle();
       Get.back();
      },
      child: const Text('ثبت'))
    );
  }


  @override
  Widget build(BuildContext context) {
    var textThem = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Obx(
            () => allOfTheSinglePage(textThem),
          ),
        ),
      ),
    );
  }

  Widget allOfTheSinglePage(TextTheme textThem) {
    return Column(
      children: [
        poster(textThem),
        SizedBox(height: Dimens.bodyMargin),
        seeMoreTitleArticle(),
        title(textThem),
        SizedBox(height: Dimens.halfBodyMargin),
        seeMoreTextArticle(),
        text(textThem),
        SizedBox(height: Dimens.bodyMargin),
        seeMoreChooseCategory(textThem),
      ],
    );
  }

  Widget cats(TextTheme textThem) {
     HomeScreenController homeScreenController = Get.find<HomeScreenController>();
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: SizedBox(
        height: Get.height/1.7,
        child: GridView.builder(
          itemCount: homeScreenController.tagsList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () async {
              String tagId = homeScreenController.tagsList[index].id!;
              await Get.find<ListArticleController>()
                  .getArticleListWithTagId(tagId);
              String tagName = homeScreenController.tagsList[index].title!;
              Get.to(ArticleListScreen(
                title: tagName,
              ));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                height: 35,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      homeScreenController.tagsList[index].title!,
                      textAlign: TextAlign.center,
                      style: textThem.headline2,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: SolidColors.primeryColor),
              ),
            ),
          ), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        ),
      ),
    );
  }

  chooseCatsBottomSheet(TextTheme textTheme){
    Get.bottomSheet(
    Container(
      height: Get.height/1.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'انتخاب دسته بندی'
            ),
            cats(textTheme),
          ],
        ),
      ),
    ),
      isScrollControlled: true,
      persistent: true,
    );
  }

  Widget seeMoreChooseCategory(TextTheme textTheme){
    return GestureDetector(
      onTap: ()=> chooseCatsBottomSheet(textTheme),
        child: SeeMore(title: ' انتخاب دسته بندی', bodyMargin: Dimens.halfBodyMargin));
  }

  Widget seeMoreTextArticle(){
    return GestureDetector(
      onTap: () => Get.to(()=> ArticleContentEditor()),
      child: SeeMore(title: 'ویرایش متن مقاله', bodyMargin: Dimens.halfBodyMargin),
    );
  }

  Widget seeMoreTitleArticle() {
    return GestureDetector(
      onTap: () {
        getTitle();
      },
        child: SeeMore(title: 'ویرایش عنوان مقاله', bodyMargin: Dimens.halfBodyMargin));
  }

  Widget poster(TextTheme textThem) {
    return Stack(
      children: [
        imagePoster(),
        appBarPoster(),
        ImageSelectionButton(textThem),
      ],
    );
  }

  Widget ImageSelectionButton(TextTheme textThem) {
    return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
              child: GestureDetector(
                onTap: () {
                pickFile();
                },
                child: Container(
            width: Get.width/3,
            height: 30,
            decoration: BoxDecoration(
                color: SolidColors.primeryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                ),
            ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('انتخاب تصویر', style: textThem.headline2,),
                      Icon(Icons.add, color: Colors.white,),
                    ],
                  ),
          ),
              ),
          )
    );
  }

  Widget text(TextTheme textThem) {
    return Padding(
      padding: EdgeInsets.only(right: Dimens.halfBodyMargin),
      child: HtmlWidget(
        manageArticleController.articleInfoModel.value.content!,
        textStyle: textThem.headline5,
        enableCaching: true,
        onLoadingBuilder: (context, element, loadingProgress) => Loading(),
      ),
    );
  }

  Widget title(TextTheme textThem) {
    return Padding(
      padding:  EdgeInsets.only(right: Dimens.halfBodyMargin),
      child: Text(
        manageArticleController.articleInfoModel.value.title!,
        maxLines: 2,
        style: textThem.titleLarge,
      ),
    );
  }

  Widget appBarPoster() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 60,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: GradiantColors.singleAppBarGradiant)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 10,
            ),
            IconButton(onPressed: () =>Get.back(),
                icon:Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),),
            Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }

  Widget imagePoster() {
    return SizedBox(
      width: Get.width,
      height: Get.height/3,
      child: filePickerController.file.value.name == 'nothing'?
      Image.asset('assets/images/single_place_holder.jpg',fit: BoxFit.cover):
      Image.file(File(filePickerController.file.value.path!), fit: BoxFit.cover,),
    );
  }


}
