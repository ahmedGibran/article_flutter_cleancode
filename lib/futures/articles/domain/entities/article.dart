import 'package:equatable/equatable.dart';

class Article extends Equatable{
  final String title;
  final String description;
  final String imageUrl;

   Article({ required this.title, required this.description, required this.imageUrl, });

  // The list of properties that will be used to determine whether two instances are equal, supported from Equatable
  @override
  List<Object?> get props => [title,description,imageUrl];

}