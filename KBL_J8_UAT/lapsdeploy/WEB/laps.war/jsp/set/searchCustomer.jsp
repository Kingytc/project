<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<%
	String strTextControl = Helper.correctNull((String)request.getParameter("TextControl"));
	String strHiddenControl = Helper.correctNull((String)request.getParameter("HiddenControl"));
	
	ArrayList arrValues=new ArrayList();
	
	if(hshValues!=null)
	{
		arrValues=(ArrayList)hshValues.get("arrCust");
	}
	
%>
<html>
<head>
<title>Customer Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
DIV.cellContainer 
{	
  width: 100%; height: 300;
  overflow: auto;
}
</style>
<style type="text/css">
<!--
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
a:hover {  color: #FF3300}
-->
</style>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	var appURL = "<%=ApplicationParams.getAppUrl()%>";

	function callSearch()
	{
		document.forms[0].method="post";
		document.forms[0].hidBeanMethod.value="getDocSearch";
		document.forms[0].hidBeanId.value="Register";
		document.forms[0].action=appURL+"action/searchCustomer.jsp";	
		document.forms[0].submit();
		
	}

	function ClearFields()
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
				  document.forms[0].elements[i].value="";		  
			}		
			else if(document.forms[0].elements[i].type=="textarea")
			{
				document.forms[0].elements[i].value="";		  
			}
		}
	}

	function callReset()
	{
		document.forms[0].txt_cust_name.value==""
	}

	function displayUser(id, name)
	{
		if("<%=strTextControl%>"!="" && "<%=strHiddenControl%>"!="")
		{
			window.opener.document.forms[0].elements["<%=strTextControl%>"].value = name;
			window.opener.document.forms[0].elements["<%=strHiddenControl%>"].value = id;
		}	
		window.close();
	}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" vlink="#330000" alink="#330000"
	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<jsp:include page="../share/help.jsp" flush="true"/>

<form name="appform" method="post">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		
      <td><font size="4"><b><i><font size="4"><b><i><font
			size="4"><b><i><font size="4"><b><i><font size="4"><b><font
			color="#000000" size="2"><i><font size="4"><b><i><font
			face="Times New Roman" size="3"><b><i>Home -&gt; Setup-&gt; Search 
        By Customer</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></td>
	</tr>
</table>

<table width="98%" border="0" cellpadding="5" cellspacing="0"
	bordercolorlight="#8F8369" bordercolordark="#FFFFFB" class=""
	align="center">
	 <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="5" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" >
          <tr> 
            <td valign="top"> 
          </tr>
          <tr> 
            <td valign="top"> 
              <table border="0" cellspacing="0" cellpadding="0" width="100%">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="1">
                      <tr> 
                        <td width="69%" valign="top"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="1">
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="1">
                                  <tr> 
                                    <td width="20%" nowrap>Customer Name</td>
                                    <td width="40%"> 
                                      <input type="text" name="txt_cust_name" size="20" maxlength="400" value="" >
                                    </td>
                                    <td width="15%"> 
                                      <input type="button" name="cmdsearch" value="Search" 
														class="buttonStyle"
														onClick="callSearch()">
                                    </td>
                                    <td width="15%"> &nbsp;
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr> 
                              <td valign="top"> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" bordercolorlight="#EBEBF8" bordercolordark="#82829F">
                                  <tr> 
                                    <td valign="top"> 
                                      <table width="98.3%" border="0" cellspacing="1" cellpadding="3" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
                                        <tr bgcolor="#71694F"> 
                                          <td width="5%" >&nbsp;</td>
                                          <td width="35%"><font face="MS Sans Serif" size="1" color="#FFFFFF"><b>Customer 
                                            Name </b></font></td>
                                            <td width="65%"><font face="MS Sans Serif" size="1" color="#FFFFFF"><b>PAN Number </b></font></td>
                                          
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td valign="top" align="center"> 
                                      <DIV class="cellcontainer"> 
                                        <table width="100%" border="0" cellspacing="1" cellpadding="2" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
                                   <%
                                      if(arrValues!=null)
                                      {
                                    	  int arrSize=arrValues.size();
                                    	  ArrayList arrCol=null;
                                          for(int i=0;i<arrSize;i++)
                                    	  {
                                        	  arrCol=new ArrayList();
                                        	  arrCol=(ArrayList)arrValues.get(i);
                                       %>
                                   			<tr>
                                   			
                                            <td width="5%"> <input type="radio" name="rdoUser" style="border-style:none"  onClick="displayUser('<%= Helper.correctNull((String)arrCol.get(0))%>','<%= Helper.correctNull((String)arrCol.get(1))%>');" >
                                            
                                            </td>
                                            <td width="35%"><%= Helper.correctNull((String)arrCol.get(1))%> </td>
                                            <td width="60%"><%= Helper.correctNull((String)arrCol.get(2))%> </td>
                                          </tr>
                                   <% 		  
                                    	  }
                                    	  
                                      }
                                      
                                   %>
                                         
                                          <tr> 
                                            <td width="5%">&nbsp; </td>
                                            <td width="35%">&nbsp; </td>
                                            <td width="60%">&nbsp; </td>
                                          </tr>
                                          <tr> 
                                            <td width="5%">&nbsp; </td>
                                            <td width="35%">&nbsp; </td>
                                            <td width="60%">&nbsp; </td>
                                          </tr>
                                          <tr> 
                                            <td width="5%">&nbsp; </td>
                                            <td width="35%">&nbsp; </td>
                                            <td width="60%">&nbsp; </td>
                                          </tr>
                                          <tr> 
                                            <td width="5%">&nbsp; </td>
                                            <td width="35%">&nbsp; </td>
                                            <td width="60%">&nbsp; </td>
                                          </tr>
                                          <tr> 
                                            <td width="5%">&nbsp; </td>
                                            <td width="35%">&nbsp; </td>
                                            <td width="60%">&nbsp; </td>
                                          </tr>
                                          <tr> 
                                            <td width="5%">&nbsp; </td>
                                            <td width="35%">&nbsp; </td>
                                            <td width="60%">&nbsp; </td>
                                          </tr>
                                          <tr> 
                                            <td width="5%">&nbsp; </td>
                                            <td width="35%">&nbsp; </td>
                                            <td width="60%">&nbsp; </td>
                                          </tr>
                                         
                                        </table>
                                      </div>
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
      </td>
    </tr>
  </table>

  <input type="hidden" name="hidCustType" value="<%=Helper.correctNull((String)request.getParameter("hidCustType")) %>">
  <input type="hidden" name="TextControl" value="<%=Helper.correctNull((String)request.getParameter("TextControl")) %>">
  <input type="hidden" name="HiddenControl" value="<%=Helper.correctNull((String)request.getParameter("HiddenControl")) %>">
  <input type="hidden" name="hidBeanMethod" value="getDocSearch">
  <input type="hidden" name="hidBeanId" value="Register">
  <input type="hidden" name="hidBeanGetMethod" value="getDocSearch">
<br> 
</form>
</body>
</html>

