module ResourceNameExtractor
  def self.traverse(hash={}, options={}, &block)
    hash.each do |k,v|
      prefix = options[:prefix] ? [options[:prefix], k].join(".") : k

      if v.kind_of? Hash
        traverse v, options.merge(:prefix => prefix), &block
      elsif v.kind_of? Array
        yield :type => Array, :key => prefix, :value => v.join("\n")
      else
        yield :type => String, :key => prefix, :value => v
      end
    end
  end
end
