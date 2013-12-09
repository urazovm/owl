window.owl.views.comments_create = function()
{
    if (window.owl.env['signed_in']){
        $('#new_comment').removeClass('hidden').hide().fadeIn();
        $('#new_comment textarea').on('focus', function() {
            $('#new_comment input[type=submit]').removeClass('hidden').hide().fadeIn();
        });
    }
};
