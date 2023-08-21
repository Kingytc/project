<%@include file="../share/directives.jsp"%>
<%
ArrayList arryCol=null;
ArrayList arryRow=(ArrayList)hshValues.get("arrVal");
String total1="";
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
if(schemetype. trim().equalsIgnoreCase(""))
{
	schemetype="0";
}

String prd_type = Helper.correctNull((String) session.getAttribute("strProductType"));
String strPrdPurpose=Helper.correctNull((String) session.getAttribute("strPrdPurpose"));
String strProAvailableFor =Helper.correctNull((String) hshValues.get("prd_applicablefor"));
int linkid = Integer.parseInt(Helper.correctInt(request.getParameter("linkid")));
String strFreezeflag = Helper.correctNull((String)hshValues.get("strFreezeflag"));

%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/per/perotherassests.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var editflag = 1;
var appURL  ="<%=ApplicationParams.getAppUrl()%>"; 
var auto_appno="<%=Helper.correctNull((String)hshValues.get("auto_appno"))%>";
var strvalue="loan_appretail_apppropasset_other.htm";
var varRecordFlag="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
var varstrSessionModuleType="<%=strSessionModuleType%>";
var schemetype="<%=schemetype%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";

<% double total = 0.00;%>
function onloading()
{	
	disableFields(true);
	document.all.sel_scheme.value="<%=schemetype%>";
}

function disableCommandButtons(edit,apply,cancel,del,close)
{
  	document.forms[0].cmdedit.disabled=edit;
  	document.forms[0].cmdsave.disabled=apply;
  	document.forms[0].cmdcancel.disabled=cancel;
  	document.forms[0].cmddelete.disabled=del;
 	document.forms[0].cmdclose.disabled=close;
}
function disableFields(flag)
{	
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].readOnly=flag;		  
		}
	}
}


