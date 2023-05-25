import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:velocity_x/velocity_x.dart';

import '../data/database.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _controller = TextEditingController();

  final _table = Hive.box("TasksTable");
  DataBs db = DataBs();

  @override
  void initState(){
    // TODO: implement initState
    if (_table.get("TODOLIST") == null) {
      db.createData();
    } else {
      db.getData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: Colors.white,
          title: 'Tasks'.text.white.xl3.bold.make().centered(),
          elevation: 0,
          flexibleSpace: Container(
            alignment: const Alignment(10, 50),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Colors.purple, Colors.blue]),
            ),
          ),
          systemOverlayStyle: SystemUiOverlayStyle.light),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Vx.blue500,
        // foregroundColor: Vx.white,

        onPressed: () {
          return onPressed();
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return TodoTile(
                isTaskCompleted: db.toDoList[index][1],
                taskName: db.toDoList[index][0],
                onChanged: (value) => changeCheck(value, index),
                delete: (context) => deleteTask(index));
          }),
    );
  }

  void onPressed() {
    showDialog(
        context: context,
        builder: (context) {
          return TaskBox(
            controller: _controller,
            onSave: saveToTaskList,
          );
        });
  }

  changeCheck(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  void saveToTaskList() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }
}

class TodoTile extends StatelessWidget {
  final bool isTaskCompleted;
  final String taskName;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? delete;

  const TodoTile({
    super.key,
    required this.isTaskCompleted,
    required this.taskName,
    required this.onChanged,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: delete,
            backgroundColor: Vx.red400,
            icon: Icons.delete_outline_rounded,
            borderRadius: BorderRadius.circular(10),
          )
        ]),
        child: Container(
          height: 80,
          width: 390,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[Colors.purple, Colors.blue]),
          ),
          child: Row(
            children: [
              Checkbox(
                  value: isTaskCompleted,
                  onChanged: onChanged,
                  checkColor: Vx.black),
              isTaskCompleted
                  ? taskName.text.lineThrough.yellow500.xl2.make().centered()
                  : taskName.text.white.xl2.make().centered(),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TaskBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  VoidCallback onSave;
  TaskBox({super.key, required this.controller, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.purple,
      content: SizedBox(
        height: 132,
        width: 320,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
                maxLength: 20,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                controller: controller,
                style: const TextStyle(color: Vx.white),
                decoration:
                    const InputDecoration(border: OutlineInputBorder())),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => context.pop(),
                  style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(
                          EdgeInsetsDirectional.fromSTEB(40, 3, 40, 3))),
                  child: 'Cancel'.text.make(),
                ),
                ElevatedButton(
                  onPressed: onSave,
                  style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(
                          EdgeInsetsDirectional.fromSTEB(40, 3, 40, 3))),
                  child: 'Save'.text.make(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
