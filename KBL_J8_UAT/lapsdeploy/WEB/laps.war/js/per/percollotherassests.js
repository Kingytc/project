function callhome()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidBeanId.value="percollateral";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appURL+"action/percollateralhome.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function callcar()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidBeanId.value="percollateral";
		document.forms[0].hidBeanGetMethod.value="getCollVehicleData";
		document.forms[0].action=appURL+"action/percollateralcar.jsp?hidauto_type=C";	
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function doEdit()
{
 	disableFields(false);
	document.forms[0].hideditflag.value="Y"
	document.forms[0].hidAction.value ="update";
	enableButtons(true,true,false,false,true,true);	
}

function doNew()
{
	if(document.forms[0].selapptype.value!="")
	{
		disableFields(false);
		document.forms[0].hideditflag.value="Y"
		document.forms[0].hidAction.value ="insert";
		enableButtons(true,true,false,false,true,true);	
	}
	else
	{
		ShowAlert('111','Applicant Type');
		document.forms[0].selapptype.focus();
		return;
	}
}

function doSave()
{   
	if(trim(document.forms[0].txt_security.value)=="")
	{
		ShowAlert('121','Security Details');
		document.forms[0].txt_security.focus();
		return;
	}
	if(trim(document.forms[0].txt_particular.value)=="")
	{
		ShowAlert('121','Particulars');
		document.forms[0].txt_particular.focus();
		return;
	}
	if(trim(document.forms[0].txt_purchase.value)=="" && trim(document.forms[0].txt_purchase.value)=="0.00")
	{
		ShowAlert('121','Purchase Price (Rs.)');
		document.forms[0].txt_purchase.focus();
		return;
	}
	if(trim(document.forms[0].txt_market.value)=="" && trim(document.forms[0].txt_market.value)=="0.00")
	{
		ShowAlert('121','Market Value (Rs.)');
		document.forms[0].txt_market.focus();
		return;
	}
	
	var len = document.forms[0].selapptype.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].selapptype.options[i].selected==true)
		 {
			 document.forms[0].chobank_apptype1.value = document.forms[0].selapptype.options[i].text; 
			break;
		 }
	}
			
	enableButtons(true,true,true,true,true,true);	
	document.forms[0].hidBeanId.value="agrotherassets";
	document.forms[0].hidSourceUrl.value="action/collotherassets.jsp";
	document.forms[0].hidBeanMethod.value="updateagrassets";
	document.forms[0].hidBeanGetMethod.value="getagrassets";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agrotherassets";
		document.forms[0].hidBeanGetMethod.value="getagrassets";
		document.forms[0].action=appURL+"action/collotherassets.jsp";
		document.forms[0].submit(); 		
	}	
}

function doDelete()
{	
	var len = document.forms[0].selapptype.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].selapptype.options[i].selected==true)
		 {
			 document.forms[0].chobank_apptype1.value = document.forms[0].selapptype.options[i].text; 
			break;
		 }
	}
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";		
		document.forms[0].hidBeanMethod.value="updateagrassets";
		document.forms[0].hidBeanId.value="agrotherassets";
		document.forms[0].hidBeanGetMethod.value="getagrassets";
		document.forms[0].hidSourceUrl.value="action/collotherassets.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}
}

function onloading()
{	  
	document.forms[0].selapptype.value=varApptype;
	disableFields(true);
}

function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{	
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}

function disableFields(flag)
{	
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  	document.forms[0].elements[i].readOnly=flag;		  
		}
	}
}

function getCollData()
{
	document.forms[0].hidBeanId.value="agrotherassets";
	document.forms[0].hidBeanGetMethod.value="getagrassets";
	document.forms[0].action=appURL+"action/collotherassets.jsp";	
	document.forms[0].submit();
}

function selectValues(val1, val2, val3, val4, val5, val6,val7)
{
	document.forms[0].hidsno.value=val1;
	document.forms[0].txt_security.value=val2;
	document.forms[0].txt_particular.value=val3;
	document.forms[0].txt_purchase.value=val4;
	document.forms[0].txt_market.value=val5;
	document.forms[0].txt_valuationdate.value=val6;
	document.forms[0].txt_valuername.value=val7;
	
	if(document.forms[0].btnenable.value=="Y")
	{
		enableButtons(true,false,true,false,false,true);
	}
}

function callCalender(name)
{
	if(document.forms[0].hideditflag.value=="Y")
	{
		showCal(appURL,name);
	}
}