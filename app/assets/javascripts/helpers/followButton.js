(function($){

    function FollowButton(el, options) {
        this.el = $(el);
        this.options = options;
        this.follow = this.el.find('.follow');
        this.unfollow = this.el.find('.unfollow');
        this.user = this.el.data('user');
        this.init();
    };

    FollowButton.prototype.init = function(e) {
        if (window.owl.env['signed_in']) {
            if (window.owl.env['current_user'] == this.user) {
                this.el.remove();
            } else {
                if (window.owl.env['followings'] && window.owl.env['followings'].indexOf(this.user) != -1) {
                    this.follow.hide();
                } else {
                    this.unfollow.hide();
                }
            }
        } else {
            this.el.remove();
        }
    };

    var settings = {};

    $.fn.followButton = function (options) {
        return this.each(function (i, el) {
            new FollowButton(el, $.extend({}, settings, options));
        });
    };

}(jQuery));
