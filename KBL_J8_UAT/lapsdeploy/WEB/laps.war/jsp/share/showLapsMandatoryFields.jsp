<%@ page import="java.util.*,com.sai.laps.helper.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
 <%
  ArrayList arrCBSNotFilledMandatoryFields=null;
  int intCBSNotFilledMandatoryFieldsSize=0;
  String strPage=Helper.correctNull((String)hshValues.get("page_name"));
   arrCBSNotFilledMandatoryFields=(ArrayList)hshValues.get("keyArrCBSNotFilledMandatoryFields");
   if(arrCBSNotFilledMandatoryFields!=null)
   {
   intCBSNotFilledMandatoryFieldsSize=arrCBSNotFilledMandatoryFields.size();
   }
  %>

<html>
 <head>
 <title>LAPS MANDATORY FIELDS</title>
 <link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>htm/link.css" type="text/css">
 <link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
 <script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
 <script>
 function fnPageClose()
 {
    if(ConfirmMsg('100'))
	{
    	<%if(strPage.equalsIgnoreCase("corporate"))
    	{%>
    		document.forms[0].action=appURL+"action/comappmastersearch.jsp";
    	<%}else{%>
		document.forms[0].action=appURL+"action/mastersearchper.jsp";
		<%}%>
		document.forms[0].submit();
		
	}
 }	
 var appURL = "<%=ApplicationParams.getAppUrl()%>";
 </script>
</head>

 <body  text="#000000">
 <form>
 <br>
 <br>
 <table width="70%" border="0"  align="center" class="outertable border1"
	>
  <tr class="dataheader">
    <td>LAPS MANDATORY FIELDS</td>
  </tr>
  <tr> 
    <td>
	   <table width="100%" >
	   <tr class="datagrid">
	      <td width="22%"><b>CBS CUSTOMER ID :</b></td>
	      <td width="15%"><%=Helper.correctNull((String)hshValues.get("keyCBSID"))%>&nbsp;</td>
	      <td width="25%"><b>CBS CUSTOMER NAME :</b></td>
	      <td width="30%"><%=Helper.correctNull((String)hshValues.get("keyCBSCustomerName"))%>&nbsp;</td>
       </tr>
	   </table>
	</td>
  </tr>
  <tr class="dataheader">
    <td> Following Mandatory Fields has to be filled in CBS/LAPS for further processing 
      in LAPS</td>
  </tr>
 
 <%
 if(intCBSNotFilledMandatoryFieldsSize>0)
 {
	 for(int i=0;i<intCBSNotFilledMandatoryFieldsSize;i++)
	 {
 %>
 <tr class="datagrid">
 <td>&nbsp;&nbsp;&nbsp;&nbsp;<%=(i+1)%>.&nbsp;&nbsp;<%=arrCBSNotFilledMandatoryFields.get(i)%></td>
 </tr>
 <%
	 }//for
 }//if	  
 %>
 <tr><td>&nbsp;</td></tr>
 <tr>
 <td align="center"><input type="button" value="Close" onClick="fnPageClose()" class="buttonClose" ></td>
 </tr>
  
</table>
</form>
 </body>

</html>