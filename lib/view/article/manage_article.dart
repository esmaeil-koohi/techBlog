import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/component/my_componenet.dart';
import 'package:tec/controller/article/manage_article_controller.dart';
import 'package:tec/named_route.dart';
import '../../constant/my_strings.dart';

class ManageArticle extends StatelessWidget {
   ManageArticle({Key? key}) : super(key: key);

  var articleManageController = Get.find<ManageArticleController>();

  @override
  Widget build(BuildContext context) {
    var textThem = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: appBar('مدیریت مقاله'),
        body: Obx(
              () =>articleManageController.loading.value ? Loading(): articleManageController.articleList.isNotEmpty ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: articleManageController.articleList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                     // rout single manage
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: Get.width / 3,
                            height: Get.height / 6,
                            child: CachedNetworkImage(
                              imageUrl: articleManageController
                                  .articleList[index].image!,
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover)),
                                );
                              },
                              placeholder: (context, url) => Loading(),
                              errorWidget: (context, url, error) => Icon(
                                Icons.image_not_supported_outlined,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: Get.width / 2,
                                child: Text(
                                  articleManageController
                                      .articleList[index].title!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    articleManageController
                                        .articleList[index].author!,
                                    style: textThem.caption,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    articleManageController
                                        .articleList[index].view! +
                                        "بازدید",
                                    style: textThem.caption,
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ):articleEmptyState(textThem),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ButtonStyle(fixedSize: MaterialStateProperty.all(Size(Get.width / 10, 56))),
            onPressed: () {
              Get.toNamed(NamedRouted.routeSingleManageArticle);
            },
            child: const Text('بریم برای نوشتن یه مقاله باحال'),
          ),
        ),
      ),
    );
  }

  Widget articleEmptyState(TextTheme textThem) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/tecbot2.png',
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: MyString.articleEmpty,
                  style: textThem.headline4,
                ),
              ),
            ),

          ],
        ),
      );
  }


}
