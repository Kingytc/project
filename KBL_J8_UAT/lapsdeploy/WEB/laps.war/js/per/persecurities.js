function onloading()
{
	clearfields();
	disableFields(true);	
}

function clearfields()
{
	document.forms[0].hid_sno.value = "";  
    document.forms[0].txtsecname.value = "";
    document.forms[0].txtdempar.value = "";
    document.forms[0].txtstandname.value = "";
    document.forms[0].txtregfoliono.value ="";
    document.forms[0].txtfacvalue.value ="";
    document.forms[0].txtqty.value ="";
    document.forms[0].txtmetvalue.value ="";
}

function selectValues(val1, val2, val3, val4, val5, val6, val7,val8,val9)
{
	document.forms[0].hid_sno.value = val1;  
	document.forms[0].txtsecname.value = val2;
	document.forms[0].txtdempar.value = val4;
	document.forms[0].txtstandname.value = val3;
	document.forms[0].txtregfoliono.value = val5;
	document.forms[0].txtfacvalue.value = val6;
	document.forms[0].txtqty.value = val7;
	document.forms[0].txtmetvalue.value =val8;
	document.forms[0].txtTOTAL.value =val9;
	
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		disableCommandButtons(true,false,true,false,false,true);
	}
}

function doSave()
{

    if(document.forms[0].txtsecname.value=="" )
	{
		 alert("Enter name of security");
		 document.forms[0].txtsecname.focus();
		 return;
	}
	if(document.forms[0].txtdempar.value=="")
	{
		 alert("Enter Demand Particulars DP Id & Client Id ");
		 document.forms[0].txtdempar.focus();
		 return;
	}
	document.forms[0].cmdapply.disabled=true;
	document.forms[0].hidSourceUrl.value="/action/persecurities.jsp";
	document.forms[0].hidBeanId.value="persecurities";
	document.forms[0].hidBeanMethod.value="updsecData";
	document.forms[0].hidBeanGetMethod.value="selsecData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();		
}

function disableCommandButtons(cmdnew,cmdedit,cmdapply,cmdcancel,cmddel,cmdclose)
{
	document.forms[0].cmdnew.disabled =cmdnew;
	document.forms[0].cmdedit.disabled=cmdedit;
	document.forms[0].cmddel.disabled=cmddel;
	document.forms[0].cmdapply.disabled=cmdapply;
	document.forms[0].cmdcancel.disabled=cmdcancel;
	document.forms[0].cmdclose.disabled=cmdclose;	
}  

function doEdit()
{ 
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	document.forms[0].hideditflag.value="Y";
	disableCommandButtons(true,true,false,false,true,true);
}

function doNew()
{
		document.forms[0].hidAction.value ="insert";
		disableFields(false);
		document.forms[0].hideditflag.value="Y";
		disableCommandButtons(true,true,false,false,true,true);
		clearfields();	
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="persecurities";
		document.forms[0].hidBeanGetMethod.value="selsecData";
		document.forms[0].hidBeanMethod.value="selsecData";
		document.forms[0].action=appURL+"action/persecurities.jsp";
		document.forms[0].submit(); 		
	}
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=(!val);
		}	 
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].hidBeanMethod.value="updsecData";
		document.forms[0].hidBeanGetMethod.value="selsecData";
		document.forms[0].hidBeanId.value="persecurities";
		document.forms[0].hidSourceUrl.value="/action/persecurities.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();		
	 }	
}



function doClose()
{
	id=document.forms[0].hidapplicantid.value;
	appname=document.forms[0].appname.value;
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/persearch.jsp?id="+id+"&comapp_compname="+appname+"&hidPageType=EXI";
	
		document.forms[0].submit();
	}
}

function gototab(beanid,methodname,pagename)
{
	if(document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}