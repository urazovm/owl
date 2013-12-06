(function($){

    function LoveButton(el, options) {
        this.el = $(el);
        this.options = options;
        this.love = this.el.find('.love');
        this.ignore = this.el.find('.ignore');
        this.init();
    };

    LoveButton.prototype.init = function(e) {
        if (window.owl.env['signed_in']) {
            if (window.owl.env['loving']) {
                this.love.hide();
            } else {
                this.ignore.hide();
            }
        } else {
            this.el.remove();
        }
    };

    var settings = {};

    $.fn.loveButton = function (options) {
        return this.each(function (i, el) {
            new LoveButton(el, $.extend({}, settings, options));
        });
    };

}(jQuery));
