function placeValues()
{
	if(document.forms[0].cmdedit.disabled)
		  editflag=0;
	doAfterEdit();
}

function putValue(i)
{
	if(document.forms[0].chkapdoc_substatus[i].checked)
	{
		document.forms[0].apdoc_substatus[i].value="y";
	}
	else
	{
		document.forms[0].apdoc_substatus[i].value="n";
	}
}


function doEdit()
{
	document.forms[0].hideditflag.value="yes";
	document.forms[0].hidBeanGetMethod.value="getDocument";
	document.forms[0].action=appUrl+"action/appdocuments.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
function doSave()
{
	document.forms[0].app_no.value=document.forms[0].appno.value;
	document.forms[0].hidBeanGetMethod.value="getDocument";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].cmdapply.disabled=true;
	document.forms[0].submit();
}

function doAfterEdit()
{
  var editcheck="<%=request.getParameter("hideditflag")%>";
  if(editcheck=="yes")
  {
	  //if(editlockflag=="y")
	  {
		  disableCommandButtons("edit");
		  for(i=0;i<document.forms[0].apdoc_rendate.length;i++)
		  {
		  document.forms[0].apdoc_rendate[i].readOnly = false;
		  }
		  
	  }
	 /* else
	  {
		  disableFields(true);
		  disableCommandButtons("load");
		  ShowAlert(128);
	  }*/
  }
  else
  {
	  disableFields(true);
	  disableCommandButtons("load");
  }
 if(document.forms[0].cmdapply.disabled == false)
	{
		document.forms[0].cmdaudit.disabled = true;
	}
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hideditflag.value="no";
		document.forms[0].hidBeanGetMethod.value="getDocument";
		document.forms[0].action=appUrl+"action/appdocuments.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}

}

function doClose()
{
	if("<%=strPgDist%>"=="P")
	{
		document.forms[0].action=appUrl+"action/persearch.jsp";
	}else
	{
		document.forms[0].action=appUrl+"action/comsearch.jsp";
	}
	document.forms[0].method="post";
	document.forms[0].submit();
}

function disableFields(val)
{
  for(var i=0;i<document.forms[0].chkapdoc_substatus.length;i++)
  {
	document.forms[0].chkapdoc_substatus[i].disabled=val;
		  
  }
  
}

function disableCommandButtons(val)
{
	
  if(val=="load")
  {
	  if(editflag==1)
	  document.forms[0].cmdedit.disabled=false;
	  document.forms[0].cmddel.disabled=true;
	  document.forms[0].cmdapply.disabled=true;
	  document.forms[0].cmdcancel.disabled=true;
	 // document.forms[0].cmdaudit.disabled=false;
	  document.forms[0].cmdclose.disabled=false;
  }
  if(val=="edit")
  {
	 document.forms[0].cmdedit.disabled=true;
	 document.forms[0].cmddel.disabled=true;
	 document.forms[0].cmdapply.disabled=false;
//	 document.forms[0].cmdaudit.disabled=true;
	 document.forms[0].cmdcancel.disabled=false;
	 document.forms[0].cmdclose.disabled=true;
  }
  
}

function callRulePage(doccode)
{
//alert(doccode);
var url=appUrl+"action/apprules.jsp?hidBeanGetMethod=getDocumentRules&doc_code="+doccode;


	var title = "";
	var prop = "scrollbars=no,width=600,height=300";
	var xpos = 120;
	var ypos = 100;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);

}

function callScanPage(doccode,dtype,docdesc,docno)
{
	//alert(docno);
	if(document.forms[0].chkapdoc_substatus[docno].checked == true && document.forms[0].chkapdoc_substatus[docno].disabled == true)
	{
	document.forms[0].doc_code.value=doccode;
	document.forms[0].doc_desc1.value=docdesc;
	document.forms[0].doc_type.value=dtype;
	document.forms[0].hidBeanGetMethod.value="getDocumentScan";
	document.forms[0].action=appUrl+"action/appdocscan.jsp";
	document.forms[0].submit();
	}

}

function changeScanColor()
{
	for(i=0;i<document.forms[0].apdoc_substatus12.length;i++)
	{
		if(document.forms[0].apdoc_substatus12[i].value == "Yes")
		{
			document.forms[0].apdoc_substatus12[i].style.color="green";
		}
		else
		{
			document.forms[0].apdoc_substatus12[i].style.color="red";
		}
	}
	for(i=0;i<document.forms[0].apdoc_substatus1.length;i++)
	{
		if(document.forms[0].apdoc_substatus1[i].value == "Yes")
		{
			document.forms[0].apdoc_substatus1[i].style.color="green";
		}
		else
		{
			document.forms[0].apdoc_substatus1[i].style.color="red";
		}
	}
}
