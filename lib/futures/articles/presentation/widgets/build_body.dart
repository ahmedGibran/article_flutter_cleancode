import 'package:flutter/material.dart';
import '../../articles.dart';
class BuildBody extends StatelessWidget {
 final ArticleState state;
  const BuildBody({required this.state,Key? key}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: BuildListOfArticles(state: state),
    );
  }
}
