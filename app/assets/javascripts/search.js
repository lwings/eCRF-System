$(function(){
    function extract_param(url){
        url = decodeURI(url);
        var arr = url.split('?');
        arr[1] = arr[1].split('&');
        for(var i=0; i<arr[1].length; i++){arr[1][i]=arr[1][i].split('=');}
        return {host: arr[0], params: arr[1]}
    }

    function handle_long_url(link){
        var host_params = extract_param(link.href),
            method = 'post',
            csrfToken = $('meta[name=csrf-token]').attr('content'),
            csrfParam = $('meta[name=csrf-param]').attr('content'),
            form = $('<form method="post" action="' + host_params.host + '"></form>'),
            input = '';

        var params = host_params.params;
        for(var i=0; i<params.length; i++){
            //if(params[i][1] !='')
            input += '<input name="' + params[i][0] + '" value="' + params[i][1] + '" type="hidden" />';
        }

        if (csrfParam !== undefined && csrfToken !== undefined && !$.rails.isCrossDomain(host_params.host)) {
            input += '<input name="' + csrfParam + '" value="' + csrfToken + '" type="hidden" />';
        }//<input name="utf8" value="✓" type="hidden">??

        form.hide().append(input).appendTo('body');
        form.submit();
    }

    function handle_long_action(form){
        var host_params = extract_param(form.action),
            input = '';

        var params = host_params.params;

        for(var i=0; i<params.length; i++){
            //if(params[i][1] !='')
            input += '<input name="' + params[i][0] + '" value="' + params[i][1] + '" type="hidden" />';
        }

        form.action = host_params.host;

        $(form).prepend(input);
    }

    $('a.sort, ul.pagination a').click(function(){
        if(this.href.length > 2000){
            handle_long_url(this);
            return false;
        }
    });

    $('form#export').submit(function(){
        if(this.action.length > 2000){
            handle_long_action(this);
        }
    });

    $('#export_table_patient').prop('checked', true).attr('readonly', true);

    $('#export_select_all').click(function(){
        $("input[id^='export_table']:not([readonly])").prop("checked", $(this).prop("checked") ? true:false);
    })
});

