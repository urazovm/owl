window.owl.views.lists_edit = function()
{
    $('#item_new_form .btn').on('click', function(e, el) {
        $('#item_new_form .btn').addClass('disabled');
        $('#item_new_form').fadeOut();
    });
}
