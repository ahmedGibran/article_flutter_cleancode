import 'package:article_app/core/plarform/newtwork_info.dart';
import 'package:article_app/futures/articles/articles.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;
void init(){

  /// Future - article
   sl.registerFactory(() => ArticleState(
  getArticles:  sl(),
  getSingleArticles: sl()));

  //use cases
   sl.registerLazySingleton(() => GetArticles(repository:  sl()));
   sl.registerLazySingleton(() => GetSingleArticle(articleRepository:  sl()));

  // repositories
   sl.registerLazySingleton<ArticleRepository>(() => ArticleRepositoryImpl(
      networkInfo:  sl(),
      getArticleRemoteData:  sl(),
      getArticleLocalData:  sl()));

  //data source
   sl.registerLazySingleton<GetArticleRemoteData>(() => GetArticleRemoteDataImpl(httpClient:  sl()));
   sl.registerLazySingleton<GetArticleLocalData>(() => GetArticleLocalDataImpl(localStorage:  sl()));

  ///Core
   sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl( sl()));


  /// External
   sl.registerLazySingleton(()=>LocalStorage("article_app"));
   sl.registerLazySingleton(() => http.Client());
   sl.registerFactory(() => InternetConnectionChecker());





}