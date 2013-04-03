//login header template

window.loginHeaderTmpl = '<div id="LoginHeader">'+
'<label id="Controltxt">Control</label><label id="Riskstxt">Risks</label>'+
'<label>13-12-2012</label>'+
'<label id="internationaltxt">International</label><br/>'+
'<label id="SOStxt">SOS</label>'+
'</div>';


window.videoTmpl =  '<div id="videotour">'+
'<video src="movie.mp4" controls="true" type="video/mp4">'+
'<br/>'+
'<label>Play video to learn more about International SOS Membership App</label>'+
'</div>';

window.loginFormTmpl = '<div id="LoginContent">'+
'<div>'+
'<label>Please enter your International SOS Membership Number provided by your organizatioin </label>'+
'<input type="text" value="iostest1" id="membership_id" required />'+
'</div>'+
'<div id="rememberme">'+
'<input type="checkbox" id="remembermecheckbox"/>'+
'<label>Remember Me</label>'+
'<br/>'+
'</div>'+
'<div id="btnloginhelp">'+
'<button id="loginBtn" onclick="loginBtnEvent()">Login</button>'+
'<button id="helpBtn" onclick="helpBtnEvent()">Help</button>'+
'</div>'+
'</div>';

var externalUrl= "http://mobile.usablenet.com/mt/www.internationalsos.com/MasterPortal/default.aspx?templatemembnum=11BWEB000048&membnum=14AYCA000033&membershiptype=comp&content=landing&countryid=111";

window.dashBoardTmpl =  '<!-- <div id="dashboardPage" style="float:left; left:100%;"> -->'+
'<div id="LoginHeader">'+
'<label id="Controltxt">Control</label><label id="Riskstxt">Risks</label>'+
'<label id="internationaltxt">International</label><br/>'+
'<label id="SOStxt">SOS</label>'+
'</div>'+


'<table id="changelocation">'+
'<tr>'+

'<td >'+
'<!-- '+
'<img src="images/netherland_flag_on.jpg" /> -->'+
'</td>'+


'<td> <label id="smalltext">We have detected You\'re in</label> <br/> <label id="countryName"></label></td>'+
'<td onclick="comingFeature()">CHANGE<br/>LOCATION</td>'+
'<td><img src="images/changelocationarrow.png" /></td>'+
'</tr>'+

'</table>'+


'</div>'+
'<div id="dashboarditems">'+

'<ul id="AlertsGuides">'+
'<li><a href="#/alertIn" onClick="onAlertClick()" class="ui-link"><img src="images/alert.png" />'+
'<br/>'+
'<label>ALERTS</label></a>'+
'</li>'+
'<li>'+
'<a href="#" onclick="getExternalLink(externalUrl)" class="ui-link"> <img src="images/guide.png" />'+
'<br/>'+
'<label>GUIDES</label>'+
'</a>'+
'</li>'+
'</ul>'+
'<ul id="CheckinClinic">'+
'<li>'+
'<a href="#/checkIn" class="ui-link"><img src="images/checkin.png" />'+
'<br/>'+
'<label>CHECK IN</label></a>'+
'</li>'+
'<li>'+
'<a href="#" onclick="getExternalLink(externalUrl)" class="ui-link">'+
'<img src="images/clinic.png" />'+
'<br/>'+
'<label>CLINICS</label>'+
'</a>'+
'</li>'+
'</ul>'+
'</div>'+
'<div data-role="footer" data-position="fixed" data-iconpos="top" class="ui-footer ui-bar-a ui-footer-fixed slideup" role="contentinfo">'+
'<div data-role="navbar" role="navigation" class="ui-navbar ui-mini">'+
'<ul class="ui-grid-d">'+
'<li class="ui-block-a"><a href="#" onclick="comingFeature()" data-corners="false" data-shadow="false" data-iconshadow="true" data-wrapperels="span" data-theme="a" data-inline="true" class="ui-btn ui-btn-inline ui-btn-hover-a"><span class="ui-btn-inner"><span class="ui-btn-text"><img src="images/location.png"> <br>Location</span></span></a></li>'+
'<li class="ui-block-b"><a href="#" onclick="comingFeature()" data-corners="false" data-shadow="false" data-iconshadow="true" data-wrapperels="span" data-theme="a" data-inline="true" class="ui-btn ui-btn-up-a ui-btn-inline"><span class="ui-btn-inner"><span class="ui-btn-text"><img src="images/globalpulse.png"> <br> Global Pulse</span></span></a></li>'+
'<li class="ui-block-c"><a href="#" onclick="comingFeature()" data-corners="false" data-shadow="false" data-iconshadow="true" data-wrapperels="span" data-theme="a" data-inline="true" class="ui-btn ui-btn-up-a ui-btn-inline"><span class="ui-btn-inner"><span class="ui-btn-text"><img src="images/call.png"><br> Call Us</span></span></a></li>'+
'<li class="ui-block-d"><a href="#" onclick="comingFeature()" data-corners="false" data-shadow="false" data-iconshadow="true" data-wrapperels="span" data-theme="a" data-inline="true" class="ui-btn ui-btn-up-a ui-btn-inline"><span class="ui-btn-inner"><span class="ui-btn-text"><img src="images/settings.png"><br>Settings</span></span></a></li>'+
'<li class="ui-block-e"><a href="#" onclick="comingFeature()" data-corners="false" data-shadow="false" data-iconshadow="true" data-wrapperels="span" data-theme="a" data-inline="true" class="ui-btn ui-btn-up-a ui-btn-inline"><span class="ui-btn-inner"><span class="ui-btn-text"><img src="images/more.png"><br>More</span></span></a></li>'+
'</ul>'+
'</div>'+
'</div>';



