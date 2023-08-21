<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror />
<%
ArrayList g1= new ArrayList();
ArrayList g2= new ArrayList();
String strSSIType  =Helper.correctNull((String)request.getParameter("hidSSIType"));
String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));
String strBorrowerType =Helper.correctNull((String)request.getParameter("hidBorrowerType"));

%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<STYLE>

DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
</STYLE>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>jsp/htm/link.css" type="text/css">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">

<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "<%=ApplicationParams.getAppUrl()%>";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>

<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js">
</script>


<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>

<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function enableButtons(bool1,bool2,bool3,bool4)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdapply.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;
	
}

function call_page(url)
{
	
	document.forms[0].action=appUrl+"action/"+url;
	document.forms[0].submit();
	
}



function show_details()
{
	
	//document.forms[0].activity_comment.value ="<%//=Helper.correctNull((String)hshValues.get("activcomment"))%>";

}

function placevalues()
{
	//show_details();
	if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
	{
	 	
	 	enableButtons(true,true,true,false);
	}
	else
	{
	enableButtons(false,true,true,false);
	document.forms[0].activity_comment.readOnly=true;
	}
}

function oncancel()
{
	if (ConfirmMsg(102))
	{

		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidBeanMethod.value="";
		document.forms[0].hidSourceUrl.value="/action/com_companydet.jsp";
		document.forms[0].submit();

		//document.forms[0].action=appUrl+"/action/com_companydet.jsp";
		//document.forms[0].submit();
	}
}

function callclose()
{
	var cattype=document.forms[0].cattype.value;
	var id=document.forms[0].id.value;
 if((cattype=="ASSI")||(cattype=="ASBI"))
        {
       if(ConfirmMsg(100))
	 { 
		document.forms[0].action=appUrl+"action/agrsearch.jsp?&id="+document.forms[0].id.value;
		document.forms[0].submit();
	 }
		}
		if((cattype=="SSI")||(cattype=="CORP")||(cattype=="SME"))
        {
        if(ConfirmMsg(100))
	 {
		document.forms[0].action=appUrl+"action/comsearch.jsp?&id="+document.forms[0].id.value;
		document.forms[0].submit();
	 }
		}
}

function onedit()
{
	
	document.forms[0].activity_comment.readOnly=false;
	enableButtons(true,false,false,true);
}

function apply()
{
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updateActivity";
	document.forms[0].hidSourceUrl.value="/action/com_activitydet.jsp";
	document.forms[0].submit();
}

//Help function added by vino
function dohlp()     
{
  var hlpvar = appUrl+"phlp/corp_propobriefbg_noact.htm";
  var title = "NatureOfActivities";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}
</script>
</head>

<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#EEEAE3" onload="placevalues()">
<jsp:include page="../share/help.jsp" flush="true"/> 

