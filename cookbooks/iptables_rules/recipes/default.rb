#
# Cookbook Name:: iptables_rules
# Recipe:: default
#
# Copyright 2013, Hiroaki Nakamura
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

# Allow any established connections to continue, even
# if they would be in violation of other rules.
simple_iptables_rule "system" do
  rule "-m conntrack --ctstate ESTABLISHED,RELATED"
  jump "ACCEPT"
end

# Allow ICMP
simple_iptables_rule "icmp" do
  rule "-p icmp"
  jump "ACCEPT"
end

# Allow loopback
simple_iptables_rule "loopback" do
  rule "-i lo"
  jump "ACCEPT"
end

# Allow SSH
simple_iptables_rule "ssh" do
  rule "-m state --state NEW -m tcp -p tcp --dport 22"
  jump "ACCEPT"
end

# Allow HTTP, HTTPS
simple_iptables_rule "http" do
  rule [ "--proto tcp --dport 80",
         "--proto tcp --dport 443" ]
  jump "ACCEPT"
end

# Reject
simple_iptables_rule "system" do
  rule ""
  jump "REJECT --reject-with icmp-host-prohibited"
end
simple_iptables_rule "system" do
  direction "FORWARD"
  rule ""
  jump "REJECT --reject-with icmp-host-prohibited"
end
