import 'package:flutter/material.dart';
import 'package:flutter_to_do_list/model/todo.dart';

class ToDoTile extends StatefulWidget {
  final Todo todo;
  ToDoTile(this.todo);

  @override
  _ToDoTileState createState() => _ToDoTileState();
}

class _ToDoTileState extends State<ToDoTile> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: CheckboxListTile(
          activeColor: Colors.amber,
          contentPadding: EdgeInsets.all(4.0),
          value: _isChecked,
          onChanged: (bool value) {
            setState(() {
              _isChecked = value;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(widget.todo.title,
            style: TextStyle(
              color: _isChecked == true ? Colors.grey[350] : Colors.black54,
              decoration:
                  _isChecked == true ? TextDecoration.lineThrough : null,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            widget.todo.content,
            style: TextStyle(
              color: _isChecked == true ? Colors.grey[350] : Colors.black54,
              decoration:
                  _isChecked == true ? TextDecoration.lineThrough : null,
            ),
          ),
        ));
  }
}
