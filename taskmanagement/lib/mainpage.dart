import 'package:flutter/material.dart';
import 'package:taskmanagement/Function.dart';

class AddTasks extends StatefulWidget {
  @override
  AddTasksState createState() => AddTasksState();
}

class AddTasksState extends State<AddTasks> {
  List<String> tasklist = [];
  List<String> taskCompleted = [];
  TextEditingController taskController = TextEditingController();
  TextEditingController editController = TextEditingController();
  bool isEditing = false;
  int editIndex = -1;

  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  @override
  void dispose() {
    taskController.dispose();
    editController.dispose();
    super.dispose();
  }

  Future<void> _loadTask() async {
    List<String> loadedDepartments = await Deptclass.loadTask();
    List<String> loadedcompleted = await Deptclass.completedTask();
    setState(() {
      tasklist = loadedDepartments;
      taskCompleted = loadedcompleted;
      //taskCompleted = List<bool>.filled(tasklist.length, false);
    });
  }

  Future<void> addTask() async {
    String task =
        isEditing ? editController.text.trim() : taskController.text.trim();
    if (task.isNotEmpty) {
      setState(() {
        if (isEditing) {
          tasklist[editIndex] = task;
          isEditing = false;
          editIndex = -1;
          editController.clear();
        } else {
          tasklist.add(task);
          taskController.clear();
          taskCompleted.add("false");
        }
      });
      await Deptclass.saveTask(tasklist, taskCompleted);
    }
  }

  Future<void> deleteTask(int index) async {
    setState(() {
      tasklist.removeAt(index);
      taskCompleted.removeAt(index);
    });
    await Deptclass.saveTask(tasklist, taskCompleted);
  }

  void startEdit(int index) {
    setState(() {
      editIndex = index;
      editController.text = tasklist[index];
      isEditing = true;
      taskController.clear();
    });
  }

  void cancelEdit() {
    setState(() {
      isEditing = false;
      editIndex = -1;
      editController.clear();
      taskController.clear();
    });
  }

  void completeTask(int index) {
    setState(() {
      taskCompleted[index] = "true";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 10, 10, 10),
          title: Center(
            child: const Text(
              "TO DO APPLICATION",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 248, 249, 250)),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isEditing ? "Edit " : "Add Task",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: isEditing ? editController : taskController,
                        decoration: InputDecoration(
                          labelText: isEditing ? 'Edit Task' : 'Enter Task',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 13, 13, 13)),
                            onPressed: addTask,
                            child: Text(
                              isEditing ? 'Save Changes' : 'Add',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 252, 250, 250)),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 12, 12, 12)),
                            onPressed: isEditing
                                ? cancelEdit
                                : () => taskController.clear(),
                            child: Text(
                              isEditing ? 'Cancel' : 'Clear',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 249, 249, 249)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Progress:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: tasklist.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: taskCompleted[index] == "true"
                                  ? Color.fromARGB(255, 3, 111, 14)
                                  : const Color.fromARGB(255, 141, 143, 145),

                              //  Color.fromARGB(255, 196, 197, 196),
                            ),
                            child: taskCompleted[index] == "true"
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(tasklist[index],
                                          style: TextStyle(
                                              color: Color.fromARGB(255, 249, 247, 247))),
                                      Row(
                                        children: [
                                          // IconButton(
                                          //   icon: Icon(
                                          //     Icons.edit,
                                          //     color: Color.fromARGB(255, 31, 28, 243),
                                          //   ),
                                          //   onPressed: () => startEdit(index),
                                          // ),
                                          Text("Completed",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255))),
                                          IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Color.fromARGB(
                                                  255, 245, 28, 46),
                                            ),
                                            onPressed: () => deleteTask(index),
                                          ),

                                          // ElevatedButton(
                                          //   style: ElevatedButton.styleFrom(
                                          //     backgroundColor: taskCompleted[index]=="true"
                                          //         ? Colors
                                          //             .red
                                          //         : Colors
                                          //             .blue,
                                          //   ),
                                          //   onPressed: () => completeTask(index),
                                          //   child: Text(
                                          //     // taskCompleted[index]
                                          //     //     ? 'Undo'
                                          //         // :
                                          //         'Complete',
                                          //     //style: TextStyle(color: Colors.white),
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(tasklist[index],
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 14, 13, 13))),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: Color.fromARGB(
                                                  255, 31, 28, 243),
                                            ),
                                            onPressed: () => startEdit(index),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Color.fromARGB(
                                                  255, 245, 28, 46),
                                            ),
                                            onPressed: () => deleteTask(index),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  taskCompleted[index] == "true"
                                                      ? Colors.red
                                                      : Colors.blue,
                                            ),
                                            onPressed: () =>
                                                completeTask(index),
                                            child: Text(
                                              // taskCompleted[index]
                                              //     ? 'Undo'
                                              // :
                                              'Complete',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
