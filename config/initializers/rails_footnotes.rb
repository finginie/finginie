if defined?(Footnotes) && Rails.env.development?
  Footnotes.run! # first of all
  Footnotes::Filter.prefix = 'gvim://open?url=file://%s&line=%d&column=%d'

  # ... other init code
end
