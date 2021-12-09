
import 'package:article_app/core/core.dart';
import 'package:article_app/futures/articles/domain/domain.dart';
import 'package:dartz/dartz.dart';

abstract class ArticleRepository{

Future<Either<Failure, List<Article>>>? getArticles();
Future<Either<Failure, Article>>? getSingleArticle();

}