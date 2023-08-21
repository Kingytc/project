function doEdit()
{
	disableFields(false);
	disableCommandButtons(true,false,false,false,true,true);
}
function disableCommandButtons(valedit,valapply,valcancel,valdel,valclose,valcomments)
{
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmdclose.disabled=valclose;
	document.forms[0].cmdcomments.disabled=valcomments;
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='textarea')
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		  
		} 
	}
}
function doSave()
{
	/*
	if(document.forms[0].txt_bnk_arg.value=="0"){
	alert("Select Working Capital Banking Arrangement ");
	return;
	}
	if(document.forms[0].txt_bnk_arg_TL.value=="0")
	{
		alert("Select Term Loan Banking Arrangement ");
		return;
	}
	*/
	if(document.forms[0].txt_bnk_arg.value=="C" )
	{
		if(document.forms[0].txt_bnk_type.value=="0")
		{
		alert("Select Working Capital Consortium Type ");
		return;
		}
		else if(document.forms[0].txt_bnk_type.value=="M" && (document.forms[0].txt_no_consortium.value=="0" || trim(document.forms[0].txt_no_consortium.value)==""))
		{
			alert("Enter Working Capital No. of Banks in Consortium ");
			return;
		}
	}
	if(document.forms[0].txt_bnk_arg_TL.value=="C" )
	{
		if(document.forms[0].txt_bnk_type_TL.value=="0")
		{
		alert("Select Term Loan Consortium Type ");
		return;
		}
		else if(document.forms[0].txt_bnk_type_TL.value=="M" && (document.forms[0].txt_no_consortium_TL.value=="0" || trim(document.forms[0].txt_no_consortium_TL.value)==""))
		{ 
			alert("Enter Term Loan  No. of Banks in Consortium ");
			return;
		}
	}
	if(document.forms[0].sel_Type.value=="O"){
		
		if((document.forms[0].txt_bnk_arg_TL.value=="S" && document.forms[0].txt_bnk_arg.value=="S") ||(document.forms[0].txt_bnk_arg_TL.value=="0" ||document.forms[0].txt_bnk_arg_TL.value=="" )&& (document.forms[0].txt_bnk_arg.value=="0" ||document.forms[0].txt_bnk_arg.value=="")){
		alert(" If banking arrangement type is selected others then in atleast one of  working capital/ term loan banking arrangement selection should be other than sole");
		return;
		}
		
		}

	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanId.value="bankapp";
	document.forms[0].hidSourceUrl.value="/action/comBankingArrgnmentNew.jsp";
	document.forms[0].hidBeanMethod.value="UpdateBankingArrangement";
	document.forms[0].hidBeanGetMethod.value="getBankingArrangement";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="bankapp";
		document.forms[0].hidBeanGetMethod.value="getBankingArrangement";
		document.forms[0].action=appURL+"action/comBankingArrgnmentNew.jsp";
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
		//document.forms[0].sel_Bank.disabled=false;
	   	document.forms[0].hidAction.value ="delete";		
		document.forms[0].hidBeanMethod.value="UpdateBankingArrangement";
		document.forms[0].hidBeanId.value="bankapp";
		document.forms[0].hidBeanGetMethod.value="getBankingArrangement";
		document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidSourceUrl.value="/action/comBankingArrgnmentNew.jsp";			
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}
function OnBankArgChanged()
{
	if(document.forms[0].txt_bnk_arg.value=="C")
	{
		document.getElementById("tbl_consortium_type").style.visibility="visible";
		document.getElementById("tbl_consortium_type").style.position="relative";
	}
	else
	{
	document.getElementById("tbl_consortium_type").style.visibility="hidden";
	document.getElementById("tbl_consortium_type").style.position="absolute";
	document.getElementById("tbl_no_consortium").style.visibility="hidden";
	document.getElementById("tbl_no_consortium").style.position="absolute";
	}
	document.forms[0].txt_bnk_type.value="0";	
	document.forms[0].txt_no_consortium.value="0";	
}
function OnBnkTypeChanged()
{
	if(document.forms[0].txt_bnk_type.value=="M")
	{
		document.getElementById("tbl_no_consortium").style.visibility="visible";
		document.getElementById("tbl_no_consortium").style.position="relative";
	}
	else
	{
	document.getElementById("tbl_no_consortium").style.visibility="hidden";
	document.getElementById("tbl_no_consortium").style.position="absolute";
	}
	document.forms[0].txt_no_consortium.value="0";	
}

function OnBankArgChangedTL()
{
	if(document.forms[0].txt_bnk_arg_TL.value=="C")
	{
		document.getElementById("tbl_tl_consortium_type").style.visibility="visible";
		document.getElementById("tbl_tl_consortium_type").style.position="relative";
	}
	else
	{

	document.getElementById("tbl_tl_consortium_type").style.visibility="hidden";
	document.getElementById("tbl_tl_consortium_type").style.position="absolute";
	document.getElementById("tbl_tl_no_consortium").style.visibility="hidden";
	document.getElementById("tbl_tl_no_consortium").style.position="absolute";

	}
	document.forms[0].txt_bnk_type_TL.value="0";	
	document.forms[0].txt_no_consortium_TL.value="0";	
}
function OnBnkTypeChangedTL()
{
	if(document.forms[0].txt_bnk_type_TL.value=="M")
	{
		document.getElementById("tbl_tl_no_consortium").style.visibility="visible";
		document.getElementById("tbl_tl_no_consortium").style.position="relative";
	}
	else
	{
	document.getElementById("tbl_tl_no_consortium").style.visibility="hidden";
	document.getElementById("tbl_tl_no_consortium").style.position="absolute";
	}
	document.forms[0].txt_no_consortium_TL.value="0";	
}