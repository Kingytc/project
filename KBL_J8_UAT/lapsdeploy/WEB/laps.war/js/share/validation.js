var oPopup = window.createPopup();

function disableSelectable(e)
{ 
	return false 
} 

function reEnable()
{ 
	return true 
} 

document.oncontextmenu=new Function ("return false") 

if(window.sidebar)
{ 
	document.onmousedown=disableSelectable 
	document.onclick=reEnable 
}

function allowWholeNumber(obj)
{
	var key = window.event.keyCode;
	var val=obj.value;
	if(key==46 && val.indexOf(".")!=-1)
	{
		window.event.returnValue = false;
	}
	if( key==45 && val.indexOf("-")!=-1 ) 
	{
		window.event.returnValue = false;
	}
	if( key==45 && val != "" ) 
	{
		window.event.returnValue = false;
	}
	if( ! (key>44 && key<58)  )
	{
		window.event.returnValue = false;
	}
}

function dateretireCheck(obj)
{
	if (!checkDate(obj))
	{
		obj.value = "";
		return false;
	}
	else
	{
		var bool = validDate(obj);
		if(bool)
		{
			return true;
		}
		else
		{
			obj.focus();
			obj.value = "";
			return false;
		}
	}
}

function allowNegtiveNumber(obj)
{
	var key = window.event.keyCode;
	var val=obj.value;

	if(key==46 && val.indexOf(".")!=-1)
	{
		window.event.returnValue = false;
	}
	if(key==47 )
	{
		window.event.returnValue = false;
	}
	if( key==45 && val.indexOf("-")!=-1 ) 
	{
		window.event.returnValue = false;
	}
	if( ! (key>44 && key<58)  )
	{
		window.event.returnValue = false;
	}
}

function roundNegativeVal(trate)
{
	var temp2="";
	if (trate.value==".") trate.value=0;
	var temp1= new Number(trate.value);
	var floc=0;
	temp=new String(Math.round(temp1*100));
	temp2=String(temp/100);
	if (temp==0)
	{
		temp2="0.00";
	}
	if (temp2.substr(0,1)==".") temp2="0"+temp2;
	if (temp2.substr(temp2.length-2,1)==".") temp2=temp2+"0";
	if (parseInt(temp2.lastIndexOf("."))<0)
	{	
		temp2 = temp2+".00";
	}
	trate.value = temp2;
	return trate.value;
}

function allowAlphabets()
{
	var key = window.event.keyCode;
	if(!((key>64 && key<91) || (key>96 && key<123)))
	{
		window.event.returnValue = false;
	}
}

function allowAlphabetsForName()
{
	var key = window.event.keyCode;
   if(!((key>64 && key<91 && key==31) || (key>96 && key<123)||(key==46) ||(key==32)||(key>=65 && key<=90)))
   {
		window.event.returnValue = false;
   }
}

function allowInteger()
{
	var key = window.event.keyCode;
	if(!(key>47 && key<58))
	{
		window.event.returnValue = false;
	}
}

function notAllowSplChar()
{
	var key=window.event.keyCode;
	if(key==35 || key==94 || key==92 || key==126 || key==124 || key==96 || key==60 || key==62|| key==37)
	{
		window.event.returnValue=false;
	}
}

function notAllowSplChar1(obj)
{
	var key=window.event.keyCode;
	
	if(obj.value.length==0 && (key==32 || (key>47 && key<58)||(key==34 || key==39 || key==35 || key==94 || key==92 || key==126 || key==124 || key==96 || key==60 || key==62 )))
	{
		window.event.returnValue = false;
	}
	else if(key==35 || key==94 || key==92 || key==126 || key==124 || key==96 || key==60 || key==62)
	{
		window.event.returnValue = false;
	}
}

function allowAlphabetsAndSpaceInt(obj)
{
	var key = window.event.keyCode;
	if(obj.value.length==0 && key==32)
		{
		window.event.returnValue = false;
		}
	else if(key==35 || key==94 || key==92 || key==126 || key==124 || key==96 || key==60 || key==62)
	{
		window.event.returnValue = false;
	}
}

function allowIntegerHypen()
{
	var key = window.event.keyCode;
	if(!((key>47 && key<58) || key==45))
	{
		window.event.returnValue = false;
	}
}

function allowPhone()
{
	var key = window.event.keyCode;
	 if((key != 41 && key != 40 && key != 32) && !(key>43 && key<58) )
	{
		window.event.returnValue = false;
	}
}

function notAllowedDouble()
{
	var key=window.event.keyCode;
	
	if( (key==34))
	{
		window.event.returnValue = false;
	}
}

function notAllowSpace()
{
	var key=window.event.keyCode;
	if( (key==32))
	{
		window.event.returnValue = false;
	}
}

function notAllowSingleQuote()
{
	var key=window.event.keyCode;
	if( (key==39))
	{
		window.event.returnValue = false;
	}
}

function notallowInteger()
{
	var key = window.event.keyCode;
	if((key>47 && key<58))
	{
		window.event.returnValue = false;
	}
}

