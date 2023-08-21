<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="strGroupRights" class="java.lang.String" scope="session"/>
<laps:handleerror/>
<%
//out.println("the val is======="+Helper.correctNull((String)request.getParameter("cattype")));
session.setAttribute("comappid",Helper.correctNull((String)request.getParameter("id")));
String strNpa=Helper.correctNull((String)request.getParameter("hidNpaPageType"));
//out.println(strNpa);
session.setAttribute("Npalink",request.getParameter("hidNpaPageType"));

%>

<html>
<head>
<title>Commercial-Existing Application form</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/menudropdown.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
function authenticateUser()
{
	
}

function toggleState()
{
	/*if(document.forms[0].srchoption.checked)
	{
		document.forms[0].mailbox[1].disabled=false;
		document.forms[0].mailbox[0].disabled=false;
		document.forms[0].srch.checked=false;
		//document.forms[0].srch[1].checked=false;
		//document.forms[0].srch[2].checked=false;
		document.forms[0].srch.disabled=true;
		//document.forms[0].srch[1].disabled=true;
		//document.forms[0].srch[2].disabled=true;
		document.forms[0].srchvalue.disabled=true;
		document.forms[0].srchvalue.readonly=true;
		authenticateUser();
	}*/
}

function showBlank()
{
document.all.result.src=appUrl+'action/blank.jsp';
}

function resetme()
	{
		document.forms[0].reset();
		toggleState();
		document.all.result.src=appUrl+'action/blank.jsp';
	}
	

function doClose()
{
	if(ConfirmMsg(100))
	{
		if(document.forms[0].hidPageType.value == "audit_trial")
		{
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/audit_trial_search.jsp?hidPageType=<%=request.getParameter("hidPageType")%>";
		}
		else
		{
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/comborrowersearch.jsp?hidPageType=<%=request.getParameter("hidPageType")%>";

		}
		document.forms[0].submit();
	}
}

function doSearch()
{
	var strOpt="";
	var strForm="";
	var strSrch="";
	var strMailbox="";


	appno = document.forms[0].srchvalue.value;	document.all.result.src="<%=ApplicationParams.getAppUrl()%>action/comresult.jsp?hidBeanGetMethod=getDataFinal&hidBeanId=borrowersearch&id=<%=Helper.correctNull((String)request.getParameter("id"))%>&hidCategoryType=<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>&hidSSIType=<%=Helper.correctNull((String)request.getParameter("hidSSIType"))%>&appno="+appno+"&comapp_compname=<%=Helper.correctNull((String)request.getParameter("comapp_compname"))%>&hidPageType=<%=request.getParameter("hidPageType")%>&From_date=<%=Helper.correctNull((String)request.getParameter("From_date"))%>&To_date=<%=Helper.correctNull((String)request.getParameter("To_date"))%>&select_cat=<%=Helper.correctNull((String)request.getParameter("select_cat"))%>&hidNpaPageType=<%=Helper.correctNull((String)request.getParameter("hidNpaPageType"))%>";

	alert(document.all.result.src);

	

/* modification starts, written by Gowrisankar 
	
	var companyname = document.forms[0].comapp_compname.value;
	var comapnyid = document.forms[0].comapp_compid.value;
	var borrowerid = document.forms[0].comapp_id.value ;

	if(strOpt=="mailbox") 
	{ 
		if(strMailbox=="outbox")
		{
			document.all.result.src="<%=ApplicationParams.getAppUrl()%>action/controllerservlet?hidBeanId=mailboxapp&hidBeanMethod=getOutBox&hidSourceUrl=/action/appmailbox.jsp&optformtype=C&optstype="+strSrch+"&txtsearch="+document.forms[0].srchvalue.value+"&orgname="+companyname+"&orgid="+comapnyid+"&borrowerid="+borrowerid;
	 	}
		else if(strMailbox=="inbox")
		{
			document.all.result.src="<%=ApplicationParams.getAppUrl()%>action/controllerservlet?hidBeanId=mailboxapp&hidBeanMethod=getInBox&hidSourceUrl=/action/appmailbox.jsp&optformtype=C&optstype="+strSrch+"&orgname="+companyname+"&orgid="+comapnyid+"&borrowerid="+borrowerid;
		}
		else
		{
				alert("Select a Form");
		}
	}
	else if(strOpt=="desk") 
	{
		

		//appno = document.forms[0].srchvalue.value;	document.all.result.src="<%=ApplicationParams.getAppUrl()%>action/comresult.jsp?hidBeanGetMethod=getDataFinal&hidBeanId=comapplicantsearch&id=<%=Helper.correctNull((String)request.getParameter("id"))%>&hidCategoryType=<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>&hidSSIType=<%=Helper.correctNull((String)request.getParameter("hidSSIType"))%>&appno="+appno+"&comapp_compname=<%=Helper.correctNull((String)request.getParameter("comapp_compname"))%>";
	

	}


	
	*/


}
function disp()
{
	/*if(document.forms[0].mailbox[0].checked)
	{
		document.forms[0].srch.disabled=true;
		//document.forms[0].srch[1].disabled=true;
		//document.forms[0].srch[2].disabled=true;
		document.forms[0].srchvalue.disabled=true;
	}
	else if(document.forms[0].mailbox[1].checked)
	{
		document.forms[0].srch.disabled=true;
		//document.forms[0].srch[1].disabled=true;
		//document.forms[0].srch[2].disabled=true;
		document.forms[0].srchvalue.disabled=true;
	}
	document.forms[0].srch.checked=false;
	//document.forms[0].srch[1].checked=false;
	//document.forms[0].srch[2].checked=false;
	document.forms[0].srchvalue.value="";*/

}
/* modification end */



