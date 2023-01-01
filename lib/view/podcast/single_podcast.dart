import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tec/component/decoration.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/component/my_componenet.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/controller/podcast/SinglePodcastController.dart';
import 'package:tec/model/podcast_model.dart';

class SinglePodcast extends StatelessWidget {

  late SinglePodcastController singlePodcastController;
  late PodcastModel podcastModel ;
  SinglePodcast(){
    podcastModel = Get.arguments;
    singlePodcastController = Get.put(SinglePodcastController(id: podcastModel.id));
  }

  @override
  Widget build(BuildContext context) {
    var textThem = Theme.of(context).textTheme;
    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Column(
            children: [
              poster(),
              title(textThem),
              informationUser(textThem),
              podcastsList(textThem),
            ],
          ),
        ),
        Obx(
              ()=> Positioned(
              bottom: 8.0,
              left: Dimens.bodyMargin,
              right: Dimens.bodyMargin,
              child: Container(
                height: Get.height / 7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      LinearPercentIndicator(
                        percent: 1.0,
                        backgroundColor: Colors.white,
                        progressColor: Colors.orange,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              onPressed: () async => await singlePodcastController.player.seekToNext(),
                              icon:Icon(Icons.skip_next,color: Colors.white, size:42,)
                          ),
                          IconButton(
                              onPressed: () {
                                singlePodcastController.player.playing?
                                singlePodcastController.player.pause():
                                singlePodcastController.player.play();
                                singlePodcastController.playState.value = singlePodcastController.player.playing;
                              },
                              icon:Icon(
                                singlePodcastController.playState.value ?
                                Icons.pause_circle_filled:
                                Icons.play_circle_fill,
                                color: Colors.white,size:45,)
                          ),
                          IconButton(
                              onPressed: () async => await singlePodcastController.player.seekToPrevious(),
                              icon:Icon(    Icons.skip_previous,
                                color: Colors.white,size:42,)
                          ),
                          SizedBox(),
                          IconButton(
                              onPressed: () {},
                              icon:Icon(Icons.repeat,
                                color: Colors.yellow,size:35,)
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                decoration: MyDecorations.mainGradiant,
              )),
        )
      ],
    )));
  }

  Widget podcastsList(TextTheme textThem) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(
        ()=> ListView.builder(
          shrinkWrap: true,
          itemCount: singlePodcastController.podcastFileList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ImageIcon(
                    AssetImage('assets/icons/voice.png'),
                    color: SolidColors.seeMore,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    width: Get.width/1.5,
                    child: Text(
                      singlePodcastController.podcastFileList[index].title!,
                      style: textThem.headline4,
                    ),
                  ),
                  Expanded(child: SizedBox.shrink()),
                  Text(singlePodcastController.podcastFileList[index].length!+':00'),
                ],
              ),
            );
          },
        ),
      ),
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

  Widget appBarPoster() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
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
            IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            Expanded(child: SizedBox()),
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
    return SizedBox(
      width: Get.width,
      height: Get.height / 3,
      child: CachedNetworkImage(
          imageUrl:podcastModel.poster!,
          imageBuilder: (context, imageProvider) => Image(image: imageProvider,fit: BoxFit.fill,),
          placeholder: (context, url) => Loading(),
          errorWidget: (context, url, error) =>
              Image.asset('assets/images/single_place_holder.jpg')),
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
          podcastModel.publisher!,
          style: textThem.headline4,
        ),
        SizedBox(
          width: 15,
        ),
      ],
    );
  }

  Widget title(TextTheme textThem) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          podcastModel.title!,
          maxLines: 2,
          style: textThem.titleLarge,
        ),
      ),
    );
  }
}