function gototab(beanid,methodname,pagename)
{
	if(document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appUrl,name);
	}
}
function callLink(page,bean,method)
{ 
		if (document.forms[0].cmdsave.disabled)
		{
			document.forms[0].hidAction.value="";
		 	document.forms[0].hidBeanGetMethod.value=method;
		 	document.forms[0].hidBeanId.value=bean;
		 	document.forms[0].action=appURL+"action/"+page;
		 	document.forms[0].submit();
		}
		else 
		{
			ShowAlert(103);
		}
}	
function callMDTD()
{
	document.forms[0].action=appURL+"action/app_sec_MDTDdetails.jsp";
	document.forms[0].submit();	
}
function callLinkComments(page,bean,method,title)
{
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidAction.value="";
	 	document.forms[0].hidBeanGetMethod.value=method;
	 	document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].hpage.value=title;	 
	 	document.forms[0].action=appURL+"action/"+page;
	 	document.forms[0].submit();
	}
	else 
	{
		ShowAlert(103);
	}
}
function callalert()
{
	alert("Click Freeze in Attached Securities page to view Security Coverage");
	return;
}
</script>
</head>
<body onload="onloading()">
<form name="fininc" method="post" class="normal">
<%
if(strSessionModuleType.equalsIgnoreCase("AGR"))
{%>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="999" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
      <td class="page_flow">Home -&gt; Agriculture -&gt; Minor Irrigation -&gt; Supplier Details
      				</td>
	</tr>
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="94" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>

<%}else
	{%>
 
  
<%if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="22" />
        </jsp:include>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
	 <%if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">Home -&gt; Agriculture -&gt;Application -&gt; Security Master -&gt; Proposed/Offered Asset -&gt; House </td>
	<%}else{%>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Application  -&gt; Security Master -&gt; Proposed/Offered Asset -&gt; House</td>
		<%} %>			
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
      <td>
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr align="center"> 
            <td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callLink('securitymaster_retail.jsp','bankappfi','getSecurityRetailDetails')">Borrower Securities</a></b></b>
            </td>
            <td align="center" width="15%" class="sub_tab_inactive"><b><b><a
					href="#" onclick="javascript:callLink('attachedsecurities_retail.jsp','bankappfi','getAttachedRetailSecurityDetails')">Attached Securities</a></b></b></td>
        
           <%if(strSessionModuleType.equals("RET")){ %>
           
          	<%
				  if (prd_type.substring(0, 1).equalsIgnoreCase("p")
								&& !prd_type.equalsIgnoreCase("pE")
								&& !prd_type.equalsIgnoreCase("pG")
								&& !prd_type.equalsIgnoreCase("pM")
								&& !prd_type.equalsIgnoreCase("pL")
								&& !prd_type.equalsIgnoreCase("pI")) {
							if (linkid == 5) {
				%>
				<td class="sub_tab_active" WIDTH="15%" nowrap="nowrap"><b>Proposed/Offered
				Asset</b></td>
				<%
					} else if ((prd_type.equalsIgnoreCase("pH")&& !(strPrdPurpose.equalsIgnoreCase("F")||strPrdPurpose.equalsIgnoreCase("T")||strPrdPurpose.equalsIgnoreCase("HC")))
									|| prd_type.equalsIgnoreCase("pM")
									|| prd_type.equalsIgnoreCase("pI")
									|| prd_type.equalsIgnoreCase("pT")) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('perpropertydetails','getHousingLoanData','per_house_proposed_asset.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					} else if (prd_type.equalsIgnoreCase("pA")||(prd_type.equalsIgnoreCase("pU") && strProAvailableFor.equalsIgnoreCase("V"))) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('percollateral','getBoatAuto','perappvehicle.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					} else if (prd_type.equalsIgnoreCase("pD")) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('perpropertydetails','getOtherAssetData','otherassets.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					} else if (prd_type.equalsIgnoreCase("pK")) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('agreconomic','getSolarlightData','per_solarlight.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					}
						}	
         		 %>
          <% } %>
          
          <%
			if(strFreezeflag.equalsIgnoreCase("Y")){%>
		 	<td align="center" width="15%" class="sub_tab_inactive_new"><b>
		 	 	<a href="JavaScript:callLink('com_attchsecuritydisplay_reatail.jsp','securitymaster','getCollateralSecurityDisplayretail')">
			 	Security Coverage</a></b></td>				
			<% }else{%>
			<td align="center" width="15%" class="sub_tab_inactive_new" align="center"><b><a href="JavaScript:callalert()">Security Coverage</a></b></td>
			
				<%} %>
				
			<td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callLinkComments('per_commentsonseccovergae.jsp','facilities','getComments','secoverageretail')">Comments on Security Coverage</a></b></b></td>	
			<td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callMDTD()">MDTD</a></b></b></td>	
          
          </tr>
        </table>
      </td>
    </tr>
  </table>
