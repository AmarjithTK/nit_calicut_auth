import 'dart:html';
import 'dart:web_gl';

import 'package:nitcauthcli/nitcauthcli.dart' as nitcauthcli;
import 'dart:io';
import 'dart:convert';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

void main(List<String> arguments) {
  // print('Hello world: ${nitcauthcli.calculate()}!');

  // print('hello');

  // var url =
  //     'sdgasdghs  a "http://192.168.65.1:1000/fgtauth?45b7ca37e558ba9c" sdg';

  // var webAddressPattern = RegExp(r'http:\/\/[\d.]+:\d+\/');
  // var webAddressMatch = webAddressPattern.firstMatch(url);
  // var secureKeyMatch = secureKeyPattern.firstMatch(html);

  // if (webAddressMatch != null) {
  //   // print('object');
  //   var baseurl = webAddressMatch.group(0);
  //   print(baseurl);
  // }

  getSecurekey();
}

Future<String> getRequestHandler(
    HttpClient client, String addr, bool redirect) async {
  client.connectionTimeout = Duration(seconds: 2);
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
  client.connectionTimeout = Duration(seconds: 2);
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

void getSecurekey() async {
  var httpClient = HttpClient();

  String firstaddr = "http://apple.com";

  var firstpage = await getRequestHandler(httpClient, firstaddr, false);
  // print(html);
  // var stringtest =
  //     'sdgasdghs  a "http://192.168.65.1:1000/fgtauth?45b7ca37e558ba9c" sdg';

  var webAddressPattern =
      RegExp(r"""http:\/\/[\d]+.[\d]+.[\d]+.[\d]+:[\d]+\/[^'\\"]*""");
  // var webAddressPattern = RegExp(r"""http:\/\/.+[^'\\"]*""");

  var webAddressMatch = webAddressPattern.firstMatch(firstpage);
  // var secureKeyMatch = secureKeyPattern.firstMatch(html);

  if (webAddressMatch != null) {
    // print('object');
    var baseurl = webAddressMatch.group(0);
    print(baseurl);

    var loginpage =
        await getRequestHandler(httpClient, baseurl.toString(), false);
    print(loginpage);
    // print(fgrequest);
  } else {
    print("you are already connected or using a different network than NITC");
  }

  //http:\/\/[\d]+.[\d]+.[\d]+.[\d]+:[\d]+\/[^'\\"]*

  // var document = parse(html);
  // List<dynamic> links = document.getElementsByTagName('a');

  // for (var link in links) {
  //   String href = link.attributes['href'];
  //   print(href);
  // }
  // List<dynamic> urls = links.map((link) => link.attributes['href']).toList();
  // print(urls);
  // var fgauthregex = RegExp();
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

  print(magic);
  print(tredir);
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




//plan

get the username password
get the url,baseurl 
    if url not found then show already connect window
get request to the fgauth page 
extract the params from fgauth page
send the post request
get the logged in page 
get the loggout url
store all in shared preferences 

logout button 
  set a sample keepalive window url in the object modal 
  send get request and extract the loggout Url
  send logout request


class nitcauthcli

  class values of shared prefs on initialisation

 
  functions: 

    getcreds,editcreds
    login,logout,timer
    getbaseurl,getfgurl,getparams,getlogouturl,gettimeout,
    getrequest,postrequest,
    setprefs,getprefs,showresults,
  

  get the timeout time and set the date and timeout,and predicted timeout into shared pref 
  when time << time.now() send logout and login request  simultaneously
  check done each 5 seconds or more time if status == true || logged

  getcreds function can check the sharedprefs and show dialog if required