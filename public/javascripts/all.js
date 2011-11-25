   $(function() {
                $(".rp_list").css("top", $(window).height() / 2 - 150);

                /**
                * the list of posts
                */
                var $list         = $('#rp_list ul');
                /**
                * number of related posts
                */
                var elems_cnt         = $list.children().length;

                /**
                * show the first set of posts.
                * 200 is the initial left margin for the list elements
                */
                load(200);

                function load(initial){
                    $list.find('li').hide().andSelf().find('div').css('margin-left',-initial+'px');
                    var loaded    = 0;
                    //show 5 random posts from all the ones in the list.
                    //Make sure not to repeat
                    while(loaded < elems_cnt){
                        var $elem    = $list.find('li:nth-child('+ (loaded+1) +')');
                        if($elem.is(':visible'))
                            continue;
                        else
                            $elem.show();
                        ++loaded;
                    }
                    //animate them
                    var d = 200;
                    $list.find('li:visible div').each(function(){
                        $(this).stop().animate({
                            'marginLeft':'-90px'
                        },d += 100);
                    });
                }

                /**
                * hovering over the list elements makes them slide out
                */
                $list.find('li:visible').live('mouseenter',function () {
                    $(this).find('div').stop().animate({
                        'marginLeft':'-295px'
                    },200);
                }).live('mouseleave',function () {
                    $(this).find('div').stop().animate({
                        'marginLeft':'-90px'
                    },200);
                });
            });