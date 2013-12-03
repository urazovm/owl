window.owl.views.lists_index = function()
{
    var query = typeof window.owl.env['query'] == 'string' ? window.owl.env['query'] : '';
    var category_id = typeof window.owl.env['category_id'] == 'number' ? window.owl.env['category_id'] : null;
    console.log(234);
    console.log(category_id);

    if (category_id != null) {
        $('#categories a.category_' + category_id).addClass('selected')
    }
    $('#query').attr('value', query);
    $('.edit_list').listForm();
}
