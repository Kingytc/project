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
	  int count1=0,count2=0;
		if(hshValues!=null)
		  {
			count1=Integer.parseInt(Helper.correctInt((String) hshValues.get("count1")));
			count2=Integer.parseInt(Helper.correctInt((String) hshValues.get("count2")));
			  //arrRow = (ArrayList) hshValues.get("arrRow");
		  }
		String strPromotorFreeze=Helper.correctNull((String)hshValues.get("strPromotorFreezeflag"));
		String strcgtmseavail = Helper.correctNull((String)hshValues.get("strcgtmseavail"));
		String strcgtmsecoapp = Helper.correctNull((String)hshValues.get("strcgtmsecoapp"));
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
			if(hshValues!=null)
			{
				arrRow = (ArrayList)hshValues.get("arrRow");
			}
			int len=arrRow.size();
		
		%>
<html>
<head>
<title>Attached Securities</title>
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
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varCategoryType = "<%=strCategoryType%>";
var varApplicant = "<%=strApplicant%>";
var varlength = "<%=intLength%>";
var varPromotorFreeze="<%=strPromotorFreeze%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("strappstatus"))%>";
var varPostSanc="<%=Helper.correctNull((String)session.getAttribute("strAppType"))%>";
var varLASCHK="<%=Helper.correctNull((String)hshValues.get("strLASCHK"))%>";
var varBorrID="<%=Helper.correctNull((String)hshValues.get("strBorrID"))%>";
var varReleasedSec="<%=Helper.correctNull((String)hshValues.get("strReleasedSec"))%>";
var varSecValuation="<%=Helper.correctNull((String)hshValues.get("strSecValuation"))%>";
var varSecVerification="<%=Helper.correctNull((String)hshValues.get("strSecVerification"))%>";
var varcollSec="<%=Helper.correctNull((String)hshValues.get("strcolSec"))%>";
var len="<%=len%>";
var varstrcgtmseavail="<%=Helper.correctNull((String)hshValues.get("strcgtmseavail"))%>";
var varstrcgtmsecoapp="<%=Helper.correctNull((String)hshValues.get("strcgtmsecoapp"))%>";
var len="<%=len%>";
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="bankappfi"
		document.forms[0].hidBeanGetMethod.value="getlegalopinionverification";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/legalopinionverificationfor_corp_agri.jsp";
		document.forms[0].submit();
	 }
}
function doDelete()
{
	if(ConfirmMsg(101))
	{	
		document.forms[0].hidActionforlov.value ="delete";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="bankappfi";
		document.forms[0].hidBeanMethod.value="updatelegalopinionverification";
		document.forms[0].hidBeanGetMethod.value="getlegalopinionverification";
		document.forms[0].hidSourceUrl.value="/action/legalopinionverificationfor_corp_agri.jsp";
		document.forms[0].submit();
	
	}
}
function doSave()
{
	document.forms[0].hidActionforlov.value ="insert";
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
		document.forms[0].hidSourceUrl.value="/action/legalopinionverificationfor_corp_agri.jsp";
		document.forms[0].submit();
	

}
function doEdit()
{
	
	
	//disableFields(false);	
	//document.forms[0].hidAction.value ="insert";
	enableButtons(true,false,false,false);	

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
	if(document.forms[0].cmdedit.disabled==true)
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
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">
if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="frmcapitalstructure" method="post" class="normal">
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
 <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="33" />
			<jsp:param name="subpageid" value="106" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="33" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
			
			
		</jsp:include>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
	 <%if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">Home -&gt; Agriculture -&gt;Application -&gt; Promoters -&gt; Security Master -&gt; Attached Securities</td>
	<%} else if(strSessionModuleType.equals("RET")){%>
		<td class="page_flow">Home -&gt; Retail -&gt;Application -&gt; Security Master -&gt; Attached Securities</td>
	<%}else{%>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Promoters -&gt; Security Master -&gt; Attached Securities</td>
		<%} %>			
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../set/appurlsectabs.jsp" flush="true">
			<jsp:param name="pageid" value="104"/>
			<jsp:param name="Freezeflag" value="<%=strFreezeflag%>" />
		</jsp:include>
		</td>
	</tr>
</table>
<%} %>
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
					Legal Opinion verify Date
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

<br>
<input type="hidden" name="hid_categoryType" value="">
<input type="hidden" name="hidsectype" value="<%=sectype%>">
<%
			if (arrRow != null && arrRow.size() > 0) {%>
<lapschoice:combuttonnew
	btnenable='<%=Helper.correctNull((String)request
							.getParameter("btnenable"))%>'
	btnnames='Edit_Save_Delete_Cancel' /> 

<%}%>
<lapschoice:hiddentag
	pageid='<%=PageId%>' />
<input type="hidden" name="hidappno" value="<%=Helper.correctNull((String)request.getParameter("appno")) %>">
<input type="hidden" name="hidsize" value="<%=arrCol.size()%>">
<input type="hidden" name="hid_applicant" value="<%=strApplicant%>">
<input type="hidden" name="hid_prioritycheck"  value="<%=strPrioirycheck%>">
<input type="hidden" name="hidSecurityId" value="<%=Helper.correctNull((String) request.getParameter("hidsecid"))%>">
<input type="hidden" name="hidPostSancParams" value="<%=Helper.correctNull((String)hshValues.get("strPostSancParam"))%>">
<input type="hidden" name="hidActionforlov" value="">
</form>

</body>
</html>
