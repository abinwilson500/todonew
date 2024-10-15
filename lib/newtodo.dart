

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class todonew extends StatefulWidget{
  const todonew({super.key});
  @override
  _todoexamplestate createState()=> _todoexamplestate();
}
class _todoexamplestate extends State<todonew> {
  TextEditingController taskcontroller = TextEditingController();
  List<String>todoItems = [];
  void initState() {
    super.initState();
    loadItems();
  }
  loadItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      todoItems = prefs.getStringList('items') ?? [];
    });
  }
  saveItem(List<String>items) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('items', items);
  }
  void addItems(String task) {
    setState(() {
      todoItems.add(task);
    });
    saveItem(todoItems);
  }
  void removeitem(int index) {
    setState(() {
      todoItems.removeAt(index);
    });
    saveItem(todoItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("to do"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                height: 60,
                width: 250,
                child: TextField(
                  controller:taskcontroller,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'enter the task'),
                ),
                ),
              
              SizedBox(width: 10),
              IconButton(
                onPressed: (){
                  addItems(taskcontroller.text);
                },
                 icon: Icon(Icons.add)),

            ],
          ),
          Expanded(
            child: ListView.builder(
             itemCount: todoItems.length,
              itemBuilder:(context, index) {
                return ListTile(
                  title: Text(todoItems[index]),
                  trailing: GestureDetector(
                    onTap: () {
                      removeitem(index);
                    },
                    child: Icon(Icons.delete)),
                  );
              }))
        ],
      ));
    
  }
  
  }

  