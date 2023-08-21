<%@include file="../share/directives.jsp"%>
<%
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
if(strSessionModuleType.equalsIgnoreCase(""))
{
 strSessionModuleType=Helper.correctNull((String)request.getParameter("ModuleType")).trim();
 session.setAttribute("sessionModuleType",strSessionModuleType);
}
// out.println("hshValues=========="+hshValues);
if(strCategoryType.equalsIgnoreCase(""))
	strCategoryType=Helper.correctNull((String) request.getParameter("hidcategory"));
session.setAttribute("strAppType","P");
session.setAttribute("strModifyterms", Helper.correctNull((String) hshValues.get("strModifyterms")));
session.setAttribute("strPageID_PS", Helper.correctNull((String) hshValues.get("Page_Id_PS"))); 
session.setAttribute("strappstatus",Helper.correctNull((String)request.getParameter("strappstatus")));
String strFacGroup=Helper.correctInt((String)hshValues.get("strFacGrp"));
String postSanctionFlag=Helper.correctNull((String)hshValues.get("postSanctionFlag"));
System.out.println("postSanctionFlag-->"+postSanctionFlag);
String insertedParamters=Helper.correctNull((String)hshValues.get("insertedParamters"));
System.out.println("insertedParamters-->"+insertedParamters);

Map<String,String> setupParamMap=(Map<String,String>)hshValues.get("setupParamMap");
System.out.println("setupParamMap-->"+setupParamMap);

Map<String,String> paramenableMap=(Map<String,String>)hshValues.get("paramenableMap");
System.out.println("paramenableMap-->"+paramenableMap);
if(!strFacGroup.equalsIgnoreCase("0"))
	strFacGroup="disabled=disabled";
else
	strFacGroup="";
%>

<html>
<head>
<script src="<%=ApplicationParams.getAppUrl()%>js/com/comloanhistory.js"></script>
<title>Post Sanction Parameters</title>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varId='';
var xmlHttp=null;
var varParameters="";
var varCategoryType="<%=Helper.correctNull((String) request.getParameter("hidCategoryType"))%>";
var varFlag=true;
var varFacSno="<%=Helper.correctNull((String)hshValues.get("strFacSNo"))%>";
var varMCLRMigReq="<%=Helper.correctNull((String)hshValues.get("mclrmigreq"))%>";
var varPSTerms="<%=Helper.correctNull((String)hshValues.get("strSanctionTerms"))%>";
var postSanctionFlag="<%=Helper.correctNull((String)hshValues.get("postSanctionFlag"))%>";
var insertedParamters="<%=insertedParamters%>";


