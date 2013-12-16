(function($){

    function ListEditInfoForm(el, options) {
        this.el = $(el);
        this.options = options;
        this.el_title = $('.edit_title');
        this.el_category = $('.edit_category');
        this.placeholder = this.el_title.data('placeholder');
        this.categories = this.el_category.data('categories');
        this.init();
    };

    ListEditInfoForm.prototype.init = function() {
        this.el_title.editable(this.options.url, {
            type: 'textarea',
            onblur: 'submit',
            method: 'PUT',
            name: 'list[title]',
            placeholder: this.placeholder,
            id: 'list_id',
            onedit: $.proxy(this.onEdit, this),
            callback: $.proxy(this.onSuccess, this),
            onerror: $.proxy(this.onError, this)
        });
        this.el_category.editable(this.options.url, {
            data: this.categories,
            type: 'select',
            onblur: 'submit',
            method: 'PUT',
            name: 'list[category_id]',
            id: 'list_id',
            onedit: $.proxy(this.onEdit, this),
            callback: $.proxy(this.onSuccess, this),
            onerror: $.proxy(this.onError, this)
        });
    };

    ListEditInfoForm.prototype.onEdit = function(form) {
        if (form.name == 'list[title]') {
            this.el_title.addClass('editing');
            setTimeout($.proxy(function(){ this.el_title.find('textarea').autosize(); }, this), 100);
        } else if (form.name == 'list[category_id]') {
            this.el_category.addClass('editing');
        }
    };

    ListEditInfoForm.prototype.onSuccess = function(data, form) {
        if (form.name == 'list[title]') {
            this.el_title.removeClass('editing');
        } else if (form.name == 'list[category_id]') {
            this.el_category.removeClass('editing');
        }
    };

    ListEditInfoForm.prototype.onError = function(form) {
        if (form.name == 'list[title]') {
            this.el_title.html('Something went wrong :(').addClass('text-danger');
        } else if (form.name == 'list[category_id]') {
            this.el_category.html('Something went wrong :(').addClass('text-danger');
        }
    };

    var settings = {
        url: '/'
    };

    $.fn.listEditInfoForm = function (options) {
        return this.each(function (i, el) {
            new ListEditInfoForm(el, $.extend({}, settings, options));
        });
    };

}(jQuery));
