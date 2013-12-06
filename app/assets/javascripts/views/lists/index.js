window.owl.views.lists_index = function()
{
    if (window.owl.env['category_id'] != null) {
        if (window.owl.env['category_id'] == 999) {
            $('#categories-collapse').collapse('show');
            $('#header .categories-collapser').addClass('active');
        }
        $('#categories .category_' + window.owl.env['category_id'] + ' a').addClass('active')
    }
    $('#query').attr('value', window.owl.env['query']);
    $('.edit_list').listForm();
}
