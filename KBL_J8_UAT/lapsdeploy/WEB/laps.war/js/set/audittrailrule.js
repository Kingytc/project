	function onopen()
	{
		
		if(type=="Y")
		{
		
		document.audittrail.optAud[0].checked   = true;
		document.audittrail.cmbapp.selectedIndex = appform;
		document.audittrail.cmbpre.selectedIndex = pre;
		document.audittrail.cmbpost.selectedIndex = post;
		document.audittrail.cmbbr.selectedIndex = br;
		document.audittrail.cmbset.selectedIndex = set;
		
		}
		if(type=="N")
		{
		document.audittrail.optAud[1].checked   = true;
		document.audittrail.cmbapp.selectedIndex = 0;
		document.audittrail.cmbpre.selectedIndex = 0;
		document.audittrail.cmbpost.selectedIndex = 0;
		document.audittrail.cmbbr.selectedIndex = 0;
		document.audittrail.cmbset.selectedIndex = 0;
		
		}
		document.audittrail.cmdapply.disabled    = true;
		document.audittrail.cmdcancel.disabled   = true;
		document.audittrail.cmbapp.disabled      = true;
		document.audittrail.cmbpre.disabled      = true;
		document.audittrail.cmbpost.disabled     = true;
		document.audittrail.cmbbr.disabled       = true;
		document.audittrail.cmbset.disabled      = true;
		document.audittrail.optAud[0].disabled   = true;
		document.audittrail.optAud[1].disabled   = true;
   	
	}

		function onedit()
	{
		document.audittrail.cmdapply.disabled    = false;
		document.audittrail.cmdcancel.disabled   = false;
		document.audittrail.cmdedit.disabled     = true;
		document.audittrail.optAud[0].disabled   = false;
		document.audittrail.optAud[1].disabled   = false;
		
		if (document.audittrail.optAud[0].checked==true)
		{
		
		document.audittrail.cmbapp.disabled      = false;
		document.audittrail.cmbpre.disabled      = false;
		document.audittrail.cmbpost.disabled     = false;
		document.audittrail.cmbbr.disabled       = false;
		document.audittrail.cmbset.disabled      = false;
		}
	}
	
	function oncancel()
	{
	if(ConfirmMsg('102'))
		{
		//document.audittrail.action = path+"/audittrialrule.jsp";
		document.audittrail.submit();
		}
	}

	function closewindow()
	{
	document.audittrail.action=path+"action/setupnav.jsp";
	document.audittrail.submit();
	}
	function fld(mode)
	{
	
		if (mode=="D")
		{
		alert("You are turning off Audit Trail");
		document.audittrail.cmbapp.selectedIndex   = 0
		document.audittrail.cmbapp.disabled        = true;
		
		document.audittrail.cmbpre.selectedIndex   = 0
		document.audittrail.cmbpre.disabled		   = true;

        document.audittrail.cmbpost.selectedIndex  = 0
		document.audittrail.cmbpost.disabled       = true;
	
		document.audittrail.cmbbr.selectedIndex    = 0
		document.audittrail.cmbbr.disabled         = true;

		document.audittrail.cmbset.selectedIndex   = 0
		document.audittrail.cmbset.disabled        = true;
		}

		if (mode=="E")
		{
		
		document.audittrail.cmbapp.disabled		   = false;
		
		document.audittrail.cmbpre.disabled		   = false;

		document.audittrail.cmbpost.disabled	   = false;
	
		document.audittrail.cmbbr.disabled		   = false;

		document.audittrail.cmbset.disabled		   = false;
		}

	}


   function onSave()
   {
    if(document.audittrail.optAud[0].checked==false && document.audittrail.optAud[1].checked==false)
	   {
		alert("Select one option for Audit Trail.")
	   	return;
		}
	document.audittrail.hidBeanMethod.value='updateTrail';
	//document.forms[0].action = "<%=ApplicationParams.getAppUrl()%>/controllerservelet"
	document.audittrail.method="post";
	document.audittrail.submit();
   }
   
   function callOrg()
	{
	if(!document.forms[0].cmdapply.disabled == true)
	{
		ShowAlert(103);
	}
	else
	{
	document.forms[0].hidBeanId.value="";
	document.forms[0].hidBeanMethod.value="";
	document.forms[0].action=path+"action/setglp.jsp"
	document.forms[0].submit();
	}
	}
   
   function menuOptionDivMouseDown (url) {
		
			if(!document.forms[0].cmdapply.disabled)
			{
				ShowAlert(103);
				return;
			}
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			document.forms[0].action=url;
			document.forms[0].submit();
					
		}

