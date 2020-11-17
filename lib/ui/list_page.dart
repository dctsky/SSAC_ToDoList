import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
            child: CheckboxListTile(
          value: _isChecked,
          onChanged: (bool value) {
            setState(() {
              _isChecked = value;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(
            '할일 제목',
            style: TextStyle(
              color: _isChecked == true ? Colors.grey : Colors.black,
              decoration:
                  _isChecked == true ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(
            '할일 내용',
            style: TextStyle(
              color: _isChecked == true ? Colors.grey : Colors.black,
              decoration:
                  _isChecked == true ? TextDecoration.lineThrough : null,
            ),
          ),
        ));
      },
    );
  }
}
