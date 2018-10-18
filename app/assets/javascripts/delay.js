// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
// require jquery
// require jquery_ujs
//= require foundation_custom
// require turbolinks
// require_tree .

$(function () {
    $(document).foundation({
        accordion: {
            // specify the class used for accordion panels
            //content_class: 'content',
            // specify the class used for active (or open) accordion panels
            //active_class: 'active',
            // allow multiple accordion panels to be active at the same time
            multi_expand: true
            // allow accordion panels to be closed by clicking on their headers
            // setting to false only closes accordion panels when another is opened
            //toggleable: true
        }
    });

    function pop_noty(type, text) {
        noty({
            text: text,
            type: type,
            dismissQueue: false,
            layout: 'bottomRight',
            closeWith: ['click'],
            theme: 'relax',
            maxVisible: 10,
            animation: {
                open: 'animated flipInX',
                close: 'animated flipOutX',
                easing: 'swing',
                speed: 500
            },
            timeout: 2000,
            killer: true
        });
        console.log("noty!");
    }

    //TODO influenced by turbo link? or something else
    function trigger_noty() {
        succ = $('#notify-success').text();
        if (succ) {
            pop_noty('success', succ);
        }
        err = $('#notify-error').text();
        if (err) {
            pop_noty('error', err);
        }
    }

    trigger_noty();

    var form = $('form[action*="patient"]');
    //return if not maintaining concerned page
    if( form.size() == 0 ) return;

    $('#patient_bmi').val(parseFloat($('#patient_bmi').val()).toFixed(1));
    $('#neoadjuvant_bmi').val(parseFloat($('#neoadjuvant_bmi').val()).toFixed(1));

    $('[id$="_pr_value"], [id$="_er_value"]').each(function(){
        $(this).val($(this).val().replace(/\.0+$/, ''));
    });

    if (form.hasClass('disabled')) {
        form.find('input, select, textarea').attr('disabled', true);
        return;
    }

    // if the form is not disabled, bind event
    //======================================================================================

    $('#patient_height, #patient_weight').change(function () {
        var height = $('#patient_height').val();
        $('#patient_bmi').val(($('#patient_weight').val() / height / height).toFixed(1));
    });
    $('#neoadjuvant_height, #neoadjuvant_weight').change(function () {
        var height = $('#neoadjuvant_height').val();
        $('#neoadjuvant_bmi').val(($('#neoadjuvant_weight').val() / height / height).toFixed(1));
    });

    $('#patient_occupation').change(function () {
        var flag = $(this).val() != 'extra';
        $(this).parent().next().children('input').attr('disabled', flag);

    });
    $('#patient_has_addiction').change(function () {
        var flag = $(this).val() != 'yes';
        $(this).parent().next().find('input').attr('disabled', flag);

    });

    $('fieldset#gynecology:not(.disabled) #history_menopause_status').change(function () {
        var flag = $(this).val() != 'after';
        $('#history_menopause_age').attr('disabled', flag);
        $('#history_is_period_regular').attr('disabled', !flag);
        $('#history_menstrual_cycle').attr('disabled', !flag);
        $('#history_last_menstrucation_date_1i').attr('disabled', !flag);
        $('#history_last_menstrucation_date_2i').attr('disabled', !flag);
        $('#history_last_menstrucation_date_3i').attr('disabled', !flag);
    }).trigger('change');

    $('fieldset#gynecology:not(.disabled) #history_is_breastfed').change(function () {
        var flag = $(this).val() != 'yes'
        $('#history_breastfed_period').attr('disabled', flag);
    }).trigger('change');

    $('fieldset#gynecology.disabled').find('input, select').attr('disabled', true);

    $('#clinical_has_initial_symptom').change(function () {
        var flag = $(this).val() != 'true';
        $(this).parent().next().find('input').attr('disabled', flag);
        $(this).parent().next().next().children('input').attr('disabled', flag);
    }).trigger('change');

    $('#operation_lesion_has_postoperative_complication').change(function () {
        var flag = $(this).val() != 'yes';
        $('#operation_lesion_postoperative_complication').attr('disabled', flag);
        $('#operation_lesion_ex_postoperative_complication').attr('disabled', flag);
    }).trigger('change');

    $('#operation_lesion_has_ihc').change(function() {
        var targets = $(this).parent().parent().find('input:not(:hidden), select').not($(this));
        targets.attr('disabled', !$(this).prop('checked'))
    }).trigger('change');

    $('[id$="_has_us"], [id$="_has_mmg"],[id$="_has_mri"], [id$="_has_twenty_eight_gene"], [id$="_has_twenty_one_and_seven_gene"],#adjuvant_is_ct, #adjuvant_is_tt, #adjuvant_is_rt, #adjuvant_is_et, #adjuvant_is_cr, #adjuvant_is_mdt, #neoadjuvant_is_mdt').change(function () {
        var targets = $(this).parent().parent().find('input:not(:hidden), select, textarea');
        var links = $(this).parent().parent().find('a.add_fields');
        var flag = !$(this).prop('checked');
        targets.not($(this)).attr('disabled', flag);
        if(flag){
            links.hide();
        }else{
            links.show();
        }
    }).trigger('change');

    $('form[id*="imaging"]').on('cocoon:after-insert', function (e, insertedItem) {
        $(insertedItem).find('[id$="_has_us"], [id$="_has_mmg"],[id$="_has_mri"]').change(function () {
            var targets = $(this).parent().parent().find('input:not(:hidden), select, textarea');
            var links = $(this).parent().parent().find('a.add_fields');
            var flag = !$(this).prop('checked');
            targets.not($(this)).attr('disabled', flag);
            if(flag){
                links.hide();
            }else{
                links.show();
            }
        }).trigger('change');

    });

    $('#pathology_has_fna').change(function () {
        var targets = $(this).parent().parent().find('input:not(:hidden), select').not($(this));
        var flag = $(this).val() != 'true';
        targets.attr('disabled', flag);
    }).trigger('change');

    $('#pathology_has_pathology').change(function () {
        var targets = $(this).parent().parent().find('input:not(:hidden), select').not($(this));
        var lesions = $('fieldset.nested-fields').find('input:not(:hidden), select, textarea');
        var link = $('a.add_fields');
        var flag = $(this).val() != 'true';
        targets.attr('disabled', flag);
        lesions.attr('disabled', flag);
        if(flag){
            link.hide();
        }else {
            link.show();
        }
    }).trigger('change');

    $('#neoadjuvant_has_adjuvant').change(function () {
        var targets = $('form[id*="neoadjuvant"]').find('input:not(:submit, :hidden), select, textarea').not($(this));
        var link = $('a.add_fields');
        var flag = $(this).val() != 'true';
        targets.attr('disabled', flag);
        if(flag){
            link.hide();
        }else {
            link.show();
        }
    }).trigger('change');

    // TODO: rt_scheme, rt_poistion
    $('#followup_metastasis, #neoadjuvant_ct_scheme, #neoadjuvant_et_scheme, #neoadjuvant_rt_scheme, ' +
        '#adjuvant_rt_position, #adjuvant_ct_scheme, #adjuvant_et_scheme, ' +
        '#neoadjuvant_et_scheme, #neoadjuvant_rt_scheme, #neoadjuvant_ct_scheme, #neoadjuvant_et_scheme').change(function () {
        var flag = $(this).val() != 'others';
        $(this).parent().next().children('input').attr('disabled', flag);

    });
    $('#followup_metastasis_biopsy, #followup_recur_biopsy').change(function () {
        var flag = !$(this).prop('checked');
        $(this).parent().parent().next().children('input').attr('disabled', flag);

    });
    $('#history_has_cancer_history, #history_has_family_breast_cancer, #history_has_family_ovarian_cancer, #history_has_breast_disease_history, #history_has_systematic_disease').change(function () {
        var flag = $(this).val() != 'yes';
        $(this).parent().next().children('textarea').attr('disabled', flag);
    }).trigger('change');

    $('#history_has_systematic_disease').change(function () {
        var flag = $(this).val() != 'yes';
        $(this).parent().next().find('input').attr('disabled', flag);
        $(this).parent().next().next().children('input').attr('disabled', flag);

    }).trigger('change');

    $('#followup_event').change(function () {
        if ($(this).val() == 'recur' || $(this).val() == 'other_cancer') {
            $('fieldset#recur input, fieldset#recur select ').attr('disabled', false);
            $('fieldset#dead input, fieldset#dead select').attr('disabled', true);
        }
        else if ($(this).val() == 'dead') {
            $('fieldset#dead input, fieldset#dead select ').attr('disabled', false);
        }
        else {
            $('fieldset#recur input[type!="checkbox"], fieldset#recur select').attr('disabled', true).val("");
            $('fieldset#recur input[type="checkbox"]').prop('checked', false).attr('disabled', true);
            $('fieldset#dead input, fieldset#dead select').attr('disabled', true).val("");
        }
        $('#followup_metastasis_biopsy, #followup_recur_biopsy').trigger('change');
    }).trigger('change');
});
