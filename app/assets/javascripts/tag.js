$.expr[':'].contains = $.expr.createPseudo(function (arg) {
    return function (elem) {
        return $(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0;
    };
});
$(document).ready(function () {
    $("#micropost_form_submit").click(function(){
        var str = " ";
        console.clear();
           $(".as").val(" ");
        $(".addedTag").each(function(){
            str += $(this).html();
        });
           $(".as").val(str);
           //console.log($(".as").val());
    });
    $('#addTagBtn').click(function () {
        $('#tags option:selected').each(function () {
            $(this).appendTo($('#selectedTags'));
        });
    });
    $('#removeTagBtn').click(function () {
        $('#selectedTags option:selected').each(function (el) {
            $(this).appendTo($('#tags'));
        });
    });
    $('.tagRemove').click(function (event) {
        event.preventDefault();
        $(this).parent().remove();
    });
    $('ul.tags').click(function () {
        $('#search-field').focus();
    });
    $('#search-field').keypress(function (event) {
        if (event.which == '32') {
            if ($(this).val() != '' && $('.tags .addedTag:contains(\'' + $(this).val() + '\') ').length == 0) {
                $('<li class="addedTag">' + $(this).val() + '<span class="tagRemove" onclick="$(this).parent().remove();">x</span><input type="hidden" value="' + $(this).val() + '" name="tags[]"></li>').insertBefore('.tags .tagAdd');
                $(this).val('');
            } else {
                $(this).val('');
            }
        }
    });
});