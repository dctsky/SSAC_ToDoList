import 'package:flutter/material.dart';
import 'package:flutter_to_do_list/db/database_helpers.dart';
import 'package:flutter_to_do_list/model/todo.dart';
import 'package:intl/intl.dart';

class UpdatePage extends StatefulWidget {
  Todo todo;

  UpdatePage(this.todo);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController _titleController;

  TextEditingController _contentController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = new TextEditingController(text: widget.todo.title);
    _contentController = new TextEditingController(text: widget.todo.content);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[400],
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLines: 1,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.white),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.amber[400]),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            style: TextStyle(fontSize: 18),
            cursorColor: Colors.white,
          ),
          Container(
            height: 20,
          ),
          TextField(
            controller: _contentController,
            minLines: 3,
            maxLines: 3,
            autocorrect: false,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.white),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.amber[400]),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            style: TextStyle(fontSize: 16),
            cursorColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text("UDATE TASK"),
      centerTitle: true,
      backgroundColor: Colors.amber[400],
      elevation: 0,
      actions: [
        FlatButton(
          textColor: Colors.white,
          child: Text(
            '저장',
            style: TextStyle(fontSize: 18),
          ),
          shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          onPressed: () {
            DBHelper.db.updateTodo(Todo(
              id: widget.todo.id,
              title: _titleController.text,
              content: _contentController.text,
              date: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
            ));

            Navigator.pop(this.context);
          },
        ),
      ],
    );
  }
}
