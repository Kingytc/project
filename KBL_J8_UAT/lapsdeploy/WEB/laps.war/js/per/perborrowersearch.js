function callExisting()
{	
	var area1="";
    var area2="";
    var area3="";
    var area4=""; 
    var area5="";
   if( document.forms[0].radiobutton[0].checked)
   {
	if(orglevel == "C")
	{	
		area2 = document.forms[0].hidarea2.value;
		if(area2=="")
		{
			alert("Select a Region");
			return;
		}
		area3=document.forms[0].hidarea3.value;
		if(area3=="")
		{
			alert("Select a CLPU");
			return;
		}
		area4=document.forms[0].hidarea4.value;
		if(area4=="")
		{
			alert("Select a Branch");
			return;
		}
	}
	else if(orglevel == "R")
	{
		area3=document.forms[0].hidarea3.value;
		if(area3=="")
		{
			alert("Select a CLPU");
			return;
		}
		area4=document.forms[0].hidarea4.value;
		if(area4=="")
		{
			alert("Select a Branch");
			return;
		}
	}
	else if(orglevel == "D")
	{
		area4=document.forms[0].hidarea4.value;
		if(area4=="")
		{
			alert("Select a Branch");
			return;
		}
	}
	else if(orglevel == "A")
	{
		area4=level;
		if(area4=="")
		{
			alert("Select a Branch");
			return;
		}
	}
   }
   
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
	ShowAlert('121','Borrower Name');
	document.forms[0].txtsearch.value="";
	document.forms[0].txtsearch.focus();
	return false;
	}
	
	if(document.forms[0].radiobutton[1].checked == true && txtval == "")
	{
	ShowAlert('121','CBS Custemer ID');
	document.forms[0].txtsearch.value="";
	document.forms[0].txtsearch.focus();
	return false;
	}
	if(document.forms[0].radiobutton[2].checked == true && txtval == "")
	{
	ShowAlert('121','Application No.');
	document.forms[0].txtsearch.value="";
	document.forms[0].txtsearch.focus();
	return false;
	}
	if(document.forms[0].radiobutton[3].checked == true && txtval == "")
	{
		ShowAlert('121','Proposal No.');
		document.forms[0].txtsearch.value="";
		document.forms[0].txtsearch.focus();
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
	//var varPageType=document.forms[0].hidPageType.value;
	var noofrows = document.forms[0].txt_noofrows.value;
	var hidCategoryType= document.forms[0].hidCategoryType.value;
		document.all.result.src=appURL+"action/perborrowerresult.jsp?hidBeanGetMethod=getBorrowerDetails&txtsearch="+txtval+"&radiobutton="+rdovalue+"&hid_rowcount="+hid_rowcount+"&noofrows="+noofrows+"&checkcbs=Y&area1="+area1+"&area2="+area2+"&area3="+area3+"&area4="+area4+"&area5="+area5+"&hidCategoryType="+hidCategoryType;
		//+"&area1="+area1+"&scode="+scode+"&bow_name="+bow_name+"&dateofbirth="+ document.forms[0].dateofbirth.value+"&area2="
		//+area2+"&area3="+area3+"&area4="+area4+"&area5="+area5";		
}
function onRadioClick()
{
	document.forms[0].txtsearch.value="";
	document.forms[0].txtsearch.readOnly=false;
	document.forms[0].txtsearch.focus();
}

function setpageid()
{

	if(trim(document.forms[0].txt_noofrows.value) == "")
	{
		document.forms[0].txt_noofrows.value = "15"
	}
}

