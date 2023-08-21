<%@include file="../share/directives.jsp"%>
<%String stramtin = "";
if (strCategoryType.equalsIgnoreCase("OPS")) 
{
	stramtin = "<b>in Lacs</b>";
}
  String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
  ArrayList arrSecRow = new ArrayList();
  ArrayList arrSecCol = new ArrayList();
  
  int intLength = arrSecRow.size();
  String strApplicant = Helper.correctNull((String)hshValues.get("strcmpId"));
  String strAppId = Helper.correctNull((String)hshValues.get("strappId"));
  String sectype = Helper.correctNull((String) request.getParameter("hidsectype"));
  String strFreezeflag = Helper.correctNull((String)hshValues.get("strFreezeflag"));
  String strPrioirycheck = Helper.correctNull((String)hshValues.get("strPrioirycheck"));
  String strPrioityflag = Helper.correctNull((String)hshValues.get("strPrioityflag"));
  ArrayList arrFacRow = new ArrayList();
  ArrayList arrFacCol = new ArrayList();
  
  if(hshValues !=null){
	  arrFacRow=(ArrayList)hshValues.get("arrFacRow");
  }
  int count1=0,count2=0,totcount=0;
	if(hshValues!=null)
	  {
		count1=Integer.parseInt(Helper.correctInt((String) hshValues.get("count1")));
		count2=Integer.parseInt(Helper.correctInt((String) hshValues.get("count2")));
		totcount=Integer.parseInt(Helper.correctInt((String) hshValues.get("strTotcount")));
		  //arrRow = (ArrayList) hshValues.get("arrRow");
	  }
	session.setAttribute("strFrzfalgnew",strFreezeflag);
	
	String strFreezecoappguar=Helper.correctNull((String)hshValues.get("strCoAppFreezeflag"));
	String strProductType=Helper.correctNull((String)session.getAttribute("strProductType"));
	
	String prd_type = Helper.correctNull((String) session.getAttribute("strProductType"));
	String strPrdPurpose=Helper.correctNull((String) session.getAttribute("strPrdPurpose"));
	String strProAvailableFor =Helper.correctNull((String) hshValues.get("prd_applicablefor"));
	int linkid = Integer.parseInt(Helper.correctInt(request.getParameter("linkid")));
	String strValuationFlag=Helper.correctNull((String)hshValues.get("valuationFlag"));
	session.setAttribute("valuationFlag",strValuationFlag);
	String strHouseFlag=Helper.correctNull((String)hshValues.get("HouseEdit_Flag"));
	session.setAttribute("HouseEdit_Flag",strHouseFlag);
	String strVehicleFlag=Helper.correctNull((String)hshValues.get("VehicleEdit_Flag"));
	session.setAttribute("VehicleEdit_Flag",strVehicleFlag);
	String strcgtmseavail = Helper.correctNull((String)hshValues.get("strcgtmseavail"));
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=new ArrayList();
		if(hshValues!=null)
		{
			arrRow = (ArrayList)hshValues.get("arrRow");
		}
		int len=arrRow.size();
		//String arrsize=String.valueOf(len);
	%>
<html>
<head>
<title>Legal Opinion Verification</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<SCRIPT LANGUAGE="JavaScript"></script>
<script>

var varFreeze="<%=strFreezeflag%>";



var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varCategoryType = "<%=strCategoryType%>";
var varApplicant = "<%=strApplicant%>";
var varlength = "<%=intLength%>";
var varFreezecoappguar="<%=strFreezecoappguar%>";
var varProductType="<%=strProductType%>";
var varSecChkFlag="<%=Helper.correctNull((String)hshValues.get("strSecChkforpI"))%>";
var varSecFlag="<%=Helper.correctNull((String)hshValues.get("strSecFlag"))%>";
var varPrdpurpose="<%=Helper.correctNull((String)hshValues.get("strPrdpurpose"))%>";
var varBorrID="<%=Helper.correctNull((String)hshValues.get("strBorrID"))%>";
var varReleasedSec="<%=Helper.correctNull((String)hshValues.get("strReleasedSec"))%>";
var varSecValuation="<%=Helper.correctNull((String)hshValues.get("strSecValuation"))%>";
var varSecVerification="<%=Helper.correctNull((String)hshValues.get("strSecVerification"))%>";
var varValuationFlag="<%=Helper.correctNull((String)hshValues.get("valuationFlag"))%>";
var varHouseFlag="<%=Helper.correctNull((String)hshValues.get("HouseEdit_Flag"))%>";
var varVehicleFlag="<%=Helper.correctNull((String)hshValues.get("VehicleEdit_Flag"))%>";
var varColSec="<%=Helper.correctNull((String)hshValues.get("strcolSec"))%>";
var varCGTMSE_flag="<%=Helper.correctNull((String)hshValues.get("str_CGTMSEFlag"))%>";
var len="<%=len%>";
function callLink(page,bean,method)
{ 
	if(len==0)
	{
		document.forms[0].hidAction.value="";
	 	document.forms[0].hidBeanGetMethod.value=method;
	 	document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].action=appURL+"action/"+page;
	 	document.forms[0].submit();


	}
	else
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
}