function doSave()
{

	var vararrsize=0;
	try
	{
		vararrsize=eval(document.forms[0].chkFac.length);
	}
	catch(e)
	{
		vararrsize=0;
	}
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

//changes based on new setup starts
	if(postSanctionFlag == "EPA")  // existing old approved application,data should not come based on enable/disablein setup,EPA - existing process approved/undo
	{
if(document.forms[0].chkFac[23].checked==true)
	{
		document.forms[0].chkFac[5].disabled=false;
		document.forms[0].chkFac[10].disabled=false;
		document.forms[0].chkFac[12].disabled=false;
	}

}

if(postSanctionFlag == "EOP" || postSanctionFlag == "NEW") {   // existing old open/pending application,data has to come based on enable/disablein setup and also saved parameters  must come infront end,EOP - existing open pending and   new applcication created on live date or  after live date,data has to come based on enable/disablein setup,NEW - New one

		if(vararrsize > 23){
if(document.forms[0].chkFac[23].checked==true)
	{
		document.forms[0].chkFac[5].disabled=false;
		document.forms[0].chkFac[10].disabled=false;
		document.forms[0].chkFac[12].disabled=false;
	}

}

}
	document.forms[0].hidBeanId.value="bankapp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanGetMethod.value="getPostSanctionParameters";
	document.forms[0].hidBeanMethod.value="updatePostSanctionParameters";
	document.forms[0].hidSourceUrl.value="/action/postsancparameters.jsp";
	document.forms[0].submit();
}
function callFacsnoChk()
{
	var varParam="";
	var varParameters="";
	var vararrsize=0;
	try
	{
		vararrsize=eval(document.forms[0].chkFac.length);
	}
	catch(e)
	{
		vararrsize=0;
	}
	//alert(vararrsize);
	for(var j=0;j<vararrsize;j++)
	{
		
		var vartemp2="document.forms[0].chkFac"+"["+j+"]";
		if(eval(vartemp2).checked)
		{
			varParam1=eval(vartemp2).value;
			varParameters=varParameters+varParam1+"@";
		}
	}
	// changes based on new setup starts
	if(postSanctionFlag == "EPA")  // existing old approved application,data should not come based on enable/disablein setup,EPA - existing process approved/undo
	{
	if(document.forms[0].chkFac[23].checked==true)
	{
		document.forms[0].chkFac[5].checked=true;
		document.forms[0].chkFac[5].disabled=true;
		
		document.forms[0].chkFac[10].checked=true;
		document.forms[0].chkFac[10].disabled=true;
				
		document.forms[0].chkFac[12].checked=true;
		document.forms[0].chkFac[12].disabled=true;
				
	}
	}

	if(postSanctionFlag == "EOP" || postSanctionFlag == "NEW") {   // existing old open/pending application,data has to come based on enable/disablein setup and also saved parameters  must come infront end,EOP - existing open pending and   new applcication created on live date or  after live date,data has to come based on enable/disablein setup,NEW - New one

		if(vararrsize > 23){
			if(document.forms[0].chkFac[23].checked==true)
			{
				document.forms[0].chkFac[5].checked=true;
				document.forms[0].chkFac[5].disabled=true;
				
				document.forms[0].chkFac[10].checked=true;
				document.forms[0].chkFac[10].disabled=true;
						
				document.forms[0].chkFac[12].checked=true;
				document.forms[0].chkFac[12].disabled=true;
						
			}

			}
	}
// ends
	
	if((document.forms[0].chkFac[0].checked==true||document.forms[0].chkFac[1].checked==true) && document.forms[0].chkFac[5].checked==false)
	{
		alert("Loan Amount changes will cause MIS Calculation also,\n Kindly select 'Change in MIS details including RBI industry codes' Parameter also");
		return false;
	}
	if(parseInt(vararrsize)>0)
	{
		if(varParameters=="")
		{
			alert("Please Select Any one Parameter");
			return false;
		}
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
	document.forms[0].action=appURL+"action/postsancparameters.jsp";
	document.forms[0].submit();
}
function callonLoad()
{
	if(insertedParamters!="" && varFacSno!="0"){
    alert("Paramters "+insertedParamters+"  marked as disabled in setup.Kindly delete the facilitiy and Proceed");
		}
	if(varFacSno!="")
	{
		document.forms[0].sel_facilitysno.value=varFacSno;
	}
	else
	{
		document.forms[0].sel_facilitysno.value="0";
	}
	// changes based on new setup starts
	if(postSanctionFlag == "EPA")  // existing old approved application,data should not come based on enable/disablein setup,EPA - existing process approved/undo
	{
		if(varPSTerms!="")
		{
			var varPSterms1 = varPSTerms.split("@");
			if(varMCLRMigReq != "Y")
			{
				document.forms[0].chkFac[17].disabled=false;
			}
			else
			{
				document.forms[0].chkFac[17].disabled=false;
			}
			for(var i=0;i<varPSterms1.length;i++)
			{
				if(varPSterms1[i] == "DLA")
				{
					document.forms[0].chkFac[0].checked=true;
					document.forms[0].chkFac[0].disabled=true;
				}
				else if(varPSterms1[i] == "INLIM")
				{
					document.forms[0].chkFac[1].checked=true;
					document.forms[0].chkFac[1].disabled=true;
				}
				else if(varPSterms1[i] == "DLP")
				{
					document.forms[0].chkFac[2].checked=true;
					document.forms[0].chkFac[2].disabled=true;
				}
				else if(varPSterms1[i] == "MRI")		
				{
					document.forms[0].chkFac[3].checked=true;
					document.forms[0].chkFac[3].disabled=true;
				}
				else if(varPSterms1[i] == "MRS")	
				{
					document.forms[0].chkFac[4].checked=true;
					document.forms[0].chkFac[4].disabled=true;
				}
				else if(varPSterms1[i] == "MIS")
				{
					document.forms[0].chkFac[5].checked=true;
					document.forms[0].chkFac[5].disabled=true;
				}
				else if(varPSterms1[i] == "LAD")
				{
					document.forms[0].chkFac[6].checked=true;
					document.forms[0].chkFac[6].disabled=true;
				}
				else if(varPSterms1[i] == "SUBLIMIT")
				{
					document.forms[0].chkFac[7].checked=true;
					document.forms[0].chkFac[7].disabled=true;
				}
				else if(varPSterms1[i] == "DATEEX")
				{
					document.forms[0].chkFac[8].checked=true;
					document.forms[0].chkFac[8].disabled=true;
				}
				else if(varPSterms1[i] == "CHBRANCH")
				{
					document.forms[0].chkFac[9].checked=true;
					document.forms[0].chkFac[9].disabled=true;
				}
				else if(varPSterms1[i] == "SEC")
				{
					document.forms[0].chkFac[10].checked=true;
					document.forms[0].chkFac[10].disabled=true;
				}
				else if(varPSterms1[i] == "MODSEC")
				{
					document.forms[0].chkFac[11].checked=true;
					document.forms[0].chkFac[11].disabled=true;
				}
				else if(varPSterms1[i] == "GUAR")
				{
					document.forms[0].chkFac[12].checked=true;
					document.forms[0].chkFac[12].disabled=true;
				}
				else if(varPSterms1[i] == "MARGIN")
				{
					document.forms[0].chkFac[13].checked=true;
					document.forms[0].chkFac[13].disabled=true;
				}
				else if(varPSterms1[i] == "CHDCCO")
				{
					document.forms[0].chkFac[14].checked=true;
					document.forms[0].chkFac[14].disabled=true;
				}
				else if(varPSterms1[i] == "DCCO")
				{
					document.forms[0].chkFac[15].checked=true;
					document.forms[0].chkFac[15].disabled=true;
				}
				else if(varPSterms1[i] == "MISMOD")
				{
					document.forms[0].chkFac[16].checked=true;
					document.forms[0].chkFac[16].disabled=true;
				}
				else if(varPSterms1[i] == "BRTOMCLR")
				{
					document.forms[0].chkFac[17].checked=true;
					document.forms[0].chkFac[17].disabled=true;
				}
				else if(varPSterms1[i] == "MODGSS")
				{
					document.forms[0].chkFac[18].checked=true;
					document.forms[0].chkFac[18].disabled=true;
				}
				else if(varPSterms1[i] == "MODBA")
				{
					document.forms[0].chkFac[19].checked=true;
					document.forms[0].chkFac[19].disabled=true;
				}
				else if(varPSterms1[i] == "CHDPOWER")
				{
					document.forms[0].chkFac[20].checked=true;
					document.forms[0].chkFac[20].disabled=true;
				}
				else if(varPSterms1[i] == "CHSCHEMECODE")
				{
					document.forms[0].chkFac[21].checked=true;
					document.forms[0].chkFac[21].disabled=true;
				}
				else if(varPSterms1[i] == "CGTMSE")
				{
					document.forms[0].chkFac[23].checked=true;
					document.forms[0].chkFac[23].disabled=true;
				}
				else if(varPSterms1[i] == "REODWC")
				{
					document.forms[0].chkFac[22].checked=true;
					document.forms[0].chkFac[22].disabled=true;
				}
				else if(varPSterms1[i] == "MODPROCESSCHARG")
				{
					document.forms[0].chkFac[24].checked=true;
					document.forms[0].chkFac[24].disabled=true;
				}
			}
			
		}
		else
		{
			if(varFacSno!="0")
			{
				document.forms[0].chkFac[17].disabled=false;
			}
		}
	}
		if(postSanctionFlag == "EOP" || postSanctionFlag == "NEW") {   // existing old open/pending application,data has to come based on enable/disablein setup and also saved parameters  must come infront end,EOP - existing open pending and   new applcication created on live date or  after live date,data has to come based on enable/disablein setup,NEW - New one

			if(varPSTerms!="")
			{
				var varPSterms1 = varPSTerms.split("@");
				for(var i=0;i<varPSterms1.length;i++)
				{
					for(var j=0;j<document.forms[0].chkFac.length;j++){
						if(varPSterms1[i] == document.forms[0].chkFac[j].value)
						{
							document.forms[0].chkFac[j].checked=true;
							document.forms[0].chkFac[j].disabled=true;
						}
						}
				}
				
			}
		}
	// ends
	
	if((document.forms[0].btnenable.value=="Y") && (document.forms[0].sel_facilitysno.value!="0"))
	{
		document.forms[0].cmdsave.disabled=false;
	}

	if(document.forms[0].sel_facilitysno.length>1)
	{
		if(document.forms[0].sel_facilitysno.value=="0")
		{
			document.forms[0].sel_facilitysno.selectedIndex=1;
			showparameters();
		}
	}

}

function chkIntratemodify(obj)
{
	if(document.forms[0].chkFac[17].checked && document.forms[0].chkFac[3].checked)
	{
		alert("Combination of both Interest rate modification and Migration from Base rate/PLR to Other Reference Rate is not allowed for post sanction modification.");
		obj.checked=false;
	}
}
function chkduedate(obj)
{
	if(document.forms[0].chkFac[8].checked && document.forms[0].chkFac[22].checked)
	{
		alert("Both Due Date Extension and Short Review (Only for Working Capital Limits) post sanction parameters cannot be selected together.");
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


function chkIntratemodifyPostSanctioncorpagr(obj)
{
	alert("inside");
	//var TempVal = "document.forms[0].chkFac"+param;
	var TempVal = "document.forms[0].chkFac";
	if(eval(TempVal+"[2]").checked && (eval(TempVal+"[0]").checked||eval(TempVal+"[1]").checked|| eval(TempVal+"[15]").checked
			||eval(TempVal+"[3]").checked || eval(TempVal+"[4]").checked ||eval(TempVal+"[5]").checked || eval(TempVal+"[6]").checked
			|| eval(TempVal+"[9]").checked || eval(TempVal+"[8]").checked || eval(TempVal+"[10]").checked
			||eval(TempVal+"[11]").checked || eval(TempVal+"[12]").checked ||eval(TempVal+"[13]").checked || eval(TempVal+"[14]").checked
			||eval(TempVal+"[7]").checked || eval(TempVal+"[16]").checked || eval(TempVal+"[17]").checked || eval(TempVal+"[18]").checked
			||eval(TempVal+"[19]").checked ||eval(TempVal+"[20]").checked ||eval(TempVal+"[21]").checked ||eval(TempVal+"[22]").checked
			||eval(TempVal+"[23]").checked))
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
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="15" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
 
 <table width="100%" border="0" cellspacing="1" cellpadding="0"   class="outertable" >
 	<tr>
	<td align="center">
	<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
			<tr class="dataGrid">
			    <td width="30%" align="center">Facility<span class="mantatory">*</span></td>
				<td width="70%" align="left">
					<select name="sel_facilitysno" tabindex="1" onchange="showparameters();">
					<option value="0" selected="selected">--Select--</option>
	                <lapschoice:ComMisDetailsTag apptype='<%=Helper.correctNull((String)request.getParameter("appno")) %>'  page='PS'/>
					</select>
				</td>				
			</tr>
	</table>
	</td>
</tr>
</table>
 
<table width="100%"  border="0" cellspacing="0" cellpadding="0" >
<tr> 
	<td valign="middle"> 
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
		<%if(postSanctionFlag.equalsIgnoreCase("EPA"))   // existing old approved application,data should not come based on enable/disablein setup,EPA - existing process approved/undo
	{
	if(!Helper.correctNull((String)hshValues.get("strFacSNo")).equalsIgnoreCase("0"))
	{%>

		<tr>
			<td valign="middle"> 
		 	 
					<table width="100%" border="0" cellspacing="1" cellpadding="1">
						<tr class="dataheader">
							<td colspan="8">POSTSANCTION PARAMETERS&nbsp;
							<input type="hidden"  name="hidSno" value="<%=Helper.correctNull((String)hshValues.get("strFacSNo"))%>"></td>
						</tr>
						<tr class="datagrid">
							
							<td align="center" width="3%" nowrap='nowrap'><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk()" value="DLA"> </td>
							<td width="22%" colspan="3">Decrease of Limit amount</td>
							
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk()" value="INLIM"> </td>
							<td colspan='3'>Increase in Limit of the sub limit
							
							</td>
						</tr>
						
						<tr class="datagrid">
							<td align="center" width="3%" nowrap='nowrap'><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk()" value="DLP"> </td>
							<td width="22%" colspan="3"> Decrease of loan period</td>
							
							<td align="center" width="3%" nowrap='nowrap'><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodify(this);" value="MRI"> </td>
							<td width="22%" colspan="3">Modification in Rate of Interest</td>
						
						</tr>
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk()" value="MRS"> </td>
							<td colspan='3'>
							Modifications to Repayment Schedule without restructuring (Non-EMI Accounts)</td>
						
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk()" value="MIS"> </td>
							<td colspan='3'>
							Change in MIS details including RBI industry codes</td>
							
						</tr>
											

						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk()" value="LAD" <%=strFacGroup %>> </td>
							<td colspan='3'>
						Sanctioning LAD / Protested Bills as sub limits of LC/BG/Buyer's Credit</td>
						<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk()" value="SUBLIMIT" <%=strFacGroup %>> </td>
							<td colspan='3'>
						Sanction of sub-limit for the existing/already sanctioned main limit</td>
						</tr>
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="chkduedate(this);callFacsnoChk();" value="DATEEX"> </td>
							<td colspan='3'>
						Due Date Extension (Only for Working Capital Limits)</td>
						
						<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk()" value="CHBRANCH"> </td>
							<td colspan='3'>Change of facility availing branch
							
							</td>

						</tr>
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk()" value="SEC"> </td>
							<td colspan='3'>
						Addition/Substitution/Release of security</td>
						<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk()" value="MODSEC" <%=strFacGroup %>> </td>
							<td colspan='3'>Modification of security type (Prime /Collateral) and value
							
							</td>
						</tr>

															
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk()" value="GUAR" <%=strFacGroup %>> </td>
							<td  colspan="3">Addition/Deletion of Guarantor</td>
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk()" value="MARGIN"> </td>
							<td colspan='3'>Modification to margin (for stock/book debts/cash margin and other margins)</td>
						
						</tr>
						
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk()" value="CHDCCO"> </td>
							<td colspan='3'>
							Change in DCCO without restructuring </td>
							
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk()" value="DCCO"> </td>
							<td colspan='3'>Capturing Actual Date of Commencement of commercial operation for the first time
							
							</td>
						</tr>
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk()" value="MISMOD"> </td>
							<td colspan='3'>Miscellaneous changes / Modifications</td>
							
							<td align="center"><input disabled="disabled" type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodify(this)" value="BRTOMCLR"> </td>
							<td colspan='3'>Migration from Base rate/PLR to Other Reference Rate</td>
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk()" value="MODGSS"> </td>
							<td colspan='3'>Modification in Govt. Sponser scheme</td>
							
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();" value="MODBA"> </td>
							<td colspan='3'>Modification in Banking Arrangement Type</td>
						</tr>
						<%String strTemp="";
						if(Helper.correctNull((String)hshValues.get("strCHDPOWER")).equalsIgnoreCase("Y"))
							strTemp="disabled";
						%>
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk()" value="CHDPOWER" <%=strTemp %>> </td>
							<td colspan='3'>Modification in Drawing Power Indicator</td>
							<%
							strTemp="";
							if(!Helper.correctNull((String)hshValues.get("strCHSCHEME")).equalsIgnoreCase("Y"))
								strTemp="disabled";
							%>
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk()" value="CHSCHEMECODE" <%=strTemp %>> </td>
							<td  colspan="3">Modifications in GL Sub head code and scheme code in CBS details</td>
						</tr>
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="chkduedate(this);callFacsnoChk();" value="REODWC"> </td>
							<td colspan='3'>Short Review (Only for Working Capital Limits)</td>
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk()" value="CGTMSE"> </td>
							<td colspan='3'>Modification of CGTMSE</td>
						</tr>
						<tr class="datagrid">
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk()" value="MODPROCESSCHARG"> </td>
							<td colspan='3'> Modification in Processing Charges</td>
						</tr>
					</table>
             </td>
            </tr>
      <% }%>
      <% }else if(postSanctionFlag.equalsIgnoreCase("EOP") || postSanctionFlag.equalsIgnoreCase("NEW")) {  //  existing old open/pending application,data has to come based on enable/disablein setup and also saved parameters  must come infront end,EOP - exiting open pending and  new application created on live date or  after live date,data has to come based on enable/disablein setup,NEW - New one
if(!Helper.correctNull((String)hshValues.get("strFacSNo")).equalsIgnoreCase("0"))
	{%>

		<tr>
			<td valign="middle"> 
		 	 
					<table width="100%" border="0" cellspacing="1" cellpadding="1">
						<tr class="dataheader">
							<td colspan="8">POSTSANCTION PARAMETERS&nbsp;
							<input type="hidden"  name="hidSno" value="<%=Helper.correctNull((String)hshValues.get("strFacSNo"))%>"></td>
						</tr>
						
						
						<tr class="datagrid">
						<%
							if(paramenableMap.containsKey("DLA")){
								String flag=paramenableMap.get("DLA");
								if(flag.equalsIgnoreCase("E")){%>
							<td align="center" width="3%" nowrap='nowrap'><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanctioncorpagr(this);" value="DLA"> </td>
							<td width="22%" colspan="3">Decrease of Limit amount</td>
							<%	}%>
								<%	}%>
								
								<%
								if(paramenableMap.containsKey("INLIM")){
								String flag=paramenableMap.get("INLIM");
								if(flag.equalsIgnoreCase("E")){%>
						<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanctioncorpagr(this);" value="INLIM"> </td>
							<td colspan='3'>Increase in Limit of the sub limit</td>
							<%	}%>
								<%	}%>
						</tr>
								
								
								
							<tr class="datagrid">
						<%
							if(paramenableMap.containsKey("DLP")){
								String flag=paramenableMap.get("DLP");
								if(flag.equalsIgnoreCase("E")){%>
							<td align="center" width="3%" nowrap='nowrap'><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanctioncorpagr(this);" value="DLP"> </td>
							<td width="22%" colspan="3"> Decrease of loan period</td>
							<%	}%>
								<%	}%>
								
								<%
								if(paramenableMap.containsKey("MRI")){
								String flag=paramenableMap.get("MRI");
								if(flag.equalsIgnoreCase("E")){%>
						<td align="center" width="3%" nowrap='nowrap'><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodify(this);chkIntratemodifyPostSanctioncorpagr(this);" value="MRI"> </td>
							<td width="22%" colspan="3">Modification in Rate of Interest</td>
							<%	}%>
								<%	}%>
						</tr>	
						
						
						<tr class="datagrid">
						<%
							if(paramenableMap.containsKey("MRS")){
								String flag=paramenableMap.get("MRS");
								if(flag.equalsIgnoreCase("E")){%>
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanctioncorpagr(this);" value="MRS"> </td>
							<td colspan='3'>
							Modifications to Repayment Schedule without restructuring (Non-EMI Accounts)</td>
							<%	}%>
								<%	}%>
								
								<%
								if(paramenableMap.containsKey("MIS")){
								String flag=paramenableMap.get("MIS");
								if(flag.equalsIgnoreCase("E")){%>
						<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanctioncorpagr(this);" value="MIS"> </td>
							<td colspan='3'>
							Change in MIS details including RBI industry codes</td>
							<%	}%>
								<%	}%>
						</tr>			
							
						
						<tr class="datagrid">
						<%
							if(paramenableMap.containsKey("LAD")){
								String flag=paramenableMap.get("LAD");
								if(flag.equalsIgnoreCase("E")){%>
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanctioncorpagr(this);" value="LAD" <%=strFacGroup %>> </td>
							<td colspan='3'>
						Sanctioning LAD / Protested Bills as sub limits of LC/BG/Buyer's Credit</td>
							<%	}%>
								<%	}%>
								
								<%
								if(paramenableMap.containsKey("SUBLIMIT")){
								String flag=paramenableMap.get("SUBLIMIT");
								if(flag.equalsIgnoreCase("E")){%>
						<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanctioncorpagr(this);" value="SUBLIMIT" <%=strFacGroup %>> </td>
							<td colspan='3'>
						Sanction of sub-limit for the existing/already sanctioned main limit</td>
							<%	}%>
								<%	}%>
						</tr>					


	                  <tr class="datagrid">
						<%
							if(paramenableMap.containsKey("DATEEX")){
								String flag=paramenableMap.get("DATEEX");
								if(flag.equalsIgnoreCase("E")){%>
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="chkduedate(this);callFacsnoChk();chkIntratemodifyPostSanctioncorpagr(this);" value="DATEEX"> </td>
							<td colspan='3'>
						Due Date Extension (Only for Working Capital Limits)</td>
							<%	}%>
								<%	}%>
								
								<%
								if(paramenableMap.containsKey("CHBRANCH")){
								String flag=paramenableMap.get("CHBRANCH");
								if(flag.equalsIgnoreCase("E")){%>
						<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanctioncorpagr(this);" value="CHBRANCH"> </td>
							<td colspan='3'>Change of facility availing branch
							</td>
							<%	}%>
								<%	}%>
						</tr>
						
						
						<tr class="datagrid">
						<%
							if(paramenableMap.containsKey("SEC")){
								String flag=paramenableMap.get("SEC");
								if(flag.equalsIgnoreCase("E")){%>
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanctioncorpagr(this);" value="SEC"> </td>
							<td colspan='3'>
						Addition/Substitution/Release of security</td>
							<%	}%>
								<%	}%>
								
								<%
								if(paramenableMap.containsKey("MODSEC")){
								String flag=paramenableMap.get("MODSEC");
								if(flag.equalsIgnoreCase("E")){%>
						<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanctioncorpagr(this);" value="MODSEC" <%=strFacGroup %>> </td>
							<td colspan='3'>Modification of security type (Prime /Collateral) and value
							
							</td>
							<%	}%>
								<%	}%>
						</tr>
						
						
                        <tr class="datagrid">
						<%
							if(paramenableMap.containsKey("GUAR")){
								String flag=paramenableMap.get("GUAR");
								if(flag.equalsIgnoreCase("E")){%>
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanctioncorpagr(this);" value="GUAR" <%=strFacGroup %>> </td>
							<td  colspan="3">Addition/Deletion of Guarantor</td>
							<%	}%>
								<%	}%>
								
								<%
								if(paramenableMap.containsKey("MARGIN")){
								String flag=paramenableMap.get("MARGIN");
								if(flag.equalsIgnoreCase("E")){%>
						<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanctioncorpagr(this);" value="MARGIN"> </td>
							<td colspan='3'>Modification to margin (for stock/book debts/cash margin and other margins)</td>
							<%	}%>
								<%	}%>
						</tr>
						
						
						<tr class="datagrid">
						<%
							if(paramenableMap.containsKey("CHDCCO")){
								String flag=paramenableMap.get("CHDCCO");
								if(flag.equalsIgnoreCase("E")){%>
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanctioncorpagr(this);" value="CHDCCO"> </td>
							<td colspan='3'>
							Change in DCCO without restructuring </td>
							<%	}%>
								<%	}%>
								
								<%
								if(paramenableMap.containsKey("DCCO")){
								String flag=paramenableMap.get("DCCO");
								if(flag.equalsIgnoreCase("E")){%>
						<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanctioncorpagr(this);" value="DCCO"> </td>
							<td colspan='3'>Capturing Actual Date of Commencement of commercial operation for the first time
							</td>
							<%	}%>
								<%	}%>
						</tr>
						
						
						<tr class="datagrid">
						<%
							if(paramenableMap.containsKey("MISMOD")){
								String flag=paramenableMap.get("MISMOD");
								if(flag.equalsIgnoreCase("E")){%>
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanctioncorpagr(this);" value="MISMOD"> </td>
							<td colspan='3'>Miscellaneous changes / Modifications</td>
							<%	}%>
								<%	}%>
								
								
							<%
							if(paramenableMap.containsKey("BRTOMCLR")){
								String flag=paramenableMap.get("BRTOMCLR");
								System.out.println("google is here");
								if(flag.equalsIgnoreCase("E")){%>
							<td align="center"><input disabled="disabled" type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodify(this);chkIntratemodifyPostSanctioncorpagr(this);" value="BRTOMCLR"> </td>
							<td colspan='3'>Migration from Base rate/PLR to Other Reference Rate</td>
							<%	}%>
								<%	}%>
								
							
						</tr>
						
						
						
						
						
						<tr class="datagrid">
						<%
							if(paramenableMap.containsKey("MODGSS")){
								String flag=paramenableMap.get("MODGSS");
								if(flag.equalsIgnoreCase("E")){%>
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanctioncorpagr(this);" value="MODGSS"> </td>
							<td colspan='3'>Modification in Govt. Sponser scheme</td>
							<%	}%>
								<%	}%>
								
								<%
								if(paramenableMap.containsKey("MODBA")){
								String flag=paramenableMap.get("MODBA");
								if(flag.equalsIgnoreCase("E")){%>
						<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanctioncorpagr(this);" value="MODBA"> </td>
							<td colspan='3'>Modification in Banking Arrangement Type</td>
							<%	}%>
								<%	}%>
						</tr>
															
						<%String strTemp="";
						if(Helper.correctNull((String)hshValues.get("strCHDPOWER")).equalsIgnoreCase("Y"))
							strTemp="disabled";
						%>
						<tr class="datagrid">
						<%
							if(paramenableMap.containsKey("CHDPOWER")){
								String flag=paramenableMap.get("CHDPOWER");
								if(flag.equalsIgnoreCase("E")){%>
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanctioncorpagr(this);" value="CHDPOWER" <%=strTemp %>> </td>
							<td colspan='3'>Modification in Drawing Power Indicator</td>
							<%
							strTemp="";
							if(!Helper.correctNull((String)hshValues.get("strCHSCHEME")).equalsIgnoreCase("Y"))
								strTemp="disabled";
							%>
							<%	}%>
								<%	}%>
								
								<%
								if(paramenableMap.containsKey("CHSCHEMECODE")){
								String flag=paramenableMap.get("CHSCHEMECODE");
								if(flag.equalsIgnoreCase("E")){%>
						<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanctioncorpagr(this);" value="CHSCHEMECODE" <%=strTemp %>> </td>
							<td  colspan="3">Modifications in GL Sub head code and scheme code in CBS details</td>
							<%	}%>
								<%	}%>
						</tr>
						
						<tr class="datagrid">
						<%
							if(paramenableMap.containsKey("REODWC")){
								String flag=paramenableMap.get("REODWC");
								if(flag.equalsIgnoreCase("E")){%>
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="chkduedate(this);callFacsnoChk();chkIntratemodifyPostSanctioncorpagr(this);" value="REODWC"> </td>
							<td colspan='3'>Short Review (Only for Working Capital Limits)</td>
							<%	}%>
								<%	}%>
								
								<%
								if(paramenableMap.containsKey("CGTMSE")){
								String flag=paramenableMap.get("CGTMSE");
								if(flag.equalsIgnoreCase("E")){%>
						<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanctioncorpagr(this);" value="CGTMSE"> </td>
							<td colspan='3'>Modification of CGTMSE</td>
							<%	}%>
								<%	}%>
						</tr>
						
						<tr class="datagrid">
						<%
							if(paramenableMap.containsKey("MODPROCESSCHARG")){
								String flag=paramenableMap.get("MODPROCESSCHARG");
								if(flag.equalsIgnoreCase("E")){%>
							<td align="center"><input type="checkbox" name="chkFac" style="border-style:none" onClick="callFacsnoChk();chkIntratemodifyPostSanctioncorpagr(this);" value="MODPROCESSCHARG"> </td>
							<td colspan='3'> Modification in Processing Charges</td>
							<%	}%>
								<%	}%>
								
						</tr>
						
					</table>
             </td>
            </tr>
      <% }%>
<%}  %>
		</table>
	</td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Save' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<input type="hidden" name="hidParameters" value="<%=Helper.correctNull((String)hshValues.get("strSanctionTerms"))%>">
<input type="hidden" name="hidpending" value="<%=Helper.correctNull((String)hshValues.get("strPendingFac"))%>">
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="hidcategory" value="<%=strCategoryType%>">
</form>
</body>
</html>
