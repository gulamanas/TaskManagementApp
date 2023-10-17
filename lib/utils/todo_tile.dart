import 'package:flutter/material.dart';
import 'package:task_management_app/utils/dialog_box.dart';

class TodoTile extends StatefulWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  VoidCallback onDelete;

  TodoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  final _controller = TextEditingController();

  void onCancel() {
    Navigator.of(context).pop();
  }

  void updateTodoData() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.taskName;
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: widget.taskCompleted,
                  onChanged: widget.onChanged,
                  activeColor: Colors.black,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return DialogBox(
                            controller: _controller,
                            onCancel: onCancel,
                            onSave: updateTodoData,
                          );
                          // return AlertDialog(
                          //   content: Text(taskName),
                          //   actions: [Text('data')],
                          // );
                        });
                  },
                  child: Text(
                    widget.taskName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      decoration: widget.taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: widget.onDelete,
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
