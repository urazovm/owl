(function($){

    function EditButton(el, options) {
        this.el = $(el);
        this.options = options;
        this.user = this.el.data('user');
        this.init();
    };

    EditButton.prototype.init = function(e) {
        console.log(1);
        if (window.owl.env['signed_in']) {
        console.log(2);
            if (window.owl.env['current_user'] == this.user) {
        console.log(3);
                this.el.removeClass('hidden');
            } else {
        console.log(4);
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
