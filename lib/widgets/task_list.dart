import 'package:flutter/material.dart';

class TaskList extends StatefulWidget {
  final String title;
  final String time;
  TaskList({required this.title, required this.time});
  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Material(
        child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.time,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            Flexible(
                child: Material(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      PopupMenuButton(
                          color: Colors.white,
                          elevation: 20,
                          enabled: true,
                          onSelected: (value) {
                            setState(() {
                              _value = value.toString();
                            });
                          },
                          itemBuilder: (context) {
                            return _list.map((PopupItem choice) {
                              return PopupMenuItem(
                                value: choice,
                                child: Text(
                                  choice.name,
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList();
                          })
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  String _value = "";

  List<PopupItem> _list = [
    PopupItem(1, "Delete"),
    PopupItem(2, "Update"),
    PopupItem(3, "More"),
  ];
}

class PopupItem {
  int value;
  String name;
  PopupItem(this.value, this.name);
}
