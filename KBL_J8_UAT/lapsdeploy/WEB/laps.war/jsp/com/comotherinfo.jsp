<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	ArrayList vec = null;
	int vecsize = 0;
	ArrayList vec1 = null;
	int vecsize1 = 0;
	if (hshValues != null) {

		vec = (ArrayList) hshValues.get("vecVal");
		vec1 = (ArrayList) hshValues.get("vecVal1");

	}

	if (vec != null) {
		vecsize = vec.size();

	}
	if (vec1 != null) {
		vecsize1 = vec1.size();

	}
%>
<html>
<head>
<title>Other information</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";

function placeValues()
{
	
		disableFields(true);
}
function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
		}
	}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{

	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;

}
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,true)

}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanMethod.value="updateInfo";
		document.forms[0].hidBeanGetMethod.value="getInfoData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comotherinfo.jsp";
		document.forms[0].submit();
	 }
	 }
	 else
	 {
	 	ShowAlert(158);
	 }
		
}
function doSave()
{
		
		var flag=validate();
		var termflag=termvalidate();
	
		if(flag || termflag)
	{
			document.forms[0].cmdsave.disabled = true;
			document.forms[0].hidRecordflag.value=varRecordFlag;
		document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanMethod.value="updateInfo";
		document.forms[0].hidBeanGetMethod.value="getInfoData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comotherinfo.jsp";
		document.forms[0].submit();
	}
	else
	{
		alert("Enter one value in on behalf of or nature of due fields");
	}


	

}
function  validate()
{ 
	var flag;
	for (m=0;m<8;m++)
	{
		if(trimtxt(document.forms[0].behalf[m].value) != "")
		{
			
				return true ;
			
		}
		else
				flag = false; 
	}
	
return flag;

}
function  termvalidate()
{ 
	var termflag;
	for (m=0;m<8;m++)
	{
		if(document.forms[0].due[m].value != "")
		{
			
				return true ;
			
		}
		else
				termflag = false; 
	}
	
return termflag;

}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="combanking";
		document.forms[0].hidBeanGetMethod.value="getInfoData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comotherinfo.jsp";
		document.forms[0].submit();
	 }
	
}

function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appURL+"action/"+"comsearch.jsp";
		document.forms[0].submit();
	}
	
}




