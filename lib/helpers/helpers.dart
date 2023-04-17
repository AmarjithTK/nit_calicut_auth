// import 'dart:html';
// import 'dart:html';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';
import 'package:html/dom_parsing.dart';

import 'dart:convert';
import 'dart:io';
// socket exception should be handled carefully
///
///
///
///  your network is unstable ,,, please check that
///
///
///
///
///
///

Future<String?> getLoginUrl() async {
  final client = HttpClient();
  String? location = 'google.com';
  var uri = Uri.parse("http://google.co.in");
  var request = await client.getUrl(uri);
  request.followRedirects = false;
  var response = await request.close();
  // print(response.statusCode);
  while (response.isRedirect) {
    location = response.headers.value(HttpHeaders.locationHeader);
    response.drain();

    print(location);
    if (location != null) {
      uri = uri.resolve(location);
      request = await client.getUrl(uri);
      // Set the body or headers as desired.
      request.followRedirects = false;
      response = await request.close();
    }
  }

  client.close();

  return location;
}

void getParams(String link) async {
  String username = 'abhishek_b220631ee';
  String password = 'B220631EE';
  String? baseurl;
  RegExp regex = RegExp(r'http:\/\/[\d.]+:\d+');

  var regexmatch = regex.firstMatch(link);
  print(regexmatch);

  if (regexmatch != null) {
    print('object');
    baseurl = regexmatch.group(0);
    print(baseurl);
  }
  // print(baseurl.toString());

  var client = http.Client();

  var response = await client.get(Uri.parse(link));
  // print(response.body);

  var parsed = parse(response.body);

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

  print(magic);
  print(tredir);
  baseurl = baseurl! + '/';

  client.close();

  // client exception connection reset by peer

  client = http.Client();

  var loginresponse = await client.post(Uri.parse(baseurl), body: {
    "username": username,
    "passsword": password,
    "4Tredir": tredir,
    "magic": magic
  });
  client.close();

  print(loginresponse.body);
}

void getsecurekey() async {
  var httpClient = HttpClient();
  httpClient.connectionTimeout = Duration(seconds: 3);
  var url = Uri.parse('http://www.gstatic.com/generate_204');
  var request = await httpClient.getUrl(url);
  // request.headers.add(HttpHeaders.upgradeHeader, '1');
  request.headers.add(HttpHeaders.acceptEncodingHeader, 'gzip');
  request.followRedirects = false;
  var response = await request.close();
  // var bytes = await response.transform(gzip.decoder).toList();
  var flattenedBytes = await response.expand((byteList) => byteList).toList();
  var html = utf8.decode(flattenedBytes);

  print(html);

  var webAddressPattern = RegExp(r'http:\/\/[\d.]+:\d+');
  var secureKeyPattern = RegExp(r'\?(.*?)">');

  var webAddressMatch = webAddressPattern.firstMatch(html);
  var secureKeyMatch = secureKeyPattern.firstMatch(html);

  if (webAddressMatch != null) {
    print('object');
    var baseurl = webAddressMatch.group(0);
    print(baseurl);
  }

  


  print(webAddressMatch);
  if (webAddressMatch == null || secureKeyMatch == null) {
    print('Failed to extract web address and/or secure key');
    return;
  }

  var webAddress = webAddressMatch.group(0)!;
  var secureKey = secureKeyMatch.group(1);

  var authUrl = Uri.parse('$webAddress/fgtauth?$secureKey');
  var authRequest = await httpClient.getUrl(authUrl);
  var authResponse = await authRequest.close();
  await authResponse.drain();
}