function callalert()
{
	alert("Click Freeze in Attached Securities page to view Security Coverage");
	return;
}
function callLinkComments(page,bean,method,title)
{
	if(len==0)
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
}
function callMDTD()
{
	document.forms[0].action=appURL+"action/app_sec_MDTDdetails.jsp";
	document.forms[0].submit();	
}
function doEdit()
{
	//disableFields(false);	
	//document.forms[0].hidAction.value ="insert";
	enableButtons(true,false,false);	

}
function enableButtons(bool1,bool2,bool3,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmddelete.disabled=bool3;  
	document.forms[0].cmdcancel.disabled=bool5; 	
	
}
function callUsersHelp1(val,val2)
{
	if(document.all.cmdsave.disabled==false)
	{
		var pagefield="ddr"+val;
		var selval=val2;
		var varQryString = appURL+"action/setUserSearchforLo.jsp?pagefrom="+pagefield+"&selval="+selval;
		var title = "Users";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}else{
		alert("Enable the edit Mode");
	}
}
function doSave()
{
	document.forms[0].hidAction.value ="insert";
	if(len>=2)
	{
	var le = document.forms[0].txt_convertedid.length;
	for(var i=0;i<le;i++)
	{
		if(checktrim(document.forms[0].txt_convertedid[i].value) == "")
		{
			alert("Please entere legal opinion verification");
		    document.forms[0].txt_convertedid[i].focus();
			return false;
		}
	}
	}
	else
	{
	if(document.forms[0].txt_convertedid.value=="")
	{
		alert("Please entere legal opinion verification");
	    document.forms[0].txt_convertedid.focus();
		return false;
		
	}
	}
	<%
	if (arrRow != null && arrRow.size() > 0) {
		if (arrRow.size() > 0) {
			for (int i = 0; i < arrRow.size(); i++) {
				arrCol = (ArrayList) arrRow.get(i);
				%>
				if(document.forms[0].txtToDate<%=i%>.value=="")
				{
					alert("Please entere legal opinion verification Date");
					document.forms[0].txtToDate<%=i%>.focus();
					return false;
				}
				<%}}}%>	
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="bankappfi";
		document.forms[0].hidBeanMethod.value="updatelegalopinionverification";
		document.forms[0].hidBeanGetMethod.value="getlegalopinionverification";
		document.forms[0].hidSourceUrl.value="/action/securitynewtab.jsp";
		document.forms[0].submit();
	

}
function doDelete()
{
	if(ConfirmMsg(101))
	{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="bankappfi";
		document.forms[0].hidBeanMethod.value="updatelegalopinionverification";
		document.forms[0].hidBeanGetMethod.value="getlegalopinionverification";
		document.forms[0].hidSourceUrl.value="/action/securitynewtab.jsp";
		document.forms[0].submit();
	
	}
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="bankappfi"
		document.forms[0].hidBeanGetMethod.value="getlegalopinionverification";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/securitynewtab.jsp";
		document.forms[0].submit();
	 }
}
function callCalender(cmdname) {
	if(document.all.cmdsave.disabled==false)
	{
	showCal(appURL, cmdname);
	}
	else{
		alert("Enable the edit Mode");
        }
}
function allowalwysOldDate(obj,mindate,chkdate)
{
	var pagedate=obj.value;
	var pgdt=changeDateformat(pagedate);
	var mindt=changeDateformat(mindate);
	var chk=changeDateformat(chkdate);
	if(obj.value!="")
	{
		if(Date.parse(pgdt) > Date.parse(mindt))
		{
			alert("Date always be less than or equal to" +mindate );
			obj.value="";
			obj.focus();
			return false;
		}
		else if(Date.parse(pgdt) < Date.parse(chk))
		{
			alert("Date always be greater than or equal to" +chkdate );
			obj.value="";
			obj.focus();
			return false;
		}
	}
	return true;
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body>
<div id='imgloading' style="display:none;">
<img src="<%=ApplicationParams.getAppUrl()%>img/processing2.gif"></div>
<form name="frmcapitalstructure" method="post" class="normal">
<%if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>

<% if(strSessionModuleType.equalsIgnoreCase("DIGI")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkerdigi.jsp" flush="true"> 
        <jsp:param name="pageid" value="22" />
        </jsp:include>
		</td>
	</tr>
</table>
<% } else { %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="22" />
        </jsp:include>
		</td>
	</tr>
</table>
<% } %>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
	 <%if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">Home -&gt; Agriculture -&gt;Application -&gt;  Security Master -&gt; Legal Opinion Verification</td>
	<%}else if(strSessionModuleType.equals("CORP")){%>
		<td class="page_flow">Home -&gt; Corporate -&gt;Application -&gt;  Security Master -&gt; Legal Opinion Verification</td>
	<%}else if(strSessionModuleType.equals("DIGI")) {%>
		<td class="page_flow">Home -&gt; Digi Retail -&gt; Application -&gt; Security Master -&gt; Legal Opinion Verification</td>
	<%}else{%>
	<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Application -&gt; Security Master -&gt; Legal Opinion Verification</td>
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
           <%if(strSessionModuleType.equals("RET") || strSessionModuleType.equals("DIGI") ){ %>
           
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
           <td align="center" width="15%" class="sub_tab_active"><b><b>Legal opinion verification</a></b></b></td>	
          </tr>
        </table>
      </td>
    </tr>
  </table>
 <%}%>
<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
					<tr class="dataheader">
					<td style="background-color: #eccbe8;" width="20%" align="center">
					Security Id
					</td >
					<td style="background-color: #eccbe8;"  width="20%" align="center">
					Classification
					</td>
					<td style="background-color: #eccbe8;"  width="15%" align="center">
					Attached Security Value
					</td>
					<td style="background-color: #eccbe8;"  width="15%" align="center">
					Legal Opinion Verify Date
					</td>
					<td style="background-color: #eccbe8;"  width="15%" align="center">
					Staffid Of The User Has Verified Legal Opinion
					</td>
					
					</tr>
					<%
			if (arrRow != null && arrRow.size() > 0) {
				if (arrRow.size() > 0) {
					for (int i = 0; i < arrRow.size(); i++) {
						arrCol = (ArrayList) arrRow.get(i);
						%>
			<tr class="datagrid">
			
				<td width="20%" align="center"><input type="hidden" name="securityid" 
							value="<%=Helper.correctNull((String)arrCol.get(0))%>" ><b><%=Helper.correctNull((String)arrCol.get(0))%></b></td>
				<td width="20%" align="center"><input type="hidden" name="classification" 
							value="<%=Helper.correctNull((String)arrCol.get(1))%>" ><b><%=Helper.correctNull((String)arrCol.get(1))%></b></td>
				<td width="15%" align="right"><input type="hidden" name="securityval"  
							value="<%=Helper.correctNull((String)arrCol.get(2))%>" ><b><%=Helper.correctNull((String)arrCol.get(2))%></b></td>
				<td width="15%" align="right"> <input
													type="text" name="txtToDate<%=i%>" maxlength="21" readonly
													size="20" onBlur="allowalwysOldDate(this,currentDate,'<%=Helper.correctNull((String)arrCol.get(7))%>');"
													value="<%=Helper.correctNull((String)arrCol.get(3))%>" >&nbsp;
													<a alt="Select date from calender" href="#"
																	onClick="callCalender('txtToDate<%=i%>')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border="0" alt="Select date from calender"
																	tabindex="29"></a></td>
																	
																	
			
													
													
				 <td><input type="text" name="txt_convertedid" size="10" value="<%=Helper.correctNull((String)arrCol.get(4))%>" readonly="readonly">
				<input type="text" name="txt_convertedname" size="30" value="<%=Helper.correctNull((String)arrCol.get(6))%>" readonly="readonly">
				<a href="#" onClick="javascript:callUsersHelp1('2','<%=i%>')">
				<input style="visibility: hidden; position: absolute;" type="text" name="txtdesignation" size="10" value="<%=Helper.correctNull((String)arrCol.get(5))%>" readonly="readonly">
				<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"> </a>
				</td>
							<%}
				}%>
			</tr>
			<%}
			else{%>
			<tr>
										<td align="center" colspan="7">No Data Found</td>
									</tr>
			<%} %>	
		</table>
		<%
			if (arrRow != null && arrRow.size() > 0) {%>
		<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel" btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
 
 <%} %>
 <input type="hidden" name="hidPage" value="">
<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidBeanMethod" value=""> 
<input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidAction" value="">
<input type="hidden" name="hidSourceUrl" value=""> 
<input type="hidden" name="hidPageId">
<input type="hidden" name="hpage">





</form>

</body>
</html>
