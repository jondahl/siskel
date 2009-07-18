require 'ruby-debug'
class Siskel

  #   results = Siskel.review(:file => 'path/to/myfile.mov')
  #   results[:format]              # => 'MPEG-4'
  #   results[:video][:frame_rate]  # => '29.970 fps'
  
  class << self
    def review(options = {})
      raise ArgumentError, "Must supply either an input file or a pregenerated response" if options[:raw_response].nil? and options[:file].nil?
      raise ArgumentError, "File not found: #{options[:file]}" if options[:file] and !FileTest.exist?(options[:file])
      parse_results(options[:raw_response] || `mediainfo #{options[:file]}`)
    end
  
    def parse_results(mediainfo_results)
      mediainfo_results.split("\n").inject({}) do |siskel_results, row|
        result = parse_row(row)
        if result.is_a?(Symbol)
          @prefix = result
          siskel_results[@prefix] ||= {}
        elsif result.is_a?(Hash)
          if @prefix.nil?
            siskel_results[result.keys.first] = result.values.first
          else
            siskel_results[@prefix][result.keys.first] = result.values.first
          end
        end
        siskel_results
      end
    end
    
    def parse_row(row)
      results = /(.*) : (.*)/.match(row)
      if results
        return { make_key(results[1]) => results[2].strip }
      elsif row =~ /\w+/ && row !=~ /General/i
        return row.strip.downcase.to_sym
      end
    end
    
    def make_key(str)
      str.strip.gsub(/[\(\)]/, "").gsub(/\W+/, "_").gsub(/_$/, "").downcase.to_sym
    end
  end
end
