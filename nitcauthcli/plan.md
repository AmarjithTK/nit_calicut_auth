// --- plan

// get the username password
// get the url,baseurl  done
//     if url not found then show already connect window
// get request to the fgauth page  done 
// extract the params from fgauth page done
// send the post request done
// get the logged in page  done
// get the loggout url done
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
//     getbaseurl,getfgurl,getparams,getlogouturl,gettimeout,
//     getrequest,postrequest,
//     setprefs,getprefs,showresults,
  

//   get the timeout time and set the date and timeout,and predicted timeout into shared pref 
//   when time << time.now() send logout and login request  simultaneously
//   check done each 5 seconds or more time if status == true || logged

//   getcreds function can check the sharedprefs and show dialog if required


// location.href = new keepalive window


// option to change username and password

// add speedo meter within app