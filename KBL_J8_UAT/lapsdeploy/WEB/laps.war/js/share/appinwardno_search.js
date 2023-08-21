function callack()
{
		var txtval=document.forms[0].txt_value.value;
		var txtlen=txtval.length;
	 	
		if(document.forms[0].radiobutton[0].checked==true)
		{
			 if(txtlen<=2)
			 {
				 alert("Enter atleast 3 characters");
			     document.forms[0].txt_value.focus();
			     return false;
			 }
		}
		if(document.forms[0].radiobutton[1].checked==true)
		{
			 if(txtlen<1)
			 {
				 alert("Enter atleast 1 character");
			     document.forms[0].txt_value.focus();
			     return false;
			 }
		}
		if(document.forms[0].radiobutton[2].checked==true)
		{
			 if(txtlen<1)
			 {
				 alert("Enter CBS Custemer ID");
			     document.forms[0].txt_value.focus();
			     return false;
			 }			
		}
	return true;
	}
function resetme()
{
	document.forms[0].reset();
	document.all.result.src=appUrl+"action/blank.jsp";

}
function onRadioClick()
{
	if(document.forms[0].radiobutton[0].checked==true)
	{
		document.forms[0].hidvalue.value="name";
	}
	else  if(document.forms[0].radiobutton[1].checked==true)
	{	
		document.forms[0].hidvalue.value="no";
	}
	else  if(document.forms[0].radiobutton[2].checked==true)
	{	
		document.forms[0].hidvalue.value="CBSID";
	}
	document.forms[0].txt_value.value="";
	document.forms[0].txt_value.focus();
}
function checkRadioButton(val)
{
	if(document.forms[0].radiobutton[0].checked==true)
	{
		notAllowSplChar(val);
		document.forms[0].hidvalue.value="name";
	}
	else  if(document.forms[0].radiobutton[1].checked==true)
	{	
		allowInteger(val);
		document.forms[0].hidvalue.value="no";
	}
	else  if(document.forms[0].radiobutton[2].checked==true)
	{	
		document.forms[0].hidvalue.value="CBSID";
	}
}
function callNew()
{
		//document.forms[0].action=appUrl+"action/appinwardreg.jsp?new=Y";
	    document.forms[0].hidvalue.value="Y";
		document.forms[0].hidBeanId.value="inwardRegister"
		document.forms[0].hidBeanGetMethod.value="getdata";
		document.forms[0].action=appURL+"action/appinwardreg.jsp?new=Y";
		document.forms[0].submit();
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
function doSearch()
{
    var area1="";
    var area2="";
    var area3="";
    var area4=""; 
    var area5="";
    if(document.forms[0].radiobutton[0].checked==true)
	{
	if(orglevel == "C")
	{	
		area2 = document.forms[0].hidarea2.value;
		if(area2=="")
		{
			alert("Select a Zone");
			return;
		}
		area3=document.forms[0].hidarea3.value;
		if(area3=="")
		{
			alert("Select a region");
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
			alert("Select a region");
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
		if(area4=="" && varRLPFUser!="012")
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
	scode="";
	
   // for searching

	hid_rowcount=document.forms[0].hid_rowcount.value;
	
	if(hid_rowcount=="")
	{
	hid_rowcount=0;
	
	}
    noofrows = document.forms[0].txt_noofrows.value;
	txt_search =  document.forms[0].txt_value.value;
	if(document.forms[0].radiobutton[0].checked==false && document.forms[0].radiobutton[1].checked==false && document.forms[0].radiobutton[2].checked==false)
	{
		alert("Select atleast one option");
		return false;
	}
	
	
	var hid_value = document.forms[0].hidvalue.value;
	if(callack())
	{
			document.all.result.src=appUrl+"action/appinwardno_result.jsp?hidBeanGetMethod=getInwardnoSearch&area1="
	+area1+"&scode="+scode+"&search="+txt_search+"&area2="+area2+"&area3="+area3+"&area4="+area4+"&area5="+area5+"&hid_rowcount="+hid_rowcount+"&noofrows="+noofrows+"&hidvalue="+hid_value;
	}
	

}
function doClose()
{
	if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appUrl+"action/mainnav.jsp";
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
				valsys=level.substring(0,6)+"%%%000000"
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
			}
				else
				{
					alert("select a Zone");
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
					alert("select a Region");
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
 		document.all.result.src=appUrl+"action/blank.jsp";
		//resetme();
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
 
function onloading()
{
	if(((orglevel == "A"||orglevel == "C" ) && vargrprights=="w")||(orglevel == "D" && vargrprights=="w" && varRLPFUser=="012"))
	{
		document.forms[0].cmdnew.disabled=false;
	}
	else
	{
		document.forms[0].cmdnew.disabled=true;
	}
}