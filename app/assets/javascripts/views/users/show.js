window.owl.views.users_show = function()
{
    $('.follow_button').followButton();
    $('#user_links .lists').addClass('active');
    $('#user_info .actions').userActions();
}
