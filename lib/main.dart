import 'package:flutter/material.dart';

// 1) You need to install this so it works 'flutter pub add http'
import 'package:http/http.dart' as http;

//This is where we will fetch some sample JSON (have a look at it please)
final String postURL = "https://jsonplaceholder.typicode.com/posts";

// 2) ADD your JItem class below (we'll do in class or grab from 10b notes)

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: DemoPage());
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {

  //3 Add better type checking here use the <JList> we created
  List data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Example'), backgroundColor: Colors.blue),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Get data logic here
                  },
                  child: Text('Get Data'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Clear data logic here
                  },
                  child: Text('Clear Data'),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data[index].id.toString()),
                    subtitle: Text(data[index].title),
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
