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
    var owner = typeof window.owl.env['owner'] == 'boolean' && window.owl.env['owner'] == true;
    if (signed_in && owner) {
        $('#user_info .edit').removeClass('hidden');
    } else if (signed_in) {
        $('#follow_button').removeClass('hidden');
        if (following) {
            $('#follow_button .follow').hide();
            $('#follow_button .unfollow').show();
        } else {
            $('#follow_button .follow').show();
            $('#follow_button .unfollow').hide();
        }
    }
}

$(document).ready(window.owl.func.ready)
$(document).on('page:load', window.owl.func.ready)
