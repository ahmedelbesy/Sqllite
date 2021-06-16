import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamada/modules/home/home_screen.dart';
import 'package:hamada/modules/notification/notifications_screen.dart';
import 'package:hamada/modules/profile/profile_screen.dart';
import 'package:hamada/shared/components/components.dart';
import 'package:hamada/shared/cubit_home_layout/states.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(ctx) => BlocProvider.of(ctx);
  Database database;
  int currentIndex = 0;
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  List<Widget> screens = [
    HomeScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];
  List<String> titles = [
    'Data',
    'Notification',
    'Profile',
  ];
  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void createDatabase() {
    openDatabase(
      'hamada.db',
      version: 1,
      onCreate: (database, version) {
        print("database created");
        database
            .execute(
                'CREATE TABLE hamadaa (id INTEGER PRIMARY KEY, title TEXT, data TEXT, time TEXT,status TEXT)')
            .then((value) {
          print("table created");
        }).catchError((error) {
          print("Error when Creating Table ${error.toString()}");
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database).then((value) {
          tasks = value;
          print(tasks);
          emit(AppGetDataFromDatabaseState());
        });
        print("open database");
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    @required String title,
    @required String time,
    @required String date,
  }) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO hamadaa(title,data,time,status) VALUES("$title", "$time", "$date", "new")')
          .then((value) {
        print("$value inserted database successfully");
        emit(AppInsertToDatabaseState());

        getDataFromDatabase(database).then((value) {
          tasks = value;
          print(tasks);
          emit(AppGetDataFromDatabaseState());
        });
      }).catchError((error) {
        print('Error when Inserted New Record');
      });
      return null;
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    emit(AppGetDataFromDatabaseLoadingState());
    return await database.rawQuery('SELECT * FROM hamadaa');
  }

  void updateData({@required String status,@required int id }) async {
    database.rawUpdate(
        'UPDATE hamadaa SET status = ?, value = ? WHERE id = ?',
        ['$status', id]).then((value) {
          emit(AppUpdateDataFromDatabaseState());
    });
  }

  void changeBottomSheetState({
    @required bool isShow,
    @required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }
}
