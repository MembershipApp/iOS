//Called after checkin button clicked
function onCheckInClick()
{
    flag=false; //  Boolean used to render dashboard
    manualCheckinFlag = true; // Boolean used to manage check-in screen
    var checkinUser=localStorage.getItem('currentUserName');
    var checkinToken=localStorage.getItem('fetchCheckinToken');
    var checkinLat=localStorage.getItem('currentLat');
    var checkinLong=localStorage.getItem('currentLong');
    //called checkin function
    checkinService(checkinUser,checkinToken,checkinLat,checkinLong);
}

function successCheckIn(){
    manualCheckinFlag=false;
    $("#CheckinSuccessful").remove();
    $("#btnCheckIn").css("display","block");
}