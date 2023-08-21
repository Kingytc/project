function onloading()
	{	
		if(rights=="r")
		{
			document.forms[0].auditedit.disabled=true;
		}
		else if(rights=="w")
		{
			document.forms[0].auditedit.disabled=false;
		}
		document.forms[0].auditapply.disabled=true;
		document.forms[0].auditcancel.disabled=true;
	}

	function onedit()
	{	
		document.forms[0].txtcuraud_text.disabled=false;
		document.forms[0].auditapply.disabled=false;
		document.forms[0].auditcancel.disabled=false;
		document.forms[0].auditedit.disabled=true;
	}

	function onapply()
	{
		document.forms[0].auditapply.disabled=true;
		document.forms[0].auditcancel.disabled=true;
		document.forms[0].auditedit.disabled=false;
		document.forms[0].action=path+"controllerservlet";
		document.forms[0].hidBeanId.value="auditorrep";
		document.forms[0].hidBeanMethod.value="updateData";
		document.forms[0].hidSourceUrl.value="/action/auditorreport.jsp";
		document.forms[0].submit();
	}

	function oncancel()
	{
		if( ConfirmMsg(102))
		{
		document.forms[0].txtcuraud_text.disabled=true
		document.forms[0].txtcuraud_text.value="";
		document.forms[0].auditapply.disabled=true;
		document.forms[0].auditcancel.disabled=true;
		document.forms[0].auditedit.disabled=false;
		}
	}

	function onclose()
	{	
		if( ConfirmMsg(100) )
		{
			//document.forms[0].action = "<%=ApplicationParams.getAppUrl()%>action/navigation.jsp";
			//document.forms[0].submit();
			window.close();
			
		}
	}