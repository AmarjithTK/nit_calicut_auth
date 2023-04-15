import 'dart:html';
import 'dart:web_gl';

import 'package:nitcauthcli/nitcauthcli.dart' as nitcauthcli;
import 'dart:io';
import 'dart:convert';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'helpers.dart';

class NITAuthenticator {
  NITAuthenticator(this.passsword, this.username, this.preferences);
  final String username;
  final String passsword;
  final Map<String, String> preferences;

  // pref.lastTime
  // pref.timeout
  // pref.logouturl
  // pref.keepaliveurl
  // pref.baseurl

  void login() {
    return;
  }

  void logout() {
    // if(logged in and logout url is not present, send get request via keepalive)
    return;
  }

  void editUserCreds() {}

  void timer() {}
}

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

  // getLoginCreds();
  // printSeconds();

  DateTime dt1 = DateTime.parse("2023-04-13 11:47:00");
  String timeout = 650000.toString();
  int timeRemaining = isTimeoutOrNot(timeout, dt1);

  if (timeRemaining == 0) {
    print("Time remaining : 0, timeout");
  } else {
    print("Time remaining : $timeRemaining seconds");
  }
}

void getLoginCreds() async {
  //
  //
  var httpClient = HttpClient();
  String firstaddr = "http://apple.com";
  var fgauthregex = r"""http:\/\/[\d.]+:\d+\/fgtauth\?[a-zA-Z\d]+""";
  var baseurlregex = r"http:\/\/[\d.]+:\d+/";
  var logoutregex = r"""http:\/\/[\d.]+:\d+\/logout\?[a-zA-Z\d]+""";
  var keepaliveregex = r"""http:\/\/[\d.]+:\d+\/keepalive\?[a-zA-Z\d]+""";
  var timeoutregex = r"countDownTime=(\d+)";

  var firstpage = await getRequestHandler(httpClient, firstaddr, false);

  firstpage =
      'what the hell is coding life very weakening http://192.168.65.1:1000/fgtauth?45b7ca37e558ba9c this far is difficult';
  var fgurl = getRegexResponse(firstpage, fgauthregex, 0);
  print(fgurl);
  var baseurl = getRegexResponse(firstpage, baseurlregex, 0);

  // var baseurl = getBaseUrl(firstpage);
  if (fgurl == 'null') {
    // print("you are already connected or using a different network than NITC");
    // return;
  }
  // print(html);
  // var stringtest =
  //     'sdgasdghs  a "http://192.168.65.1:1000/fgtauth?45b7ca37e558ba9c" sdg';
  var fglink = 'https://starlighter4097.github.io/testing-props/';

  var loginpage = await getRequestHandler(
      httpClient, fglink, false); // change to fgurl when in use
  // print(loginpage);

  var payload = getParams(loginpage);

  // var loggedpage = postRequestHandler(httpClient, baseurl, false, payload);
  // above is working fine
  var loggedpageurl =
      'https://starlighter4097.github.io/testing-props/logout.html';

  var loggedpage = await getRequestHandler(httpClient, loggedpageurl, false);
  // print(loggedpage);

  // var logouturl = getLogoutUrl(loggedpage);

  var logouturl = getRegexResponse(loggedpage, logoutregex, 0);
  var keepaliveurl = getRegexResponse(loggedpage, keepaliveregex, 0);

  // var keepaliveurl = getKeepaliveUrl(loggedpage);
  // var timeout = getTimeout(loggedpage);
  var timeout = getRegexResponse(loggedpage, timeoutregex, 1);

  print(fgurl);
  print(baseurl);
  print(payload);

  print(logouturl);
  print(keepaliveurl);
  print(timeout);

  // if keepalive url to be used to get logout url and logout

  // print(fgrequest);

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
  httpClient.close();
}

// var loggedpageurl = getloggedpageurl('<a href="http://192.168.65.1:1000/logout?0b00020a0f1bafab"> logout </a>');
// print(loggedpageurl);

// class nitcauthcli

// write a function to extract the base url from the html page

// --- plan

// get the username password
// get the url,baseurl
//     if url not found then show already connect window
// get request to the fgauth page
// extract the params from fgauth page
// send the post request
// get the logged in page
// get the loggout url
// store all in shared preferences

// logout button
//   set a sample keepalive window url in the object modal
//   send get request and extract the loggout Url
//   send logout request

// class nitcauthcli

//   class values of shared prefs on initialisation

//   functions:

//     getcreds,editcreds
//     login,logout,timer
//     getbaseurl,getfgurl,getparams,getloggedpageurl,gettimeout,
//     getrequest,postrequest,
//     setprefs,getprefs,showresults,

//   get the timeout time and set the date and timeout,and predicted timeout into shared pref
//   when time << time.now() send logout and login request  simultaneously
//   check done each 5 seconds or more time if status == true || logged

//   getcreds function can check the sharedprefs and show dialog if required
