window.owl.views.lists_index = function()
{
    if (window.owl.env['category_id'] != null) {
        $('#categories-collapse .category_' + window.owl.env['category_id'] + ' a').addClass('active')
    }
    $('#query').attr('value', window.owl.env['query']);
    $('.edit_list').listForm();
}
