(function($){

    function CommentForm(el, options) {
        this.el = $(el);
        this.options = options;
        this.textarea = this.el.find('textarea');
        this.submit = this.el.find('input[type=submit]');
        this.init();
    };

    CommentForm.prototype.init = function(e) {
        if (window.owl.env['signed_in']){
            this.el.removeClass('hidden').hide().fadeIn();
            this.textarea.on('focus', $.proxy(function() {
                this.submit.removeClass('hidden').hide().fadeIn();
                this.textarea.height(80);
            }, this));
        }
    };

    var settings = {};

    $.fn.commentForm = function (options) {
        return this.each(function (i, el) {
            new CommentForm(el, $.extend({}, settings, options));
        });
    };

}(jQuery));
