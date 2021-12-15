import 'dart:convert';

import 'package:article_app/core/core.dart';
import 'package:article_app/futures/articles/articles.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixture/fixture_reader.dart';
import 'get_aricle_local_data_test.mocks.dart';
@GenerateMocks([LocalStorage])
void main(){
  late GetArticleLocalDataImpl dataSource;
  late MockLocalStorage mockLocalStorage;

  setUp((){
    mockLocalStorage = MockLocalStorage();
    dataSource = GetArticleLocalDataImpl(localStorage: mockLocalStorage);
  });

  group("cache articles", (){
    //  handling matcher data
    List<Article> articles = [];
    final fixtureData = json.decode(fixture('cached_articles_data.json'));
    articles =List<Article>.from(fixtureData.map((item)=> ArticleModel.fromJson(item)));
    setUp((){
      // check if local storage instance is ready for read/write operations
      when(mockLocalStorage.ready).thenAnswer((_) async=>true);
    });

    test("should call local storage and return cached data when the articles data is present",()async{

      when(mockLocalStorage.getItem(CACHED_ARTICLE_LIST)).thenAnswer((_) =>json.decode(fixture('cached_articles_data.json')));
      final result = await dataSource.getArticles();
      verify(mockLocalStorage.ready);
      verify(mockLocalStorage.getItem(CACHED_ARTICLE_LIST));

      expect(result, articles);

    });

    test("should throw cache exceptions when there are not articles data cached",(){

      when(mockLocalStorage.getItem(CACHED_ARTICLE_LIST)).thenAnswer((_) => null);
      final call = dataSource.getArticles();
      expect(()=>  call, throwsA(const TypeMatcher<CacheException>()));

    });

    test("should cache data when the cacheArticles method it is has been call", ()async{
      await dataSource.cacheArticles(articles: articles);
      verify(mockLocalStorage.setItem(CACHED_ARTICLE_LIST, json.encode(articles)));
    });


  });

  group("cache single articles", (){
    //  handling matcher data
   Article article = ArticleModel.fromJson(json.decode(fixture('cached_single_article_data.json')));
    setUp((){
      // check if local storage instance is ready for read/write operations
      when(mockLocalStorage.ready).thenAnswer((_) async=>true);
    });

    test("should call local storage and return cached single article data when the data is present",()async{
      when(mockLocalStorage.getItem(CACHED_SINGLE_ARTICLE)).thenAnswer((_) =>json.decode(fixture('cached_single_article_data.json')));
      final result = await dataSource.getSingleArticle();
      verify(mockLocalStorage.ready);
      verify(mockLocalStorage.getItem(CACHED_SINGLE_ARTICLE));
      expect(result, article);

    });

    test("should throw cache exceptions when there are not single article data cached",(){

      when(mockLocalStorage.getItem(CACHED_SINGLE_ARTICLE)).thenAnswer((_) => null);
      final call = dataSource.getSingleArticle();
      expect(()=>  call, throwsA(const TypeMatcher<CacheException>()));

    });
    //
    test("should cache data when the cacheSingleArticle method it is has been call", ()async{
      await dataSource.cacheSingleArticle(article: article);
      verify(mockLocalStorage.setItem(CACHED_SINGLE_ARTICLE, json.encode(article)));
    });


  });

}