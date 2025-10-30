import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:provider/provider.dart';

// 1) You need to install this so it works 'flutter pub add http'
import 'package:http/http.dart' as http;

//This is where we will fetch some sample JSON (have a look at it please)
// final String postURL = "https://jsonplaceholder.typicode.com/posts";

// 2) ADD your JItem class below (we'll do in class or grab from 10b notes)
class JItem {
  final int id;
  final String title;

  JItem({required this.id, required this.title});
}

class JItemsProvider extends ChangeNotifier {
  List<JItem> items = [];
  final String postURL = "https://jsonplaceholder.typicode.com/posts";

  Future<void> getData() async {
    var response = await http.get(Uri.parse(postURL));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      for (var item in data) {
        item.add(JItem(id: item['id'], title: item['title']));
      }
    }

    // return posts; // We'll fix this next
    notifyListeners();
  }

  void clear() {
    items.clear();
    notifyListeners();
  }
}

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => JItemsProvider(),
      child: MaterialApp(title: 'Future Provider Example', home: DemoPage()),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  //3 Add better type checking here use the <JList> we created
  // List data = [];
  List<JItem> data = [];

  // Future<List<JItem>> getData() async {
  //   List<JItem> posts = [];

  //   var response = await http.get(Uri.parse(postURL));

  //   if (response.statusCode == 200) {
  //     var data = json.decode(response.body);

  //     for (var item in data) {
  //       posts.add(JItem(id: item['id'], title: item['title']));
  //     }
  //   }

  //   return posts;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Example'), backgroundColor: Colors.orange),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Consumer<JItemsProvider>(
                  builder: (context, value, child) {
                    return ElevatedButton(
                      onPressed: () => value.getData(),
                      child: Text('Get Data'),
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () => context.read<JItemsProvider>().clear(),
                  child: Text('Clear Data'),
                ),
              ],
            ),
            Expanded(
              child: Consumer<JItemsProvider>(
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: value.items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(value.items[index].id.toString()),
                        subtitle: Text(value.items[index].title),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//4) Create the getData Function here!
