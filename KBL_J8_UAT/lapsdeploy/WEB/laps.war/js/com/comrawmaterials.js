function placeValues()
{
	disableFields(true);
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
		  document.forms[0].elements[i].readOnly=val;		  
		}
		else if (document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;	
		}
	}
}

function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,true);
}

function  validate()
{ 
	if(trimtxt(document.forms[0].rawmaterial[0].value) == "" )
	{
		ShowAlert('121',"List of Raw materials and Stores required");
		document.forms[0].rawmaterial[0].focus();
		return false;
	}
	for (m=0;m<8;m++)
	{
		if(document.forms[0].rawmaterial[m].value != "" )
		{
			if(document.forms[0].from[m].value=="S")
			{
				ShowAlert('111',"Imported/Indigenous ");
				document.forms[0].from[m].focus();
				return false;
			}
			if(document.forms[0].unit[m].value=="S")
			{
				ShowAlert('121',"Units");
				document.forms[0].unit[m].focus();
				return false;
			}
		}
		else
		{
			if(document.forms[0].from[m].value!="S")
			{
				ShowAlert('121',"List of Raw materials and Stores required ");
				document.forms[0].rawmaterial[m].focus();
				return false;
			}
			if(document.forms[0].unit[m].value!="S")
			{
				ShowAlert('121',"List of Raw materials and Stores required ");
				document.forms[0].rawmaterial[m].focus();
				return false;
			}
			if(document.forms[0].totalquantity[m].value!="")
			{
				ShowAlert('121',"List of Raw materials and Stores required ");
				document.forms[0].rawmaterial[m].focus();
				return false;
			}
			if(document.forms[0].costperunit[m].value!="" && document.forms[0].costperunit[m].value!="0.00")
			{
				ShowAlert('121',"List of Raw materials and Stores required ");
				document.forms[0].rawmaterial[m].focus();
				return false;
			}
			if(document.forms[0].purity[m].value!="" && document.forms[0].purity[m].value!="0.00")
			{
				ShowAlert('121',"List of Raw materials and Stores required ");
				document.forms[0].rawmaterial[m].focus();
				return false;
			}
			if(document.forms[0].percost[m].value!="" && document.forms[0].percost[m].value!="0.00")
			{
				ShowAlert('121',"List of Raw materials and Stores required ");
				document.forms[0].rawmaterial[m].focus();
				return false;
			}
			if(document.forms[0].perrawcost[m].value!="" && document.forms[0].perrawcost[m].value!="0.00")
			{
				ShowAlert('121',"List of Raw materials and Stores required ");
				document.forms[0].rawmaterial[m].focus();
				return false;
			}	
			if(document.forms[0].location[m].value!="")
			{
				ShowAlert('121',"List of Raw materials and Stores required ");
				document.forms[0].rawmaterial[m].focus();
				return false;
			}
		}
	}
	return true;
}

function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{
			document.forms[0].hidAction.value="delete"
			document.forms[0].hidBeanId.value="combanking"
			document.forms[0].hidBeanMethod.value="updateRaw";
			document.forms[0].hidBeanGetMethod.value="getRawData";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/comrawmaterials.jsp";
			document.forms[0].submit();
		}
	}
	else
	{
	 	ShowAlert(158);
	}
}

function doSave()
{
	var flag=validate();
	
	if(flag )
	{
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidRecordflag.value=varRecordFlag;
		document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanMethod.value="updateRaw";
		document.forms[0].hidBeanGetMethod.value="getRawData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comrawmaterials.jsp";
		document.forms[0].submit();
	}
}

function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanGetMethod.value="getRawData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comrawmaterials.jsp";
		document.forms[0].submit();
	 }
}

function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appURL+"action/"+"comsearch.jsp";
		document.forms[0].submit();
	}
}


function callLink(page,bean,method)
{
	if (document.forms[0].cmdsave.disabled)
	{
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

function callApplicantTab(page)
{ 
	if (document.forms[0].cmdsave.disabled)
	{
		if(page=="company")
		{ 
			document.forms[0].hidBeanGetMethod.value="getData";
			document.forms[0].action=appURL+"action/comcompany.jsp";
		}
		if(page=="proposal")
		{
			document.forms[0].hidBeanGetMethod.value="getProposal";
			document.forms[0].action=appURL+"action/comproposal.jsp";
		}
		if(page=="facilities")
		{
			document.forms[0].hidBeanMethod.value="getFacilityData";
			document.forms[0].hidBeanId.value="facilities";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/facilities.jsp";
	  	}
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}

var strvalue="corp_prodrawmat.htm";
function doHelp()     
{
	var hlpvar = appURL+"phlp/corp_prodrawmat.htm";
	var title = "Rawmaterials";
	var prop = "scrollbars=yes,width=600,height=450";	
	prop = prop + ",left=50,top=150";
	window.open(hlpvar,title,prop);
}