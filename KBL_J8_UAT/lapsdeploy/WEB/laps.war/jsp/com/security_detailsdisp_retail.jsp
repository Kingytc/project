<%@include file="../share/directives.jsp"%>
<%String sectype = Helper.correctNull((String) request.getParameter("hidsectype"));
String strsecID = Helper.correctNull((String) request.getParameter("hidsecid"));
	HashMap hshRecord = (HashMap) hshValues.get("hshRecord");
	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	nf.setGroupingUsed(false);
	String pageid = Helper.correctNull((String) request.getParameter("pageid"));
	String strPagefrom = Helper.correctNull((String) request.getParameter("pagefrom"));
	String strEmployment = (String) session
			.getAttribute("strEmployment");
	String strModuleName = Helper.correctNull(request
			.getParameter("hidModuleName"));
	String strModName = "";
	if (strModuleName.equalsIgnoreCase("T")) {
		strModName = "Tertiary";
	} else if (strModuleName.equalsIgnoreCase("P")) {
		strModName = "Retail";
	} else {
		strModName = "Corporate & SME";
	}
	String strAppid = Helper.correctNull((String) hshValues
			.get("strAppid"));
	String strsecurityowners = Helper.correctNull((String) hshValues.get("strJointOwnDetails"));
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	String strSecId=  Helper.correctNull((String) hshValues.get("cus_sec_id")); 
%>
<html>
<head>
<title>Securities</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript">
var appURL="<%=ApplicationParams.getAppUrl()%>";
var curdate = "<%=Helper.getCurrentDateTime()%>";
var varAppid="<%=strAppid%>";
var varSecType = "";
var securityowners = "<%=strsecurityowners%>";
var valuerCode="<%=Helper.correctNull((String) hshValues.get("CUS_SEC_VALUERCODE"))%>";
function onLoad() 
{
	document.forms[0].sel_securitytype.value = "<%=Helper.correctNull((String)hshValues.get("cus_sec_type"))%>";
	document.forms[0].sel_alreadycharged.value = "<%=Helper.correctNull((String)hshValues.get("CUS_SEC_Already_Charged"))%>";
	document.forms[0].sel_securityclassifcation.value = "<%=Helper.correctNull((String)hshValues.get("cus_sec_classification"))%>";
	document.forms[0].sel_jointholder.value = "<%=Helper.correctNull((String)hshValues.get("CUS_SEC_Joint_Holder"))%>";
	document.forms[0].sel_residual_risk.value = "<%=Helper.correctNull((String)hshValues.get("CUS_SEC_Residual_RiskFlag"))%>";
	document.forms[0].sel_natureCharge.value = "<%=Helper.correctNull((String)hshValues.get("CUS_SEC_NATUREOFCHARGE"))%>";
	var SecID=<%=strSecId %>;
	
	var varSecurityType = document.forms[0].sel_securitytype.options[document.forms[0].sel_securitytype.selectedIndex].value;
	document.all.ifrmsecurityclassification.src = appURL
			+ "action/ifrmsecurityclassification.jsp?hidBeanGetMethod=getSecurityClassification&hidBeanId=securitymaster&securityclassificationtype="
			+ varSecurityType +  "&secID=" + SecID +"&pagefrom=appl&sectype=" + "<%=Helper.correctNull((String)hshValues.get("cus_sec_classification"))%>"  ;

	disableFields(true);
	selJointHolder();
	showSpecify();
	chargedDetails();
	jointownerdelall();
	jointownerdisp(securityowners);
	showJointSecurity();
	disablefields();
	
	if(document.forms[0].sel_securitytype.value =="6")
	{
		document.all.idcompanydetails.style.display="table-row";
		document.all.idcompanydetails1.style.display="table-row";
	}
	else
	{
		document.all.idcompanydetails.style.display="none";
		document.all.idcompanydetails1.style.display="none";
	}
	if(valuerCode=="2122"){
		document.all.govt_name.style.visibility="visible";
		document.all.govt_name.style.position="relative";
	}else{
		document.all.govt_name.style.visibility="hidden";
		document.all.govt_name.style.position="absolute";
	}
}

