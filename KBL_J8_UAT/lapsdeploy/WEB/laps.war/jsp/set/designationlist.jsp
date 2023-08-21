<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
ArrayList g1 =  new ArrayList();
String strFromLink = Helper.correctNull((String)request.getParameter("strfrom"));
String strvalue = Helper.correctNull((String)hshValues.get("svalue"));
%>
<html>
<title>LAPS: Designation List</title>
<head>
<style type="text/css">
DIV.cellContainer 
{	
  width: 100%; height: 200;
  overflow: auto;
}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>htm/link.css" type="text/css">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>

<SCRIPT LANGUAGE="JavaScript">	
var from_link = "<%=strFromLink%>";	
var appUrl="<%=ApplicationParams.getAppUrl()%>";
	

function onselect1()
	{
	
	}
function getSelectedValue(val1, val2)
{	
	if(from_link == "DesignationMaster")
	{
		window.opener.document.forms[0].hidsno.value = val1;
		window.opener.document.forms[0].txt_datavalues.value = val2;
		window.close();
	}	
	if(from_link == "lawyerMaster")
	{
		window.opener.document.forms[0].txt_desig.value = val1;
		window.opener.document.forms[0].txt_desig1.value = val2;
		window.close();
	}
	if(from_link == "BuilderMaster")
	{
		window.opener.document.forms[0].txt_desig.value = val1;
		window.opener.document.forms[0].txt_desig1.value = val2;
		window.close();
	}
	if(from_link == "ValuerMaster")
	{
		window.opener.document.forms[0].txt_desig.value = val1;
		window.opener.document.forms[0].txt_desig1.value = val2;
		window.close();
	}	
	if(from_link == "companymaster")
	{
		window.opener.document.forms[0].txt_desig.value = val1;
		window.opener.document.forms[0].txt_desig1.value = val2;
		window.close();
	}
	if(from_link == "Employer")
	{
		window.opener.document.forms[0].txtperemp_Desigcode.value = val1;
		window.opener.document.forms[0].txtperemp_Designation.value = val2;
		window.close();
	}
}
	
function searchData()
{
	//var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
	//var url=appUrl+"action/designationlist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getDesignationMasterList&strfrom=Employer&hidAction=search&txt_ser="+document.forms[0].txt_ser.value;
	//window.open(url,"",prop);
	document.forms[0].hidAction.value="search";
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanGetMethod.value="getDesignationMasterList";
	document.forms[0].action=appUrl+"action/designationlist.jsp";	
	document.forms[0].submit();
	
}
</SCRIPT>
</head>
<body class="bgcolor" bgcolor="#EEEAE3">
	<form name="productlisthelp" method="post">
  <br>
  <table width="95%" border="0" cellspacing="0" class="outertable border1" cellpadding="0" align="center">
    <tr>
      <td> <br>
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertablecolor" align="center">
          <tr> 
            <td><b>Search By 
              <br>
              </b>
              <table border="0" cellspacing="0" cellpadding="3" width="100%"  bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
                <tr>                  
                 <%--  <td width="5%"> 
                    <input type="radio" name="selradio" value="N" <%if(Helper.correctNull((String)hshValues.get("scode")).equalsIgnoreCase("N")){out.println("Checked");}%> style="border-style:none" onClick ="onselect1()">--%>
                  <td width="30%">Designation</td>
                  <td width="30%"> 
                    <input type="text" name="txt_ser" maxlength="50" size = "40" value="<%=strvalue%>" onKeyPress="notAllowSplChar1(this)">
                  </td>
                  <td width="40%" align = "center"> 
                    <input type=button  style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:75" class="buttonStyle"  value="Search" name="search" tabindex="20" onClick="searchData()">
                  </td>
                </tr>
              </table>
              <table width="100%" border="0" cellspacing="0" cellpadding="0" bordercolorlight="#EBEBF8" bordercolordark="#82829F">
                <tr> 
                  <td> 
                    <table width="97%" border="0" cellspacing="1" cellpadding="3" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
                      <tr bgcolor="#71694F"> 
                 	     <td width="15%"><b><font face="MS Sans Serif" size="1" color="#FFFFFF">Sl. No.</font></b></td>
                        <td width="85%"><b><font face="MS Sans Serif" size="1" color="#FFFFFF">Designation</font></b></td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
              <div class="cellcontainer"> 
                <table width="100%" border="0" cellspacing="1" cellpadding="3">
			<% 
 				ArrayList	v = (ArrayList) hshValues.get("vecRow");
			String inside="N";
				if(v!=null)
				{					
					int vecsize =v.size();
					for(int l=0;l<vecsize;l++)
					{							
						g1 = (ArrayList)v.get(l);
						%>
		                  <tr valign="top">
		                    <td  width="15%" align="left">
		                    <%=l+1%>&nbsp;</td>
		                    <td width="85%" align="left" ><a href="javascript:getSelectedValue('<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)g1.get(1))%>')" class="blackfont" align="center"><b><%=Helper.correctNull((String)g1.get(1))%></b></a></td>
		                  </tr>
		                  <%
		                  inside="Y";
				          	}
						}
					if (inside.equals("N"))
					{
						%>
					 <tr>
                        <td width="15%">&nbsp;</td>
                        <td width="85%">&nbsp;</td>
                      </tr>
					   <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
					   <tr>
                       <td>&nbsp;</td>
                       <td>&nbsp;</td>
                      </tr>
					   <tr>
                       <td>&nbsp;</td>
                       <td>&nbsp;</td>
                      </tr>
                      <tr valign="top" bgcolor="#FFFFFF"> 
                    <td  colspan="2"width="15%" align="center"><b>No 
                      Data Found for the selected criteria</b>  
                  </tr>
					<tr>
                       <td>&nbsp;</td>
                       <td>&nbsp;</td>
                      </tr>
                      <tr>
                       <td>&nbsp;</td>
                       <td>&nbsp;</td>
                      </tr>
                      <tr>
                       <td>&nbsp;</td>
                       <td>&nbsp;</td>
                      </tr>
					  <tr>
                       <td>&nbsp;</td>
                       <td>&nbsp;</td>
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
       <input type=button class="buttonClose" value="Close" name="closebtn" tabindex="25"  onClick=window.close()>
     </td>
   </tr>
</table>
<input type ="hidden" name="svalue" value="<%=Helper.correctNull((String)hshValues.get("svalue"))%>">
<input type ="hidden" name="stype" value="<%=Helper.correctNull((String)hshValues.get("scode"))%>">
<input type ="hidden" name="strfrom" value="<%=strFromLink%>">
<input type ="hidden" name="hidBeanId">
<input type ="hidden" name="hidBeanGetMethod">
<input type ="hidden" name="hidAction">
<input type ="hidden" name="org_name" value="<%=session.getAttribute("strOrgName")%>">
<input type ="hidden" name="org_code" value="<%=session.getAttribute("strOrgCode")%>">
</form>
</body>
</html>