function allowNumber(obj)
{	
	var key = window.event.keyCode;
	var val=obj.value;
	if(key==46 && val.indexOf(".")!=-1)
	{
		window.event.returnValue = false;
	}
	if(!((key>47 && key<58)||(key==46)))
	{
		window.event.returnValue = false;
	}
}
function allowNegativeNumber(obj)
{	
	var key = window.event.keyCode;
	var val=obj.value;
	if(key==46 && val.indexOf(".")!=-1)
	{
		window.event.returnValue = false;
	}
	if(!((key>47 && key<58)||(key==46) || (key==45)))
	{
		
		window.event.returnValue = false;
	}
	
}

function trim(val)
{
	var si;
	var ei;
	for(si=0;(val.charAt(si)==" " && si<val.length);si++);
	for(ei=val.length-1;(val.charAt(ei)==" " && ei>-1);ei--);
	if(ei!=-1)
	   return val.substring(si,ei+1);
	else
		return "";
}

function checktrim(strValues)
{
	var strval = strValues;
	var bool = false;
	while(bool == false)
    {
 		if(strval.substring(0,1) ==" ")
		{
			strval = strval.substring(1,strval.length);
		}
		else
		{
			bool =true;
		}
	}
	return strval;
}

function allowDecimals(tmptxt)
{
	var i=0;
	var key=window.event.keyCode;
	if (key==46)
	{
		for(i=0;i<tmptxt.value.length;i++)	
		{
			if (tmptxt.value.charAt(i)==".")
			{
				key=0;
				break;
			}
		}
	}
	if ((!(key>=48 && key<=57)) && !(key==46))
		window.event.keyCode=0;
	return true;
}

function allowDelete(obj)
{
	var key=window.event.keyCode;
	if( !(key==46 || key==8))
	{
		window.event.returnValue = false;
	}
	else if(document.forms[0].edit.disabled)
	{
		obj.value="";
		window.event.returnValue = false;
	}
	else
	{
		window.event.returnValue = false;
	}
}

function roundtxt(trate)
{
	var temp2="";
	if (trate.value==".") trate.value=0;
	var temp1= new Number(trate.value);
	var floc=0;
	temp=new String(Math.round(temp1*100));
	temp2=String(temp/100);
	if (temp==0)
	{
		temp2="0.00";
	}
	if (temp2.substr(0,1)==".") temp2="0"+temp2;
	if (temp2.substr(temp2.length-2,1)==".") temp2=temp2+"0";
	if (parseInt(temp2.lastIndexOf("."))<0)
	{	
		temp2 = temp2+".00";
	}
	trate.value = temp2;
	return trate.value;
}

function showOrgSearch(path, forgscode, forgname)
{
		var varQryString = path+"action/searchOrg.jsp?forgscode="+forgscode+"&forgname="+forgname;
		var title = "Organization";
		var prop = "scrollbars=yes,width=500,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
}

function NanNumber(val)
{
	if(isNaN(val))
	{
		val = "0.00";
	}
	return val;
}

function changecase(obj)
{
	var val = obj.value.toUpperCase();
	obj.value = val;
}

function isEmailAddr(email,obj)
{
    var result = false;
  	if(trim(obj.value)!="")
	{
	  	var theStr = new String(email);
	  	var index = theStr.indexOf("@");	//find the position of @ symbol
	  	if (index > 0)
	  	{
	  	for(var si=0;si<email.length;si++)
	  		{
	  		if(email.charAt(si)==" ")
	  			{
	  			ShowAlert('105','Email Address');
				obj.value="";
				return;
	  			}
	  		}
			var pindex = theStr.indexOf(".",index);// find the position of .
			if ((pindex > index+1) && (theStr.length > pindex+1))//
			{
				result = true;
			}
			else
			{
				ShowAlert('105','Email Address');
				obj.value="";
			}
	  	}
	  	else
	  	{
			ShowAlert('105','Email Address');
			obj.value="";
	  	}	  
	}
  	return result;
}
	
function trimtxt(parstr)
{
  var gt=parstr;
  var mx=parstr;
  var avs=false;
  while (avs==false)
  {
    if(gt.substring(0,1)==" ")
	{
	  gt=gt.substring(1,gt.length);
	}
	else
	{
	  avs=true;
	}
  }
  return gt;
}

function CheckDecimal(strDec)
{
	var str = strDec;
	var intLocal = 0;
	if(str.indexOf(".") != -1)
	{
		var i = str.indexOf(".");
		for(var k=i;k<str.length;k++)
		{
			intLocal++;			
		}
		switch (intLocal)
		{
			case 2:
			str = str.concat("0");	
			break;
			case 1:
			str = str.concat("00");
			break;
		}
		if(intLocal >= 3)
		{
			str = str.substring(0,str.indexOf(".")+3);

		}

	}
	else
	{
		str = str.concat(".00");
	}
	return str;
}

function checkPercentage(obj)
{	
	if(parseFloat(obj.value,10) > 100)
	{
		ShowAlert(104,"Percentage");
		obj.focus();
		obj.value = "";
		return false;
	}
}

