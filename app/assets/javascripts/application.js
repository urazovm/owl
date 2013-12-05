//= require_self
//= require_tree ./helpers
//= require_tree ./views

window.owl = window.owl || {views:{}, env:{}, func:{}};
window.owl.func['ready'] = function() {
    var page = window.owl.env.controller + '_' + window.owl.env.action;
    typeof window.owl.views[page] == 'function' && window.owl.views[page]();

    window.Echo.init();

    var signed_in = typeof window.owl.env['signed_in'] == 'boolean' && window.owl.env['signed_in'] == true;
    var following = typeof window.owl.env['following'] == 'boolean' && window.owl.env['following'] == true;
    var loving = typeof window.owl.env['loving'] == 'boolean' && window.owl.env['loving'] == true;
    var owner = typeof window.owl.env['owner'] == 'boolean' && window.owl.env['owner'] == true;
    if (signed_in && owner) {
        $('#user_info .logout').removeClass('hidden');
        $('#user_info .edit').removeClass('hidden');
        $('#list .edit').removeClass('hidden');
    } else if (signed_in) {
        $('#follow_button').removeClass('hidden');
        if (following) {
            $('#follow_button .follow').hide();
            $('#follow_button .unfollow').show();
        } else {
            $('#follow_button .follow').show();
            $('#follow_button .unfollow').hide();
        }
        $('#love_button').removeClass('hidden');
        if (loving) {
            $('#love_button .love').hide();
            $('#love_button .ignore').show();
        } else {
            $('#love_button .love').show();
            $('#love_button .ignore').hide();
        }
    }


    var searchCollapsed = $('#search-collapse').hasClass('collapse');
    var categoriesCollapsed = $('#categories-collapse').hasClass('collapse');
    $('#search-collapse').on('hide.bs.collapse', function () {
        searchCollapsed = true;
        $('#header .search-collapser').removeClass('active');
    });
    $('#categories-collapse').on('hide.bs.collapse', function () {
        categoriesCollapsed = true;
        $('#header .categories-collapser').removeClass('active');
    });
    $('#search-collapse').on('show.bs.collapse', function () {
        searchCollapsed = false;
        if (!categoriesCollapsed) $('#categories-collapse').collapse('hide');
        $('#header .search-collapser').addClass('active');
    });
    $('#categories-collapse').on('show.bs.collapse', function () {
        categoriesCollapsed = false;
        if (!searchCollapsed) $('#search-collapse').collapse('hide');
        $('#header .categories-collapser').addClass('active');
    });
}

$(document).ready(window.owl.func.ready)
$(document).on('page:load', window.owl.func.ready)
