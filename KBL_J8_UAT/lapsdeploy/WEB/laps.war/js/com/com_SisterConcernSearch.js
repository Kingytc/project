function entsub(myform) 
{
  if (window.event && window.event.keyCode == 13)
    callExisting();
  else
    return true;
}

function callNew()
{

document.forms[0].hidAppType.value="new";
document.forms[0].hidBeanId.value="mastapplicant";
document.forms[0].hidBeanGetMethod.value="getDemographics";
document.forms[0].action=appURL+"action/perapplicant.jsp?applnt=P&scode=yyy";
document.forms[0].submit();
}

function callExisting()
{	
	if(document.forms[0].radiobutton[0].checked)
	{
		cat=1;
	}
	else if (document.forms[0].radiobutton[1].checked)
	{
		cat=2;
	}
	else if (document.forms[0].radiobutton[2].checked)
	{
		cat=3;
	}
	else
	{
		alert("Select a search criteria to search");   
		return;
	}
	for(var k=0;k<1;k++)
	{
		if(document.forms[0].radiobutton[k].checked==true)
		{
			if(trim(document.forms[0].txtsearch.value) == "")
			{
			    
				ShowAlert(121,'Search Criteria');
				document.forms[0].txtsearch.focus();
				return false;
			}
		}	

	}
	
   	var txtval=document.forms[0].txtsearch.value;

	var txtlen=txtval.length;

	if(txtlen<=2 && document.forms[0].radiobutton[0].checked == true)
	{
		 alert("Enter atleast 3 characters");
	     document.forms[0].txtsearch.focus();
	     return;
	}
	var rdovalue="";
	if(document.forms[0].radiobutton[0].checked == true && txtval == "")
	{
	ShowAlert('121','Customer Name');
	return false;
	}
	
	if(document.forms[0].radiobutton[1].checked == true && txtval == "")
	{
	ShowAlert('121','CBS Custemer ID');
	return false;
	}
	if(document.forms[0].radiobutton[2].checked == true && txtval == "")
	{
	ShowAlert('121','LAPS ID');
	return false;
	}
	for(var i=0;i<document.forms[0].radiobutton.length;i++)
	{
		
	if(document.forms[0].radiobutton[i].checked==true)
		{
		
			rdovalue=document.forms[0].radiobutton[i].value;
		}
	}
    // for searching

	var hid_rowcount=document.forms[0].hid_rowcount.value;
	
	if(hid_rowcount=="")
	{
	hid_rowcount=0;
	
	}
	var varPageType=document.forms[0].hidPageType.value;
	var noofrows = document.forms[0].txt_noofrows.value;
	document.all.isearch.src=appURL+"action/com_SisterConcernDisplay.jsp?hidBeanGetMethod=getMasterSearch&hidBeanId=commappmaster&txtsearch="+txtval+"&radiobutton="+rdovalue+"&hid_rowcount="+hid_rowcount+"&noofrows="+noofrows+"&hidCategoryType="+varCategoryType+"&checkcbs=Y&pageType="+varPageType;		
}

function onTextSearch()
{
	var rdovalue="";
	
	for(var i=0;i<document.forms[0].radiobutton.length;i++)
	{

		if(document.forms[0].radiobutton[i].checked==true)
		{
			rdovalue=document.forms[0].radiobutton[i].value;
		}
	}
	if(rdovalue.toUpperCase()=="LAST" || rdovalue.toUpperCase()=="FIRST")
	{
		boolvalue=allowAlphabets();
	}
	/* if(rdovalue.toUpperCase()=="ID" || rdovalue.toUpperCase()=="PAN")
	{
		allowInteger();
	}*/
}

function onRadioClick()
{
	
	/* for(var i=0;i<document.forms[0].radiobutton.length;i++)
	{
		
		if(document.forms[0].radiobutton[i].checked==true)
		{

			if(document.forms[0].radiobutton[i].value=="dob")
			{
				document.all.dob.style.visibility="visible";
				document.forms[0].txtsearch.value="";
				document.forms[0].txtsearch.readOnly=true;
			}
			else
			{
				document.all.dob.style.visibility="hidden";
				document.forms[0].txtsearch.value="";
				document.forms[0].txtsearch.readOnly=false;
				document.forms[0].txtsearch.focus();
			}
		}
	}*/
	
	document.forms[0].txtsearch.value="";
	document.forms[0].txtsearch.readOnly=false;
	document.forms[0].txtsearch.focus();
}
function callCalender(name)
{
	showCal(appURL,name);
	
}

function doClose()
{	
	var con=ConfirmMsg('100');
	if(con)
	{	document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}

function doReset()
{	document.forms[0].reset();
	document.forms[0].txtsearch.readOnly=true;
	document.all.isearch.src=appURL+'action/blank.jsp';
}
function menuOptionDivMouseDown (url)
{	document.currentMenu.style.display='none';
	document.currentMBarOpt.style.border='1px solid lightgrey';
	document.menuIsActive = false;
	document.forms[0].action=url;
	document.forms[0].submit();
}

// Help function added by vino
function dohlp()     
{
  var hlpvar = appURL+"phlp/loan_appretail_custprofile.htm";
  var title = "CustomerProfileSearch";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}
// row count addded by karthik 

function rowCount(nav)
 {
	if(document.forms[0].readFlag.value.toUpperCase()=="R")
	{
	document.forms[0].cmdOK22.disabled=true;
	}
	
 	if(document.forms[0].hid_rowcount.value == "")
 	{
 		document.forms[0].hid_rowcount.value = 0;


 	}
 	else
 	{
 	 	
 		if(nav == 1)
 		{
 			if(parseInt(document.forms[0].hid_rowcount.value) < parseInt(document.forms[0].txt_noofrows.value) + 1)
 			{
	 			document.forms[0].hid_rowcount.value = 0;
	 		}
	 		else
	 		{
			document.forms[0].hid_rowcount.value = parseInt(document.forms[0].hid_rowcount.value) - parseInt(document.forms[0].txt_noofrows.value);
			
			}
		}

		else if(nav == 2)
		{
			document.forms[0].hid_rowcount.value = parseInt(document.forms[0].hid_rowcount.value) + parseInt(document.forms[0].txt_noofrows.value);
		}
		
	    	callExisting();
 	}

 }
 
 function setpageid()
{

	if(trim(document.forms[0].txt_noofrows.value) == "")
	{
		document.forms[0].txt_noofrows.value = "15"
	}
}

// row count to be displayed in screen

