import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hamada/shared/cubit_home_layout/cubit.dart';
import 'package:hamada/shared/cubit_home_layout/states.dart';
import 'package:intl/intl.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var Titlecontroller = TextEditingController();
  var Timecontroller = TextEditingController();
  var datacontroller = TextEditingController();

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext ctx) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates states) {
          if (states is AppInsertToDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates states) {
          return Scaffold(
            key: scaffoldKey,
            floatingActionButton: FloatingActionButton(
              child: Icon(AppCubit.get(context).fabIcon),
              onPressed: () {
                if (AppCubit.get(context).isBottomSheetShown) {
                  if (formKey.currentState.validate()) {
                    AppCubit.get(context).insertToDatabase(
                        title: Titlecontroller.text,
                        time: Timecontroller.text,
                        date: datacontroller.text);
                  }
                } else {
                  scaffoldKey.currentState
                      .showBottomSheet(
                        (context) => Container(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, top: 10),
                          width: double.infinity,
                          color: Colors.grey[100],
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: Titlecontroller,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "Task must not empty";
                                    }
                                    return null;
                                  },
                                  onTap: () => print("task Tapped"),
                                  decoration: InputDecoration(
                                    labelText: "Task Title",
                                    prefixIcon: Icon(Icons.title),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(width: 2)),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.datetime,
                                  controller: Timecontroller,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "Time must not empty";
                                    }
                                    return null;
                                  },
                                  onTap: () => showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now())
                                      .then((value) {
                                    Timecontroller.text =
                                        value.format(context).toString();
                                    print(value.format(context));
                                  }),
                                  decoration: InputDecoration(
                                    labelText: "Task Time",
                                    prefixIcon: Icon(Icons.access_alarms),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(width: 2)),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  // keyboardType: TextInputType.datetime,
                                  controller: datacontroller,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "Data must not empty";
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2021-05-20'),
                                    ).then((value) {
                                      datacontroller.text =
                                          DateFormat.yMMMd().format(value);
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Task Data",
                                    prefixIcon: Icon(Icons.calendar_today),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(width: 2)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .closed
                      .then((value) {
                    AppCubit.get(context).changeBottomSheetState(
                        isShow: false, icon: Icons.edit);
                  });
                  AppCubit.get(context)
                      .changeBottomSheetState(isShow: true, icon: Icons.add);
                }
              },
            ),
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                AppCubit.get(context)
                    .titles[AppCubit.get(context).currentIndex],
                style: TextStyle(fontSize: 25),
              ),
            ),
            body:states is AppGetDataFromDatabaseLoadingState? Center(child: CircularProgressIndicator()): AppCubit.get(context)
                .screens[AppCubit.get(context).currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: AppCubit.get(context).currentIndex,
              onTap: (index) {
                AppCubit.get(context).changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_sharp),
                  label: "Notifications",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profile",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
