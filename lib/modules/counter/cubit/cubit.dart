

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamada/modules/counter/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates>{
  CounterCubit() : super(CounterInitialState());

  static CounterCubit get(ctx)=>BlocProvider.of(ctx);

  int counter=1;
  void minus(){
    counter--;
    emit(CounterMinusState());


  }
  void plus(){
    counter++;
    emit( CounterPlusState());

  }

}