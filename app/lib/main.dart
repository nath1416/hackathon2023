import 'package:app/firebase_options.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import 'main_drawer.dart';

// await Firebase.initializeApp(

//     options: DefaultFirebaseOptions.currentPlatform,

// );

void main() async {
  //Initializing Database when starting the application.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  MaterialColor mainColorM = Colors.green;
  Color mainColor = Colors.green;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: mainColorM,
        appBarTheme: AppBarTheme(
          color: mainColor,
          toolbarTextStyle: TextStyle(
            color: Colors.yellow.shade50,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: mainColor).copyWith(
          secondary: Colors.green.shade300,
          primary: mainColor,
        ),
        fontFamily: "Montserrat",
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 72.0,
            fontWeight: FontWeight.bold,
            color: mainColor,
          ),
          headline2: TextStyle(
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
            color: mainColor,
          ),
          headline3: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: mainColor,
          ),
          headline4: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: mainColor,
          ),
          headline5: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: mainColor,
          ),
          headline6: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: mainColor,
          ),
          bodyText1: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
            color: mainColor,
          ),
          bodyText2: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: mainColor,
          ),
          subtitle1: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
            color: mainColor,
          ),
          subtitle2: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: mainColor,
          ),
          button: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
            color: mainColor,
          ),
          caption: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: mainColor,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int loadSize = 3;

  int currentSize = 0;

  List<Map<String, dynamic>> currentData = [];

  List<Map<String, dynamic>> data = [
    {
      "title": "Happy 1title iudgh fsdfsdyufgbsdf1",
      "content":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      "link": "https://www.google.com/",
      "logo link": "...",
      "id": "a",
      "liked": false,
    },
    {
      "title": "Happy 2title iudgh fsdfsdyufgbsdf2",
      "content":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      "link": "https://www.google.com/",
      "logo link": "...",
      "id": "b",
      "liked": false,
    },
    {
      "title": "Happy title iudgh fsdfsdyufgbsdf3",
      "content":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      "link": "https://www.google.com/",
      "logo link": "...",
      "id": "c",
      "liked": false,
    },
    {
      "title": "Happy title iudgh fsdfsdyufgbsdf4",
      "content":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      "link": "https://www.google.com/",
      "logo link": "...",
      "id": "d",
      "liked": false,
    },
    {
      "title": "Happy title iudgh fsdfsdyufgbsdf",
      "content":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      "link": "https://www.google.com/",
      "logo link": "...",
      "id": "e",
      "liked": false,
    },
    {
      "title": "Happy title iudgh fsdfsdyufgbsdf",
      "content":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      "link": "https://www.google.com/",
      "logo link": "...",
      "id": "f",
      "liked": false,
    },
    {
      "title": "Happy title iudgh fsdfsdyufgbsdf",
      "content":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      "link": "https://www.google.com/",
      "logo link": "...",
      "id": "g",
      "liked": false,
    },
    {
      "title": "Happy title iudgh fsdfsdyufgbsdf",
      "content":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      "link": "https://www.google.com/",
      "logo link": "...",
      "id": "g",
      "liked": false,
    },
    {
      "title": "Happy title iudgh fsdfsdyufgbsdf",
      "content":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      "link": "https://www.google.com/",
      "logo link": "...",
      "id": "g",
      "liked": false,
    },
    {
      "title": "Happy title iudgh fsdfsdyufgbsdf",
      "content":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      "link": "https://www.google.com/",
      "logo link": "...",
      "id": "g",
      "liked": false,
    },
    {
      "title": "Happy title iudgh fsdfsdyufgbsdf",
      "content":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      "link": "https://www.google.com/",
      "logo link": "...",
      "id": "g",
      "liked": false,
    },
    {
      "title": "Happy title iudgh fsdfsdyufgbsdf",
      "content":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      "link": "https://www.google.com/",
      "logo link": "...",
      "id": "g",
      "liked": false,
    },
    {
      "title": "Happy title iudgh fsdfsdyufgbsdf",
      "content":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      "link": "https://www.google.com/",
      "logo link": "...",
      "id": "g",
      "liked": false,
    },
    {
      "title": "Happy title iudgh fsdfsdyufgbsdf",
      "content":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      "link": "https://www.google.com/",
      "logo link": "...",
      "id": "g",
      "liked": false,
    },
    {
      "title": "Happy title iudgh fsdfsdyufgbsdf",
      "content":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      "link": "https://www.google.com/",
      "logo link": "...",
      "id": "g",
      "liked": false,
    },
    {
      "title": "Happy title iudgh fsdfsdyufgbsdf",
      "content":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      "link": "https://www.google.com/",
      "logo link": "...",
      "id": "g",
      "liked": false,
    },
  ];

  Map<String, bool> filters = {
    "admiration": true,
    "amusement": true,
    "approval": true,
    "caring": true,
    "love": true,
    "optimism": true,
    "relief": true,
  };

  toggleFilter(bool value, String name) {
    setState(() {
      filters[name] = value;
      currentSize = 0;

      currentData = [];
      appendList();
    });
  }

  // Future<List<Map<String, dynamic>>> getContent() async {
  //   // List<Map<String, Object>> returnData =
  //   //     data.sublist(currentSize, currentSize + loadSize - 1);
  //   // currentSize += loadSize;

  // }

  void appendList() {
    List<Map<String, dynamic>> returnData = [];
    List<String> wFilters = [];
    for (var key in filters.keys) {
      if (filters[key] as bool) {
        wFilters.add(key);
      }
    }
    FirebaseFirestore.instance
        .collection("Final6")
        // .where("categorie")sdfsdfasd
        .where("categorie", whereIn: wFilters)
        .orderBy("percent", descending: true)
        .limit(currentSize + loadSize)
        .get()
        .then((res) async {
      for (var element in res.docs.sublist(currentSize)) {
        print(element.data()["title"]);
        Map<String, dynamic> elementData = element.data();
        elementData["liked"] = false;
        returnData.add(elementData);
      }
      currentSize += loadSize;
      setState(() {
        currentData.addAll(returnData);
      });
    }).catchError((e) {
      print("Failed");
    });
    print(currentData.length);
  }

  void toggleLike(String id) {
    // TODO
    // data.firstWhere((e) => e["id"] == id)["liked"] =
    //     !(data.firstWhere((e) => e["id"] == id)["liked"] as bool);
  }
  void deleteArticle(String id) {
    setState(() {
      currentData.removeWhere((e) => e["title"] as String == id);
    });
    // TODO
  }

  ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    appendList();
    super.initState();
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      appendList();
    }
    // if (_controller.offset <= _controller.position.minScrollExtent &&
    //     !_controller.position.outOfRange) {
    //   setState(() {
    //     print("reach the top");
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: MainDrawer(toggleSwitch: toggleFilter, currentFilters: filters),
      appBar: AppBar(
        title: Image.asset("lib/assets/images/logo_withe.png",
            height: height * 0.08),
        elevation: 0,
        toolbarHeight: height * 0.1,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
            color: Theme.of(context).colorScheme.primary,
            height: 2,
          ),
        ),
      ),
      body: Center(
        child: Container(
          color: Colors.grey.shade200,
          width: double.infinity,
          child: Container(
            child: ListView(
              controller: _controller,
              children: [
                SizedBox(height: height * 0.04),
                Text(
                  "Your news",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height * 0.03),
                ...currentData.map((article) {
                  return Column(
                    children: [
                      SizedBox(height: height * 0.03),
                      Article(
                        data: article,
                        toggleLike: toggleLike,
                        deleteArticle: deleteArticle,
                      ),
                    ],
                  );
                }).toList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

typedef s2Void = void Function(String);

class Article extends StatefulWidget {
  final Map<String, dynamic> data;
  final s2Void toggleLike;
  final s2Void deleteArticle;

  const Article(
      {super.key,
      required this.data,
      required this.toggleLike,
      required this.deleteArticle});

  // bool isVisible =

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  void updateToggleLike(String id) {
    setState(() {
      widget.data["liked"] = !(widget.data["liked"] as bool);
    });
    widget.toggleLike(id);
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    Color buttonColor = Colors.black;

    return Container(
      height: 250,
      width: width * 0.8,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: Container(
                width: width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Center(),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 6,
                      child: Text(
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        widget.data["title"] as String,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: IconButton(
                        icon: Icon(Icons.close_rounded),
                        onPressed: () => widget
                            .deleteArticle(widget.data["title"] as String),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            !(widget.data["hasImage"] as bool)
                ? Flexible(
                    fit: FlexFit.tight,
                    flex: 7,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 7,
                      textAlign: TextAlign.left,
                      widget.data["body"] as String,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  )
                : Flexible(
                    fit: FlexFit.tight,
                    flex: 7,
                    child: Image.network(widget.data["urlImage"], height: 20)),
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // CircleAvatar(
                  //   backgroundColor: Theme.of(context).colorScheme.error,
                  //   child: IconButton(
                  //       icon: Icon(
                  //         Icons.delete,
                  //         color: buttonColor,
                  //       ),
                  //       onPressed: () =>
                  //           widget.deleteArticle(widget.data["id"] as String)),
                  // ),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: IconButton(
                      icon: Icon(
                        Icons.link,
                        color: buttonColor,
                      ),
                      onPressed: () {
                        openUrl(widget.data["url"] as String);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  !(widget.data["liked"] as bool)
                      ? CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          child: IconButton(
                            icon: Icon(
                              Icons.thumb_up_alt_outlined,
                              color: buttonColor,
                            ),
                            onPressed: () => updateToggleLike(
                                widget.data["title"] as String),
                          ),
                        )
                      : CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          child: IconButton(
                            icon: Icon(
                              Icons.thumb_up_alt,
                              color: buttonColor,
                            ),
                            onPressed: () => updateToggleLike(
                                widget.data["title"] as String),
                          ),
                        ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

Future<void> openUrl(String url) async {
  final uri = Uri.parse(url);
  // if (await canLaunchUrl(uri)) {
  await launchUrl(uri);
  // } else {
  //   throw 'Could not launch $url';
  // }
}

// void _launchUrl(String url) {
//   // final uri = Uri.parse(url);
//   // if (await canLaunchUrl(uri)) {
//   //   await launchUrl(uri);
//   // } else {
//   //   throw 'Could not launch $url';
//   // }
//   // js.context.callMethod('open', ['https://stackoverflow.com/questions/ask']);
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
