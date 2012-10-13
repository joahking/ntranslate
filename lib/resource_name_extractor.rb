module ResourceNameExtractor
  def self.get_names(hash={}, options={})
    options[:names] ||= {}

    hash.each do |k,v|
      prefix = options[:prefix] ? [options[:prefix], k].join(".") : k

      if v.kind_of? Hash
        get_names v, options.merge(:prefix => prefix)
      else
        options[:names][prefix] = v
      end
    end

    options[:names]
  end
end