function chargedDetails() {
	if (document.forms[0].sel_alreadycharged.value == "Y") {
		document.all.amtcharged.style.visibility = "visible";
		document.all.amtcharged.style.position = "relative";
		document.all.amtcharged1.style.visibility = "visible";
		document.all.amtcharged1.style.position = "relative";
		document.all.instname.style.visibility = "visible";
		document.all.instname.style.position = "relative";
		document.all.instname1.style.visibility = "visible";
		document.all.instname1.style.position = "relative";
		
	} else {
		document.all.amtcharged.style.visibility = "hidden";
		document.all.amtcharged.style.position = "absolute";
		document.all.amtcharged1.style.visibility = "hidden";
		document.all.amtcharged1.style.position = "absolute";
		document.all.instname.style.visibility = "hidden";
		document.all.instname.style.position = "absolute";
		document.all.instname1.style.visibility = "hidden";
		document.all.instname1.style.position = "absolute";

	}
}

function jointownerdelall()
{
	var table=document.all.id_jointsec;
	var rowCount=table.rows.length;
	if(rowCount > 1)
	{
		for(var i=rowCount-1;i>0;i--)
		{
			table.deleteRow(i);      
		}
	}
	else
	{
		//No Function
	}
}

function callLAPSID(id)
{
	document.forms[0].txt_security_ownership.value=id;	
}

function jointownerdisp(securityowners)
{
	var var_arr= securityowners.split("@");
	var length=var_arr.length;
	for(var i=0;i<length-1;i=i+3)
	{
		var j=i;
		var table=document.all.id_jointsec;
		var rowCount=table.rows.length;

		
		var row=table.insertRow(rowCount);
		var varName=var_arr[j];
		var varLapsID=var_arr[++j];
		var varCBSID=var_arr[++j];
		
		var cell0=row.insertCell(0);
		cell0.className="datagrid";
		//cell0.innerHTML='<input type="radio" style="border-style:none" name="rad_chk" onclick="callLAPSID('+varLapsID+')">';		
			
		
		var cell1=row.insertCell(1);
		cell1.className="datagrid";
		cell1.innerHTML=varName;
		
		var cell2=row.insertCell(2);
		cell2.className="datagrid";
		cell2.innerHTML=varLapsID;

		var cell3=row.insertCell(3);
		cell3.className="datagrid";
		cell3.innerHTML=varCBSID;

		var cell4=row.insertCell(4);
		cell4.className="datagrid";

		var element4=document.createElement("input");
		element4.type="hidden";
		element4.name="hid_jointID["+rowCount+"]";
		element4.value=varLapsID;
		cell4.appendChild(element4);			
	}

	
}

function showJointSecurity()
{
	var rowCount=document.all.id_jointsec.rows.length;
	if(rowCount > 1)
	{
		document.all.id_jointsec.visibility="visible";
		document.all.id_jointsec.position="relative";
	}
	else
	{
		document.all.id_jointsec.visibility="hidden";
		document.all.id_jointsec.position="absolute";
	}
}
function disablefields()
{
	document.all.specifytype1.style.visibility = "hidden";
	document.all.specifytype1.style.position = "absolute";
	document.all.specifytype2.style.visibility = "hidden";
	document.all.specifytype2.style.position = "absolute";

	document.all.instname.style.visibility = "hidden";
	document.all.instname.style.position = "absolute";
	document.all.instname1.style.visibility = "hidden";
	document.all.instname1.style.position = "absolute";

	document.all.amtcharged.style.visibility = "hidden";
	document.all.amtcharged.style.position = "absolute";
	document.all.amtcharged1.style.visibility = "hidden";
	document.all.amtcharged1.style.position = "absolute";
}

function dobtnClose()
{
	if (ConfirmMsg(100)) 
	{
		document.forms[0].hidBeanId.value="bankappfi"
		document.forms[0].hidBeanGetMethod.value="getSecurityRetailDetails";
		document.forms[0].action=appURL+"action/securitymaster_retail.jsp";
		document.forms[0].submit();
	}
}

function disableFields(val) 
{
	for ( var i = 0; i < document.forms[0].length; i++) {
		if (document.forms[0].elements[i].type == 'textarea') {
			document.forms[0].elements[i].readOnly = val;
		}
		if (document.forms[0].elements[i].type == 'text') {
			document.forms[0].elements[i].readOnly = val;
		}
		if (document.forms[0].elements[i].type == 'select-one') {
			document.forms[0].elements[i].disabled = val;
		}
	}
}

