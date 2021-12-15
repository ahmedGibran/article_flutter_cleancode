import 'package:article_app/core/core.dart';
import 'package:article_app/futures/articles/articles.dart';
import 'package:article_app/futures/articles/infrastructure/infrastructure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNetworkInfo extends Mock implements NetworkInfo{}
class MockGetArticleRemoteData extends Mock implements GetArticleRemoteData{}
class MockGetArticleRLocalData extends Mock implements GetArticleLocalData{}

void main(){
  late ArticleRepositoryImpl repositoryImpl;
  late MockNetworkInfo mockNetworkInfo;
  late MockGetArticleRemoteData mockGetArticleRemoteData;
  late MockGetArticleRLocalData mockGetArticleLocalData;

  setUp((){
    // make instance
    mockNetworkInfo = MockNetworkInfo();
    mockGetArticleRemoteData = MockGetArticleRemoteData();
    mockGetArticleLocalData = MockGetArticleRLocalData();
    repositoryImpl= ArticleRepositoryImpl(networkInfo:mockNetworkInfo,
      getArticleRemoteData:mockGetArticleRemoteData,
        getArticleLocalData:mockGetArticleLocalData
    );
  });


  group("get articles or single article",(){

    test("Should to check the device is online or not", ()async{
      when(mockNetworkInfo.isConnected).thenAnswer((_) async=> true);
      await repositoryImpl.getArticles();
      verify(mockNetworkInfo.isConnected);
    });
  });

  group("device is online", (){
    List<Article> articles = [];
    // articles.add(Article(title: "title", description: "description", imageUrl: "imageUrl"));

    setUp((){
      when(mockNetworkInfo.isConnected).thenAnswer((_) async=> true);
    });
    test("should remote data work successfully", ()async{
      when( mockGetArticleRemoteData.getArticles()).thenAnswer((_) async=> articles);

      final result = await repositoryImpl.getArticles();
      verify(mockGetArticleRemoteData.getArticles());
      expect(result, equals(Right(articles)));

    });

    test("should call cache data when remote data is received", ()async{
      when( mockGetArticleRemoteData.getArticles()).thenAnswer((_) async=> articles);

      await repositoryImpl.getArticles();

      verify(mockGetArticleRemoteData.getArticles());
      verify(mockGetArticleLocalData.cacheArticles(articles: articles));

    });


  });

  group("device is offline", (){
    List<Article> articles = [];
    // articles.add(Article(title: "title", description: "description", imageUrl: "imageUrl"));

    setUp((){
      when(mockNetworkInfo.isConnected).thenAnswer((_) async=> false);
    });
    test("should call cache data when data is present", ()async{
      when( mockGetArticleLocalData.getArticles()).thenAnswer((_) async=> articles);

      final result = await repositoryImpl.getArticles();
      verify(mockGetArticleLocalData.getArticles());
      expect(result, equals(Right(articles)));

    });

    test("should call cache failure  when data is un present", ()async{
      // when( mockGetArticleLocalData.getArticles()).thenThrow(CacheFailure(message: "message"));
      when(mockGetArticleLocalData.getArticles()).thenThrow( CacheFailure(message: "message"));

       await repositoryImpl.getArticles();
      // // verify(mockGetArticleLocalData.getArticles());
      // await expectLater(result, equals(Left(CacheFailure(message: "message"))));

    });



  });

}


