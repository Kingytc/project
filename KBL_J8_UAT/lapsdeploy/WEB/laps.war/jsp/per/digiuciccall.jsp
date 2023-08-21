<%@include file="../share/directives.jsp"%>
<% //out.println(hshValues); %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>DIGI_UCIC</title>
<%
String strCust1="",strCust2="",strCust3="",strCust4="",strCust5="";
String strCustId1 = Helper.correctNull((String) hshValues.get("strCustId1"));
String strCustName1 = Helper.correctNull((String) hshValues.get("strCustName1"));
strCust1 = strCustId1+"-"+strCustName1;

String strCustId2 = Helper.correctNull((String) hshValues.get("strCustId2"));
String strCustName2 = Helper.correctNull((String) hshValues.get("strCustName2"));
strCust2 = strCustId2+"-"+strCustName2;

String strCustId3 = Helper.correctNull((String) hshValues.get("strCustId3"));
String strCustName3 = Helper.correctNull((String) hshValues.get("strCustName3"));
strCust3 = strCustId3+"-"+strCustName3;

String strCustId4 = Helper.correctNull((String) hshValues.get("strCustId4"));
String strCustName4 = Helper.correctNull((String) hshValues.get("strCustName4"));
strCust4 = strCustId4+"-"+strCustName4;

String strCustId5 = Helper.correctNull((String) hshValues.get("strCustId5"));
String strCustName5 = Helper.correctNull((String) hshValues.get("strCustName5"));
strCust5 = strCustId5+"-"+strCustName5;

%>
<script>
var appstatus="<%=Helper.correctNull((String)hshValues.get("strappstatus"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varGrpRights="<%=(Helper.correctNull((String)session.getAttribute("strGroupRights"))).charAt(18)%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var hidborrowerid="<%=Helper.correctNull((String)hshValues.get("hidborrowerid"))%>";
var varcbsid1 ="<%=Helper.correctNull((String) hshValues.get("strCustId1"))%>" ;
var varcbsid2 ="<%=Helper.correctNull((String) hshValues.get("strCustId2"))%>" ;
var varcbsid3 ="<%=Helper.correctNull((String) hshValues.get("strCustId3"))%>" ;
var varcbsid4 ="<%=Helper.correctNull((String) hshValues.get("strCustId4"))%>" ;
var varcbsid5 ="<%=Helper.correctNull((String) hshValues.get("strCustId5"))%>" ;
var varcbsid ="<%=Helper.correctNull((String) hshValues.get("strCustomerID"))%>" ;
var varcbsflag ="<%=Helper.correctNull((String) hshValues.get("strcbscustflag"))%>" ;
var varcbsdedupeflag ="<%=Helper.correctNull((String) hshValues.get("strdedupflag"))%>" ;

</script>
<script  LANGUAGE="JavaScript">
function doClose()
{
	window.close();
}


function onloading()
{
	if(varcbsid != "" && varcbsflag == "Y" && varcbsdedupeflag =="Y")
	{
		alert("CBS ID Updated..Please click retry for update cbs id");
		opener.location.reload();
		window.close();
	}

	 if(varcbsflag != "Y" && varcbsid1 =="NULL" && varcbsid2 =="NULL" && varcbsid3 =="NULL" && varcbsid4 =="NULL" && varcbsid5 =="NULL")
	{
		alert("No CBS Id Found..! Please click Retry and proceed with Create cbs id");
		parent.frames.document.forms[0].ucicEnable.value = document.forms[0].ucicEnable.value;
		opener.location.reload();
		window.close();
	}


	 if(varcbsflag != "Y" && varcbsid1 =="NULL" && varcbsid2 =="NULL" && varcbsid3 =="NULL" && varcbsid4 =="NULL" && varcbsid5 =="NULL")
		{
			 document.all.hidd.style.visibility = "hidden";
			 document.all.hidd.style.position = "absolute";

			 document.all.hiddB.style.visibility = "hidden";
			 document.all.hiddB.style.position = "absolute";
				
		}else{

			document.all.hidd.style.visibility = "visible";
			document.all.hidd.style.position = "relative";
				
			document.all.hiddB.style.visibility = "visible";
			document.all.hiddB.style.position = "relative";
		}
}
function doSave()
{

	var varselctcbsid ="";

	<% if(!Helper.correctNull((String) hshValues.get("strCustId1")).equalsIgnoreCase("NULL")){%>
	if(document.forms[0].chk_cbsid.checked==true) 
    {
		varselctcbsid=varcbsid1;
    }
	<%}if(!Helper.correctNull((String) hshValues.get("strCustId2")).equalsIgnoreCase("NULL")){%>
    else if(document.forms[0].chk_cbsid.checked==true) 
    {
    	varselctcbsid=varcbsid2;
    	
    }
    <%}if(!Helper.correctNull((String) hshValues.get("strCustId3")).equalsIgnoreCase("NULL")){%>
    else if(document.forms[0].chk_cbsid.checked==true) 
    {
    	varselctcbsid=varcbsid3;
    	
    }
    <%}if(!Helper.correctNull((String) hshValues.get("strCustId4")).equalsIgnoreCase("NULL")){%>
    else if(document.forms[0].chk_cbsid.checked==true) 
    {
    	varselctcbsid=varcbsid4;
    	
    }
    <%}if(!Helper.correctNull((String) hshValues.get("strCustId5")).equalsIgnoreCase("NULL")){%>

    else if(document.forms[0].chk_cbsid.checked==true) 
    {
    	varselctcbsid=varcbsid5;
    }
	<%}%>
	document.forms[0].hidAction.value="Save";
	document.forms[0].hidborrowerid.value=hidborrowerid;
	document.forms[0].selctuciccbsid.value=varselctcbsid;
	document.forms[0].hidBeanId.value="DigitalAppInterface";
	document.forms[0].hidBeanGetMethod.value="UCICExecuteService";
	document.forms[0].action=appURL+"action/digiuciccall.jsp";
	document.forms[0].submit();
}
</script>
</head>
<body onLoad="onloading()">
<form method="post" class="normal">
<span style=":display:none;">
<lapschoice:borrowertype /></span><lapschoice:application />
<br/><table width="80%" border="1" cellspacing="0" cellpadding="0" class="outertable" align="center" id="hidd">

