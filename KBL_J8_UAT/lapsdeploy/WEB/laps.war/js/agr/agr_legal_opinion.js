function callLoading()
{
	ClearFields();
	disableFields(true);
}
	

function ClearFields()
	{
	document.forms[0].TxtEntryDt.value="";
	document.forms[0].TxtSearchDt.value="";
	document.forms[0].TxtPast.value="";
	document.forms[0].TxtsentDt.value="";
	document.forms[0].TxtRecdDt.value="";
	document.forms[0].TxtRefNo.value="";
	document.forms[0].TxtRefDt.value="";
	document.forms[0].TxtLawDet.value="";
	document.forms[0].LegOpFl.value='Y';
	document.forms[0].MortFl.value='Y';	
	document.forms[0].TxtCond.value="";
	document.forms[0].TxtRemark.value="";
	document.forms[0].TxtDesign.value="";
	document.forms[0].hid_sno.value="";
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
		if(document.forms[0].elements[i].type=="textarea")
			{
			document.forms[0].elements[i].readOnly=val;		  
			}		
		if(document.forms[0].elements[i].type=='radio')
			{
			document.forms[0].elements[i].disabled=!val;
			}
		}
	document.forms[0].TxtLawDet.readOnly=true;
	document.forms[0].TxtDesign.readOnly=true;
	}
	

function enableButtons(add,edit,apply,cancel,del,close)
	{
	document.forms[0].cmdnew.disabled=add;
	document.forms[0].cmdedit.disabled=edit;
	document.forms[0].cmdsave.disabled=apply;
	document.forms[0].cmdcancel.disabled=cancel;
	document.forms[0].cmddelete.disabled=del;
	document.forms[0].cmdclose.disabled=close;
	}
	
function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled!=true)
	{
		showCal(appURL,fname);
	}
}

function doEdit()
{
	document.forms[0].hidAction.value="update";
	disableFields(false);
	selLawyerNme();
	enableButtons(true,true,false,false,false,true);
}

function callsupnam()
{
	var action=document.forms[0].hidAction.value;
	if(document.forms[0].cmdsave.disabled==false)
	{
		var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
		var url=appURL+"action/lawyermasterlist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getLawyerMasterList&hidAction=search&strfrom=LegalOpinion";
		window.open(url,"",prop);
	}
	
}

function doCancel()
{		
	var varconfirm=ConfirmMsg('102');	
	if(varconfirm)
	{
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getDatalegal";
		document.forms[0].hidBeanId.value="perpropertydetails";
		document.forms[0].action=appURL+"action/agr_legal_opinion.jsp";	
		document.forms[0].submit();
	}
}

function doNew()
{
	document.forms[0].hidAction.value="insert";
	disableFields(false);
	enableButtons(true,true,false,false,true,true);	
}


function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="perpropertydetails";
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanMethod.value="legalupdateData";
		document.forms[0].hidBeanGetMethod.value="getDatalegal";
		document.forms[0].hidSourceUrl.value="/action/agr_legal_opinion.jsp";
		document.forms[0].submit();
	}		
}

function doSave()
{
	if(document.forms[0].TxtsentDt.value=="")
	{
		alert("Enter Date Sent");
		document.forms[0].TxtsentDt.focus();
		return;
	}
	if(document.forms[0].TxtLawDet.value=="")
	{
		alert("Select the Lawyer Name");
		document.forms[0].TxtLawDet.focus();
		return;
	}
	document.forms[0].cmdsave.disabled=true;
	if (document.forms[0].hidAction.value=="insert")
	{
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="perpropertydetails";
		document.forms[0].hidAction.value="insert";
		document.forms[0].hidBeanMethod.value="legalupdateData";
		document.forms[0].hidBeanGetMethod.value="getDatalegal";
		document.forms[0].hidSourceUrl.value="/action/agr_legal_opinion.jsp";
		document.forms[0].submit();
	}	
	if (document.forms[0].hidAction.value=="update")
	{
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="perpropertydetails";
		document.forms[0].hidAction.value="update";
		document.forms[0].hidBeanMethod.value="legalupdateData";
		document.forms[0].hidBeanGetMethod.value="getDatalegal";
		document.forms[0].hidSourceUrl.value="/action/agr_legal_opinion.jsp";
		document.forms[0].submit();
	}			
}

function gototab(beanid,methodname,pagename)
{
	if(document.forms[0].hideditflag.value.toUpperCase()=="N")
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

function selApplicant(val1, val2, val3, val4, val5, val6, val7, val8, val9, val10, val11, val12, val13, val14, val15,val16,val17)
{
	document.forms[0].hidsno.value=val2;
	document.forms[0].TxtEntryDt.value=val3;
	document.forms[0].TxtRefNo.value=val4;
	document.forms[0].TxtRefDt.value=val5;
	document.forms[0].TxtLawDet.value=val16;
	document.forms[0].LegOpFl.value=val6;
	document.forms[0].MortFl.value=val7;	
	document.forms[0].TxtCond.value=val8;
	document.forms[0].TxtRemark.value=val9;
	document.forms[0].TxtDesign.value=val17;
	document.forms[0].hid_sno.value=val10;
	document.forms[0].TxtsentDt.value=val11;
	document.forms[0].TxtRecdDt.value=val12;
	document.forms[0].sel_branchpanel.value=val13;
	document.forms[0].TxtSearchDt.value=val14;
	document.forms[0].TxtPast.value=val15;
	
	if(document.forms[0].btnenable.value=="Y")	 
	{
	 	enableButtons(true,false,true,false,true,false);
	}
	
		
	if(document.forms[0].sel_branchpanel.value=="Y")
	{	
	//	document.all.b1.style.visibility="visible";			
	}
	else if(document.forms[0].sel_branchpanel.value=="N")
	{
	//	document.all.b1.style.visibility="hidden";		
	}
}


