var bingUrl = "https://source.unsplash.com/category/nature/" + window.innerWidth + "x" + window.innerHeight;

$.ajax({
    url : bingUrl,
    type: 'GET',
    cache: true,
    beforeSend : function(){
        $("body").css({
            "background-image": "url('loader.gif')",
            "background-repeat": "no-repeat",
            "background-attachment": "fixed",
            "background-position": "center top 70%" 
        });
    },
    success : function(body){
        $("body").css({
            "background" : "url("+ bingUrl +") no-repeat center center fixed", 
            "-webkit-background-size" : "cover",
            "-moz-background-size" : "cover",
            "-o-background-size" : "cover",
            "background-size" : "cover"
        });
    }
});

function startTime() {
    var today = new Date();
    var h = today.getHours();
    var m = today.getMinutes();
    var s = today.getSeconds();
    h = checkTime(h);
    m = checkTime(m);
    s = checkTime(s);
    document.getElementById('live-clock').innerHTML =
    h + ":" + m + ":" + s;
    var t = setTimeout(startTime, 500);
    document.getElementById('todays-date').innerHTML = getDate();
}
function checkTime(i) {
    if (i < 10) {i = "0" + i};  // add zero in front of numbers < 10
    return i;
}

function getDate () {
	var monthNames = [
	"January", "February", "March",
	"April", "May", "June", "July",
	"August", "September", "October",
	"November", "December"
	];

	var weekday = [
		"Sunday", "Monday", "Tuesday",
		"Wednesday", "Thursday", "Friday",
		"Saturday"
	];

	var date = new Date();

	 return weekday[date.getDay()] + ', ' + monthNames[date.getMonth()] + ' ' + date.getDate();
}

startTime();