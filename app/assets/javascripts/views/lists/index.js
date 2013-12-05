window.owl.views.lists_index = function()
{
    var query = typeof window.owl.env['query'] == 'string' ? window.owl.env['query'] : '';
    var category_id = typeof window.owl.env['category_id'] == 'number' ? window.owl.env['category_id'] : null;
    console.log(234);
    console.log(category_id);

    if (category_id != null) {
        if (category_id == 999) {
            $('#categories-collapse').collapse('show');
            $('#header .categories-collapser').addClass('active');
        }
        $('#categories .category_' + category_id + ' a').addClass('active')
    }
    $('#query').attr('value', query);
    $('.edit_list').listForm();
}
