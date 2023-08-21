<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
ArrayList g1 =  new ArrayList();
%>
<html>
<head>
<style type="text/css">

DIV.cellcontainer 
{	
  width: 100%; height: 200;
  overflow: auto;
}
</style>

<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<SCRIPT LANGUAGE="JavaScript">
function getSelectedValue(val1,val2)
{
	//-->existing code :// window.opener.document.appform.txt_userid.value=val2;
	//-->existing code :// window.opener.document.appform.appraisedby.value=val1;
     
	window.opener.document.forms[0].appraisedby.value=val1;
	
	window.opener.document.forms[0].txt_userid.value=val2;
	window.opener.document.forms[0].txt_userid.readOnly = true;
	window.opener.document.forms[0].appraisedby.readOnly = true;
	window.close();
	
	window.opener.document.forms[0].txtverf_doneby.value=val1;
	window.opener.document.forms[0].txtverf_doneby.readOnly = true;
	window.close();
	
}
  </SCRIPT>
  <link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body >
<form name="userlist" method="post"><table width="95%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable border1" > 
<tr> <td> <br> <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertablecolor" align="center" > 
<tr> <td ALIGN="CENTER"><b>SELECT USER </b> <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable" > 
<tr> <td> <table width="97%" border="0" cellspacing="1" cellpadding="3" > <tr class="dataheader"> 
<td width="15%"><b>Sl. No.</b></td><td width="85%"><b>User Name </b></td></tr> 
</table></td></tr> </table><div class="cellcontainer"> <table width="100%" border="0" cellspacing="1" cellpadding="3"> 
<% 
 				ArrayList	v = (ArrayList) hshValues.get("vecRow");
				if(v!=null)
				{					
					int vecsize =v.size();
					for(int l=0;l<vecsize;l++)
					{							
						g1 = (ArrayList)v.get(l);
						%> <tr valign="top"  class="datagrid"> <td  width="15%" align="left"> 
<%=l+1%>&nbsp;</td><td width="85%" align="left" ><a href="javascript:getSelectedValue('<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)g1.get(1))%>')"align="center"><b><%=Helper.correctNull((String)g1.get(0))%></b></a></td></tr> 
<%
				          	}
						}
					%> 

</table></div></table></td></tr> </table><br> <table width="10%" border="0" cellspacing="0" cellpadding="3" align="center"> 
<tr valign="top"> <td width="20%"> <input type=button class="buttonClose" value="Close" name="closebtn" tabindex="25"  onClick=window.close()> 
</td></tr> </table><input type ="hidden" name="svalue" value="<%=Helper.correctNull((String)hshValues.get("usr_lname"))%>"> 
<input type ="hidden" name="stype" value="<%=Helper.correctNull((String)hshValues.get("usr_id"))%>"> 
<input type ="hidden" name="hidBeanId"> <input type ="hidden" name="hidBeanGetMethod"> 
</form>
</body>
</html>
