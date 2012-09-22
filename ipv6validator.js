// Javascript to test an IPv6 address for proper format, and to 
// present the "best text representation" according to IETF RFC 5952 at
// http://tools.ietf.org/html/rfc5952


// do the work of checking the string
function checkipv6(str)
{ 
	var perlipv6regex = "^\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))\s*$";
	var aeronipv6regex = "^\s*((?=.*::.*)(::)?([0-9A-F]{1,4}(:(?=[0-9A-F])|(?!\2)(?!\5)(::)|\z)){0,7}|((?=.*::.*)(::)?([0-9A-F]{1,4}(:(?=[0-9A-F])|(?!\7)(?!\10)(::))){0,5}|([0-9A-F]{1,4}:){6})((25[0-5]|(2[0-4]|1[0-9]|[1-9]?)[0-9])(\.(?=.)|\z)){4}|([0-9A-F]{1,4}:){7}[0-9A-F]{1,4})\s*$";

	var regex = "/"+perlipv6regex+"/";
	return (/^\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))\s*$/.test(str));
}

function formatipv6field(str)
{
	var str, theAddress;
	
	var pageItem = document.getElementById('ipv6text');			// retrieve the user's input field
	theAddress = pageItem.value;
	
	str = formatipv6result(theAddress);							// retrieve the Good/Bad result string
	pageItem = document.getElementById('ipv6results');
	pageItem.innerHTML = str;									// and display it

	str = formatipv6preferred(theAddress);						// retrieve the best representation
	pageItem = document.getElementById('bestrepresentation');	
	pageItem.innerHTML = str;									// and display it
}

// Print Good/Bad IPv6 Result
function formatipv6result(str)
{
var resultstr = "";
var font =  'font-family:Arial, Verdana, Sans-serif;font-size:16px;';
var styling = '<span style="color:%s;' + font + '">%s</span>';
var color = "";

	if (checkipv6(str))
	{	
		resultstr = "Good IPv6 format";
		color = '#00FF00';
	} 
	else 
	{
		resultstr = "Bad IPv6 format";
		color = '#FF0000';
	}
	resultstr =  sprintf(styling ,color, resultstr);

return resultstr;
}

// Global variables - Danger Will Robinson!
var debugstr = "";	// a place to put debugging information

// print the "preferred representation" of the IPv6 address
function formatipv6preferred(theaddress)
{
	var resultstr = "";
	var beststr = "";
		
	beststr = formatbestipv6(theaddress);		

	resultstr = resultstr + "<b>Best representation:</b> " + beststr;
	if (debugstr.length > 0)
		{ resultstr = resultstr + " <br /> Oops! Certain test cases failed. They include: <br />" + debugstr; }

	return resultstr;
}

// formatbestipv6 - create the "best format" IPv6 address representation according to RFC 5952
// Takes an IPv6 address and returns its best representation
// If it is not a valid IPv6 address, returns "Not a valid IPvt6 address"
function formatbestipv6(theaddress)
{
	var str;
	var beststr = "Not a valid IPv6 Address";
	var segments;
	var totalv6segments;
	
	if (checkipv6(theaddress))
	{	
		// ASSERT: theaddress is now a well-formed IPv6 address, as a result of the checkipv6() call above
		// Make the string lowercase and split it up on the ":"
		str = theaddress.toLowerCase();
		segments = str.split(":");
		
		// ASSERT: the 'segments' array contains the segments of the address after splitting on ":"
		// Trim off leading or trailing double-:: from front or back (:: or ::a:b:c... or ...a:b:c::)
		trimcolonsfromends(segments);
		// ASSERT: at this point segments[] has exactly zero or one "" string in it
			
		// Find the empty segment (if any) resulting from "::"
		// Fill it with enough "0000" segments to make a total of 8 segments
		fillemptysegment(segments);
		// ASSERT: All non-empty entry have been expanded as necessary; if IPv4 address present, only 7 segments
	
		// Now strip off leading zero's from all segments
		stripleadingzeroes(segments);
		// ASSERT: at this point, all leading zeroes have been stripped off
	
		// Scan through looking for consecutive "0" segments
		removeconsecutivezeroes(segments);
		
		// debugstr = debugstr + "-----<br />" + printsegments();
		
		// Assemble best representation from remainder of segments
		beststr = assemblebestrepresentation(segments);
		
	}
	return beststr;
}

