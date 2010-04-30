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

module EmailValidator

  unless defined? LOCAL_PART_ATEXT
    MAX_SIZE_LOCAL_PART = 64

    # optimized out by overall email size
#    MAX_SIZE_DOMAIN = 255 

    MAX_SIZE_EMAIL = 254
    
    LOCAL_PART_ALLOWED_SPECIAL_CHARS = '!#$%&\'*+/=?^_`{|}~-'
    LOCAL_PART_ATEXT = "[[:alnum:]#{LOCAL_PART_ALLOWED_SPECIAL_CHARS}]"
    LOCAL_PART_ATOM = "#{LOCAL_PART_ATEXT}+"
    LOCAL_PART_DOT_ATOM = "#{LOCAL_PART_ATOM}(\\.#{LOCAL_PART_ATOM})*"
    
    SUBDOMAIN = "[[:alnum:]]+([-[:alnum:]]+[[:alnum:]])?"
    DOMAIN = "(#{SUBDOMAIN}\\.)+#{SUBDOMAIN}\\.?"

    LENGTH_CHECK = "(?=.{1,#{MAX_SIZE_EMAIL}}$)(?=.{1,#{MAX_SIZE_LOCAL_PART}}\@.+$)"

    EMAIL = "#{LENGTH_CHECK}#{LOCAL_PART_DOT_ATOM}\@#{DOMAIN}"

    EMAIL_RX = /^#{EMAIL}$/
  end
  
  def self.valid_email?(email) !!EMAIL_RX.match(email); end

end
