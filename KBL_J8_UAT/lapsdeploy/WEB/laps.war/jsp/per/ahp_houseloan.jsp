<%@include file="../share/directives.jsp"%>

<%
	String strappno = Helper.correctNull((String) request
			.getParameter("Applicationno"));
%>
<html>

<head>
<title>AHP Housing Loan</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script type="text/javascript"><!--

var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varCustFlag="<%=Helper.correctNull((String) hshValues.get("custflag"))%>";
function doEdit()
{
	
	calldisable(false);
	document.forms[0].sel_resident_type.disabled=true;
	document.forms[0].cmdedit.disabled = true;
	document.forms[0].cmdsave.disabled = false;
	document.forms[0].cmddelete.disabled = false;
	document.forms[0].cmdcancel.disabled = false;
	
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="perpropertydetails";
		document.forms[0].hidBeanGetMethod.value="getAHPdata";
		document.forms[0].action=appURL+"action/ahp_houseloan.jsp";	
		document.forms[0].submit();
	}
}
function doDelete()
{
	if(ConfirmMsg(101))
		{	
			document.forms[0].hidBeanId.value="perpropertydetails";
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanMethod.value="updateAHPdata";
			document.forms[0].hidBeanGetMethod.value="getAHPdata";
			document.forms[0].hidSourceUrl.value="/action/ahp_houseloan.jsp";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();
		}
}

function placevalues()

{
	document.forms[0].sel_allotment_letter.value = "<%=Helper.correctNull((String) hshValues.get("AHP_ALLOTMENT_LETTER"))%>";
	document.forms[0].sel_income_certificate.value = "<%=Helper.correctNull((String) hshValues.get("AHP_INCOME_CERTIFICATE"))%>";
	document.forms[0].sel_resident_type.value = "<%=Helper.correctNull((String) hshValues.get("AHP_RESIDENT_TYPE"))%>";
	document.forms[0].txt_costloanprd.readOnly=true;
	document.forms[0].hid_restype.value = "<%=Helper.correctNull((String) hshValues.get("AHP_RESIDENT_TYPE"))%>";
	

} 

function callOnload()
{	 
	calldisable(true);
	
	
	if(varCustFlag=="N"){
		alert("Please Enter Resident Type in Communication Details tab to proceed.. ");
		
		document.forms[0].cmdedit.disabled=true;
		return;
	}
	if(varRecordFlag=="Y")
	{
		window.opener.document.forms[0].hidAHPDet.value="Y";
	}
	else
	{
		window.opener.document.forms[0].hidAHPDet.value="N";
	}
	if(document.forms[0].btnenable.value=="N")
	{
		document.forms[0].cmdedit.disabled=true;
	}		

 	
}	

function calldisable(val)
{
	for(i=0;i<document.forms[0].elements.length;i++)
	{
		
		if(document.forms[0].elements[i].type == "select-one" )
		{
			document.forms[0].elements[i].disabled = val;
		}
		if(document.forms[0].elements[i].type == "text" )
		{
			document.forms[0].elements[i].disabled = val;
		}
    }
}

