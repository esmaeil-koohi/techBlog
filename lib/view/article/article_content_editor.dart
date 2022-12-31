import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:tec/component/my_componenet.dart';
import 'package:tec/controller/article/manage_article_controller.dart';


class ArticleContentEditor extends StatelessWidget {
   ArticleContentEditor({Key? key}) : super(key: key);

  final HtmlEditorController controller = HtmlEditorController();
  ManageArticleController manageArticleController = Get.put(ManageArticleController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:()=> controller.clearFocus(),
      child: Scaffold(
        appBar: appBar('نوشتن/ویرایش مقاله'),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HtmlEditor(
                  controller: controller,
                 htmlEditorOptions: HtmlEditorOptions(
                   hint: '...میتونی مقالتو اینجا بنویسی',
                   shouldEnsureVisible: true,
                   initialText:manageArticleController.articleInfoModel.value.content
                 ),
                callbacks: Callbacks(
                  onChangeContent: (p0) => manageArticleController.articleInfoModel.update((val) {
                    val?.content = p0;
                  }),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
