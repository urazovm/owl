window.owl.views.lists_edit = function()
{
    var items = $('.edit_list .items .item');
    var totalItems = items.length;
    var lastItem = items.last();
    var specialKeys = [13, 38, 40, 37, 39, 27, 32, 17, 18, 9, 16, 20, 91, 93, 8, 36, 35, 45, 46, 33, 34, 144, 145, 19];

    function onKeyup(e) {
        if ((e.keyCode < 112 || e.keyCode > 123) && specialKeys.indexOf(e.keyCode) == -1)
        {
            $('.edit_list .items').append($('<div class="item"></div>').append(lastItem.html().replace(new RegExp(totalItems - 1, 'g'), totalItems)));
            totalItems ++;
            lastItem.off('keyup', onKeyup);
            lastItem = $('.edit_list .items .item').last();
            lastItem.on('keyup', onKeyup);
        }
    };

    items.off('keyup', onKeyup);
    lastItem.on('keyup', onKeyup);
}
