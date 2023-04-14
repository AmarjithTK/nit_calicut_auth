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

void getParams(String link) async {
  String username = 'abhishek_b220631ee';
  String password = 'B220631EE';
  String? baseurl;
  RegExp regex = RegExp(r'http:\/\/[\d.]+:\d+');

  var regexmatch = regex.firstMatch(link);

  if (regexmatch != null) {
    print('object');
    baseurl = regexmatch.group(0);
    print(baseurl);
  }
  // print(baseurl.toString());

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

  // client exception connection reset by peer

  client = http.Client();

  var loginresponse = await client.post(Uri.parse(baseurl), body: {
    "username": username,
    "passsword": password,
    "4Tredir": tredir,
    "magic": magic
  });
}
