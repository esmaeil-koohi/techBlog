import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tec/controller/home_screen_controller.dart';
import 'package:tec/controller/article/single_article_controller.dart';
import 'package:tec/model/fake_data.dart';
import 'package:tec/view/article/article_list_screen.dart';
import '../../constant/my_colors.dart';
import '../../component/my_componenet.dart';
import '../../constant/my_strings.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    Key? key,
    required this.size,
    required this.textThem,
    required this.bodyMargin,
  }) : super(key: key);

  HomeScreenController homeScreenController = Get.put(HomeScreenController());

  final Size size;
  final TextTheme textThem;
  final double bodyMargin;


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Obx(
        ()=> Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
          child:homeScreenController.loading.value == false ? Column(
              children: [
                homePagePoster(),
                const SizedBox(height: 16.0,),
                tags(),
                const SizedBox(height: 32.0,),
                seeMoreBlog(),
                topVisited(),
                seeMorePodcats(),
                topPodcast(),
              ],
            )
          : Loading(),
        ),
      ),
    );
  }

  Widget topVisited() {
    return SizedBox(
      height: size.height / 3.5,
      child: Obx(
        () => ListView.builder(
            itemCount: homeScreenController.topVisitedList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((contex, index) {
              // blog item
              return GestureDetector(
                onTap: () {
                  Get.find<SingleArticleController>().
                  getArticleInfo(int.parse(homeScreenController.topVisitedList[index].id!));
                },
                child: Padding(
                  padding: EdgeInsets.only(right: index == 0 ? bodyMargin : 15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height / 5.3,
                        width: size.width / 2.4,
                        child: Stack(
                          children: [
                            Container(
                              child: CachedNetworkImage(
                          imageUrl:
                              homeScreenController.topVisitedList[index].image!,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                  ),
                              foregroundDecoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
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
                                    homeScreenController
                                        .topVisitedList[index].author!,
                                    style: textThem.subtitle1,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        homeScreenController
                                            .topVisitedList[index].view!,
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
                        width: size.width / 2.4,
                        child: Text(
                          homeScreenController.topVisitedList[index].title!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      )
                    ],
                  ),
                ),
              );
            })),
      ),
    );
  }

  Widget topPodcast() {
    return SizedBox(
      // height: size.height / 4.3,
      height: size.height / 3.5,
      child: Obx(
        () => ListView.builder(
            itemCount: homeScreenController.topPodcasts.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: index == 0 ? bodyMargin : 15),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height / 5.3,
                      width: size.width / 2.4,
                      child: CachedNetworkImage(
                        imageUrl:
                            homeScreenController.topPodcasts[index].poster!,
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
                    ),
                    SizedBox(
                      height: size.width / 2.4,
                      child: Text(
                        homeScreenController.topPodcasts[index].title!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget homePagePoster(){
    return Stack(
        children: [
          Container(
            width: size.width / 1.25,
            height: size.height / 4.2,
            child:CachedNetworkImage(
                          imageUrl:
                              homeScreenController.poster.value.image!,
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
                          placeholder: (context, url) => SpinKitFadingCube(
                            color: SolidColors.primeryColor,
                            size: 32.0,
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.image_not_supported_outlined,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ), 
            foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                gradient: LinearGradient(
                  colors: GradiantColors.homepostCoverGradiant,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
          ),
          Positioned(
            bottom: 8,
            right: 0,
            left: 0,
            child: Text(
              homeScreenController.poster.value.title!,
              style: textThem.headline1,
            ),
          )
        ],
      );
     
  }

  Widget tags(){
return SizedBox(
      height: 60,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tagList.length,
          itemBuilder: ((context, index) {
            return Padding(
              padding:
                  EdgeInsets.fromLTRB(0, 8, index == 0 ? bodyMargin : 15, 8),
              child: MainTags(textThem: textThem, index: index),
            );
          })),
    );
  }
  
  Widget seeMorePodcats(){
    return Padding(
      padding: EdgeInsets.only(right: bodyMargin, bottom: 8),
      child: Row(
        children: [
          ImageIcon(
            AssetImage('assets/icons/voice.png'),
            color: SolidColors.seeMore,
          ),
          SizedBox(
            width: 6.0,
          ),
          Text(
            MyString.viewHotestPodcasts,
            style: textThem.headline3,
          ),
        ],
      ),
    );
  }

  Widget seeMoreBlog(){
return GestureDetector(
  onTap: () {
    Get.to(ArticleListScreen(title: 'مقالات'));
  },
  child: SeeMore(title: MyString.viewHotesBlog, bodyMargin: bodyMargin,)
);
 }
}








