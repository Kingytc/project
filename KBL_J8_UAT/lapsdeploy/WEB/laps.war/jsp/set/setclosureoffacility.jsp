<%@ include file="../share/directives.jsp"%>
<%
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
arrRow=(ArrayList)hshValues.get("arrRow");
int intLen=0;
if(arrRow!=null)
	intLen=arrRow.size();
%>
<html>
<head>
<title>Application Transfer</title>
<script  LANGUAGE="JavaScript">
var appURL ="<%=ApplicationParams.getAppUrl()%>";
function loadPage()
{
	document.forms[0].cmdclosefacility.disabled=true;
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}	
}

function selectValues(varloantype,varappno,varsno,varflag,varnewappcheck,varAdhocchk)
{
	document.forms[0].hidloantype.value=varloantype;
	document.forms[0].hidAppno.value=varappno;
	document.forms[0].hidsno.value=varsno;
	document.forms[0].hidsublimchk.value=varflag;
	document.forms[0].txtremarks.value="";

	document.all.idreamrks.style.display="table";
	document.forms[0].cmdclosefacility.disabled=false;

	if(varnewappcheck!="0")
	{
		alert("Application has Renewal/Restructured/Post Sanction application in open/pending Status");
		document.forms[0].cmdclosefacility.disabled=true;
	}
	else
	{
		document.forms[0].cmdclosefacility.disabled=false;
	}
	if(varAdhocchk=="Y")
	{
		alert("You cannot close this facility.Additional/Adhoc Facilities in Pending/Lodged/Approved Status.");
		document.forms[0].cmdclosefacility.disabled=true;
	}
	else
	{
		document.forms[0].cmdclosefacility.disabled=false;
	}
}
function doCloseFacility()
{
	if(document.forms[0].hidsublimchk.value=="Y")
	{
		alert("You cannot close this facility.Please close all the sublimits for this Main-Limit.");
		return;
	}
	if(document.forms[0].txtremarks.value=="")
	{
		alert("Please Enter Remarks");
		document.forms[0].txtremarks.focus();
		return;
	}
	if(confirm("Do you want to close this facility"))
	{
	document.forms[0].hidBeanId.value="facilities";
    document.forms[0].hidBeanGetMethod.value="getClosureFacilities";
    document.forms[0].hidBeanMethod.value="UpdateClosureFacilities";
    document.forms[0].hidSourceUrl.value="/action/setclosureoffacility.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	}
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad ="loadPage()" >
<form method="post" class="normal">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr>
            <td class="page_flow">Home -&gt; Closure of Facilities</td>
          </tr>
        </table>
        <br><br>
        <table width="97%" border="0" cellspacing="0" cellpadding="0" class="outertable border1" align="center">
        <tr>
        <td>
         <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center" style="border-left: 0px;border-right: 0px;border-bottom: 0px;">
         <tr  class="datagrid">
          <td colspan="3"><b>Customer ID:&nbsp;&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("strcbsid")) %></b>
          <input type="hidden" name="hidcbsid" value="<%=Helper.correctNull((String)hshValues.get("strcbsid")) %>"></td>
          <td colspan="3"><b>Customer Name:&nbsp;&nbsp;&nbsp; <%=Helper.correctNull((String)hshValues.get("strAppname")) %>&nbsp;</td>
          <td colspan="3"><b>Applicant ID:&nbsp;&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("strAppID")) %>
          <input type="hidden" name="appoldid" value="<%=Helper.correctNull((String)hshValues.get("strAppID")) %>"></td>
          </tr>
          <tr align="center" class="dataheader">
          <td align="center" width="5%">&nbsp;</td>
          <td align="center" width="10%">Application No</td>
          <td align="center"  width="5%">Sno</td>
          <td align="center"  width="10%">CBS Account No</td>
          <td align="center"  width="25%">Facility Description</td>
          <td align="center"  width="10%">Sanctioned Limit</td>
          <td align="center"  width="10%">Loan Type</td>
          <td align="center"  width="10%">Facility Type</td>
          <td align="center"  width="10%">Process Date</td>
          </tr>
          <%if(arrRow!=null && arrRow.size()>0){ 
          for(int i=0;i<arrRow.size();i++){
        	  arrCol=(ArrayList)arrRow.get(i);%>
        	  <tr 
        	  <%if(i%2==0){ %>
        	  class="datagrid"
        	  <%}else{ %>
        	  class="datagridnew"
        	  <%} %>>
        	  
        	  <%if(Helper.correctNull((String)arrCol.get(8)).equalsIgnoreCase("0")){%>
        	  <td><input type="radio" name="chk" onclick="selectValues('<%=Helper.correctNull((String)arrCol.get(0)) %>','<%=Helper.correctNull((String)arrCol.get(1)) %>','<%=Helper.correctNull((String)arrCol.get(2)) %>','<%=Helper.correctNull((String)arrCol.get(9)) %>','<%=Helper.correctNull((String)arrCol.get(11)) %>','<%=Helper.correctNull((String)arrCol.get(12)) %>')" style="border: none;">&nbsp;</td>
        	  <td align="center"><b><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</font></b></td>
        	  <td align="center"><b><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(2)) %>&nbsp;</font></b></td>
        	  <td><b><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(5)) %>&nbsp;</font></b></td>
        	  <td><b><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(3)) %>&nbsp;</font></b></td>
        	  <td align="right"><b><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(4)) %>&nbsp;</font></b></td>
        	  <td><b><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(10)) %>&nbsp;</font></b></td>
        	  <td align="center"><b><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(7)) %>&nbsp;</font></b></td>
        	  <td align="center"><b><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(6)) %>&nbsp;</font></b></td>
        	  <%} else{%>
        	  <td><input type="radio" name="chk" onclick="selectValues('<%=Helper.correctNull((String)arrCol.get(0)) %>','<%=Helper.correctNull((String)arrCol.get(1)) %>','<%=Helper.correctNull((String)arrCol.get(2)) %>','<%=Helper.correctNull((String)arrCol.get(9)) %>','<%=Helper.correctNull((String)arrCol.get(11)) %>','<%=Helper.correctNull((String)arrCol.get(12)) %>')" style="border: none;">&nbsp;</td>
        	  <td align="center"><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</font></td>
        	  <td align="center"><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(2)) %>&nbsp;</font></td>
        	  <td><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(5)) %>&nbsp;</font></td>
        	  <td><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(3)) %>&nbsp;</font></td>
        	  <td align="right"><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(4)) %>&nbsp;</font></td>
        	  <td><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(10)) %>&nbsp;</font></td>
        	  <td align="center"><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(7)) %>&nbsp;</font></td>
        	  <td align="center"><font color="#3f3f40"><%=Helper.correctNull((String)arrCol.get(6)) %>&nbsp;</font></td>
        	  <%} %>
        	  </tr>
          <%}}else{ %>
          <tr  class="datagrid">
          <%for(int i=0;i<9;i++){ %>
          <td>&nbsp;</td>
          <%} %>
          </tr>
          <tr  class="datagrid">
          <td colspan="9" align="center"> - No Record Found - &nbsp;</td>
          </tr>
          <tr  class="datagrid">
           <%for(int i=0;i<9;i++){ %>
          <td>&nbsp;</td>
          <%} %>
          </tr>
          <%} %>
        </table>
        </td>
        </tr>
        <tr>
        <td>
         <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center" style="border-left: 0px;border-right: 0px;border-bottom: 0px;display: none;" id="idreamrks" >
         <tr>
         <td width="10%" align="right">Remarks</td>
         <td align="center"><textarea name="txtremarks" cols="150" rows="5" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ></textarea></td>
         </tr>
         </table>
		</td>
        </tr>
        </table>
  

  <lapschoice:combuttonnew btnnames='Close Facility'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	  <lapschoice:hiddentag pageid="<%=PageId%>"/> 
	  <input type="hidden" name="hidloantype">
	  <input type="hidden" name="hidAppno">
	  <input type="hidden" name="hidsno">
	  <input type="hidden" name="hidsublimchk">
</form>
</body>
</html>