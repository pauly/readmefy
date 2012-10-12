require 'test/unit'
require 'readmefy'

# Only testing that the main method returns true right now
class ReadmefyTest < Test::Unit::TestCase
  def test_test
    assert Readmefy.go == true
  end
end
