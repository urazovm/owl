//= require_tree ./views
//= require_self

window.owl.func['ready'] = function() {
    var page = window.owl.env.controller + '_' + window.owl.env.action;
    typeof window.owl.views[page] == 'function' && window.owl.views[page]();
}

$(document).ready(window.owl.func.ready)
