

function allowAlphabetsAndNumber()
{
	var key = window.event.keyCode;
	if(key==32 || !((key>64 && key<91) || (key>96 && key<123)))
	{
		window.event.returnValue = false;
	}
}

function saveData()
{
	var val = trimtxt(document.forms[0].txtprofile_name.value);
	if( val == "")
	{
		alert("Enter Profile Name");
		document.forms[0].txtprofile_name.focus();
	}

	else
	{
//alert(repname);
	document.forms[0].userid.value=userid;
	document.forms[0].repname.value=repname;
	document.forms[0].hidParam.value=param;
	document.forms[0].hidAction.value="Insert";
	document.forms[0].hidBeanId.value="repData";
	document.forms[0].hidBeanGetMethod.value="updateData";
	document.forms[0].hidSourceUrl.value="/action/savereport2.jsp";
	document.forms[0].action=path+"action/savereport2.jsp";
//alert(document.forms[0].action);
alert(param);
	document.forms[0].submit();
	}
	
		
}

function trimtxt(parstr)
 {
	  var gt=parstr;
	  var mx=parstr;
	  var avs=false;
	  while (avs==false)
	  {
		if (gt.substring(0,1)==" ")
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


