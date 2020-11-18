import 'package:flutter/material.dart';
import 'package:flutter_to_do_list/db/database_helpers.dart';
import 'package:flutter_to_do_list/model/todo.dart';
import 'package:intl/intl.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              hintText: '제목',
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
              hintText: '내용',
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
      title: Text("ADD A NEW TASK"),
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
            DBHelper.db.insertTodo(Todo(
                title: _titleController.text,
                content: _contentController.text,
                date: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())));

            Navigator.pop(this.context);
          },
        ),
      ],
    );
  }
}
