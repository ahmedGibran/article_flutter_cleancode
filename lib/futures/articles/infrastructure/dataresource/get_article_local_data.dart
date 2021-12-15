import 'dart:convert';

import 'package:article_app/core/core.dart';
import 'package:localstorage/localstorage.dart';
import 'package:json_helpers/json_helpers.dart';

import '../../articles.dart';

abstract class GetArticleLocalData{

  // get data when there data in present
  Future <List<Article>>? getArticles();
  Future <Article>? getSingleArticle();

  // should to save data when there no data from remote
  Future <void>? cacheArticles({ List<Article> articles});
  Future <void>? cacheSingleArticle({ Article? article});

}

const  String CACHED_ARTICLE_LIST = "CACHED_ARTICLE_LIST";
const  String CACHED_SINGLE_ARTICLE = "CACHED_SINGLE_ARTICLE";

class GetArticleLocalDataImpl implements GetArticleLocalData{
  LocalStorage localStorage;
  GetArticleLocalDataImpl({required this.localStorage});

  @override
  Future<void>? cacheArticles({List<Article>? articles}) async{
    bool ready = await localStorage.ready;
    if(ready){
      return  localStorage.setItem(CACHED_ARTICLE_LIST,json.encode(articles));
      }else{
      throw CacheException();
    }


  }

  @override
  Future<void>? cacheSingleArticle({ Article? article}) async{

    bool ready = await localStorage.ready;
    if(ready){
      return  localStorage.setItem(CACHED_SINGLE_ARTICLE,json.encode(article));
    }else{
      throw CacheException();
    }
  }

  @override
  Future<List<Article>>? getArticles() async{
    List<Article> articles =[];
    //A future indicating if local storage instance is ready for read/write operations
    bool ready = await localStorage.ready;
    if(ready){
      final list = localStorage.getItem(CACHED_ARTICLE_LIST);
      if(list!=null){
        articles =List<Article>.from(list.map((model)=> ArticleModel.fromJson(model)));
      }else{
        throw CacheException();
      }

    }

    return articles;

  }

  @override
  Future<Article>? getSingleArticle() async{
    late Article article ;
    //A future indicating if local storage instance is ready for read/write operations
    bool ready = await localStorage.ready;
    if(ready){
      final item = localStorage.getItem(CACHED_SINGLE_ARTICLE);
      if(item!=null){
        article = ArticleModel.fromJson(item);
      }else{
        throw CacheException();
      }

    }

    return article;
  }

}