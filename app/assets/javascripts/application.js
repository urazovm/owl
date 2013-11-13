//= require_tree ./views
//= require_self

window.owl.func['ready'] = function() {
    var page = window.owl.env.controller + '_' + window.owl.env.action;
    typeof window.owl.views[page] == 'function' && window.owl.views[page]();
}

$(function() {
    $(document).ready(window.owl.func.ready)
    $(document).on('page:load', window.owl.func.ready)
});
