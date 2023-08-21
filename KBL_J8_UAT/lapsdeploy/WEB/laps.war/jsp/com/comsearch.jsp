<%@include file="../share/directives.jsp"%>
<%

session.setAttribute("HidCategory",Helper.correctNull((String)request.getParameter("Type")));
String strhidmoduletype="";
strhidmoduletype=Helper.correctNull((String)request.getParameter("hidModuleType"));
%>

<html>
<head>
<title>Commercial-Existing Application form</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function showBlank()
{
	document.all.result.src=appURL+'action/blank.jsp';
}

function resetme()
{
	document.forms[0].reset();
	document.all.result.src=<%=ApplicationParams.getAppUrl()%>+'action/blank.jsp';
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

	appno = document.forms[0].srchvalue.value;	
	document.all.result.src="<%=ApplicationParams.getAppUrl()%>action/comresult.jsp?hidBeanGetMethod=getDataFinal&hidBeanId=borrowersearch&id=<%=Helper.correctNull((String)request.getParameter("id"))%>&hidCategoryType=<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>&appno="+appno+"&comapp_compname=<%=Helper.correctNull((String)request.getParameter("comapp_compname"))%>&hidPageType=<%=Helper.correctNull((String)request.getParameter("hidPageType"))%>&From_date=<%=Helper.correctNull((String)request.getParameter("From_date"))%>&To_date=<%=Helper.correctNull((String)request.getParameter("To_date"))%>&hidModuleType=<%=strhidmoduletype%>";
}