<%} %>
   
   
   
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                <tr> 
                  <td> <table width="91%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
                      <tr> 
                      	<td>
							<jsp:include page="../per/ProposedAssetTabs.jsp" flush="true">
							<jsp:param name="tabid" value="3" />
							</jsp:include>
						</td>
                      </tr>
                    </table>
                  </td>
                </tr>
 </table>        
 <%} %>
 <table width="98%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
     <tr> 
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
		<tr>
			<td valign="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
			<tr>
				<td> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable linebor">
                      <tr class="dataheader"> 
                        <td width="20%">&nbsp;&nbsp;&nbsp;&nbsp;Details of Asset/Equipment</td>
                        <td width="16%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Equipment needed for</td>
                        <td align="center" width="16%">Name &amp; address of Supplier / Dealer</td>
                        <td align="center" width="16%" >Purchase Price / Amount (Rs.)</td>
                        <td width="16%" align="center">Invoice / Quotation</td>
                        <td width="16%" align="center">Date of Invoice / Quotation</td>
                      </tr>
                      <%
					  for(int i=1;i<11;i++)
					  {
					  	if(arryRow!=null && arryRow.size()>=i)
						{
							arryCol=(ArrayList)arryRow.get(i-1);
					  %>
                      <% 
					  double temp  = Double.parseDouble(Helper.correctDouble((String)arryCol.get(2)));  
                      
					  total = temp + total;
						total1=(String)arryCol.get(5);	
					  %>
					  <!-- changes by Madhura -->
                      <tr class="datagrid" align="center"> 
                        <td width="20%"> 
                          <input type="text" name="txtAssetDetail" value="<%=arryCol.get(0)%>"size="35" maxlength="200">
                        </td>
                        <td width="16%">
                          <input type="text" name="txtNeed" value="<%=arryCol.get(6)%>" size="35" maxlength="500">
                        </td>
                        <td width="16%"> 
                          <input type="text" name="txtSupplier" size="30" value="<%=arryCol.get(1)%>" maxlength="200">
                        </td>
                        <td width="16%" > 
                          <input type="text" name="txtPurchasePrice" size="15" value="<%=arryCol.get(2)%>" onKeyPress="allowNumber(this)" maxlength="9" style="text-align:right">
                        </td>
                        <td width="16%">
                          <input type="text" name="txtinvoice" size="15" value="<%=arryCol.get(3)%>" maxlength="15" onKeyPress="allowAlphaNumeric()">
                        </td>
                        <td width="16%"> 
                          <input type="text" name="txt_invoiceDate" size="15%" onKeyPress="" maxlength="10" value="<%=arryCol.get(4)%>"
							onBlur="checkDate(this);checkmaxdate(this,currdate)"> <a href="#" onClick="callCalender('txt_invoiceDate[<%=i-1%>]')"
							title="Click to view calender" border=0><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif" border="0"></a>
						</td>
                      </tr>
                      <%}else{%>
                      <tr class="datagrid" align="center"> 
                        <td width="20%"> 
                          <input type="text" name="txtAssetDetail" size="35" maxlength="200"> 
                        </td>
                        <td width="16%">
                          <input type="text" name="txtNeed" size="35" maxlength="500">
                        </td>
                        <td width="16%"> 
                          <input type="text" name="txtSupplier" size="30" maxlength="200">
                        </td>
                        <td width="16%" > 
                          <lapschoice:CurrencyTag name="txtPurchasePrice" size="15" maxlength="9"/>
                        </td>
                        <td width="16%">
                          <input type="text" name="txtinvoice" size="15"  onKeyPress="allowAlphaNumeric()"  maxlength="15" >
                        </td>
                        <td width="16%"> 
                          <input type="text" name="txt_invoiceDate" value="" size="15%" onKeyPress="" maxlength="10"
							onBlur="checkDate(this);checkmaxdate(this,currdate)"> <a href="#" onClick="callCalender('txt_invoiceDate[<%=i-1%>]')"
							title="Click to view calender" border=0><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif" border="0"></a>
						</td>
                      </tr>
                      <%}//end of else
									}//end of for statement%>
                    </table>
                  </td>
                </tr>
              </table></td>
          </tr>
        </table></td>
    </tr>
  <tr><td>
 
  
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
      <td align ="left" width="31%" bordersize="0" nowrap><b>Expected Monthly income after acquiring the equipments&nbsp;&nbsp;</b></td>
      <td align ="left" width="31%" bordersize="0"> &nbsp; 
        <input type="text" name="txt_incincome" onKeyPress="allowNumber(this)" size="10" value="<%=total1%>" style="text-align:right" maxlength="9"></td>
      <td align ="right" width="31%" bordersize="0"><B>TOTAL PURCHASE PRICE&nbsp;&nbsp;</B></td>

      <td align="right" width="7%"><b><%=Helper.formatDoubleValue(total)%>&nbsp;&nbsp;</b></td>
    </tr>
  </table>
  </td>
  </tr>
  </table>

  <br>
  <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br>
<input type="hidden" name="hpage">
<INPUT TYPE="hidden" name="radLoan" value="Y">
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
</form>
</body>
</html>
