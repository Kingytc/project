function onloading()
{
	disableFields(true);
	/*if(proposalnoteCheck=="Y")
	{		document.forms[0].proposalNote.checked=true;
	}
	else
	{		document.forms[0].proposalNote.checked=false;
	}
	if(annexureCheck=="Y"){
		document.forms[0].Annexure3.checked=true;
	}
	else
	{		document.forms[0].Annexure3.checked=false;
	}
	*/
}
function doEdit()
{
	document.forms[0].hidAction.value ="update";
	disableFields(false);
	disableCommandButtons(true,true,false,false,false,true);
	callEdit();
}
function disableCommandButtons(valnew,valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdnew.disabled =valnew;
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmdclose.disabled=valclose;
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			if(document.forms[0].elements[i]!=document.forms[0].txt_bankName)
			{
			document.forms[0].elements[i].readOnly=val;
			}
		}	  
		if(document.forms[0].elements[i].type=='textarea')
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		  
		} 
		if(document.forms[0].elements[i].type=="checkbox")
		{
			document.forms[0].elements[i].disabled=val;		  
		} 
	}
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="bankapp";
		document.forms[0].hidBeanGetMethod.value="getMultipleBanking";
		document.forms[0].action=appURL+"action/com_multipleBanking.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
	   	document.forms[0].hidAction.value ="delete";		
	   	document.forms[0].hidBeanId.value="bankapp";
		document.forms[0].hidSourceUrl.value="/action/com_multipleBanking.jsp";
		document.forms[0].hidBeanMethod.value="UpdateMultipleBaking";
		document.forms[0].hidBeanGetMethod.value="getMultipleBanking";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}	
}
function doSave()
{
	callSave();
	if(document.forms[0].sel_ConsType && document.forms[0].sel_ConsType.value=="")
	{
		alert("Select the Consortium type");
		document.forms[0].sel_ConsType.focus();
		return;
	}
	if(document.forms[0].txt_bankName.value=="")
	{
		alert("Select the bank name");
		document.forms[0].txt_bankName.focus();
		return;
	}
	if(document.forms[0].txt_existFb.value=="0.00" && document.forms[0].txt_existNfb.value=="0.00" && document.forms[0].txt_PropFb.value=="0.00" && document.forms[0].txt_PropNfb.value=="0.00")
	{
		alert("Enter atleast one value");
		document.forms[0].txt_existFb.focus();
		return;
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="bankapp";
	document.forms[0].hidSourceUrl.value="/action/com_multipleBanking.jsp";
	document.forms[0].hidBeanMethod.value="UpdateMultipleBaking";
	document.forms[0].hidBeanGetMethod.value="getMultipleBanking";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doNew()
{
	disableFields(false);
	disableCommandButtons(true,true,false,false,true,true);
	document.forms[0].hidAction.value ="insert";
	FbSum=eval(document.forms[0].hidFBSum.value);
	NfbSum=eval(document.forms[0].hidNfbSum.value);
	ExistSum=eval(document.forms[0].hidExistSum.value);
	ProFbSum=eval(document.forms[0].hidProFbSum.value);
	ProNfbSum=eval(document.forms[0].hidProNfbSum.value);
	ProSum=eval(document.forms[0].hidProSum.value);
	callNew();
}
function selectValues(v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12,v13,v14)
{
	document.forms[0].hid_sno.value=v1;
	document.forms[0].txt_bankName.value=v2;
	document.forms[0].txt_existFb.value=v3;
	document.forms[0].txt_existFbExpo.value=v4;
	document.forms[0].txt_existNfb.value=v5;
	document.forms[0].txt_existNfbExpo.value=v6;
	document.forms[0].txt_existTot.value=v7;
	document.forms[0].txt_existTotExpo.value=v8;
	document.forms[0].txt_PropFb.value=v9;
	document.forms[0].txt_PropFbExpo.value=v10;
	document.forms[0].txt_PropNfb.value=v11;
	document.forms[0].txt_PropNfbExpo.value=v12;
	document.forms[0].txt_PropTot.value=v13;
	document.forms[0].txt_PropTotExpo.value=v14;
	
	FbSum=eval(document.forms[0].hidFBSum.value)-eval(document.forms[0].txt_existFb.value);
	NfbSum=eval(document.forms[0].hidNfbSum.value)-eval(document.forms[0].txt_existNfb.value);
	ExistSum=eval(document.forms[0].hidExistSum.value)-eval(document.forms[0].txt_existTot.value);
	ProFbSum=eval(document.forms[0].hidProFbSum.value)-eval(document.forms[0].txt_PropFb.value);
	ProNfbSum=eval(document.forms[0].hidProNfbSum.value)-eval(document.forms[0].txt_PropNfb.value);
	ProSum=eval(document.forms[0].hidProSum.value)-eval(document.forms[0].txt_PropTot.value);
	
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		disableCommandButtons(true,false,true,false,true,false);
	}
}
function callBankmaster(id,pos)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = appURL+"action/ops_sanctionhelp.jsp?hidBeanGetMethod=getSearch&hidBeanId=additionalParameter&pagename=Banking&id="+id+"&Position="+pos;
		var title = "Bank_Master";
		var prop = "scrollbars=no,width=650,height=400";
		var xpos = "50";
		var ypos = "50";
		prop = prop+","+xpos+","+ypos+",left=200,top=200";
		window.open(varQryString,title,prop);
	}
}