import 'package:article_app/futures/articles/articles.dart';
import 'package:flutter/material.dart';
class BuildListOfArticles extends StatelessWidget {
  final ArticleState state;
  const BuildListOfArticles({Key? key,required this.state}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListView.builder(

        itemCount: state.articles!.length,
        shrinkWrap: true,

        itemBuilder: (_, index){
              return Container(
                // height: 280,
                padding: const EdgeInsets.all(4.0),
                margin:const EdgeInsets.all(4.0) ,
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius:const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                     Image.network(state.articles![index].imageUrl,fit: BoxFit.cover,),
                    const SizedBox(height: 10,),
                    Text("${state.articles?[index].title}",style: TextStyle(fontSize: 12),)
                  ],
                ),
              );
        });
  }
}
