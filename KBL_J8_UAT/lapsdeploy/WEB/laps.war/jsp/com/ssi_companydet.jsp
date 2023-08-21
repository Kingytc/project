<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror />
<%
ArrayList g1= new ArrayList();

String dateofincorp = Helper.correctNull((String)hshValues.get("dateofincorp"));
if (dateofincorp.equals("01/01/1900"))
{
dateofincorp = "";
}
String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));
String strSSIType  =Helper.correctNull((String)request.getParameter("hidSSIType"));
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
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
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

function call_page(url)
{
	if (document.forms[0].cmdedit.disabled != true)
	{

	document.forms[0].action=appURL+"action/"+url;
	document.forms[0].submit();
	}
	else
	{
		alert("You Have Unsaved Information");
	}
	
}

function change_select()
{
	if(document.forms[0].select_asset.value != "Standard")
	{
		document.all.labelchange.innerText="NPA Since";
		document.all.showtext.style.visibility = "visible";
	}
	else
	{
		document.all.labelchange.innerText="";
		document.all.showtext.style.visibility = "hidden";
	}

}

function show_details()
{
	asset = "<%=Helper.correctNull((String)hshValues.get("asset"))%>";
	if (asset != "")
	{
	document.forms[0].select_asset.value ="<%=Helper.correctNull((String)hshValues.get("asset"))%>";
	document.forms[0].txt_npa.value ="<%=Helper.correctNull((String)hshValues.get("npa"))%>";
	}
}

function placevalues()
{
	show_details();
	change_select();
	enableButtons(false,true,true,false);
	document.forms[0].select_asset.disabled = true;
	document.forms[0].txt_npa.readOnly=true;
	document.forms[0].company_comment.readOnly=true;
}

function oncancel()
{
	if (ConfirmMsg(102))
	{
	document.forms[0].action=appURL+"/action/com_companydet.jsp";
	document.forms[0].submit();
	}
}

function onclose()
{
	if (ConfirmMsg(100))
	{
	document.forms[0].action=appURL+"/action/comborrowersearch.jsp";
	document.forms[0].submit();
	}
}

function onedit()
{
	document.forms[0].select_asset.disabled = false;
	document.forms[0].txt_npa.readOnly=false;
	document.forms[0].company_comment.readOnly=false;
	enableButtons(true,false,false,true);
}

function apply()
{
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updateCompany";
	document.forms[0].hidSourceUrl.value="/action/com_companydet.jsp";
	document.forms[0].submit();
}

function callSSIMethod(pagename,methodname)
{
	//alert("callSSIMethod");
	document.forms[0].hidMethod.value= methodname ;
	document.forms[0].action=appURL+"action/"+pagename;
	document.forms[0].submit();
}

