import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamada/modules/counter/cubit/cubit.dart';
import 'package:hamada/modules/counter/cubit/states.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (ctx, state) {},
        builder: (ctx, state) => Scaffold(
          body: Center(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(ctx).minus();
                      },
                      child: Text(
                        "MINUS",
                        style: TextStyle(fontSize: 20),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Text("${CounterCubit.get(ctx).counter}",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(ctx).plus();
                      },
                      child: Text("PLUS", style: TextStyle(fontSize: 20))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
