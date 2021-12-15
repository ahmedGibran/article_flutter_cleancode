import '../../articles.dart';

abstract class GetArticleRemoteData {

  // fetch data from server side
  Future <List<Article>>? getArticles();
  Future <Article>? getSingleArticle();

}