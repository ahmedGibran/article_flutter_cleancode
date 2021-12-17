import 'dart:convert';
import 'dart:io';
import 'package:article_app/core/core.dart';
import 'package:article_app/futures/articles/articles.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import '../../../../fixture/fixture_reader.dart';
import 'get_article_remote_data_test.mocks.dart';

@GenerateMocks([http.Client])
void main(){
  late GetArticleRemoteDataImpl dataSource;
  late MockClient mockHttpClient;

  setUp((){
      mockHttpClient = MockClient();
      dataSource = GetArticleRemoteDataImpl(httpClient:mockHttpClient);
  });



  group("get articles list  by remote data", (){
    void callSuccess200(){
      when(mockHttpClient.get(any,headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      })).thenAnswer((_)async => http.Response(fixture("articles.json"),200, headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      }));
    }
    final fixtureData = json.decode(fixture("articles.json"));
    List<Article> articles = List<Article>.from(fixtureData.map((item)=>ArticleModel.fromJson(item)));

    test("should call get Method and statues code should be 200 (success)", ()async{
      callSuccess200();
      await dataSource.getArticles();
      verify(mockHttpClient.get(any,headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      }));
    });

    test("should get articles list response when call getArticles and statues code of http.get equal 200 (success)", ()async{

      when(mockHttpClient.get(any,headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'

      })).thenAnswer((_)async => http.Response(fixture("articles.json"),200, headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      }));

      final result = await dataSource.getArticles();
      verify(mockHttpClient.get(any,headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      }));
      expect(result, equals(articles));
    });

    test("should throw exception when the statues code of http.get does not equal 200 or 201 (success)", ()async{

      when(mockHttpClient.get(any,headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      })).thenAnswer((_)async => http.Response("wrong response",404, headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      }));

      final call =  dataSource.getArticles;
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });

  });

  group("get single article by remote data", (){
    void callSuccess200(){
      when(mockHttpClient.get(any,headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      })).thenAnswer((_)async => http.Response(fixture("article.json"),200, headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      }));
    }
    const String articleId = "1";
    final fixtureData = json.decode(fixture("article.json"));
    Article article =ArticleModel.fromJson(fixtureData);
    test("should call get Method and statues code should be 200 (success)", ()async{
      callSuccess200();
      await dataSource.getSingleArticle(articleId: articleId);
      verify(mockHttpClient.get(any,headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      }));
    });
    test("should get article response when call getSingleArticle and statues code of http.get equal 200 (success)", ()async{
      callSuccess200();
      final result = await dataSource.getSingleArticle(articleId: articleId);
      verify(mockHttpClient.get(any,headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      }));
      expect(result, equals(article));
    });
    test("should throw exception when the statues code of http.get does not equal 200 or 201 (success)", ()async{
      when(mockHttpClient.get(any,headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      })).thenAnswer((_)async => http.Response("wrong response",404, headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      }));

      final call =  dataSource.getSingleArticle;
      expect(() => call(articleId: articleId), throwsA(const TypeMatcher<ServerException>()));
    });

  });



}