
import 'package:article_app/futures/articles/articles.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockArticleRepository extends Mock implements ArticleRepository{}

void main(){
   late GetArticles usecase;
  late MockArticleRepository mockArticleRepository;
  // this function it will be start before test functions work
  setUpAll(() {
    //
     // define instances
    //
    mockArticleRepository = MockArticleRepository();
    // set mock getArticles value to the usecase instance of GetArticles
    usecase = GetArticles(repository: mockArticleRepository);
  });
 List<Article> article = [];
 article.add(Article(title: "title", description: "description", imageUrl: "imageUrl"));
 test('should be check the get articles fetch data', ()async{
  when(mockArticleRepository.getArticles()).thenAnswer((_) async => Right(article));
  final result = await usecase.getArticles();
  expect(result,Right(article) );
  verify(mockArticleRepository.getArticles());
  verifyNoMoreInteractions(mockArticleRepository);
});//end of getArticles test
}