function callNew()
{
	if(approvedApplDemoid=="Y")
	{
		alert("Kindly click on modify in customer profile and update latest details before proceeding");
		document.all.result.src=appURL+"action/blank.jsp";
		document.all.search.style.visibility="hidden";
		document.all.search.style.position="absolute";
		document.all.idinward.style.visibility="hidden";
		document.all.idinward.style.position="absolute";
		return;
	}
	document.forms[0].method="post";
	document.forms[0].hidStatus.value="copy";
	document.forms[0].appno.value="new";
	document.forms[0].hidAction.value="insert";
	var varcomappid=document.forms[0].comapp_id.value;
	var varcomapp_newid=document.forms[0].comapp_newid.value;
	
	if(varcomappid=="")
	{
		varcomappid=document.forms[0].comapp_oldid.value;
	}
	if(document.forms[0].radLoan[0].checked==true)
	{
		document.forms[0].hidType.value="F";
	}
	//if(document.forms[0].radLoan[2].checked==true)
	//{
		//document.forms[0].hidType.value="C";
	//}
	if(document.forms[0].hidCategoryType.value=="OPS")
	{
		document.forms[0].action=appURL+"action/ops_facilities.jsp";
		document.forms[0].hidBeanGetMethod.value="getOPSFacilityData";
	}
	else
	{
		document.forms[0].action=appURL+"action/facilities.jsp?valuesin=L&varComId="+varcomappid+"&type="+document.forms[0].hidType.value+"&varComNewid="+varcomapp_newid;
		document.forms[0].hidBeanGetMethod.value="getFacilityData";
	}
	document.forms[0].submit();
}

function doSave()
{
	//alert(document.forms[0].hidCategoryType.value);
	var txtSearch = document.forms[0].txtSearch.value;
	var appDtls;
	var prinDtls;
	var collDtls;
	var finDtls;

	if(document.forms[0].radSearch.checked == true && txtSearch == "")
	{
		ShowAlert('121','Application No');
		return false; 
	}
	
	/*if(document.forms[0].radSearch.checked == true && txtSearch != "" && document.forms[0].txt_appinwardno.value=="")
	{
		ShowAlert('121','Application Inward No');
		return false; 
	}*/
	
	if(document.forms[0].chkApp.checked == true)
	{
		appDtls = "Y";
	}
	else
	{
		appDtls = "N";
	}

	if(document.forms[0].chkCoApp.checked == true)
	{
		prinDtls = "Y";
	}
	else
	{
		prinDtls = "N";
	}

	if(document.forms[0].chkColl.checked == true)
	{
		collDtls = "Y";
	}
	else
	{
		collDtls = "N";
	}

	if(document.forms[0].chkFin.checked == true)
	{
		finDtls = "Y";
	}
	else
	{
		finDtls = "N";
	}

	var searchBy;
	if(document.forms[0].radSearch.checked == true)
	{
		searchBy  = "A";
	}
 	var val = document.forms[0].txtSearch.value;
    var valf=document.forms[0].chkFin.value;
    var valm=document.forms[0].chkColl.value;
    var valg=document.forms[0].chkCoApp.value;
    var vala=document.forms[0].chkApp.value;
    
	
    if ((valf=='on') && (valm=='on') && (valg=='on') && (vala=='on'))
   {
   alert("Select Any one Check Box");
   return;
   } 
   else
   {
	  document.forms[0].strAppval.value=val;
	  document.forms[0].strAppFlag.value=valf;
	  document.forms[0].strAppSecurity.value=valm;
	  document.forms[0].strAppGroupflag.value=valg;
	  document.forms[0].strchkApp.value=vala;
	 
	document.forms[0].method="post";
	document.forms[0].appno.value="new";
	document.forms[0].hidStatus.value="copy";
	document.forms[0].hidAction.value="insert";
	if(document.forms[0].hidCategoryType.value=="OPS")
	{
		document.forms[0].action=appURL+"action/ops_facilities.jsp?val="+val+"&valf="+valf+"&valm="+valm+"&valg="+valg;
		document.forms[0].hidBeanGetMethod.value="getOPSFacilityData";
	}
	else
	{
		document.forms[0].action=appURL+"action/facilities.jsp?val="+val+"&valf="+valf+"&valm="+valm+"&valg="+valg;
		document.forms[0].hidBeanGetMethod.value="getFacilityData";
	}
	
	document.forms[0].submit();
	}

}

function enableText()
{
	document.forms[0].txtSearch.disabled = false;
	document.forms[0].chkApp.disabled = false;
	document.forms[0].chkCoApp.disabled = false;
	document.forms[0].chkColl.disabled = false;
	document.forms[0].chkFin.disabled = false;
	document.forms[0].cmdOK.disabled = false;
	document.forms[0].cmdCancel.disabled = false;
}

function callFin()
{
	if(document.forms[0].chkFin.checked==true)
	{
		document.forms[0].chkFin.value="Y";
	}
	else
	{
		document.forms[0].chkFin.value="on";
	}
}

function callMang()
{
	if(document.forms[0].chkColl.checked==true)
	{
		document.forms[0].chkColl.value="Y";
	}
	else
	{
		document.forms[0].chkColl.value="on";
	}
}

function callGroup()
{
	if(document.forms[0].chkCoApp.checked==true)
	{
		document.forms[0].chkCoApp.value="Y";
	}
	else
	{
		document.forms[0].chkCoApp.value="on";
	}
}


function showAckSearch()
{		
	if(document.forms[0].radSearch.checked == true && document.forms[0].txtSearch.value != "")
	{
		var varcategory;
		if(document.forms[0].hidCategoryType.value="OPS")
		{
			varcategory="t";
		}
		else
		{
			varcategory="c";
		}
		var varQryString = appURL+"action/searchAppinwradno.jsp?Category="+varcategory+"&proposal="+document.forms[0].hidPropType.value;
		var title = "Acknowledgement";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}	
}
