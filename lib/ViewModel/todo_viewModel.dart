import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Data/Model/todo_model.dart';
import 'dart:convert';

class TodoController extends GetxController {
  RxList<TodoModel> tasks = <TodoModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTasksFromStorage();
  }

  void addTask(String task) {
    tasks.add(TodoModel(task: task));
    saveTasksToStorage();
  }

  void updateTask(int index, String newTask) {
    tasks[index].task = newTask;
    saveTasksToStorage();
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
    saveTasksToStorage();
  }

  void clearAllTasks() {
    tasks.clear();
    saveTasksToStorage();
  }

  void loadTasksFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tasksJson = prefs.getString('tasks');

    if (tasksJson != null) {
      List<dynamic> taskList = json.decode(tasksJson);
      tasks.value =
          taskList.map((task) => TodoModel(task: task['task'])).toList();
    }
  }

  void saveTasksToStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tasksJson = json.encode(tasks.map((task) => task.toJson()).toList());
    prefs.setString('tasks', tasksJson);
  }
}
