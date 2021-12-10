import 'dart:convert';
import 'package:article_app/futures/articles/articles.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fixture/fixture_reader.dart';

void main(){

  // make instance from article model and set the default params,
  // then add to list of article model type

  final ArticleModel article = ArticleModel(title: "New Version of Tesla Cybertruck Spotted by Drone on Test Track [VIDEO]",
      description: "The new Cybertruck was seen at the company’s Fremont test track in California.\nContinue reading New Version of Tesla Cybertruck Spotted by Drone on Test Track [VIDEO] at iPhone in Canada Blog.",
      imageUrl: "https://cdn.iphoneincanada.ca/wp-content/uploads/2021/12/new-cybertruck.jpeg");
    List<ArticleModel> articles= <ArticleModel>[
      article
    ];

  test("fromJson", ()async{

    // get data from local json file
    final Map<String,dynamic>
    mapData = json.decode(fixture("article.json"));
    List<ArticleModel>  resultList =<ArticleModel>[];

    // list of items date convert to the resultList, it should only put the first item inside it
    resultList.add(ArticleModel.fromJson(mapData['articles'][0]));

    // here we can check so if it is confirmed or not
    expect(resultList, articles);

  });

  test("toJson", ()async{

    final result = article.toJson();

    // mapping data
    Map<String,dynamic> mapOfData =
      {
      "title": "New Version of Tesla Cybertruck Spotted by Drone on Test Track [VIDEO]",
      "description": "The new Cybertruck was seen at the company’s Fremont test track in California.\nContinue reading New Version of Tesla Cybertruck Spotted by Drone on Test Track [VIDEO] at iPhone in Canada Blog.",
      "urlToImage": "https://cdn.iphoneincanada.ca/wp-content/uploads/2021/12/new-cybertruck.jpeg",
       };
    // here we can check so if it is confirmed or not
    expect(result, mapOfData);

  });


}