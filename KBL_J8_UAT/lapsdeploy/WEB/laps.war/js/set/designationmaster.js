function callonLoad()
{		
	disablefields(true);
	enableButtons(false, true, true, true, false);	
	document.all.t1.style.visibility="hidden";	 
}

function callsupnam()
{
	var action=document.forms[0].hidAction.value;
	if(document.forms[0].cmdApply.disabled==true)
	{
		var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
		var url=appURL+"action/designationlist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getDesignationMasterList&strfrom=DesignationMaster";
		window.open(url,"",prop);
	}
}

function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			  document.forms[0].elements[i].value="";		  
		}
		if (document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].value="0";	
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
}

function disablefields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=(!one);
		}		
	}
}

function doSave()
{	
	if(document.forms[0].txt_datavalues.value=="")
	{  
		ShowAlert(121,"the Designation Values");
		document.forms[0].txt_datavalues.focus();
		return ;
	}
	else
	{	
		document.forms[0].cmdApply.disabled=true;
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanMethod.value="updateDesignationMasterData";
		document.forms[0].hidBeanGetMethod.value="getDesignationMasterList";
		document.forms[0].hidSourceUrl.value="/action/designationmaster.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}	
}

function callClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}

function callCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidAction.value="Cancel";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanGetMethod.value="getDesignationMasterList";
		document.forms[0].hidBeanMethod.value="getDesignationMasterList";
		document.forms[0].hidSourceUrl.value="/action/designationmaster.jsp";		
		document.forms[0].submit();
	}
}


function callNew() 
{
	ClearFields();
	document.forms[0].hidAction.value="insert";
   	enableButtons(true, true, false, false, true);
   	disablefields(false);   	
}

function callEdit() 
{
	if(document.forms[0].txt_datavalues.value=="")
	{
		ShowAlert(111,"Designation Values Sno from the list");
		document.forms[0].txt_datavalues.focus();
		return ;
	}
   	document.forms[0].hidAction.value="update"
	enableButtons(true, true, false, false, true);
	disablefields(false);
}
   
function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdNew.disabled=bool1;
	document.forms[0].cmdEdit.disabled=bool2;
	document.forms[0].cmdApply.disabled=bool3;
	document.forms[0].cmdCancel.disabled=bool4;
	document.forms[0].cmdClose.disabled=bool5;
}

function selectValues(val1,val2)
{
	document.forms[0].hidsno.value=val1;             
    document.forms[0].txt_datavalues.value=val2;
    enableButtons(true, false, true, false, false);	
}