import 'package:article_app/futures/articles/articles.dart';
import 'package:flutter/material.dart';
import 'package:article_app/core/core.dart';
import 'package:provider/provider.dart';
import 'core/utils/injection_container.dart';
void main() {
  init();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
    ChangeNotifierProvider(
    create: (context) => sl<ArticleState>(),),
    ],
    child: MaterialApp(
      title: 'Article Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ArticlesListScreen(),
    ),
    );
  }
}
