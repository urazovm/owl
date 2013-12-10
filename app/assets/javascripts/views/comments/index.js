window.owl.views.comments_index = function()
{
    if (window.owl.env['signed_in']){
        $('#new_comment').removeClass('hidden').hide().fadeIn();
        $('#new_comment textarea').on('focus', function() {
            $('#new_comment input[type=submit]').removeClass('hidden').hide().fadeIn();
        });
    }
    $('#list .comments').addClass('active');
    $('.love_button').loveButton();
    $('.report_button').reportButton();
};
