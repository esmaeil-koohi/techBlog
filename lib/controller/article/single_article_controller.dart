import 'package:get/get.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/model/article_info_model.dart';
import 'package:tec/model/article_model.dart';
import 'package:tec/model/tags_model.dart';
import 'package:tec/services/dio_service.dart';
import 'package:tec/view/article/single.dart';

class SingleArticleController extends GetxController {
  RxBool loading = false.obs;
  Rx<ArticleInfoModel> articleInfoModel = ArticleInfoModel().obs;
  RxList<TagsModel> tagList = RxList();
  RxList<ArticleModel> relatedList = RxList();


   getArticleInfo(int id) async {
     articleInfoModel = ArticleInfoModel().obs;
     Get.to( Single());
     loading.value = true;
     //ToDo userid is hard code
     String userId = '';
     var response = await DioService().getMethod(ApiConstant.baseUrl+'article/get.php?command=info&id=$id&user_id=$userId');
     if (response.statusCode == 200) {
      articleInfoModel.value = ArticleInfoModel.fromJson(response.data);
      loading.value = false;
    }

     tagList.clear();
     response.data['tags'].forEach((element) {
       tagList.add(TagsModel.fromJson(element));
     });

     relatedList.clear();
     response.data['related'].forEach((element) {
       relatedList.add(ArticleModel.fromJson(element));
     });

    }

  }

