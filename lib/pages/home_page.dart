import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _data = '';

  //Вытягивание данных 
  Future<void>fetchData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
    var response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Data fetched successfully: ${response.body}");
      setState(() {
        _data = response.body;
      });
    } else {
      print("Failder to fetch data ${response.statusCode}");
      setState(() {
        _data = 'Failder to fetch data';
      });
    }
  }
    //Создание данных
    Future<void>createData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await http.post(url,body: {'title': 'New Post','body': 'Here is the body','userId': '1' });
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        _data = 'Data created successfuly : ${response.body}';
      });
    } else {
      setState(() {
        _data = 'Failder to create data';
      });
    }
  }

  //Удаленние данных в posts/1
  Future<void>deleteData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
    var response = await http.delete(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        _data = 'Data deleted successfuly';
      });
    } else {
      setState(() {
        _data = 'Failder to create data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Http Request"),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: fetchData,
                  child: const Text("Fetch Data"),
                ),
                ElevatedButton(
                  onPressed: createData,
                  child: const Text("Create Data"),
                ),
                ElevatedButton(
                  onPressed: deleteData,
                  child: const Text("Delete Data"),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_data),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
