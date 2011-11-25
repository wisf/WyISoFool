function move_advert(element, y_offset, margin_top)
{
    if (Math.abs(margin_top.val - y_offset.val) > 1)
    {
        if (margin_top.val < y_offset.val) { k = 1 } else { k = -1 }
        margin_top.val += (Math.abs(Math.round((y_offset.val - margin_top.val) / 6))) * k;
        element.css('margin-top', margin_top.toString() + "px");
    }
    else
    {
        clearInterval(ki);
    }
}

function advert_animate()
{
    clearInterval(ki);
    a = $("#teasernet");
    mt = a.css('margin-top');
    margin_top = {
        val: parseInt(mt.substr(0,mt.length - 2)),
        toString: function () { return this.val.toString() }
    };
    y_start_offset = Math.round(($(window).height() - a.height()) / 2);
    y_offset = {
        val: window.pageYOffset + y_start_offset,
        toString: function () { return this.val.toString() }
    };
    ki = setInterval('move_advert(a, y_offset, margin_top);', 20);
}

function skyscraper_init() {
    a = $("#teasernet");
    a.css('margin-left', Math.round(((($(window).width() - $("#wrapper").width()) / 2 - a.width()) / 2)));
    a.css('margin-top', -a.height());
    ki = 0;
    advert_animate();
    window.onscroll = advert_animate;
};

function comment_notify(message) {
    var notice_div = $("#commentnotice");
    notice_div.html(message).hide().slideToggle("slow", function () {
        setTimeout(function () {
            notice_div.slideToggle("slow")
        },2000)
    });
}

$(document).ready(function () {
    $("ul.dropdown > li").hover(function(){
        $(this).addClass("menuhover");
        $('ul:first',this).fadeIn("fast");
    }, function(){
        $(this).removeClass("menuhover");
        $('ul:first',this).fadeOut("fast");
    });
});
