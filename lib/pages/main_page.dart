import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hobby_hive/models/event_model.dart';
import 'package:hobby_hive/pages/create_event_page.dart';
import 'package:hobby_hive/widgets/loading_indicator.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';

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
  bool _isLoading = true;
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
  // final List<Color> _colors = [
  //   Colors.red,
  //   Colors.blue,
  //   Colors.green,
  //   Colors.yellow,
  //   Colors.orange,
  //   Colors.grey,
  //   Colors.purple,
  //   Colors.pink
  // ];

  List<Event> _eventList = [];
  List<String> _eventImageList = [];
  @override
  void initState() {
    _getUserEvents();

    super.initState();
  }

  _getUserEvents() async {
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    if (mounted)
      setState(() {
        _isLoading = true;
      });
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseStorage storage = FirebaseStorage.instance;

    QuerySnapshot querySnapshot = await _firestore.collection('events').get();
    for (var doc in querySnapshot.docs) {
      doc.id;
      Map<String, dynamic> eachEvent =
          doc.data() as Map<String, dynamic>; // 각 문서의 데이터를 출력합니다.
      print(doc.data().toString());

      var each = Event.fromJson(eachEvent);
      Reference ref = storage.ref().child('events/${each.event_image}');
      String downloadURL = await ref.getDownloadURL();
      _eventImageList.add(downloadURL);

      _eventList.add(each);
    }
    for (int i = 0; i < _eventList.length; i++) {
      _swipeItems.add(SwipeItem(
          // content: Content(text: _names[i], color: _colors[i]),
          likeAction: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Liked"),
          duration: Duration(milliseconds: 500),
        ));
        querySnapshot.docs[i].reference.update({
          'candidates':
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
        });
      }, nopeAction: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Nope"),
          duration: Duration(milliseconds: 500),
        ));
      }, superlikeAction: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Superliked"),
          duration: Duration(milliseconds: 500),
        ));
      }, onSlideUpdate: (SlideRegion? region) async {
        print("Region $region");
      }));
    }

    //  _matchEngine = MatchEngine(swipeItems: _swipeItems);
    if (mounted)
      setState(() {
        _isLoading = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildEventCard(int index) {
      return Stack(
        children: [
          Material(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
            elevation: 5.0,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                // color: Colors.red,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: (_eventImageList[index]),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 280,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          _eventList[index].event_name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          " | ${_eventList[index].description}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.pink),
                        ),
                      ],
                    ),
                    Text(_eventList[index].address),
                  ],
                ),
              ),
            ),
          )
        ],
      );
    }

    return _isLoading
        ? LoadingIndicator()
        : Scaffold(
            key: _scaffoldKey,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateEventPage(),
                  ),
                );
              },
              child: Icon(Icons.add), // 버튼 안의 아이콘
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 100, 20, 80),
                child: Container(
                    child: Stack(children: [
                  Container(
                    height: MediaQuery.of(context).size.height - kToolbarHeight,
                    child: SwipeCards(
                      matchEngine: _matchEngine!,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildEventCard(index);
                      },
                      onStackFinished: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Stack Finished"),
                          duration: Duration(milliseconds: 500),
                        ));
                      },
                      itemChanged: (SwipeItem item, int index) {
                        print(index);
                      },
                      leftSwipeAllowed: true,
                      rightSwipeAllowed: true,
                      upSwipeAllowed: false,
                      fillSpace: true,
                      likeTag: Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                        ),
                        child: Text(
                          'Like',
                          style: TextStyle(color: Colors.green, fontSize: 60),
                        ),
                      ),
                      nopeTag: Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                        ),
                        child: Text(
                          'Nope',
                          style: TextStyle(color: Colors.red, fontSize: 60),
                        ),
                      ),
                      superLikeTag: Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange)),
                        child: Text('Super Like'),
                      ),
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       RoundedTransparentButton(
                  //         onPressed: () {
                  //           _matchEngine!.currentItem?.nope();
                  //         },
                  //         kind: ButtonType.nope,
                  //       ),
                  //       RoundedTransparentButton(
                  //         onPressed: () {
                  //           _matchEngine!.currentItem?.like();
                  //         },
                  //         kind: ButtonType.like,
                  //       ),
                  //     ],
                  //   ),
                  // )
                ])),
              ),
            ));
  }
}

// class Content {
//   final String? text;
//   final Color? color;
//   final String? imageURL;
//   final String? name;
//   final String? hobby;
//   final String? distance;

//   Content(
//       {this.imageURL,
//       this.name,
//       this.hobby,
//       this.distance,
//       this.text,
//       this.color});
// }

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
