import 'package:get/get.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/model/podcats_file_model.dart';
import 'package:tec/services/dio_service.dart';

class SinglePodcastController extends GetxController{
  var id;
  SinglePodcastController({this.id});
  RxBool loading = false.obs;

  RxList<PodcastsFileModel> podcastFileList = RxList();

  @override
  onInit(){
    super.onInit();
    getPodcastFiles();
  }

  getPodcastFiles() async{
    loading.value = true;
    var response = await DioService().getMethod(ApiUrlConstant.postRegister +id);
    if(response.statusCode == 200){
       for(var element in response.data['files']){
         podcastFileList.add(PodcastsFileModel.fromJson(element));
       }
       loading.value = false;
    }

  }


}