function doHelp()
{

}

function checkEnter()
{
	var key=window.event.keyCode;
	if(key == 13)
	{
		window.event.returnValue = false;
	}
}

function round(number,X) 
{
    X = (!X ? 2 : X);
    return Math.round(number*Math.pow(10,X))/Math.pow(10,X);
}

function roundVal(trate)
{	
	var temp2="";
	if (trate==".") trate=0;
	var temp1= new Number(trate);
	var floc=0;
	if (temp1!=0.0)
	{
		if(Math.abs(temp1)>=0.01 && Math.abs(temp1)<0.1 )
		{
			return parseFloat(temp1).toFixed(2);
		}
		else if(Math.abs(temp1)>=0 && Math.abs(temp1)<=0.01 )
		{
			return parseFloat(temp1).toFixed(3);
		}
		else
		{
			temp=new String(Math.round(temp1*100));
			temp2=temp.substr(0,temp.length-2)+"."+temp.substr(temp.length-2,2);
		}
		
	}
	else
	{
		temp2="0.00";
	}
	if (temp2.substr(0,1)==".") 	
	temp2="0"+temp2;
	trate=temp2;	
	return trate;//round(trate,2);
}

function allowAlphaSpaIntPunct()
{
	var key = window.event.keyCode;	
	if(!((key>64 && key<91) || (key>96 && key<123) ||(key==32) || (key>47 && key<58) ||(key==37) ||(key==44) ||(key==45) ||(key==47) ||(key==59) || (key==46)))
	{
		window.event.returnValue = false;
	}
}

function allowAlphaNumeric()
{
	var key = window.event.keyCode;
	if(!((key>64 && key<91) || (key>96 && key<123) || (key>47 && key<58) || key == 46) )
	{
		window.event.keyCode=0;
	}
		
}

function allowAlphaNumericSpace()
{
	var key = window.event.keyCode;	
	if(!((key>64 && key<91) || (key>96 && key<123) || (key>47 && key<58) || (key==32)) )
	{
		window.event.keyCode=0;
	}
		
}

function validDate(obj)
{
  	var result = true;
  	// Create date object using birth date str
  	var birthDate = new Date(obj.value);
  	var today = new Date();
  	// getTime returns date in milliseconds, so need to divide by number of milliseconds in year
 	 var age = (today.getTime())/(365*24*60*60*1000) - (birthDate.getTime())/(365*24*60*60*1000); 
	 return result;
}

function dateDOBCheck(obj)
{
	if (!checkDate(obj))
	{
		obj.value = "";
		return false;
	}
	else
	{
		var bool = validDate(obj);
		if(bool)
		{
			return true;
		}
		else
		{
			obj.focus();
			obj.value = "";
			return false;
		}
	}
}

function formattext()
{
	var key = window.event.keyCode;
	
	if(key==34 || key==39)
	{
		window.event.returnValue = false;
	}
}

function NoallowEnterandDoubleQuote()
{
	var key=window.event.keyCode;
	if(key == 13 || key==34)
	{
		window.event.returnValue = false;
	}
}

function notAllowSingleAndDoubleQuote()
{
	var key=window.event.keyCode;
	if((key==39) || (key==34))
	{
		window.event.returnValue = false;
	}
}

function textlimit(field,maxlen)
{
	if(field.value.length>maxlen)
    {
		field.value=field.value.substring(0,maxlen);
		alert('Limit reached, your input has been truncated');
    }
}

function textlimitcorp1(field,maxlen)
{
	var key = window.event.keyCode;
    if(key!=63)
    {
	    if(field.readOnly==true)
		{
		   return;
		}
		else
		{
			maxlen = maxlen - 1;
		   // showLAPSPopup("<b>Length Left ::&nbsp;<font color='red'>"+(maxlen-field.value.length)+"</font></b>","#D5D9EF");
			if((field.value.length) > (maxlen))
		    {
				field.value=field.value.substring(0,maxlen);
				//showLAPSPopup("<font color=white>Text Area Reached the Limit</font>","#ff0000");
				alert("Text Area Reached the Limit -> "+maxlen);
				window.event.returnValue = true;
			}
		}
	}
	else
	{
	  	window.event.returnValue = false;
	}
}
/***
* Function to check if the number typed is a valid decimal number
***/
function allowDecimal(obj, precision)
{
	var key = window.event.keyCode;
	
	var val=obj.value;
	
	if(key==46 && val.indexOf(".")!=-1)
	{
		window.event.returnValue = false;
	}
	if(!((key>47 && key<58)||(key==46)||(key==45)))
	{
		window.event.returnValue = false;
	}
}

