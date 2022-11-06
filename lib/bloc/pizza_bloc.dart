import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/pizza_model.dart';

part 'pizza_event.dart';
part 'pizza_state.dart';

class PizzaBloc extends Bloc<PizzaEvent, PizzaState> {
  PizzaBloc() : super(PizzaInitial()) {
    //First event
    on<LoadPizzaCounterEvent>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const PizzaLoadedState(
          pizzas: <Pizza>[])); //Sending empty list to some God state
    });
    //Second event
    on<AddPizza>((event, emit) {
      if (state is PizzaLoadedState) {
        final state = this.state
            as PizzaLoadedState; // casting the god state to mortal the PizzaLoadedStete
        emit(PizzaLoadedState(
          pizzas: List.from(state.pizzas)..add(event.pizza),
        ));
      }
    });
    //Third event
    on<RemovePizza>((event, emit) {
      if (state is PizzaLoadedState) {
        final state = this.state as PizzaLoadedState;
        emit(PizzaLoadedState(
            pizzas: List.from(state.pizzas)..remove(event.pizza)));
      }
    });
  }
}
