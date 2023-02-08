import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                     ProgressBar(
                         timeLabelTextStyle: TextStyle(color: Colors.white),
                          thumbColor: Colors.yellow,
                          baseBarColor: Colors.white,
                          progressBarColor: Colors.orange,
                          buffered: singlePodcastController.bufferedValue.value,
                          progress: singlePodcastController.progressValue.value,
                          total: singlePodcastController.player.duration?? Duration(seconds: 0),
                         onSeek:(position) async {
                           singlePodcastController.player.seek(position);
                           if(singlePodcastController.player.playing){
                             singlePodcastController.startProgress();
                           }else if(position <= Duration(seconds: 0)){
                            await singlePodcastController.player.seekToNext();
                            singlePodcastController.currentFileIndex.value = singlePodcastController.player.currentIndex!;
                            singlePodcastController.checkTheResetTimer();
                           }
                         },
                     ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              onPressed: () async {
                                await singlePodcastController.player.seekToNext();
                                singlePodcastController.currentFileIndex.value = singlePodcastController.player.currentIndex!;
                                singlePodcastController.checkTheResetTimer();
                              } ,
                              icon:Icon(Icons.skip_next,color: Colors.white, size:40,)
                          ),
                          IconButton(
                              onPressed: () {
                                singlePodcastController.player.playing?
                                singlePodcastController.timer!.cancel():
                                singlePodcastController.startProgress();

                                singlePodcastController.player.playing?
                                singlePodcastController.player.pause():
                                singlePodcastController.player.play();

                                singlePodcastController.playState.value = singlePodcastController.player.playing;
                                singlePodcastController.currentFileIndex.value = singlePodcastController.player.currentIndex!;
                              },
                              icon:Icon(
                                singlePodcastController.playState.value ?
                                Icons.pause_circle_filled:
                                Icons.play_circle_fill,
                                color: Colors.white,size:40,)
                          ),
                          IconButton(
                              onPressed: () async {
                                await singlePodcastController.player.seekToPrevious();
                                singlePodcastController.currentFileIndex.value = singlePodcastController.player.currentIndex!;
                                singlePodcastController.checkTheResetTimer();
                              },
                              icon:Icon(    Icons.skip_previous,
                                color: Colors.white,size:40,)
                          ),
                          SizedBox(),
                          Obx(
                              ()=> IconButton(
                                onPressed: () {
                                singlePodcastController.setLoopMode();
                                },
                                icon:Icon(Icons.repeat,
                                  color:singlePodcastController.isLoopAll.value? Colors.blue : Colors.white,size:30,)
                            ),
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
            return GestureDetector(
              onTap: () async {
                await singlePodcastController.player.seek(Duration.zero, index: index);
                singlePodcastController.currentFileIndex.value = singlePodcastController.player.currentIndex!;
                singlePodcastController.player.play();
                singlePodcastController.playState.value = singlePodcastController.player.playing;
                singlePodcastController.startProgress();
              },
              child: Padding(
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
                      child: Obx(
                        ()=> Text(
                          singlePodcastController.podcastFileList[index].title!,
                          style: singlePodcastController.currentFileIndex.value == index ? textThem.headline3 : textThem.headline4,
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox.shrink()),
                    Text(singlePodcastController.podcastFileList[index].length!+':00'),
                  ],
                ),
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
