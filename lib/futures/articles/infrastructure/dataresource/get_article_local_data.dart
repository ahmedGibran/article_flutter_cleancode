import '../../articles.dart';

abstract class GetArticleLocalData{

  // get data when there data in present
  Future <List<Article>>? getArticles();
  Future <Article>? getSingleArticle();

  // should to save data when there no data from remote
  Future <void>? cacheArticles({ List<Article> articles});
  Future <void>? cacheSingleArticle();

}