/***
* Function to format the number based on number of precision
***/
function roundNumber(obj, precision)
{
	var i=0;
	var varValue="";
	if(obj.value!="")
		varValue = obj.value;
	var newval="";
	for(j=1,i=0; i<varValue.length; i++,j++)
	{
		newval=newval+varValue.charAt(i);
		if(j==2)
		{
			if(newval=="--")
			{
				varValue="";
			}
			newval="";
		}
	}
	if(varValue=="-")
	{
		varValue="";
	}
	if(varValue == "" || varValue == ".")
	{
		varValue="0.";
		for(i=0; i<precision; i++)
			varValue = varValue + "0";
	}
	else
	{
		varValue = new String(parseFloat(varValue));
	}
	temp = varValue.split(".");
	if(temp.length>1)
	{
		for(i=temp[1].length; i<precision; i++)
			varValue = varValue + "0";
	}
	else
	{
		varValue = varValue + ".";
		for(i=0; i<precision; i++)
			varValue = varValue + "0";
	}
	obj.value = varValue;
}
function checkmaxdate(obj,maxdate)
{
	var pagedate=obj.value;
	var pgdt=changeDateformat(pagedate);
	var maxdt=changeDateformat(maxdate);
	if(obj.value!="")
	{
		if(Date.parse(pgdt) > Date.parse(maxdt))
		{
			alert("Date cannot be greater than " +maxdate );
			obj.value="";
			obj.focus();
			return false;
		}
	}
	return true;
}

function checkmindate(obj,mindate)
{
	var pagedate=obj.value;
	var pgdt=changeDateformat(pagedate);
	var mindt=changeDateformat(mindate);
	if(obj.value!="")
	{
		if(Date.parse(pgdt) < Date.parse(mindt))
		{
			alert("Date cannot be less than " +mindate );
			obj.value="";
			obj.focus();
			return false;
		}
	}
	return true;
}

function checkmaxequaldate(obj,maxdate)
{
	var pagedate=obj.value;
	var pgdt=changeDateformat(pagedate);
	var maxdt=changeDateformat(maxdate);
	if(obj.value!="")
	{
		if(Date.parse(pgdt) >= Date.parse(maxdt))
		{
			alert("Date cannot be greater than or equal to" +maxdate );
			obj.value="";
			obj.focus();
			return false;
		}
	}
	return true;
}


function zipvalidate(obj,value)
{
	var zip=parseInt(obj.value.length);
	if(zip!="" && zip>0)
	{
		if(!(zip==parseInt(value)))
		{
			ShowAlert('121','Valid Pincode');
			obj.value="";
			obj.focus();
			return;
		}
	}
}
	
function checkcurrentyear(obj,val)
{
	var pagedate = obj.value;
	var currentYear=new Date().getFullYear();
	if(pagedate.length==4)
	{
		if(val!="N")
		{
			if (parseInt(pagedate)>parseInt(currentYear))
			{
				alert("Year should not be greater than current year");
				obj.focus();
				obj.value="";
				return;
			}
		}
	}	
	else
	{
		if(pagedate.length!=0)
		{
			alert("Enter Proper Year");
			obj.focus();
			obj.value="";
			return;
		}
	}
}

function checkTextArealimit(obj, maxchars)
 {
	if (obj.value.length > (eval(maxchars)-eval(1))) {
	   alert('For this Text Limit is '+maxchars+ ' characters');
	   obj.value = obj.value.substring(0,(eval(maxchars)-eval(1)));
	   return false;
	}
}

function CheckMax(obj1,obj2,val)
{
	var min=parseFloat(obj2.value);
	var max=parseFloat(obj1.value);
	if (min > max)
	{
		if(val==2)
		{
			alert(obj1.title + " cannot be less than " +obj2.title );
			obj1.value="";
		}
		else if(val==1)
		{
			alert(obj2.title + " cannot be greater than " +obj1.title);
			obj2.value="";
		}
		return false;
	}
}

document.onkeydown = function()
{
	if(window.event && window.event.keyCode == 8) 
    {
		// Capture and remap F5
		window.event.keyCode = 606;
  	}
	if(window.event && window.event.keyCode == 116) 
    { 
    	// Capture and remap F5
		window.event.keyCode = 505;
  	}
	if(window.event && window.event.keyCode == 505) 
    { // New action for F5
		return false; 
    	// Must return false or the browser will refresh anyway
	}
	if ((event.keyCode == 78) && (event.ctrlKey)){
		event.cancelBubble = true;
		event.returnValue = false;
		event.keyCode = false; 
		return false;
	}
	if ((event.keyCode == 110) && (event.ctrlKey)){
		event.cancelBubble = true;
		event.returnValue = false;
		event.keyCode = false; 
		return false;
	}
}

/**
@author :R.PAULRAJ
@PURPOSE:FOR DISABLING MOnitoring Buttons.<b> 
*/



//window.attachEvent("onload",assignhiddenvalues);