function callLink(page,bean,method)
{
	if (document.forms[0].cmdsave.disabled)
	{
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
 function callApplicantTab(page)
  { 
   	if (document.forms[0].cmdsave.disabled)
	{
	  if(page=="company")
	  { 
		  document.forms[0].hidBeanGetMethod.value="getData";
		  document.forms[0].action=appURL+"action/comcompany.jsp";
	  }
	  if(page=="proposal")
	  {
		  document.forms[0].hidBeanGetMethod.value="getProposal";
		  document.forms[0].action=appURL+"action/comproposal.jsp";
	  }
	 	  	  if(page=="facilities")
	  {
		  document.forms[0].hidBeanMethod.value="getFacilityData";
		  document.forms[0].hidBeanId.value="facilities";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/facilities.jsp";
	  }  
		  document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
	
	
  }

var strvalue="corp_organdemp_otherinf.htm";
function doHelp()     
{
  var hlpvar = appURL+"phlp/corp_organdemp_otherinf.htm";
  var title = "OtherInfo";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onload="placeValues()">
<form method="post" name="fltintrate" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top" colSpan="5"><jsp:include
			page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="5" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Org. & Emp. -&gt; Other Info</td>
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table border="0" cellspacing="1" cellpadding="3" class="outertable"
			width="60%">
			<tr align="center">
				<td width="15%" class="sub_tab_inactive"><b><a href="#"
					onclick="javascript:callLink('comorg.jsp','combanking','getOrgData')">Organisation</a></b></td>
				<td width="15%" class="sub_tab_inactive"><b><a href="#"
					onclick="javascript:callLink('comemp.jsp','combanking','getEmpData')">Mgmt.&amp;
				Employees</a></b></td>
				<td width="15%" class="sub_tab_inactive"><b><a href="#"
					onclick="javascript:callLink('commis.jsp','combanking','getMisData')">Other
				Management Details</a></b></td>
				<td width="15%" class="sub_tab_active"><b>Other Info</b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			align="center" class="outertable border1">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="2" cellpadding="3"
							class="outertable">
							<tr align="center" class="dataheader">
								<td width="50%">Details of Corporate Guarantees issued by
								the applicant</td>
								<td width="50%">Details of Statutory Dues</td>
							</tr>
							<tr>
								<td WIDTH="50%">
								<table border="0" cellspacing="1" cellpadding="3"
									class="outertable" WIDTH="100%">
									<tr class="dataheader" align="center">
										<td align="center" width="6%"><b>S.No</b></td>
										<td align="center" width="59%"><b>on behalf of </b></td>
										<td width="59%" align="center"><b>Amt. of Guarantee</b></td>
									</tr>
									<%
										ArrayList g1 = null;

										for (int l = 0; l < 8; l++) {

											int colSize = 0;

											if (l < vecsize) {
												g1 = (ArrayList) vec.get(l);

												if (g1 != null) {
													colSize = g1.size();

												}
											}

											if (colSize > 0) {
									%>
									<tr>
										<td align="center" width="6%"><%=l + 1%></td>
										<td align="center"><input type="text" name="behalf"
											size="35" onKeyPress="notAllowSplChar1(this)" onBlur="javascript:roundtxt(this)"
											value="<%=Helper.correctNull((String) g1
											.get(3))%>"
											maxlength="99"></td>
										<td width="22%" align="center"><lapschoice:CurrencyTag
											name="guarantee" size="15" maxlength="12"
											value='<%=Helper.correctNull((String) g1
											.get(4))%>'/>
										<input type="hidden" name="type" size="15" value="guarantee">
										</td>
									</tr>
									<%
										} else {
									%>
									<tr>
										<td align="center" width="6%"><%=l + 1%></td>
										<td align="center"><input type="text" name="behalf"
											size="35" maxlength="99" onKeyPress="notAllowSplChar1(this)">
										</td>
										<td width="22%" align="center"><lapschoice:CurrencyTag
											name="guarantee" size="15" 
											maxlength="12" /> <input
											type="hidden" name="type" size="15" value="guarantee">
										</td>
									</tr>
									<%
										}
										}
									%>
								</table>
								</td>
								<td width="50%">
								<table width="100%" border="0" cellspacing="1" cellpadding="3"
									class="outertable">
									<tr align="center" class="dataheader">
										<td width="6%"><b>S.No</b></td>
										<td><b>Nature of Due</b></td>
										<td><b>Amount Due</b></td>
									</tr>
									<%
										ArrayList g2 = null;

										for (int j = 0; j < 8; j++) {

											int colSize1 = 0;

											if (j < vecsize1) {
												g2 = (ArrayList) vec1.get(j);

												if (g2 != null) {
													colSize1 = g2.size();
												}
											}

											if (colSize1 > 0) {
									%>
									<tr>
										<td width="6%" align="center"><%=j + 1%></td>
										<td width="22%" align="center"><input type="text"
											name="due" size="25"
											value="<%=Helper.correctNull((String) g2
											.get(3))%>"
											maxlength="99" onKeyPress="notAllowSplChar1(this)"></td>
										<td width="22%" align="center"><lapschoice:CurrencyTag
											name="amount" size="15" maxlength="12"
											value='<%=Helper.correctNull((String) g2
											.get(4))%>'/>
										<input type="hidden" name="type1" size="15" value="nature">
										</td>
									</tr>
									<%
										}

											else {
									%>
									<tr>
										<td width="6%" align="center"><%=j + 1%></td>
										<td width="22%" align="center"><input type="text"
											name="due" size="25" maxlength="99"
											onKeyPress="notAllowSplChar1(this)"></td>
										<td width="22%" align="center"><lapschoice:CurrencyTag
											name="amount" size="15" maxlength="12" />
										<input type="hidden" name="type1" size="15" value="nature">
										</td>
									</tr>
									<%
										}
										}
									%>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>Details of suit filed / Litigations against the applicant</td>
					</tr>
					<tr>
						<td><textarea name="suit" cols="140" rows="6" onKeyPress="textlimit(this,199)" onKeyUp="textlimit(this,199)"><%=Helper.correctNull((String) hshValues
							.get("Details of suit"))%></textarea>
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
<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel_Audit Trail"
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' />
</body>
</html>

