<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror />
<%
ArrayList g1= new ArrayList();
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
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function call_page(url)
{
	
	document.forms[0].action=appURL+"action/"+url;
	document.forms[0].submit();
	
}
</script>
</head>

<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#EEEAE3">

<form name="frmpri" method = post>
  <table width="100%" border="1" cellspacing="0" cellpadding="0" bgcolor="#EEEAE3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  >
    
  </table>
  <b><i>Brief Background</i></b><br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td valign="bottom"> <laps:application/> </td>
    </tr>
    <tr> 
      <td valign="bottom">&nbsp; </td>
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
                          <table width="40%" border="0" cellspacing="3" cellpadding="3" align="left">
                            <tr> 
                              <td width="25%"  align="center" bgcolor="#EEEAE3" id="prin"><b><font size="1" face="MS Sans Serif"><a href="javascript:call_page('comcompanydet.jsp')" class="blackfont">Company</a></font></b></td>
                              <td width="17%"  align="center" bgcolor="#EEEAE3" id="prin"><font size="1" face="MS Sans Serif"><b><a href="javascript:call_page('compromdet.jsp')" class="blackfont">Promoters</a></b></font></td>
                              <td width="17%"  align="center" bgcolor="#71694F" id="prin"><b><font  color="#FFFFFF">Activities</font></b></td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td> <br>
                          <table width="70%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center" >
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="1" cellpadding="4">
                                  <tr> 
                                    <td colspan="3"><font size="1" face="MS Sans Serif"><b>Details 
                                      of Manufacturing Activities</b></font></td>
                                    <td colspan="3" align="center" width="56%"><font size="1" face="MS Sans Serif"><b> 
                                      </b></font></td>
                                  </tr>
                                  <%
					ArrayList v = (ArrayList) hshValues.get("manfactureactivity");
		
				int vecsize=0;
							if(v!=null)
							{
								vecsize =v.size();

							}
							for(int l=0;l<vecsize;l++)
							{
								g1 = (ArrayList)v.get(l);
					%>
                                  <tr> 
                                    <td colspan="3"><font size="1" face="MS Sans Serif"><%=l+1+".     "+Helper.correctNull((String)g1.get(0))%>&nbsp;</font></td>
                                    <td colspan="3" width="56%"><font size="1" face="MS Sans Serif">&nbsp</font></td>
                                  </tr>
                                 
                                  <%
							}
										%>
										 <tr>
                                    <td colspan="3">&nbsp;</td>
                                    <td colspan="3" width="56%">&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td colspan="3"><font size="1" face="MS Sans Serif"><b>Details 
                                      of Trading Activities</b></font></td>
                                    <td colspan="3" width="56%"><font size="1" face="MS Sans Serif"><b> 
                                      </b></font></td>
                                  </tr>
                                  <%
					 v = (ArrayList) hshValues.get("tradingactivity");
		
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
                                    <td colspan="3"><font size="1" face="MS Sans Serif"><%=l+1+".     "+Helper.correctNull((String)g1.get(0))%>&nbsp;</font></td>
                                    <td colspan="3" width="56%"><font size="1" face="MS Sans Serif">&nbsp</font></td>
                                  </tr>
                                  <%
							}
										%>
                                  <tr> 
                                    <td colspan="6">&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td colspan="6"><font size="1" face="MS Sans Serif"><b>Details 
                                      of Group Compaties (Group Exposure Overview 
                                      enclosed)</b></font><font size="1" face="MS Sans Serif"></font></td>
                                  </tr>
                                  <tr> 
                                    <td colspan="3" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b>Name 
                                      of the Company / Firm</b></font></td>
                                    <td colspan="3" bgcolor="#EEEAE3" align="center" width="56%"><font size="1" face="MS Sans Serif"><b>Nature 
                                      of Activity</b></font></td>
                                  </tr>
                                  <%
										v = (ArrayList) hshValues.get("companyactivity");
		
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
                                    <td colspan="3"><font size="1" face="MS Sans Serif"><%=l+1+".     "+Helper.correctNull((String)g1.get(0))%>&nbsp;</font></td>
                                    <td colspan="3" width="56%"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)g1.get(1))%>&nbsp</font></td>
                                  </tr>
                                  <%
							}
										%>
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
</form>
</body>
</html>
