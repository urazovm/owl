window.owl.views.comments_index = function()
{
    if (typeof window.owl.env['signed_in'] && window.owl.env['signed_in'] == true){
        $('#new_comment').removeClass('hidden').hide().fadeIn();
    }

    $('#new_comment textarea').on('focus', function() {
        $('#new_comment input[type=submit]').removeClass('hidden').hide().fadeIn();
    });
}
