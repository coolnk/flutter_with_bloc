import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_with_bloc/bloc/pizza_bloc.dart';

import 'models/pizza_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    //so the build wants something to return like what
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PizzaBloc()..add(LoadPizzaCounterEvent()),
        )
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'The pizza bloc',
          home: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // title: Text(widget.title),
          title: const Text("The Pizza bloc title"),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: Center(child: BlocBuilder<PizzaBloc, PizzaState>(
          builder: (context, state) {
            if (state is PizzaInitialState) {
              return const CircularProgressIndicator(
                color: Colors.orange,
              );
            }
            if (state is PizzaLoadedState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${state.pizzas.length}',
                      style: const TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        for (int index = 0;
                            index < state.pizzas.length;
                            index++)
                          Positioned(
                            left: Random().nextInt(250).toDouble(),
                            top: Random().nextInt(400).toDouble(),
                            child: SizedBox(
                                height: 150,
                                width: 150,
                                child: state.pizzas[index].image),
                          )
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const Text('Something went wrong');
            }
          },
        )),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
                child: const Icon(Icons
                    .local_pizza_outlined), //where is this icon comming from
                onPressed: () {
                  context.read<PizzaBloc>().add(AddPizza(Pizza.pizzas[0]));
                }),
            FloatingActionButton(
                child:
                    const Icon(Icons.remove), //where is this icon comming from
                onPressed: () {
                  context.read<PizzaBloc>().add(RemovePizza(Pizza.pizzas[0]));
                }),
            const SizedBox(height: 10),
            FloatingActionButton(
                child: const Icon(
                    Icons.local_pizza), //where is this icon comming from
                onPressed: () {
                  context.read<PizzaBloc>().add(AddPizza(Pizza.pizzas[1]));
                }),
            FloatingActionButton(
                child:
                    const Icon(Icons.remove), //where is this icon comming from
                onPressed: () {
                  context.read<PizzaBloc>().add(RemovePizza(Pizza.pizzas[1]));
                }),
          ],
        ));
  }
}