function assignhiddenvalues()
{
	if(parent.menuFrame && parent.mainFrame)
	{
		if(parent.menuFrame.document.forms[0].appno && parent.mainFrame.document.forms[0].appno)
		{
			parent.mainFrame.document.forms[0].appno.value=parent.menuFrame.document.forms[0].appno.value;
		}
		if(parent.menuFrame.document.forms[0].appname && parent.mainFrame.document.forms[0].appname)
		{
			parent.mainFrame.document.forms[0].appname.value=parent.menuFrame.document.forms[0].appname.value;
		}
		if(parent.menuFrame.document.forms[0].appstatus && parent.mainFrame.document.forms[0].appstatus)
		{
			parent.mainFrame.document.forms[0].appstatus.value=parent.menuFrame.document.forms[0].appstatus.value;
		}
		if(parent.menuFrame.document.forms[0].hidapplicantid && parent.mainFrame.document.forms[0].hidapplicantid)
		{
			parent.mainFrame.document.forms[0].hidapplicantid.value=parent.menuFrame.document.forms[0].hidapplicantid.value;
		}
		if(parent.menuFrame.document.forms[0].inwardno && parent.mainFrame.document.forms[0].inwardno)
		{
			parent.mainFrame.document.forms[0].inwardno.value=parent.menuFrame.document.forms[0].inwardno.value;
		}
		if(parent.menuFrame.document.forms[0].readFlag && parent.mainFrame.document.forms[0].readFlag)
		{
			parent.mainFrame.document.forms[0].readFlag.value=parent.menuFrame.document.forms[0].readFlag.value;
		}
		if(parent.menuFrame.document.forms[0].applevel && parent.mainFrame.document.forms[0].applevel)
		{
			parent.mainFrame.document.forms[0].applevel.value=parent.menuFrame.document.forms[0].applevel.value;
		}
		if(parent.menuFrame.document.forms[0].appholder && parent.mainFrame.document.forms[0].appholder)
		{
			parent.mainFrame.document.forms[0].appholder.value=parent.menuFrame.document.forms[0].appholder.value;
		}
		if(parent.menuFrame.document.forms[0].apploantype && parent.mainFrame.document.forms[0].apploantype)
		{
			parent.mainFrame.document.forms[0].apploantype.value=parent.menuFrame.document.forms[0].apploantype.value;
		}
		if(parent.menuFrame.document.forms[0].btnenable && parent.mainFrame.document.forms[0].btnenable)
		{
			parent.mainFrame.document.forms[0].btnenable.value=parent.menuFrame.document.forms[0].btnenable.value;
		}
		if(parent.menuFrame.document.forms[0].hidCategoryType && parent.mainFrame.document.forms[0].hidCategoryType)
		{
			parent.mainFrame.document.forms[0].hidCategoryType.value=parent.menuFrame.document.forms[0].hidCategoryType.value;
		}
	}
}



/**
*@author:V.Prashanthavel
*@purpose:PAN NO VALIDATION
*@usage:on Blur Function
*Criteria: first 5 alphaphets only -- next 4 numerics only--last 1 alphapbhets and 4th letter should be "P, F, C, A, H, B, L, J, or R"
*/
function validatePANNO(obj)
{
	if(trim(obj.value.toUpperCase())!="" && trim(obj.value.toUpperCase())!="NOPAN")
	{
		obj.value=obj.value.toUpperCase();
		if(obj.value.length!=10)
		{
			alert("Invalid PAN NO:");
			obj.value="";
			return false;
		}
		else 
		{
			if(!isNaN(obj.value.substring(0,4)))
			{
				alert("Invalid PAN NO:");
				obj.value="";
			    return false;
			}
			if(isNaN(obj.value.substring(5,8)))
			{
				alert("Invalid PAN NO:");
				obj.value="";
			    return false;
			}
			if(!isNaN(obj.value.substring(9,10)))
			{
				alert("Invalid PAN NO:");
				obj.value="";
			    return false;
			}
			if((obj.value.substring(3,4)!="P")&&
					(obj.value.substring(3,4)!="F")&&
					(obj.value.substring(3,4)!="C")&&
					(obj.value.substring(3,4)!="A")&&
					(obj.value.substring(3,4)!="H")&&
					(obj.value.substring(3,4)!="B")&&
					(obj.value.substring(3,4)!="L")&&
					(obj.value.substring(3,4)!="J")&&
					(obj.value.substring(3,4)!="R"))
			{
				alert("Invalid PAN NO:");
				obj.value="";
			    return false;
			}
		}
	}
}


//added by Prashanth for checking the pin code validation
function zipcodeVaildate(obj1,obj2,obj3)
{
	var comcust_zip=obj1.value;
	var hidzip=obj2.value;
	var cust_zip=0;
	if(hidzip=='')
	{
		var stat_id=obj3.value;
		document.all.ifrstate.src = appURL+"action/iframestate.jsp?hidBeanId=setstatecity&hidBeanGetMethod=getData&val=1&stateid="+stat_id+"&cust_zip="+comcust_zip;
	}
	else
	{
		if(comcust_zip.length>2)
		{
			cust_zip=comcust_zip.substring(0,2);
		}
		if(hidzip!='~' && cust_zip!=0)
		{
			var zipvaild = hidzip.split("~");
			if(!((zipvaild[0]<= eval(cust_zip)) && (zipvaild[1] >= eval(cust_zip))))
			{
				alert("The First two digit of the pincode should be between "+zipvaild[0] + " and " +zipvaild[1]);
				document.forms[0].txtcomcust_zip.value="";
				document.forms[0].txtcomcust_zip.focus();
			}
		}
		if(trim(hidzip) == '~' && cust_zip!=0) {
			alert("The Minimum and Maximum of Pin code First two digits aren't defined in Setup for the selected State");
			document.forms[0].txtcomcust_zip.value="";
			document.forms[0].txtcomcust_zip.focus();
		}
	}
}
	
