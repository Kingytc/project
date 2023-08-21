<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			ArrayList vec = new ArrayList();
			int vecsize = 0;
			if (hshValues != null) {
				vec = (ArrayList) hshValues.get("vecData2");
			}
			if (vec != null) {
				vecsize = vec.size();
			}
			ArrayList g2 = new ArrayList();
			String strSno[]={"R","D","A","111","112","P004","P005","M004","M005","M006","P006"};
			
			ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();
			if (hshValues != null) {
				arrRow = (ArrayList) hshValues.get("arrRow1");
			}
%>
<html>
<head>
<title>LAPS Application Parameters</title>

<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
	<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"> </script>

<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";

function callonLoad()
{		
	disablefields(true);
	enableButtons(false, true, true, false);	
	<%for(int i=0;i<strSno.length;i++){%>
		for(var j=0;j<document.forms[0].txt_id.length;j++)
		{
			var val="<%=strSno[i]%>";
			if(document.forms[0].txt_id[j].value==val)
			{
				document.forms[0].txt_noofyears[j].value="<%=Helper.correctNull((String)hshValues.get("strSOCParam"+strSno[i]))%>";
				showDescClass(document.forms[0].txt_noofyears[j],j);

				document.forms[0].txt_maxid[j].value="<%=Helper.correctNull((String)hshValues.get("strMaxParam"+strSno[i]))%>";
				showDescClass1(document.forms[0].txt_maxid[j],j);

				var sel_mul="<%=Helper.correctNull((String)hshValues.get("strParam"+strSno[i]))%>";
				if(sel_mul!="")
				{
					   var sml = sel_mul.split("@");
					   for(var i=0;i<sml.length;i++)
					   {
						if(sml[i]=="C")
						{
							document.forms[0].txt_orgLevel[j].options[0].selected=true;
						}
						else if(sml[i]=="R")
						{
							document.forms[0].txt_orgLevel[j].options[1].selected=true;
						}
						else if(sml[i]=="D")
						{
							document.forms[0].txt_orgLevel[j].options[2].selected=true;
						}
						else if(sml[i]=="A")
						{
							document.forms[0].txt_orgLevel[j].options[3].selected=true;
						}
					  }
				}

			}
		}
	<%}
	if(arrRow!=null && arrRow.size()>0){ 
	for(int i=0;i<arrRow.size();i++){
	arrCol=(ArrayList)arrRow.get(i);%>
	for(var j=0;j<document.forms[0].txt_id.length;j++)
	{
		var val="C<%=Helper.correctNull((String)arrCol.get(3))%>";
		if(document.forms[0].txt_id[j].value==val)
		{
			document.forms[0].txt_noofyears[j].value="<%=Helper.correctNull((String)hshValues.get("strSOCParamC"+Helper.correctNull((String)arrCol.get(3))))%>";
			showDescClass(document.forms[0].txt_noofyears[j],j);
			document.forms[0].txt_maxid[j].value="<%=Helper.correctNull((String)hshValues.get("strMaxParamC"+Helper.correctNull((String)arrCol.get(3))))%>";
			showDescClass1(document.forms[0].txt_maxid[j],j);
		}
	}
	<%}}%>
	<%if(arrRow!=null && arrRow.size()>0){ 
		for(int i=0;i<arrRow.size();i++){
		arrCol=(ArrayList)arrRow.get(i);%>
		for(var j=0;j<document.forms[0].txt_id.length;j++)
		{
			var val="P<%=Helper.correctNull((String)arrCol.get(3))%>";
			if(document.forms[0].txt_id[j].value==val)
			{
				document.forms[0].txt_noofyears[j].value="<%=Helper.correctNull((String)hshValues.get("strSOCParamP"+Helper.correctNull((String)arrCol.get(3))))%>";
				showDescClass(document.forms[0].txt_noofyears[j],j);
				
				document.forms[0].txt_maxid[j].value="<%=Helper.correctNull((String)hshValues.get("strMaxParamP"+Helper.correctNull((String)arrCol.get(3))))%>";
				showDescClass1(document.forms[0].txt_maxid[j],j);
			}
		}
		<%}}
	if(arrRow!=null && arrRow.size()>0){ 
		for(int i=0;i<arrRow.size();i++){
		arrCol=(ArrayList)arrRow.get(i);%>
		for(var j=0;j<document.forms[0].txt_id.length;j++)
		{
			var val="M<%=Helper.correctNull((String)arrCol.get(3))%>";
			if(document.forms[0].txt_id[j].value==val)
			{
				document.forms[0].txt_noofyears[j].value="<%=Helper.correctNull((String)hshValues.get("strSOCParamM"+Helper.correctNull((String)arrCol.get(3))))%>";
				showDescClass(document.forms[0].txt_noofyears[j],j);
				
				document.forms[0].txt_maxid[j].value="<%=Helper.correctNull((String)hshValues.get("strMaxParamM"+Helper.correctNull((String)arrCol.get(3))))%>";
				showDescClass1(document.forms[0].txt_maxid[j],j);

				var sel_mul="<%=Helper.correctNull((String)hshValues.get("strParamM"+Helper.correctNull((String)arrCol.get(3))))%>";
				if(sel_mul!="")
				{
					   var sml = sel_mul.split("@");
					   for(var i=0;i<sml.length;i++)
					   {
						if(sml[i]=="C")
						{
							document.forms[0].txt_orgLevel[j].options[0].selected=true;
						}
						else if(sml[i]=="R")
						{
							document.forms[0].txt_orgLevel[j].options[1].selected=true;
						}
						else if(sml[i]=="D")
						{
							document.forms[0].txt_orgLevel[j].options[2].selected=true;
						}
						else if(sml[i]=="A")
						{
							document.forms[0].txt_orgLevel[j].options[3].selected=true;
						}
					  }
				}
			}
		}
		<%}}
		%>
		for(var j=0;j<document.forms[0].txt_id.length;j++)
		{
			if(document.forms[0].txt_id[j].value=="122")
			{
				document.forms[0].txt_noofyears[j].value="<%=Helper.correctNull((String)hshValues.get("strLMSAvail"))%>";
			}
			if(document.forms[0].txt_id[j].value=="128")
			{
				document.forms[0].txt_noofyears[j].value="<%=Helper.correctNull((String)hshValues.get("strUserRestrict"))%>";
				enabledOrgDetails(document.forms[0].txt_noofyears[j]);
			}
			if(document.forms[0].txt_id[j].value=="132") //vindhya pan check
			{
				document.forms[0].txt_noofyears[j].value="<%=Helper.correctNull((String)hshValues.get("strPancheck"))%>";
			}
		}
}

