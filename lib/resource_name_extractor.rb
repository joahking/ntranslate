module ResourceNameExtractor
  def self.get_names(hash={}, options={})
    options[:names] ||= {}

    hash.each do |k,v|
      prefix = options[:prefix] ? [options[:prefix], k].join(".") : k

      if v.kind_of? Hash
        get_names v, options.merge(:prefix => prefix)
      elsif v.kind_of? Array
        options[:names][prefix] = v.join("\n")
      else
        options[:names][prefix] = v
      end
    end

    options[:names]
  end
end
