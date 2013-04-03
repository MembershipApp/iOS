
window.loginUser;
var setToken; //variable for token value
var setGeoLat; //variable for lat and long
var setGeoLong;
var setCheckinToken; //variable for checkin token
var flag=true; //variable for dashboard page
window.manualCheckinFlag=false;

function loginBtnEvent(){
    var membership_id = document.getElementById("membership_id").value;
    var remembermeflag=document.getElementById("remembermecheckbox").checked;
    //fetch token value
    setToken=token;
    loginUser=membership_id;
    if(loginUser){
        //Call Web Service
        var loginDict = {membershipID:membership_id,DeviceToken:setToken,method:"login"};
//        callWebService(membership_id,setToken);
        invokeWebService(loginDict);
        
        //fetch remember me
//        rememberMECheckbox(remembermeflag,membership_id);
        
    }else{
        alert("Please Enter Membership Number");
    }
    
}

//checkin function
function checkinService(userName,fetchToken,currentLat,currentLong){
    var checkinOptions = {UserName:userName,DeviceToken:fetchToken,Latitude:currentLat,Longitude:currentLong,method:"checkin"};
//    var checkinOptions = {UserName:userName,DeviceToken:fetchToken,Latitude:"0.0000",Longitude:"0.0000",method:"checkin"};
    invokeWebService(checkinOptions);
}

//method for daskboard page
function dashboardPage(){
    //called dashboard screen
   
    $("#wrapper").fadeOut("fast",function(){
          var _dashBoard = new dashBoardView();
    });
}

//store username,token
function storeDataToLocalStorage(currentLoginUser,fetchToken)
{
    localStorage.setItem('currentUserName', currentLoginUser); //defining a local storage for login User
    localStorage.setItem('fetchCheckinToken',fetchToken);//defining a local storage for remember me flag
}

//  Removed 'Remember Me' feature

/*
//method for remember me
function rememberMECheckbox(memberIDFlag,activeUserName)
{
    
    if(memberIDFlag)
    {
        localStorage.setItem('userName', activeUserName); //defining a local storage for username
        localStorage.setItem('rememberMe',memberIDFlag);//defining a local storage for remember me flag
    }else
    {
        localStorage.removeItem('userName'); //remove value from local storage if checkbox is not select
        localStorage.removeItem('rememberMe'); //remove value local storage  if checkbox is not select
    }
}
*/

function getRememberValue()
{
    var getRememberMeFlagValue=localStorage.getItem('rememberMe');
    if(getRememberMeFlagValue)
    {
        var getUserName=localStorage.getItem('userName');
        document.getElementById("membership_id").value=getUserName;
        document.getElementById("remembermecheckbox").checked=getRememberMeFlagValue;
    }
}

function notificationCallback(jsonstr){
    localStorage.setItem("notificationAlert",jsonstr);
}

function regionNotificationCallback(regionMessage){
    //region changed current location
    
    //  Extract location retrieved from Native code
    
    setGeoLocation(regionMessage); // store location coordinates in local storage
    
    var checkinUser=localStorage.getItem('currentUserName');
    var checkinToken=localStorage.getItem('fetchCheckinToken');
    
    var checkinLat=localStorage.getItem('currentLat');
    var checkinLong=localStorage.getItem('currentLong');
    
    //dashboard flag
    flag=false;
    
    //called checkin
    checkinService(checkinUser,checkinToken,checkinLat,checkinLong);

}
function helpBtnEvent(){
    comingFeature();
}
