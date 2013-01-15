#IPv6 Address Regular Expression (regex) and Best IPv6 Representation

This repository documents a regular expression (regex) that checks an IPv6 address for the proper format. It also displays a "best representation" for any valid IPv6 address, according to RFC5952. 

##IPv6 Regular Expression and Validator

The Javascript tests an IPv6 address according to an elaborate regular expression (RE, or regex) to validate that the address is the proper format. This regular expression is discussed further in the [InterMapper Knowledge Base article.](http://forums.intermapper.com/viewtopic.php?t=452)

The Javascript file includes a number of test cases that were used during development. Please let us know at <support@intermapper.com> if you find new interesting test cases. 

##Best Text Representation of IPv6 Address

IETF RFC5952 [A Recommendation for IPv6 Address Text Representation](http://tools.ietf.org/html/rfc5952) describes a preferred text representation for an IPv6 address. These sensible rules make the address lower-case, trim leading zeroes, shorten runs of zero segments (e.g. :0000:) as much as possible but don't shorten a single segment, and place the compressed zeros as far to the left as possible.

##Source Files in this Repository

**IPv6AddressValidator.html** 

A stand-alone web page that has an input field to enter an IPv6 address. The script checks the IPv6 address against the regex to determine if it's the proper format. It also displays the "best representation" for that IPv6 address.

To use this page, simply load the file IPv6AddressValidator.html into your browser, enter an IPv6 address and hit Tab/Return.

**ipv6validator.js**

This Javascript does the work of testing an IPv6 address for validity, and producing its best representation. It is incorporated into the IPv6AddressValidator.html page.

**mibprobebuilder.css**

A CSS file pulled into the IPv6AddressValidator.html page.

**test-ipv6-regex.pl**

This Perl test script has nearly 500 test cases of valid and invalid IPv6 addresses. You can use them to test your own implementation of an IPv6 regex. 

##Other IPv6 Regular Expressions

This project draws together a lot of knowledge from various people who have ventured into creating an IPv6 Regex. Thanks to the following:

* Stephen Ryan for starting this project <http://forums.intermapper.com/viewtopic.php?t=452>
* Christoph Petschnig for a Ruby implementation of the same  <http://gist.github.com/294476>
* Aeron for a shorter RE, and for Java and Ruby RE's. NB The RE does not ignore whitespace before or after the IPv6 address.
* Phil Pennock who submitted a RE generated automatically from the full grammar in RFC3986 <http://people.spodhuis.org/phil.pennock/software/emit_ipv6_regexp-0.304>
* Salvador Fandiño García who provides the CPAN module Regexp::IPv6 at <http://search.cpan.org/~salva/Regexp-IPv6-0.03/lib/Regexp/IPv6.pm>


##License

IPv6 Regex by Dartware, LLC is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License](http://creativecommons.org/licenses/by-sa/3.0/) To attribute this work, place a link to <http://intermapper.com> in the Credits or About... window of your software. We would love to have you send any changes to the code or regular expression back to us at <support@intermapper.com>.
