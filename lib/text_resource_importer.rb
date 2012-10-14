module TextResourceImporter
  def self.import_yaml_file_into_project(file, project, options={})
    language = options[:language] || project.master_language
    data = YAML.load_file(file)
    data = data[language] if data[language]

    traverse(data) do |args|
      tr = TextResource.find_or_initialize_by_key_and_project_id(args[:key], project.id)
      tr.send :"content_#{language}=", args[:value]
      tr.array = args[:type] == Array
      begin
        tr.save!
      rescue
        puts "Couldn't save resource (#{language}): #{args[:key]}, text: #{args[:value]}, error: #{tr.errors.messages.inspect}"
      end
    end
  end

  def self.traverse(hash={}, options={}, &block)
    hash.each do |k,v|
      prefix = options[:prefix] ? [options[:prefix], k].join(".") : k

      if v.kind_of? Hash
        traverse v, options.merge(:prefix => prefix), &block
      elsif v.kind_of? Array
        yield :type => Array, :key => prefix, :value => v.join("\n")
      elsif v.present?
        yield :type => String, :key => prefix, :value => v
      end
    end
  end
end