function selJointHolder() 
{
	if (document.forms[0].sel_jointholder.value == "Y") {			
		document.all.id_jointsec.style.visibility="visible";
		document.all.id_jointsec.style.position="relative";
				
	} else{
		document.all.id_jointsec.style.visibility="hidden";
		document.all.id_jointsec.style.position="absolute";
	}

}
function showSpecify()
{
	if(document.forms[0].sel_securitytype.value ==24)
	{
			/* document.getElementById("specifytype1").style.display="block";
			document.getElementById("specifytype2").style.display="block"; */
		    document.all.specifytype1.style.visibility = "visible";
			document.all.specifytype1.style.position = "relative";
			document.all.specifytype2.style.visibility = "visible";
			document.all.specifytype2.style.position = "relative"; 
			
	} else {
			
		/* document.getElementById("specifytype1").style.display="none";
		document.getElementById("specifytype2").style.display="none"; */
			document.all.specifytype1.style.visibility = "hidden";
			document.all.specifytype1.style.position = "absolute";
			document.all.specifytype2.style.visibility = "hidden";
			document.all.specifytype2.style.position = "absolute";

	}
}

</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="onLoad()" style="overflow-y: scroll; overflow-x: hidden">
<form name="colForm" method="post" class="normal">
<%if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="22" />
        </jsp:include>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
	 <%if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">Home -&gt; Agriculture -&gt;Application -&gt; Promoters -&gt; Security Master </td>
	<%} else if(strSessionModuleType.equals("RET")){%>
		<td class="page_flow">Home -&gt; Retail -&gt;Application -&gt; Security Master </td>
	<%}
	else{%>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt;  Application -&gt; Security Master</td>
		<%} %>			
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%} else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="4" />
			<jsp:param name="subpageid" value="201" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../set/appurlsectabs.jsp" flush="true">
			<jsp:param name="pageid" value="2" />
		</jsp:include>
		</td>
	</tr>
</table>
 
