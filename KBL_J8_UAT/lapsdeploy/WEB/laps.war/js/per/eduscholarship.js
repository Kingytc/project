function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
	}
}
	
function callLink(page,bean,method)
{	
	if (document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidAction.value="";
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/perborrowersearch.jsp?hidPageType=EXI";
		document.forms[0].submit();
	}
}

function selectValues(sno)
{
	document.forms[0].hidAction.value = "edit";	
	document.forms[0].selsno.value = sno;
	document.forms[0].selyear.disbled=true;
	appno=document.forms[0].appno.value;
	if(sno!="")
	{	
		document.all.ifrm.src=appURL+"action/iframeeduscholarship.jsp?hidBeanId=eduscholar&appno="+appno+"&selsno="+sno+"&hidBeanGetMethod=getData&hidAction=edit";
	}
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		disableCommandButtons("radioselect")
	}
}

function doSave()
{
 	if(checktrim(document.forms[0].selyear.value)=="")
	{
		  ShowAlert(121,'Examination');
		  document.forms[0].selyear.focus();
		  return;
	}
	if(checktrim(document.forms[0].lodge.value)=="")
	{
		  ShowAlert(121,'Duration From');
		  document.forms[0].lodge.focus();
		  return;
	}
	if(checktrim(document.forms[0].lab.value)=="")
	{
		  ShowAlert(121,'Duration To');
		  document.forms[0].lab.focus();
		  return;
	}
	else
	{	document.forms[0].cmdsave.disabled=true;	
		document.forms[0].selyear.disabled=false;
		document.forms[0].hidBeanId.value="eduscholar";		
		document.forms[0].hidSourceUrl.value="/action/eduscholarship.jsp";
		document.forms[0].hidBeanMethod.value="updateData";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}

function disableCommandButtons(val)
{	 
	if(val=="edit")
	{		  
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=false;
		document.forms[0].cmdcancel.disabled=false;		 
		document.forms[0].cmdclose.disabled=true;	 
		disableFields(false);
	}
	if(val=="radioselect")
	{	  
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=false;
	}	  
}  

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
}

function doNew()
{
	disableFields(false);
	disableCommandButtons("edit");
	document.forms[0].selyear.value="";
	document.forms[0].selyear.disabled=false;	 
	document.forms[0].tution.value="";
	document.forms[0].exam.value="";
	document.forms[0].books.value="";
	document.forms[0].lodge.value="";
	document.forms[0].lab.value="";
	document.forms[0].selyear.focus();
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="insert";
	for(var i=0;i<document.forms[0].length;i++)
	{
	 	if(document.forms[0].elements[i].type=='radio')
	 	{
			document.forms[0].elements[i].checked=false;
	 	}	  
	}
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="eduscholar";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appURL+"action/eduscholarship.jsp";
		document.forms[0].method="post";
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
			document.forms[0].elements[i].disabled=!val;
		}	 
	}	  
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updateData";
		document.forms[0].hidBeanId.value="eduscholar";
		document.forms[0].hidSourceUrl.value="/action/eduscholarship.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();		
	}
}
	
function onloading()
{	  
	disableFields(true);
	document.forms[0].selyear.readOnly=true;
}

function checkFileDate(obj)
{
	var todate = obj.value;
	var pgdt = todate.substring(0,2);
	var pgmon = todate.substring(3,5);
	var pgyr = todate.substring(6,10);
	var TODate = pgmon+"/"+pgdt+"/"+pgyr;	
	var fromdate=  document.forms[0].lodge.value;
	var crdt = fromdate.substring(0,2);
	var crmon = fromdate.substring(3,5);
	var cryr = fromdate.substring(6,10);
	var FromDate = crmon+"/"+crdt+"/"+cryr;	
	
	if (Date.parse(TODate) < Date.parse(FromDate))
	{
		alert("From Date Should be Lesser than To Date");
		document.forms[0].lodge.value="";
		document.forms[0].lab.value="";
		return;
	}
}