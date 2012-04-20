if defined?(Footnotes) && Rails.env.development?
    Footnotes.run! # first of all
    Footnotes::Filter.notes = [:session, :cookies, :params, :filters, :routes, :env, :queries, :log, :general]
end
