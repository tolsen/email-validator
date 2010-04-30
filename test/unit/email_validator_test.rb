# Copyright (c) 2010 Lime Labs LLC

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'test/unit'

require File.dirname(__FILE__) + '/../../lib/email_validator'

class EmailValidatorTest < Test::Unit::TestCase

  def assert_not_valid_email email
    assert(!EmailValidator.valid_email?(email),
           "#{email} expected to not be valid")
  end
  
  def assert_valid_email email
    assert EmailValidator.valid_email?(email), "#{email} expected to be valid"
  end

  def test_simple_email
    assert_valid_email 'tim@limebits.com'
    assert_valid_email 'a@b.c'
  end

  def test_local_part_no_beginning_period
    assert_not_valid_email '.a@b.c'
  end

  def test_local_part_no_trailing_period
    assert_not_valid_email 'a.@b.c'
  end

  def test_local_part_no_consecutive_periods
    assert_not_valid_email 'a..b@c.d'
  end

  def test_local_part_inner_period_allowed
    assert_valid_email 'a.b@c.d'
  end

  def test_local_part_inner_non_consecutive_periods_allowed
    assert_valid_email 'a.b.c@d.e'
  end

  def test_local_part_some_strange_chars_allowed
    assert_valid_email '!#$%@c.d'
  end

  def test_local_part_other_strange_char_not_allowed
    assert_not_valid_email 'a@a@c.d'
    assert_not_valid_email 'a(b)@c.d'
  end

  def test_local_part_up_to_64_chars
    assert_valid_email "#{'a' * 64}@b.c"
  end
  
  def test_local_part_over_64_chars
    assert_not_valid_email "#{'a' * 65}@b.c"
  end

  def test_domain_one_subdomain_invalid
    assert_not_valid_email 'a@b'
  end

  def test_domain_trailing_period_allowed
    assert_valid_email 'a@b.c.'
  end

  def test_subdomain_no_leading_hyphen
    assert_not_valid_email 'a@-b.c'
  end

  def test_subdomain_no_trailing_hyphen
    assert_not_valid_email 'a@b-.c'
  end

  def test_subdomain_inner_hyphen_allowed
    assert_valid_email 'a@b-c.d'
  end

  def test_subdomain_consecutive_hyphens_allowed
    assert_valid_email 'a@b--c.d'
  end

  def test_over_two_subdomains_allowed
    assert_valid_email 'a@b.c.d'
    assert_valid_email 'a@b.c.d.e'
  end

  def test_email_up_to_254_chars_allowed
    assert_valid_email "a@#{'b' * 250}.c"
  end
    
  def test_email_up_over_254_chars_not_allowed
    assert_not_valid_email "a@#{'b' * 251}.c"
  end
    
end
