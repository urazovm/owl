//= require_self
//= require_tree ./helpers
//= require_tree ./views

window.owl = window.owl || {views:{}, env:{}, func:{}};
window.owl.func['ready'] = function() {
    var page = window.owl.env.controller + '_' + window.owl.env.action;
    typeof window.owl.views[page] == 'function' && window.owl.views[page]();
    typeof window.owl.env['query'] == 'string' && $('#query').attr('value', window.owl.env['query']);
    typeof window.owl.env['category_id'] == 'number' && $('#categories a.category_' + window.owl.env['category_id']).addClass('selected');
    window.Echo.init();
}

$(document).ready(window.owl.func.ready)
$(document).on('page:load', window.owl.func.ready)
