#IPv6 Address Regular Expression (regex) and Best IPv6 Representation

This repository documents a regular expression (regex) that checks an IPv6 address for the proper format. It also displays a "best representation" for any valid IPv6 address, according to RFC5952. 

##IPv6 Regular Expression and Validator

The Javascript tests an IPv6 address according to an elaborate regular expression (RE, or regex) for validation that the address is the proper format. This regular expression is discussed further in the InterMapper [Knowledge Base article](http://forums.dartware.com/viewtopic.php?t=452) which also includes a number of test cases. 

The Javascript file includes a number of test cases that were used during development. Please let us know <support@intermapper.com> if you find interesting test cases. 

##Best Text Representation of IPv6 Address

IETF RFC5952 [A Recommendation for IPv6 Address Text Representation](http://tools.ietf.org/html/rfc5952) describes a preferred text representation for an IPv6 address. These sensible rules make the address lower-case, trim leading zeroes, shorten runs of zero segments (e.g. :0000:) as much as possible but don't shorten a single segment, and place the compressed zeros as far to the left as possible.

##Source Files in this Repository

**IPv6AddressValidator.html** and
**mibprobebuilder.css**

These two files provide a stand-alone web page (runs from the local disk; no web server required) that has an input field to enter an IPv6 address. The script checks the IPv6 address against the regex to determine if it's the proper format. It also displays the "best representation" for that IPv6 address.

**ipv6validator.js**

A Javascript program that works with the files above to test an IPv6 address for validity, and to produce its best representation.

**test-ipv6-regex.pl**

This Perl test script has nearly 500 test cases of valid and invalid IPv6 addresses. You can use them to test your own implementation. In addition it has pointers to several other regular expressions that can be used for IPv6.

##License

IPv6 Regex by Dartware, LLC is licensed under a [Creative Commons Attribution-ShareAlike 3.0 Unported License](http://creativecommons.org/licenses/by-sa/3.0/) To attribute this work, place a link to <http://intermapper.com> in the Credits or About... window of your software. We would love to have you send any changes to the code or regular expression back to us at <support@intermapper.com>.
