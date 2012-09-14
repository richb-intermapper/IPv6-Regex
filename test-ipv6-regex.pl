#! /usr/bin/perl 

# Test suite for IPv6 address validation Regular Expressions
# Rich Brown <richard.e.brown@dartware.com> 
# see also InterMapper Knowledge Base for links to python, 
# javascript, php, ruby, java implementations
# http://forums.dartware.com/viewtopic.php?t=452 for 

# Run this program. Successful tests will print as "."
# Unsuccessful tests will display the address and 
# whether it should have been declared correct or not.

# NB When using any of these REs, the candidate string should be stripped of white space
# and also of any /## subnet mask

# Thanks to the following:

# Stephen Ryan, Dartware, for starting this project 
#	http://forums.dartware.com/viewtopic.php?t=452
# Christoph Petschnig for a Ruby implementation of the same 
#	http://gist.github.com/294476
# Aeron for a shorter RE, and for Java and Ruby RE's 
#	(NB The RE does not always ignore whitespace before or after the IPv6 address)
# Phil Pennock who submitted a RE generated automatically from the full grammar in RFC3986 
#	http://people.spodhuis.org/phil.pennock/software/emit_ipv6_regexp-0.304
# Salvador Fandiño García who provides the CPAN module Regexp::IPv6 at
#	http://search.cpan.org/~salva/Regexp-IPv6-0.03/lib/Regexp/IPv6.pm

# Updated 26-27 Apr 2010 to use improved/fixed aeron RE
# Updated 22 Oct 2010 to add test cases from crisp
# Updated 26 May 2011 Factored to test all RE's each time; 
#                     Added tests for combinations of "0" and "::"
#                     Removed test strings with whitespace
#
# Notes:
#
# - The Perl Regex::IPv6 does not distinguish IPv4 in IPv6 addresses whose octets have 
#   leading zero's, such as "::FFFF:192.168.1.013" This is not strictly an error,
#   but should probably be disallowed because varying implementations differ on whether
#   to treat the final octet above ("013") as base 10 (0xD) or base 8 (0x0B).
# - All regexes tested fail to detect suspect IPv4 in IPv6 addresses, such as 1::1.2.3.4 
#	(Although the RFC fails to explicitly deprecate this form, it mentions that 
#   representations would be ::1.2.3.4 or ::FFFF:1.2.3.4)

use Regexp::IPv6 qw($IPv6_re); # http://search.cpan.org/~salva/Regexp-IPv6-0.03/lib/Regexp/IPv6.pm
use Net::IPv6Addr;

$dartware = qr/^\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(%.+)?\s*$/;
$philpennock = qr/^(?:(?:(?:(?:(?:(?:(?:[0-9a-fA-F]{1,4})):){6})(?:(?:(?:(?:(?:[0-9a-fA-F]{1,4})):(?:(?:[0-9a-fA-F]{1,4})))|(?:(?:(?:(?:(?:25[0-5]|(?:[1-9]|1[0-9]|2[0-4])?[0-9]))\.){3}(?:(?:25[0-5]|(?:[1-9]|1[0-9]|2[0-4])?[0-9])))))))|(?:(?:::(?:(?:(?:[0-9a-fA-F]{1,4})):){5})(?:(?:(?:(?:(?:[0-9a-fA-F]{1,4})):(?:(?:[0-9a-fA-F]{1,4})))|(?:(?:(?:(?:(?:25[0-5]|(?:[1-9]|1[0-9]|2[0-4])?[0-9]))\.){3}(?:(?:25[0-5]|(?:[1-9]|1[0-9]|2[0-4])?[0-9])))))))|(?:(?:(?:(?:(?:[0-9a-fA-F]{1,4})))?::(?:(?:(?:[0-9a-fA-F]{1,4})):){4})(?:(?:(?:(?:(?:[0-9a-fA-F]{1,4})):(?:(?:[0-9a-fA-F]{1,4})))|(?:(?:(?:(?:(?:25[0-5]|(?:[1-9]|1[0-9]|2[0-4])?[0-9]))\.){3}(?:(?:25[0-5]|(?:[1-9]|1[0-9]|2[0-4])?[0-9])))))))|(?:(?:(?:(?:(?:(?:[0-9a-fA-F]{1,4})):){0,1}(?:(?:[0-9a-fA-F]{1,4})))?::(?:(?:(?:[0-9a-fA-F]{1,4})):){3})(?:(?:(?:(?:(?:[0-9a-fA-F]{1,4})):(?:(?:[0-9a-fA-F]{1,4})))|(?:(?:(?:(?:(?:25[0-5]|(?:[1-9]|1[0-9]|2[0-4])?[0-9]))\.){3}(?:(?:25[0-5]|(?:[1-9]|1[0-9]|2[0-4])?[0-9])))))))|(?:(?:(?:(?:(?:(?:[0-9a-fA-F]{1,4})):){0,2}(?:(?:[0-9a-fA-F]{1,4})))?::(?:(?:(?:[0-9a-fA-F]{1,4})):){2})(?:(?:(?:(?:(?:[0-9a-fA-F]{1,4})):(?:(?:[0-9a-fA-F]{1,4})))|(?:(?:(?:(?:(?:25[0-5]|(?:[1-9]|1[0-9]|2[0-4])?[0-9]))\.){3}(?:(?:25[0-5]|(?:[1-9]|1[0-9]|2[0-4])?[0-9])))))))|(?:(?:(?:(?:(?:(?:[0-9a-fA-F]{1,4})):){0,3}(?:(?:[0-9a-fA-F]{1,4})))?::(?:(?:[0-9a-fA-F]{1,4})):)(?:(?:(?:(?:(?:[0-9a-fA-F]{1,4})):(?:(?:[0-9a-fA-F]{1,4})))|(?:(?:(?:(?:(?:25[0-5]|(?:[1-9]|1[0-9]|2[0-4])?[0-9]))\.){3}(?:(?:25[0-5]|(?:[1-9]|1[0-9]|2[0-4])?[0-9])))))))|(?:(?:(?:(?:(?:(?:[0-9a-fA-F]{1,4})):){0,4}(?:(?:[0-9a-fA-F]{1,4})))?::)(?:(?:(?:(?:(?:[0-9a-fA-F]{1,4})):(?:(?:[0-9a-fA-F]{1,4})))|(?:(?:(?:(?:(?:25[0-5]|(?:[1-9]|1[0-9]|2[0-4])?[0-9]))\.){3}(?:(?:25[0-5]|(?:[1-9]|1[0-9]|2[0-4])?[0-9])))))))|(?:(?:(?:(?:(?:(?:[0-9a-fA-F]{1,4})):){0,5}(?:(?:[0-9a-fA-F]{1,4})))?::)(?:(?:[0-9a-fA-F]{1,4})))|(?:(?:(?:(?:(?:(?:[0-9a-fA-F]{1,4})):){0,6}(?:(?:[0-9a-fA-F]{1,4})))?::))))$/;
# Works with all versions of Perl
$aeron = qr/^(((?=(?>.*?::)(?!.*::)))(::)?([0-9A-F]{1,4}::?){0,5}|([0-9A-F]{1,4}:){6})(\2([0-9A-F]{1,4}(::?|$)){0,2}|((25[0-5]|(2[0-4]|1[0-9]|[1-9])?[0-9])(\.|$)){4}|[0-9A-F]{1,4}:[0-9A-F]{1,4})(?<![^:]:)(?<!\.)\z/i;
# Next RE requires Perl 5.10+
#$aeron2 = qr/^(((?=(?>.*?::)(?!.*::)))(::)?(([0-9A-F]{1,4})::?){0,5}|((?5):){6})(\2((?5)(::?|$)){0,2}|((25[0-5]|(2[0-4]|1[0-9]|[1-9])?[0-9])(\.|$)){4}|(?5):(?5))(?<![^:]:)(?<!\.)\z/i

