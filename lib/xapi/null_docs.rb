module Xapi
  # NullDocs is documentation for non-existent track
  class NullDocs < Docs
    def files
      @files ||= AUTHORIZED_DOCS.each_with_object({}) do |filename, files|
        files[filename] = ""
      end
    end

    def available?
      false
    end
  end
end
