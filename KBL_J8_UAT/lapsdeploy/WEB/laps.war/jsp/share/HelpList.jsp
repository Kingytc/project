<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />
<%
//out.println("hshValues==>"+hshValues);
ArrayList g1 =  new ArrayList();
String strFromLink = Helper.correctNull((String)request.getParameter("strfrom"));
String strpagefrom = Helper.correctNull((String)request.getParameter("pagefrom"));
%>
<html>
<title>LAPS ::: Help List</title>
<head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<SCRIPT LANGUAGE="JavaScript">	
var from_link = "<%=strFromLink%>";	
var appURL = "<%=ApplicationParams.getAppUrl()%>";
	
function getSelectedValue(val1,val2,val3)
{

	window.opener.document.forms[0].txt_helpKey_no.value = val1;
	window.opener.document.forms[0].hid_helpKey_no.value = val1;
	window.opener.document.forms[0].hidAction.value = "Edit";
	window.opener.document.forms[0].hidBeanId.value = "lapshelp";
	window.opener.document.forms[0].hidBeanMethod.value = "getData";
	window.opener.document.forms[0].hidBeanGetMethod.value = "getData";
	window.opener.document.forms[0].hidSourceUrl.value="/action/Helpdesc.jsp";
	window.opener.document.forms[0].action=appURL+"controllerservlet";
	window.opener.document.forms[0].submit();
	window.close();
}
	
</SCRIPT>
</head>
<body bgcolor="#EEEAE3" text="#000000" >
	<form name="productlisthelp" method="post">
  <br>
  <table width="95%" border="0" class="outertable border1" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertablecolor" align="center">
          <tr> 
            <td><font face="sans-serif" size="2"><b>
              </b></font> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td> 
                    <table width="97%" border="0" cellspacing="1" cellpadding="3">
                      <tr class="dataheadcolor"> 
                        <td width="25%"><b><font face="MS Sans Serif" size="1">Help 
                          Key No.</font></b></td>
                        <td width="75%"><font face="MS Sans Serif" size="1"><b>Screen 
                          Name </b></font></td>
                      </tr>
                     
                    </table>
                  </td>
                </tr>
              </table>
              <div class="cellcontainer"> 
                <table width="100%" border="0" cellspacing="1" cellpadding="3">
<% 
				String bgcol= "";
 				ArrayList	v = (ArrayList) hshValues.get("vecData");
			  //out.println("v==="+v);
			    String inside="N";
				if(v!=null)
				{
				int vecsize =v.size();
				//out.println("vecsize"+vecsize);
				for(int l=0;l<vecsize;l++)
				{ 
					inside ="Y";
					g1 = (ArrayList)v.get(l);
					  if(bgcol.equals("#F0F0FF"))
								{
								bgcol = "#FFFFFF";
								}
								else
								{
								bgcol ="#F0F0FF";
								} 
				%>
			                  <tr valign="top" class="datagridcolor"> 
			                    <td  width="25%" align="left"> &nbsp;&nbsp;<font size="1" face="MS Sans Serif" color="#000000">
			                    <a href="javascript:getSelectedValue('<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)g1.get(2))%>','<%=Helper.correctNull((String)g1.get(3))%>')" class="blackfont" align="center"><b><%=Helper.correctNull((String)g1.get(0))%>&nbsp;</b></a></font></td>
			                    <td width="75%" align="left" ><font size="1" face="MS Sans Serif" color="#000000" align="center"><%=Helper.correctNull((String)g1.get(3))%>&nbsp;</font></td>
			                  </tr>
			                  <%
					  }
			}
	%>
	 <tr class="datagridcolor">
                        <td width="25%">&nbsp;</td>
                        <td width="75%">&nbsp;</td>
                      </tr>
					   <tr class="datagridcolor">
                        <td width="25%">&nbsp;</td>
                        <td width="75%">&nbsp;</td>
                      </tr>
					   <tr class="datagridcolor">
                        <td width="25%">&nbsp;</td>
                        <td width="75%">&nbsp;</td>
                      </tr>
					   <tr class="datagridcolor">
                        <td width="25%">&nbsp;</td>
                        <td width="75%">&nbsp;</td>
                      </tr>
					<tr class="datagridcolor">
                        <td width="25%">&nbsp;</td>
                        <td width="75%">&nbsp;</td>
                      </tr>
                      <tr class="datagridcolor">
                        <td width="25%">&nbsp;</td>
                        <td width="75%">&nbsp;</td>
                      </tr>
                      <tr class="datagridcolor">
                        <td width="25%">&nbsp;</td>
                        <td width="75%">&nbsp;</td>
                      </tr>
					  <tr class="datagridcolor">
                        <td width="25%">&nbsp;</td>
                        <td width="75%">&nbsp;</td>
                      </tr>
                  <%if (inside.equals("N"))
	{
		%>
                  <tr valign="top" bgcolor="#FFFFFF"> 
                    <td  colspan="2"width="15%" align="center"><font size="1" face="MS Sans Serif"><b>No 
                      Data Found for the selected criteria</b> </font> 
                  </tr>
                  <%
	}%>
                </table>
              </div>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <table width="10%" border="0" cellspacing="0" cellpadding="3" align="center">
   <tr valign="top"> 
		<td width="20%"> 
            <input type=button style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" value="Close" name="closebtn" tabindex="25"  onClick=window.close()>
          </td>
	</tr>
       </table>
	   <input type="hidden" name="strfrom" value="<%=strFromLink%>">
	   <input type="hidden" name="pagefrom" value="<%=strpagefrom%>">
	   <input type="hidden" name="hidBeanId">
	   <input type="hidden" name="hidBeanGetMethod">
</form>
</body>
</html>
