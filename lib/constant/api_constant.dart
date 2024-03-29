class ApiUrlConstant {
  ApiUrlConstant._();
  static const hostDlUrl = "https://techblog.sasansafari.com";
  static const baseUrl = "https://techblog.sasansafari.com/Techblog/api/";
  static const getHomeItems = baseUrl + "home/?command=index";
  static const publishedByMe =baseUrl + "/article/get.php?command=published_by_me&user_id=";
  static const getArticleList = baseUrl + "article/get.php?command=new&user_id=";
  static const postRegister = baseUrl + "register/action.php";
  static const articlePost = baseUrl + "article/post.php";
  static const podcastFiles =baseUrl + "podcast/get.php?command=get_files&podcats_id=";
}

class ApiKeyArticleConstance {
  ApiKeyArticleConstance._();
  static const title = 'title';
  static const content = 'content';
  static const catId = 'cat_id';
  static const userId = 'user_id';
  static const image = 'image';
  static const command = 'command';
  static const tagList = 'tag_list';

}