function disablefields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=='select-multiple')
		{
			document.forms[0].elements[i].disabled=one;
		}	
	}

	for(var i=0;i<document.forms[0].txt_class_desc.length;i++)
	{
		document.forms[0].txt_class_desc[i].readOnly=true;
	}
}

function doSave()
{	
	var s1="";
	for(i=0;i<document.forms[0].txt_orgLevel.length;i++)
    {
	  s1="";
		for(j=0;j<document.forms[0].txt_orgLevel[i].length;j++)
	   	{     
			if(document.forms[0].txt_orgLevel[i].options[j].selected==true)
     		{
	     			s1 = s1+ document.forms[0].txt_orgLevel[i].options[j].value+"@"; 
          	}
		}
		document.forms[0].hidtxt_orgLevel[i].value = s1;
	}
	disablefields(false);
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanGetMethod.value="updateDataHouseParameters";
	document.forms[0].action=appURL+"action/setlapsParameters.jsp";	
	document.forms[0].submit();
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanGetMethod.value="getDataHouseParameters";
		document.forms[0].action=appURL+"action/setlapsParameters.jsp";	
		document.forms[0].submit();
	}
}

function doEdit() 
{
   	document.forms[0].hidAction.value="update";
	enableButtons(true, false, false, true);
	disablefields(false);
	document.all.txt_LoanMargindate.readOnly=true;
}
   
function enableButtons(bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

var val2="";
var val1="";
function showDescClass(id,value)
{
	var val=id.value;
	
    val1=document.forms[0].txt_noofyears[value].value;
    val2=document.forms[0].txt_maxid[value].value;
    if(val1!=""&&val2!="" &&  value != "18" && value != "19" && value != "20" && value != "21" && value != "22" && value != "9" && value != "10")
    {
    	
   if(eval(val1)<=eval(val2))
   {
    for(i=0;i<document.forms[0].prd_class_value.length;i++)
		{	
			if(val == document.forms[0].prd_class_value[i].value)
			{
				document.forms[0].prd_class_value.selectedIndex=i;
				if(document.forms[0].prd_class_value.options[document.forms[0].prd_class_value.selectedIndex].text == "Select")
					document.forms[0].txt_class_desc[value].value="";
				else
					document.forms[0].txt_class_desc[value].value=document.forms[0].prd_class_value.options[document.forms[0].prd_class_value.selectedIndex].text;
			}
		}
		
  }
    else if(eval(val1)>eval(val2))
 {
	 alert("select minimum value");
	 document.forms[0].txt_noofyears[value].value="";
	 document.forms[0].txt_class_desc[value].value="";
	 document.forms[0].txt_noofyears[value].focus();
	 return;
  }
   
	   
	   
  }
    if(val1!=""&&val2=="")
    {
    	 for(i=0;i<document.forms[0].prd_class_value.length;i++)
 		{	
 			if(val == document.forms[0].prd_class_value[i].value)
 			{
 				document.forms[0].prd_class_value.selectedIndex=i;
 				if(document.forms[0].prd_class_value.options[document.forms[0].prd_class_value.selectedIndex].text == "Select")
 					document.forms[0].txt_class_desc[value].value="";
 				else
 					document.forms[0].txt_class_desc[value].value=document.forms[0].prd_class_value.options[document.forms[0].prd_class_value.selectedIndex].text;
 			}
 		}
    }
  
}

function showDescClass1(id,value)
{
	var val=id.value;
	val1=document.forms[0].txt_noofyears[value].value;
	val2=document.forms[0].txt_maxid[value].value;
	if(eval(val1)<=eval(val2))
	{
		
	for(i=0;i<document.forms[0].prd_class_value.length;i++)
		{	
			if(val == document.forms[0].prd_class_value[i].value)
			{
				document.forms[0].prd_class_value.selectedIndex=i;
				if(document.forms[0].prd_class_value.options[document.forms[0].prd_class_value.selectedIndex].text == "Select")
					document.forms[0].txt_class_desc1[value].value="";
				else
					document.forms[0].txt_class_desc1[value].value=document.forms[0].prd_class_value.options[document.forms[0].prd_class_value.selectedIndex].text
			}
		}
	}
	
	else if(eval(val1)>eval(val2))
	{
	alert("select maximum value");
	document.forms[0].txt_maxid[value].value="";
	document.forms[0].txt_class_desc1[value].value="";
	document.forms[0].txt_maxid[value].focus();
	return;
	
		
	}
}

function cgborlimit()
{
	var varcglmt = document.getElementById("bor_lmt").value;
	if(varcglmt > 20000000)
	{
		alert("Amount should not exceed 20000000.00");
		document.getElementById("bor_lmt").value="";
		document.getElementById("bor_lmt").focus();
		return;
	}
}

function cgborint()
{
	var varcgint = document.getElementById("bor_int").value;
	if(varcgint > 14)
	{
		alert("CGTMSE Maximum Interest Rate is 14%");
		document.getElementById("bor_int").value="";
		document.getElementById("bor_int").focus();
		return;
	}
}
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
	}
}
function enabledOrgDetails(obj)
{
	if(obj.value=="Y")
	{
		document.all.idBranch.style.display="table-row";
		document.all.idCLPU.style.display="table-row";
		document.all.idRO.style.display="table-row";
		document.all.idHO.style.display="table-row";
	}
	else
	{
		document.all.idBranch.style.display="none";
		document.all.idCLPU.style.display="none";
		document.all.idRO.style.display="none";
		document.all.idHO.style.display="none";
	}
}
function enabledPANlimitDetails(obj)
{
	if(obj.value=="Y")
	{
		document.all.idagrlimit.style.display="table-row";
		document.all.idcorplimit.style.display="table-row";
		document.all.idretlimit.style.display="table-row";
		document.all.idagrlimit1.style.display="table-row";
		
	}
	else
	{
		document.all.idagrlimit.style.display="none";
		document.all.idcorplimit.style.display="none";
		document.all.idretlimit.style.display="none";
		document.all.idagrlimit1.style.display="none";
	}
}
</SCRIPT>
</head>
<body onload="callonLoad()">

