import 'package:article_app/core/core.dart';
import 'package:article_app/futures/articles/articles.dart';
import 'package:dartz/dartz.dart';

class GetSingleArticle{
  ArticleRepository articleRepository;
  GetSingleArticle({required this.articleRepository});
  Future <Either<Failure,Article>?> getSingleArticle()async{
    return articleRepository.getSingleArticle();
  }
}