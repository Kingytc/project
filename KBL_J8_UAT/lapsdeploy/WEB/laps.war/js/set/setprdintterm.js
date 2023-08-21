function placeValues()
{
	
	for(var i=0;i<recsize;i++)
	{
		document.forms[0].hidsno[i].value=workid[i];
		document.forms[0].txt_prdtermfrom[i].value=termfrom[i];
		document.forms[0].txt_prdtermto[i].value=termto[i];
		document.forms[0].txt_prdintrate[i].value=termint[i];
		
	}
	for(var j=recsize;j<document.forms[0].hidsno.length;j++)
	{
		document.forms[0].hidsno[i].value="";
		document.forms[0].txt_prdtermfrom[i].value="";
		document.forms[0].txt_prdtermto[i].value="";
		document.forms[0].txt_prdintrate[i].value="";
		

	}
	document.forms[0].edit.disabled=false;
	document.forms[0].apply.disabled=true;
	document.forms[0].cancel.disabled=true;
	document.forms[0].close.disabled=false;
	disableFields(true);
}

function doEdit()
{
	document.forms[0].edit.disabled=true;
	document.forms[0].close.disabled=true;
	document.forms[0].apply.disabled=false;
	document.forms[0].cancel.disabled=false;
	disableFields(false);
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		placeValues();
	}
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/setsearchproducts.jsp";
		 document.forms[0].hidBeanGetMethod.value="getData";
		 document.forms[0].submit();
	}
}

function doSave()
{
	/*for(var i=0;i<document.forms[0].wrk_flowname.length;i++)
	{
		if(document.forms[0].wrk_flowname[i].value!="")
		{
			if(document.forms[0].prd_maxclass[i].value=="" || eval(document.forms[0].prd_maxclass[i].value)<=0)
			{
				ShowAlert(106,"maximum class");
				document.forms[0].prd_maxclass[i].value="";
				document.forms[0].prd_maxclass[i].focus();
				return;
			}
			if(document.forms[0].prd_function[i].value=="")
			{

				ShowAlert(106,"function");
				document.forms[0].prd_function[i].value="";
				document.forms[0].prd_function[i].focus();
				return;
			}

			if(document.forms[0].prd_duration[i].value=="" || eval(document.forms[0].prd_duration[i].value)<=0)
			{
				ShowAlert(106,"duration");
				document.forms[0].prd_duration[i].value="";
				document.forms[0].prd_duration[i].focus();
				return;
			}

		}
	}*/
	document.forms[0].apply.disabled=true;
	document.forms[0].cancel.disabled=true;
	//document.forms[0].prd_code.value=document.forms[0].prdCode.value;	
	//document.forms[0].wrk_flowtype.value=strWrkflowtype;
	document.forms[0].hidBeanMethod.value="updateIntTermsData";
	document.forms[0].hidBeanGetMethod.value="getIntTermsData";
	document.forms[0].hidSourceUrl.value="/action/setprdintterms.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}



/*function checkFlowname(idx)
{
	if(document.forms[0].wrk_flowname[idx].value=="")
	{
		ShowAlert(109);
		document.forms[0].wrk_flowname[idx].focus();
	}
}*/

function disableFields(flag)
{
	for(var i=0;i<8;i++)
	{
		document.forms[0].txt_prdtermfrom[i].disabled=flag;
		document.forms[0].txt_prdtermto[i].disabled=flag;
		document.forms[0].txt_prdintrate[i].disabled=flag;
		
	}
}
function callOtherTab(url)
{
	if(!document.forms[0].apply.disabled)
	 {
		 ShowAlert(103);
		 return;
	 }
	 if(url=="setproducts.jsp" || url=="produsedby.jsp" || url=="prodinterest.jsp")
	 {
		 document.forms[0].hidBeanGetMethod.value="getData";
	 }
	 if(url=="setprdauth.jsp")
	 {
		 document.forms[0].hidBeanGetMethod.value="getAuthorityData";
	 }
	 if(url=="setprdworkflow.jsp")
	 {
		 document.forms[0].hidBeanGetMethod.value="getWorkflowData";
	 }
	 if(url=="setprddoc.jsp")
	 {
		 document.forms[0].hidBeanGetMethod.value="getDocData";
	 }
	 //document.forms[0].prd_code.value=document.forms[0].prdCode.value;
	 document.forms[0].action=appUrl+"action/"+url;
	 document.forms[0].submit();
 }
 
 function menuOptionDivMouseDown (url)
		{
		
			if(!document.forms[0].apply.disabled)
			{
				ShowAlert(103);
				return;
			}
			document.forms[0].hidBeanId.value="";
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			document.forms[0].action=url;
			document.forms[0].submit();
					
		}

		function loadUsedApp()
{

	if(document.forms[0].checkApp.value=="Yes")
	{
		document.forms[0].edit.disabled=true;
		document.forms[0].apply.disabled=true;
		document.forms[0].cancel.disabled=true;
		document.forms[0].close.disabled=false;
		
	}
}