<table width="98%" border="0" cellpadding="3" cellspacing="1" class="outertable" align="center" style="border: 1px solid #bbb;">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="3" cellpadding="3"	align="center" class="outertable">
		<tr>
			<td colspan="2"> Security ID :  <span style="color:#750b6a"> <%=strSecId %> </span>  </td>	
		</tr>
		<tr>
		    <td width="20%">Security Type <span class="mantatory">*&nbsp;</span></td>
						
            <td width="30%"> 
              <select name="sel_securitytype"size="1">
							<option value="0">&lt;--Select--&gt;</option>
                    <%
                    	String parenttype = "0";
                    %>
                    <lapschoice:staticdatasecuritiestag parenttype="<%=parenttype%>" />
						</select></td>
			
		    <td width="20%">Already Charged</td>						
            <td width="30%"> 
              <select name="sel_alreadycharged">
							<option value="" selected>--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
							
		</tr>
		<tr id="idcompanydetails">
			 <td>CIN No&nbsp;<span class="mantatory">*&nbsp;</span></td>						
	            <td> 
	              <input type="text" name="txt_com_cinno" size="30" maxlength="29"
							value='<%=Helper.correctNull((String)hshValues.get("svm_companycinno"))%>'>&nbsp;<b></b></td>
	             <td>Name of the Company</td>						
	            <td> 
	              <input type="text" name="txt_companyname" size="30"
			value="<%=Helper.correctNull((String)hshValues.get("svm_companyname"))%>" tabindex="12"><input type="hidden" name="hidcompanycode"></td>
		</tr>
		<tr id="idcompanydetails1">
			<td>Share Value</td>
			<td> 
	              <input type="text" name="txt_shareval" size="10" maxlength="5"  
							value='<%=Helper.correctNull((String)hshValues.get("CUS_COMPANYSHAREVAL"))%>' onblur="caltotalsecvalue();" style="text-align: right;"></td>
			 <td>Number of Shares&nbsp;<span class="mantatory">*&nbsp;</span></td>						
	            <td> 
	              <input type="text" name="txt_noofshares" size="10" maxlength="5" onkeypress="allowNumber(this);" 
							value='<%=Helper.correctNull((String)hshValues.get("CUS_COMPANYSHARE_CNT"))%>'  onblur="caltotalsecvalue();"></td>
		</tr>
		<tr>
		
		 <td id="specifytype1">Specify (Other Security Type)<span class="mantatory">*&nbsp;</span></td>						
            <td id="specifytype2"> 
              <input type="text" name="txt_security_type_specify" size="30" maxlength="29"
						value="<%=Helper.correctNull((String)hshValues.get("CUS_SEC_TYPE_SPECIFY"))%>" tabindex="2"></td>
						
			       
             <td id="instname">Name of the institution</td>						
            <td id="instname1"> 
              <input type="text" name="txt_name_institution" size="30" maxlength="29"
		value="<%=Helper.correctNull((String)hshValues.get("CUS_SEC_NAME_institution"))%>" tabindex="12"></td>
		   
			
		</tr>
		
		<tr>
		    <td>Security Classification <span class="mantatory">*&nbsp;</span></td>
						
            <td> 
               <select name="sel_securityclassifcation" size="1" tabindex="3">
                      <option selected value="0">--Select--</option>
                    </select></td>
             
		 <td id="amtcharged">Amount Charged to other institution <b>(<%=ApplicationParams.getCurrency()%>)</b></td>						
            <td id="amtcharged1">
              <input type="text" name="txt_charged_to_institution" size="12" maxlength="10"
		value="<%=Helper.correctNull((String)hshValues.get("CUS_SEC_Amount_Charged"))%>" style="text-align:right"></td>
							
		</tr>		
		<tr>
		<td>Specify (Other Security Classification) </td>						
            <td> 
              <input type="text" name="txt_security_clasicification_specify" size="30" maxlength="29"
		value="<%=Helper.correctNull((String)hshValues.get("CUS_SEC_CLASSIFICATION_SPECIFY"))%>" tabindex="4"></td>
		
		<td>Valuer Name</td>
						<td><input type="text" name="txt_Valuers_name" size="30" maxlength="29"
													value="<%=Helper.correctNull((String)hshValues.get("CUS_SEC_Valuer_Name"))%>" 
													onKeyPress="notAllowSplChar()" tabindex="14">
												<b><span style="cursor: hand"><font
													size="1" face="MS Sans Serif"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0"></font></span></b>&nbsp;</td>
		</tr>
		<tr id="govt_name">
		<td>Specify the Name(GOVT VALUER) </td>						
            <td> 
              <input type="text" name="txt_gvtscheme_name" size="30" maxlength="29"
		value="<%=Helper.correctNull((String)hshValues.get("CUS_SEC_GOVT_VALUER"))%>" onKeyPress="notAllowSplChar()" ></td>
		</tr>
		
		<tr>
			<td>Nature of Charge<span class="mantatory">*&nbsp;</span></td>
			<td> 
              <select name="sel_natureCharge" tabindex="" >
				<option value="0" selected>---Select---</option>
                <lapschoice:StaticDataNewTag apptype="134"  /> 
			 </select>
			</td>
			<td colspan="2">&nbsp;</td>
		</tr>
		
		<tr>
			<td>Security interest ID with ROC </td>
			<td><input type="text" name="txt_secintID_roc" size="30" maxlength="29"  value="<%=Helper.correctNull((String)hshValues.get("CUS_SEC_INTID_ROC"))%>"></td>
			<td> Charge ID with ROC  </td>
			<td><input type="text" name="txt_charid_roc" size="30" maxlength="29" 	value="<%=Helper.correctNull((String)hshValues.get("CUS_SEC_CHARGEID_ROC"))%>"></td>
		</tr>
		<tr>
                   <td>Date of submission of request for valuation by bank </td>
                   <td><input type="text" name="txt_dateofsubmissionbybank" size="11"
							value="<%=Helper.correctNull((String)hshValues.get("CUS_VALSUBMITTEDDATE"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate);checkmaxdate(this,document.forms[0].txt_validation_date.value)" maxlength="10" tabindex="15">
					 </td>
                   <td>Date of receipt of valuation report by bank </td>
                   <td><input type="text" name="txt_dateofreceiptbybank" size="11"
							value="<%=Helper.correctNull((String)hshValues.get("CUS_VALRECVDATE"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate);checkmindate(this,document.forms[0].txt_dateofsubmissionbybank.value)" maxlength="10" tabindex="15">
					 </td>
                  </tr>
		
		<tr>
		    <td>Security Description</td>						
            <td> 
              <input type="text" name="txt_security_desc" size="30" maxlength="29"
		value="<%=Helper.correctNull((String)hshValues.get("cus_sec_security_description"))%>" tabindex="5"></td>
			<td>Date of Valuation (as per report)</td>										
		    <td > 
              <input type="text" name="txt_validation_date" size="11"
							value="<%=Helper.correctNull((String)hshValues.get("CUS_SEC_VALUATION_DATE"))%>">
							</td>
							
		</tr>
		
		<tr>
		    <td>Collateral Start Date <span class="mantatory">*&nbsp;</span></td>										
		    <td> 
              <input type="text" name="txt_collareral_start_date" size="11"
							value="<%=Helper.correctNull((String)hshValues.get("CUS_SEC_COLLATERAL_START_DATE"))%>"
							onBlur="checkDate(this);" maxlength="12" tabindex="6">
							</td>
			<td>Insurance Company</td>
						<td><input type="text" name="txt_insurence_company" size="30" maxlength="29"
													value="<%=Helper.correctNull((String)hshValues.get("CUS_SEC_INSURENCE_COMPANY"))%>"
													 tabindex="16"></td>
						
		</tr>
		<tr>
		<td>Collateral End Date <span class="mantatory">*&nbsp;</span></td>										
		    <td> 
              <input type="text" name="txt_collareral_end_date" size="11"
							value="<%=Helper.correctNull((String)hshValues.get("CUS_SEC_COLLATERAL_END_DATE"))%>">
							</td>
							
			<td>Insured Amount <b><%=ApplicationParams.getCurrency()%></b></td>						
            <td> 
              <input type="text" name="txt_insured_amount" size="12" maxlength="10"
		value="<%=Helper.correctNull((String)hshValues.get("CUS_SEC_Insured_Amount"))%>" style="text-align:right"></td>
			
						
		</tr>
		
		<tr>
		    <td>Net Security Value <span class="mantatory">*&nbsp;</span> <b><%=ApplicationParams.getCurrency()%></b></td>						
            <td>
              <input type="text" name="txt_net_security" size="12" maxlength="10"
		value="<%=Helper.correctNull((String)hshValues.get("cus_sec_netsecurity"))%>" style="text-align:right"></td>
		
		
		    <td>Due Date </td>										
		    <td> 
              <input type="text" name="txt_duedate" size="11"
							value="<%=Helper.correctNull((String)hshValues.get("CUS_SEC_DUE_DATE"))%>">
							</td>
						
		
		 							
		</tr>
		<tr>
		<td>Residual Amount <span class="mantatory">*&nbsp;</span><b><%=ApplicationParams.getCurrency()%></b></td>						
              <td> 
              <input type="text" name="txt_residual_amount" size="12" maxlength="10"
		value="<%=Helper.correctNull((String)hshValues.get("CUS_SEC_REIDUALVAL"))%>" style="text-align:right"></td>
												
			 <td>Joint Holder</td>						
            <td> 
              <select name="sel_jointholder">
							<option value="" selected>--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
		</tr>	
		
		<tr>
		<td>Residual Risk Flag</td>						
            <td> 
              <select name="sel_residual_risk" tabindex="9" >
							<option value="" selected>--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
												
			 <td colspan="2">&nbsp;</td>
		</tr>
		
				
		<tr>
		<td colspan="4">
		<table id="id_jointsec" width="45%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="right" style="border: 1px solid #bbb;">		
				<tr class="dataheader">
					<td width="0%">&nbsp;</td>
					<td width="30%" align="center">Name</td>
					<td width="30%" align="center">Laps Id</td>			
            		<td width="30%" align="center">CBS Id</td>
            		<td width="0%">&nbsp;</td>
            	</tr>
				</table>
		</td>
		</tr>
		
	</table>
	
		</td>
	</tr>
</table>
<br>
 <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable" align="center">
  <tr><td align="center"> 
    <input type="button" name="cmdclose" value="Close" onClick="dobtnClose()"  class="buttonClose"> 
  </td></tr>
 </table>
 <br>
 
<input type="hidden" name="hidSecurityId" value="<%=Helper.correctNull((String) hshValues.get("strSecId"))%>">
<input type="hidden" name="hidsno"> 
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String) hshValues.get("strAppid"))%>">
<input type="hidden" name="hidOnclickFlag"> 
<input type="hidden" name="hidOwners"> 
<input type="hidden" name="hidsecid" value="<%=strsecID%>"> 
<input type="hidden" name="hidsectype" value="<%=sectype%>">
<input type="hidden" name="cmdsave" disabled="disabled">

<%
 	String strappno = request.getParameter("appno");
 %> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<iframe	height="0" width="0" id="ifrmsecurityclassification" frameborder=0 style="border: 0">
</form>
</body>
</html>