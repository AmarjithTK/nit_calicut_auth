//  r"countDownTime=(\d+)"

import 'dart:convert';
import 'dart:io';

import 'package:html/parser.dart';

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

String? getBaseUrl(String body) {
  String? baseurl;
  RegExp regex = RegExp(r'http:\/\/[\d.]+:\d+/');

  var regexmatch = regex.firstMatch(body);

  if (regexmatch != null) {
    print('object');
    baseurl = regexmatch.group(0);
    print(baseurl);
    return baseurl;
  }

  return 'null';

  /// standard to have null as output
}

String getFgUrl(String body) {
  var webAddressPattern =
      RegExp(r"""http:\/\/[\d.]+:\d+\/fgauth\?[a-zA-Z\d]+""");
  // var webAddressPattern = RegExp(r"""http:\/\/.+[^'\\"]*""");

  var webAddressMatch = webAddressPattern.firstMatch(body);
  // var secureKeyMatch = secureKeyPattern.firstMatch(html);

  if (webAddressMatch != null) {
    // print('object');
    var fgurl = webAddressMatch.group(0);
    print(fgurl);

    return fgurl!;
  } else {
    print("you are already connected or using a different network than NITC");
    return "null";
  }
}

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

    // if (name != null) {
    //   print(name);
    // }
    // print(input);
  }

  // print(magic);
  // print(tredir);
  // baseurl = baseurl! + '/';

  // client exception connection reset by peer

  // client = http.Client();

  var payload = {
    "username": username,
    "passsword": password,
    "4Tredir": tredir,
    "magic": magic
  };

  return payload;
}

//  http://192.168.65.1:1000/logout?0b00020a0f1bafab url to be extracted is similar to this match whole string with regex till quotes
String getLogoutUrl(String body) {
  var webAddressPattern =
      RegExp(r"""http:\/\/[\d.]+:\d+\/logout\?[a-zA-Z\d]+""");
  // var webAddressPattern = RegExp(r"""http:\/\/.+[^'\\"]*""");

  var webAddressMatch = webAddressPattern.firstMatch(body);
  // var secureKeyMatch = secureKeyPattern.firstMatch(html);
  var baseurl;
  if (webAddressMatch != null) {
    // print('object');
    baseurl = webAddressMatch.group(0);
    // print(baseurl!);
  }
  return baseurl;

  /// standard to have null as output
}

String getKeepaliveUrl(String body) {
  var webAddressPattern =
      RegExp(r"""http:\/\/[\d.]+:\d+\/keepalive\?[a-zA-Z\d]+""");
  // var webAddressPattern = RegExp(r"""http:\/\/.+[^'\\"]*""");

  var webAddressMatch = webAddressPattern.firstMatch(body);
  // var secureKeyMatch = secureKeyPattern.firstMatch(html);
  var baseurl;
  if (webAddressMatch != null) {
    // print('object');
    baseurl = webAddressMatch.group(0);
    // print(baseurl!);
  }
  return baseurl;

  /// standard to have null as output
}

String getTimeout(String body) {
  var webAddressPattern = RegExp(r"countDownTime=(\d+)");
  // var webAddressPattern = RegExp(r"""http:\/\/.+[^'\\"]*""");

  var webAddressMatch = webAddressPattern.firstMatch(body);
  // var secureKeyMatch = secureKeyPattern.firstMatch(html);
  var baseurl;
  if (webAddressMatch != null) {
    // print('object');
    baseurl = webAddressMatch.group(1);
    // print(baseurl!);
  }
  return baseurl;

  /// standard to have null as output
}
