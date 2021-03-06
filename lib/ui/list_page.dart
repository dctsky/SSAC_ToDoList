import 'package:flutter/material.dart';
import 'package:flutter_to_do_list/ui/create_page.dart';
import 'package:flutter_to_do_list/db/database_helpers.dart';
import 'package:flutter_to_do_list/model/todo.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_to_do_list/ui/update_page.dart';
import 'package:flutter_to_do_list/extensions/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Todo> _items = [];
  TextEditingController _textEditingController;
  var _query = "";
  int _counter = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _incrementCounter();
    _fetchList();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showDialog());
  }

  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = (prefs.getInt('counter') ?? 0) + 1;
    await prefs.setInt('counter', _counter);
    // prefs.remove('counter');
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Text("환영합니다.\n $_counter번째 방문이시군요."),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future<void> _fetchList() async {
    // DBHelper.db.deleteAllTodos();
    _items = await DBHelper.db.getAllTodos();
    setState(() {
      _items.sort((b, a) =>
          a.date.stringToDate().compareTo(b.date.stringToDate()));
      _items.sort((a, b) => a.isChecked.compareTo(b.isChecked));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[400],
      appBar: _buildAppBar(),
      body:  _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: Text("TO DO"),
      centerTitle: true,
      backgroundColor: Colors.amber[400],
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreatePage()),
            ).then((value) => _fetchList());

            setState(() {});
          },
        ),
      ],
    );
  }

  _buildBody() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              TextField(
                onChanged: (text) {
                  setState(() {
                    _query = text;
                  });
                },
                autofocus: false,
                controller: _textEditingController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '검색',
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
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(_items
              .where(
                  (e) => e.title.toLowerCase().contains(_query.toLowerCase()))
              .map((e) => _buildTile(e))
              .toList()),
        ),
      ],
    );
  }

  Widget _buildTile(Todo todo) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      actions: [
        IconSlideAction(
          caption: '수정',
          color: Colors.green,
          icon: Icons.create,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UpdatePage(todo)),
            ).then((value) => _fetchList());
          },
        ),
      ],
      secondaryActions: [
        IconSlideAction(
          caption: '삭제',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            _items.remove(todo);
            DBHelper.db.deleteTodo(todo.id).then((value) => _fetchList());
          },
        ),
      ],
      child: Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: CheckboxListTile(
              activeColor: Colors.amber,
              contentPadding: EdgeInsets.all(4.0),
              value: todo.isChecked == 0 ? false : true,
              onChanged: (bool value) {
                value == false ? todo.isChecked = 0 : todo.isChecked = 1;
                setState(() {
                  DBHelper.db.updateTodo(todo);
                  _fetchList();
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                todo.title,
                style: TextStyle(
                  color:
                  todo.isChecked == 0 ? Colors.black54 : Colors.grey[350],
                  decoration:
                  todo.isChecked == 0 ? null : TextDecoration.lineThrough,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                todo.content,
                style: TextStyle(
                  color:
                  todo.isChecked == 0 ? Colors.black54 : Colors.grey[350],
                  decoration:
                  todo.isChecked == 0 ? null : TextDecoration.lineThrough,
                ),
              ),
              secondary: Text(
                todo.date.stringToDate().dateToString('yy.MM.dd EEE'),
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.end,
              ))),
    );
  }
}
