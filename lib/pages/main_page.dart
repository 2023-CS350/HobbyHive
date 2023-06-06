import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<String> _names = [
    "Red",
    "Blue",
    "Green",
    "Yellow",
    "Orange",
    "Grey",
    "Purple",
    "Pink"
  ];
  List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.grey,
    Colors.purple,
    Colors.pink
  ];

  @override
  void initState() {
    for (int i = 0; i < _names.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(text: _names[i], color: _colors[i]),
          likeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Liked ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Nope ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          superlikeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Superliked ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          onSlideUpdate: (SlideRegion? region) async {
            print("Region $region");
          }));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(widget.title!),
        ),
        body: Container(
            child: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height - kToolbarHeight,
            child: SwipeCards(
              matchEngine: _matchEngine!,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: _swipeItems[index].content.color,
                  child: Text(
                    _swipeItems[index].content.text,
                    style: TextStyle(fontSize: 100),
                  ),
                );
              },
              onStackFinished: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Stack Finished"),
                  duration: Duration(milliseconds: 500),
                ));
              },
              itemChanged: (SwipeItem item, int index) {
                print("item: ${item.content.text}, index: $index");
              },
              leftSwipeAllowed: true,
              rightSwipeAllowed: true,
              upSwipeAllowed: false,
              fillSpace: true,
              likeTag: Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.green)),
                child: Text('Like'),
              ),
              nopeTag: Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.red)),
                child: Text('Nope'),
              ),
              superLikeTag: Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.orange)),
                child: Text('Super Like'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _matchEngine!.currentItem?.nope();
                    },
                    child: Text("Nope")),
                // ElevatedButton(
                //     onPressed: () {
                //       _matchEngine!.currentItem?.superLike();
                //     },
                //     child: Text("Superlike")),
                ElevatedButton(
                    onPressed: () {
                      _matchEngine!.currentItem?.like();
                    },
                    child: Text("Like"))
              ],
            ),
          )
        ])));
  }
}

class Content {
  final String? text;
  final Color? color;
  final String? imageURL;
  final String? name;
  final String? hobby;
  final String? distance;


  Content({this.imageURL, this.name, this.hobby, this.distance, this.text, this.color});
}
// import 'package:flutter/material.dart';

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SwappableWidget(),
//       ),
//     );
//   }
// }

// class SwappableWidget extends StatefulWidget {
//   @override
//   _SwappableWidgetState createState() => _SwappableWidgetState();
// }

// class _SwappableWidgetState extends State<SwappableWidget> {
//   int? _draggedIndex=0;
//   List<String> _items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Swappable Widget'),
//       ),
//       body: GridView.builder(
//         itemCount: _items.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//         ),
//         itemBuilder: (BuildContext context, int index) {
//           return DragTarget<int>(
//             onAccept: (int draggedIndex) {
//               setState(() {
//                 final item = _items[draggedIndex];
//                 _items.removeAt(draggedIndex);
//                 _items.insert(index, item);
//                 _draggedIndex = null;
//               });
//             },
//             onWillAccept: (int? draggedIndex) {
//               return true;
//             },
//             onLeave: (data) {
//               _draggedIndex = null;
//             },
//             builder: (BuildContext context, List<dynamic> candidateData, List<dynamic> rejectedData) {
//               return Draggable<int>(
//                 data: index,
//                 child: Container(
//                   padding: EdgeInsets.all(8),
//                   color: Colors.blue,
//                   child: Center(
//                     child: Text(
//                       _items[index],
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 feedback: Container(
//                   padding: EdgeInsets.all(8),
//                   color: Colors.blue.withOpacity(0.7),
//                   child: Center(
//                     child: Text(
//                       _items[index],
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 onDragStarted: () {
//                   setState(() {
//                     _draggedIndex = index;
//                   });
//                 },
//                 onDraggableCanceled: (Velocity velocity, Offset offset) {
//                   setState(() {
//                     _draggedIndex = null;
//                   });
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }