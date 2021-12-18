import 'dart:convert';

import 'package:article_app/core/core.dart';
import 'package:article_app/futures/articles/articles.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixture/fixture_reader.dart';
import '../../domain/usecase/get_articles_test.dart';

@GenerateMocks([ArticleRepository])
void main(){
   late ArticleState articleState;
   late GetArticles getArticles;
   late GetSingleArticle getSingleArticle;
   late MockArticleRepository mockArticleRepository;
   late bool? isSuccess;
   late bool? isError;
   late bool? isLoading;

  setUp((){

    mockArticleRepository = MockArticleRepository();
    getArticles = GetArticles(repository:mockArticleRepository);
    getSingleArticle = GetSingleArticle(articleRepository:mockArticleRepository);
    articleState=  ArticleState(getArticles: getArticles,getSingleArticles: getSingleArticle);

  });
   group("article state logic",(){
   group("get articles state", (){
     final dataFixture = json.decode(fixture("articles.json"));
     List<Article> articles = List<Article>.from(dataFixture['articles'].map((item)=>ArticleModel.fromJson(item)));
     test("should be response the article list when call get articles is success", ()async{

       when(mockArticleRepository.getArticles()).thenAnswer((_)async => Right(articles));
       await articleState.getArticlesState();
       final result = articleState.articles;
       isSuccess = articleState.isSuccess;
       isError = articleState.isError;
       isLoading = articleState.isLoading;
       expect(result, equals(articles));
       expect(isSuccess, equals(true));
       expect(isError, equals(false));
       expect(isLoading, equals(false));

     });
     test("should be error is true when call get articles is unsuccessfully", ()async{

       when(mockArticleRepository.getArticles()).thenAnswer((_)async => Left(Failure(message: "message")));
       await articleState.getArticlesState();
       final result = articleState.articles;
       isSuccess = articleState.isSuccess;
       isError = articleState.isError;
       isLoading = articleState.isLoading;
       expect(result, isEmpty);
       expect(isSuccess, equals(false));
       expect(isError, equals(true));
       expect(isLoading, equals(false));

     });
   });
   group("get single articles state", (){
      String articleId= "1";
     final Article article = ArticleModel.fromJson(json.decode(fixture("article.json")));
     test("should success is true and get single article data when call is successfully", ()async{
       when(mockArticleRepository.getSingleArticle(articleId:articleId)).thenAnswer((_)async => Right(article));
       await articleState.getSingleArticleState(articleId:articleId);

       final result = articleState.article;
       isSuccess = articleState.isSuccess;
       isError = articleState.isError;
       isLoading = articleState.isLoading;
       expect(result, equals(article));
       expect(isSuccess, equals(true));
       expect(isError, equals(false));
       expect(isLoading, equals(false));

     });
      test("should error is true when call get single article is unsuccessfully", ()async{

        when(mockArticleRepository.getSingleArticle(articleId:articleId)).thenAnswer((_)async => Left(Failure(message: "message")));
        await articleState.getSingleArticleState(articleId:articleId);

        isSuccess = articleState.isSuccess;
        isError = articleState.isError;
        isLoading = articleState.isLoading;
        expect(isSuccess, equals(false));
        expect(isError, equals(true));
        expect(isLoading, equals(false));

      });
   });
 });
}