import 'package:article_app/futures/articles/articles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticlesListScreen extends StatelessWidget {
  const ArticlesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleState>(
      builder: (context, state, child) {
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Home"),
            ),
            body: ListView(
              children: [
                if (state.isLoading)
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                      child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                    ),

                  )),
                if (state.isError)
                  const  Center(
                    child: Text(
                      "Error",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                if (state.isSuccess)
                  BuildBody(
                    state: state,
                  )
              ],
            ));
      },
    );
  }
}
