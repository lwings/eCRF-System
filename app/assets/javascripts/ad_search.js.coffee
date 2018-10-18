class @Ad_search
  constructor: (@templates = {}) ->

  add_search_fields: (button, type, content,content2) ->
    new_id = new Date().getTime()
    regexp = new RegExp('new_' + type, 'g')
    $(button).before(content.replace(regexp, new_id))

  nest_search_fields: (button, type) ->
    new_id = new Date().getTime()
    id_regexp = new RegExp('new_' + type, 'g')
    template = @templates[type]
    object_name = $(button).closest('.fields').attr('data-object-name')
    sanitized_object_name = object_name.replace(/\]\[|[^-a-zA-Z0-9:.]/g, '_').replace(/_$/, '')
    template = template.replace(/new_object_name\[/g, object_name + "[")
    template = template.replace(/new_object_name_/, sanitized_object_name + '_')
    $(button).before(template.replace(id_regexp, new_id))