// printsegments - return each of the actual segments, one per line for debugging. 
function printsegments(segments)
{
	var resultstr = "";
	for (i=0;i<segments.length; i++)
 	{
 		resultstr = resultstr + i.toString() + ' "' + segments[i] + '"<br />';
 	}
	return resultstr;
}

// Trim off leading or trailing double-:: from front or back (:: or ::a:b:c... or a:b:c::)
function trimcolonsfromends(segments)
{
	var seglen = segments.length;
	if ((segments[0] == '') && (segments[1] == '') && (segments[2] == "")) 	// must have been "::"
		{ segments.shift(); segments.shift() }								//    remove first two items
																			//    leaving a single segment of ""
	else if ((segments[0] == '') && (segments[1] == ''))					// must have been ::xxxx...
		{ segments.shift(); }												//    remove the first item
	else if ((segments[seglen-1] == '') && (segments[seglen-2] == '')) 		// must have been xxxx::
		{ segments.pop(); }													//    remove the last item	
	// ASSERT: at this point segments[] has exactly zero or one "" string in it
}

// fillemptysegments - find the empty segment and fill with enough "0000" to make 8 segments
function fillemptysegment(segments)
{
	var pos;
	var maxsegments = 8; 							// normally 8 segments
	
	if (segments[segments.length-1].indexOf(".") != -1) // found a "." which means IPv4
	{												// IPv4 addresses take up two segments
		// alert ("only seven segments");
		maxsegments = 7;
	}
	for (pos=0; pos<maxsegments; pos++)				// scan to find position of the ""
	{
		if (segments[pos] == '') { 
			segments[pos] = "0";					// Fill the empty segment with "0"				
			break; 
		}
	}
	// alert(pos.toString());

	// Now splice in enough "0000" entries in the array to flesh it out to right number
	while (segments.length < maxsegments)			// if it's not long enough
	{
		segments.splice(pos, 0, "0");				// insert one more "0" at this position
	}
}

// strip leading zeroes from every segment
function stripleadingzeroes(segments)
{
	var numsegs = segments.length;
	var segment;
	
	for (i=0; i<numsegs; i++)							// for each of the segments
	{
		segs=segments[i].split("");						// split the segment apart
		for (j=0; j<3 ; j++)							// scan through at most three characters 
		{
			// alert(segs);
			if ((segs[0] == "0") && (segs.length > 1))	// if leading zero and not last character
				segs.splice(0,1);						//    take it out
			else break;									// non-zero or last character - break out
		}
		segments[i] = segs.join("");					// put 'em back together
	}
}

// find longest sequence of zeroes and coalesce them into one segment
function removeconsecutivezeroes(segments)
{
		var bestpos = -1;									// bestpos contains position of longest sequence
		var bestcnt = 0;									// bestcnt contains the number of occurrences
		var inzeroes = false;								// assume we start in zeroes
		var curcnt = 0;
		var curpos = -1;
		var i;
		
		for (i=0; i<8; i++)
		{
			// alert (i.toString() + " " + inzeroes.toString() + " " + bestpos.toString() + " " + bestcnt.toString() + " ");
			if (inzeroes)									// we're in a run of zero segments
			{
				if (segments[i] == "0")						// one more - just count it
					curcnt += 1;
				else										// found the end of it
				{
					inzeroes = false;						// not in zeroes anymore
					if (curcnt > bestcnt)
						{ bestpos = curpos; bestcnt = curcnt; } // remember this place & count
				}
			}
			else											// not in a run of zeroes
			{
				if (segments[i] == "0")						// found one!
					{ inzeroes = true; curpos = i; curcnt = 1; }
			}
		}
		if (curcnt > bestcnt)
			{ bestpos = curpos; bestcnt = curcnt; } // remember this place & count

		//debugstr = 'bestpos: ' + bestpos.toString() + ' bestcnt: ' + bestcnt.toString() + '<br />';
		//debugstr = resultstr + printsegments();		// 
		
		// now take out runs of zeroes that are longer than one occurrance
		if (bestcnt > 1)
		{
			segments.splice(bestpos, bestcnt, "");
		}
}

