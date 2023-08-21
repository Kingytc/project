<%@include file="../share/directives.jsp"%>
<html>
<head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var SPOUSE_UBI="<%=Helper.correctNull((String)hshValues.get("SPOUSE_UBI"))%>";
var SPOUSE_GUARANTEE="<%=Helper.correctNull((String)hshValues.get("SPOUSE_GUARANTEE"))%>";


function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
			 
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;
		  document.forms[0].cmdclose.disabled=true;		 		 
		 
		 disableFields(false);
	}
}
function onLoading()
{
	if(SPOUSE_UBI!="")
	{
		document.forms[0].selubi.value=SPOUSE_UBI;
	}
	if(SPOUSE_GUARANTEE!="")
	{
		document.forms[0].selguarantee.value=SPOUSE_GUARANTEE;
	}
	showLoandeatil();
	showGuarantee();
	disableFields(true);
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value="insert";
	disableCommandButtons("edit");
	document.forms[0].txt_grossincome.readOnly=true;
	document.forms[0].txt_exp_deduction.readOnly=true;
	document.forms[0].txt_netincome.readOnly=true;	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agreligibility";		
		document.forms[0].hidBeanGetMethod.value="getUGCC_Eligibility";
		document.forms[0].action=appURL+"action/agr_ugcc_eligibility.jsp";	
		document.forms[0].submit();
	}	
}

function check()
{
	var annual_income=document.forms[0].txt_grossincome.value;
	var recomd_limit=document.forms[0].txt_recomdlimit.value;

	var checkvalue=annual_income*0.25;
	if(recomd_limit > checkvalue)
	{
		alert("Recommended limit cannot exceed 25% of Gross Annual Income");
		document.forms[0].txt_recomdlimit.value="";
		document.forms[0].txt_recomdlimit.focus();
	}
}


function doDelete()
{	
	if(ConfirmMsg(101))
	{	
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidSourceUrl.value="/action/agr_ugcc_eligibility.jsp";
		document.forms[0].hidBeanId.value="agreligibility";
		document.forms[0].hidBeanMethod.value="updateUGCC_Eligibility";
		document.forms[0].hidBeanGetMethod.value="getUGCC_Eligibility";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit(); 
	}
}

function check()
{
var annual_income=document.forms[0].txt_grossincome.value;
var recomd_limit=document.forms[0].txt_recomdlimit.value;

var checkvalue=annual_income*0.25;
	if(recomd_limit > checkvalue)
		{
			alert("Recommended limit cannot exceed 25% of Gross Annual Income");
			document.forms[0].txt_recomdlimit.value="";
			document.forms[0].txt_recomdlimit.focus();
		}

}

function doSave()
	{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidSourceUrl.value="/action/agr_ugcc_eligibility.jsp";
	document.forms[0].hidBeanId.value="agreligibility";
	document.forms[0].hidBeanMethod.value="updateUGCC_Eligibility";
	document.forms[0].hidBeanGetMethod.value="getUGCC_Eligibility";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
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
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}		  
		 
	}
}
function showLoandeatil()
{
	if(document.forms[0].selubi.value=="y")
	{
			document.all.t1.style.visibility="visible";
			document.all.t1.style.position="relative";
			document.all.t2.style.visibility="visible";
			document.all.t2.style.position="relative";
	}
	else if(document.forms[0].selubi.value=="n")
	{
			document.all.t1.style.visibility="hidden";
			document.all.t1.style.position="absolute";
			document.all.t2.style.visibility="hidden";
			document.all.t2.style.position="absolute";
			document.forms[0].txt_accno.value="";
			document.forms[0].txt_otherdetail.value="";
	}
	else
	{
		document.all.t1.style.visibility="hidden";
			document.all.t1.style.position="absolute";
			document.all.t2.style.visibility="hidden";
			document.all.t2.style.position="absolute";
			document.forms[0].txt_accno.value="";
			document.forms[0].txt_otherdetail.value="";
	}
}
function showGuarantee()
{
	if(document.forms[0].selguarantee.value=="y")
	{
			document.all.g1.style.visibility="visible";
			document.all.g1.style.position="relative";
			document.all.g2.style.visibility="visible";
			document.all.g2.style.position="relative";
			document.all.g3.style.visibility="visible";
			document.all.g3.style.position="relative";
	}
	else if(document.forms[0].selubi.value=="n")
	{
			document.all.g1.style.visibility="hidden";
			document.all.g1.style.position="absolute";
			document.all.g2.style.visibility="hidden";
			document.all.g2.style.position="absolute";
			document.all.g3.style.visibility="hidden";
			document.all.g3.style.position="absolute";
			document.forms[0].txt_behalf.value="";
			document.forms[0].txt_organisation.value="";
			document.forms[0].txt_amount.value="";
	}
	else
	{
			document.all.g1.style.visibility="hidden";
			document.all.g1.style.position="absolute";
			document.all.g2.style.visibility="hidden";
			document.all.g2.style.position="absolute";
			document.all.g3.style.visibility="hidden";
			document.all.g3.style.position="absolute";
			document.forms[0].txt_behalf.value="";
			document.forms[0].txt_organisation.value="";
			document.forms[0].txt_amount.value="";
	}
}
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/retailpge.jsp";	
		document.forms[0].submit();
	}
}

</script>
</head>

<body onload="onLoading()">
<form class="normal" name="ugcc" method="post">
<table class="outertable border1"  align="center" width="50%" border="0" cellspacing="0" cellpadding="3">
  <tr> 
    <td>