function doReset()
	{
		document.forms[0].reset();
		document.forms[0].txtsearch.focus();
		document.all.result.src=appURL+"action/blank.jsp";

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
function doSearch()
{
   if(document.forms[0].bow_name.value && document.forms[0].dateofbirth.value != "")
	{
		alert("Search by Borrower name or Date of birth");
		return;
	}
   if(document.forms[0].bow_name.value==""  && document.forms[0].dateofbirth.value == "")
	{
		alert("Enter data in any of the search criteria");
		return;
	}
    var area1="";
    var area2="";
    var area3="";
    var area4=""; 
    var area5="";

	if(orglevel == "C")
	{	
		area2 = document.forms[0].hidarea2.value;
		if(area2=="")
		{
			alert("Select Regional Office");
			return;
		}
		area3=document.forms[0].hidarea3.value;
		if(area3=="")
		{
			alert("Select CLPU");
			return;
		}
		area4=document.forms[0].hidarea4.value;
		if(area4=="")
		{
			alert("Select a Branch");
			return;
		}
	}
	else if(orglevel == "R")
	{
		area3=document.forms[0].hidarea3.value;
		if(area3=="")
		{
			alert("Select CLPU");
			return;
		}
		area4=document.forms[0].hidarea4.value;
		if(area4=="")
		{
			alert("Select a Branch");
			return;
		}
	}
	else if(orglevel == "D")
	{
		area4=document.forms[0].hidarea4.value;
		if(area4=="")
		{
			alert("Select a Branch");
			return;
		}
	}
	else if(orglevel == "A")
	{
		area4=level;
		if(area4=="")
		{
			alert("Select a Branch");
			return;
		}
	}
	scode="";
	
   // for searching

	hid_rowcount=document.forms[0].hid_rowcount.value;
	
	if(hid_rowcount=="")
	{
	hid_rowcount=0;
	
	}
    noofrows = document.forms[0].txt_noofrows.value;
	bow_name =  document.forms[0].bow_name.value;
	
	hidCategoryType= document.forms[0].hidCategoryType.value;
	
	document.all.result.src=appURL+"action/perborrowerresult.jsp?hidBeanGetMethod=getBorrowerDetails&area1="
	+area1+"&scode="+scode+"&bow_name="+bow_name+"&dateofbirth="+ document.forms[0].dateofbirth.value+"&area2="
	+area2+"&area3="+area3+"&area4="+area4+"&area5="+area5+"&hidCategoryType="+hidCategoryType
	+"&hid_rowcount="+hid_rowcount+"&noofrows="+noofrows+"&chk_staff_only="+document.forms[0].chk_staff_only.value;

}

function callCalender(name)
	{
	showCal(appURL,name);
	}
	
function doClose()
{
	if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appURL+"action/retailpge.jsp";
		 document.forms[0].submit();
	 }
}

function showSystem(val,glpsize)
{
	prop = "scrollbars=yes,width=500,height=355,statusbar=yes";	
	xpos = (screen.width - 700) / 2;
	ypos = (screen.height - 550) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	
	if(orglevel == "C")
	{
		if(val == "2")
		{			
			valsys=level.substring(0,3)+"%%%000000000";
			var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
		}
		if(val == "3")
		{
			if(document.forms[0].hidarea2.value != "")
			{
				level = document.forms[0].hidarea2.value;
				valsys=level.substring(0,6)+"%%%000000";
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
			}
				else
				{
					alert("select a Region");
					return;
				}
		}
		    if(val == "4")
			{
				if(document.forms[0].hidarea2.value != "" && document.forms[0].hidarea3.value != "")
				{
				level = document.forms[0].hidarea3.value;
				valsys=level.substring(0,9)+"%%%000"	;
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
				}
				else
				{
					alert("select a CLPU");
					return;
				}
			}
		if(val == "5")
			{
				if(document.forms[0].hidarea2.value != "" && document.forms[0].hidarea3.value != "" &&  document.forms[0].hidarea4.value != "")
				{
				level = document.forms[0].hidarea4.value;
				valsys=level.substring(0,12)+"%%%"	;
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
				}
				else
				{
					alert("Select a Branch");
					return;
				}
			}
	}
	else if(orglevel == "R")
	{
		
		if(val == "3")
			{
				
				valsys=level.substring(0,9)+"%%%000"	;
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
				
			}
		if(val == "4")
			{
				if(document.forms[0].hidarea3.value != "" )
				{
				level = document.forms[0].hidarea3.value;
				valsys=level.substring(0,12)+"%%%"	;
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
				}
				else
				{
					alert("Select a Branch");
					return;
				}
			}
	}
	else if(orglevel == "D")
	{
		if(val == "4")
			{
				
				valsys=level.substring(0,9)+"%%%000";
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
							
			}
		
	}
	
	title="help";
	//alert(purl);
	window.open(purl,title,prop);
	


}
function rowCount(nav)
{
	if(document.forms[0].hid_rowcount.value == "")
 	{
 		document.forms[0].hid_rowcount.value = 0;
 		document.all.result.src=appURL+"action/blank.jsp";
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
	    	doSearch();
	}

 }
 
function changeStaffFlag()
{
	if(document.forms[0].chk_staff_only.checked)
		document.forms[0].chk_staff_only.value = "Y";
	else
		document.forms[0].chk_staff_only.value = "N";		 	
}