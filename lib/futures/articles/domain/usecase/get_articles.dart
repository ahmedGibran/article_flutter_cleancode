import 'package:article_app/core/core.dart';
import 'package:article_app/futures/articles/domain/domain.dart';
import 'package:dartz/dartz.dart';

class GetArticles{
 final  ArticleRepository repository;
  GetArticles({required this.repository});

  Future<Either<Failure, List<Article>>?> getArticles()async{
    return repository.getArticles();
  }

}