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
    podcastModel.id = Get.arguments;
    singlePodcastController = Get.put(SinglePodcastController(id: podcastModel.id));
  }

  @override
  Widget build(BuildContext context) {
    print(singlePodcastController.id);
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
        Positioned(
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
                            onPressed: () {},
                            icon:Icon(Icons.skip_next,color: Colors.white, size:45,)
                        ),
                        IconButton(
                            onPressed: () {},
                            icon:Icon( Icons.play_circle_fill,
                              color: Colors.white,size:45,)
                        ),
                        IconButton(
                            onPressed: () {},
                            icon:Icon(    Icons.skip_previous,
                              color: Colors.white,size:45,)
                        ),
                        SizedBox(),
                        IconButton(
                            onPressed: () {},
                            icon:Icon(Icons.repeat,
                              color: Colors.yellow,size:45,)
                        ),
                      ],
                    )
                  ],
                ),
              ),
              decoration: MyDecorations.mainGradiant,
            ))
      ],
    )));
  }

  Widget podcastsList(TextTheme textThem) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
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
                Text(
                  'بخش چهارم : فریلنسر دیوانه',
                  style: textThem.headline4,
                ),
                Expanded(child: SizedBox.shrink()),
                Text('22:00'),
              ],
            ),
          );
        },
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
    return CachedNetworkImage(
        imageUrl:
            'https://onlinejpgtools.com/images/examples-onlinejpgtools/mountains-near-water-better-quality.jpg',
        imageBuilder: (context, imageProvider) => Image(image: imageProvider),
        placeholder: (context, url) => Loading(),
        errorWidget: (context, url, error) =>
            Image.asset('assets/images/single_place_holder.jpg'));
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
          'اسماعیل کوهی',
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
          'عنوان مقاله',
          maxLines: 2,
          style: textThem.titleLarge,
        ),
      ),
    );
  }
}
