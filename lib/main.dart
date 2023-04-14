// ignore_for_file: avoid_print

// import 'dart:html';

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:shell/shell.dart';

import './helpers/helpers.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;

void httptest() async {
  var httpClient = HttpClient();
  httpClient.connectionTimeout = Duration(seconds: 3);
  var urls = Uri.parse('http://www.gstatic.com/generate_204');
  var request = await httpClient.getUrl(urls);
  request.headers.add(HttpHeaders.acceptEncodingHeader, 'gzip');
  request.followRedirects = false;
  var response = await request.close();
  // var bytes = await response.transform(gzip.decoder).toList();
  var bytes = await response.expand((b) => b).toList();
  // var html = utf8.decode(bytes);
  // var flattenedBytes = bytes.expand((byteList) => byteList).toList();
  var output = utf8.decode(bytes);
  // var output = utf8.decode(flattenedBytes);

  if (!output.startsWith('<html>')) {
    print('Something doesn\'t seem right. Check if you are already logged in');
    // exit(1);
  }

  getsecurekey();
  // var shell = new Shell();

  //     arguments: ["-m 3 -s 'http://www.gstatic.com/generate_204'--compressed"]);
  //  "curl -m 3 -s 'http://www.gstatic.com/generate_204'--compressed'"
  // print(pwd);

  // var client = http.Client();

  // var response = await client.get(Uri.parse('http://google.com'));

  // print(response.headers);

  // final url = await getLoginUrl();
  // // print('here');
  // // print(url);
  // if (url == 'http://www.google.co.in/') {
  //   print("Logged in already or using a different network");
  // } else {
  //   print("url is $url");
  //   getParams(url!);
  // }

//  var url = Uri.parse('http://example.com');
  // var response = await http.get(url);
  // print(response.body);

  // var r = await Requests.get('https://google.com', verify: false);
  // r.raiseForStatus();
  // String body = r.content();

  // print(body);
  // print(r.url);

  // final request =
  //     http.Request('GET', Uri.parse('https://gstatic.com/generate_204'));
  // request.followRedirects = false;
  // var response = await http.Client.send(request);

//   var url = Uri.https('apple.com');
//   var response = await http.get(url);
//   print('Response status: ${response.statusCode}');
//   print('Response body: ${response.body}');

// // print(await http.read(Uri.https('example.com', 'foobar.txt')));

  // var client = HttpClient();

  // // link https://starlighter4097.github.io/testing-props/

  // try {
  //   var request = await client.getUrl(Uri.parse('http://apple.com'));
  //   var response = await request.close();

  //   if (response.statusCode == HttpStatus.movedPermanently ||
  //       response.statusCode == HttpStatus.movedTemporarily) {
  //     var redirectUrl = response.headers.value('location');
  //     request = await client.getUrl(Uri.parse(redirectUrl.toString()));
  //     // print(request.);
  //     print('object');
  //     response = await request.close();
  //   }

  //   // Do something with the response
  //   // print(response.headers);
  //   var document = parse(await response.transform(utf8.decoder).join());
  //   List<dynamic> links = document.getElementsByTagName('a');

  //   // for (var link in links) {
  //   //   var href = link.attributes['href'];
  //   //   if (href != null) {
  //   //     print(href);
  //   //   }
  //   // }

  //   ///
  //   //////
  //   ///
  //   ///
  //   ///
  //   ///
  //   ///
  //   ///
  //   ///
  //   ///
  //   ///
  //   ///
  // } catch (e) {
  //   print('Error: $e');
  // } finally {
  //   client.close();
  // }
  //http://www.gstatic.com/generate_204

  // var url = Uri.parse('http://gstatic.com/generate_204');

  // var client = http.Client();

  // final request =
  //     http.Request('GET', Uri.parse('https://gstatic.com/generate_204'));
  // request.followRedirects = false;
  // // var response = await client.send(request);
  // var response = await client.get(url);

  // if (response.statusCode == 200) {
  //   print(response.body);
  //   print(response.request!.url);

  //   // magic, 4tredir, username,password to send the request
  // }
  //else if (response.statusCode == 302) {
  //   final redirectUrl = response.headers['location'];
  //   final redirectedResponse = await http.get(Uri.parse(redirectUrl!));

  //   if (redirectedResponse.statusCode == 200) {
  //     print(redirectedResponse.statusCode);
  //   } else {
  //     print('Error: ${redirectedResponse.statusCode}');
  //   }
  // } else {
  //   print('Error: ${response.statusCode}');
  // }

  dynamic getTheCredentials(String body) {
    String tredir;
    String magic;
    // final String body;

    var parsed = parse(body);
    // List<dynamic> inputelements =
  }

  // client.close();
}

void main() {
  runApp(const MyApp());
  httptest();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
