//  r"countDownTime=(\d+)"

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:html/parser.dart';

int isTimeoutOrNot(String timeout, DateTime lastlogin) {
  // Get current time in nanoseconds
  // int microSecondsNow = DateTime(Date).millisecondsSinceEpoch;

  // DateTime dt1 = DateTime.parse("2023-04-13 11:47:00");
  DateTime now = DateTime.now();

  var diff = now.difference(lastlogin);
  // print(diff.inDays);
  if (diff.inSeconds > int.parse(timeout)) {
    return 0;
  }
  return diff.inSeconds;
  //   var diffString =
  //       "${diff.inMinutes} minutes ${diff.inSeconds} seconds till timeout";
  // print(diffString);
}

Future<String> getRequestHandler(
    HttpClient client, String addr, bool redirect) async {
  client.connectionTimeout = Duration(seconds: 3);
  var url = Uri.parse(addr);
  var request = await client.getUrl(url);
  // request.headers.add(HttpHeaders.upgradeHeader, '1');
  // request.headers.add(HttpHeaders.acceptEncodingHeader, 'gzip');
  request.followRedirects = redirect;
  var response = await request.close();
  var responseBody = await response.transform(utf8.decoder).join();

  // var response = await request.close();
  // var bytes = await response.transform(gzip.decoder).toList();
  // var flattenedBytes = await response.expand((byteList) => byteList).toList();
  // var flattenedBytes =
  //     await response.expand<List<int>>((byteList) => byteList).toList();
  // var flattenedBytes = await response.expand(convert).toList();
  // var html = utf8.decode(flattenedBytes);

  return responseBody.toString();
}

Future<String> postRequestHandler(
    HttpClient client, String addr, bool redirect, dynamic requestbody,headers) async {

var url = Uri.parse(addr);
var request = await client.postUrl(url);

// var request = await client.postUrl(Uri.parse(url));                                                                    
headers.forEach((name, value) => request.headers.set(name, value));
   var payload = json.encode(requestbody);                                                                           
   request.write(payload);                                                                                                
   var response = await request.close();                                                                                  
   var responseBody = await response.transform(utf8.decoder).join();                                                      
   print(responseBody);                                              

  return responseBody;
//   client.connectionTimeout = Duration(seconds: 10);
//   var url = Uri.parse(addr);
//   // client.allowLegacyUnsafeRenegotiation =true
//   var request = await client.postUrl(url);
//   var jsonPayload = utf8.encode(json.encode(requestbody));
//     // request.followRedirects = redirect;
// // request.headers.set('Accept', 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng');
    // request.headers.set('Accept-Encoding', 'gzip, deflate');
//     // request.headers.set('Accept-Language', 'en-GB,en-US;q=0.9,en;q=0.8');
//     request.headers.set('Cache-Control', 'max-age=0');
//     request.headers.set('Connection', 'keep-alive');
//     // request.headers.set('Content-Length', '104');
//     // request.headers.set('Content-Type', 'application/x-www-form-urlencoded');
//     // request.headers.set('Host', '192.168.65.1:1000');
//     // request.headers.set('Origin', 'http://192.168.65.1:1000');
//     request.headers.set('Referer', fgurl!);
//     request.headers.set('Upgrade-Insecure-Requests', '1');
//     request.headers.set('User-Agent', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36');
// // Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,
// // Accept-Encoding: gzip, deflate
// // Accept-Language: en-GB,en-US;q=0.9,en;q=0.8
// // Cache-Control: max-age=0
// // Connection: keep-alive
// // Content-Length: 104
// // Content-Type: application/x-www-form-urlencoded
// // Host: 192.168.65.1:1000
// // Origin: http://192.168.65.1:1000
// // Referer: http://192.168.65.1:1000/fgtauth?52156589e9a7881c
// // Upgrade-Insecure-Requests: 1
// // User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36

// // Connection: keep-alive' -H 'Cache-Control: max-age=0' -H 'Origin: ${web_address}' -H 'Upgrade-Insecure-Requests: 1' -H 'Referer: ${web_address}fgtauth?${secure_key}' --compressed

//   print(jsonPayload);
//   // request.headers
//       // .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
//   request.add(jsonPayload);

//   // request.headers.add(HttpHeaders.upgradeHeader, '1');
//   // request.headers.add(HttpHeaders.acceptEncodingHeader, 'gzip');


//     var response = await request.close();

//   var responseBody = await response.transform(utf8.decoder).join();

//   // var response = await request.close();
//   // var bytes = await response.transform(gzip.decoder).toList();
//   // var flattenedBytes = await response.expand((byteList) => byteList).toList();
//   // var flattenedBytes =
//   //     await response.expand<List<int>>((byteList) => byteList).toList();
//   // var flattenedBytes = await response.expand(convert).toList();
//   // var html = utf8.decode(flattenedBytes);

//   return responseBody.toString();
}

// write a function to send post request to baseurl with payload from the getparams function

Map<String, String> getParams(String responseBody) {
  String username = 'abhishek_b220631ee';
  String password = 'B220631EE';

  // print(baseurl.toString());

  // print(response.body);

  var parsed = parse(responseBody);

  print(responseBody);


  List<dynamic> inputs = parsed.getElementsByTagName('input');
  String magic = 'none';
  String tredir = 'none';

  for (var input in inputs) {
    var name = input.attributes['name'];

    if (name == '4Tredir') {
      tredir = input.attributes['value'];
    } else if (name == 'magic') {
      magic = input.attributes['value'];
    }
  }

  var payload = {
    "username": username,
    "password": password,
    "magic": magic,
    "4Tredir": tredir
  };

  return payload;
}

String? getRegexResponse(String body, String regex, int matchgroup) {
  // String rawString = 'r"""${regex}"""';
  // print(rawString);
  var webAddressPattern = RegExp(regex);
  // var webAddressPattern = RegExp(r"""http:\/\/.+[^'\\"]*""");

  var webAddressMatch = webAddressPattern.firstMatch(body);
  // var secureKeyMatch = secureKeyPattern.firstMatch(html);
  var baseurl;
  if (webAddressMatch != null) {
    // print(baseurl);
    baseurl = webAddressMatch.group(matchgroup);
    return baseurl;

    // print(baseurl!);
  }
  return 'null';
}
