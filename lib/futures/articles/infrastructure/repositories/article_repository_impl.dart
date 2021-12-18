import 'package:article_app/core/core.dart';
import 'package:article_app/core/errors/failure.dart';
import 'package:article_app/futures/articles/articles.dart';
import 'package:dartz/dartz.dart';

class ArticleRepositoryImpl extends ArticleRepository{
 final NetworkInfo networkInfo;
 final GetArticleRemoteData getArticleRemoteData;
 final  GetArticleLocalData getArticleLocalData;

 ArticleRepositoryImpl({
   required this.networkInfo,required this.getArticleRemoteData, required this.getArticleLocalData});


  @override
  Future<Either<Failure, List<Article>>> getArticles() async{
    bool  isConnected = await networkInfo.isConnected;
    if(isConnected){
      try{
        List<Article>? list = await getArticleRemoteData.getArticles();
        await getArticleLocalData.cacheArticles(articles: []);
        return Right(list!);
      }on ServerException{
        return left(ServerFailure(message: "message"));
      }
    }else{
      try{
      List<Article>? list = await getArticleLocalData.getArticles();
      return Right(list!);
      }on CacheException{
        return Left(CacheFailure(message: "message"));
      }
    }

  }

  @override
  Future<Either<Failure, Article>>? getSingleArticle({required String articleId}) {
    // TODO: implement getSingleArticle
    throw UnimplementedError();
  }

}