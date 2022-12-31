import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/component/my_componenet.dart';
import 'package:tec/controller/article/list_article_controller.dart';
import 'package:tec/controller/article/single_article_controller.dart';
import 'package:tec/view/article/article_list_screen.dart';

class Single extends StatelessWidget {

  var singleArticleController = Get.find<SingleArticleController>();
  final double sizeWith = Get.width;
  final double sizeHeight = Get.height;

  @override
  Widget build(BuildContext context) {
    var textThem = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Obx(
            () => singleArticleController.articleInfoModel.value.title == null
                ? SizedBox(height: Get.height, child: const Loading())
                : allOfTheSinglePage(textThem),
          ),
        ),
      ),
    );
  }

  Widget allOfTheSinglePage(TextTheme textThem) {
    return Column(
      children: [
        poster(),
        title(textThem),
        informationUser(textThem),
        text(textThem),
        const SizedBox(
          height: 25,
        ),
        tags(textThem),
        const SizedBox(
          height: 15,
        ),
        simmilar(textThem),
      ],
    );
  }

  Widget poster() {
    return Stack(
      children: [
        imagePoster(),
        appBarPoster(),
      ],
    );
  }

  Widget text(TextTheme textThem) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: HtmlWidget(
        singleArticleController.articleInfoModel.value.content!,
        textStyle: textThem.headline5,
        enableCaching: true,
        onLoadingBuilder: (context, element, loadingProgress) => Loading(),
      ),
    );
  }

  Widget informationUser(TextTheme textThem) {
    return Row(
      children: [
        Image.asset(
          'assets/icons/pro.png',
          height: 50,
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          singleArticleController.articleInfoModel.value.author!,
          style: textThem.headline4,
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          singleArticleController.articleInfoModel.value.createdAt!,
          style: textThem.caption,
        ),
      ],
    );
  }

  Widget title(TextTheme textThem) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        singleArticleController.articleInfoModel.value.title!,
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
            IconButton(onPressed: () =>Get.back() ,
              icon:Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),),
            Expanded(child: SizedBox()),
            Icon(
              Icons.bookmark_border_outlined,
              color: Colors.white,
            ),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.share,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget imagePoster() {
    return CachedNetworkImage(
        imageUrl: singleArticleController.articleInfoModel.value.image!,
        imageBuilder: (context, imageProvider) => Image(image: imageProvider),
        placeholder: (context, url) => Loading(),
        errorWidget: (context, url, error) =>
            Image.asset('assets/images/single_place_holder.jpg'));
  }

  Widget tags(TextTheme textThem) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: SizedBox(
        height: 45,
        child: ListView.builder(
          itemCount: singleArticleController.tagList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () async {
              String tagId = singleArticleController.tagList[index].id!;
              await Get.find<ListArticleController>()
                  .getArticleListWithTagId(tagId);
              String tagName = singleArticleController.tagList[index].title!;
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
                  child: Text(
                    singleArticleController.tagList[index].title!,
                    textAlign: TextAlign.center,
                    style: textThem.headline4,
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Colors.grey),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget simmilar(textThem) {
    return SizedBox(
      height: Get.height / 3.5,
      child: Obx(
        () => ListView.builder(
            itemCount: singleArticleController.relatedList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((contex, index) {
              return itemListSimmilar(index, textThem);
            })),
      ),
    );
  }

  Widget itemListSimmilar(int index, textThem) {
    return GestureDetector(
      onTap: () {
        singleArticleController.getArticleInfo(
            singleArticleController.getArticleInfo(int.parse(singleArticleController.relatedList[index].id!)));
      },
      child: Padding(
        padding: EdgeInsets.only(right: index == 0 ? sizeWith / 10 : 15),
        child: Column(
          children: [
            SizedBox(
              height: sizeHeight / 5.3,
              width: sizeWith / 2.4,
              child: Stack(
                children: [
                  Container(
                    child: CachedNetworkImage(
                      imageUrl:
                          singleArticleController.relatedList[index].image!,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              )),
                        );
                      },
                      placeholder: (context, url) => Loading(),
                      errorWidget: (context, url, error) => Icon(
                        Icons.image_not_supported_outlined,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    foregroundDecoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        gradient: LinearGradient(
                            colors: GradiantColors.bolgPost,
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter)),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 0,
                    left: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          singleArticleController.relatedList[index].author!,
                          style: textThem.subtitle1,
                        ),
                        Row(
                          children: [
                            Text(
                              singleArticleController.relatedList[index].view!,
                              style: textThem.subtitle1,
                            ),
                            SizedBox(
                              width: 6.0,
                            ),
                            Icon(
                              Icons.remove_red_eye_sharp,
                              size: 16,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: sizeWith / 2.4,
              child: Text(
                singleArticleController.relatedList[index].title!,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            )
          ],
        ),
      ),
    );
  }

}
