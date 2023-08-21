<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror />
<%
ArrayList g1 = new ArrayList();

%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
a:hover {  color: #FF3300}
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
</STYLE>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>jsp/htm/link.css" type="text/css">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function enableButtons(bool1,bool2,bool3,bool4)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdapply.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;
	
}

function call_page(url,method,type)
{
	
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?type="+type;
	document.forms[0].submit();
	
}




function show_details()
{
	
/*ocument.forms[0].techsoph.value ="<%//elper.correctNull((String)hshValues.get("Technologysophistication"))%>";
	document.forms[0].gestation.value ="<%//elper.correctNull((String)hshValues.get("GestationPeriod"))%>";
	document.forms[0].distribution.value ="<%//elper.correctNull((String)hshValues.get("DistributionNetwork"))%>";
	document.forms[0].brandname.value ="<%//elper.correctNull((String)hshValues.get("MarketingBrandName"))%>";
	document.forms[0].startupcost.value ="<%//elper.correctNull((String)hshValues.get("Marketingstartupcost"))%>";
	document.forms[0].market_comment.value ="<%//elper.correctNull((String)hshValues.get("Marketingcomments"))%>";
	*/
	
	

}

function placevalues()
{
	show_details();
	enableButtons(false,true,true,false);
	for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=true;
			  
			}
			
		}
}


function oncancel(url,method)
{
	if (ConfirmMsg(102))
	{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].action=appURL+"action/"+url;
	document.forms[0].submit();
	}
}

function onclose()
{
	document.forms[0].action=appURL+"/action/corppge.jsp";
	document.forms[0].submit();
}

function onedit()
{
		
	for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=false;
			  
			}
			
		}
	enableButtons(true,false,false,true);
}

function apply()
{
	
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updateGeneralComment";
	document.forms[0].hidBeanGetMethod.value="getDataComment";
	document.forms[0].hidSourceUrl.value="/action/com_workassesscomment.jsp"
	document.forms[0].action=appURL+"controllerservlet?type=1";
	document.forms[0].submit();
}

</script>
</head>

<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#EEEAE3"
onload="placevalues()">
<jsp:include page="../share/help.jsp" flush="true"/> 

<form name="frmpri" method = post>
  <table width="100%" border="1" cellspacing="0" cellpadding="0" bgcolor="#EEEAE3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  >
    <tr> 
     <td valign="top" colSpan=5> 
              <jsp:include page="../share/menus.jsp" flush="true"/> 
              <jsp:include page="../com/proposallinks.jsp" flush="true"> 
              <jsp:param name="pageid" value="10" />
              </jsp:include>
            </td>
    </tr>
  </table>
  <b><i>About Management</i></b><br><laps:application  /> 
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td valign="bottom"> 
        <table width="50%" border="0" cellspacing="3" cellpadding="3" align="left">
          <tr> 
            <td width="45%"  align="center" bgcolor="#EEEAE3" id="prin"><b><font size="1" face="MS Sans Serif"><a href="javascript:call_page('com_workassesscomment.jsp','getDataComment','1')" class="blackfont">Working Capital Assessment</a></font></b></td>
            <td width="45%"  align="center" bgcolor="#EEEAE3" id="prin"><b><font size="1" face="MS Sans Serif"><a href="javascript:call_page('com_assesscomment.jsp','getDataComment','2')" class="blackfont">Comment On Assessment</a></font></b></td>
			<td width="45%"  align="center" bgcolor="#EEEAE3" id="prin"><b><font size="1" face="MS Sans Serif"><a href="javascript:call_page('com_loanreqcomment.jsp','getDataComment','3')" class="blackfont">Term Loan Justification</a></font></b></td>
			<td width="45%"  align="center" bgcolor="#71694F" id="prin"><b><font size="1" face="MS Sans Serif">Justification For Contingent Limit</font></b></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="5" height="380" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <tr> 
      <td valign="top"> 
        <div align="left"> </div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="1" cellspacing="0" cellpadding="5" height="100%" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td>
                          <textarea name="txt_limitcomment" cols="140" wrap="VIRTUAL" rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("comment"))%></textarea>
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
  <br>
	<table width="12%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  align="center">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top"> 
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdedit" value="Edit" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="onedit()">
              </div>
            </td>
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdapply" value="Save" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="apply()" >
              </div>
            </td>
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdcancel" value="Cancel"  style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="oncancel('com_workassesscomment.jsp','getDataComment')">
              </div>
            </td>
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdhelp" value="Help"  style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
              </div>
            </td>
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdclose" value="Close"  style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"  onClick="onclose()">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <input type=hidden name="hidBeanId" >
  <input type=hidden name="hidBeanMethod"  >
  <input type=hidden name="hidBeanGetMethod" >
  <input type=hidden name="hidSourceUrl">
</form>
</body>
</html>
