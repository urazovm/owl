//= require_self
//= require_tree ./helpers
//= require_tree ./views

window.owl = window.owl || {views:{}, env:{}, func:{}};
window.owl.func['ready'] = function() {
    function getEnv(name, type, fallback) {
        return typeof window.owl.env[name] == type ? window.owl.env[name] : fallback;
    }
    window.owl.env['signed_in'] = getEnv('signed_in', 'boolean', false);
    window.owl.env['loving'] = getEnv('loving', 'boolean', false);
    window.owl.env['current_user'] = getEnv('current_user', 'string', '');
    window.owl.env['followers'] = getEnv('followers', 'object', null);
    window.owl.env['followings'] = getEnv('followings', 'object', null);
    window.owl.env['query'] = getEnv('query', 'string', '');
    window.owl.env['category_id'] = getEnv('category_id', 'number', null);

    var page = window.owl.env.controller + '_' + window.owl.env.action;
    typeof window.owl.views[page] == 'function' && window.owl.views[page]();

    window.Echo.init();
}

$(document).ready(window.owl.func.ready)
$(document).on('page:load', window.owl.func.ready)
