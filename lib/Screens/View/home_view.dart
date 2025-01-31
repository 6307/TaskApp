import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../ViewModel/todo_viewModel.dart';

class TodoScreen extends StatelessWidget {
  final TodoController controller = Get.put(TodoController());
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        title: const Text("TODO App"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () => controller.clearAllTasks(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(hintText: "Enter Your Task"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  controller.addTask(textController.text);
                  textController.clear();
                }
              },
              child: const Text("Add Task"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.tasks.length,
                  itemBuilder: (context, index) {
                    TextEditingController editController =
                        TextEditingController(
                            text: controller.tasks[index].task);

                    return Card(
                      child: ListTile(
                        title: TextField(
                          controller: editController,
                          decoration: InputDecoration(
                            hintText: 'Edit your task',
                          ),
                          onSubmitted: (value) {
                            if (value.isNotEmpty) {
                              controller.updateTask(index, value);
                            }
                          },
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon:
                                  const Icon(Icons.check, color: Colors.green),
                              onPressed: () {
                                if (editController.text.isNotEmpty) {
                                  controller.updateTask(
                                      index, editController.text);
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => controller.deleteTask(index),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
