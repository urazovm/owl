(function($){

    function ItemEditImageForm(el, options) {
        this.el = $(el);
        this.options = options;
        this.el_input = this.el.find('.imageInput');
        this.el_preview = this.el.find('.imagePreview');
        this.el_submit = this.el.find('.submit');
        this.el_name = this.el.find('.item_name');
        this.el_delete = this.el.find('.delete');
        this.newFileLoaded = false;
        this.init();
    };

    ItemEditImageForm.prototype.init = function(e) {
        this.el_input.find('input').fileupload({
            url: this.options.url,
            method: 'put',
            dataType: 'text',
            autoUpload: false,
            acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
            maxFileSize: 1500000,
            disableImageResize: /Android(?!.*Chrome)|Opera/.test(window.navigator.userAgent),
            previewMaxWidth: 120,
            previewMaxHeight: 120,
            previewCrop: true
        })
        .on('fileuploadadd', $.proxy(this.onAdd, this))
        .on('fileuploadprocessalways', $.proxy(this.onProcess, this))
        .on('fileuploadfail', $.proxy(this.onFail, this))
        .on('fileuploaddone', $.proxy(this.onDone, this))
        .prop('disabled', !$.support.fileInput)
        .parent().addClass($.support.fileInput ? undefined : 'disabled');

        this.el_delete.on('click', $.proxy(this.onDelete, this));
        this.el_submit.on('click', $.proxy(this.onSubmit, this));

        if (this.el_preview.find('.files').children().length == 0) {
            this.el_preview.hide();
            this.el_input.show();
            this.el_submit.hide();
            this.el_name.hide();
        } else {
            this.el_preview.show();
            this.el_input.hide();
            this.el_submit.show();
            this.el_name.show();
        }
    };

    ItemEditImageForm.prototype.onAdd = function(e, data) {
        this.el_preview.find('.files').html('');
        this.el_submit.data(data);
        this.el_preview.show();
        this.el_input.hide();
        this.el_name.show();
        this.el_submit.show();
        this.newFileLoaded = true;
    };

    ItemEditImageForm.prototype.onProcess = function(e, data) {
        var file = data.files[data.index];
        if (file.preview) {
            this.el_preview.find('.files').prepend(file.preview);
        }
        if (file.error) {
            this.el_preview.find('.files').append($('<span class="text-danger"/>').text(file.error));
        }
    };

    ItemEditImageForm.prototype.onFail = function(e, data) {
        alert('Something went wrond :(');
    };

    ItemEditImageForm.prototype.onDone = function(e, data) {
        eval(data.result);
    };

    ItemEditImageForm.prototype.onDelete = function(e, data) {
        if (this.newFileLoaded) {
            this.el_submit.data().files.pop();
        }
        this.el_preview.hide();
        this.el_submit.hide();
        this.el_name.hide();
        this.el_input.show();
        this.newFileLoaded = false;
    };

    ItemEditImageForm.prototype.onSubmit = function(e, data) {
        e.preventDefault();
        e.stopPropagation();
        if (this.newFileLoaded) {
            this.el_submit.data().submit();
        } else {
            this.el.submit();
        }
    };

    var settings = {
        'url' : '/'
    };

    $.fn.itemEditImageForm = function (options) {
        return this.each(function (i, el) {
            new ItemEditImageForm(el, $.extend({}, settings, options));
        });
    };

}(jQuery));
