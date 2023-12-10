import 'package:flutter/material.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';

class Hel extends StatelessWidget {
  const Hel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DraggableGridViewBuilder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio:
                  MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 3),
            ),
            isOnlyLongPress: true,
            dragCompletion: (List<DraggableGridItem> list, int beforeIndex, int afterIndex) {
              print('onDragAccept: $beforeIndex -> $afterIndex');
            },
            dragFeedback: (List<DraggableGridItem> list, int index) {
              return Container(
                child: list[index].child,
                width: 200,
                height: 150,
              );
            },
            dragPlaceHolder: (List<DraggableGridItem> list, int index) {
              return PlaceHolderWidget(
                child: Container(
                  color: Colors.white,
                ),
              );
            },
            children: [
              DraggableGridItem(
                  isDraggable: true,
                  child: Container(
                    // width: 200,
                    constraints: const BoxConstraints(maxHeight: 150, maxWidth: 150),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {
                          // controller.removeImage(file.path);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  )),
              DraggableGridItem(
                  isDraggable: true,
                  child: Container(
                    // width: 200,
                    constraints: const BoxConstraints(maxHeight: 150, maxWidth: 100),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // child: Align(
                    //   alignment: Alignment.topRight,
                    //   child: IconButton(
                    //     onPressed: () {
                    //       // controller.removeImage(file.path);
                    //     },
                    //     icon: const Icon(
                    //       Icons.delete,
                    //       color: Colors.red,
                    //     ),
                    //   ),
                    // ),
                  )),
            ]),
      ),
    );
  }
}

class SliverExample extends StatefulWidget {
  const SliverExample({Key? key}) : super(key: key);

  @override
  State createState() => _SliverExample();
}

class _SliverExample extends State<SliverExample> {
  late List<DragAndDropList> _contents;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _contents = List.generate(10, (index) {
      return DragAndDropList(
        children: <DragAndDropItem>[
          DragAndDropItem(
              child: Container(
                color: Colors.blue,
                width: 50,
                height: 30,
              ),
              feedbackWidget: Container(
                color: Colors.red,
                width: 50,
                height: 30,
              )),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            flexibleSpace: Container(
              color: Colors.pinkAccent,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Slivers',
                  style: Theme.of(context).primaryTextTheme.headline1,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 20),
            sliver: DragAndDropLists(
              children: [
                DragAndDropList(
                  children: <DragAndDropItem>[
                    DragAndDropItem(
                        child: Container(
                          color: Colors.blue,
                          width: 50,
                          height: 30,
                        ),
                        feedbackWidget: Container(
                          color: Colors.red,
                          width: 50,
                          height: 30,
                        )),
                  ],
                ),
                DragAndDropList(
                  children: <DragAndDropItem>[
                    DragAndDropItem(
                        child: Container(
                          color: Colors.blue,
                          width: 50,
                          height: 30,
                        ),
                        feedbackWidget: Container(
                          color: Colors.red,
                          width: 50,
                          height: 30,
                        )),
                  ],
                )
              ],
              onItemReorder: _onItemReorder,
              onListReorder: _onListReorder,
              sliverList: true,
              scrollController: _scrollController,
            ),
          ),
        ],
      ),
    );
  }

  _onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
      _contents[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = _contents.removeAt(oldListIndex);
      _contents.insert(newListIndex, movedList);
    });
  }
}
