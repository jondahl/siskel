require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'fixtures/test_mediainfo_results'
require '../lib/siskel'

class SiskelTest < Test::Unit::TestCase
  
  context "The Siskel inspector" do
    should "return a results hash with raw results" do
      results = Siskel.review(:raw_response => TestMediainfoResults.triple_figures)
      assert_equal Hash, results.class
    end
    
    should "return a results hash when passed a file" do
      results = Siskel.review(:file => 'fixtures/tiny.mp4')
      assert_equal Hash, results.class
    end
  end
end
