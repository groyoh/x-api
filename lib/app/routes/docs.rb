module Xapi
  module Routes
    class Docs < Core
      get '/docs/:track' do |id|
        track = Xapi::Config.find(id)
        if track.is_a?(NullTrack)
          halt 404, { error: "Track #{id} not found." }.to_json
        end
        docs = track.docs
        unless docs.available?
          halt 404, {
            error: "Documentation for #{track.language} not found.",
          }.to_json
        end
        pg :docs, locals:  { docs: docs }
      end
    end
  end
end
