<%@include file="../share/directives.jsp"%>
<%session.setAttribute("strPageID_PS", Helper.correctNull((String) hshValues.get("Page_Id_PS")));
session.setAttribute("strModifyterms", Helper.correctNull((String) hshValues.get("strModifyterms")));%>
<html>
<head>
<script src="<%=ApplicationParams.getAppUrl()%>js/com/comloanhistory.js"></script>
<title>Post Sanction Parameters</title>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varParameters="";
var varFlag=true;
var varPSTerms="<%=Helper.correctNull((String)hshValues.get("strSanctionTerms"))%>";
var varStaffPrd="<%=Helper.correctNull((String)hshValues.get("staffPrd"))%>";
var varPrdType="<%=Helper.correctNull((String)hshValues.get("PRD_TYPE"))%>";
var varMCLRMigReq="<%=Helper.correctNull((String)hshValues.get("mclrmigreq"))%>";
var varAppCnt="<%=Helper.correctNull((String)hshValues.get("strAppCount"))%>";
var varAllowedCnt="<%=Helper.correctNull((String)hshValues.get("strAppMaxCount"))%>";
function doSave()
{
	varFlag=callFacsnoChk();
	if(varFlag==false)
	{
		return;
	}
	var varpara=document.forms[0].hidParameters.value;
	if(document.forms[0].hidParameters.value=="")
	{
		alert("Please select atleast one Parameter");
		return;
	}
	if(document.forms[0].chkFac[16].checked == true)
	{
		document.forms[0].chkFac[1].disabled=false;
		document.forms[0].chkFac[6].disabled=false;
		document.forms[0].chkFac[8].disabled=false;
	}
	document.forms[0].hidBeanId.value="bankapp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanGetMethod.value="getPostSanctionParameters";
	document.forms[0].hidBeanMethod.value="updatePostSanctionParameters";
	document.forms[0].hidSourceUrl.value="/action/perpostsancparameters.jsp";
	document.forms[0].submit();
}
function callFacsnoChk()
{
	var varParam="";
	var varParameters="";
	var vararrsize=eval(document.forms[0].chkFac.length);

/*	if(varStaffPrd == "Y" && varPrdType == "pH")
	{
		if(document.forms[0].chkFac[9].checked==true)
		{
			for(var j=0;j<vararrsize-1;j++)
			{
				document.forms[0].chkFac[j].checked = false;
				document.forms[0].chkFac[j].disabled = true;
			}
		}
		else if(document.forms[0].chkFac[9].checked==false)
		{
			for(var j=0;j<vararrsize-1;j++)
			{
				document.forms[0].chkFac[j].disabled = false;
			}
		}
		
		for(var j=0;j<vararrsize-1;j++)
		{
			if(document.forms[0].chkFac[j].checked==true)
			{
				document.forms[0].chkFac[9].checked = false;
				document.forms[0].chkFac[9].disabled = true;
				break;
			}
			else
			{
				document.forms[0].chkFac[9].disabled = false;
			}
		}
	}
*/
	for(var j=0;j<vararrsize;j++)
	{
		
		var vartemp2="document.forms[0].chkFac"+"["+j+"]";
		if(eval(vartemp2).checked)
		{
			varParam1=eval(vartemp2).value;
			varParameters=varParameters+varParam1+"@";
		}
	}
if(document.forms[0].chkFac[16].checked==true)
{
	document.forms[0].chkFac[1].checked=true;
	document.forms[0].chkFac[1].disabled=true;
	
	document.forms[0].chkFac[6].checked=true;
	document.forms[0].chkFac[6].disabled=true;
			
	document.forms[0].chkFac[8].checked=true;
	document.forms[0].chkFac[8].disabled=true;
			
}
/*else if(document.forms[0].chkFac[13].checked==false)
{
	document.forms[0].chkFac[1].checked=false;
	document.forms[0].chkFac[1].disabled=false;
	
	document.forms[0].chkFac[6].checked=false;
	document.forms[0].chkFac[6].disabled=false;
			
	document.forms[0].chkFac[8].checked=false;
	document.forms[0].chkFac[8].disabled=false;
}*/
	if(document.forms[0].chkFac[4].checked==true && document.forms[0].chkFac[6].checked==false)
	{
		alert("Loan Amount changes will cause MIS Calculation also,\n Kindly select 'Change in MIS details including RBI industry codes' Parameter also");
		return false;
	}

	
	if(varParameters=="")
	{
		alert("Please Select Any one Parameter");
		return false;
	}
	document.forms[0].hidParameters.value=varParameters;
}



