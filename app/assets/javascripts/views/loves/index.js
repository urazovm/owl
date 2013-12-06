window.owl.views.loves_index = function()
{
    var current_user = typeof window.owl.env['current_user'] == 'string' ? window.owl.env['current_user'] : '';

    if (current_user != '') {
        $('#user_' + current_user + ' .follow').remove();
    }

    $('#user_links .lovings').addClass('active');
    $('#list .lovers').addClass('active');
}
