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
  request.followRedirects = false;
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
    HttpClient client, String addr, bool redirect, dynamic requestbody) async {
  client.connectionTimeout = Duration(seconds: 3);
  var url = Uri.parse(addr);
  var request = await client.postUrl(url);
  request.headers
      .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
  request.write(requestbody);

  final response = await request.close();
  // request.headers.add(HttpHeaders.upgradeHeader, '1');
  // request.headers.add(HttpHeaders.acceptEncodingHeader, 'gzip');
  request.followRedirects = false;
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

// write a function to send post request to baseurl with payload from the getparams function

Map<String, String> getParams(String responseBody) {
  String username = 'abhishek_b220631ee';
  String password = 'B220631EE';

  // print(baseurl.toString());

  // print(response.body);

  var parsed = parse(responseBody);

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
    "passsword": password,
    "4Tredir": tredir,
    "magic": magic
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