function doClose()
{
    	if(ConfirmMsg(100))
	 	{
			document.forms[0].action=appURL+"action/mainnav.jsp";
		 	document.forms[0].submit();
	 	}
}
function showparameters()
{
	document.forms[0].hidBeanId.value="bankapp";
	document.forms[0].hidBeanGetMethod.value="getPostSanctionParameters";
	document.forms[0].action=appURL+"action/perpostsancparameters.jsp";
	document.forms[0].submit();
}
function callonLoad()
{
	if(varPSTerms!="")
	{
		var varPSterms1 = varPSTerms.split("@");
		if(varMCLRMigReq != "Y")
		{
			document.forms[0].chkFac[9].disabled=true;
		}
		else
		{
			document.forms[0].chkFac[9].disabled=false;
		}
		for(var i=0;i<varPSterms1.length;i++)
		{
			if(varPSterms1[i] == "MRS")
			{
				document.forms[0].chkFac[0].checked=true;
				document.forms[0].chkFac[0].disabled=true;
			}
			else if(varPSterms1[i] == "SEC")
			{
				document.forms[0].chkFac[1].checked=true;
				document.forms[0].chkFac[1].disabled=true;
			}
			else if(varPSterms1[i] == "MODSEC")
			{
				document.forms[0].chkFac[2].checked=true;
				document.forms[0].chkFac[2].disabled=true;
			}
			else if(varPSterms1[i] == "CHBRANCH")		
			{
				document.forms[0].chkFac[3].checked=true;
				document.forms[0].chkFac[3].disabled=true;
			}
			else if(varPSterms1[i] == "DLA")	
			{
				document.forms[0].chkFac[4].checked=true;
				document.forms[0].chkFac[4].disabled=true;
			}
			else if(varPSterms1[i] == "DLP")
			{
				document.forms[0].chkFac[5].checked=true;
				document.forms[0].chkFac[5].disabled=true;
			}
			else if(varPSterms1[i] == "MIS")
			{
				document.forms[0].chkFac[6].checked=true;
				document.forms[0].chkFac[6].disabled=true;
			}
			else if(varPSterms1[i] == "MRI")
			{
				document.forms[0].chkFac[7].checked=true;
				document.forms[0].chkFac[7].disabled=true;
			}
			else if(varPSterms1[i] == "GUAR")
			{
				document.forms[0].chkFac[8].checked=true;
				document.forms[0].chkFac[8].disabled=true;
			}
			else if(varPSterms1[i] == "BRTOMCLR")
			{
				document.forms[0].chkFac[9].checked=true;
				document.forms[0].chkFac[9].disabled=true;
			}
			else if(varPSterms1[i] == "COEX")
			{
				document.forms[0].chkFac[10].checked=true;
				document.forms[0].chkFac[10].disabled=true;
			}
			else if(varPSterms1[i] == "MISMOD")
			{
				document.forms[0].chkFac[11].checked=true;
				document.forms[0].chkFac[11].disabled=true;
			}
			else if(varPSterms1[i] == "MODGSS")
			{
				document.forms[0].chkFac[15].checked=true;
				document.forms[0].chkFac[15].disabled=true;
			}
			else if(varPSterms1[i] == "MOEX")
			{
				document.forms[0].chkFac[12].checked=true;
				document.forms[0].chkFac[12].disabled=true;
			}
			else if(varPSterms1[i] == "CGTMSE")
			{
				document.forms[0].chkFac[16].checked=true;
				document.forms[0].chkFac[16].disabled=true;
			}
			else if(varPSterms1[i] == "CHDPOWER")
			{
				document.forms[0].chkFac[13].checked=true;
				document.forms[0].chkFac[13].disabled=true;
			}
			else if(varPSterms1[i] == "CHSCHEMECODE")
			{
				document.forms[0].chkFac[14].checked=true;
				document.forms[0].chkFac[14].disabled=true;
			}
			else if(varPSterms1[i] == "MODPROCESSCHARG")
			{
				if(varStaffPrd == "Y" && varPrdType == "pH")
				{
				document.forms[0].chkFac[19].checked=true;
				document.forms[0].chkFac[19].disabled=true;
				}else{
					document.forms[0].chkFac[17].checked=true;
					document.forms[0].chkFac[17].disabled=true;
				}
			}
			var vararrsize=eval(document.forms[0].chkFac.length);
			if(varStaffPrd == "Y" && varPrdType == "pH")
			{
				if(varPSterms1[i] == "SLILA")
				{
					document.forms[0].chkFac[17].checked=true;
					document.forms[0].chkFac[17].disabled=true;
					
					var vararrsize=eval(document.forms[0].chkFac.length);
					for(var j=0;j<vararrsize-1;j++)
					{
						document.forms[0].chkFac[j].checked = false;
						document.forms[0].chkFac[j].disabled = true;
					}
				}
				else if(varPSterms1[i] != "SLILA" && varPSterms1[i] != "")
				{
					document.forms[0].chkFac[17].checked=false;
					document.forms[0].chkFac[17].disabled=true;
				}
			}
			else
			{
				
			}
		}
	}
	else
	{
		if(varMCLRMigReq == "Y")
		{
			document.forms[0].chkFac[9].disabled=false;
		}
	}

	if(varPrdType!="pE")
	{
		document.forms[0].chkFac[10].disabled=true;
		document.forms[0].chkFac[12].disabled=true;
	}
	if((parseInt(varAppCnt)== parseInt(varAllowedCnt)))
	{
		document.forms[0].chkFac[12].disabled=true;
	}
	
	if(document.forms[0].btnenable.value=="Y")
	{
		document.forms[0].cmdsave.disabled=false;
	}
}

