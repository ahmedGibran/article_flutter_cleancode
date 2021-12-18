import 'package:article_app/futures/articles/domain/domain.dart';

class ArticleModel extends Article{
  ArticleModel({ required String title, required  String description, required String imageUrl, })
      : super (title: title,imageUrl: imageUrl,description: description);

  factory ArticleModel.fromJson(Map<String,dynamic> jsonData){
    return ArticleModel(title: jsonData['title'],
        imageUrl: jsonData['urlToImage'].toString(),
      description: jsonData['description']

    );
  }

  Map<String,dynamic> toJson(){
    return {
      "title":title,
      "description":description,
      "urlToImage":imageUrl,
    };
  }
}