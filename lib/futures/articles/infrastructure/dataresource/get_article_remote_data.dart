import 'dart:convert';
import 'dart:io';

import 'package:article_app/core/core.dart';
import 'package:article_app/core/utils/constant.dart';

import '../../articles.dart';
import 'package:http/http.dart' as htp;
abstract class GetArticleRemoteData {

  // fetch data from server side
  Future <List<Article>>? getArticles();
  Future <Article>? getSingleArticle({required String articleId});

}

class GetArticleRemoteDataImpl implements GetArticleRemoteData{
  final htp.Client httpClient;
  GetArticleRemoteDataImpl({required this.httpClient});

  @override
  Future<List<Article>>? getArticles() async{
    List<Article> articles=[];
    final response = await httpClient.get(Uri.parse(Constant().endPoint("")),headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
    });
    if(response.statusCode==200){

      final data = json.decode(response.body);
      for(var item in data['articles']){
        articles.add(ArticleModel.fromJson(item));
      }

    }else{
      throw ServerException();
    }
    return articles;
  }

  @override
  Future<Article>? getSingleArticle({required String articleId}) async{
   final response = await httpClient.get(Uri.parse("uri"),headers: {
     HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
   });
   Article article ;
   if(response.statusCode==200){
     final dataJson = json.decode(response.body);

     article = ArticleModel.fromJson(dataJson);
   }else{
     throw ServerException();
   }
   return article;
  }

}