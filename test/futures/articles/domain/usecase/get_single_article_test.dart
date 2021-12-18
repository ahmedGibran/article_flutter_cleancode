import 'package:article_app/futures/articles/articles.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
class MockArticleRepository extends Mock implements ArticleRepository{}
void main(){

  late GetSingleArticle usecase;
  late MockArticleRepository mockArticleRepository;
  setUp((){
    // define instance
    mockArticleRepository= MockArticleRepository();
    // set the mockArticleRepository value to  constructor to make mock repository for test
    usecase = GetSingleArticle(articleRepository:mockArticleRepository,);
  });

  final Article article = Article(title: "title", description: "description", imageUrl: "imageUrl");

  test("should test the get single article fetch data", ()async{
    //set constant return value to the mock get single article when we fetch data that is for make expect matcher
    when(mockArticleRepository.getSingleArticle(articleId: "1")).thenAnswer((_) async=> Right(article));

    // The result it is the actual value that is most always equal matcher
    final result = await usecase.getSingleArticle(articleId: "1");
    expect(result, Right(article));

  });

}