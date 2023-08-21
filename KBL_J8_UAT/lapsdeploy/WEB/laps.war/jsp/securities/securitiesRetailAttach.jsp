<%@include file="../share/directives.jsp"%>
<%	
    String hidcitycontrol = Helper.correctNull((String)request.getParameter("hidcitycontrol"));
    String hidstatecontrol = Helper.correctNull((String)request.getParameter("hidstatecontrol"));
	String hidcitycodecontrol  = Helper.correctNull((String)request.getParameter("hidcitycodecontrol"));
	String hidstatecodecontrol = Helper.correctNull((String)request.getParameter("hidstatecodecontrol"));
	
	String hidzipcontrol = Helper.correctNull((String)request.getParameter("hidzipcontrol"));
	String hidzipvaildatorcontrol = Helper.correctNull((String)request.getParameter("hidzipvaildatorcontrol"));
	ArrayList arrValues=new ArrayList();
	
	if(hshValues!=null)
	{
		arrValues=(ArrayList)hshValues.get("arrCust");
	}
	
%>
<html>
<head>
<title>Securities Retail Attachment</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
		  document.forms[0].elements[i].disabled=val;		  
		}
		
	}
}
function callonLoad()
{
	disableFields(true);
}

function doClose()
{
 	window.close();
}
function enableType()
{
	if(document.forms[0].selchk.checked==true)
	{
	 document.forms[0].seltype.disabled=false;
	 document.forms[0].txt_existing.readOnly=false;	
	 document.forms[0].txt_proposed.readOnly=false;	
	}
	else
	{
		 document.forms[0].seltype.disabled=true;
		 document.forms[0].txt_existing.readOnly=true;	
		 document.forms[0].txt_proposed.readOnly=true;	
		
	}
  if(document.forms[0].selchk1.checked==true)
	 {
	 document.forms[0].seltype1.disabled=false;
	 document.forms[0].txt_existing1.readOnly=false;	
	 document.forms[0].txt_proposed1.readOnly=false;	
	 } 	  
  else
  {
	     document.forms[0].seltype1.disabled=true;
		 document.forms[0].txt_existing1.readOnly=true;	
		 document.forms[0].txt_proposed1.readOnly=true;
  }
}
function setValues1(value1,value2,value3,value4,value5,value6,value7)
{
	document.forms[0].hidzipdiffcode.value = value6+"~"+value7;
	document.forms[0].hidstatuscode.value = value5;
	window.opener.document.forms[0].elements["<%=hidcitycontrol%>"].value = value3;
	window.opener.document.forms[0].elements["<%=hidstatecontrol%>"].value = value4;
	window.opener.document.forms[0].elements["<%=hidcitycodecontrol%>"].value = value2;
	window.opener.document.forms[0].elements["<%=hidstatecodecontrol%>"].value = value5;
	//window.opener.zipcodeVaildate(window.opener.document.forms[0].txtcomcust_zip,document.forms[0].hidzipdiffcode,document.forms[0].hidstatuscode)
	//window.opener.document.forms[0].elements["<%=hidzipcontrol%>"].value = "";
	window.opener.document.forms[0].elements["<%=hidzipvaildatorcontrol%>"].value = value6+"~"+value7;
	window.close();
}
function setValues()
{

	  if(document.forms[0].selchk.checked==true && document.forms[0].selchk1.checked==false)
	  {
			window.opener.document.all.hid1.style.visibility="visible";
			window.opener.document.all.hid2.style.visibility="hidden";
			
	  }
	  if(document.forms[0].selchk1.checked==true && document.forms[0].selchk.checked==false)
	  {
		  
			window.opener.document.all.hid2.style.visibility="visible";
			window.opener.document.all.hid1.style.visibility="hidden";
	 }
	  if(document.forms[0].selchk1.checked==true && document.forms[0].selchk.checked==true)
	  {
		  window.opener.document.all.hid2.style.visibility="visible";
		  window.opener.document.all.hid2.style.position="relative";
		  
			window.opener.document.all.hid1.style.visibility="visible";
			  window.opener.document.all.hid1.style.position="relative";
				
	  }
	  if(document.forms[0].selchk1.checked==false && document.forms[0].selchk.checked==false)
	  {
		  
		  window.opener.document.all.hid2.style.visibility="hidden";
			window.opener.document.all.hid1.style.visibility="hidden";
	  }
		  
	
	//window.opener.document.forms[0].hidtype.value = val1;
	document.forms[0].action=appURL+"action/perfinancialinvst.jsp";
	document.forms[0].submit();
	window.close();
}
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad()" >
<form name="appform" method="post" class="normal">
<table width="98%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

