<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<lapschoice:handleerror />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ page import="java.util.*,java.io.*"%>
<%
	if (objValues instanceof java.util.HashMap) 
	{
		hshValues = (java.util.HashMap) objValues;
	}
%>

<html>
<head>
<title>Personal - Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/per/perapplicantdisp.js"></script>

<STYLE>

DIV.cellContainer {	
  width: 100%; height: 100%;
  overflow: auto;
}
</STYLE>



<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" vlink="#330000" alink="#330000"
	leftmargin="0" topmargin="0" marginwidth="0" margin
	onload="callonLoad();enableSince();showBranch();getlocationvalues();
	showres();showcoun();shownri();showStaffBox()">
	
	<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url=""><script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>
<!-- <body bgcolor="#EEEAE3" text="#000000"  vlink="#330000" alink="#330000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="callonLoad();">-->
<form name="appform" method="post" action="">
  <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td id="mainlnk1"> 
     
        <jsp:include page="../share/Applurllinkper.jsp" flush="true" > 
        <jsp:param name="pageid" value="1" />
        </jsp:include>
        
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><font face="Times New Roman" size="3"><b><i>Home -&gt; Retail -&gt; 
        <%= (String)session.getAttribute("pgeLabel")%>-&gt; Applicant -&gt;Demographics </i></b></font></td>
    </tr>
  </table>
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr> 
      <td id="mainlnk1"> <lapschoice:application /> </td>
    </tr>
  </table>
 <%--  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td colspan="2" valign="bottom"> 
        <table width="99%" border="0" cellspacing="3" cellpadding="3" align="left">
          <tr align="center"> 
            <td width="12%" bgcolor="#EEEAE3"><b><a href="JavaScript:loanDetails()" class="blackfont">Loan 
              Product</a></b></td>
            <td width="13%" bgcolor="#71694F"><b><font  color="#FFFFFF">Demographics</font></b></td>
            <td width="15%" bgcolor="#EEEAE3"><b><a href="JavaScript:callIncomeExpenses()" class="blackfont">Income 
              &amp; Expenses</a></b></td>
            <td width="15%" id="employertdbtn1" bgcolor="#EEEAE3"  ><b><a href="JavaScript:callEmployer()" class="blackfont">Employment 
              Details </a></b></td>
            <td width="15%"  height="16" bgcolor="#EEEAE3" ><b><a href="javascript:callProposedAsset()" class="blackfont">Proposed 
              Asset</a></b></td>
            <td width="18%"  height="16" bgcolor="#EEEAE3"><font face="MS Sans Serif" size="1"><font color="#CCCCCC"><b><a href="JavaScript:callCoAppGuarantor()" class="blackfont">Co-Applicant 
              / Guarantor</a></b></font></font></td>
            <%if(loan_steptype.equalsIgnoreCase("2")||loan_steptype.equalsIgnoreCase("3"))
				
			{%>
            <td width="18%"  height="16" bgcolor="#EEEAE3"><font face="MS Sans Serif" size="1"><font color="#CCCCCC"><b><a href="JavaScript:callSteptype()" class="blackfont">StepUp 
              / Down</a></b></font></font></td>
            <%}%>
          </tr>
        </table>
      </td>
    </tr>
  </table>--%>
  
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td valign="bottom">
			<table width="93%" border="0" cellspacing="0" cellpadding="0" align="left">
				<tr align="center"> 
        			<td>
             			<jsp:include page="../per/applicanttab.jsp" flush="true"> 
             			<jsp:param name="linkid" value="2" />
                        </jsp:include>
            		</td>
        		</tr>
      		</table>
		</td>
	</tr>
</table>
  
        
       
<%@include file="per_commoncustdemographics.jsp"%>
<tr> 
      <td> 
        <table width="43%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top"> 
            <td> 
              <input type="button" name="cmdEdit" value="Edit" tabindex="79"
					style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50;visibility:hidden"
					onClick="callEdit()" >
            </td>
            <td> 
              <input type="button" name="cmdapply" value="Save" tabindex="80"
					style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50; visibility:hidden"
					onClick="doSave()">
            </td>
            <td> 
              <input type="button" name="cmdCancel" value="Cancel" tabindex="81"
					style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50; visibility:hidden"
					onClick="callCancel()">
            </td>
            <td> 
              <input type="button" name="cmdDelete" value="Delete" tabindex="82"
					style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50; visibility:hidden"
					onClick="callDelete()">
            </td>
            <td> 
              <input type="button" name="cmdModify" value="Modify" tabindex="83"
					style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50; visibility:hidden"
					onClick="callModify()" disabled>
            </td>
            <td> 
              <input type="button" name="cmdHelp" value="Help" tabindex="84"
					style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50; visibility:hidden"
					onClick="doHelp('loan_appretail_appdemo.htm')">
            </td>
            <td> 
              </td>
            <td id="n1"> 
              <input type="button" name="cmdNridetails" value="NRI Details" tabindex="86"
					onClick="callNRI()"
					style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:100; visibility:hidden"> 
            </td>
            <td> 
             <input type="button" name="cmdClose" value="Close" tabindex="85"
					onClick="callClose()"

					style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"> 
           
              <input type="button" name="cmdReferences" value="References" tabindex="87"
					onClick="callReferences()"
					style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:100; visibility:hidden"> 
            </td>
            <td id="m1" width="0"> 
              <input type="button" name="cmdDirectors" tabindex="88"
					value="Partners/Co- Partners /HUF/Directors" onClick="callDirectors()" 
					style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:240; visibility:hidden"> 
            </td>
            <td> 
            
              <input type="button" name="cmdAdditionalparameter" value="CBS Customer Data" tabindex="87"
					onClick="ShowAdditionalParameter('additionalParameter.jsp')"
					style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:150; visibility:hidden"> 
            </td>
            <!--  <td><input type="button" name="cmdSuppliers" value="Supplier" tabindex="82"
					onClick="callSupplier()"
					style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:100">
				</td> -->
          </tr>                     
          </table>
              
                              
  <INPUT TYPE="hidden" name="hidApp_type" value='A'>
  <INPUT TYPE="hidden" name="page" value="ep">
  <INPUT TYPE="hidden" name="radLoan" value="Y">
   <INPUT TYPE="hidden" name="hidDemoId" value="<%=(String)request.getParameter("hidDemoId")%>">
  <INPUT TYPE="hidden" name="hidAppType">
<lapschoice:hiddentag/>
  <input type="hidden" name="hid_comappid1" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>">
  <input type="hidden" name="hid_comappid2" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>">
   <input type="hidden" name="hidcity" value="<%=Helper.correctNull((String)hshValues.get("perapp_city_code"))%>">
  <input type="hidden" name="hidPermCity" value="<%=Helper.correctNull((String)hshValues.get("perapp_permcity_code"))%>"> 
  <input type="hidden" name="hidcity1" value="<%=Helper.correctNull((String)hshValues.get("perapp_permcity_code"))%>">
  <input type="hidden" name="hidstate" value="<%=Helper.correctNull((String)hshValues.get("perapp_state_code"))%>">
  <input type="hidden" name="hidstate1" value="<%=Helper.correctNull((String)hshValues.get("perapp_permstate_code"))%>">
</form>
</body>
</html>
 
