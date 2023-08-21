function loadUsedApp()
{
	if(document.forms[0].checkApp.value=="Yes")
	{
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
		
		if(val=="existing")
		{
		ShowAlert(144);
		}
	}
}

function placeValues()
{
	for(var i=0;i<applen;i++)
	{
		document.forms[0].elements["adoc_desc"][i].value=appdocdesc[i];
		document.forms[0].elements["adoc_code"][i].value=appdoccode[i];
		document.forms[0].elements["adoc_date"][i].value=appdocdate[i];
		document.forms[0].elements["adoc_mand1"][i].value=appdocmand[i];
		if(appdocmand[i]=="Y"){
			document.forms[0].adoc_mand[i].checked=true;
		}else{
			document.forms[0].adoc_mand[i].checked=false;
		}
	}
	for(var i1=applen;i1<document.forms[0].adoc_desc.length;i1++)
	{
		document.forms[0].elements["adoc_desc"][i1].value="";
		document.forms[0].elements["adoc_code"][i1].value="";
		document.forms[0].elements["adoc_date"][i1].value="";
		document.forms[0].elements["adoc_mand1"][i1].value=="N";
	}
	for(var j=0;j<intlen;j++)
	{
		document.forms[0].elements["idoc_desc"][j].value=intdocdesc[j];
		document.forms[0].elements["idoc_code"][j].value=intdoccode[j];
		document.forms[0].elements["idoc_date"][j].value=intdocdate[j];
		document.forms[0].elements["idoc_mand1"][j].value=intdocmand[j];
		if(intdocmand[j]=="Y"){
			document.forms[0].idoc_mand[j].checked=true;
		}else{
			document.forms[0].idoc_mand[j].checked=false;
		}
	}
	for(var j1=intlen;j1<document.forms[0].idoc_desc.length;j1++)
	{
		document.forms[0].elements["idoc_desc"][j1].value="";
		document.forms[0].elements["idoc_code"][j1].value="";
		document.forms[0].elements["idoc_date"][j1].value="";
		document.forms[0].elements["idoc_mand"][j1].value="N";
	}	
	document.forms[0].cmdedit.disabled=false;
	document.forms[0].cmdclose.disabled=false;
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].cmdcancel.disabled=true;
	document.forms[0].appdoclist.disabled=true;
	document.forms[0].intdoclist.disabled=true;	
}

function disableFields(val)
{
	for(var k=0;k<document.forms[0].idoc_desc.length;k++)
	{
		document.forms[0].idoc_desc[k].disabled=val;
	
	}
	for(var k1=0;k1<document.forms[0].adoc_desc.length;k1++)
	{
		document.forms[0].adoc_desc[k1].disabled=val;	
	}
	for(var k2=0;k2<document.forms[0].idoc_mand.length;k2++)
	{
		document.forms[0].idoc_mand[k2].disabled=val;	
	}
	for(var k3=0;k3<document.forms[0].adoc_mand.length;k3++)
	{
		document.forms[0].adoc_mand[k3].disabled=val;	
	}
}

function doEdit()
{
	disableFields(false);
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmdclose.disabled=true;
	document.forms[0].cmdsave.disabled=false;
	document.forms[0].cmdcancel.disabled=false;
	document.forms[0].appdoclist.disabled=false;
	document.forms[0].intdoclist.disabled=false;
	document.forms[0].hidAction.value="update";
}

function callDocList(doctype)
{
	var prop = "scrollbars=no,width=700,height=400,top=100,left=70";
	var url=appUrl+"action/doclist.jsp?doc_type="+doctype+"&ModuleType="+ModuleType;
	window.open(url,"",prop);
}

function onInternalDoc()
{
	var len=document.forms[0].idoc_desc.length;
	var cnt=0;
	var value;
	for(i=0;i<len;i++)
	{
		value=document.forms[0].idoc_desc[i].value;		
		if(value=="")
			continue;
		cnt++;
	}
	if(cnt<2)
	{
		alert("Please Attach Atleast 2 Documents To Internal");
		return false;
	}
}

function onApplicantDoc()
{	
	var len=document.forms[0].adoc_desc.length;
	//alert(len);
	var cnt=0;
	var value;
	for(i=0;i<len;i++)
	{
		value=document.forms[0].adoc_desc[i].value;		
		if(value=="")
			continue;
		cnt++;
	}
	if(cnt<2)
	{
		alert("Please Attach Atleast 2 Documents To  Applicant");
		return false;
	}
}

function doSave()
{	

	var bool=onApplicantDoc();	
	if(bool!=false)
	var bool=onInternalDoc();
	for(var i=0;i<40;i++){
	 if(document.forms[0].adoc_mand[i].checked==true)
	 {
	 	document.forms[0].adoc_mand[i].value="Y";
	 	document.forms[0].adoc_mand1[i].value="Y";
	 }
	 if(document.forms[0].adoc_mand[i].checked==false)
	 {
	 	document.forms[0].adoc_mand[i].value="N";
	 	document.forms[0].adoc_mand1[i].value="N";
	 }
	 if(document.forms[0].idoc_mand[i].checked==true)
	 {
	 	document.forms[0].idoc_mand[i].value="Y";
	 	document.forms[0].idoc_mand1[i].value="Y";
	 }
	 if(document.forms[0].idoc_mand[i].checked==false)
	 {
	 	document.forms[0].idoc_mand[i].value="N";
	 	document.forms[0].idoc_mand1[i].value="N";
	 }
		}
	if(bool!=false)
	{
	
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].hidBeanId.value="setproducts";
		document.forms[0].hidBeanMethod.value="updateDocData";
		document.forms[0].hidBeanGetMethod.value="getDocData";
		document.forms[0].hidSourceUrl.value="/action/setprddoc.jsp";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}
}

/*function callOtherTab(url)
{
	if(!document.forms[0].cmdsave.disabled)
	{
		ShowAlert(103);
		return;
	}
	if(url=="setproducts.jsp" || url=="produsedby.jsp" || url=="prodinterest.jsp" || url=="prodsanclimit.jsp")
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
	if(url=="setprdintterms.jsp")
	{
		document.forms[0].hidBeanGetMethod.value="getIntTermsData";
	}	 
	document.forms[0].action=appUrl+"action/"+url;
	document.forms[0].submit();
}*/

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmdclose.disabled=false;
		placeValues();
		disableFields(true);
	}
}

 function doClose()
 {
	 if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appUrl+"action/setsearchproducts.jsp";
		 document.forms[0].submit();
	 }
 }
 
/*function menuOptionDivMouseDown (url)
{
	if(!document.forms[0].cmdsave.disabled)
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
}*/

function dohlp()     
{
  	var hlpvar = appUrl+"phlp/setup_retailprod_document.htm";
  	var title = "GlobalOption";
 	var prop = "scrollbars=yes,width=600,height=450";	
  	prop = prop + ",left=50,top=150";
  	window.open(hlpvar,title,prop);
}