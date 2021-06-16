import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamada/shared/components/components.dart';
import 'package:hamada/shared/cubit_home_layout/cubit.dart';
import 'package:hamada/shared/cubit_home_layout/states.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        return ListView.separated(
            itemBuilder: (context, index) => buildTaskItem(tasks[index],context),
            separatorBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
            itemCount: tasks.length);
      },
    );
  }

  Widget buildTaskItem(Map model, context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.0,
            child: Text("${model['data']}"),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${model['title']}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${model['time']}",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),

          IconButton(
              icon: Icon(
                Icons.check_box,
                color: Colors.green,
              ),
              onPressed: () {
                AppCubit.get(context).updateData(status: "done", id: model["id"]);
              }),
          IconButton(icon: Icon(Icons.archive), onPressed: () {

    AppCubit.get(context).updateData(status: "archive", id: model["id"]);

          }),
        ],
      ),
    );
  }
}
