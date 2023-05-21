import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
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
        onPressed: () {
          return onPressed();
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
          child: Column(
        children: [
          TodoTile(
            isTaskCompleted: true,
            taskName: "Class assignment",
            onChanged: (p0) => {},
          ),
        ],
      )),
    );
  }

  void onPressed() {
    showDialog(
        context: context,
        builder: (context) {
          return  const TaskBox();
        });
  }
}

class TodoTile extends StatelessWidget {
  final bool isTaskCompleted;
  final String taskName;
  final Function(bool?)? onChanged;

  const TodoTile({
    super.key,
    required this.isTaskCompleted,
    required this.taskName,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
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
            Checkbox(value: isTaskCompleted, onChanged: onChanged),
            'task1'.text.white.center.bold.make(),
          ],
        ),
      ),
    );
  }
}

class TaskBox extends StatelessWidget {
  const TaskBox({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      backgroundColor: Colors.purple,
      content:SizedBox(height: 200  ,width: 350,child: TextField(),),
    );
  }
}
