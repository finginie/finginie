_.extend Backbone.Model.prototype,
  color_classes: (attrs...)->
    color_classes = {}
    for attr in attrs
      value = @get attr
      color_classes["#{attr}_color"] = if value?
        if value < 0 then 'red' else 'green'
    color_classes

  round: (attrs...)->
    ret = {}
    for attr in attrs
      ret[attr] = Math.round(@get(attr) * 100)/100
    ret

  slug: (attrs...)->
    slugs = {}
    for attr in attrs
      slugs["#{attr}_slug"] = string_to_slug @get attr
    slugs

  localize_date: (attrs...)->
    ret = {}
    for attr in attrs
      date = new Date(@get(attr))
      ret[attr] = date.toLocaleDateString() + ' ' + date.toLocaleTimeString()
    ret
