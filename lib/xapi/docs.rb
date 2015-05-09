module Xapi
  # Track specific documentation
  class Docs
    AUTHORIZED_DOCS = [
      "HELLO.md",
      "WORKFLOW.md",
      "RESOURCES.md",
      "INSTALLATION.md",
      "TOOLS.md",
    ]

    def initialize(language, dir)
      @language = language
      @dir = dir
    end

    def files
      @files ||= AUTHORIZED_DOCS.each_with_object({}) do |filename, files|
        path = path_for(filename)
        next unless File.exist?(path)
        files[filename] = File.read(path)
      end
    end

    def available?
      AUTHORIZED_DOCS.any? { |filename| File.exist?(path_for(filename)) }
    end

    private

    attr_reader :dir, :language

    def path_for(filename)
      "#{docs_dir}/#{filename}"
    end

    def language_dir
      @language_dir ||= File.join(dir, 'problems', language)
    end

    def docs_dir
      @docs_dir ||= File.join(language_dir, 'docs')
    end

    def basename(path)
      path.gsub("#{docs_dir}/", "")
    end
  end
end
