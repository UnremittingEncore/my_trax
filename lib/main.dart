import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_trax/Todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: myTrax(),
    );
  }
}

class myTrax extends StatefulWidget {
  @override
  _myTraxState createState() => _myTraxState();
}

class _myTraxState extends State<myTrax> {

  TextEditingController taskController = new TextEditingController();

  List<Todo> myTodos = [
    Todo('Hello', 0),
    Todo('Test', 1)
  ];
  Todo newTodo = new Todo('',0);
  Todo newTodoTemp;
  bool isButtonPressed = false;

  String Priority(Todo inputTodo) {
    switch(inputTodo.priority){
      case 0:{
        return 'low';
      }
      break;
      case 1:{
        return 'medium';
      }
      break;
      default: {
        return 'high';
      }
      break;
    }
  }

  Color customColor(int priority) {
    switch (priority) {
      case 0:{
        return Colors.green;
      }
      break;
      case 1:{
        return Colors.amberAccent;
      }
      break;
      default: {
        return Colors.pink;
      }
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('My Trax',
              style: TextStyle(
                color: Colors.blueAccent,
            ),
            ),
            centerTitle: true,
            backgroundColor: Colors.black87,
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      //hintText: 'Enter new task',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyanAccent),
                      ),
                      labelText: 'New Task',
                     // contentPadding: EdgeInsets.only(left: 20, top: 10, right: 20),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.transparent,
                      textColor: Colors.black87,
                      highlightColor: Colors.green,
                      splashColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.black87),
                      ),
                      child: Text('Low'),
                      onPressed: () {
                        setState(() {
                          newTodo.priority = 0;
                        });
                      },
                    ),
                    RaisedButton(
                      color: Colors.transparent,
                      textColor: Colors.black87,
                      highlightColor: Colors.amberAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.black87),
                      ),
                      child: Text('Medium'),
                      onPressed: () {
                        setState(() {
                          newTodo.priority = 1;
                        });
                      },
                    ),
                    RaisedButton(
                      color: Colors.transparent,
                      textColor: Colors.black87,
                      highlightColor: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.black87),
                      ),
                      child: Text('High'),

                      onPressed: () {
                        setState(() {
                          newTodo.priority = 2;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 5.0,),
                Expanded(
                  child: ListView.builder(
                    itemCount: myTodos.length,
                    itemBuilder: (context, index){
                      return Card(
                        child: ListTile(
                          onTap: () {
                            print('Task: ' + myTodos[index].task + ', Priority: ' + Priority(myTodos[index]));
                          },
                          title: Text(myTodos[index].task),
                          subtitle: Text('Priority:' + Priority(myTodos[index])),
                          trailing: SizedBox(
                            width: 35.0,
                            child: RaisedButton(
                              color: Colors.transparent,
                              textColor: Colors.black87,
                              highlightColor: Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(color: Colors.black87),
                              ),
                              child: Icon(
                                Icons.close,
                              ),
                              padding: EdgeInsets.all(2),
                              onPressed: () {
                                setState(() {
                                  myTodos.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.black87),
                        ),
                        color: customColor(myTodos[index].priority),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.blueAccent,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              newTodo.task = taskController.text;
              newTodoTemp = newTodo;
              if(newTodo.task != '') {
                setState(() {
                  myTodos.insert(0,newTodoTemp);
                  newTodo = new Todo('',0);
                });
              }
              print(myTodos[1].task);
            },
            child: Icon(
              Icons.add,
              color: Colors.blueAccent,
            ),
            backgroundColor: Colors.black87,
          ),
        ),
    );
  }
}

