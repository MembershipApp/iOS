window.token; //global declaration for store token value

//getting token from iOS native 
function getTokenValue(returnSuccessAPN)
{
    PushNotification.getRegisterDevice(nativePluginResultHandlerAPN,nativePluginErrorHandlerAPN,returnSuccessAPN);
}

//Sucess Notification Token
function nativePluginResultHandlerAPN (notificationToken) {
	token=notificationToken;
}
//Failure Notification Token
function nativePluginErrorHandlerAPN (error) {
}   

//called for geofencing
function getGeofencing(returnSuccessGeofencing)
{
    Geofencing.getgeofencingLocationUpdates(nativePluginResultHandlergetGeofencing,nativePluginErrorHandlergetGeofencing,returnSuccessGeofencing);
}
//Sucess Geofencing
function nativePluginResultHandlergetGeofencing (geoToken) {
}
//Failure Geofencing
function nativePluginErrorHandlergetGeofencing(error) {
}


//Called Google Analytics

function getGoogleAnalytics(returnSuccessGoogleAnalytics)
{
    GoogleAnalytics.getGoogleAnalytics(nativePluginResultHandlergetGoogleAnalytics,nativePluginErrorHandlergetGoogleAnalytics,returnSuccessGoogleAnalytics);
}

//Sucess Geofencing
function nativePluginResultHandlergetGoogleAnalytics (getGoogleAnalyticsSucess) {
    
}

//Failure Geofencing
function nativePluginErrorHandlergetGoogleAnalytics(getGoogleAnalyticsError) {
    //alert("GeoToken ERROR: \r\n"+error );
}

//Called Google Analytics Track Event
function getGoogleAnalyticsTrackEvent(returnSuccessGoogleAnalyticsTrackEvent)
{
    GoogleAnalyticsTrackEvent.getGoogleAnalyticsTrackEvent(successGooleAnalyticsTrackEvent,failedGooleAnalyticsTrackEvent,returnSuccessGoogleAnalyticsTrackEvent);
}

function successGooleAnalyticsTrackEvent(sucessTrackEvent)
{

}
function failedGooleAnalyticsTrackEvent(failedTrackEvent)
{
    
}


//Called Google Analytics Track View
function getGoogleAnalyticsTrackPageView(returnSuccessGoogleAnalyticsTrackEventPageView)
{
    GoogleAnalyticsTrackPageview.getGoogleAnalyticsTrackPageview(successGooleAnalyticsTrackPageView,failedGooleAnalyticsTrackPageView,returnSuccessGoogleAnalyticsTrackEventPageView);
}

function successGooleAnalyticsTrackPageView(sucessTrackPageView)
{
    
}
function failedGooleAnalyticsTrackPageView(failedTrackPageView)
{
    
}

function invokeWebService(returnSuccessResponse){
    InvokeWebService.webServiceCallFromNative(successServiceHandler,errorServiceHandler,returnSuccessResponse);
}

function successServiceHandler(successResponse){
    
    var checkinLat =localStorage.getItem('currentLat');
    var checkinLong =localStorage.getItem('currentLong');

    if(successResponse.method == "login"){
        
        isLogin = 1;
        //called to bodyload.js for location updates
        getGeofencing('geofacing');
                
        //  new account created on Google analytics
        getGoogleAnalytics("UA-36813559-2");
        
        //Google Analytics Track Event
        var options = {category:"GA category",action:"GA action",label:"GA label",value:666};
        getGoogleAnalyticsTrackEvent(options);
        
        //Google Analytics Track Page View
        getGoogleAnalyticsTrackPageView("/test");
        
        //daskboard page
        storeDataToLocalStorage(successResponse.membershipID,successResponse.DeviceToken);
        
        //onCheckInClick();
        var checkinUser=localStorage.getItem('currentUserName');
        var checkinToken=localStorage.getItem('fetchCheckinToken');
        
        //dashboard flag
        flag=true;
        
        //called checkin
        checkinService(checkinUser,checkinToken,checkinLat,checkinLong);
    }
    else if(successResponse.method == "checkin"){
        if(flag==true){
            
            dashboardPage();
        }
        
        // Handling invalid geolocation coordinates
       
        if(manualCheckinFlag==true && (successResponse.Latitude!="0.0000" || successResponse.Longitude!="0.0000")){
            $("#btnCheckIn").css("display","none");
            var temp =  _.template(checkinSuccessfulTmpl);
            $("#wrapper").append(temp);
            manualCheckinFlag=false;
        }
        
        var lat = document.getElementById("latitudeValue");
        lat.innerHTML=checkinLat;
        var longi = document.getElementById("longitudeValue");
        longi.innerHTML=checkinLong;
    }

}

function errorServiceHandler(errorResponse){
    if(errorResponse.method=="login"){
        navigator.notification.alert("Invalid membership id",errCallBack,'International SOS',"OK");
        
        function errCallBack(){
            
        }
    }
}

function comingFeature(){
    
    navigator.notification.alert(
                                 "This feature is coming soon!",
                                 callBackFunctionB, // Specify a function to be called
                                 'International SOS',
                                 "OK"
                                 );
    function callBackFunctionB(){
    }
}

// Open External Link in Child Browser
function getExternalLink(returnExternalLink)
{
    ChildBrowser.getExternalLink(successExternalLink,failedExternalLink,returnExternalLink);
}

function successExternalLink(sucessExternalLink)
{
    
}
function failedExternalLink(failedExternalLink)
{
    
}

//  Retrieve GeoLocation from native

function getGeoLocationFromNative(returnGeoLocation){
    
}