function doSave()
{
   
	if(document.forms[0].sel_allotment_letter.selectedIndex==0 ||document.forms[0].sel_allotment_letter.selectedIndex==2)
	{
		alert('For affordable housing scheme value cannot be NO in Whether allotment letter obtained from Co-operative Housing Society/Housing Board/ULB/KSDB');
		document.forms[0].sel_allotment_letter.focus();
		return;
	}
	if(document.forms[0].sel_income_certificate.selectedIndex==0 || document.forms[0].sel_income_certificate.selectedIndex==2)
	{
		alert('For affordable housing scheme value cannot be NO in Whether Income Certificate from revenue authority obtained');
		document.forms[0].sel_income_certificate.focus();
		return;
	}
	if(document.forms[0].txt_bankname.value=="")
	{
		alert('Enter Bank Name');
		document.forms[0].txt_bankname.focus();
		return;
	}
	if(document.forms[0].txt_branchname.value=="")
	{
		ShowAlert('121','Branch Name');
		document.forms[0].txt_branchname.focus();
		return;
	}
	if(document.forms[0].txt_accnumber.value=="")
	{
		ShowAlert('121','Account Number');
		document.forms[0].txt_accnumber.focus();
		return;
	}
	if(document.forms[0].txt_ifsccode.value=="")
	{
		ShowAlert('121','IFSC Code');
		document.forms[0].txt_ifsccode.focus();
		return;
	}
	if(document.forms[0].txt_goi_amt.value=="")
	{
		ShowAlert('121','GOI Amount');
		document.forms[0].txt_goi_amt.focus();
		return;
	}
	if(document.forms[0].txt_gok_amt.value=="")
	{
		ShowAlert('121','GOK Amount');
		document.forms[0].txt_gok_amt.focus();
		return;
	}
	if(document.forms[0].sel_resident_type.selectedIndex==2)
	{
		alert(' Resident Type should not be OWNED for AHP,Please change in Customer Profile - communication Details tab');
		document.forms[0].sel_resident_type.focus();
		return;
	}
	if(document.forms[0].sel_resident_type.selectedIndex==0)
	{
		alert('Please Enter Resident Type in Customer Profile - communication Details tab');
		document.forms[0].sel_resident_type.focus();
		return;
	}
	
	if(document.forms[0].txt_savings.value=="")
	{
		ShowAlert('121','Initial deposit or savings from the borrower ');
		document.forms[0].txt_savings.focus();
		return;
	}

	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanId.value="perpropertydetails";
	document.forms[0].hidBeanMethod.value="updateAHPdata";
	document.forms[0].hidBeanGetMethod.value="getAHPdata";
	document.forms[0].hidSourceUrl.value="/action/ahp_houseloan.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		window.close();
	}
}
function callIfsccode()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		
			var varECSifsccode=document.forms[0].txt_ifsccode.value;
			 if(varECSifsccode.length!=11){
	
				alert("Please Enter Valid IFSC Code");
				document.forms[0].txt_ifsccode.value="";
				return;
			}
			if(varECSifsccode.length==11)
				{
					document.all.ifrmifsc.src=appURL+"action/enachifsccode.jsp?hidBeanId=DigitalAppInterface&hidBeanGetMethod=IFSCcodeCheck&ifsccode="+varECSifsccode;
				}
		
	}
}
function callBankmaster(id)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
			var varQryString = appURL+"action/ops_sanctionhelp.jsp?hidBeanGetMethod=getSearch&hidBeanId=additionalParameter&pagename=Takeover&id="+id;
			var title = "Bank_Master";
			var prop = "scrollbars=no,width=650,height=400";
			var xpos = "50";
			var ypos = "50";
			prop = prop+","+xpos+","+ypos+",left=200,top=200";
			window.open(varQryString,title,prop);
	}
}
</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onload="callOnload();placevalues();">
<form class="normal" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><lapschoice:application /></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<div align="center">
		<p class="dataheader">Affordable Housing in Partnership - Housing
		Loan</p>
		<table width="95%" border="1" cellspacing="1" cellpadding="3"
			class="outertable">



			<tr>
				<td width="56%">Whether allotment letter obtained from
				Co-operative Housing Society/Housing Board/ULB/KSDB</td>
				<td width="40%"><select name="sel_allotment_letter">
					<option value="" selected="selected">---SELECT---</option>
					<option value="Y">Yes</option>
					<option value="N">No</option>

				</select></td>
			</tr>

			<tr>
				<td width="56%">Whether Income Certificate from revenue
				authority obtained</td>
				<td width="40%" valign="top"><select
					name="sel_income_certificate" >
					<option value="" selected="selected">---SELECT---</option>
					<option value="Y">Yes</option>
					<option value="N">No</option>
				</select></td>
			</tr>
			<tr>
				<td width="56%">Bank Name of the Implementing Agency</td>
				<td width="40%"><input type="text" name="txt_bankname" onKeyPress="" maxlength="40" size="30" tabindex="1" readonly="readonly" value="<%=Helper.correctNull((String)hshValues.get("AHP_BANKNAME")) %>">
										<input type="hidden" name="hid_LeadBankcode" value="<%=Helper.correctNull((String)hshValues.get("AHP_BANKNAME_CODE")) %>" >
										<span onClick="callBankmaster('147')" style="cursor: hand">
										<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"></span>
						</td>
			</tr>

			<tr>
			<tr>

				<td width="56%">Branch Name of the Implementing Agency</td>
				<td width="40%"><input type="text" name="txt_branchname"
					
					value="<%=Helper.correctNull((String) hshValues
							.get("AHP_BRANCHNAME"))%>"
					></td>
			</tr>
			<tr>
				
				<td width="56%">Account Number of the Implementing Agency</td>
				<td width="40%"><input type="text"
					name="txt_accnumber"
					value="<%=Helper.correctNull((String) hshValues
							.get("AHP_ACCNUMBER"))%>"
					maxlength="30"></td>
			</tr>
			<tr>

				<td width="56%">IFSC CODE</td>
				<td width="40%"><input type="text" name="txt_ifsccode"
					onChange="callIfsccode()"
					value="<%=Helper.correctNull((String) hshValues
									.get("AHP_IFSCCODE"))%>"
					maxlength="11"></td>
			</tr>
			<tr>
				<td width="56%">Total Cost of the Project (Amount in Rs.)</td>
				<td width="40%"><lapschoice:CurrencyTag name="txt_costloanprd"
					size="20" maxlength="10"
					value='<%=Helper.correctNull((String) hshValues
							.get("AHP_COSTLOANPRD"))%>'
					tabindex="18" style="width:150px" /> &nbsp;</td>
			</tr>
			<tr>
				<td width="56%">GOI subsidy amount (Amount in Rs.)</td>
				<td width="40%"><lapschoice:CurrencyTag name="txt_goi_amt"
					size="20" maxlength="10"
					value='<%=Helper.correctNull((String) hshValues
							.get("AHP_GOI_AMT"))%>'
					tabindex="18" style="width:150px" /> &nbsp;</td>
			</tr>
			<tr>
				<td width="56%">GOK subsidy amount (Amount in Rs.)</td>
				<td width="40%"><lapschoice:CurrencyTag name="txt_gok_amt"
					size="20" maxlength="10"
					value='<%=Helper.correctNull((String) hshValues
							.get("AHP_GOK_AMT"))%>'
					tabindex="18" style="width:150px" /> &nbsp;</td>
			</tr>
			<tr>
												
                    <td width="56%">Present Accommodation<span class="mantatory">*&nbsp;</span></td>
												
                    <td width="40%"><select name="sel_resident_type" 
					>
					<option value="0" selected>---SELECT---</option>
					<option value="1">Rented</option>
					<option value="2">Owned</option>
					<option value="3">Leased</option>
					<option value="4">Family</option>
					<option value="5">Employer</option>
				</select></td>
				</tr>
				<tr>
				<td width="56%">Initial deposit or savings from the borrower (Amount in Rs.)</td>
				<td width="40%"><lapschoice:CurrencyTag name="txt_savings"
					size="20" maxlength="10"
					value='<%=Helper.correctNull((String) hshValues
							.get("AHP_SAVINGS"))%>'
					tabindex="18" style="width:150px" /> &nbsp;</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete'
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
<br>
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="hid_restype" value="">
</form>
</body>

</html>
