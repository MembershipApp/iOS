//global declaration for store lat and long value
window.getCurrentLat;
window.getCurrentLong;


/* Fetch Geolocation Data */
function getGeolcation() {
    navigator.geolocation.getCurrentPosition(onSuccess, onError);
}
/* onSuccess Callback for getCurrentPosition */
var onSuccess = function(position) {
    var geoLatitude=position.coords.latitude;
    var geoLongitude=position.coords.longitude;

    getCurrentLat=geoLatitude;
    getCurrentLong=geoLongitude;
    
    //store getCurrentLat,getCurrentLong
    localStorage.setItem('currentLat', getCurrentLat); //defining a local storage for login User
    localStorage.setItem('currentLong',getCurrentLong);//defining a local storage for remember me flag
};
/* onError Callback receives a PositionError object*/
function onError(error) {

}

// store location coordinates in local storage
function setGeoLocation(locationStr){
    
    var location_jsonObj = JSON.parse(locationStr);   //  json object
    
    localStorage.setItem('currentLat',location_jsonObj.Latitude);
    localStorage.setItem('currentLong',location_jsonObj.Longitude);
}