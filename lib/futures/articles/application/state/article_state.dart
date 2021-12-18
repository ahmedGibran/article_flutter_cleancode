import 'package:article_app/core/core.dart';
import 'package:article_app/futures/articles/articles.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class ArticleState extends ChangeNotifier{
   bool _isLoading = false;
   bool  _isError = false;
   bool  _isSuccess = false;
   List<Article>? _articles;
   late Article _article;
  final GetArticles getArticles ;
  final GetSingleArticle getSingleArticles;

  // = GetSingleArticle(
   //           articleRepository: ArticleRepositoryImpl(
   //           networkInfo: NetworkInfoImpl(InternetConnectionChecker()),
   //           getArticleRemoteData: GetArticleRemoteDataImpl(httpClient: http.Client()),
   //           getArticleLocalData: GetArticleLocalDataImpl(localStorage: LocalStorage("article_app"))));
  bool get isLoading=>_isLoading;
  bool get isError=>_isError;
  bool get isSuccess=>_isSuccess;
  List<Article>? get articles=>_articles;
  Article get article=>_article;
   ArticleState({required  this.getArticles, required this.getSingleArticles}){
     _isSuccess = false;
     _isError = false;
     _isLoading = false;
     _articles =[];
     getArticlesState();
   }

  Future<void> getArticlesState()async{

    _isLoading = true;
    notifyListeners();
    final result = await getArticles.getArticles();
    result?.fold((l){
      _isSuccess = false;
      _isError = true;
      _isLoading = false;
      notifyListeners();

    }, (r){
      _articles = r;
        _isSuccess = true;
        _isError = false;
        _isLoading = false;
        notifyListeners();

  });


}

  Future<void> getSingleArticleState({required String articleId})async{

    _isLoading = true;
    notifyListeners();
    final result = await getSingleArticles.getSingleArticle(articleId:articleId);
    result?.fold((l){
      _isSuccess = false;
      _isError = true;
      _isLoading = false;
      notifyListeners();

    }, (r){
      _article = r;
        _isSuccess = true;
        _isError = false;
        _isLoading = false;
        notifyListeners();

  });


}

}