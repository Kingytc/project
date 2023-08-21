
function allowEntry(tmptxt)
{
	if(document.forms[0].prd_range[0].checked == true)
	{
		
	}
	else if(document.forms[0].prd_range[1].checked == true)
	{
		allowDecimals(tmptxt);
	}
}

function loadDatas()
{	
	document.forms[0].hidBeanId.value="setsearchproducts";
	document.forms[0].hidSourceUrl.value="/action/SetSearchProducts.jsp";
	if(strext == "Existing")
	{
		document.forms[0].prd_choose[1].checked = true;
		//showsub();
	}
	if(strext == "renew")
	{
		document.forms[0].prd_choose[2].checked = true;
		//showsub();
	}	
	if(strSaveType == "p")
	{
		document.forms[0].prd_save[0].checked = true;
	}
	else if(strSaveType == "c")
	{
		document.forms[0].prd_save[1].checked = true;
	}
	if(varprodavail=="n")
	{
		document.forms[0].prodavail[0].checked=true;
	}
	else
	{
		document.forms[0].prodavail[1].checked=true;
	}
	if(strSearchType == "Category")
	{
		document.forms[0].prd_range[0].checked = true;
		showtxt();
		document.forms[0].textrng.value = strcat;
	}
	else if(strSearchType == "Range")
	{
		document.forms[0].prd_range[1].checked = true;
		showtxt();
		document.forms[0].textrng.value = strRangeFrom;
		document.forms[0].textto.value = strRangeTo;
	}
	if(strType == "p")
	{
		document.forms[0].prd_producttype.checked = true;
		document.forms[0].cmdgetproducts.disabled = false;
		document.forms[0].prd_save[0].disabled = false;
		document.forms[0].prd_save[1].disabled = false;
		document.forms[0].prd_range[0].disabled = false;
		document.forms[0].prd_range[1].disabled = false;
		document.forms[0].prd_producttype.disabled = false;
		//document.forms[0].prd_producttype[1].disabled = false;
		document.forms[0].prodavail[0].disabled = false;
		document.forms[0].prodavail[1].disabled = false;
	}
	/*else if (strType == "a")
	{
			document.forms[0].prd_producttype[1].checked = true;
			document.forms[0].cmdgetproducts.disabled = false;
			document.forms[0].prd_save[0].disabled = false;
			document.forms[0].prd_save[1].disabled = false;
			document.forms[0].prd_range[0].disabled = false;
			document.forms[0].prd_range[1].disabled = false;
			document.forms[0].prd_producttype[0].disabled = false;
			document.forms[0].prd_producttype[1].disabled = false;
			document.forms[0].prodavail[0].disabled = false;
			document.forms[0].prodavail[1].disabled = false;

	}*/
}

function disRadio()
{
	for(i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type == "radio")
		{
			document.forms[0].elements[i].disabled = true;
		}
	}
	document.forms[0].prd_choose[0].disabled = false;
	document.forms[0].prd_choose[1].disabled = false;
	document.forms[0].prd_choose[2].disabled = false;
	
}

function showtxt()
{
	if(document.forms[0].prd_range[0].checked == true)
	{
		document.all.range1.style.visibility="hidden";
		document.all.range2.style.visibility="hidden";
		document.all.range3.style.visibility="visible";
		document.all.range4.style.visibility="hidden";
		document.forms[0].textrng.maxLength = 30;
		document.forms[0].textrng.style.textAlign = "left";
		document.forms[0].textrng.focus();
		document.forms[0].hidprd_rng.value = "cat";		
	}
	else if(document.forms[0].prd_range[1].checked == true)
	{
		document.all.range1.style.visibility="visible";
		document.all.range2.style.visibility="visible";
		document.all.range3.style.visibility="visible";
		document.all.range4.style.visibility="visible";
		document.forms[0].textrng.maxLength = 15;
		document.forms[0].textto.maxLength = 15;
		document.forms[0].textrng.style.textAlign = "right";
		document.forms[0].textto.style.textAlign = "right";
		document.forms[0].textrng.focus();
		document.forms[0].hidprd_cat.value = "";
		document.forms[0].hidprd_rng.value = "rng";		
	}
}

function clears()
{
	document.forms[0].textrng.value ="";
	document.forms[0].textto.value ="";
}

function doReset()
{
	document.forms[0].reset();
	document.forms[0].action = appURL+"action/setsearchproducts.jsp";
	document.forms[0].submit();
}

