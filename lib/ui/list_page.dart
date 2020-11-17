import 'package:flutter/material.dart';
import 'package:flutter_to_do_list/ui/create_page.dart';
import 'package:flutter_to_do_list/widget/to_do_tile.dart';
import 'package:flutter_to_do_list/db/database_helpers.dart';
import 'package:flutter_to_do_list/model/todo.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool _isChecked = false;
  List<Todo> _items = [];
  TextEditingController _textEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchList();
  }

  Future<void> _fetchList() async {
    // DBHelper.db.deleteAllTodos();
    _items = await DBHelper.db.getAllTodos();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[400],
      appBar: _buildAppBar(),
      body: _buildBody(),
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
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreatePage()),
            ).then((value) async {
              _items = await DBHelper.db.getAllTodos();
            }).then((value) {
              setState(() {
              });
            });
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
                autofocus: false,
                controller: _textEditingController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Search',
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
          delegate: SliverChildBuilderDelegate((context, index) {
            return ToDoTile(_items[index]);
          }, childCount: _items.length),
        ),
      ],
    );
  }
}
