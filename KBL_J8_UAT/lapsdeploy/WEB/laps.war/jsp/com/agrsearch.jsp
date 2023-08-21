<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Agriculture-Existing Application form</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varoldid="<%=Helper.correctNull((String)request.getParameter("id"))%>";
var varappname="<%=Helper.correctNull((String)request.getParameter("appname"))%>";
var varcategorytype="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>";
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
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrborrowersearch.jsp?hidPageType=<%=request.getParameter("hidPageType")%>&hidCategoryType="+document.forms[0].hidCategoryType.value;
		}
		document.forms[0].submit();
	}
}
function doNew()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/comloanhistroy.jsp?comapp_id="+document.forms[0].hidapplicantid.value+"&comapp_oldid="+varoldid+"&comapp_compid="+document.forms[0].hidapplicantid.value+"&comapp_compname="+varappname;
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="exist" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr>
            <td valign="top" class="page_flow">Home -&gt; Tertiary</td>
          </tr>
        </table>		
      </td>
    </tr>
 </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable border1">
                <tr> 
                  <td height="70" valign="top"> <br>
                    <table width="80%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
                      <tr> 
                        <td height="0" valign="top"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
                            <tr> 
                              <td> 
                                <table width="30%" border="0" align="center" cellspacing="0" cellpadding="0" class="outertable border1">
                                  <tr align="center">
                                		<td id="idnewbuton" style="visibility:hidden">
                                			<%if (strGroupRights.charAt(8) == '1'
					&& strGroupRights.charAt(18) == 'w'
					&& (strOrgLevel.equals("A") || (strOrgLevel.equals("D") && strIsSaral
							.equals("Y")))) {%>
											<input type="button" name="cmdnew" value="New Application" onClick="doNew()" class="buttonStyle"
											style="width:100%"/>
							
							<%} %>
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
                    <table width="80%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
                      <tr> 
                        <td valign="top" id="searchheading"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
                            <tr align="center" class="dataheader"> 
                              <td width="24%">Application No.</td>
                              <td width="51%" >Borrower Name </td>
                              <td width="25%" > Process Status</td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top"><iframe id="result" src="<%=ApplicationParams.getAppUrl()%>action/agrresult.jsp?hidBeanGetMethod=getDataFinal&hidBeanId=borrowersearch&applicantoldid=<%=Helper.correctNull((String)request.getParameter("applicantoldid"))%>&hidCategoryType=<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>&hidPageType=<%=request.getParameter("hidPageType")%>&comapp_compname=<%=Helper.correctNull((String)request.getParameter("appname"))%>&select_cat=Tertiary" width="100%" height=220 > </iframe> </td>
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
  <lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> <br>
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>"> 
<input type="hidden" name="hidapplicantid">
<input type="hidden" name="hidPageType" value="<%=request.getParameter("hidPageType")%>">
</form>
</body>
</html>
