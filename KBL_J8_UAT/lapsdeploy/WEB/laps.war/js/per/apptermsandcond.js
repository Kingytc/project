function callTerms()
{
	document.forms[0].hidBeanId.value="apptermscond";
	document.forms[0].hidBeanGetMethod.value="getTerms";
	document.forms[0].action=appURL+"action/apptermsandcond.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
function deleteTerms()
{
	var appno = document.forms[0].appno.value;
	var url = appURL+"action/apptermsandcondexcep_retail.jsp?appno="+appno+"&hidBeanId=apptermscond&hidBeanGetMethod=getDeletedTerms&hidAction=Retail";
	var title1 = "";
	var prop = "scrollbars=yes,width=775,height=500,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title1,prop);
}
function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="apptermscond";
		document.forms[0].hidBeanGetMethod.value="getTerms";
		document.forms[0].action=appURL+"action/apptermsandcond.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function disableButton(b1,b2,b3,b4,b5,b6)
{
	document.forms[0].cmdadd.disabled = b1;
	document.forms[0].cmdedit.disabled = b2;
	document.forms[0].cmdsave.disabled = b3;
	document.forms[0].cmdcancel.disabled = b4;
	document.forms[0].cmddelete.disabled = b5;
	document.forms[0].cmdclose.disabled = b6;
}
function doEdit()
{
	document.forms[0].hidAction.value="update";
	document.forms[0].txttrmdesc.readOnly=false;
	document.forms[0].select_termstype.disabled=true;
	var len = document.forms[0].sno.length;

	if(len != null)
	{
		for(i=0;i<len;i++)
		{
			document.forms[0].sno[i].disabled = true;
		}
	}
	else
	{
		document.forms[0].sno.disabled = true;
	}
	disableButton(true,true,false,false,true,true)
}
function doSave()
{
	if(trimtxt(document.forms[0].txttrmdesc.value)=="")
	{
		alert("Enter Terms Description");
		document.forms[0].txttrmdesc.focus();
		return false;
	}
	if(document.forms[0].select_termstype.value =="")
	{
		alert("Please Select Terms Type");
		document.forms[0].select_termstype.focus();
		return false;
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="apptermscond";
	document.forms[0].hidBeanMethod.value="updateTerms";
	document.forms[0].hidBeanGetMethod.value="getTerms";		
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/apptermsandcond.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}	
function setData()
{
	var len = document.forms[0].sno.length;
	if(len!=null)
	{
		for(i=0;i<len;i++)
		{
			if(document.forms[0].sno[i].checked == true)
			{
				document.forms[0].txttrmdesc.value = document.forms[0].hidText[i].value;
				document.forms[0].hidtermid.value = document.forms[0].sno[i].value;
				document.forms[0].hidterms.value = document.forms[0].hidtermtype[i].value;
				document.forms[0].select_termstype.value =document.forms[0].hidtermtype_select[i].value;
				//While edit and this value has to be passed to bean.(In Edit mode select_termstype should be in disable mode)
				document.forms[0].hid_select_termstype.value=document.forms[0].hidtermtype_select[i].value;
			}
		}
	}
	else
	{
		document.forms[0].txttrmdesc.value = document.forms[0].hidText.value;
		document.forms[0].hidtermid.value = document.forms[0].sno.value;
		document.forms[0].hidterms.value = document.forms[0].hidtermtype.value;
		document.forms[0].select_termstype.value =document.forms[0].hidtermtype_select.value;
		//While edit and this value has to be passed to bean.(In Edit mode select_termstype should be in disable mode)
		document.forms[0].hid_select_termstype.value=document.forms[0].hidtermtype_select.value;
	}
	document.forms[0].hidcomments.value="";
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		disableButton(true,false,true,false,false,false);
	}
	document.forms[0].select_termstype.disabled=true;
}
function disablebutton()
{
	if (document.forms[0].btnenable.value == "N")
	{
		disableButton(true,true,true,true,true,false);
		document.forms[0].cmdadd2.disabled=true;
	}
	else
	{
		disableButton(false,true,true,true,true,false);
	}
}
function doDelete()
{
	if(document.forms[0].hidtermid.value=="")
	{
		alert("Select Terms to delete");
		return false;
	}
	if(trimtxt(document.forms[0].hidcomments.value)=="")
	{
		var url = appURL+"action/deletedtermremarks.jsp";
		var title1 = "";
		var prop = "scrollbars=no,width=600,height=450,menubar=no";
		var xpos = 20;
		var ypos = 20;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(url,title1,prop);
	}
	else
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="apptermscond";
		document.forms[0].hidBeanMethod.value="updateTerms";
		document.forms[0].hidBeanGetMethod.value="getTerms";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/apptermsandcond.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function doAdd()
{
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidtermid.value="";
	document.forms[0].txttrmdesc.value="";
	document.forms[0].txttrmdesc.readOnly=false;
	document.forms[0].select_termstype.disabled=false;
	disableButton(true,true,false,false,true,true)
}