window.alertInTmpl = '<section data-role="header" data-position="inline" >'+
'<div id="CheckinHeader">'+
'<a onclick="window.history.back()">'+
'<div class="backbutton" >'+
'<div>'+
'<span></span>'+
'</div>'+
'<p onclick="onBackButton()">Back</p>'+
'</div>'+
'</a>'+
'<p>Alerts</p>'+
'</div>'+
'</section>'+
'<!-- End Header -->'+
'<!-- Begin Main Content -->'+
'<section class="AlertsSubheader">'+
'<!--'+
'<img src="images/netherland_checkin_flag.gif" />'+
'<h3>Netherlands</h3>'+
'-->'+
'</section>'+
'<div class="content-primary" id="alertWrapper">'+
'<ul data-role="listview" id="datalist" style="margin-left:0px;">'+
'</ul>'+
'</div>';

window.checkInTmpl = '<section data-role="header" data-position="inline" >'+
'<div id="CheckinHeader">'+
'<a onclick=\'manualCheckinFlag="false"; window.history.back()\'>'+
'<div class="backbutton">'+
'<div>'+
'<span></span>'+
'</div>'+
'<p>Back</p>'+
'</div>'+
'</a>'+
'<p>Check In</p>'+
'</div>'+
'</section>'+
'<!-- End Header -->'+
'<!-- Begin Main Content -->'+
'<!-- Map Content -->'+
'<div>'+

'<div id="map_canvas" style="height:200px"></div>'+

'</div>'+
'<div id="CheckinLocationDetails">'+
'<!--'+
'<div id="CheckinLocationName">'+

'<h1>The Netherlands</h1>'+
'<h2>Veenendaal</h2>'+

'</div>'+

'<img src="images/netherland_checkin_flag.gif" />'+
'-->'+
'<div id="locationHeader">'+
'<strong>Location: </strong>'+

'<label id="country"> </label><br/>'+
'Latitude: <label id="latitudeValue"> </label><br/>'+
'Longitude: <label id="longitudeValue"></label>'+
'</div>'+

'<div id="btnCheckIn">'+
'<a onclick="onCheckInClick()">Check In Here</a>'+
'</div>';

window.checkinSuccessfulTmpl='<div  id="CheckinSuccessful" data-position="fixed" >'+
'<img src="images/check.png" />'+
'<p>You\'ve successfully checked in.</p>'+
'<a onclick="successCheckIn()">Done</a>'+
'</div>';




