part of 'pizza_bloc.dart';

abstract class PizzaState extends Equatable {
  const PizzaState();

  @override
  List<Object> get props => [];
}

class PizzaInitial extends PizzaState {}

class PizzaLoaded extends PizzaState {
  //The state will have access to the list of pizzas
  final List<Pizza> pizzas;

  const PizzaLoaded({required this.pizzas});

  @override
  List<Object> get props => [pizzas]; //For bloc to compare the states
}

class PizzaConfused extends PizzaState {
  final String? eyes;
  final String? ears;
  final String? mouth;

  //const PizzaConfused(this.eyes, this.ears, this.mouth);
  const PizzaConfused({this.eyes, this.ears, this.mouth});
  //  https://stackoverflow.com/questions/64560461/the-parameter-cant-have-a-value-of-null-because-of-its-type-in-dart
}
