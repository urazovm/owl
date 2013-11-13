//= require_self
//= require_tree ./views

window.owl = window.owl || {views:{}, env:{}, func:{}};
window.owl.func['ready'] = function() {
    var page = window.owl.env.controller + '_' + window.owl.env.action;
    typeof window.owl.views[page] == 'function' && window.owl.views[page]();
}

$(document).ready(window.owl.func.ready)
$(document).on('page:load', window.owl.func.ready)
