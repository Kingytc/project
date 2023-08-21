<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
 // out.println("hhhh"+hshValues);

 
  ArrayList arrcomdate= (ArrayList)hshValues.get("arrcomdate");
  ArrayList arrcomid=(ArrayList)hshValues.get("arrcomid");
  String bname=Helper.correctNull((String)hshValues.get("bname"));
  String appno=Helper.correctNull((String)hshValues.get("appno"));
%>
<html>
<head>
<script>


  function callPage(id,bdate,bname,appno)
  {
	 
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/com_insrep_page1.jsp?hidMethod=getGeneralDetails&hidparam=PurposeofInspection^DateofSubmissionofReport^DateofInspection^Name^Name1^Designation^Designation1^DateoflastInspection^CreditRatingason^GodownsAddress&hidTabName=INSPECTIONREPORTFIRST&otherGetMethod=proposal&txt_id="+id+"&txt_insdate="+bdate+"&bname="+bname+"&appno="+appno;
	//alert(document.forms[0].action);
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
  }
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body bgcolor="#EEEAE3" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="srchform" method ="post">
  <table width="100%" border="0" cellspacing="1" cellpadding="3" bordercolorlight="#EBEBF8" bordercolordark="#82829F">
    <% for(int i=0;i<arrcomdate.size();i++){ %>
    <tr > 
      <td width="25%"><a href="javascript:callPage('<%=arrcomid.get(i)%>','<%=arrcomdate.get(i)%>','<%=bname %>','<%=appno %>')" class="blackfont"><font size="1" face="MS Sans Serif"><b>&nbsp;&nbsp;<%=arrcomdate.get(i)%></b></font></a></td>
      
    </tr>
    <%}%>
  </table>




</form>
</body>
</html>


  