//added by saranya for Phonenumber validation
function validatephone(obj)
{
	var phone=new String(obj);
	if(phone!="")
	{
		if(phone.length<=6)
		{
			alert("Invalid phoneno:");
			return false;
		}
		else
		{
			var vartmp2=phone.substring(0,6);
			var varcharatzero=vartmp2.charAt(0);
			var flag=1;
			for(var i=1;i<vartmp2.length;i++)
			{
				if(vartmp2.charAt(i)==varcharatzero)
				{
					flag=flag+1;
				}
			}
			if (flag==6)
			{
				alert("Invalid Phoneno:")
			}
		}
	}
}
//saranya added for Passport Number& Voter Id
function allowAlpaNumeric()
{
	key=window.event.keyCode;
	if(key==94 || key==39 || key==34 || key==63 || key==47 || key==92)
		window.event.keyCode=0;
}
//added by saranya for mobilenumber validation
function phonevalidate(obj)
{
	var temp=new String(obj);
	if(temp!="")
	{
		if(temp.length!=10)
		{
			alert("Invalid phoneno:");
			return false;
		}
		else
		{
			var vartmp2=temp.substring(0,6);
			var varcharatzero=vartmp2.charAt(0);
			var flag=1;
			for(var i=1;i<vartmp2.length;i++)
			{
				if(vartmp2.charAt(i)==varcharatzero)
				{
					flag=flag+1;
				}
			}
			if (flag==6)
			{
				alert("Invalid Phoneno:")
			}
		}
	}
}


function calyearsofserviceleft()
{
	var mycurrentdate=new Date(currdate.substring(6,10),currdate.substring(3,5)-1,currdate.substring(0,2));
	var retdate=document.forms[0].txtperemp_retdate.value;
	var retiredate=new Date(retdate.substring(6,10),retdate.substring(3,5)-1,retdate.substring(0,2));
	var retyear=retiredate.getYear();
	var curryear=mycurrentdate.getYear();
	var retmonth=retiredate.getMonth();
	var currmonth=mycurrentdate.getMonth();
	if(parseInt(retyear)<parseInt(curryear))
	{
		document.forms[0].txt_servicemonths.value="0";
		document.forms[0].txtserviceleft.value="0";
	}
	else if(parseInt(retyear)>parseInt(curryear))
	{
		if(retmonth>currmonth)
		{
			var serv_month=retmonth-currmonth;
	  		document.forms[0].txt_servicemonths.value=serv_month;
	  		var serv_left=retyear-curryear;
	  		document.forms[0].txtserviceleft.value=serv_left;
		}
		else if(retmonth < currmonth)
		{
			var serv_month=parseInt(retmonth)+12-parseInt(currmonth);
	  		document.forms[0].txt_servicemonths.value=serv_month;
	  		var serv_left=parseInt(retyear)-1-parseInt(curryear);
	  		document.forms[0].txtserviceleft.value=serv_left;
		}
		else
		{
			if(parseInt(retdate.substring(0,2))>=parseInt(currdate.substring(0,2)))
			{
				var serv_month=retmonth-currmonth;
	  			document.forms[0].txt_servicemonths.value=serv_month;
	  			var serv_left=retyear-curryear;
	  			document.forms[0].txtserviceleft.value=serv_left;
			}
			else
			{
				var serv_month=retmonth-currmonth+11;
	  			document.forms[0].txt_servicemonths.value=serv_month;
	  			var serv_left=retyear-1-curryear;
	  			document.forms[0].txtserviceleft.value=serv_left;
			}
		}
	}
	else if(parseInt(retyear)==parseInt(curryear))
	{
		if(retmonth>=currmonth)
		{
			var serv_month=retmonth-currmonth;
	  		document.forms[0].txt_servicemonths.value=serv_month;
	  		var serv_left=retyear-curryear;
	  		document.forms[0].txtserviceleft.value=serv_left;
		}
		else
		{
			document.forms[0].txt_servicemonths.value="0";
			document.forms[0].txtserviceleft.value="0";
		}
	}
}
function min_nos(obj,no)
{
	var min_len=obj.value.length;
	if(min_len<eval(no))
	{
		alert("Enter all "+no+" digits");
		obj.value="";
	}
}
//Used to control the navigation
function gototab(beanid, methodname, pagename) 
{
	if(document.forms[0].cmdsave)
	{
		if(document.forms[0].cmdsave.disabled==true)
		{
			document.forms[0].hidBeanId.value = beanid;
			document.forms[0].hidBeanGetMethod.value = methodname;
			document.forms[0].action = appURL + "action/" + pagename;
			document.forms[0].submit();
		}
		else
		{
			ShowAlert(103);
			return;
		}
	}
	else
	{
		document.forms[0].hidBeanId.value = beanid;
		document.forms[0].hidBeanGetMethod.value = methodname;
		document.forms[0].action = appURL + "action/" + pagename;
		document.forms[0].submit();
	}
}
function gototab(beanid, methodname, pagename,pagefrom) 
{
	document.forms[0].hidBeanId.value = beanid;
	document.forms[0].hidBeanGetMethod.value = methodname;
	document.forms[0].action = appURL + "action/" + pagename+"?pageFrom="+pagefrom;
	document.forms[0].submit();
}