function repTable()
{
	if(document.forms[0].srchoption.checked==true)
	{
	document.all.searchheading.innerHTML='<table width="100%" border="0" cellspacing="2" cellpadding="1"><tr bgcolor="#71694F" bordercolordark="#82829F" bordercolorlight="#EBEBF8">         <td width="25%" height="22" bgcolor="#71694F"><b> <font  color="#FFFFFF">Application No</font></b></td><td width="25%" height="22"> <b><font  color="#FFFFFF">Process Status</font></b></td><td width="25%" height="22" bgcolor="#71694F"><b> <font  color="#FFFFFF">Sent By</font></b></td><td width="25%" height="22" bgcolor="#71694F"><b> <font  color="#FFFFFF">Application No</font></b></td></tr></table> '
	}
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<style type="text/css">
<!--
input {  border-style: groove; font-family: "MS Sans Serif"; font-size: 10px}
-->
</style>
</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="">
<form name="exist">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top" colSpan=5> 
              <jsp:include page="../share/help.jsp" flush="true"/> 
              <jsp:include page="../share/menus.jsp" flush="true"/> 
            </td>
          </tr>
          <tr>
            <td valign="top" colSpan=5><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>Home 
              </i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
              <font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt;</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
              <font face="Times New Roman" size="3"><b><i>Commercial</i></b></font></td>
          </tr>
        </table>		
      </td>
    </tr>
 </table>

  <br>
  <table width="100%" border="1" cellspacing="0" cellpadding="5" height="380" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
          <tr> 
            <td> 
              <table width="100%" border="1" cellspacing="0" cellpadding="4" height="100%" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
                <tr> 
                  <td height="70" valign="top"> <br>
                    <table width="80%" border="1" cellspacing="0" cellpadding="3" align="center" height="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                      <tr> 
                        <td height="0" valign="top"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" bordercolorlight="#EBEBF8" bordercolordark="#82829F">
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tr> 
                                    <td colspan="9" height="15"><font size="1" face="MS Sans Serif">&nbsp;&nbsp;<b>Search 
                                      By </b></font></td>
                                  </tr>
                                  <tr> 
                                    <td width="4%"> 
                                      <input type="radio" name="srch" value="appno" onClick="document.forms[0].srchvalue.readOnly=false;document.forms[0].srchvalue.focus();document.forms[0].srchvalue.value=''"  style="border-style:none">
                                    </td>
                                    <td width="18%"><font size="1" face="MS Sans Serif">Application 
                                      Number </font></td>
                                    <!-- <td width="4%"> <font size="1" face="MS Sans Serif"> 
                                      <input type="radio" name="srch" value="orgname" onClick="document.forms[0].srchvalue.readOnly=false;document.forms[0].srchvalue.focus();document.forms[0].srchvalue.value=''"  style="border-style:none">
                                      </font></td>
                                   <td width="15%"><font size="1" face="MS Sans Serif">Company 
                                      Name</font></td>
                                    <td width="4%"> <font size="1" face="MS Sans Serif"> 
                                      <input type="radio" name="srch" value="orgid" onClick="document.forms[0].srchvalue.readOnly=false;document.forms[0].srchvalue.focus();document.forms[0].srchvalue.value=''"  style="border-style:none">
                                      </font></td>
                                    <td width="18%"><font size="1" face="MS Sans Serif">Company 
                                      ID</font></td>-->
                                    <td width="29%"> 
                                      <input type="text" name="srchvalue" size="20"  readonly style="color:#333399;border-style:groove;height:18;font-family:MS Sans Serif;font-size:10px;" onKeyPress="notAllowSplChar()">
                                    </td>
                                    <td width="16%"> 
                                      <input type="button" name="search" value="Search"  style="font-weight:bold;background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:80;font-weight:bold" onClick="doSearch()" >
                                    </td>
                                    <td width="33%"> 
                                      <input type="button" name="cmdreset" value="Reset" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:80;font-weight:bold" onClick="resetme()">
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
                    <table width="80%" border="0" cellspacing="0" cellpadding="0" align="center">
                      <tr> 
                        <td valign="top" id="searchheading"> 
                          <table width="100%" border="0" cellspacing="2" cellpadding="1">
                            <tr bgcolor="#71694F" bordercolordark="#82829F" bordercolorlight="#EBEBF8" align="center"> 
                              <td width="24%" height="22" bgcolor="#71694F"><font  color="#FFFFFF">Application 
                                No.</font></td>
                              <td width="51%" height="22"><font  color="#FFFFFF">Borrower 
                                Name </font></td>
                              <td width="25%" height="22"> <font  color="#FFFFFF">Process 
                                Status</font></td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top"><iframe id="result" src="<%=ApplicationParams.getAppUrl()%>action/comresult.jsp?hidBeanGetMethod=getDataFinal&hidBeanId=borrowersearch&id=<%=Helper.correctNull((String)request.getParameter("id"))%>&hidCategoryType=<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>&hidSSIType=<%=Helper.correctNull((String)request.getParameter("hidSSIType"))%>&hidPageType=<%=request.getParameter("hidPageType")%>&comapp_compname=<%=Helper.correctNull((String)request.getParameter("comapp_compname"))%>&From_date=<%=Helper.correctNull((String)request.getParameter("From_date"))%>&To_date=<%=Helper.correctNull((String)request.getParameter("To_date"))%>&select_cat=<%=Helper.correctNull((String)request.getParameter("select_cat"))%>" width="100%" height=220 > </iframe> </td>
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
  <br>
  <table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"align="center">
    <tr> 
      <td> 
        <table width="0%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="middle"> 
            <td> 
              <div align="center"> 
                <input type="button" name="cmdhelp" value="Help" style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" onClick="doHelp('comexisting.htm')">
              </div>
            </td>
            <td> 
              <div align="center"> 
                <input type="button" name="cmdclose" value="Close" style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" onClick="doClose()">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
<input type="hidden" name="hidPageType" value="<%=request.getParameter("hidPageType")%>"> 
<input type="hidden" name="hidNpaPageType" value="<%=request.getParameter("hidNpaPageType")%>"> 

<input type="hidden" name="comapp_id" value="<%=request.getParameter("comapp_id")%>"> 
<input type="hidden" name="comapp_compname" value="<%=request.getParameter("comapp_compname")%>"> 
<input type="hidden" name="comapp_compid" value="<%=request.getParameter("comapp_compid")%>"> 
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>"> 
 <input type="hidden" name="hidSSIType" value="<%=Helper.correctNull((String)request.getParameter("hidSSIType"))%>"> 

  <input type="hidden" name="select_cat" value="<%=Helper.correctNull((String)request.getParameter("select_cat"))%>"> 

  <input type="hidden" name="From_date" value="<%=Helper.correctNull((String)request.getParameter("From_date"))%>"> 

<input type="hidden" name="To_date" value="<%=Helper.correctNull((String)request.getParameter("To_date"))%>"> 
</form>
</body>
</html>