// Assemble best representation of the string
function assemblebestrepresentation(segments)
{
	var beststr = "";
	var segslen = segments.length;
	if (segments[0] == "") 
		beststr = ":";
	for (i=0; i<segslen; i++)
	{
		beststr = beststr + segments[i];
		if (i == segslen-1) break;
		beststr = beststr + ":";
	}
	if (segments[segslen-1] == "")
		beststr = beststr + ":";
	return beststr;
}

// This function clears the field when a customer focuses on it
//   unless the field doesn't contain the default "Enter acknowedge text"
function focus_field(obj)
{
obj.style.color='';
obj.style.fontStyle='';
if (obj.value=="::1")
	{
	obj.value='';
	}
}

// function from http://forums.devshed.com/t39065/s84ded709f924610aa44fff827511aba3.html
// author appears to be Robert Pollard
// found on: http://www.esqsoft.com/javascript_examples/javascript-sprintf.js

function sprintf()
{
   if (!arguments || arguments.length < 1 || !RegExp)
   {
      return;
   }
   var str = arguments[0];
   var re = /([^%]*)%('.|0|\x20)?(-)?(\d+)?(\.\d+)?(%|b|c|d|u|f|o|s|x|X)(.*)/;
   var a = b = [], numSubstitutions = 0, numMatches = 0;
   while (a = re.exec(str))
   {
      var leftpart = a[1], pPad = a[2], pJustify = a[3], pMinLength = a[4];
      var pPrecision = a[5], pType = a[6], rightPart = a[7];

      numMatches++;
      if (pType == '%')
      {
         subst = '%';
      }
      else
      {
         numSubstitutions++;
         if (numSubstitutions >= arguments.length)
         {
            alert('Error! Not enough function arguments (' + (arguments.length - 1)
               + ', excluding the string)\n'
               + 'for the number of substitution parameters in string ('
               + numSubstitutions + ' so far).');
         }
         var param = arguments[numSubstitutions];
         var pad = '';
                if (pPad && pPad.substr(0,1) == "'") pad = leftpart.substr(1,1);
           else if (pPad) pad = pPad;
         var justifyRight = true;
                if (pJustify && pJustify === "-") justifyRight = false;
         var minLength = -1;
                if (pMinLength) minLength = parseInt(pMinLength);
         var precision = -1;
                if (pPrecision && pType == 'f')
                   precision = parseInt(pPrecision.substring(1));
         var subst = param;
         switch (pType)
         {
         case 'b':
            subst = parseInt(param).toString(2);
            break;
         case 'c':
            subst = String.fromCharCode(parseInt(param));
            break;
         case 'd':
            subst = parseInt(param) ? parseInt(param) : 0;
            break;
         case 'u':
            subst = Math.abs(param);
            break;
         case 'f':
            subst = (precision > -1)
             ? Math.round(parseFloat(param) * Math.pow(10, precision))
              / Math.pow(10, precision)
             : parseFloat(param);
            break;
         case 'o':
            subst = parseInt(param).toString(8);
            break;
         case 's':
            subst = param;
            break;
         case 'x':
            subst = ('' + parseInt(param).toString(16)).toLowerCase();
            break;
         case 'X':
            subst = ('' + parseInt(param).toString(16)).toUpperCase();
            break;
         }
         var padLeft = minLength - subst.toString().length;
         if (padLeft > 0)
         {
            var arrTmp = new Array(padLeft+1);
            var padding = arrTmp.join(pad?pad:" ");
         }
         else
         {
            var padding = "";
         }
      }
      str = leftpart + padding + subst + rightPart;
   }
   return str;
}

 	document.onload=checkall();  // force an update when the window loads
 
 function XTEST(sbok, str, beststr)
 {
 	var bestrep;
 	var lcstr;
 	
// 	return; 					// Just return for production - too slow
 	if (checkipv6(str) && sbok) 
 	{
 		// it's OK - both return true
 	}
 	else if (!checkipv6(str) && !sbok)
 	{
 		// this is OK, too
 	}
 	else
 	{
 		alert (str + " is not OK");
 	}
 	
 	// Check the best representation, as well
 	
 	bestrep = formatbestipv6(str);	// get the best representation
 	lcstr = beststr.toLowerCase();	// the lower-case representation of the test case
 	if (sbok && (lcstr != bestrep))	// if it should be well formatted, is it correct?
 	{
 		debugstr = debugstr + "<br /> Test string: '" + lcstr + "'<br /> Best rep: '" + bestrep + "'<br />";
 	}
 	
 }
 
 function checkall()
 {
 	formatipv6field();
	XTEST(false,"","---");
	XTEST(true ,"2001:0000:1234:0000:0000:C1C0:ABCD:0876","2001:0:1234::C1C0:ABCD:876"); 
	XTEST(true ,"3ffe:0b00:0000:0000:0001:0000:0000:000a","3ffe:b00::1:0:0:a"); 
	XTEST(true ,"FF02:0000:0000:0000:0000:0000:0000:0001","FF02::1"); 
	XTEST(true ,"0000:0000:0000:0000:0000:0000:0000:0001","::1"); 
	XTEST(true ,"0000:0000:0000:0000:0000:0000:0000:0000","::"); 
	XTEST(true ,"::ffff:192.168.1.26","::ffff:192.168.1.26"); 
	XTEST(false,"02001:0000:1234:0000:0000:C1C0:ABCD:0876","---");      
	XTEST(false,"2001:0000:1234:0000:00001:C1C0:ABCD:0876","---");     
	XTEST(true ," 2001:0000:1234:0000:0000:C1C0:ABCD:0876"," 2001:0:1234::C1C0:ABCD:876"); 
	XTEST(true ," 2001:0000:1234:0000:0000:C1C0:ABCD:0876  "," 2001:0:1234::C1C0:ABCD:876  "); 
	XTEST(false," 2001:0000:1234:0000:0000:C1C0:ABCD:0876  0","---"); 
	XTEST(false,"2001:0000:1234: 0000:0000:C1C0:ABCD:0876","---"); 
	XTEST(false,"2001:1:1:1:1:1:255Z255X255Y255","---");
	
	XTEST(false,"3ffe:0b00:0000:0001:0000:0000:000a","---"); 
	XTEST(false,"FF02:0000:0000:0000:0000:0000:0000:0000:0001","---"); 
	XTEST(false,"3ffe:b00::1::a","---"); 
	XTEST(false,"::1111:2222:3333:4444:5555:6666::","---");       
	XTEST(true ,"2::10","2::10"); 
	XTEST(true ,"ff02::1","ff02::1"); 
	XTEST(true ,"fe80::","fe80::"); 
	XTEST(true ,"2002::","2002::"); 
	XTEST(true ,"2001:db8::","2001:db8::"); 
	XTEST(true ,"2001:0db8:1234::","2001:db8:1234::"); 
	XTEST(true ,"::ffff:0:0","::ffff:0:0"); 
	XTEST(true ,"::1","::1"); 
	XTEST(true ,"::ffff:192.168.1.1","::ffff:192.168.1.1"); 
	XTEST(true ,"1:2:3:4:5:6:7:8","1:2:3:4:5:6:7:8"); 
	XTEST(true ,"1:2:3:4:5:6::8","1:2:3:4:5:6:0:8"); 
	XTEST(true ,"1:2:3:4:5::8","1:2:3:4:5::8"); 
	XTEST(true ,"1:2:3:4::8","1:2:3:4::8"); 
	XTEST(true ,"1:2:3::8","1:2:3::8"); 
	XTEST(true ,"1:2::8","1:2::8"); 
	XTEST(true ,"1::8","1::8"); 
	XTEST(true ,"1::2:3:4:5:6:7","1:0:2:3:4:5:6:7"); 
	XTEST(true ,"1::2:3:4:5:6","1::2:3:4:5:6"); 
	XTEST(true ,"1::2:3:4:5","1::2:3:4:5"); 
	XTEST(true ,"1::2:3:4","1::2:3:4"); 
	XTEST(true ,"1::2:3","1::2:3"); 
	XTEST(true ,"1::8","1::8"); 
	XTEST(true ,"::2:3:4:5:6:7:8","0:2:3:4:5:6:7:8"); 
	XTEST(true ,"::2:3:4:5:6:7","::2:3:4:5:6:7"); 
	XTEST(true ,"::2:3:4:5:6","::2:3:4:5:6"); 
	XTEST(true ,"::2:3:4:5","::2:3:4:5"); 
	XTEST(true ,"::2:3:4","::2:3:4"); 
	XTEST(true ,"::2:3","::2:3"); 
	XTEST(true ,"::8","::8"); 
	XTEST(true ,"1:2:3:4:5:6::","1:2:3:4:5:6::"); 
	XTEST(true ,"1:2:3:4:5::","1:2:3:4:5::"); 
	XTEST(true ,"1:2:3:4::","1:2:3:4::"); 
	XTEST(true ,"1:2:3::","1:2:3::"); 
	XTEST(true ,"1:2::","1:2::"); 
	XTEST(true ,"1::","1::"); 
	XTEST(true ,"1:2:3:4:5::7:8","1:2:3:4:5:0:7:8"); 
	XTEST(false,"1:2:3::4:5::7:8","---"); 
	XTEST(false,"12345::6:7:8","---"); 
	XTEST(true ,"1:2:3:4::7:8","1:2:3:4::7:8"); 
	XTEST(true ,"1:2:3::7:8","1:2:3::7:8"); 
	XTEST(true ,"1:2::7:8","1:2::7:8"); 
	XTEST(true ,"1::7:8","1::7:8"); 
	XTEST(false,"1:2:3:4:5:6:7:1.2.3.4","---"); // IPv4 addresses take 32 bits/2 segments
	XTEST(true ,"1:2:3:4:5:6:1.2.3.4","1:2:3:4:5:6:1.2.3.4"); 
	XTEST(true ,"1:2:3:4:5:0:1.2.3.4","1:2:3:4:5:0:1.2.3.4"); 
	XTEST(true ,"1:2:3:4:5::1.2.3.4", "1:2:3:4:5:0:1.2.3.4"); 
	XTEST(true ,"1:2:3:4::1.2.3.4","1:2:3:4::1.2.3.4"); 
	XTEST(true ,"1:2:3::1.2.3.4","1:2:3::1.2.3.4"); 
	XTEST(true ,"1:2::1.2.3.4","1:2::1.2.3.4"); 
	XTEST(true ,"1::1.2.3.4","1::1.2.3.4"); 
	XTEST(true ,"1:2:3:4::5:1.2.3.4","1:2:3:4:0:5:1.2.3.4"); 
	XTEST(true ,"1:2:3::5:1.2.3.4","1:2:3::5:1.2.3.4"); 
	XTEST(true ,"1:2::5:1.2.3.4","1:2::5:1.2.3.4"); 
	XTEST(true ,"1::5:1.2.3.4","1::5:1.2.3.4"); 
	XTEST(true ,"1::5:11.22.33.44","1::5:11.22.33.44"); 
	XTEST(false,"1::5:400.2.3.4","---"); 
	XTEST(false,"1::5:260.2.3.4","---"); 
	XTEST(false,"1::5:256.2.3.4","---"); 
	XTEST(false,"1::5:1.256.3.4","---"); 
	XTEST(false,"1::5:1.2.256.4","---"); 
	XTEST(false,"1::5:1.2.3.256","---"); 
	XTEST(false,"1::5:300.2.3.4","---"); 
	XTEST(false,"1::5:1.300.3.4","---"); 
	XTEST(false,"1::5:1.2.300.4","---"); 
	XTEST(false,"1::5:1.2.3.300","---"); 
	XTEST(false,"1::5:900.2.3.4","---"); 
	XTEST(false,"1::5:1.900.3.4","---"); 
	XTEST(false,"1::5:1.2.900.4","---"); 
	XTEST(false,"1::5:1.2.3.900","---"); 
	XTEST(false,"1::5:300.300.300.300","---"); 
	XTEST(false,"1::5:3000.30.30.30","---"); 
	XTEST(false,"1::400.2.3.4","---"); 
	XTEST(false,"1::260.2.3.4","---"); 
	XTEST(false,"1::256.2.3.4","---"); 
	XTEST(false,"1::1.256.3.4","---"); 
	XTEST(false,"1::1.2.256.4","---"); 
	XTEST(false,"1::1.2.3.256","---"); 
	XTEST(false,"1::300.2.3.4","---"); 
	XTEST(false,"1::1.300.3.4","---"); 
	XTEST(false,"1::1.2.300.4","---"); 
	XTEST(false,"1::1.2.3.300","---"); 
	XTEST(false,"1::900.2.3.4","---"); 
	XTEST(false,"1::1.900.3.4","---"); 
	XTEST(false,"1::1.2.900.4","---"); 
	XTEST(false,"1::1.2.3.900","---"); 
	XTEST(false,"1::300.300.300.300","---"); 
	XTEST(false,"1::3000.30.30.30","---"); 
	XTEST(false,"::400.2.3.4","---"); 
	XTEST(false,"::260.2.3.4","---"); 
	XTEST(false,"::256.2.3.4","---"); 
	XTEST(false,"::1.256.3.4","---"); 
	XTEST(false,"::1.2.256.4","---"); 
	XTEST(false,"::1.2.3.256","---"); 
	XTEST(false,"::300.2.3.4","---"); 
	XTEST(false,"::1.300.3.4","---"); 
	XTEST(false,"::1.2.300.4","---"); 
	XTEST(false,"::1.2.3.300","---"); 
	XTEST(false,"::900.2.3.4","---"); 
	XTEST(false,"::1.900.3.4","---"); 
	XTEST(false,"::1.2.900.4","---"); 
	XTEST(false,"::1.2.3.900","---"); 
	XTEST(false,"::300.300.300.300","---"); 
	XTEST(false,"::3000.30.30.30","---"); 
	XTEST(true ,"fe80::217:f2ff:254.7.237.98","fe80::217:f2ff:254.7.237.98"); 
	XTEST(true ,"fe80::217:f2ff:fe07:ed62","fe80::217:f2ff:fe07:ed62"); 
	XTEST(true ,"2001:DB8:0:0:8:800:200C:417A","2001:DB8::8:800:200C:417A"); 
	XTEST(true ,"FF01:0:0:0:0:0:0:101","FF01::101"); 
	XTEST(true ,"0:0:0:0:0:0:0:1","::1"); 
	XTEST(true ,"0:0:0:0:0:0:0:0","::"); 
	XTEST(true ,"2001:DB8::8:800:200C:417A","2001:DB8::8:800:200C:417A"); 
	XTEST(true ,"FF01::101","FF01::101"); 
	XTEST(true ,"::1","::1"); 
	XTEST(true ,"::","::"); 
	XTEST(true ,"0:0:0:0:0:0:13.1.68.3","::13.1.68.3"); 
	XTEST(true ,"0:0:0:0:0:FFFF:129.144.52.38","::FFFF:129.144.52.38");
	XTEST(true ,"::13.1.68.3","::13.1.68.3"); 
	XTEST(true ,"::FFFF:129.144.52.38","::FFFF:129.144.52.38"); 
// 	# XTEST(true ,"2001:0DB8:0000:CD30:0000:0000:0000:0000/60","2001:0DB8:0000:CD30:0000:0000:0000:0000/60");
// 	# XTEST(true ,"2001:0DB8::CD30:0:0:0:0/60","2001:0DB8::CD30:0:0:0:0/60");
// 	# XTEST(true ,"2001:0DB8:0:CD30::/60","2001:0DB8:0:CD30::/60");
// 	# XTEST(true ,"::/128","::/128"); 
// 	# XTEST(true ,"::1/128","::1/128"); 
// 	# XTEST(true ,"FF00::/8","FF00::/8"); 
// 	# XTEST(true ,"FE80::/10","FE80::/10"); 
// 	# XTEST(true ,"FEC0::/10","FEC0::/10"); 
// 	# XTEST(false,"124.15.6.89/60","---"); 
	XTEST(false,"2001:DB8:0:0:8:800:200C:417A:221","---"); 
	XTEST(false,"FF01::101::2","---");
	XTEST(false,"","---"); 
	
	XTEST(true ,"fe80:0000:0000:0000:0204:61ff:fe9d:f156","fe80::204:61ff:fe9d:f156"); 
	XTEST(true ,"fe80:0:0:0:204:61ff:fe9d:f156","fe80::204:61ff:fe9d:f156"); 
	XTEST(true ,"fe80::204:61ff:fe9d:f156","fe80::204:61ff:fe9d:f156"); 
	XTEST(false,"fe80:0000:0000:0000:0204:61ff:254.157.241.086","---"); 
	XTEST(true ,"fe80:0:0:0:204:61ff:254.157.241.86","fe80::204:61ff:254.157.241.86"); 
	XTEST(true ,"fe80::204:61ff:254.157.241.86","fe80::204:61ff:254.157.241.86"); 
	XTEST(true ,"::1","::1"); 
	XTEST(true ,"fe80::","fe80::"); 
	XTEST(true ,"fe80::1","fe80::1"); 
	XTEST(false,":","---");

// Aeron supplied these test cases.	
	XTEST(false,"1111:2222:3333:4444::5555:","---");
	XTEST(false,"1111:2222:3333::5555:","---");
	XTEST(false,"1111:2222::5555:","---");
	XTEST(false,"1111::5555:","---");
	XTEST(false,"::5555:","---");
	XTEST(false,":::","---");
	XTEST(false,"1111:","---");
	XTEST(false,":","---");
	
	XTEST(false,":1111:2222:3333:4444::5555","---");
	XTEST(false,":1111:2222:3333::5555","---");
	XTEST(false,":1111:2222::5555","---");
	XTEST(false,":1111::5555","---");
	XTEST(false,":::5555","---");
	XTEST(false,":::","---");
	
	XTEST(false,"1.2.3.4:1111:2222:3333:4444::5555","---");
	XTEST(false,"1.2.3.4:1111:2222:3333::5555","---");
	XTEST(false,"1.2.3.4:1111:2222::5555","---");
	XTEST(false,"1.2.3.4:1111::5555","---");
	XTEST(false,"1.2.3.4::5555","---");
	XTEST(false,"1.2.3.4::","---");

// Additional Patterns
// from http://rt.cpan.org/Public/Bug/Display.html?id=50693

	XTEST(true ,"2001:0db8:85a3:0000:0000:8a2e:0370:7334","2001:db8:85a3::8a2e:370:7334");
	XTEST(true ,"2001:db8:85a3:0:0:8a2e:370:7334","2001:db8:85a3::8a2e:370:7334");
	XTEST(true ,"2001:db8:85a3::8a2e:370:7334","2001:db8:85a3::8a2e:370:7334");
	XTEST(true ,"2001:0db8:0000:0000:0000:0000:1428:57ab","2001:db8::1428:57ab");
	XTEST(true ,"2001:0db8:0000:0000:0000::1428:57ab","2001:db8::1428:57ab");
	XTEST(true ,"2001:0db8:0:0:0:0:1428:57ab","2001:db8::1428:57ab");
	XTEST(true ,"2001:0db8:0:0::1428:57ab","2001:db8::1428:57ab");
	XTEST(true ,"2001:0db8::1428:57ab","2001:db8::1428:57ab");
	XTEST(true ,"2001:db8::1428:57ab","2001:db8::1428:57ab");
	XTEST(true ,"0000:0000:0000:0000:0000:0000:0000:0001","::1");
	XTEST(true ,"::1","::1");
	XTEST(true ,"::ffff:12.34.56.78","::ffff:12.34.56.78");
	XTEST(true ,"::ffff:0c22:384e","::ffff:c22:384e");
	XTEST(true ,"2001:0db8:1234:0000:0000:0000:0000:0000","2001:db8:1234::");
	XTEST(true ,"2001:0db8:1234:ffff:ffff:ffff:ffff:ffff","2001:db8:1234:ffff:ffff:ffff:ffff:ffff");
	XTEST(true ,"2001:db8:a::123","2001:db8:a::123");
	XTEST(true ,"fe80::","fe80::");
	XTEST(true ,"::ffff:192.0.2.128","::ffff:192.0.2.128");
	XTEST(true ,"::ffff:c000:280","::ffff:c000:280");

	XTEST(false,"123","---");
	XTEST(false,"ldkfj","---");
	XTEST(false,"2001::FFD3::57ab","---");
	XTEST(false,"2001:db8:85a3::8a2e:37023:7334","---");
	XTEST(false,"2001:db8:85a3::8a2e:370k:7334","---");
	XTEST(false,"1:2:3:4:5:6:7:8:9","---");
	XTEST(false,"1::2::3","---");
	XTEST(false,"1:::3:4:5","---");
	XTEST(false,"1:2:3::4:5:6:7:8:9","---");
	XTEST(false,"::ffff:2.3.4","---");
	XTEST(false,"::ffff:257.1.2.3","---");
	XTEST(false,"1.2.3.4","---");
	
// Test collapsing zeroes...

	XTEST(true ,"a:b:c:d:e:f:f1:f2","a:b:c:d:e:f:f1:f2");
	XTEST(true ,"a:b:c::d:e:f:f1","a:b:c:0:d:e:f:f1");
	XTEST(true ,"a:b:c::d:e:f","a:b:c::d:e:f");
	XTEST(true ,"a:b:c::d:e","a:b:c::d:e");
	XTEST(true ,"a:b:c::d","a:b:c::d");
	XTEST(true ,"::a","::a");
	XTEST(true ,"::a:b:c","::a:b:c");
	XTEST(true ,"::a:b:c:d:e:f:f1","0:a:b:c:d:e:f:f1");
	XTEST(true ,"a::","a::");
	XTEST(true ,"a:b:c::","a:b:c::");
	XTEST(true ,"a:b:c:d:e:f:f1::","a:b:c:d:e:f:f1:0");
	XTEST(true ,"a:bb:ccc:dddd:000e:00f:0f::","a:bb:ccc:dddd:e:f:f:0");
	XTEST(true ,"0:a:0:a:0:0:0:a","0:a:0:a::a");
	XTEST(true ,"0:a:0:0:a:0:0:a","0:a::a:0:0:a");
	XTEST(true ,"2001:db8:1:1:1:1:0:0","2001:db8:1:1:1:1::");
	XTEST(true ,"2001:db8:1:1:1:0:0:0","2001:db8:1:1:1::");
	XTEST(true ,"2001:db8:1:1:0:0:0:0","2001:db8:1:1::");
	XTEST(true ,"2001:db8:1:0:0:0:0:0","2001:db8:1::");
	XTEST(true ,"2001:db8:0:0:0:0:0:0","2001:db8::");
	XTEST(true ,"2001:0:0:0:0:0:0:0","2001::");

	XTEST(true ,"A:BB:CCC:DDDD:000E:00F:0F::","A:BB:CCC:DDDD:E:F:F:0");

	XTEST(true ,"0:0:0:0:0:0:0:0","::");
	XTEST(true ,"0:0:0:0:0:0:0:a","::a");
	XTEST(true ,"0:0:0:0:a:0:0:0","::a:0:0:0");
	XTEST(true ,"0:0:0:a:0:0:0:0","0:0:0:a::");
	XTEST(true ,"0:a:0:0:a:0:0:a","0:a::a:0:0:a");
	XTEST(true ,"a:0:0:a:0:0:a:a","a::a:0:0:a:a");
	XTEST(true ,"a:0:0:a:0:0:0:a","a:0:0:a::a");
	XTEST(true ,"a:0:0:0:a:0:0:a","a::a:0:0:a");
	XTEST(true ,"a:0:0:0:a:0:0:0","a::a:0:0:0");
	XTEST(true ,"a:0:0:0:0:0:0:0","a::");
 }