//Added by Kishan Ref: While navigating from Financial Analysis Ratios and nearer tabs
function gototab(beanid, methodname, pagename,pagefrom) 
{
	if(document.forms[0].cmdsave)
	{
		if(document.forms[0].cmdsave.disabled==true)
		{
			document.forms[0].hidBeanId.value = beanid;
			document.forms[0].hidBeanGetMethod.value = methodname;
			document.forms[0].action = appURL + "action/" + pagename+"?pageFrom="+pagefrom;
			document.forms[0].submit();
		}
		else
		{
			ShowAlert(103);
			return;
		}
	}
	else
	{
		document.forms[0].hidBeanId.value = beanid;
		document.forms[0].hidBeanGetMethod.value = methodname;
		document.forms[0].action = appURL + "action/" + pagename+"?pageFrom="+pagefrom;
		document.forms[0].submit();
	}
}

// to allow decimals with + and - symbols
function allowAdjustment(obj)
{	
	var key = window.event.keyCode;
	var val=obj.value;
	if(!((key>47 && key<58)||(key==43)||(key==45)||(key==46)))
	{
		window.event.returnValue = false;
	}
}

function changeDateformat(old_date)
{
	var saperator="/";
	var temp;
	var flag;
	flag = false;
	temp = old_date;
	var my_array = temp.split("/");
	var size_array = my_array.length;
	var maxsize = size_array;

	if (maxsize == 3)
	{
		if ( my_array[0].length == 1 )
		{
			my_array[0] = "0" + my_array[0]
		}
		if ( my_array[1].length == 1 )
		{
			my_array[1] = "0" + my_array[1]
		}		
		if ( my_array[2].length == 2 )
		{
			my_array[2] = "20" + my_array[2]
		}	
		New_date = my_array[1] + saperator + my_array[0] + saperator + my_array[2];
		flag = true;
	}
	if (flag == false)
	{
		New_date = old_date;
	}
	return(New_date);
}

function disabledFields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}
		if(document.forms[0].elements[i].type=="checkbox")
		{
			document.forms[0].elements[i].disabled=one;		  
		}
		if(document.forms[0].elements[i].type=="select-multiple" )
		{
			document.forms[0].elements[i].disabled=one;
		}
	}
}

function Validate(v,v1,v3)
{
	if(document.forms[0].hidncgtcflag && document.forms[0].hidbankscheme)
	{
		if(document.forms[0].hidbankscheme.value=="069" && document.forms[0].hidncgtcflag.value=="N")
		{
			alert("Please Fill the KBL Aarogya page");
			return;
		}
	}
	if(document.forms[0].hidCGTMSE)
	{
		if(document.forms[0].hid_cgtmse_applicable.value=="Y")
		{
			if(document.forms[0].hidCGTMSE.value=="N")
			{
				alert("Please Fill the CGTMSE Coverage page");
				return;
			}
		}
	}

	if(document.forms[0].hidChecklist)
	{
	if(document.forms[0].hidChecklist.value=="N")
	{
		alert("Please Fill the CheckList Document");
		return;
	}}
	//vindhya begin
	if(document.forms[0].hidcheckenwr && document.forms[0].hidenwrbankschemecode)
	{
	if(document.forms[0].hidenwrbankschemecode.value=="074" && document.forms[0].hidcheckenwr.value=="N")
	{
		alert("Please Fill the eNWR Details");
		return;
	}}
	if(document.forms[0].freezeflag)
	{
	if(document.forms[0].freezeflag.value=="Y")
	{
		if(document.forms[0].varPanCheck.value=="Y")
		{ 
			if(document.forms[0].sessionmodule.value!="AGR")
			{
				
					if(document.forms[0].sessionmodule.value=="CORP")
					{					
							if(document.forms[0].Explimitchk.value=="F")
							 {
								 if (document.forms[0].varPancount.value=="N")
								{
								 alert(" Please obtain PAN number of the Applicants (including co-applicant/Joint borrower/Co-applicant) Co-Obligant/guarantor and capture in CBS for exposure (includes existing and proposed limit) of Rs."+document.forms[0].Expcheck.value+"/- and above ");
									return;
								}	 
							}				
					
					}
					else if(document.forms[0].sessionmodule.value=="RET")
					{			
					 if(document.forms[0].Explimitchk.value=="F")
						 {
							 if (document.forms[0].varPancount.value=="N")
							{
							 alert("Please obtain PAN number of the Applicants (including co-applicant/Joint borrower/Co-applicant) Co-Obligant/guarantor and capture in CBS for exposure (includes existing and proposed limit) of Rs."+document.forms[0].Expcheck.value+"/- and above ");
								return;
							}	 
						}
					}	
			
				 
			}
			if(document.forms[0].sessionmodule.value=="AGR")
			{
				if(document.forms[0].Expmainactcheck.value>0)
				{	
				 if(document.forms[0].Explimitagrchk.value=="F")
					 {
						if (document.forms[0].varPancount.value=="N")
						{
						 	alert("Please obtain PAN number of the Applicants (including co-applicant/Joint borrower/Co-applicant) Co-Obligant/guarantor and capture in CBS for exposure (includes existing and proposed limit) of "+document.forms[0].Expcheck.value+"/- and above ");
							return;
						}	 
					}
				}
				else
				{
					if(document.forms[0].Explimitagrchk.value=="F")
					 {
						 if (document.forms[0].varPancount.value=="N")
						{
						 	alert("Please obtain PAN number of the Applicants (including co-applicant/Joint borrower/Co-applicant) Co-Obligant/guarantor and capture in CBS for exposure (includes existing and proposed limit) of Rs."+document.forms[0].Expcheck.value+"/- and above ");
							return;
						}	 
					}
				}	
			
			}
			
		}
	}	}
	//vindhya end
	
	if(document.forms[0].cmdsave && document.forms[0].cmdsave.disabled)
	{
		document.forms[0].action=appUrl+"action/"+v1;	
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
		return;
	}
}
function notAllowAlphabets()
{
	    var key = window.event.keyCode;
		if((key>64 && key<91) || (key>96 && key<123))
	  
		{
			window.event.returnValue = false;
		}
}
function EditorEnableDisable(name1,val1,name2,val2)
{
	document.getElementById(name1).style.display=val1;
	document.getElementById(name2).style.display=val2;
}
function checkNumeric(obj){
	objval=obj.value;
	if(isNaN(objval)){
		alert("Please Enter Valid Numeric Data");
		obj.value='';
	}
	return;
}

