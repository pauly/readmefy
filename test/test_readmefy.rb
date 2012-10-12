require 'test/unit'
require 'readmefy'

class ReadmefyTest < Test::Unit::TestCase
  def test_test
    assert Readmefy.go == true
  end
end
