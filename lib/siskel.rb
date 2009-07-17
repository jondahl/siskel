class Siskel

  #   results = Siskel.review(:file => 'path/to/myfile.mov')
  #   results[:format]              # => 'MPEG-4'
  #   results[:video][:frame_rate]  # => '29.970 fps'
  
  class << self
    def review(options = {})
      raise ArgumentError, "Must supply either an input file or a pregenerated response" if options[:raw_response].nil? and options[:file].nil?
    
      parse_results(options[:raw_response] || `mediainfo #{options[:file]}`)
    end
  
    def parse_results(mediainfo_results)
      
      mediainfo_results.split("\n").inject({}) do |siskel_results, row|
        key, value = parse_row(row)
        siskel_results[key] = value if key and value
        siskel_results
      end
    end
    
    def parse_row(row)
      results = /(.*) : (.*)/.match(row)
      return make_key(results[1]), results[2].strip if results
    end
    
    def make_key(str)
      str.strip.gsub(/[\(\)]/, "").gsub(/\W+/, "_").gsub(/_$/, "").downcase.to_sym
    end
  end
end
