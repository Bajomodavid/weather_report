import 'package:equatable/equatable.dart';

abstract class WeatherblocState extends Equatable {
  const WeatherblocState();
}

class InitialWeatherblocState extends WeatherblocState {
  @override
  List<Object> get props => [];
}
