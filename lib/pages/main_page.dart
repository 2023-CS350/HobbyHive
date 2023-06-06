import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

enum ButtonType {
  nope,
  like,
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final List<String> _names = [
    "Red",
    "Blue",
    "Green",
    "Yellow",
    "Orange",
    "Grey",
    "Purple",
    "Pink"
  ];
  final List<Color> _colors = [
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
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Container(
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
                    RoundedTransparentButton(
                      onPressed: () {
                        _matchEngine!.currentItem?.nope();
                      },
                      kind: ButtonType.nope,
                    ),
                    RoundedTransparentButton(
                      onPressed: () {
                        _matchEngine!.currentItem?.like();
                      },
                      kind: ButtonType.like,
                    ),
                  
                  ],
                ),
              )
            ])),
          ),
        ));
  }
}

class Content {
  final String? text;
  final Color? color;
  final String? imageURL;
  final String? name;
  final String? hobby;
  final String? distance;

  Content(
      {this.imageURL,
      this.name,
      this.hobby,
      this.distance,
      this.text,
      this.color});
}

class RoundedTransparentButton extends StatelessWidget {
  final VoidCallback onPressed;
  final ButtonType kind;

  RoundedTransparentButton({required this.onPressed, required this.kind});

  @override
  Widget build(BuildContext context) {
    return kind == ButtonType.like
        ? ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              side: BorderSide(color: Colors.green, width: 2.0),
              shape: CircleBorder(),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Icon(
                Icons.favorite,
                color: Colors.green,
                size: 40.0,
              ),
            ),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              side: BorderSide(color: Colors.red, width: 2.0),
              shape: CircleBorder(),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Icon(
                Icons.clear,
                color: Colors.red,
                size: 40.0,
              ),
            ),
          );
  }
}
