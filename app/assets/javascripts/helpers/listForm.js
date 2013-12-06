(function($){

    function ListForm(el, options) {
        this.el = $(el);
        this.options = options;
        this.container = this.el.find('.items');
        this.items = this.container.find('.item');
        this.totalItems = this.items.length;
        this.lastItem = this.items.last();
        this.items.off('keyup', $.proxy(this.onKeyup, this));
        this.lastItem.on('keyup', $.proxy(this.onKeyup, this));
    };

    ListForm.prototype.onKeyup = function(e) {
        if ((e.keyCode < 112 || e.keyCode > 123) && this.options.specialKeys.indexOf(e.keyCode) == -1) {
            this.container.append($('<li class="item"></li>').append(this.lastItem.html().replace(new RegExp(this.totalItems - 1, 'g'), this.totalItems)));
            this.totalItems ++;
            this.lastItem.off('keyup', $.proxy(this.onKeyup, this));
            this.lastItem = this.container.find('.item').last();
            this.lastItem.on('keyup', $.proxy(this.onKeyup, this));
        }
    };

    var settings = {
        specialKeys : [13, 38, 40, 37, 39, 27, 32, 17, 18, 9, 16, 20, 91, 93, 8, 36, 35, 45, 46, 33, 34, 144, 145, 19]
    };

    $.fn.listForm = function (options) {
        return this.each(function (i, el) {
            new ListForm(el, $.extend({}, settings, options));
        });
    };

}(jQuery));
