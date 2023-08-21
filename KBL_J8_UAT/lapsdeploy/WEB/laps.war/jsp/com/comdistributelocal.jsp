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
<title>Marketing, Distribution , Competition</title>
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
			else if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
		}
	}
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,true);

}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;

}
function doDelete()
{
	if(varRecordFlag=="Y")
		{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanMethod.value="updateDistLocal";
		document.forms[0].hidBeanGetMethod.value="getDistLocalData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comdistributelocal.jsp";
		document.forms[0].submit();
	  }
	   }
	  else{
	 ShowAlert(158);
	 }
		
}
function doSave()
{
	var termflag=termvalidate();

	if( termflag)
	{
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidRecordflag.value=varRecordFlag;
		document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanMethod.value="updateDistLocal";
		document.forms[0].hidBeanGetMethod.value="getDistLocalData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comdistributelocal.jsp";
		document.forms[0].submit();
	}
	else
	{
		alert("Enter one value in Customer Name Column");
	}
}

function  termvalidate()
{ 
	var termflag;
	for (m=0;m<10;m++)
	{
		if(trimtxt(document.forms[0].localname[m].value) != "")
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
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanGetMethod.value="getDistLocalData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comdistributelocal.jsp";
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

var strvalue="corp_prodmark_mcloc.htm";
function doHelp()     
{
  var hlpvar = appURL+"phlp/corp_prodmark_mcloc.htm";
  var title = "MajorCustLocal";
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
			<jsp:param name="pageid" value="4" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable border1">
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Products -&gt; Marketing -&gt; Major Customers Local</td>
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span><lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr>
		<td valign="bottom">
		<table border="0" cellspacing="2" cellpadding="3" class="outertable"
			WIDTH="70%">
			<tr align="center">
				<td width="10%" class="sub_tab_inactive"><b><a href="#"
					onClick="javascript:callLink('comactivities.jsp','compro','getActivity')">Activities</a></b></td>
				<td width="10%" class="sub_tab_inactive"><b><a href="#"
					onClick="javascript:callLink('comproduction.jsp','combanking','getProductData')">About
				Prod.</a></b></td>
				<td width="10%" class="sub_tab_inactive"><b><a href="#"
					onClick="javascript:callLink('comrawmaterials.jsp','combanking','getRawData')">Raw
				Materials</a></b></td>
				<td width="10%" class="sub_tab_inactive"><b><a href="#"
					onClick="javascript:callLink('comprocessdesc.jsp','combanking','getDescData')">Manf.Process</a></b></td>
				<td width="10%" class="sub_tab_inactive"><b><a href="#"
					onClick="javascript:callLink('comgovtpolicies.jsp','combanking','getGovtData')">Govt.Policy</a></b></td>
				<td width="10%" class="sub_tab_inactive"><b><a href="#"
					onClick="javascript:callLink('comtransport.jsp','combanking','getTransData')">Transportation</a></b></td>
				<td width="10%" class="sub_tab_active"><b>Marketing</b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="center" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td colspan="2">
								<table border="0" cellspacing="2" cellpadding="3"
									class="outertable" WIDTH="60%">
									<tr align="center">
										<td width="10%" class="sub_tab_inactive"><b><a
											href="#"
											onClick="javascript:callLink('commarketing.jsp','combanking','getSegmentData')">Marketing</a></b></td>
										<td width="10%" class="sub_tab_inactive"><b><a
											href="#"
											onClick="javascript:callLink('commarketingsegment.jsp','combanking','getMarketData')">Distribution</a></b></td>
										<td width="15%" class="sub_tab_inactive"><b><a
											href="#"
											onClick="javascript:callLink('comdistribute.jsp','combanking','getDistData')">Major
										Customers Export</a></b></td>
										<td width="15%" class="sub_tab_active"><b>Major
										Customers Local</b></td>
										<td width="10%" class="sub_tab_inactive"><b><a
											href="#"
											onClick="javascript:callLink('comcompetitor.jsp','combanking','getCompData')">Competition</a></b></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td colspan="2">
								<table width="100%" border="1" cellspacing="0" cellpadding="3"
									class="outertable">
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="1" cellpadding="3"
											class="outertable">
											<tr class="dataheader">
												<td colspan="5">Major customers (over 10% of turnover)
												for the products manufactured</td>
											</tr>
											<tr align="center" class="dataheader">
												<td width="6%"><b>S.No</b></td>
												<td width="35%"><b>Customer Name</b></td>
												<td width="35%"><b>Product</b></td>
												<td width="35%"><b>%of total turnover</b></td>
											</tr>
											<tr class="dataheader">
												<td width="6%">&nbsp;</td>
												<td width="35%"><b>Local</b></td>
												<td width="35%">&nbsp;</td>
												<td width="35%">&nbsp;</td>
											</tr>
											<%
												ArrayList g2 = null;
												//if(vecsize1!=0)
												//{
												for (int j = 0; j < 10; j++) {

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
												<td width="35%" align="center"><input type="text"
													name="localname"
													value="<%=Helper.correctNull((String) g2
											.get(3))%>"
													size="30" maxlength="49"
													onKeyPress="notAllowSplChar1(this)"></td>
												<td width="35%" align="center"><input type="text"
													name="localproduct" size="30"
													value="<%=Helper.correctNull((String) g2
											.get(4))%>"
													maxlength="99" onKeyPress="notAllowSplChar1(this)">
												</td>
												<td width="35%" align="center"><input type="text"
													name="localtotal" 
													value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) g2.get(5))))%>"
													maxlength="12" onKeyPress="allowNumber(this)"
													onblur="checkPercentage(this);roundtxt(this)" size="30"> <input
													type="hidden" name="localtype" value="local"></td>
											</tr>
											<%
												}

													else {
											%>
											<tr>
												<td width="6%" align="center"><%=j + 1%></td>
												<td width="35%" align="center"><input type="text"
													name="localname" size="30" maxlength="49"
													onKeyPress="notAllowSplChar1(this)"></td>
												<td width="35%" align="center"><input type="text"
													name="localproduct" size="30" maxlength="99"
													onKeyPress="notAllowSplChar1(this)"></td>
												<td width="35%" align="center"><input type="text"
													name="localtotal" onKeyPress="allowNumber(this)"
													onblur="checkPercentage(this);roundtxt(this)" size="30" maxlength="12">
												<input type="hidden" name="localtype" value="local">
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
<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel_Audit Trail"
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' /></form>
</body>
</html>
