import 'package:tec/constant/api_constant.dart';

class PodcastsFileModel{
  String? id;
  String? podcastsId;
  String? file;
  String? title;
  String? length;

  PodcastsFileModel();
  PodcastsFileModel.fromJson(Map<String, dynamic> element){
    id = element['id'];
    podcastsId = element['podcast_id'];
    file = ApiUrlConstant.hostDlUrl + element['file'];
    title = element['title'];
    length = element['length'];
  }

}