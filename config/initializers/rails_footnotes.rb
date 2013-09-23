if defined?(Footnotes) && Rails.env.development?
  Footnotes.run!
  Footnotes::Filter.notes = [:session, :cookies, :params, :filters, :routes, :env, :queries, :log, :general]
end
