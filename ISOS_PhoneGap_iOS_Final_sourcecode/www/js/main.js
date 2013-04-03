window.isLogin = 0;
var AppRouter = Backbone.Router.extend({
    routes: {
       ""  : "home",
       "alertIn" : "alertIn",
       "checkIn" : "checkIn"
         },
       home: function ()
       {
           //alert("home render");
           if(isLogin == "0"){
               $('#wrapper').append(new loginHeaderView().render() );
               $('#wrapper').append(new videoView().render() );
               $('#wrapper').append(new loginView().render() );
           }
           else{
                new dashBoardView();
           }
       },
      
       
       
       alertIn: function()
       {
                                       flag=false;
           getGoogleAnalyticsTrackPageView("/Alert Screen");
           $("#wrapper").fadeOut("fast",function(){
                 alertview = new alertView();

           var parsedJson;
           var cnt=0;

           parsedJson = JSON.parse(localStorage.getItem("notificationAlert"));

           if(parsedJson!=null)
           {
                cnt = eval(parsedJson).length;
            }

           var str='';
           
           for(var i=0;i<cnt;i++){
               var li_element = parsedJson[i].Message;
               var p_element = parsedJson[i].Date;

             str += "<div class=\"format-row\"><div class=\"plus-sign-orange\">"+"<img src=\"images/Plus__Orange.png\"/></div>"+"<div class='message-text'><p>"+ li_element +"</p>"+"<p>"+ p_element + "</p></div></div>";
                                 
           }
             var width1 = $('body').width();
             
             $("#datalist").html(str);
             $('.format-row').width(width1); 
             setTimeout(function(){
                        
            $('.plus-sign-orange').css('height', $('.format-row').height());
                        
                },0);
                                 });
       },
       
       checkIn: function()
       {
            $("#wrapper").fadeOut("fast",function(){
                 var checkin = new checkInView();
            });
            getGoogleAnalyticsTrackPageView("/Check-in Screen");                           
       }
                                       
});
// Instantiation of AppRouter
app = new AppRouter();
Backbone.history.start();