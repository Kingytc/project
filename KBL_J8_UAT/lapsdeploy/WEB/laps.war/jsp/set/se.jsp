<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<lapschoice:handleerror />

<%


   if(objValues instanceof java.util.HashMap)
   {
	  
	   hshValues=(java.util.HashMap)objValues;

   }

String strFormType =request.getParameter("optformtype");
ArrayList vecVal = (ArrayList)hshValues.get("vecVal");
ArrayList vecR = null;
int count =0;

%>

<html>
<head>
<title>Application - MailBox</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 800; height: 200;
  overflow: auto;
}

</STYLE>

<script>


  function callAppPage(appno,cname,status)
  {
	  if("<%=strFormType%>"=="P")
	  {
		  gotoPersonal(appno,cname,status);
	  }
	  if("<%=strFormType%>"=="C")
	  {
		  gotoCommercial(appno,cname,status);
	  }
  }

  function gotoCommercial(appno,cname,status)
  {
	  document.mails.appno.value=appno;
	  document.mails.appname.value=cname;
	  document.mails.appstatus.value=status;
	  document.mails.action="<%=ApplicationParams.getAppUrl()%>action/comloanproduct.jsp";
	  document.mails.target="mainFrame"
	  document.mails.submit();
  }



function gotoPersonal(appno,cname,status)
{
	var appstatus = status;
	//document.forms[0].hidAppType.value="";
	document.forms[0].appno.value=appno;
	document.forms[0].hidBeanId.value="perapplicant";
	document.forms[0].hidBeanGetMethod.value="getLoanProducts";
document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perloandetails.jsp?appstatus="+appstatus+"&hidBeanId=perapplicant&page=ep&radLoan=Y";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}
function menuOptionDivMouseDown (url) {
		//if (! isMac) {
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			//window.location=url;
			document.forms[0].action=url;
			document.forms[0].submit();
			//}
		}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>

<body bgcolor="#EEEAE3" text="#000000"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
<form name="mails" method="post">
<input type="hidden" name="optformtype" >
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidSourceUrl">
  <table width="100%" border="0" cellspacing="1" cellpadding="2" bgcolor="#FFFFFF" align="center" bordercolorlight="#EBEBF8" bordercolordark="#82829F">
    <%
  if(vecVal!=null)
  {
	  for(int i=0;i<vecVal.size();i++)
	  {
			vecR = new ArrayList();
			vecR  =(ArrayList)vecVal.get(i);


  %>
    <tr> 
      <td width="13%"><a href="javascript:callAppPage('<%=vecR.get(0)%>','<%=vecR.get(1)%>','<%=vecR.get(4)%>')" class="blackfont"><font size="1" face="MS Sans Serif" color="#000000"><b><%=vecR.get(0)%></b></font></a></td>
      <td width="22%"><font size="1" face="MS Sans Serif" color="#000000"><%=vecR.get(1)%></font></td>
      <td width="12%"><font size="1" face="MS Sans Serif" color="#000000"><%=vecR.get(2)%></font></td>
      <td width="17%"><font size="1" face="MS Sans Serif" color="#000000"><%=vecR.get(3)%></font></td>
      <td width="14%"><font size="1" face="MS Sans Serif" color="#000000"><%=vecR.get(4)%></font></td>
      <td width="12%"><font size="1" face="MS Sans Serif" color="#000000"><%=vecR.get(5)%></font></td>
      <td width="10%"><font size="1" face="MS Sans Serif" color="#000000"><%=vecR.get(6)%></font></td>
    </tr>
    <%
	  }
  }
%>
  </table>
  <div align="center"> <br>
  </div>
<input type="hidden"  name="appno">
<input type="hidden" name="appname">
<input type="hidden" name="appstatus">
  <input type="hidden" name="hidBeanGetMethod" value="getLoanProducts">
</form>
</body>
</html>
