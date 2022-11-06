import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/pizza_model.dart';

part 'pizza_event.dart';
part 'pizza_state.dart';

class PizzaBloc extends Bloc<PizzaEvent, PizzaState> {
  PizzaBloc() : super(PizzaInitial()) {
    //First event
    on<LoadPizzaCounter>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const PizzaLoaded(
          pizzas: <Pizza>[])); //Sending empty list to some God state
    });
    //Second event
    on<AddPizza>((event, emit) {
      if (state is PizzaLoaded) {
        final state = this.state
            as PizzaLoaded; // casting the god state to mortal the PizzaLoadedStete
        emit(PizzaLoaded(
          pizzas: List.from(state.pizzas)..add(event.pizza),
        ));
      }
    });
    //Third event
    on<RemovePizza>((event, emit) {
      if (state is PizzaLoaded) {
        final state = this.state as PizzaLoaded;
        emit(PizzaLoaded(pizzas: List.from(state.pizzas)..remove(event.pizza)));
      }
    });
  }
}
