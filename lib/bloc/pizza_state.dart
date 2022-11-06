part of 'pizza_bloc.dart';

abstract class PizzaState extends Equatable {
  const PizzaState();

  @override
  List<Object> get props => [];
}

class PizzaInitialState extends PizzaState {}

class PizzaLoadedState extends PizzaState {
  //The state will have access to the list of pizzas
  final List<Pizza> pizzas;

  const PizzaLoadedState({required this.pizzas});

  @override
  List<Object> get props => [pizzas]; //For bloc to compare the states
}