<form name="appform" method="post" action="" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home
		-&gt; Setup -&gt; Admin Level Controls -&gt; LAPS Application Parameters </td>
	</tr>
</table>
<table width="90%" border="0" cellpadding="5" cellspacing="0"
	 align="center" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable">

			<tr>
				<td valign="top">
				<table width="85%" border="0" cellspacing="0" cellpadding="5"
					align="center" class="outertable">
					<tr>
						<td valign="top" height="100px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="3"
								class="outertable border1 tableBg"	>
									<tr height="25" align="center" class="dataheader">
										<td nowrap width="30%"><b>
											Parameters</b></td>
										<td nowrap width="70%">
											<b>Value</b></td>
									</tr>
									<tr>
										<td><b>Kalypto Application URL</b>&nbsp;</td>
										<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="text" name="txt_noofyears" value="<%=Helper.correctNull((String)hshValues.get("strKalypto")) %>" 
										size="60" maxlength="80"><input type="hidden" name="txt_class_desc"><input type="hidden"  
										name="txt_id" value="KALYPTO">&nbsp;</span>
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr>
										<td><b>Security Valuation Expiry Period for a Property from the Date of Valuation </b>&nbsp;</td>
										<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="txt_noofyears" onKeyPress="allowNumber(this)"  value="<%=Helper.correctNull((String)hshValues.get("strExpirePeriod")) %>" style="text-align:right" size="10" maxlength="5"><input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="101">&nbsp;(months)</span>
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr>
										<td><b>Period to Check the securities approaching valuation Expiry </b>&nbsp;</td>
										<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="txt_noofyears" onKeyPress="allowNumber(this)" value="<%=Helper.correctNull((String)hshValues.get("strExpireIn")) %>" style="text-align:right" size="10" maxlength="5"><input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="102">&nbsp;(months)
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr>
										<td><b>Retail (Schematic loans) Interest Deviation can be done upto</b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" onKeyPress="allowNumber(this)" onblur="roundtxt(this);"  value="<%=Helper.correctNull((String)hshValues.get("strIntDev_retail_sch")) %>" style="text-align:right" size="10" maxlength="5"><input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="103">&nbsp;%
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr>
										<td><b>Retail (Non Schematic loans) Interest Deviation can be done upto</b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" onKeyPress="allowNumber(this)" onblur="roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("strIntDev_retail_nonsch")) %>" style="text-align:right" size="10" maxlength="5"><input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="105">&nbsp;%
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr>
										<td><b>Corporate &amp; Agriculture Interest Deviation can be done upto </b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" onKeyPress="allowNumber(this)" onblur="roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("strIntDev_CorpAgri")) %>" style="text-align:right" size="10" maxlength="5"><input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="104">&nbsp;%
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr>
										<td><b>Additional Premium for Adhoc Facilities(WCDPN) can be done upto</b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" onKeyPress="allowNumber(this)" value="<%=Helper.correctNull((String)hshValues.get("strmclradhocpremium")) %>" style="text-align:right" size="10" maxlength="5"><input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="106">&nbsp;%
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr>
										<td><b>Maximum Document Size for Document Attachment </b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" onKeyPress="allowNumber(this)" value="<%=Helper.correctNull((String)hshValues.get("strMaxDOCsize")) %>" style="text-align:right" size="10" maxlength="10"><input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="107">&nbsp;kb
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr>
										<td><b> Maximum Number of times allowed to Print Document </b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" onKeyPress="allowInteger(this)" value="<%=Helper.correctNull((String)hshValues.get("strMaxDocPrint")) %>" style="text-align:right" size="10" maxlength="3"><input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="108">&nbsp;  
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr>
										<td><b> Minimum Class Rights for Approve Security </b>&nbsp;</td>
										<td>
										
										<table border="0" cellspacing="0" cellpadding="0" width="100%"
									class="outertable">
									<tr>
										<td><select
											name="txt_noofyears"
											onChange=showDescClass(this,9)>
											<option value="">Select</option>
											<lapschoice:usersclass />
										</select> &nbsp;</td>
										<td><input type="text" name="txt_class_desc" size="35">
										<input type="hidden"  name="txt_id" value="111">&nbsp;
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
								</table>
										</td>								
									</tr>
										<tr>
										<td><b> Minimum Class Rights for CFR Deviation Approve </b>&nbsp;</td>
										<td>
										
										<table border="0" cellspacing="0" cellpadding="0" width="100%"
									class="outertable">
									<tr>
										<td><select
											name="txt_noofyears"
											onChange=showDescClass(this,10)>
											<option value="">Select</option>
											<lapschoice:usersclass />
										</select> &nbsp;</td>
										<td><input type="text" name="txt_class_desc" size="35">
										<input type="hidden"  name="txt_id" value="112">&nbsp;
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
								</table>
										</td>								
									</tr>
									<tr>
										<td><b>Borrower level CGTMSE limit</b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears"  onKeyPress="allowNumber(this)" onblur="roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("strBorLmt")) %>" style="text-align:right" size="15" > <input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="115">&nbsp;  
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr>
										<td><b>CGTMSE Maximum Interest Rate</b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears"  onKeyPress="allowNumber(this)" onblur="roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("strCgtInt")) %>" style="text-align:right" size="10" maxlength="5"><input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="116">&nbsp;%
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr style="display:none;">
										<td><b>GST percentage on Guarantee Fee</b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" onKeyPress="allowNumber(this)" onblur="roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("strGstfee")) %>" style="text-align:right" size="10" maxlength="5"><input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="117">&nbsp;%
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr>
										<td><b>Gold Loan Margin Changes Effective Date</b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" id="txt_LoanMargindate" onblur="checkDate(this);checkmaxdate(this,currentDate)" value="<%=Helper.correctNull((String)hshValues.get("strGoldDate")) %>" style="text-align:right" size="15" maxlength="10">
										&nbsp;
										<input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="118">
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr>
										<td><b>Number of times moratorium can be given</b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" value="<%=Helper.correctNull((String)hshValues.get("strEduAppCnt")) %>" style="text-align:right" size="15" maxlength="10">
										&nbsp;
										<input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="119">
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr>
										<td><b>Maximum number of months for which extension can be given each time</b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" value="<%=Helper.correctNull((String)hshValues.get("strEduMort")) %>" style="text-align:right" size="15" maxlength="10">
										&nbsp;
										<input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="120">
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									
									<tr>
										<td><b>Hunter Minimum Score</b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" value="<%=Helper.correctNull((String)hshValues.get("strHunterScore")) %>" style="text-align:right" size="15" maxlength="10">
										&nbsp;
										<input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="123">
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									
									<tr>
										<td><b>Hunter Periodicity</b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" value="<%=Helper.correctNull((String)hshValues.get("strHunterPeriodicity")) %>" style="text-align:right" size="15" maxlength="10">
										&nbsp; (Days)
										<input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="124">
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr>
										<td><b>Business Quick Loan - No of Times GST Average Permitted</b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" value="<%=Helper.correctNull((String)hshValues.get("strBusinessLoanAssess")) %>" style="text-align:right" size="15" maxlength="10"  onkeypress="allowNumber(this)"> (Times)
										<input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="125">
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr>
										<td><b>Business Quick Loan - Eligible Limit</b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" value="<%=Helper.correctNull((String)hshValues.get("strBusinessLoanPercent")) %>" style="text-align:right" size="15" maxlength="10"  onkeypress="allowNumber(this)"> (%)
										<input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="126">
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
									<td colspan="2" class="dataheader"> Loan Against Share Parameters</td>
									</tr>
									<tr>
										<td><b> Maximum Paid up capital percentage for Karnataka Bank </b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" onKeyPress="allowInteger(this)" onblur="roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("strLASBankMargin")) %>" style="text-align:right" size="10" maxlength="3"> (%)<input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="109">&nbsp;  
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr>
										<td><b>  Maximum Paid up capital percentage for Others </b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" onKeyPress="allowInteger(this)" onblur="roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("strLASOtherMargin")) %>" style="text-align:right" size="10" maxlength="3"> (%)<input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="110">&nbsp;  
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr>
										<td><b> Maximum Borrower Limit for Physical form </b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" onKeyPress="allowNumber(this)" onblur="roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("strLASPhysicalLmt")) %>" style="text-align:right" size="15" maxlength="15"> <input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="113">&nbsp;  
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr>
										<td><b>  Maximum Borrower Limit for Demat Form </b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" onKeyPress="allowNumber(this)" onblur="roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("strLASDematLmt")) %>" style="text-align:right" size="15" maxlength="15"> <input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="114">&nbsp;  
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
									<td colspan="2" class="dataheader"> MINIMUM CLASS RIGHTS FOR APPROVE SECURITY OWNER CHANGE</td></tr>
										<%int a=24;
										if(arrRow!=null && arrRow.size()>0){ 
										for(int i=0;i<arrRow.size();i++){
										arrCol=(ArrayList)arrRow.get(i);
										
									%>
									<tr>
										<td><b><%=Helper.correctNull((String)arrCol.get(2)) %></b>&nbsp;</td>
										<td>
										<table border="0" cellspacing="0" cellpadding="0" width="100%"
									class="outertable">
									<tr>
										<td><select
											name="txt_noofyears"
											onChange=showDescClass(this,<%=++a%>)>
											<option value="">Select</option>
											<lapschoice:usersclass />
										</select> &nbsp;</td>
										
										<td><input type="text" name="txt_class_desc" size="35">
										<input type="hidden"  name="txt_id" value="C<%=Helper.correctNull((String)arrCol.get(3)) %>">&nbsp;
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
								</table>
								</td>
									</tr>
									<%}} %>
									
									<tr>
										<td><b>REGIONAL OFFICE </b>&nbsp;</td>
										<td>
										<table border="0" cellspacing="0" cellpadding="0" width="100%"
									class="outertable">
									<tr>
										<td>
										<select name="txt_noofyears" onChange=showDescClass(this,<%=++a %>)>
											<option value="">Select</option>
											<lapschoice:usersclass />
										</select> &nbsp;</td>
										<td style="visibility: hidden;position: absolute;"><select name="prd_class_value"
											style="width: 20">
											<option value="">Select</option>
											<lapschoice:usersclassdesc />
										</select></td>
										<td><input type="text" name="txt_class_desc" size="35">
										<input type="hidden"  name="txt_id" value="R">&nbsp;
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
										</table>
										</td>
									</tr>
									<tr>
										<td><b>CLPU </b>&nbsp;</td>
										<td>
										<table border="0" cellspacing="0" cellpadding="0" width="100%"
									class="outertable">
									<tr>
										<td>
										<select name="txt_noofyears" onChange=showDescClass(this,<%=++a %>)>
											<option value="">Select</option>
											<lapschoice:usersclass />
										</select> &nbsp;</td>
										<td><input type="text" name="txt_class_desc" size="35">
										<input type="hidden"  name="txt_id" value="D">&nbsp;
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
										</table>
										</td>
									</tr>
									<tr>
										<td><b>BRANCH </b>&nbsp;</td>
										<td>
										<table border="0" cellspacing="0" cellpadding="0" width="100%"
									class="outertable">
									<tr>
										<td>
										<select name="txt_noofyears" onChange=showDescClass(this,<%=++a %>)>
											<option value="">Select</option>
											<lapschoice:usersclass />
										</select> &nbsp;</td>
										<td><input type="text" name="txt_class_desc" size="35">
										<input type="hidden"  name="txt_id" value="A">&nbsp;
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
										</table>
										</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
									<td colspan="2" class="dataheader"> PERMISSION PARAMETER</td>
									</tr>
									<tr>
										<td><b>Maximum Document Size for Document Attachment </b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" onKeyPress="allowNumber(this)" value="<%=Helper.correctNull((String)hshValues.get("strDoc")) %>" style="text-align:right" size="10" maxlength="10"><input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="P001">&nbsp;kb
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<%a=a+1; %>
									<%
										if(arrRow!=null && arrRow.size()>0){ 
										for(int i=0;i<arrRow.size();i++){
										arrCol=(ArrayList)arrRow.get(i);
										
									%>
									<tr>
										<td><b><%=Helper.correctNull((String)arrCol.get(2)) %></b>&nbsp;</td>
										<td>
										<table border="0" cellspacing="0" cellpadding="0" width="100%"
									class="outertable">
									<tr>
										<td><select
											name="txt_noofyears"
											onChange=showDescClass(this,<%=++a %>)>
											<option value="">Select</option>
											<lapschoice:usersclass />
										</select> &nbsp;</td>
										
										<td><input type="text" name="txt_class_desc" size="35">
										<input type="hidden"  name="txt_id" value="P<%=Helper.correctNull((String)arrCol.get(3)) %>">&nbsp;
										</td>
										<td><select
											name="txt_maxid"
											onChange=showDescClass1(this,<%=a%>)>
											<option value="">Select</option>
											<lapschoice:usersclass />
										</select> &nbsp;
										</td>
										<td>
										<input type="text" name="txt_class_desc1" size="35">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel">
										</td>
									</tr>
								</table>
								</td>
									</tr>
									<%}} %>
									
									<tr>
										<td><b>BRANCH </b>&nbsp;</td>
										<td>
										<table border="0" cellspacing="0" cellpadding="0" width="100%"
									class="outertable">
									<tr>
										<td>
										<select name="txt_noofyears" onChange=showDescClass(this,<%=++a %>)>
											<option value="">Select</option>
											<lapschoice:usersclass />
										</select> &nbsp;</td>
										<td><input type="text" name="txt_class_desc" size="35">
										<input type="hidden"  name="txt_id" value="P004">&nbsp;</td>
										<td><select
											name="txt_maxid"
											onChange=showDescClass1(this,<%=a %>)>
											<option value="">Select</option>
											<lapschoice:usersclass />
										</select> &nbsp;
										</td>
										<td>
										<input type="text" name="txt_class_desc1" size="35">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel">
										</td>
										</table>
										</td>
									</tr>
									<tr>
										<td><b>RO/CLPU</b>&nbsp;</td>
										<td>
										<table border="0" cellspacing="0" cellpadding="0" width="100%"
									class="outertable">
									<tr>
										<td><select
											name="txt_noofyears"
											onChange=showDescClass(this,<%=++a %>)>
											<option value="">Select</option>
											<lapschoice:usersclass />
										</select> &nbsp;</td>
										<td><input type="text" name="txt_class_desc" size="35">
										<input type="hidden"  name="txt_id" value="P005">&nbsp;</td>
										<td><select
											name="txt_maxid"
											onChange=showDescClass1(this,<%=a %>)>
											<option value="">Select</option>
											<lapschoice:usersclass />
										</select> &nbsp;
										</td>
										<td>
										<input type="text" name="txt_class_desc1" size="35">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel">
										</td>
									</tr>
									
								</table>
								</td>
									</tr>
									<tr>
										<td><b> Whether LMS Server Available?</b>&nbsp;</td>
										<td valign="top"><select
											name="txt_noofyears">
											<option value="">Select</option>
											<option value="Y">Yes</option>
											<option value="N">No</option>
										</select> <input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="122">&nbsp;  
										<textarea  name="txt_maxid" cols="90" rows="5" onKeyPress="textlimit(this,499)" onKeyUp="textlimit(this,499)"><%=Helper.correctNull((String)hshValues.get("strLMSRemarks")) %></textarea>
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr>
										<td><b> Eligible Margin value for KBL MICRO MITRA Assessment</b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" value="<%=Helper.correctNull((String)hshValues.get("strMithraAssessment")) %>" style="text-align:right" size="15" maxlength="10"  onkeypress="allowNumber(this)"> (%)
										<input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="127">
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<!-- <tr>
										<td><b> Maximum eligible limit to the borrower</b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" value="<%=Helper.correctNull((String)hshValues.get("strLmtBrwr")) %>" style="text-align:right" size="15" maxlength="10"  onkeypress="allowNumber(this)"> (%)
										<input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="129">
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr>
										<td><b> Maximum eligible limit without NOC from others</b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" value="<%=Helper.correctNull((String)hshValues.get("strLmtNOC")) %>" style="text-align:right" size="15" maxlength="10"  onkeypress="allowNumber(this)"> (%)
										<input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="130">
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr> -->
									<tr>
										<td><b> Whether Login restriction required for Limited Users?</b>&nbsp;</td>
										<td valign="top"><select
											name="txt_noofyears" onchange="enabledOrgDetails(this);">
											<option value="">Select</option>
											<option value="Y">Yes</option>
											<option value="N">No</option>
										</select> <input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="128">&nbsp;  
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr id="idBranch">
										<td><b> Branch</b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" value="<%=Helper.correctNull((String)hshValues.get("strBranchUserCnt")) %>" style="text-align:right" size="15" maxlength="10"  onkeypress="allowInteger()"> 
										<input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="U001">
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr id="idCLPU">
										<td><b>CLPU/CLPH</b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" value="<%=Helper.correctNull((String)hshValues.get("strRLPCUserCnt")) %>" style="text-align:right" size="15" maxlength="10"  onkeypress="allowInteger()"> 
										<input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="U002">
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr id="idRO">
										<td><b> Regional Office</b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" value="<%=Helper.correctNull((String)hshValues.get("strROUserCnt")) %>" style="text-align:right" size="15" maxlength="10"  onkeypress="allowInteger()"> 
										<input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="U003">
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<tr id="idHO">
										<td><b> Head Office</b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" value="<%=Helper.correctNull((String)hshValues.get("strHOUserCnt")) %>" style="text-align:right" size="15" maxlength="10"  onkeypress="allowInteger()"> 
										<input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="U004">
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									
									<tr><td colspan="2" class="dataheader"> Minimum Class Rights for Approve MSME Modifications</td></tr>
									<tr>
										<td>&nbsp;</td>
										<td>
											<table border="0" cellspacing="0" cellpadding="0" width="100%"
											class="outertable">
											<tr align="center">
											<td width="50%">Creation</td>
											<td width="50%">Verification</td>
											</tr>
											</table>
										</td>
									</tr>
									
									
									<%a=41; %>
									<%
										if(arrRow!=null && arrRow.size()>0){ 
										for(int i=0;i<arrRow.size();i++){
										arrCol=(ArrayList)arrRow.get(i);
										
									%>
									<tr>
										<td><b><%=Helper.correctNull((String)arrCol.get(2)) %></b>&nbsp;</td>
										<td>
										<table border="0" cellspacing="0" cellpadding="0" width="100%"
									class="outertable">
									<tr>
										<td><select
											name="txt_noofyears"
											onChange=showDescClass(this,<%=++a %>)>
											<option value="">Select</option>
											<lapschoice:usersclass />
										</select> &nbsp;</td>
										
										<td><input type="text" name="txt_class_desc" size="35">
										<input type="hidden"  name="txt_id" value="M<%=Helper.correctNull((String)arrCol.get(3)) %>">&nbsp;
										
										<td><select
											name="txt_maxid"
											onChange=showDescClass1(this,<%=a %>)>
											<option value="">Select</option>
											<lapschoice:usersclass />
										</select> &nbsp;
										</td>
										<td>
										<input type="text" name="txt_class_desc1" size="35">
										</td>
										<td> <select name="txt_orgLevel" multiple>
											<option value="C">HEAD OFFICE</option>
											<option value="R">REGIONAL OFFICE</option>
											<option value="D">CLPU</option>
											<option value="A">BRANCH</option>
											</select> 
											<input type="hidden" name="hidtxt_orgLevel">
									 	</td>
									</tr>
								</table>
								</td>
									</tr>
									<%}} %>
									
									<tr>
										<td><b>BRANCH </b>&nbsp;</td>
										<td>
										<table border="0" cellspacing="0" cellpadding="0" width="100%"
									class="outertable">
									<tr>
										<td>
										<select name="txt_noofyears" onChange=showDescClass(this,<%=++a %>)>
											<option value="">Select</option>
											<lapschoice:usersclass />
										</select> &nbsp;</td>
										<td><input type="text" name="txt_class_desc" size="35">
										<input type="hidden"  name="txt_id" value="M004">&nbsp;
										</td>
										<td><select
											name="txt_maxid"
											onChange=showDescClass1(this,<%=a %>)>
											<option value="">Select</option>
											<lapschoice:usersclass />
										</select> &nbsp;
										</td>
										<td>
										<input type="text" name="txt_class_desc1" size="35">
										</td>
										<td> <select name="txt_orgLevel" multiple>
											<option value="C">HEAD OFFICE</option>
											<option value="R">REGIONAL OFFICE</option>
											<option value="D">CLPU</option>
											<option value="A">BRANCH</option>
											</select> 
											<input type="hidden" name="hidtxt_orgLevel">
									 	</td>
										</table>
										</td>
									</tr>
									<tr>
										<td><b>CLPU</b>&nbsp;</td>
										<td>
										<table border="0" cellspacing="0" cellpadding="0" width="100%"
									class="outertable">
									<tr>
										<td><select
											name="txt_noofyears"
											onChange=showDescClass(this,<%=++a %>)>
											<option value="">Select</option>
											<lapschoice:usersclass />
										</select> &nbsp;</td>
										<td><input type="text" name="txt_class_desc" size="35">
										<input type="hidden"  name="txt_id" value="M005">&nbsp;
										</td>
										<td><select
											name="txt_maxid"
											onChange=showDescClass1(this,<%=a %>)>
											<option value="">Select</option>
											<lapschoice:usersclass />
										</select> &nbsp;
										</td>
										<td>
										<input type="text" name="txt_class_desc1" size="35">
										</td>
										<td> <select name="txt_orgLevel" multiple>
											<option value="C">HEAD OFFICE</option>
											<option value="R">REGIONAL OFFICE</option>
											<option value="D">CLPU</option>
											<option value="A">BRANCH</option>
											</select> 
											<input type="hidden" name="hidtxt_orgLevel">
									 	</td>
									</tr>
									</table>
										</td>
									</tr>
									<tr>
										<td><b>RO</b>&nbsp;</td>
										<td>
										<table border="0" cellspacing="0" cellpadding="0" width="100%"
									class="outertable">
									<tr>
										<td><select
											name="txt_noofyears"
											onChange=showDescClass(this,<%=++a %>)>
											<option value="">Select</option>
											<lapschoice:usersclass />
										</select> &nbsp;</td>
										<td><input type="text" name="txt_class_desc" size="35">
										<input type="hidden"  name="txt_id" value="M006">&nbsp;
										</td>
										<td><select
											name="txt_maxid"
											onChange=showDescClass1(this,<%=a %>)>
											<option value="">Select</option>
											<lapschoice:usersclass />
										</select> &nbsp;
										</td>
										<td>
										<input type="text" name="txt_class_desc1" size="35">
										</td>
										<td> <select name="txt_orgLevel" multiple>
											<option value="C">HEAD OFFICE</option>
											<option value="R">REGIONAL OFFICE</option>
											<option value="D">CLPU</option>
											<option value="A">BRANCH</option>
											</select> 
											<input type="hidden" name="hidtxt_orgLevel">
									 	</td>
									</tr>
									</table>
										</td>
									</tr>
									
									<tr><td colspan="2" class="dataheader"> Minimum Class Rights for Approve Gold Loan Re-Appraisal Modifications</td></tr>
									<tr>
										<td>&nbsp;</td>
										<td>
											<table border="0" cellspacing="0" cellpadding="0" width="100%"
											class="outertable">
											<tr align="center">
											<td width="50%">Creation</td>
											<td width="50%">Verification</td>
											</tr>
											</table>
										</td>
											<tr>
										<td><b>BRANCH </b>&nbsp;</td>
										<td>
										<table border="0" cellspacing="0" cellpadding="0" width="100%"
									class="outertable">
									<tr>
										<td>
										<select name="txt_noofyears" onChange=showDescClass(this,<%=++a %>)>
											<option value="">Select</option>
											<lapschoice:usersclass />
										</select> &nbsp;</td>
										<td><input type="text" name="txt_class_desc" size="35">
										<input type="hidden"  name="txt_id" value="P006">&nbsp;
										</td>
										<td><select
											name="txt_maxid"
											onChange=showDescClass1(this,<%=a %>)>
											<option value="">Select</option>
											<lapschoice:usersclass />
										</select> &nbsp;
										</td>
										<td>
										<input type="text" name="txt_class_desc1" size="35">
										</td>
										<td> <select name="txt_orgLevel" multiple>
											<option value="C">HEAD OFFICE</option>
											<option value="R">REGIONAL OFFICE</option>
											<option value="D">CLPU</option>
											<option value="A">BRANCH</option>
											</select> 
											<input type="hidden" name="hidtxt_orgLevel">
									 	</td>
										</table>
										</td>
									</tr>
									<tr>
										<td><b> New Classification Validity in days</b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" value="<%=Helper.correctNull((String)hshValues.get("strMSMEExpiry")) %>" style="text-align:right" size="15" maxlength="10"  onkeypress="allowNumber(this)"> 
										<input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="131">
										<textarea  name="txt_maxid" cols="90" rows="5" onKeyPress="textlimit(this,499)" onKeyUp="textlimit(this,499)"><%=Helper.correctNull((String)hshValues.get("strMSMERemarks")) %></textarea>
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
									</tr>
									<!-- vindhya PAN check enable/disable begin-->
									<%a=47; %>
									<tr><td colspan="2" class="dataheader">PAN Mandatory</td></tr>
									<tr>
										<td><b> PAN Mandatory check Available</b>&nbsp;</td>
										<td><select
											name="txt_noofyears" onchange="enabledPANlimitDetails(this)">
											<option value="">Select</option>
											<option value="Y">Yes</option>
											<option value="N">No</option>
											</select>  &nbsp;
										<input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="132">
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel">
										</td>
									</tr>
									<tr id="idagrlimit">
										<td><b>Agriculture Limit</b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" onKeyPress="allowNumber(this)" 
										onblur="roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("stragrilimit")) %>" 
										style="text-align:right" size="15" maxlength="18"> 
										<input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="133">&nbsp;  
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
										</td>
									</tr>
									<tr id="idagrlimit1">
										<td><b>Agriculture Limit Other than Direct/Indirect</b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" onKeyPress="allowNumber(this)" 
										onblur="roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("stragrilimit2")) %>" 
										style="text-align:right" size="15" maxlength="18"> 
										<input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="136">&nbsp;  
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel"></td>
										</td>
									</tr>
									<tr id="idcorplimit">
										<td><b>Corporate Limit</b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" onKeyPress="allowNumber(this)" 
										onblur="roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("strcorplimit")) %>" 
										style="text-align:right" size="15" maxlength="18"> 
										<input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="134">&nbsp;  
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel">
										</td>
									</tr>
									<tr id="idretlimit">
										<td><b>Retail Limit</b>&nbsp;</td>
										<td><input type="text" name="txt_noofyears" onKeyPress="allowNumber(this)" 
										onblur="roundtxt(this);" value="<%=Helper.correctNull((String)hshValues.get("strretaillimit")) %>" 
										style="text-align:right" size="15" maxlength="18"> 
										<input type="hidden" name="txt_class_desc"><input type="hidden"  name="txt_id" value="135">&nbsp;  
										<input type="hidden"  name="txt_maxid" value="">
										<input type="hidden" name="txt_class_desc1">
										<input type="hidden" name="hidtxt_orgLevel">
										<input type="hidden" name="txt_orgLevel">
										</td>
									</tr>
									<!-- <tr>
										<td>&nbsp;</td>
										<td>
											<table border="0" cellspacing="0" cellpadding="0" width="100%"
											class="outertable">
											<tr align="center">
											<td width="50%">Creation</td>
											<td width="50%">Verification</td>
											</tr>
											</table>
										</td></tr>
										 <tr>
										<td><b>BRANCH </b>&nbsp;</td>
										<td>
										<table border="0" cellspacing="0" cellpadding="0" width="100%"
									class="outertable">
									<tr>
										<td>
										<select name="txt_noofyears" onChange=showDescClass(this,<%=++a %>)>
											<option value="">Select</option>
											<lapschoice:usersclass />
										</select> &nbsp;</td>
										<td><input type="text" name="txt_class_desc" size="35">
										<input type="hidden"  name="txt_id" value="133">&nbsp;
										</td>
										<td><select
											name="txt_maxid"
											onChange=showDescClass1(this,<%=a %>)>
											<option value="">Select</option>
											<lapschoice:usersclass />
										</select> &nbsp;
										</td>
										<td>
										<input type="text" name="txt_class_desc1" size="35">
										</td>
										<td> <select name="txt_orgLevel" multiple>
											<option value="C">HEAD OFFICE</option>
											<option value="R">REGIONAL OFFICE</option>
											<option value="D">CLPU</option>
											<option value="A">BRANCH</option>
											</select> 
											<input type="hidden" name="hidtxt_orgLevel">
									 	</td>
										</table>
										</td>
									</tr> -->
									<!-- vindhya PAN check enable/disable  end -->
								</table>
								</td>
									</tr>					
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidfrom" value="LP">
<input type="hidden" name="hidMaxcap_kbl" value="<%=Helper.correctNull((String)hshValues.get("strLASBankMargin"))%>">
<input type="hidden" name="hidMaxcap_oth" value="<%=Helper.correctNull((String)hshValues.get("strLASOtherMargin"))%>">

</form>
</body>
</html>