</script>
</head>
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#EEEAE3" onLoad="placevalues()">
<jsp:include page="../share/help.jsp" flush="true"/> 
<form name="frmpri" method = post>
<table width="100%" border="0" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  >
 <tr> 
	<laps:borrowertype />
    <td> 
  <jsp:include page="../share/menus.jsp" flush="true"/>
  <jsp:include page="../com/proposallinks.jsp" flush="true">
  <jsp:param name="pageid" value="1" />
  <jsp:param name="cattype" value="<%=strCategoryType%>" />
  <jsp:param name="ssitype" value="<%=strSSIType%>" />
  </jsp:include>
      </td>
    </tr>
  </table>
  <b><i>Basic Information </i></b><br>
  <laps:application  /> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td valign="bottom"> 
        <table width="55%" border="0" cellspacing="3" cellpadding="3" align="left">
          <tr> 
            <td width="39%"  align="center" bgcolor="#71694F" id="prin"><b><font  color="#FFFFFF">Borrower 
              Demographics </font></b></td>
			  <%
			  if(strCategoryType.equals("CORP"))
			  {
			  %>

            <td width="24%"  align="center" bgcolor="#EEEAE3" id="prin"><font size="1" face="MS Sans Serif"><b><a href="javascript:call_page('com_promdet.jsp')" class="blackfont">Promoters & Guarantors </a></b></font></td>
			<%
			}
			else
			{
			%>
			<td width="24%"  align="center" bgcolor="#EEEAE3" id="prin"><font size="1" face="MS Sans Serif"><b><a href="javascript:callSSIMethod('ssi_proposal_promoters.jsp','getPromotorDetails')" class="blackfont">Promoters & Guarantors</a></b></font></td>

			<%
			}
			%>

            <td width="37%"  align="center" bgcolor="#EEEAE3" id="prin"><b><font size="1" face="MS Sans Serif"><a href="javascript:call_page('com_activitydet.jsp')" class="blackfont">Nature 
              of Activities</a></font></b></td>
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
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr> 
                        <td> 
                          <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="1" cellpadding="4">
                                  <tr> 
                                    <td align="center" bgcolor="#71694F" width="12%"><font  color="#FFFFFF"><b>Group</b></font></td>
                                    <td align="center" bgcolor="#71694F"><font  color="#FFFFFF"><b>Nature 
                                      of Activity</b>&nbsp;</font></td>
                                    <td colspan="2" align="center" bgcolor="#71694F"><font  color="#FFFFFF"><b>Credit 
                                      Rating </b>&nbsp;</font></td>
                                    <td colspan="2" align="center" bgcolor="#71694F"><font  color="#FFFFFF"><b>&nbsp;Asset 
                                      Classification </b>&nbsp; </font> </td>
                                  </tr>
                                  <tr> 
                                    <td align="center" width="12%"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)hshValues.get("group"))%></font></td>
                                    <td align="center"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)hshValues.get("activitynature"))%></font></td>
                                    <td width="16%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif">Last 
                                      Year </font></td>
                                    <td width="13%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif">Current 
                                      Year</font></td>
                                    <td colspan="2" align="center"><font size="1" face="MS Sans Serif"> 
                                      <select name="select_asset" size="1" onchange="change_select()">
                                        <option value="Standard" selected><font size="1" face="MS Sans Serif">Standard</font></option>
                                        <option value="SubStandard"><font size="1" face="MS Sans Serif">SubStandard</font></option>
                                        <option value="Doubtful"><font size="1" face="MS Sans Serif">Doubtful</font></option>
                                        <option value="Loss"><font size="1" face="MS Sans Serif">Loss</font></option>
                                      </select>
                                      </font> </td>
                                  </tr>
                                  <tr> 
                                    <td width="12%"><font size="1" face="MS Sans Serif"></font><font size="1" face="MS Sans Serif"></font></td>
                                    <td>&nbsp;</td>
                                    <td width="16%">&nbsp;</td>
                                    <td width="13%"><font size="1" face="MS Sans Serif"></font></td>
                                    <td width="21%"><font size="1" face="MS Sans Serif"> 
                                      <b><span id="labelchange">Remark</span></b></font></td>
                                    <td width="18%" id="showtext"><font size="1" face="MS Sans Serif"> 
                                      <input type="text" name="txt_npa" onblur="checkDate(txt_npa)">
                                      </font></td>
                                  </tr>
                                  <tr align="center"> 
                                    <td colspan="2" bgcolor="#71694F"><font  color="#FFFFFF"><b>Registered 
                                      Office Address</b></font></td>
                                    <td colspan="2" bgcolor="#71694F"><font  color="#FFFFFF"><b>Corporate 
                                      Office Address</b></font></td>
                                    <td colspan="2" bgcolor="#71694F"><font  color="#FFFFFF"><b>Factory 
                                      Address </b></font></td>
                                  </tr>
                                  <tr> 
                                    <td colspan="2" valign="top" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"> 
                                      <%=Helper.correctNull((String)hshValues.get("regoffaddress"))%>&nbsp;<br>
                                      &nbsp;<%=Helper.correctNull((String)hshValues.get("companycity"))%><br>
                                      </font></td>
                                    <td colspan="2" valign="top" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"> 
                                      <%=Helper.correctNull((String)hshValues.get("corpoffaddress"))%>&nbsp;<br>
                                      <%=Helper.correctNull((String)hshValues.get("regoffcity"))%>&nbsp;<br>
                                      </font></td>
                                    <td colspan="2" valign="top" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"> 
                                      <%=Helper.correctNull((String)hshValues.get("factoffaddress"))%>&nbsp;<br>
                                      <%=Helper.correctNull((String)hshValues.get("factoffcity"))%>&nbsp;</font></td>
                                  </tr>
                                  <tr> 
                                    <td colspan="2" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)hshValues.get("companystate"))%>&nbsp;- 
                                      <%=Helper.correctNull((String)hshValues.get("companypin"))%>&nbsp;</font></td>
                                    <td colspan="2" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)hshValues.get("regoffstate"))%>&nbsp;- 
                                      <%=Helper.correctNull((String)hshValues.get("regoffpin"))%>&nbsp;</font></td>
                                    <td colspan="2" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)hshValues.get("factoffstate"))%>&nbsp;- 
                                      <%=Helper.correctNull((String)hshValues.get("factoffpin"))%>&nbsp;</font></td>
                                  </tr>
                                  <tr> 
                                    <td colspan="2" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif">Ph:<%=Helper.correctNull((String)hshValues.get("companyphone"))%>&nbsp;</font></td>
                                    <td colspan="2" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif">Ph:<%=Helper.correctNull((String)hshValues.get("regoffphone"))%>&nbsp;</font></td>
                                    <td colspan="2" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif">Ph:<%=Helper.correctNull((String)hshValues.get("factoffphone"))%>&nbsp;</font></td>
                                  </tr>
                                  <tr> 
                                    <td colspan="2" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif">Fax:<%=Helper.correctNull((String)hshValues.get("companyfax"))%>&nbsp;</font></td>
                                    <td colspan="2" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"></font></td>
                                    <td colspan="2" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"></font></td>
                                  </tr>
                                  <tr> 
                                    <td colspan="2" align="center" bgcolor="#71694F"><font  color="#FFFFFF"><b>Date 
                                      of Incorporation</b></font></td>
                                    <td colspan="2" align="center" bgcolor="#71694F"><font  color="#FFFFFF"><b>Constitution 
                                      </b></font></td>
                                    <td colspan="2" align="center" bgcolor="#71694F"><font  color="#FFFFFF"><b>Dealing 
                                      with our bank since</b></font></td>
                                  </tr>
                                  <tr> 
                                    <td colspan="2" align="center" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif">&nbsp;<%=dateofincorp%></font></td>
                                    <td colspan="2" align="center" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif">&nbsp;<%=Helper.correctNull((String)hshValues.get("constitution"))%></font></td>
                                    <td colspan="2" align="center" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif">&nbsp;<%=Helper.correctNull((String)hshValues.get("dealings"))%></font></td>
                                  </tr>
                                  <tr> 
                                    <td colspan="6"><b><font size="1" face="MS Sans Serif">Comments</font></b></td>
                                  </tr>
                                  <tr> 
                                    <td colspan="6"> 
                                      <textarea name="company_comment" cols="120" wrap="VIRTUAL" rows="8"><%=Helper.correctNull((String)hshValues.get("companydesc"))%></textarea>
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
                <input type="button" name="cmdcancel" value="Cancel"  style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="oncancel()">
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
  <input type=hidden name="hidMethod">
  <input type="hidden" name="comapp_id" value="<%=request.getParameter("comapp_id")%>">

</form>
</body>
</html>
