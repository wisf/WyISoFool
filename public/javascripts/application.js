function teasetnet_init() {
    a = $("#teasernet_291256");
    $("#teasernet").css('margin-left', -((($(document).width()-640)/2-a.width())/2+a.width()));
};

function comment_notify(message) {
    var notice_div = $("#commentnotice");
    notice_div.html(message).hide().slideToggle("slow", function () {
        setTimeout(function () {
            notice_div.slideToggle("slow")
        },2000)
    });
}