function doNew()
{ 
	if(('<%=strOrgLevel%>'=='D') &&('<%=strIsSaral%>'=='Y'))
	{
		document.forms[0].applevel.value="S";
	}
		
	var comapp_id="<%=Helper.correctNull((String)request.getParameter("comapp_oldid"))%>";
	var appname="<%=Helper.correctNull((String)request.getParameter("comapp_compname"))%>";
	var categoryType="<%=Helper.correctNull((String)request.getParameter("hidPageType"))%>";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/facilities.jsp?hidBeanId=facilities&hidBeanGetMethod=getFacilityData&hidCategoryType="+categoryType+"&compname="+appname+"&appno=new&valuesin=L&hidapplicantid="+document.forms[0].comapp_id.value+"&hidappoldid="+comapp_id;
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}
function dohlp()     
{
  var hlpvar = <%=ApplicationParams.getAppUrl()%>+"phlp/corp_search.htm";
  var title = "CorporateSearch";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body>
<form name="exist" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	    <%if(request.getParameter("hidPageType").equalsIgnoreCase("SRE")){ %>
        <tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Short Review/Extension  </td>
	</tr>
	<%}else if(request.getParameter("hidPageType").equalsIgnoreCase("STL")){  %>
	 <tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Short Term Loan  </td>
	</tr>
        <%} else{%>
          <tr>
            <td class="page_flow">Home&nbsp;-&gt;&nbsp;Corporate</td>
          </tr>


          <%} %>
        </table>		
      </td>
    </tr>
 </table>

  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr> 
                  <td valign="top"> <br>
                    <table width="80%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
                      <tr> 
                        <td valign="top"> 
                        
						 <%if(Helper.correctNull((String)request.getParameter("hidPageType")).equalsIgnoreCase("SRE")) 
						  {
						  %>
						  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                                  <tr> 
                                    <%
									 if(strGroupRights.charAt(18) =='w' && (strOrgLevel.equals("A")) || strGroupRights.charAt(18) =='w' &&  (strOrgLevel.equals("D")) &&  (strIsSaral.equals("Y")) ){
									%>
									<td align="center">
									 <input type="button" name="cmdNew" value="New Short Review" class="buttonStyle" style="width:175" onClick="doNew()">
									 <input type="hidden" name="hidPropType" value="E"> 
									</td>
									<%} %>
								  </tr>
                                </table>
                              </td>
                            </tr>
                          </table>
                          <%
                          }
                            else if(Helper.correctNull((String)request.getParameter("hidPageType")).equalsIgnoreCase("ADC"))
                          {
                            	%>
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                                  <tr> 
                                    <%if(strGroupRights.charAt(18) =='w' && (strOrgLevel.equals("A")) || strGroupRights.charAt(18) =='w' &&  (strOrgLevel.equals("D")) &&  (strIsSaral.equals("Y"))){%>
										
                                    <td align="center">
                                      <input type="button" name="cmdNew2" value="New Adhoc" class="buttonStyle" style="width:175" onClick="doNew()">
									  <input type="hidden" name="hidPropType" value="H"> 
                                    </td>
									<% }%>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                          </table>
                          <%}
                            else if(Helper.correctNull((String)request.getParameter("hidPageType")).equalsIgnoreCase("STL"))
                            { %>
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                                  <tr> 
                                    <%
									if(strGroupRights.charAt(18) =='w' && (strOrgLevel.equals("A")) || strGroupRights.charAt(18) =='w' &&  (strOrgLevel.equals("D")) &&  (strIsSaral.equals("Y"))){
									%>
										<td align="center"><input type="button" name="cmdNew" value="New Short Term Loan" class="buttonStyle" style="width:175" onClick="doNew()">
										<input type="hidden" name="hidPropType" value="V"> 
										</td>
									<% }%>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                          </table>
                        <%} %>
                        </td>
                      </tr>
                    </table>
                    <br>
                    <table width="80%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
                      <tr> 
                        <td valign="top" id="searchheading"> 
                          <table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
                            <tr align="center" class="dataheader"> 
                              <td width="15%">Proposal No.</td>
                              <td width="32%">Borrower Name</td>
                              <td width="23%">Process Status</td>
                              <td width="25%">Proposal Type</td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top"><iframe id="result" src="<%=ApplicationParams.getAppUrl()%>action/comresult.jsp?hidBeanGetMethod=getDataFinal&hidBeanId=borrowersearch&id=<%=Helper.correctNull((String)request.getParameter("id"))%>&hidCategoryType=<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>&hidSSIType=<%=Helper.correctNull((String)request.getParameter("hidSSIType"))%>&hidPageType=<%=request.getParameter("hidPageType")%>&comapp_compname=<%=Helper.correctNull((String)request.getParameter("comapp_compname"))%>&From_date=<%=Helper.correctNull((String)request.getParameter("From_date"))%>&To_date=<%=Helper.correctNull((String)request.getParameter("To_date"))%>&select_cat=<%=Helper.correctNull((String)request.getParameter("select_cat"))%>&appno=<%=Helper.correctNull((String)request.getParameter("srch_txtval"))%>&hidModuleType=<%=strhidmoduletype%>&idnew=<%=Helper.correctNull((String)request.getParameter("idnew"))%>" width="100%" height=220 > </iframe> </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
             </table>
      </td>
    </tr>
  </table>
  <br>
  <table border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
    <tr> 
      <td> 
        <table width="0%" border="0" cellspacing="0" cellpadding="2" class="outertable">
          <tr valign="middle"> 
            <td> 
              <div align="center"> 
                <input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="doClose()">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
<input type="hidden" name="hidPageType" value="<%=request.getParameter("hidPageType")%>"> 
<input type="hidden" name="hidPage" value="<%=request.getParameter("hidPage")%>"> 
<input type="hidden" name="comapp_id" value="<%=request.getParameter("comapp_id")%>"> 
<input type="hidden" name="comapp_compname" value="<%=request.getParameter("comapp_compname")%>"> 
<input type="hidden" name="comapp_compid" value="<%=request.getParameter("comapp_compid")%>"> 
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>"> 
<input type="hidden" name="From_date" value="<%=Helper.correctNull((String)request.getParameter("From_date"))%>"> 
<input type="hidden" name="To_date" value="<%=Helper.correctNull((String)request.getParameter("To_date"))%>"> 
<input type="hidden" name="applevel" value=""/>
<input type="hidden" name="srchvalue" value="<%=Helper.correctNull((String)request.getParameter("srch_txtval"))%>"/>
</form>
</body>
</html>
