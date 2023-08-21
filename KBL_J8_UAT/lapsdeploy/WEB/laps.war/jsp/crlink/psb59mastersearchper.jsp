
<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<!--<lapschoice:handleerror />-->
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
	String grpRights = Helper.correctNull((String)session.getAttribute("strGroupRights"));
	String modType = Helper.correctNull((String)session.getAttribute("moduletype"));
	session.setAttribute("pageType","agri");
	//session.removeAttribute("moduletype");
	//session.setAttribute("moduletype","A");
	//String strCanaraSyndBank=ApplicationParams.getStrCbsInterfaceflag();
	String strCanaraSyndBank="";
	//out.println(strCanaraSyndBank);
	String strRefid= Helper.correctNull((String) session.getAttribute("strapprefid"));
%>
<%
%>
<html>
<head>
<title>Master Search Personal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 100%;
  overflow: auto;
}
a:hover {  color: #FF6600}
</STYLE>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/set/psb59mastersearchper.js"> </script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varCanaraSyndBank="<%=strCanaraSyndBank%>";
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>

<%if(modType.equals("A")){
%>
   <body  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="imgLoad(appURL,'agriculture.gif')" class="bgcolor"></BODY><%
   %>
    <%
    } 
        	else{%>
		  <body  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="imgLoad(appURL,'personal.jpg');loadpg()" class="bgcolor"></BODY><%
 %>
		<%} %>
		
<body text="#000000"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<jsp:include page="../share/help.jsp" flush="true"> 
</jsp:include>
<form name="persearchMast" method="post">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top" colSpan=5> 
              <jsp:include page="../share/menus.jsp" flush="true"> </jsp:include>
            </td>
          </tr>
          <tr>
          
        	<%if(modType.equals("A")){%>
    <td class="bredcrumb">Home <span class="bredcrumbArw">&gt; </span> &nbsp; Agriculture <span class="bredcrumbArw"> &gt; </span> &nbsp;Customer Profile Search <%
 %></td>
    <%
    } 
        	else{%>
		  <td class="bredcrumb">Home <span class="bredcrumbArw">&gt; </span> &nbsp; Retail <span class="bredcrumbArw"> &gt; </span> &nbsp;Customer Profile Search <%
 %> </td>
		<%} %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <div align="center"><br>
    <table width="100%" border="0" cellspacing="0" cellpadding="3" height="400" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" class="outertablecolor">
      <tr> 
        <td valign="top"> 
          <div align="left"></div>
          <table width="100%" border="0" cellspacing="0" cellpadding="10" height="100%">
            <tr> 
              <td> 
                <table width="100%" border="0" cellspacing="0" cellpadding="2" height="100%" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
                  <tr> 
                    <td valign="top">
                      <table width="100%" border="0" cellspacing="0" cellpadding="5" height="100%">
                        <tr> 
                          <td valign="top"> 
                            <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                              <tr> 
                                <td> 
                                  <table width="100%" border="0" cellspacing="0" cellpadding="5">
                                    <tr> 
                                      <td colspan="9" width="65%"><font size="1" face="MS Sans Serif"><b>Search 
                                        By</b> </font></td>
                                      <!-- <td width="4%"> 
                                        <input type="radio" name="radiobutton" value="first" style="border-style:none" onClick="onRadioClick()">
                                      </td> -->
                                      <!-- <td width="9%"><font size="1" face="MS Sans Serif">First 
                                        Name</font></td>
                                      <td width="4%"> 
                                        <input type="radio" name="radiobutton" value="last" style="border-style:none" onClick="onRadioClick()">
                                      </td>
                                      <td width="9%"><font face="MS Sans Serif" size="1">Last 
                                        Name</font></td>
                                      <td width="3%"><font size="1" face="MS Sans Serif"> 
                                        <input type="radio" name="radiobutton" value="id" style="border-style:none" onClick="onRadioClick()">
                                        </font></td>
                                      <td colspan="2"><font size="1" face="MS Sans Serif">Branch 
                                        Alpha </font></td>
                                      <td width="4%"> 
                                        <input type="radio" name="radiobutton" value="pan" style="border-style:none" onClick="onRadioClick()">
                                      </td> -->
                                      <td width="10%"><font size="1" face="MS Sans Serif">Customer ID 
                                        </font> </td>
                                      <td width="10%"> 
                                        <input type="text" name="txtsearch" size="15" maxlength="15" onKeyPress="allowInteger('this')" onPaste="return true">
                                        <input type="hidden" name="hid_sectr" value="<%=(String)request.getParameter("hidSectorType")%>">
                                        <font size="1" face="MS Sans Serif"><b><!--<a href="javascript:showSearchData()"  class="blackfont" tabindex ="10"><img src="<%=ApplicationParams.getAppUrl()%>img/Search.png" style="border: none" align="middle" height="25px">--></b></font></td>             
                                      
                                             
                                  
                                      
                                      <%if(strCanaraSyndBank.equals("C")){ %>
                                      
                                      <td width="10%"> 
                                        <input type="button" name="cmdOK2" value="Search" style="width:75" class="buttoncolor" onClick="callExisting_Canara()" >
                                      </td>
                                      <%}else{ %>
                                       <td width="10%"> 
                                        <input type="button" name="cmdOK2" value="Search" style="width:75" class="buttoncolor" onClick="callExisting()" >
                                      </td>
                                      <%} %>
                                      <td width="5%">&nbsp;</td>
                                      <!-- <td width="18%"> 
                                        <input type="button" name="cmdOK22" value="New Applicant" style="width:100" class="buttoncolor" onClick="callNew()" >
                                      </td> -->
                                    </tr>
                                    <tr> 
                                      <td colspan="13"> 
                                        <table width="100%" border="0" cellspacing="0" cellpadding="3" bordercolorlight="#EBEBF8" bordercolordark="#82829F">
                                          <tr> 
                                            <td width="31%" class="tabactive"> 
                                              <div align="center"><b><font color="#FFFFFF"><font face="MS Sans Serif" size="1">Applicant 
                                                Name</font></font></b></div>
                                            </td>
                                            <td width="18%" class="tabactive"> 
                                              <div align="center"><b><font color="#FFFFFF"><font face="MS Sans Serif" size="1">Customer ID </font></font></b></div>
                                            </td>
                                             <!-- <td width="18%" class="tabactive"> 
                                              <div align="center"><b><font color="#FFFFFF"><font face="MS Sans Serif" size="1">LAPS ID </font></font></b></div>
                                            </td> -->
                                            <td width="31%" class="tabactive"> 
                                              <div align="center"><b><font color="#FFFFFF" face="MS Sans Serif" size="1">Home Branch 
                                                Name</font></b></div>
                                            </td>
                                          </tr>
                                        </table>
                                      </td>
                                    </tr>
                                    <tr> 
                                      <td colspan="13"> 
                                        <div align="left"><iframe   id="isearch" width="100%" height="340"  src="<%=ApplicationParams.getAppUrl()%>action/blank.jsp"></iframe> 
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
                      <br>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    <br>
    <table width="0%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center" class="outertablecolor">
      <tr> 
        <td> 
          <table width="0%" border="0" cellspacing="0" cellpadding="3">
            <tr valign="top">
              <td height="2">
                <input type="reset" name="getforms2" value="Reset" style="width:80" class="buttoncolor" onClick="resetme()">
              </td>
              <td height="2"> 
                <div align="center"> 
                  <input type="button" name="cmdHelp" value="Help" style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="callhelp()">
                </div>
              </td>
              <td height="2"> 
                <div align="center"> 
                  <input type="button" name="cmdClose" value="Close" style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="callClose()">
                </div>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </div>
  <INPUT TYPE="hidden" name="hidAppType">
  <input type="hidden" name="hidBeanMethod" >
  <input type="hidden" name="hidBeanId" >
  <input type="hidden" name="hidSourceUrl" >
  <input type="hidden" name="hidBeanGetMethod" >
  <input type="hidden" name="hidDemoId" >
<input type="hidden" name="hidSear" >
<input type="hidden" name="hidrefid" value="<%=Helper.correctNull((String)session.getAttribute("strapprefid"))%>">
   
  <input type="hidden" name="modType" value="<%=Helper.correctNull((String)session.getAttribute("moduletype"))%>">
  

</form>
</body>
</html>
