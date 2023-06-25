// ignore: file_names
import 'package:flutter/material.dart';
import 'style.dart';

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<ToDo> toDoIteams = [];

  void _showModal(BuildContext context) {
    showModalBottomSheet(
        // isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              height: 500,
              width: double.infinity,
              color: const Color.fromARGB(71, 60, 224, 236),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(children: [
                  TextField(
                    controller: _titleController,
                    decoration: appTextField("Enter List Title"),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: appTextField("Enter List Description"),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        if (_titleController.text.trim().isNotEmpty &&
                            _descriptionController.text.trim().isNotEmpty) {
                          toDoIteams.add(ToDo(_titleController.text.trim(),
                              _descriptionController.text.trim(), false));
                          if (mounted) {
                            setState(() {});
                          }
                          Navigator.pop(context);
                          _titleController.clear();
                          _descriptionController.clear();
                        }
                      },
                      icon: const Icon(Icons.add_chart),
                      label: const Text("Add List")),
                ]),
              ),
            ),
          );
        });
  }

  int _editingIndex = -1;

  void _openEditDialog(int index) {
    setState(() {
      _editingIndex = index;
      _titleController.text = toDoIteams[index].title;
      _descriptionController.text = toDoIteams[index].description;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit ToDo List'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: appTextField("Title"),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: _descriptionController,
                decoration: appTextField("Description"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _titleController.clear();
                _descriptionController.clear();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_titleController.text.trim().isNotEmpty &&
                    _descriptionController.text.trim().isNotEmpty) {
                  toDoIteams[index].title = _titleController.text.trim();
                  toDoIteams[index].description =
                      _descriptionController.text.trim();
                  _editingIndex = -1;
                }
                setState(() {});
                Navigator.of(context).pop();
                _titleController.clear();
                _descriptionController.clear();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  bool _isDarkMode = false;

  // void _toggleTheme() {
  //   setState(() {
  //     _isDarkMode = !_isDarkMode;
  //     _isDarkMode ? ThemeData.dark() : ThemeData.light();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDO App"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                // _toggleTheme();
              },
              icon: Icon(_isDarkMode ? Icons.nightlight_round : Icons.wb_sunny))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        child: ListView.builder(
          itemCount: toDoIteams.length,
          itemBuilder: (context, index) {
            return Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              margin: const EdgeInsets.symmetric(vertical: 20),
              elevation: 4,
              shadowColor: Colors.greenAccent,
              child: Container(
                  color: Colors.grey[250],
                  child: ListTile(
                    onTap: () {
                      toDoIteams[index].isDone = !toDoIteams[index].isDone;
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    leading: toDoIteams[index].isDone
                        ? const Icon(
                            Icons.check_box_rounded,
                            color: Colors.deepOrange,
                          )
                        : const Icon(Icons.check_box_outline_blank_rounded,
                            color: Color.fromARGB(255, 11, 11, 11)),
                    title: Text(
                      toDoIteams[index].title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(toDoIteams[index].description),
                    trailing: SizedBox(
                      height: 30,
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                toDoIteams.removeAt(index);
                                if (mounted) {
                                  setState(() {});
                                }
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Color.fromARGB(255, 13, 12, 12),
                              )),
                          IconButton(
                              onPressed: () {
                                _openEditDialog(index);
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.deepOrange,
                              )),
                        ],
                      ),
                    ),
                  )),
            );
          },
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add_comment),
        label: const Text("Press Here To Add Your List"),
        onPressed: () {
          _showModal(context);
        },
      ),
    );
  }
}

class ToDo {
  String title, description;
  bool isDone;
  ToDo(this.title, this.description, this.isDone);
}
