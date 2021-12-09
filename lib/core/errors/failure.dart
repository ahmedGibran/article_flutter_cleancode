import 'package:equatable/equatable.dart';


// To handle message error for fetch data errors with dartZ
class Failure extends Equatable{

  final String message;
  Failure({required this.message});

  // The list of properties that will be used to determine whether two instances are equal, supported from Equatable
  @override
  List<Object?> get props => [message];

}