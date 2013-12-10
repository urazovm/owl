(function($){

    function EditButton(el, options) {
        this.el = $(el);
        this.options = options;
        this.user = this.el.data('user');
        this.init();
    };

    EditButton.prototype.init = function(e) {
        if (window.owl.env['signed_in']) {
            if (window.owl.env['current_user'] == this.user) {
                this.el.removeClass('hidden');
            } else {
                this.el.remove();
            }
        }
    };

    var settings = {};

    $.fn.editButton = function (options) {
        return this.each(function (i, el) {
            new EditButton(el, $.extend({}, settings, options));
        });
    };

}(jQuery));
