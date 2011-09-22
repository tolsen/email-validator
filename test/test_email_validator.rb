require 'helper'

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
    assert_valid_email '!#$%&\'*+-/=?^_`{|}~@c.d'
  end

  def test_local_part_other_strange_char_not_allowed
    assert_not_valid_email 'a@a@c.d'
    assert_not_valid_email 'a(b)@c.d'

    # backslashes (quoted parts) currently not supported
    assert_not_valid_email 'a\b@c.d'
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
