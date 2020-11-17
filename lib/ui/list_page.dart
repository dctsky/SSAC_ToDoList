import 'package:flutter/material.dart';
import 'package:flutter_to_do_list/widget/to_do_tile.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool _isChecked = false;
  List<Widget> _items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[400],
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: TextField(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) => ToDoTile(),
              childCount: 5),
        ),
      ],
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

          },
        ),
      ],
    );
  }
}
