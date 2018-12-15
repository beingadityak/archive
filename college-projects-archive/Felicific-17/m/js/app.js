$(function() {
    $("#body_touch").swipe({
        swipeLeft: function (event, direction, distance, duration, fingerCount) {
            $(".cd-nav-trigger").click();
        }
    });
});

$(function() {
    $("#dept_body").swipe({
        swipeLeft: function (event, direction, distance, duration, fingerCount) {
            $('#dept_menu').prop('checked', true);
        }
    });
});


$(function() {
    $("#dept_body").swipe({
        tap: function (event,target) {
            $('#dept_menu').prop('checked', false);
        }
    });
});

$(function() {
    $("#header_touch").swipe({
        swipeUp: function (event, direction, distance, duration, fingerCount) {
            $("#down_arrow").click();
        }

    });
});



