import 'dart:async';
import 'package:bloc/bloc.dart';
import 'bloc.dart';

class WeatherblocBloc extends Bloc<WeatherblocEvent, WeatherblocState> {
  @override
  WeatherblocState get initialState => InitialWeatherblocState();

  @override
  Stream<WeatherblocState> mapEventToState(
    WeatherblocEvent event,
  ) async* {}
}
