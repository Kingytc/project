	function setData()
	{
		doAfterEdit();
	}
	function doAfterEdit()
	{		
		disableCommandButtons("load");
		disableFields(true);
	}
	function disableCommandButtons(val)
	{
	  if(val=="load")
	  {		 
		  document.forms[0].cmdedit.disabled=false;
		  document.forms[0].cmdsave.disabled=true;
		  document.forms[0].cmdcancel.disabled=true;
		  document.forms[0].cmdclose.disabled=false;
	  }
	  if(val=="edit")
	  {
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;
		 document.forms[0].cmdclose.disabled=true;
	  }
	}	
	function doEdit()
	{
		document.forms[0].hidAction.value="INSERT";
		disableCommandButtons("edit");
		disableFields(false);
	}	
	function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].name=="txtsanc_limit")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
		}
	}
	function doSave()
	{
		document.forms[0].cmdsave.disabled=true;
		if(document.forms[0].hidPage.value!="Delegate")
		{
		document.forms[0].hidAction.value="update";
        document.forms[0].hidRecordflag.value=varRecordFlag;
		document.forms[0].hidBeanId.value="prdsanclimit";
		document.forms[0].hidBeanMethod.value="updateData";
		document.forms[0].hidSourceUrl.value="/action/prodsanclimit.jsp";
		document.forms[0].action=path+"controllerservlet";
		document.forms[0].submit();
		}
		else
		{
			document.forms[0].hidAction.value="update";
	      	document.forms[0].hidBeanId.value="prdsanclimit";
			document.forms[0].hidBeanMethod.value="updateDelegate";
			document.forms[0].hidBeanGetMethod.value ="getDelegate"
			document.forms[0].hidSourceUrl.value="/action/prod_delegatedPowers.jsp";
			document.forms[0].action=path+"controllerservlet";
			document.forms[0].submit();
		}
	}
	function doCancel()
	{	
		if(document.forms[0].hidPage.value!="Delegate")
		{
		if(ConfirmMsg(102))
		{
			document.forms[0].hideditflag.value = "no";
			document.forms[0].hidBeanId.value="prdsanclimit";
			document.forms[0].hidBeanGetMethod.value = "getData";
			document.forms[0].action = path+"action/prodsanclimit.jsp";
			document.forms[0].method="post";
			document.forms[0].submit();
		}
		}
		else
		{
			document.forms[0].hidBeanId.value="prdsanclimit";
			document.forms[0].hidBeanGetMethod.value ="getDelegate"
			document.forms[0].hidSourceUrl.value="/action/setupnav.jsp";
			document.forms[0].action=path+"controllerservlet";
			document.forms[0].submit();
		}
	}
	function callOtherTab(url)
	{
		if(!document.forms[0].cmdsave.disabled)
		{
			ShowAlert(103);
		}
		else
		{
			if(url=="setproducts.jsp" || url=="produsedby.jsp" || url=="prodinterest.jsp")
			{
				document.forms[0].hidBeanGetMethod.value="getData";
			}
			if(url=="setprddoc.jsp")
			{
				document.forms[0].hidBeanGetMethod.value="getDocData";
			}
			if(url=="setprdworkflow.jsp")
			{
				document.forms[0].hidBeanGetMethod.value="getWorkflowData";
			}
			if(url=="setprdauth.jsp")
			{
				document.forms[0].hidBeanGetMethod.value = "getAuthorityData";
			}
			 if(url=="setprdintterms.jsp")
			{
				 document.forms[0].hidBeanId.value="setproducts";
				document.forms[0].hidBeanGetMethod.value="getIntTermsData";
			}
			document.forms[0].action=path+"action/"+url;
			document.forms[0].submit();
		}
	}
	function doClose()
	{
		if(document.forms[0].hidPage.value!="Delegate")
		{
		if( ConfirmMsg(100) )
		{
			document.forms[0].action =path+"action/setsearchproducts.jsp";
			document.forms[0].submit();
		}
		}
		else
		{
			document.forms[0].action =path+"action/setupnav.jsp";
			document.forms[0].submit();
		}
	}
	function allowSPInteger(n,i)
	{
		if (isNaN(n) && n!="")
		{
			ShowAlert("121","Integer");
			document.forms[0].txtnpa_workclass[i].select();
			document.forms[0].txtnpa_workclass[i].focus();
			return;
		}
	}
function loadUsedApp()
{
	if(document.forms[0].checkApp.value=="Yes")
	{
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
}
function callScheme()
{
	document.forms[0].hidBeanId.value="prdsanclimit";
	document.forms[0].hidBeanMethod.value="updateDelegate";
	document.forms[0].hidBeanGetMethod.value = "getDelegate";
	document.forms[0].action = path+"action/prod_delegatedPowers.jsp?&schemeid="+document.forms[0].sel_bankscheme.value;
	document.forms[0].submit();

}
function callload()
{
document.forms[0].sel_bankscheme.value=varSchemeCode;
}