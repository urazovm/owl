(function($){

    function UserActions(el, options) {
        this.el = $(el);
        this.options = options;
        this.user = this.el.data('user');
        this.init();
    };

    UserActions.prototype.init = function(e) {
        window.owl.env['signed_in']
        if (window.owl.env['signed_in'] && window.owl.env['current_user'] == this.user) {
            this.el.removeClass('hidden');
        } else {
            this.el.remove();
        }
    };

    var settings = {};

    $.fn.userActions = function (options) {
        return this.each(function (i, el) {
            new UserActions(el, $.extend({}, settings, options));
        });
    };

}(jQuery));

