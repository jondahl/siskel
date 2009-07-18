require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'fixtures/test_mediainfo_results'
require 'lib/siskel'

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
    
    should "raise an exception if neither file nor raw results are provided" do
      assert_raises ArgumentError do
        results = Siskel.review
      end
    end
    
    should "raise an exception if file not found" do
      assert_raises ArgumentError do
        results = Siskel.review(:file => 'fixtures/not_there.mp4')
      end
    end
    
    context "results" do
      setup do
        @results = Siskel.review(:raw_response => TestMediainfoResults.triple_figures)
      end
      
      should "have general attributes" do
        assert @results[:general]
        assert @results[:video]
        assert @results[:audio][:format]
      end
    end
    
    context "compatibility" do
      # TODO: add suite of compatibility tests
      # should_inspect_media :file => 'file'
      # should_inspect_media :response => 'response' 
    end
  end
end
