import 'package:get/get.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/model/article_model.dart';
import 'package:tec/model/poster_model.dart';
import 'package:tec/model/tags_model.dart';
import 'package:tec/services/dio_service.dart';
import '../model/podcast_model.dart';

class HomeScreenController extends GetxController {
  Rx<PosterModel> poster = PosterModel().obs;
  RxList<TagsModel> tagsList = RxList();
  RxList<ArticleModel> topVisitedList = RxList();
  RxList<PodcastModel> topPodcasts = RxList();
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getHomeItems();
  }

  void getHomeItems() async {
    loading.value = true;
    var response = await DioService().getMethod(ApiUrlConstant.getHomeItems);
    if (response.statusCode == 200) {
      response.data['top_visited'].forEach((element) {
        topVisitedList.add(ArticleModel.fromJson(element));
      });
      response.data['top_podcasts'].forEach((element) {
        topPodcasts.add(PodcastModel.fromJson(element));
      });
      response.data['tags'].forEach((element) {
        tagsList.add(TagsModel.fromJson(element));
      });
      poster.value = PosterModel.fromJson(response.data['poster']);
      loading.value = false;
    }
  }
}
