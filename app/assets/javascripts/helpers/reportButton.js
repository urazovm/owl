(function($){

    function ReportButton(el, options) {
        this.el = $(el);
        this.options = options;
        this.list = this.el.data('list');
        this.init();
    };

    ReportButton.prototype.init = function(e) {
        console.log(1);
        this.el.on('click', $.proxy(function(e) {
        console.log(2);
            e.preventDefault();
            if (confirm('Are you realy sure you want to report this list as inapropriate?\n\nClick "ok" if so, otherwise click "cancel".\n\nWARNING: Duplicated reports will be ignored and abusive reports will be punished.')) {
                var m = prompt('Please explain briefly the reason why this list is inapropriate.', '');
                if (m != null) {
                    m = $.trim(m);
                    if (m == '') {
                        alert('Sorry, you have to explain the reason why this list is inapropriate, otherwise we cannot handle your request.');
                    } else {
                        this.report(m);
                    }
                }
            }
            return false;
        }, this));
    };

    ReportButton.prototype.report = function(message) {
        $.ajax({
            url: '/reports',
            type: 'post',
            data: { report: { message: message, list_id: this.list }},
            success: function(data) {
                alert('Thank you, your report has been sent to our team! It will be handled shortly.');
            }
        });
    };

    var settings = {};

    $.fn.reportButton = function (options) {
        return this.each(function (i, el) {
            new ReportButton(el, $.extend({}, settings, options));
        });
    };

}(jQuery));
