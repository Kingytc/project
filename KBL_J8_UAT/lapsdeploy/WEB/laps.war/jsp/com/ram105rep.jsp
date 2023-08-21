<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Rating</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>


<body>
<form method="post" >
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="outertable border1">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="3">
      
      <tr>
        <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr> 
                  <td colspan="3"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td align="center"><strong>KARNATAKA BANK LTD. </strong></td>
                      </tr>
                      <tr> 
                        <td align="center"><strong><%=Helper.correctNull((String)hshValues.get("branchname"))%> &nbsp;
                          Branch </strong></td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr align="center"> 
                  <td colspan="3"><b>Details of Risk Rating</b></td>
                </tr>
                <tr> 
                  <td width="4%" valign="top"><strong>1.</strong></td>
                  <td>Branch</td>
                  <td width="63%"><%=Helper.correctNull((String)hshValues.get("branchname"))%></td>
                </tr>
                <tr> 
                  <td valign="top"><strong>2.</strong></td>
                  <td>Rating Finalised By - Branch / Region / FGMO</td>
                  <td><%=Helper.correctNull((String)hshValues.get("regionname"))%></td>
                </tr>
                <tr> 
                  <td valign="top"><strong>3.</strong></td>
                  <td>Borrower's Name &amp; ID</td>
                  <td><%=Helper.correctNull((String)hshValues.get("companyname"))%>&nbsp;&amp;&nbsp;<%=Helper.correctNull((String)hshValues.get("companycode"))%></td>
                </tr>
                <tr> 
                  <td valign="top"><strong>4.</strong></td>
                  <td>Structured Message Ref. No. &amp; Date of Rating</td>
                  <td><%=Helper.correctNull((String)hshValues.get("dateoffinalisation"))%></td>
                </tr>
                <tr> 
                  <td valign="top"><strong>5.</strong></td>
                  <td>Last rated with Date and rating <br />
                    ( In case of review / renewal a/cs )</td>
                  <td><%=Helper.correctNull((String)hshValues.get("lastrateddate_basemodel"))%> 
                  </td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                  <td> - Base Model (Bank Model)</td>
                  <td> 
                    <div id="top"> 
                      <table width="75%" border="0">
                        <tr align="center"> 
                          <td>Date</td>
                          <td>Score</td>
                          <td>Rating Grade</td>
                          <td>Risk Definition</td>
                        </tr>
                        <tr> 
                          <td><%=Helper.correctNull((String)hshValues.get("lastrateddate_basemodel"))%>&nbsp;</td>
                          <td><%=Helper.correctNull((String)hshValues.get("lastscore_basemodel"))%>&nbsp;</td>
                          <td><%=Helper.correctNull((String)hshValues.get("lastrating_basemodel"))%>&nbsp;</td>
                          <td><%=Helper.correctNull((String)hshValues.get("lastgradef_basemodel"))%>&nbsp;</td>
                        </tr>
                      </table>
                    </div>
                  </td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                  <td>- Dynamic Model (CRISIL Model)</td>
                  <td> 
                    <div id="top"> 
                      <table width="75%" border="0">
                        <tr align="center"> 
                          <td rowspan="2">Date</td>
                          <td rowspan="2">Score</td>
                          <td colspan="2">Rating Grade</td>
                          <td rowspan="2">Risk Definition</td>
                        </tr>
                        <tr align="center"> 
                          <td>Obligor</td>
                          <td>Combined</td>
                        </tr>
                        <tr> 
                          <td><%=Helper.correctNull((String)hshValues.get("lastrateddate_dynamicmodel"))%>&nbsp;</td>
                          <td><%=Helper.correctNull((String)hshValues.get("lastscore_dynamicmodel"))%>&nbsp;</td>
                          <td><%=Helper.correctNull((String)hshValues.get("lastrating_dynamicmodel"))%>&nbsp;</td>
                          <td><%=Helper.correctNull((String)hshValues.get("lastcombinedrating_dm"))%>&nbsp;</td>
                          <td><%=Helper.correctNull((String)hshValues.get("lastgradef_dynamicmodel"))%>&nbsp;</td>
                        </tr>
                      </table>
                    </div>
                  </td>
                </tr>
                <tr> 
                  <td valign="top"><strong>6.</strong></td>
                  <td>Credit Rating assigned now with reference to Base Year <%=Helper.correctNull((String)hshValues.get("base_year"))%> 
                  </td>
                  <td>&nbsp;</td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                  <td> - Base Model (Bank Model)</td>
                  <td> 
                    <div id="top"> 
                      <table width="75%" border="0">
                        <tr align="center"> 
                          <td>Date</td>
                          <td>Score</td>
                          <td>Rating Grade</td>
                          <td>Risk Definition</td>
                        </tr>
                        <tr> 
                          <td><%=Helper.correctNull((String)hshValues.get("currentratingdate_basemodel"))%>&nbsp;</td>
                          <td><%=Helper.correctNull((String)hshValues.get("currentscore_basemodel"))%>&nbsp;</td>
                          <td><%=Helper.correctNull((String)hshValues.get("currentrating_basemodel"))%>&nbsp;</td>
                          <td><%=Helper.correctNull((String)hshValues.get("currentgradef_basemodel"))%>&nbsp;</td>
                        </tr>
                      </table>
                    </div>
                  </td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                  <td>- Dynamic Model (CRISIL Model)</td>
                  <td> 
                    <div id="top"> 
                      <table width="75%" border="0">
                        <tr align="center"> 
                          <td rowspan="2">Date</td>
                          <td rowspan="2">Score</td>
                          <td colspan="2">Rating Grade</td>
                          <td rowspan="2">Risk Definition</td>
                        </tr>
                        <tr align="center"> 
                          <td>Obligor</td>
                          <td>Combined</td>
                        </tr>
                        <tr> 
                          <td><%=Helper.correctNull((String)hshValues.get("currentratingdate_dynamicmodel"))%>&nbsp;</td>
                          <td><%=Helper.correctNull((String)hshValues.get("currentscore_dynamicmodel"))%>&nbsp;</td>
                          <td><%=Helper.correctNull((String)hshValues.get("currentrating_dynamicmodel"))%>&nbsp;</td>
                          <td><%=Helper.correctNull((String)hshValues.get("currentcombinedrating_dm"))%>&nbsp;</td>
                          <td><%=Helper.correctNull((String)hshValues.get("currentgradef_dynamicmodel"))%>&nbsp;</td>
                        </tr>
                      </table>
                    </div>
                  </td>
                </tr>
                <tr> 
                  <td valign="top"><strong>7.</strong></td>
                  <td valign="top">Rating Rationale </td>
                  <td><%=Helper.correctNull((String)hshValues.get("ratingrationale"))%></td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td align="right">&nbsp;</td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td align="right">&nbsp;</td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td align="right">&nbsp;</td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td align="right"><strong>DIGITAL SIGNATURE OF RATING HEAD </strong></td>
                </tr>
              </table>
            </td>
      </tr>
      
    </table></td>
  </tr>
</table>
 </form>	
</body>
</html>