<tr align="center">
	<td class="datagrid" ><b><td class="datagrid" ><b>Applicant's Mobile No/PAN/Aadhaar are matching with already existing below CBS ID's.
Please dedupe the same in CRM if CBS ID is not related to applicant and then proceed.<br/>Only If below CBS ID belongs to Applicant then click confirm.</b></td></b></td>
</tr>
<tr><td>
<table class="outertable" align="center">
<% if(!(Helper.correctNull((String) hshValues.get("strCustId1")).equalsIgnoreCase("NULL")|| Helper.correctNull((String) hshValues.get("strCustId1")).equalsIgnoreCase("NULL"))){%>
<tr align="center"><td><input type="radio" name="chk_cbsid" style='border=none' value="<%=Helper.correctNull((String) hshValues.get("strCustId1"))%>"></td><td><%=strCust1%></td></tr>	
<%}if(!Helper.correctNull((String) hshValues.get("strCustId2")).equalsIgnoreCase("NULL")){%>
<tr align="center"><td><input type="radio" name="chk_cbsid" style='border=none' value="<%=Helper.correctNull((String) hshValues.get("strCustId2"))%>"></td><td><%=strCust2%></td></tr>
<%}if(!Helper.correctNull((String) hshValues.get("strCustId3")).equalsIgnoreCase("NULL")){%>
<tr align="center"><td><input type="radio" name="chk_cbsid" style='border=none' value="<%=Helper.correctNull((String) hshValues.get("strCustId3"))%>"></td><td><%=strCust3%></td></tr>
<%}if(!Helper.correctNull((String) hshValues.get("strCustId4")).equalsIgnoreCase("NULL")){%>
<tr align="center"><td><input type="radio" name="chk_cbsid" style='border=none' value="<%=Helper.correctNull((String) hshValues.get("strCustId4"))%>"></td><td><%=strCust4%></td></tr>
<%}if(!Helper.correctNull((String) hshValues.get("strCustId5")).equalsIgnoreCase("NULL")){%>
<tr align="center"><td><input type="radio" name="chk_cbsid" style='border=none' value="<%=Helper.correctNull((String) hshValues.get("strCustId5"))%>"></td><td><%=strCust5%></td></tr><%}%>	
</table></td></tr>
</table><br/>
<table align="center" id="hiddB">
<tr>
	<td><input type="button" class="buttonOthers" name="cmd_save" value="Save" onclick="doSave()"></td>
	<td><input type="button" class="buttonClose" name="cmd_close" value="Close" onclick="doClose()"></td>
</tr>
</table>
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidAction">
<input type="hidden" name="hidBeanGetMethod">
<input type="hidden" name="hidborrowerid">
<input type="hidden" name="selctuciccbsid">
<input type="hidden" name="hidSourceUrl">
<input type="hidden" name="ucicEnable" value="Y">

</form>
</body>
</html>