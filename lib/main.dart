
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:my_trax/Todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: myTaskz(),
    );
  }
}

class myTaskz extends StatefulWidget {
  @override
  _myTaskzState createState() => _myTaskzState();
}

class _myTaskzState extends State<myTaskz> {

  TextEditingController taskController = new TextEditingController();
  // Variables
  List<Todo> myTodos = [
    Todo('Watch Avengers Endgame', 0),
    Todo('Hit the gym', 2),
    Todo('Wash Hands for 20 seconds', 1),
    Todo('Complete Maths Homework', 0),
    Todo('Buy Groceries', 1),
    Todo('Complete assignments', 2),
    Todo('Take out trash', 0),
  ];
  Todo newTodo = new Todo('',0);
  Todo newTodoTemp;
  bool isLowBtn = true; //if low button is pressed
  bool isMediumBtn = false; // if medium button is pressed
  bool isHighBtn = false; // if high button is pressed
  bool noTextError = false; // shows error when no text has been entered
  //
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
        return Colors.red;
      }
      break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(

          appBar: AppBar(
            title: Stack(
              children: <Widget>[
                Text('myTaskz',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            centerTitle: true,
            backgroundColor: Colors.blue,

          ),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      hintText: 'Enter new task',
                      labelText: 'New Task',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder( // gives basic outline border
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder( // gives outline border when clicked or focused
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      errorText: noTextError ? 'Please enter new task' : null,
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      color: isLowBtn ? Colors.green : Colors.transparent,
                      textColor: Colors.black87,
                      highlightColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.black87),
                      ),
                      child: Text('Low'),
                      onPressed: () {
                        setState(() {
                          isLowBtn = true;
                          isMediumBtn = false;
                          isHighBtn = false;
                          newTodo.priority = 0;
                        });
                      },
                    ),
                    RaisedButton(
                      color: isMediumBtn ? Colors.amberAccent : Colors.transparent,
                      textColor: Colors.black87,
                      highlightColor: Colors.amberAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.black87),
                      ),
                      child: Text('Medium'),
                      onPressed: () {
                        setState(() {
                          isMediumBtn = true;
                          isLowBtn = false;
                          isHighBtn = false;
                          newTodo.priority = 1;
                        });
                      },
                    ),
                    RaisedButton(
                      color: isHighBtn ? Colors.red : Colors.transparent,
                      textColor: Colors.black87,
                      highlightColor: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.black87),
                      ),
                      child: Text('High'),

                      onPressed: () {
                        setState(() {
                          isHighBtn = true;
                          isLowBtn = false;
                          isMediumBtn = false;
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
                      return Dismissible(
                        key: Key(myTodos[index].task),
                        onDismissed: (direction){
                          setState(() {
                            myTodos.removeAt(index);
                          });
                        },
                        child: Card(
                          child: ListTile(
                            onTap: () {
                              print('Task: ' + myTodos[index].task + ', Priority: ' + Priority(myTodos[index])); //Prints info about current list tile
                            },
                            title: Text(myTodos[index].task),
                            subtitle: Text('Priority:' + Priority(myTodos[index])),
                            trailing: SizedBox(
                              width: 35.0,
                              child: FlatButton(
                                color: Colors.transparent,
                                textColor: Colors.black87,
                                highlightColor: Colors.teal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(color: Colors.black87),
                                ),
                                child: Icon(
                                  Icons.clear,
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
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.lightBlueAccent,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                noTextError = false;
                FocusScope.of(context).unfocus();//to disable keyboard after clicking add button
              });
              newTodo.task = taskController.text;
              newTodoTemp = newTodo;
              if(newTodo.task != '') {
                setState(() {
                  isLowBtn = true;
                  isMediumBtn = false;
                  isHighBtn = false;
                  myTodos.insert(0,newTodoTemp);
                  newTodo = Todo('',0);
                });
              }
              else {
                setState(() {
                  noTextError = true;
                });
              }
              taskController.clear();
            },
            child: Icon(
              Icons.playlist_add,
              color: Colors.cyan,
            ),
            backgroundColor: Colors.black87,
          ),
        ),
    );
  }
}

