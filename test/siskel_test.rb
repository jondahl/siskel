require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'fixtures/test_mediainfo_results'
require '../lib/siskel'

class SiskelTest < Test::Unit::TestCase
  
  context "Siskel reviewer" do
    should "return a results hash with raw results" do
      results = Siskel.review(:raw_response => TestMediainfoResults.triple_figures)
      assert_equal Hash, results.class
    end
    
    should "return a results hash when passed a file" do
      results = Siskel.review(:file => 'fixtures/tiny.mp4')
      assert_equal Hash, results.class
    end
    
    context "results" do
      setup do
        @results = Siskel.review(:raw_response => TestMediainfoResults.triple_figures)
      end
      
      should "have general attributes" do
        assert @results[:format]
        puts @results.inspect
        assert @results[:video]
        assert @results[:audio]
      end
    end
    
    context "compatibility" do
      # should_inspect_media :file => 'file'
      # should_inspect_media :response => 'response' 
    end
  end
end
