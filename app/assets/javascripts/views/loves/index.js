window.owl.views.loves_index = function()
{
    $('.follow_button').followButton();
    $('.love_button').loveButton();
    $('.report_button').reportButton();
    $('#user_links .lovings').addClass('active');
    $('#list .lovers').addClass('active');
};
