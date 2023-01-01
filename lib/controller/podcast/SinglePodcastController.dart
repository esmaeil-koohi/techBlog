import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/model/podcats_file_model.dart';
import 'package:tec/services/dio_service.dart';

class SinglePodcastController extends GetxController{
  var id;
  SinglePodcastController({this.id});
  RxBool loading = false.obs;
  RxList<PodcastsFileModel> podcastFileList = RxList();
  final player = AudioPlayer();
  late var playList;
  RxBool playState = false.obs;

  @override
  onInit() async{
    super.onInit();
    playList = ConcatenatingAudioSource(
      useLazyPreparation: true,
        children: []);
  await getPodcastFiles();
  await player.setAudioSource(playList, initialIndex: 0,initialPosition: Duration.zero);
  }

  getPodcastFiles() async{
    loading.value = true;
    var response = await DioService().getMethod(ApiUrlConstant.podcastFiles +id);
    if(response.statusCode == 200){
       for(var element in response.data['files']){
         podcastFileList.add(PodcastsFileModel.fromJson(element));
         playList.add(AudioSource.uri(Uri.parse(PodcastsFileModel.fromJson(element).file!)));
       }
       loading.value = false;
    }
  }


}