

import 'package:tec/constant/api_constant.dart';

class PodcastModel {
  String? id;
  String? title;
  String? poster;
  String? publisher;
  String? view;
  String? creatAt;

  PodcastModel(
      {required this.id,
      required this.title,
      required this.poster,
      required this.publisher,
      required this.view,
      required this.creatAt});

  PodcastModel.fromJson(Map<String, dynamic> element){
      id = element["id"];
      title = element["title"];      
      poster =ApiUrlConstant.hostDlUrl + element["poster"];
      publisher = element["author"];
      view = element["view"];
      creatAt = element["created_at"];
  }

}