function chkIntratemodify(obj)
{
	if(document.forms[0].chkFac[9].checked && document.forms[0].chkFac[7].checked)
	{
		alert("Combination of both Interest rate modification and Migration from Base rate/PLR to Other Reference Rate is not allowed for post sanction modification.");
		obj.checked=false;
	}
}

function chkIntratemodifyPostSanction(obj)
{
	//alert("inside");
	if(document.forms[0].chkFac[7].checked && (document.forms[0].chkFac[0].checked||document.forms[0].chkFac[1].checked|| document.forms[0].chkFac[2].checked
			||document.forms[0].chkFac[3].checked || document.forms[0].chkFac[4].checked ||document.forms[0].chkFac[5].checked || document.forms[0].chkFac[6].checked
			|| document.forms[0].chkFac[9].checked || document.forms[0].chkFac[8].checked || document.forms[0].chkFac[10].checked
			||document.forms[0].chkFac[11].checked || document.forms[0].chkFac[12].checked || document.forms[0].chkFac[13].checked || document.forms[0].chkFac[14].checked
			||document.forms[0].chkFac[15].checked || document.forms[0].chkFac[16].checked || document.forms[0].chkFac[17].checked || document.forms[0].chkFac[18].checked
			||document.forms[0].chkFac[19].checked))
		//alert("obj===="+obj);
	{
		
		alert("Combination of both Interest rate modification and Others Parameters is not allowed for post sanction modification.");
		obj.checked=false;
	}
}
</script>
</head>

<body text="#000000"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="callonLoad();" >
<form name="mails" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="100" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
 