$numTested = 0;
$numFailed = 0;

print "\n";
print "IPv6 Regular Expression Tester:\n\n";
print "Each '.' represents a successful test.\n";
print "Incorrect tests print the failing address\n";

# This is the place to add your favorite Regular Expression. 

  $theRE = $dartware;      $theREname = "Dartware";     testall();
  $theRE = qr/^$IPv6_re$/; $theREname = "Regex::IPv6";  testall();
  $theRE = $philpennock;   $theREname = "Phil Pennock"; testall();
  $theRE = $aeron;         $theREname = "aeron"; 		testall();
#  $theRE = $aeron2;        $theREname = "aeron2";       testall();


# Test routine - test the supplied against whether it should be good or not.
sub ipv6test 
{ 
  my($bool,$addr) = @_; 
  my($isit, $count); 

  $isit = $addr =~ $theRE; # Test the RE here
  
  $numTested = $numTested+1;
  if ($isit == $bool) { print ("."); } 
  else { 
	print "\nFAILED: '$addr' should"; 
	print $bool ? " " : " not "; 
	print "be valid\n"; 
	$numFailed = $numFailed+1;
  } 
} 

# test each of the test cases against the passed in RE
sub testall
{

# print $IPv6_re;
print "==================================================\n";
print "Testing Regex: " . $theREname . "\n";
$numTested = 0;
$numFailed = 0;

# The test cases...

ipv6test(!1,"");# empty string 
ipv6test(1,"::1");# loopback, compressed, non-routable 
ipv6test(1,"::");# unspecified, compressed, non-routable 
ipv6test(1,"0:0:0:0:0:0:0:1");# loopback, full 
ipv6test(1,"0:0:0:0:0:0:0:0");# unspecified, full 
ipv6test(1,"2001:DB8:0:0:8:800:200C:417A");# unicast, full 
ipv6test(1,"FF01:0:0:0:0:0:0:101");# multicast, full 
ipv6test(1,"2001:DB8::8:800:200C:417A");# unicast, compressed 
ipv6test(1,"FF01::101");# multicast, compressed 
ipv6test(!1,"2001:DB8:0:0:8:800:200C:417A:221");# unicast, full 
ipv6test(!1,"FF01::101::2");# multicast, compressed 
ipv6test(1,"fe80::217:f2ff:fe07:ed62");

ipv6test(1,"2001:0000:1234:0000:0000:C1C0:ABCD:0876");
ipv6test(1,"3ffe:0b00:0000:0000:0001:0000:0000:000a");
ipv6test(1,"FF02:0000:0000:0000:0000:0000:0000:0001");
ipv6test(1,"0000:0000:0000:0000:0000:0000:0000:0001");
ipv6test(1,"0000:0000:0000:0000:0000:0000:0000:0000");
ipv6test(!1,"02001:0000:1234:0000:0000:C1C0:ABCD:0876");	# extra 0 not allowed! 
ipv6test(!1,"2001:0000:1234:0000:00001:C1C0:ABCD:0876");	# extra 0 not allowed! 
#ipv6test(1," 2001:0000:1234:0000:0000:C1C0:ABCD:0876");		# leading space
#ipv6test(1,"2001:0000:1234:0000:0000:C1C0:ABCD:0876");		# trailing space
#ipv6test(1," 2001:0000:1234:0000:0000:C1C0:ABCD:0876  ");	# leading and trailing space
ipv6test(!1,"2001:0000:1234:0000:0000:C1C0:ABCD:0876  0");	# junk after valid address
ipv6test(!1,"2001:0000:1234: 0000:0000:C1C0:ABCD:0876");	# internal space

ipv6test(!1,"3ffe:0b00:0000:0001:0000:0000:000a");			# seven segments
ipv6test(!1,"FF02:0000:0000:0000:0000:0000:0000:0000:0001");	# nine segments
ipv6test(!1,"3ffe:b00::1::a");								# double "::"
ipv6test(!1,"::1111:2222:3333:4444:5555:6666::");			# double "::"
ipv6test(1,"2::10");
ipv6test(1,"ff02::1");
ipv6test(1,"fe80::");
ipv6test(1,"2002::");
ipv6test(1,"2001:db8::");
ipv6test(1,"2001:0db8:1234::");
ipv6test(1,"::ffff:0:0");
ipv6test(1,"::1");
ipv6test(1,"1:2:3:4:5:6:7:8");
ipv6test(1,"1:2:3:4:5:6::8");
ipv6test(1,"1:2:3:4:5::8");
ipv6test(1,"1:2:3:4::8");
ipv6test(1,"1:2:3::8");
ipv6test(1,"1:2::8");
ipv6test(1,"1::8");
ipv6test(1,"1::2:3:4:5:6:7");
ipv6test(1,"1::2:3:4:5:6");
ipv6test(1,"1::2:3:4:5");
ipv6test(1,"1::2:3:4");
ipv6test(1,"1::2:3");
ipv6test(1,"1::8");
ipv6test(1,"::2:3:4:5:6:7:8");
ipv6test(1,"::2:3:4:5:6:7");
ipv6test(1,"::2:3:4:5:6");
ipv6test(1,"::2:3:4:5");
ipv6test(1,"::2:3:4");
ipv6test(1,"::2:3");
ipv6test(1,"::8");
ipv6test(1,"1:2:3:4:5:6::");
ipv6test(1,"1:2:3:4:5::");
ipv6test(1,"1:2:3:4::");
ipv6test(1,"1:2:3::");
ipv6test(1,"1:2::");
ipv6test(1,"1::");
ipv6test(1,"1:2:3:4:5::7:8");
ipv6test(!1,"1:2:3::4:5::7:8");							# Double "::"
ipv6test(!1,"12345::6:7:8");
ipv6test(1,"1:2:3:4::7:8");
ipv6test(1,"1:2:3::7:8");
ipv6test(1,"1:2::7:8");
ipv6test(1,"1::7:8");

# IPv4 addresses as dotted-quads
ipv6test(1,"1:2:3:4:5:6:1.2.3.4");
ipv6test(1,"1:2:3:4:5::1.2.3.4");
ipv6test(1,"1:2:3:4::1.2.3.4");
ipv6test(1,"1:2:3::1.2.3.4");
ipv6test(1,"1:2::1.2.3.4");
ipv6test(1,"1::1.2.3.4");
ipv6test(1,"1:2:3:4::5:1.2.3.4");
ipv6test(1,"1:2:3::5:1.2.3.4");
ipv6test(1,"1:2::5:1.2.3.4");
ipv6test(1,"1::5:1.2.3.4");
ipv6test(1,"1::5:11.22.33.44");
ipv6test(!1,"1::5:400.2.3.4");
ipv6test(!1,"1::5:260.2.3.4");
ipv6test(!1,"1::5:256.2.3.4");
ipv6test(!1,"1::5:1.256.3.4");
ipv6test(!1,"1::5:1.2.256.4");
ipv6test(!1,"1::5:1.2.3.256");
ipv6test(!1,"1::5:300.2.3.4");
ipv6test(!1,"1::5:1.300.3.4");
ipv6test(!1,"1::5:1.2.300.4");
ipv6test(!1,"1::5:1.2.3.300");
ipv6test(!1,"1::5:900.2.3.4");
ipv6test(!1,"1::5:1.900.3.4");
ipv6test(!1,"1::5:1.2.900.4");
ipv6test(!1,"1::5:1.2.3.900");
ipv6test(!1,"1::5:300.300.300.300");
ipv6test(!1,"1::5:3000.30.30.30");
ipv6test(!1,"1::400.2.3.4");
ipv6test(!1,"1::260.2.3.4");
ipv6test(!1,"1::256.2.3.4");
ipv6test(!1,"1::1.256.3.4");
ipv6test(!1,"1::1.2.256.4");
ipv6test(!1,"1::1.2.3.256");
ipv6test(!1,"1::300.2.3.4");
ipv6test(!1,"1::1.300.3.4");
ipv6test(!1,"1::1.2.300.4");
ipv6test(!1,"1::1.2.3.300");
ipv6test(!1,"1::900.2.3.4");
ipv6test(!1,"1::1.900.3.4");
ipv6test(!1,"1::1.2.900.4");
ipv6test(!1,"1::1.2.3.900");
ipv6test(!1,"1::300.300.300.300");
ipv6test(!1,"1::3000.30.30.30");
ipv6test(!1,"::400.2.3.4");
ipv6test(!1,"::260.2.3.4");
ipv6test(!1,"::256.2.3.4");
ipv6test(!1,"::1.256.3.4");
ipv6test(!1,"::1.2.256.4");
ipv6test(!1,"::1.2.3.256");
ipv6test(!1,"::300.2.3.4");
ipv6test(!1,"::1.300.3.4");
ipv6test(!1,"::1.2.300.4");
ipv6test(!1,"::1.2.3.300");
ipv6test(!1,"::900.2.3.4");
ipv6test(!1,"::1.900.3.4");
ipv6test(!1,"::1.2.900.4");
ipv6test(!1,"::1.2.3.900");
ipv6test(!1,"::300.300.300.300");
ipv6test(!1,"::3000.30.30.30");
ipv6test(1,"fe80::217:f2ff:254.7.237.98");
ipv6test(1,"::ffff:192.168.1.26");
ipv6test(!1,"2001:1:1:1:1:1:255Z255X255Y255");				# garbage instead of "." in IPv4
ipv6test(!1,"::ffff:192x168.1.26");							# ditto
ipv6test(1,"::ffff:192.168.1.1");
ipv6test(1,"0:0:0:0:0:0:13.1.68.3");# IPv4-compatible IPv6 address, full, deprecated 
ipv6test(1,"0:0:0:0:0:FFFF:129.144.52.38");# IPv4-mapped IPv6 address, full 
ipv6test(1,"::13.1.68.3");# IPv4-compatible IPv6 address, compressed, deprecated 
ipv6test(1,"::FFFF:129.144.52.38");# IPv4-mapped IPv6 address, compressed 
ipv6test(1,"fe80:0:0:0:204:61ff:254.157.241.86");
ipv6test(1,"fe80::204:61ff:254.157.241.86");
ipv6test(1,"::ffff:12.34.56.78");
ipv6test(!1,"::ffff:2.3.4");
ipv6test(!1,"::ffff:257.1.2.3");
ipv6test(!1,"1.2.3.4");

ipv6test(!1,"1.2.3.4:1111:2222:3333:4444::5555");  # Aeron
ipv6test(!1,"1.2.3.4:1111:2222:3333::5555");
ipv6test(!1,"1.2.3.4:1111:2222::5555");
ipv6test(!1,"1.2.3.4:1111::5555");
ipv6test(!1,"1.2.3.4::5555");
ipv6test(!1,"1.2.3.4::");

# Testing IPv4 addresses represented as dotted-quads
# Leading zero's in IPv4 addresses not allowed: some systems treat the leading "0" in ".086" as the start of an octal number
# Update: The BNF in RFC-3986 explicitly defines the dec-octet (for IPv4 addresses) not to have a leading zero
ipv6test(!1,"fe80:0000:0000:0000:0204:61ff:254.157.241.086");
ipv6test(1,"::ffff:192.0.2.128");   # but this is OK, since there's a single digit
ipv6test(!1,"XXXX:XXXX:XXXX:XXXX:XXXX:XXXX:1.2.3.4");
ipv6test(!1,"1111:2222:3333:4444:5555:6666:00.00.00.00");
ipv6test(!1,"1111:2222:3333:4444:5555:6666:000.000.000.000");
ipv6test(!1,"1111:2222:3333:4444:5555:6666:256.256.256.256");

# Not testing address with subnet mask
# ipv6test(1,"2001:0DB8:0000:CD30:0000:0000:0000:0000/60");# full, with prefix 
# ipv6test(1,"2001:0DB8::CD30:0:0:0:0/60");# compressed, with prefix 
# ipv6test(1,"2001:0DB8:0:CD30::/60");# compressed, with prefix #2 
# ipv6test(1,"::/128");# compressed, unspecified address type, non-routable 
# ipv6test(1,"::1/128");# compressed, loopback address type, non-routable 
# ipv6test(1,"FF00::/8");# compressed, multicast address type 
# ipv6test(1,"FE80::/10");# compressed, link-local unicast, non-routable 
# ipv6test(1,"FEC0::/10");# compressed, site-local unicast, deprecated 
# ipv6test(!1,"124.15.6.89/60");# standard IPv4, prefix not allowed 

ipv6test(1,"fe80:0000:0000:0000:0204:61ff:fe9d:f156");
ipv6test(1,"fe80:0:0:0:204:61ff:fe9d:f156");
ipv6test(1,"fe80::204:61ff:fe9d:f156");
ipv6test(1,"::1");
ipv6test(1,"fe80::");
ipv6test(1,"fe80::1");
ipv6test(!1,":");
ipv6test(1,"::ffff:c000:280");

# Aeron supplied these test cases
ipv6test(!1,"1111:2222:3333:4444::5555:");
ipv6test(!1,"1111:2222:3333::5555:");
ipv6test(!1,"1111:2222::5555:");
ipv6test(!1,"1111::5555:");
ipv6test(!1,"::5555:");
ipv6test(!1,":::");
ipv6test(!1,"1111:");
ipv6test(!1,":");

ipv6test(!1,":1111:2222:3333:4444::5555");
ipv6test(!1,":1111:2222:3333::5555");
ipv6test(!1,":1111:2222::5555");
ipv6test(!1,":1111::5555");
ipv6test(!1,":::5555");
ipv6test(!1,":::");


# Additional test cases
# from http://rt.cpan.org/Public/Bug/Display.html?id=50693

ipv6test(1,"2001:0db8:85a3:0000:0000:8a2e:0370:7334");
ipv6test(1,"2001:db8:85a3:0:0:8a2e:370:7334");
ipv6test(1,"2001:db8:85a3::8a2e:370:7334");
ipv6test(1,"2001:0db8:0000:0000:0000:0000:1428:57ab");
ipv6test(1,"2001:0db8:0000:0000:0000::1428:57ab");
ipv6test(1,"2001:0db8:0:0:0:0:1428:57ab");
ipv6test(1,"2001:0db8:0:0::1428:57ab");
ipv6test(1,"2001:0db8::1428:57ab");
ipv6test(1,"2001:db8::1428:57ab");
ipv6test(1,"0000:0000:0000:0000:0000:0000:0000:0001");
ipv6test(1,"::1");
ipv6test(1,"::ffff:0c22:384e");
ipv6test(1,"2001:0db8:1234:0000:0000:0000:0000:0000");
ipv6test(1,"2001:0db8:1234:ffff:ffff:ffff:ffff:ffff");
ipv6test(1,"2001:db8:a::123");
ipv6test(1,"fe80::");

ipv6test(!1,"123");
ipv6test(!1,"ldkfj");
ipv6test(!1,"2001::FFD3::57ab");
ipv6test(!1,"2001:db8:85a3::8a2e:37023:7334");
ipv6test(!1,"2001:db8:85a3::8a2e:370k:7334");
ipv6test(!1,"1:2:3:4:5:6:7:8:9");
ipv6test(!1,"1::2::3");
ipv6test(!1,"1:::3:4:5");
ipv6test(!1,"1:2:3::4:5:6:7:8:9");

# New from Aeron 
ipv6test(1,"1111:2222:3333:4444:5555:6666:7777:8888");
ipv6test(1,"1111:2222:3333:4444:5555:6666:7777::");
ipv6test(1,"1111:2222:3333:4444:5555:6666::");
ipv6test(1,"1111:2222:3333:4444:5555::");
ipv6test(1,"1111:2222:3333:4444::");
ipv6test(1,"1111:2222:3333::");
ipv6test(1,"1111:2222::");
ipv6test(1,"1111::");
# ipv6test(1,"::");     #duplicate
ipv6test(1,"1111:2222:3333:4444:5555:6666::8888");
ipv6test(1,"1111:2222:3333:4444:5555::8888");
ipv6test(1,"1111:2222:3333:4444::8888");
ipv6test(1,"1111:2222:3333::8888");
ipv6test(1,"1111:2222::8888");
ipv6test(1,"1111::8888");
ipv6test(1,"::8888");
ipv6test(1,"1111:2222:3333:4444:5555::7777:8888");
ipv6test(1,"1111:2222:3333:4444::7777:8888");
ipv6test(1,"1111:2222:3333::7777:8888");
ipv6test(1,"1111:2222::7777:8888");
ipv6test(1,"1111::7777:8888");
ipv6test(1,"::7777:8888");
ipv6test(1,"1111:2222:3333:4444::6666:7777:8888");
ipv6test(1,"1111:2222:3333::6666:7777:8888");
ipv6test(1,"1111:2222::6666:7777:8888");
ipv6test(1,"1111::6666:7777:8888");
ipv6test(1,"::6666:7777:8888");
ipv6test(1,"1111:2222:3333::5555:6666:7777:8888");
ipv6test(1,"1111:2222::5555:6666:7777:8888");
ipv6test(1,"1111::5555:6666:7777:8888");
ipv6test(1,"::5555:6666:7777:8888");
ipv6test(1,"1111:2222::4444:5555:6666:7777:8888");
ipv6test(1,"1111::4444:5555:6666:7777:8888");
ipv6test(1,"::4444:5555:6666:7777:8888");
ipv6test(1,"1111::3333:4444:5555:6666:7777:8888");
ipv6test(1,"::3333:4444:5555:6666:7777:8888");
ipv6test(1,"::2222:3333:4444:5555:6666:7777:8888");
ipv6test(1,"1111:2222:3333:4444:5555:6666:123.123.123.123");
ipv6test(1,"1111:2222:3333:4444:5555::123.123.123.123");
ipv6test(1,"1111:2222:3333:4444::123.123.123.123");
ipv6test(1,"1111:2222:3333::123.123.123.123");
ipv6test(1,"1111:2222::123.123.123.123");
ipv6test(1,"1111::123.123.123.123");
ipv6test(1,"::123.123.123.123");
ipv6test(1,"1111:2222:3333:4444::6666:123.123.123.123");
ipv6test(1,"1111:2222:3333::6666:123.123.123.123");
ipv6test(1,"1111:2222::6666:123.123.123.123");
ipv6test(1,"1111::6666:123.123.123.123");
ipv6test(1,"::6666:123.123.123.123");
ipv6test(1,"1111:2222:3333::5555:6666:123.123.123.123");
ipv6test(1,"1111:2222::5555:6666:123.123.123.123");
ipv6test(1,"1111::5555:6666:123.123.123.123");
ipv6test(1,"::5555:6666:123.123.123.123");
ipv6test(1,"1111:2222::4444:5555:6666:123.123.123.123");
ipv6test(1,"1111::4444:5555:6666:123.123.123.123");
ipv6test(1,"::4444:5555:6666:123.123.123.123");
ipv6test(1,"1111::3333:4444:5555:6666:123.123.123.123");
ipv6test(1,"::2222:3333:4444:5555:6666:123.123.123.123");

# Playing with combinations of "0" and "::"
# NB: these are all sytactically correct, but are bad form 
#   because "0" adjacent to "::" should be combined into "::"
ipv6test(1,"::0:0:0:0:0:0:0");
ipv6test(1,"::0:0:0:0:0:0");
ipv6test(1,"::0:0:0:0:0");
ipv6test(1,"::0:0:0:0");
ipv6test(1,"::0:0:0");
ipv6test(1,"::0:0");
ipv6test(1,"::0");
ipv6test(1,"0:0:0:0:0:0:0::");
ipv6test(1,"0:0:0:0:0:0::");
ipv6test(1,"0:0:0:0:0::");
ipv6test(1,"0:0:0:0::");
ipv6test(1,"0:0:0::");
ipv6test(1,"0:0::");
ipv6test(1,"0::");

# New invalid from Aeron
# Invalid data
ipv6test(!1,"XXXX:XXXX:XXXX:XXXX:XXXX:XXXX:XXXX:XXXX");

# Too many components
ipv6test(!1,"1111:2222:3333:4444:5555:6666:7777:8888:9999");
ipv6test(!1,"1111:2222:3333:4444:5555:6666:7777:8888::");
ipv6test(!1,"::2222:3333:4444:5555:6666:7777:8888:9999");

# Too few components
ipv6test(!1,"1111:2222:3333:4444:5555:6666:7777");
ipv6test(!1,"1111:2222:3333:4444:5555:6666");
ipv6test(!1,"1111:2222:3333:4444:5555");
ipv6test(!1,"1111:2222:3333:4444");
ipv6test(!1,"1111:2222:3333");
ipv6test(!1,"1111:2222");
ipv6test(!1,"1111");

# Missing :
ipv6test(!1,"11112222:3333:4444:5555:6666:7777:8888");
ipv6test(!1,"1111:22223333:4444:5555:6666:7777:8888");
ipv6test(!1,"1111:2222:33334444:5555:6666:7777:8888");
ipv6test(!1,"1111:2222:3333:44445555:6666:7777:8888");
ipv6test(!1,"1111:2222:3333:4444:55556666:7777:8888");
ipv6test(!1,"1111:2222:3333:4444:5555:66667777:8888");
ipv6test(!1,"1111:2222:3333:4444:5555:6666:77778888");

# Missing : intended for ::
ipv6test(!1,"1111:2222:3333:4444:5555:6666:7777:8888:");
ipv6test(!1,"1111:2222:3333:4444:5555:6666:7777:");
ipv6test(!1,"1111:2222:3333:4444:5555:6666:");
ipv6test(!1,"1111:2222:3333:4444:5555:");
ipv6test(!1,"1111:2222:3333:4444:");
ipv6test(!1,"1111:2222:3333:");
ipv6test(!1,"1111:2222:");
ipv6test(!1,"1111:");
ipv6test(!1,":");
ipv6test(!1,":8888");
ipv6test(!1,":7777:8888");
ipv6test(!1,":6666:7777:8888");
ipv6test(!1,":5555:6666:7777:8888");
ipv6test(!1,":4444:5555:6666:7777:8888");
ipv6test(!1,":3333:4444:5555:6666:7777:8888");
ipv6test(!1,":2222:3333:4444:5555:6666:7777:8888");
ipv6test(!1,":1111:2222:3333:4444:5555:6666:7777:8888");

# :::
ipv6test(!1,":::2222:3333:4444:5555:6666:7777:8888");
ipv6test(!1,"1111:::3333:4444:5555:6666:7777:8888");
ipv6test(!1,"1111:2222:::4444:5555:6666:7777:8888");
ipv6test(!1,"1111:2222:3333:::5555:6666:7777:8888");
ipv6test(!1,"1111:2222:3333:4444:::6666:7777:8888");
ipv6test(!1,"1111:2222:3333:4444:5555:::7777:8888");
ipv6test(!1,"1111:2222:3333:4444:5555:6666:::8888");
ipv6test(!1,"1111:2222:3333:4444:5555:6666:7777:::");

# Double ::");
ipv6test(!1,"::2222::4444:5555:6666:7777:8888");
ipv6test(!1,"::2222:3333::5555:6666:7777:8888");
ipv6test(!1,"::2222:3333:4444::6666:7777:8888");
ipv6test(!1,"::2222:3333:4444:5555::7777:8888");
ipv6test(!1,"::2222:3333:4444:5555:7777::8888");
ipv6test(!1,"::2222:3333:4444:5555:7777:8888::");

ipv6test(!1,"1111::3333::5555:6666:7777:8888");
ipv6test(!1,"1111::3333:4444::6666:7777:8888");
ipv6test(!1,"1111::3333:4444:5555::7777:8888");
ipv6test(!1,"1111::3333:4444:5555:6666::8888");
ipv6test(!1,"1111::3333:4444:5555:6666:7777::");

ipv6test(!1,"1111:2222::4444::6666:7777:8888");
ipv6test(!1,"1111:2222::4444:5555::7777:8888");
ipv6test(!1,"1111:2222::4444:5555:6666::8888");
ipv6test(!1,"1111:2222::4444:5555:6666:7777::");

ipv6test(!1,"1111:2222:3333::5555::7777:8888");
ipv6test(!1,"1111:2222:3333::5555:6666::8888");
ipv6test(!1,"1111:2222:3333::5555:6666:7777::");

ipv6test(!1,"1111:2222:3333:4444::6666::8888");
ipv6test(!1,"1111:2222:3333:4444::6666:7777::");

ipv6test(!1,"1111:2222:3333:4444:5555::7777::");


# Too many components"
ipv6test(!1,"1111:2222:3333:4444:5555:6666:7777:8888:1.2.3.4");
ipv6test(!1,"1111:2222:3333:4444:5555:6666:7777:1.2.3.4");
ipv6test(!1,"1111:2222:3333:4444:5555:6666::1.2.3.4");
ipv6test(!1,"::2222:3333:4444:5555:6666:7777:1.2.3.4");
ipv6test(!1,"1111:2222:3333:4444:5555:6666:1.2.3.4.5");

# Too few components
ipv6test(!1,"1111:2222:3333:4444:5555:1.2.3.4");
ipv6test(!1,"1111:2222:3333:4444:1.2.3.4");
ipv6test(!1,"1111:2222:3333:1.2.3.4");
ipv6test(!1,"1111:2222:1.2.3.4");
ipv6test(!1,"1111:1.2.3.4");
ipv6test(!1,"1.2.3.4");

# Missing :
ipv6test(!1,"11112222:3333:4444:5555:6666:1.2.3.4");
ipv6test(!1,"1111:22223333:4444:5555:6666:1.2.3.4");
ipv6test(!1,"1111:2222:33334444:5555:6666:1.2.3.4");
ipv6test(!1,"1111:2222:3333:44445555:6666:1.2.3.4");
ipv6test(!1,"1111:2222:3333:4444:55556666:1.2.3.4");
ipv6test(!1,"1111:2222:3333:4444:5555:66661.2.3.4");

# Missing .
ipv6test(!1,"1111:2222:3333:4444:5555:6666:255255.255.255");
ipv6test(!1,"1111:2222:3333:4444:5555:6666:255.255255.255");
ipv6test(!1,"1111:2222:3333:4444:5555:6666:255.255.255255");

# Missing : intended for ::
ipv6test(!1,":1.2.3.4");
ipv6test(!1,":6666:1.2.3.4");
ipv6test(!1,":5555:6666:1.2.3.4");
ipv6test(!1,":4444:5555:6666:1.2.3.4");
ipv6test(!1,":3333:4444:5555:6666:1.2.3.4");
ipv6test(!1,":2222:3333:4444:5555:6666:1.2.3.4");
ipv6test(!1,":1111:2222:3333:4444:5555:6666:1.2.3.4");

# :::
ipv6test(!1,":::2222:3333:4444:5555:6666:1.2.3.4");
ipv6test(!1,"1111:::3333:4444:5555:6666:1.2.3.4");
ipv6test(!1,"1111:2222:::4444:5555:6666:1.2.3.4");
ipv6test(!1,"1111:2222:3333:::5555:6666:1.2.3.4");
ipv6test(!1,"1111:2222:3333:4444:::6666:1.2.3.4");
ipv6test(!1,"1111:2222:3333:4444:5555:::1.2.3.4");

# Double ::
ipv6test(!1,"::2222::4444:5555:6666:1.2.3.4");
ipv6test(!1,"::2222:3333::5555:6666:1.2.3.4");
ipv6test(!1,"::2222:3333:4444::6666:1.2.3.4");
ipv6test(!1,"::2222:3333:4444:5555::1.2.3.4");

ipv6test(!1,"1111::3333::5555:6666:1.2.3.4");
ipv6test(!1,"1111::3333:4444::6666:1.2.3.4");
ipv6test(!1,"1111::3333:4444:5555::1.2.3.4");

ipv6test(!1,"1111:2222::4444::6666:1.2.3.4");
ipv6test(!1,"1111:2222::4444:5555::1.2.3.4");

ipv6test(!1,"1111:2222:3333::5555::1.2.3.4");

# Missing parts
ipv6test(!1,"::.");
ipv6test(!1,"::..");
ipv6test(!1,"::...");
ipv6test(!1,"::1...");
ipv6test(!1,"::1.2..");
ipv6test(!1,"::1.2.3.");
ipv6test(!1,"::.2..");
ipv6test(!1,"::.2.3.");
ipv6test(!1,"::.2.3.4");
ipv6test(!1,"::..3.");
ipv6test(!1,"::..3.4");
ipv6test(!1,"::...4");

# Extra : in front
ipv6test(!1,":1111:2222:3333:4444:5555:6666:7777::");
ipv6test(!1,":1111:2222:3333:4444:5555:6666::");
ipv6test(!1,":1111:2222:3333:4444:5555::");
ipv6test(!1,":1111:2222:3333:4444::");
ipv6test(!1,":1111:2222:3333::");
ipv6test(!1,":1111:2222::");
ipv6test(!1,":1111::");
ipv6test(!1,":::");
ipv6test(!1,":1111:2222:3333:4444:5555:6666::8888");
ipv6test(!1,":1111:2222:3333:4444:5555::8888");
ipv6test(!1,":1111:2222:3333:4444::8888");
ipv6test(!1,":1111:2222:3333::8888");
ipv6test(!1,":1111:2222::8888");
ipv6test(!1,":1111::8888");
ipv6test(!1,":::8888");
ipv6test(!1,":1111:2222:3333:4444:5555::7777:8888");
ipv6test(!1,":1111:2222:3333:4444::7777:8888");
ipv6test(!1,":1111:2222:3333::7777:8888");
ipv6test(!1,":1111:2222::7777:8888");
ipv6test(!1,":1111::7777:8888");
ipv6test(!1,":::7777:8888");
ipv6test(!1,":1111:2222:3333:4444::6666:7777:8888");
ipv6test(!1,":1111:2222:3333::6666:7777:8888");
ipv6test(!1,":1111:2222::6666:7777:8888");
ipv6test(!1,":1111::6666:7777:8888");
ipv6test(!1,":::6666:7777:8888");
ipv6test(!1,":1111:2222:3333::5555:6666:7777:8888");
ipv6test(!1,":1111:2222::5555:6666:7777:8888");
ipv6test(!1,":1111::5555:6666:7777:8888");
ipv6test(!1,":::5555:6666:7777:8888");
ipv6test(!1,":1111:2222::4444:5555:6666:7777:8888");
ipv6test(!1,":1111::4444:5555:6666:7777:8888");
ipv6test(!1,":::4444:5555:6666:7777:8888");
ipv6test(!1,":1111::3333:4444:5555:6666:7777:8888");
ipv6test(!1,":::3333:4444:5555:6666:7777:8888");
ipv6test(!1,":::2222:3333:4444:5555:6666:7777:8888");
ipv6test(!1,":1111:2222:3333:4444:5555:6666:1.2.3.4");
ipv6test(!1,":1111:2222:3333:4444:5555::1.2.3.4");
ipv6test(!1,":1111:2222:3333:4444::1.2.3.4");
ipv6test(!1,":1111:2222:3333::1.2.3.4");
ipv6test(!1,":1111:2222::1.2.3.4");
ipv6test(!1,":1111::1.2.3.4");
ipv6test(!1,":::1.2.3.4");
ipv6test(!1,":1111:2222:3333:4444::6666:1.2.3.4");
ipv6test(!1,":1111:2222:3333::6666:1.2.3.4");
ipv6test(!1,":1111:2222::6666:1.2.3.4");
ipv6test(!1,":1111::6666:1.2.3.4");
ipv6test(!1,":::6666:1.2.3.4");
ipv6test(!1,":1111:2222:3333::5555:6666:1.2.3.4");
ipv6test(!1,":1111:2222::5555:6666:1.2.3.4");
ipv6test(!1,":1111::5555:6666:1.2.3.4");
ipv6test(!1,":::5555:6666:1.2.3.4");
ipv6test(!1,":1111:2222::4444:5555:6666:1.2.3.4");
ipv6test(!1,":1111::4444:5555:6666:1.2.3.4");
ipv6test(!1,":::4444:5555:6666:1.2.3.4");
ipv6test(!1,":1111::3333:4444:5555:6666:1.2.3.4");
ipv6test(!1,":::2222:3333:4444:5555:6666:1.2.3.4");

# Extra : at end
ipv6test(!1,"1111:2222:3333:4444:5555:6666:7777:::");
ipv6test(!1,"1111:2222:3333:4444:5555:6666:::");
ipv6test(!1,"1111:2222:3333:4444:5555:::");
ipv6test(!1,"1111:2222:3333:4444:::");
ipv6test(!1,"1111:2222:3333:::");
ipv6test(!1,"1111:2222:::");
ipv6test(!1,"1111:::");
ipv6test(!1,":::");
ipv6test(!1,"1111:2222:3333:4444:5555:6666::8888:");
ipv6test(!1,"1111:2222:3333:4444:5555::8888:");
ipv6test(!1,"1111:2222:3333:4444::8888:");
ipv6test(!1,"1111:2222:3333::8888:");
ipv6test(!1,"1111:2222::8888:");
ipv6test(!1,"1111::8888:");
ipv6test(!1,"::8888:");
ipv6test(!1,"1111:2222:3333:4444:5555::7777:8888:");
ipv6test(!1,"1111:2222:3333:4444::7777:8888:");
ipv6test(!1,"1111:2222:3333::7777:8888:");
ipv6test(!1,"1111:2222::7777:8888:");
ipv6test(!1,"1111::7777:8888:");
ipv6test(!1,"::7777:8888:");
ipv6test(!1,"1111:2222:3333:4444::6666:7777:8888:");
ipv6test(!1,"1111:2222:3333::6666:7777:8888:");
ipv6test(!1,"1111:2222::6666:7777:8888:");
ipv6test(!1,"1111::6666:7777:8888:");
ipv6test(!1,"::6666:7777:8888:");
ipv6test(!1,"1111:2222:3333::5555:6666:7777:8888:");
ipv6test(!1,"1111:2222::5555:6666:7777:8888:");
ipv6test(!1,"1111::5555:6666:7777:8888:");
ipv6test(!1,"::5555:6666:7777:8888:");
ipv6test(!1,"1111:2222::4444:5555:6666:7777:8888:");
ipv6test(!1,"1111::4444:5555:6666:7777:8888:");
ipv6test(!1,"::4444:5555:6666:7777:8888:");
ipv6test(!1,"1111::3333:4444:5555:6666:7777:8888:");
ipv6test(!1,"::3333:4444:5555:6666:7777:8888:");
ipv6test(!1,"::2222:3333:4444:5555:6666:7777:8888:");

# Additional cases: http://crisp.tweakblogs.net/blog/2031/ipv6-validation-%28and-caveats%29.html
ipv6test(1,"0:a:b:c:d:e:f::");
ipv6test(1,"::0:a:b:c:d:e:f"); # syntactically correct, but bad form (::0:... could be combined)
ipv6test(1,"a:b:c:d:e:f:0::");
ipv6test(!1,"':10.0.0.1");

# Testing for IPv4 in IPv6 format:
ipv6test(1,"::10.0.0.1");
ipv6test(1,"::FFFF:10.0.0.1");
# NB All the regexes fail to detect somewhat suspect v4 in v6 addresses
# Leaving this test out
#ipv6test(!1,"1::1.2.3.4");

# Testing for "%" at end of IPv6 address
ipv6test(!1,"2001:db8::%1");

print "\nNumber of failures: " . $numFailed . " out of " . $numTested . " tests.\n"; 
} # of printall