<form name="frmpri" method = post>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
			<td valign="top" colSpan=5> 
              <jsp:include page="../share/menus.jsp" flush="true"/> 
              <jsp:include page="../com/proposallinks.jsp" flush="true"> 
              <jsp:param name="pageid" value="1" />
			   <jsp:param name="cattype" value="<%=strCategoryType%>" />
			  <jsp:param name="ssitype" value="<%=strSSIType%>" />
			
              </jsp:include>
            </td>
          </tr>
        </table>
  <b><i>Home-&gt; Corporate-&gt; 
  Proposal-&gt; Brief Background-&gt; Nature of Activities</i></b> <span style="display:none"><laps:borrowertype /></span> 
  <laps:application/> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td valign="bottom"> 
        <table width="55%" border="0" cellspacing="3" cellpadding="3" align="left">
          <tr> 
            <td width="39%"  align="center" bgcolor="#EEEAE3" id="prin"><b>a href="javascript:call_page('com_companydet.jsp')" class="blackfont">Borrower 
              Demographics </a></b></td>
             <%--
			  if(strCategoryType.equals("CORP") || strCategoryType.equals("SME"))
			  {
			  %>

            <td width="24%"  align="center" bgcolor="#EEEAE3" id="prin">b><a href="javascript:call_page('com_promdet.jsp')" class="blackfont">Promoters</a></b></td>
				<%
			  }
			else
				{
				%>
				 <td width="24%"  align="center" bgcolor="#EEEAE3" id="prin">b><a href="javascript:call_page('com_ssi_promdet.jsp')" class="blackfont">Promoters</a></b></td>
					 <%
				}
					 --%>
            <td width="37%"  align="center" bgcolor="#71694F" id="prin"><b><font  color="#FFFFFF">Nature 
              of Activities</font></b><</td>
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
                          <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="1" cellpadding="4">
                                  <tr align="center"> 
                                    <td colspan="3" bgcolor="#71694F"><font  color="#FFFFFF"><b>Details 
                                      of Manufacturing Activities</font></b></td>
                                    <td colspan="3" bgcolor="#71694F" width="54%"><font  color="#FFFFFF"><b>Details 
                                      of Trading Activities</font></b></td>
                                  </tr>
                                  <%
							ArrayList	  v = (ArrayList) hshValues.get("manfactureactivity");
			ArrayList v1 = (ArrayList)hshValues.get("tradingactivity");			
			String val="",val1="";
		
				int  vecsize=0;
				 int vecsize1=0;
				int  finsize = 0;
							if(v!=null)
							{
								vecsize =v.size();

							}
						if (v1 != null)
							{
								vecsize1 =v1.size();
							}
							if (vecsize > vecsize1)
							{
								finsize = vecsize;
							}
							else
							{
								finsize = vecsize1;
							}
							
							for(int l=0;l<finsize;l++)
							{
								val1="";
								if (vecsize > l)
								{
								g1 = (ArrayList)v.get(l);
								val1 = l+1+"."+Helper.correctNull((String)g1.get(0));
									
								}
								
								val="";
								if (vecsize1 > l)
								{
								
								g2 = (ArrayList)v1.get(l);
								val = l+1+"."+Helper.correctNull((String)g2.get(0));
									
								}
								
								
									
					%>
                                  <tr> 
                                    <td colspan="3" bgcolor="#EEEAE3">&nbsp;<%=val1%></td>
                                    <td colspan="3" width="54%" bgcolor="#EEEAE3">%=val%></td>
                                  </tr>
                                  <%
							}
										%>
                                  <tr> 
                                    <td colspan="6">&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td colspan="6">b>Details 
                                      of Group Companies</b></td>
                                  </tr>
                                  <tr align="center"> 
                                    <td colspan="3" bgcolor="#71694F"><font  color="#FFFFFF"><b>Name 
                                      of the Company / Firm</font></b></td>
                                    <td colspan="3" bgcolor="#71694F" width="54%"><font  color="#FFFFFF"><b>Nature 
                                      of Activity</font></b></td>
                                  </tr>
                                  <%
								  v = (ArrayList) hshValues.get("vecSisterConcerns");
		
				 vecsize=0;
							if(v!=null)
							{
								vecsize =v.size();

							}
							for(int l=0;l<vecsize;l++)
							{
								g1 = (ArrayList)v.get(l);
								%>
                                  <tr> 
                                    <td colspan="3" bgcolor="#EEEAE3">&nbsp;<%=l+1+".     "+Helper.correctNull((String)g1.get(0))%></td>
                                    <td colspan="3" width="54%" bgcolor="#EEEAE3">%=Helper.correctNull((String)g1.get(1))%></td>
                                  </tr>
                                  <%
							}
										%>
                                  <tr> 
                                    <td colspan="3">&nbsp;</td>
                                    <td colspan="3" width="54%">&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td colspan="3">b>Comments</b></td>
                                    <td colspan="3" width="54%">&nbsp;</td>
                                  </tr>
                                </table>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tr> 
                                    <td> 
                                      <textarea name="activity_comment" cols="120" wrap="VIRTUAL" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("activcomment"))%></textarea></td>
                                      <%//String strB=Helper.correctNull((String)hshValues.get("activcomment"));
									 // if (!(strB.trim().equals("")))
									 // {
												//  StringTokenizer strIdV1 = new StringTokenizer(strB,"\n");
											//	  while (strIdV1.hasMoreTokens())			
												//	{
												//	 String strTempV1=(String)strIdV1.nextToken();
												//	 out.print(strTempV1);
												///	}
									//  }
									  %>
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
                <input type="button" name="cmdhelp" value="Help"  style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="dohlp()">
              </div>
            </td>
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdclose" value="Close"  style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"  onClick="callclose()">
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
			<input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
<input type="hidden" name="ssitype" value="<%=strSSIType%>"> 
 <input type="hidden" name="id" value="<%=strBorrowerType%>">	
			
</form>
</body>
<!-- 
<script language="javascript1.2">
editor_generate('activity_comment');
</script>
 --> 
</html>