<table width="98%" border="1" cellpadding="5" cellspacing="0"
	class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="1"
			class="outertable">
			<tr>
				<td>

				
				</td>
			</tr>
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="1" cellpadding="3"
							class="outertable linebor">
							<tr class="dataheader">
							<td>&nbsp;</td>
								<td width="10%" align="center" valign="top" >Security Id</td>
						<td  align="center" valign="top">Security Type</td>
						<td  align="center" valign="top">Security Classification</td>
						<td  align="center" valign="top">Security Description</td>
						<td  align="center" valign="top">Security value</td>
						<td  align="center" valign="top">Type</td>
						<td  align="center" valign="top">Existing</td>
						<td  align="center" valign="top">Proposed</td>
						
							</tr>
						<tr valign="top" class="datagrid">
						<td><input type="checkbox" name="selchk" style="border:none" onclick="enableType()" ></td>
						<td>120001</td>
						<td>Bank Deposit</td>
						<td>Bank Deposits-FD</td>
						<td>Fixed Deposit</td>
						<td style="text-align:right">50000.00</td>
						<td align="right"><select name="seltype" ><option value="0">select</option><option value="1">Primary</option><option value="2">Collateral</option> </select></td>
						<td align="right"><input type="text" name="txt_existing"  value="25000.00" style="text-align:right"></td>
						<td align="right"><input type="text" name="txt_proposed" value="750000.00" style="text-align:right"></td>
						</tr>
						<tr valign="top" class="datagrid">
						<td><input type="checkbox" name="selchk1" style="border:none" onclick="enableType()" ></td>
						<td>120002</td>
						<td>Plant&Machinery</td>
						<td>Irrigation Equipment</td>
						<td>Farm Machinery</td>
						<td style="text-align:right">150000.00</td>
						<td align="right"><select name="seltype1" ><option>select</option><option value="1">Primary</option><option value="2">Collateral</option> </select></td>
						<td align="right"><input type="text"  name="txt_existing1" value="50000.00" style="text-align:right"></td>
						<td align="right"><input type="text"  name="txt_proposed1" value="650000.00" style="text-align:right"></td>
			
						
					</tr>
						</table>
						</td>
					</tr>
					<tr>

					
						<table width="10%" border="0" cellspacing="0" cellpadding="3"
							align="center">
							<tr valign="top">
								<td width="20%" >
								<input type="button" name="cmdOk"	value="Ok" class="buttonStyle" style="width:75"	onClick="setValues()" >
								</td>
								<td>
								<input type="button" name="cmdClose"	value="Close" class="buttonStyle" style="width:75"	onClick="doClose()" >
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


<input type="hidden" name="hidcitycontrol"
	value="<%=Helper.correctNull((String)request.getParameter("hidcitycontrol")) %>">
<input type="hidden" name="hidstatecontrol"
	value="<%=Helper.correctNull((String)request.getParameter("hidstatecontrol")) %>">

<input type="hidden" name="hidcitycodecontrol"
	value="<%=Helper.correctNull((String)request.getParameter("hidcitycodecontrol")) %>">
<input type="hidden" name="hidstatecodecontrol"
	value="<%=Helper.correctNull((String)request.getParameter("hidstatecodecontrol")) %>">

<input type="hidden" name="hidzipcontrol"
	value="<%=Helper.correctNull((String)request.getParameter("hidzipcontrol")) %>">
<input type="hidden" name="hidzipvaildatorcontrol"
	value="<%=Helper.correctNull((String)request.getParameter("hidzipvaildatorcontrol")) %>">
<input type="hidden" name="hidzipdiffcode" value="">
<input type="hidden" name="hidstatuscode" value="">	
<INPUT TYPE="hidden" name="hidtype" value=""> 
<lapschoice:hiddentag /> <input type="hidden" name="state_id"
	value="<%=Helper.correctNull((String)hshValues.get("strStatId"))%>">


<br>
</form>
</body>
</html>