<table class="outertable"  align="center" width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr> 
    <td width="42%">1.&nbsp;Have you or your spouse earlier applied to UBI for a loan?</td>
    <td width="18%"> 
      <select name="selubi" onChange="showLoandeatil()" >
        <option value="y" selected>Yes</option>
        <option value="n">No</option>
      </select>
    </td>
    
   
  </tr>
  <tr id="t1"> 
    <td width="42%">(a)&nbsp;Loan A/c.No</td>
    <td width="18%"> 
      <input type="text" name="txt_accno" onKeyPress="allowIntegerHypen()" maxlength="15" value="<%=Helper.correctNull((String)hshValues.get("LOAN_ACC_NO"))%>">
    </td>
    
   
  </tr >
  <tr id="t2"> 
    <td width="42%">(b)&nbsp;Other details </td>
    <td width="18%"> 
      <input type="text" name="txt_otherdetail" maxlength="25" onKeyPress="notAllowSplChar()"  maxlength="15" onKeyPress="notAllowSplChar()" value="<%=Helper.correctNull((String)hshValues.get("OTHER_DETAILS"))%>">
    </td>
    
   
  </tr>
  <tr> 
    <td>2.&nbsp;Have you or your spouse given Personal Guarantee(s)?</td>
    <td> 
      <select name="selguarantee" onChange="showGuarantee()" value="<%=Helper.correctNull((String)hshValues.get("SPOUSE_GUARANTEE"))%>">
        <option value="y" selected>Yes</option>
        <option value="n">No</option>
      </select>
	
    </td>
    
   
  </tr>
  <tr id="g1"> 
      <td width="42%">(a)&nbsp;On behalf of </td>
    <td width="18%"> 
      <input type="text" name="txt_behalf"   maxlength="10" onKeyPress="notAllowSplChar()" value="<%=Helper.correctNull((String)hshValues.get("ONBEHALF_OF"))%>">
    </td>
    
   
  </tr>
  <tr id="g2"> 
      <td width="42%">(b)&nbsp;Name of the Organisation </td>
    <td width="18%"> 
      <input type="text" name="txt_organisation"  maxlength="15" onKeyPress="notAllowSplChar()"  value="<%=Helper.correctNull((String)hshValues.get("ORG_NAME"))%>">
    </td>
    
   
  </tr>
  <tr id="g3"> 
      <td width="42%">(c)&nbsp;Amount   &nbsp;Rs.</td>
    <td width="18%"> 
       <lapschoice:CurrencyTag name="txt_amount" maxlength="12" value='<%=Helper.correctNull((String)hshValues.get("AMOUNT"))%>'/>
    </td>
    
   
  </tr>
  <tr>
    <td width="42%">&nbsp;</td>
    <td width="18%">&nbsp;</td>
    
   
  </tr>
  <tr> 
    <td width="42%"><b>Eligibillity:</b></td>
    <td width="18%">&nbsp;</td>
    
   
  </tr>
  <tr> 
    <td width="42%">1)&nbsp;Total Gross Annual Income of the main earning member  &nbsp;Rs.</td>
    <td width="18%"> 
      <lapschoice:CurrencyTag name="txt_grossincome"  style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("perinc_yearsalary"))%>'/>
    </td>
    
   
  </tr>
  <tr> 
    <td width="42%">2)&nbsp;Total Expenses/Deductions &nbsp; Rs.</td>
    <td width="18%"> 
      <lapschoice:CurrencyTag name="txt_exp_deduction"  style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("totaldeduc"))%>'/>
    </td>
    
   
  </tr>
  <tr> 
    <td width="42%">3)&nbsp;Net Annual Income (1-2)&nbsp;Rs.</td>
    <td width="18%"> 
      <lapschoice:CurrencyTag name="txt_netincome"  style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("annual_inc"))%>'/>
    </td>
    
   
  </tr>
  <tr> 
    <td width="42%">4)&nbsp;Net Annual Income acceptable to the branch &nbsp;Rs.</td>
    <td width="18%"> 
      <lapschoice:CurrencyTag name="txt_acceptbranch"  style="text-align:right"  maxlength="12" value='<%=Helper.correctNull((String)hshValues.get("NET_INCOME_BRANCH"))%>'/>
    </td>
    
   
  </tr>
  <tr> 
    <td width="42%">5)&nbsp;Recommended Limit [Maximum 25% of (1) above]&nbsp;Rs.</td>
    <td width="18%"> 
      <lapschoice:CurrencyTag name="txt_recomdlimit"  maxlength="12" onKeyPress="allowDecimals(this)"  style="text-align:right"  value='<%=Helper.correctNull((String)hshValues.get("RECOMMENDED_LIMIT"))%>' onBlur="check()"/>
    </td>
    
   
  </tr>
  <tr> 
    <td width="42%">6)&nbsp;Rate of interest &nbsp;Rs.</td>
    <td width="18%"> 
       <lapschoice:CurrencyTag name="txt_interst" maxlength="12" style="text-align:right"  value='<%=Helper.correctNull((String)hshValues.get("RATE_OF_INTEREST"))%>'/>
    </td>
    
   
  </tr>
  <tr> 
    <td width="42%">7)&nbsp;Security documents to be obtained</td>
    <td width="18%"> 
      <input type="text" name="txt_security" maxlength="12" onKeyPress="notAllowSplChar()" value="<%=Helper.correctNull((String)hshValues.get("SECURITY_DOC"))%>">
    </td>
    
   
  </tr>
</table></td></tr></table><br>
<lapschoice:combuttonnew  btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<br>
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("auditFlag"))%>">
<lapschoice:agrihiddentag pageid='<%=PageId%>'/>

</form>
</body>
</html>
