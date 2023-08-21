
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
	else if (document.forms[0].radiobutton[3].checked)
	{
		cat=4;
	}
	else if (document.forms[0].radiobutton[4].checked)
	{
		cat=5;
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
	if(document.forms[0].radiobutton[3].checked == true && (txtlen < 10 || txtlen > 10))
	{
	ShowAlert('121','Correct PAN No');
	document.forms[0].txtsearch.value="";
	document.forms[0].txtsearch.focus();
	return false;
	}
	if(document.forms[0].radiobutton[4].checked == true && txtval == "")
	{
	ShowAlert('121','Proposal Number');
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
	//if(document.forms[0].hidAppType.value=="T")
		//document.all.isearch.src=appURL+"action/iframesearchsolvency.jsp?hidBeanGetMethod=getMasterSearch&hidBeanId=mastapplicant&txtsearch="+txtval+"&radiobutton="+rdovalue+"&hid_rowcount="+hid_rowcount+"&noofrows="+noofrows;
	//else
		document.all.isearch.src=appURL+"action/iframesearchsolvency.jsp?hidBeanGetMethod=getSolvencySearch&hidBeanId=mastapplicant&txtsearch="+txtval+"&radiobutton="+rdovalue+"&hid_rowcount="+hid_rowcount+"&noofrows="+noofrows+"&hidCategoryType="+varCategoryType+"&checkcbs=Y&pageType="+varPageType;
		
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
{	
	var con=ConfirmMsg('100');
	if(con)
	{	document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}

function doReset()
{	document.forms[0].reset();
	//document.forms[0].txtsearch.readOnly=true;
	document.all.isearch.src=appURL+'action/blank.jsp';
}



function rowCount(nav)
 {
	if(document.forms[0].readFlag.value.toUpperCase()=="R")
	{
	//document.forms[0].cmdOK22.disabled=true;
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
