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
	document.forms[0].action=appURL+"action/ops_applicant.jsp?applnt=T&scode=yyy"
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
	else
	{
		alert("Select a search criteria to search");   
		return;
	}
	for(var k=0;k<2;k++)
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

	 if(txtlen<=2)
	 {
	 alert("Enter atleast 3 characters");
     document.forms[0].txtsearch.focus();
     return;
	 }	
	var rdovalue="";
	if(document.forms[0].radiobutton[0].checked == true && txtval == "")
	{
		ShowAlert('121','First Name');
		return false;
	}
	if(document.forms[0].radiobutton[1].checked == true && txtval == "")
	{
		ShowAlert('121','CBS Customer ID');
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
 var noofrows = document.forms[0].txt_noofrows.value;

	document.all.isearch.src=appURL+"action/ops_searchresults.jsp?hidBeanGetMethod=getMasterSearch&hidBeanId=mastapplicant&txtsearch="+txtval+"&radiobutton="+rdovalue+"&hid_rowcount="+hid_rowcount+"&noofrows="+noofrows+"&checkcbs=Y";
}

function onRadioClick()
{
	document.forms[0].txtsearch.value="";
	document.forms[0].txtsearch.readOnly=false;
	document.forms[0].txtsearch.focus();
}
function callCalender(name)
{
	showCal(appURL,name);
	
}

function doClose()
{	var con=ConfirmMsg('100');
	if(con)
	{	document.forms[0].action=appURL+"action/agrpage.jsp";
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

//Help function added by vino
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
 	
 	if(document.forms[0].readFlag.value.toUpperCase()=="R")
 	{
 	document.forms[0].cmdOK22.disabled=true;
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
function setCount()
{

  if(document.forms[0].txt_noofrows.value == "")
	{
		alert(" Enter Value");
		document.forms[0].txt_noofrows.focus();
		return;
	}

	if(parseInt(document.forms[0].txt_noofrows.value) > 100)
	{
		alert("Value should be below 100");
		document.forms[0].txt_noofrows.focus();
		return;
	}
}