function removeCheck()
{
	document.forms[0].prd_range[0].checked = false;
	document.forms[0].prd_range[1].checked = false;
	document.forms[0].prd_save[0].checked = false;
	document.forms[0].prd_save[1].checked = false;
	document.forms[0].prd_term[0].checked = false;
	document.forms[0].prd_term[1].checked = false;
	document.forms[0].textrng.value = "";
	document.forms[0].textto.value = "";		
}

function showcomm()
{
	document.forms[0].prd_save[0].disabled = false;
	document.forms[0].prd_save[1].disabled = false;
	document.forms[0].prd_range[0].disabled = false;
	document.forms[0].prd_range[1].disabled = false;
	document.forms[0].prd_producttype.disabled = false;
	//document.forms[0].prd_producttype[1].disabled = false;
	document.forms[0].prodavail[0].disabled = false;
	document.forms[0].prodavail[1].disabled = false;
	
	document.forms[0].cmdgetproducts.disabled=false;	
}

function callLink(pcode)
{
	document.forms[0].method="post";
	if(pcode == 'New')
	{
		document.forms[0].prdCode.value=pcode;
		document.forms[0].action=appURL+"action/setproducts.jsp?prd_type=pH";
		document.forms[0].submit();
	}
	else
	{
		document.forms[0].prdCode.value=pcode;
		document.forms[0].action=appURL+"action/setproducts.jsp?val=existing";
		document.forms[0].submit();
	}
}

function showsub()
{
	if(document.forms[0].prd_choose[1].checked == true)
	{
		if(varRights == "p")
		{
			document.forms[0].prd_type[0].disabled =false;			
		}
		if(varRights == "c")
		{
			document.forms[0].prd_type[1].disabled =false;
		}
		if(varRights == "b")
		{
			document.forms[0].prd_type[0].disabled =false;
			document.forms[0].prd_type[1].disabled =false;
			document.forms[0].prd_type[2].disabled =false;
			document.forms[0].prd_type[3].disabled =false;			
		}
	}
}

function termassign()
{

}

function producttype()
{
	if(document.forms[0].prd_producttype.checked==true)
	{
		//document.forms[0].hid_producttype.value="";
		document.forms[0].hid_producttype.value="p";
	}
	//else if(document.forms[0].prd_producttype[1].checked==true)
	//{
		//document.forms[0].hid_producttype.value="";
	//	document.forms[0].hid_producttype.value="a";
	//}
}
function productavail()
{
	if(document.forms[0].prodavail[0].checked==true)
	{
		document.forms[0].hid_prodavail.value="n";
	}
	else if(document.forms[0].prodavail[1].checked==true)
	{
		document.forms[0].hid_prodavail.value="y";
	}
}
function saveassign()
{
	if(document.forms[0].prd_save[0].checked == true)
	{
		document.forms[0].hidprd_save.value="p";
	}
	else if(document.forms[0].prd_save[1].checked == true)
	{
		document.forms[0].hidprd_save.value="c";
	}
}

function doGetProducts()
{
	showcomm();
	saveassign();
	termassign();
	showtxt();
	producttype();
	productavail();
	if((document.forms[0].prd_producttype.checked==false))
	{
		alert("Select the Product");
		return;
	}
	if((document.forms[0].prd_save[0].checked==false) && document.forms[0].prd_save[1].checked==false)
	{
		alert("Select any one option for Save Type");
		return;
	}
	document.forms[0].hidprd_cat.value = document.forms[0].textrng.value;
	if(document.forms[0].hidprd_rng.value == "cat")
	{
		if(document.forms[0].hidprd_cat.value != "")
		{
			document.forms[0].textrng.value ="";
		}
	}
	else if(document.forms[0].hidprd_rng.value == "rng")
	{
		document.forms[0].hidprd_cat.value ="";
	}	
	document.forms[0].hidprd_select.value ="getSelect";
	document.forms[0].action = appURL+"action/setsearchproducts.jsp";
	document.forms[0].submit();
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}

function menuOptionDivMouseDown (url)
{	
	document.currentMenu.style.display='none';
	document.currentMBarOpt.style.border='1px solid lightgrey';
	document.menuIsActive = false;
	document.forms[0].action=url;
	document.forms[0].submit();			
}

function dohlp()     
{
  var hlpvar = appURL+"phlp/setup_retailprod_searchprod.htm";
  var title = "ProductSearch";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}