function checkSplDotC(obj){
val1=obj.value;
var arrCodePdtType=['~','!','@','#','$','%',"'",'^','&','*','(',')','-','{','}','"','>','<','?','|','+','\\','.'];
for(var i=0;i<arrCodePdtType.length;i++){
	if(val1.indexOf(arrCodePdtType[i]) >= 0){
		alert("Special characters not allowed on this field");
		obj.value="";
		return;
	}
}
}

function checkNotAllowNumber(obj){
val1=obj.value;
var arrCodePdtType=['0','1','2','3','4','5',"6",'7','8','9'];
for(var i=0;i<arrCodePdtType.length;i++){
	if(val1.indexOf(arrCodePdtType[i]) >= 0){
		alert("Number not allowed on this field");
		obj.value="";
		return;
	}
}
}

function textlimit(field,maxlen)
{
	var key = window.event.keyCode;
    if(key!=63)
    {
	    if(field.readOnly==true)
		{
		   return;
		}
		else
		{
		    showLAPSPopup("<b>Length Left ::&nbsp;<font color='red'>"+(maxlen-field.value.length)+"</font></b>","#ece1ea");
			if(field.value.length > maxlen)
		    {
				field.value=field.value.substring(0,maxlen);
				showLAPSPopup("<font color=white>Text Area Reached the Limit</font>","#ff0000");
			}
		}
	}
	else
	{
	  	window.event.returnValue = false;
	}
}

function showLAPSPopup(strdesc,strColor)
{
	var oPopupBody = oPopup.document.body;
	oPopupBody.style.backgroundColor = strColor;
	oPopupBody.style.border = "solid #7a4d98 3px";
	if(strdesc=="")strdesc="Loading Please Wait...";
	oPopupBody.innerHTML =strdesc;
	//oPopup.show(1000, 250, 200, 25, document.body);
	oPopup.show(880,250, 200, 25, document.body);
}
function fnValidateGSTNo(obj)
{
	if(document.forms[0].cmdsave.disabled==true)
	{
		return;
	}
	var re = new RegExp('^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$');
	if(obj.value!="")
	{
		if(obj.value.match(re))
		{
			return true;
		}
		else
		{
			alert("Invalid GST No");
			obj.value="";
			obj.focus();
			return false;
		}
	}
}


function checkmaxequaldate(obj,maxdate)
{
	var pagedate=obj.value;
	var pgdt=changeDateformat(pagedate);
	var maxdt=changeDateformat(maxdate);
	if(obj.value!="")
	{
		if(Date.parse(pgdt) >= Date.parse(maxdt))
		{
			alert("Date cannot be greater than or equal to " +maxdate );
			obj.value="";
			obj.focus();
			return false;
		}
	}
	return true;
}

function checkminequaldate(obj,maxdate)
{
	var pagedate=obj.value;
	var pgdt=changeDateformat(pagedate);
	var maxdt=changeDateformat(maxdate);
	if(obj.value!="")
	{
		if(Date.parse(pgdt) <= Date.parse(maxdt))
		{
			alert("Date should be greater than  " +maxdate );
			obj.value="";
			obj.focus();
			return false;
		}
	}
	return true;
}