<table width="100%"  border="0" cellspacing="0" cellpadding="0" >
<tr> 
	<td valign="middle"> 
		<table width="100%" border="0" cellspacing="1" cellpadding="3">
						<tr class="dataheader">
							<td colspan="8">POSTSANCTION PARAMETERS&nbsp;&nbsp;<input type="hidden"  name="hidSno" value=""></td>
						</tr>
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction(this);" value="MRS"> </td>
							<td colspan='3'>
							Modifications to Repayment Schedule without restructuring</td>
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction(this);" value="SEC"> </td>
							<td colspan='3'>
						Addition/Substitution/Release of security</td>
							
						</tr>
							<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction(this);" value="MODSEC"> </td>
							<td colspan='3'>Modification of security type (Prime /Collateral) and value / Change of security owner
							
							</td>
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction(this);" value="CHBRANCH"> </td>
							<td colspan='3'>Change of facility availing branch
							
							</td>
							</tr>
							<tr class="datagrid">
						<td align="center" width="3%" nowrap='nowrap'><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction(this);" value="DLA"> </td>
							<td width="22%" colspan="3">Decrease of Limit amount</td>
							<td align="center" width="3%" nowrap='nowrap'><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction(this);" value="DLP"> </td>
							<td width="22%" colspan="3"> Decrease of loan period</td>
							
						</tr>
											
						<tr class="datagrid">
						<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction(this);" value="MIS"> </td>
							<td colspan='3'>
							Change in MIS details including RBI industry codes</td>
						<td align="center" width="3%" nowrap='nowrap'><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodify(this);chkIntratemodifyPostSanction(this);" value="MRI"> </td>
						<td width="22%" colspan="3">Modification in Rate of Interest</td>
						</tr>
						
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction(this);chkIntratemodifyPostSanction(this);" value="GUAR"> </td>
							<td  colspan="3">Addition/Deletion of Guarantor</td>
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodify(this);chkIntratemodifyPostSanction(this);" value="BRTOMCLR"> </td>
							<td  colspan="3">Migration from Base Rate/PLR to Other Reference Rate</td>
						</tr>
							
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction(this);" value="COEX"> </td>
							<td  colspan="3">Extension of Course period (Only for Education Loans)</td>
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction(this);" value="MISMOD"> </td>
							<td  colspan="3">Miscellaneous changes / Modifications</td>
						</tr>
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction(this);" value="MOEX"> </td>
							<td  colspan="7">Extension of Moratorium taking into account spells of unemployment/under-employment (Only for education loans) </td>
						</tr>
						<%String strTemp="";
						if(Helper.correctNull((String)hshValues.get("strCHDPOWER")).equalsIgnoreCase("Y"))
							strTemp="disabled";
						%>
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction(this);" value="CHDPOWER" <%=strTemp %>> </td>
							<td colspan='3'>Modification in Drawing Power Indicator</td>
						<%
						strTemp="";
						if(!Helper.correctNull((String)hshValues.get("strCHSCHEME")).equalsIgnoreCase("Y"))
							strTemp="disabled";
						%>
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction(this);" value="CHSCHEMECODE" <%=strTemp %>> </td>
							<td  colspan="3">Modifications in GL Sub head code and scheme code in CBS
							 details</td>
						</tr>
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction(this);" value="MODGSS"> </td>
							<td colspan='3'>Modification in Govt. Sponser scheme</td>
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction(this);" value="CGTMSE"> </td>
							<td  colspan="3">CGTMSE Check Parameter</td>
						</tr>
						<tr class="datagrid">
							<%if(Helper.correctNull((String)hshValues.get("staffPrd")).equalsIgnoreCase("Y") && Helper.correctNull((String)hshValues.get("PRD_TYPE")).equalsIgnoreCase("pH")){ %>
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction(this);" value="SLILA"> </td>
							<td  colspan="3">Increase in Limit of Staff Housing Loan</td>
							<%} %>
						</tr>
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanction(this);" value="MODPROCESSCHARG" <%=strTemp %>> </td>
							<td colspan='3'> Modification in Processing Charges</td>
						</tr>
							
					</table>
	</td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Save' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<input type="hidden" name="hidParameters" value="<%=Helper.correctNull((String)hshValues.get("strSanctionTerms"))%>">
<lapschoice:hiddentag pageid='<%=PageId%>' />
</form>
</body>
</html>
