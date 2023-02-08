import 'package:get/get.dart';
import 'package:tec/route_manager/binding.dart';
import 'package:tec/route_manager/named_route.dart';
import 'package:tec/view/article/manage_article.dart';
import 'package:tec/view/article/single.dart';
import 'package:tec/view/article/single_manage_article.dart';
import 'package:tec/view/main_screen/main_screen.dart';
import 'package:tec/view/podcast/single_podcast.dart';
import 'package:tec/view/splash_screen.dart';

class Pages{

  Pages._();

  static List<GetPage> pages = [
    GetPage(
      name: NamedRouted.initialRoute,
      page: () => SplashScreen(),
    ),
    GetPage(
  name: NamedRouted.routeMainScreen,
  page: () => MainScreen(),
  binding: RegisterBinding(),
  ),
  GetPage(
  name: NamedRouted.routeSingleArticle,
  page: () => Single(),
  binding: ArticleBinding(),
  ),
  GetPage(
  name: NamedRouted.routeManageArticle,
  page:()=> ManageArticle(),
  binding: ArticleManagerBinding(),
  ),
  GetPage(
  name: NamedRouted.routeSingleManageArticle,
  page:()=> SingleManageArticle(),
  binding: ArticleManagerBinding(),
  ),
  GetPage(
  name: NamedRouted.routeSinglePodcast,
  page:()=> SinglePodcast(),
  ),
  ];


}