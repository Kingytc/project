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
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanMethod.value="updateDist";
		document.forms[0].hidBeanGetMethod.value="getDistData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comdistribute.jsp";
		document.forms[0].submit();
	  }
	   }
	  else{
	 ShowAlert(158);
	 }
		
}
function doSave()
{
	var flag=validate();
	
	if(flag)
	{
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidRecordflag.value=varRecordFlag;
		document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanMethod.value="updateDist";
		document.forms[0].hidBeanGetMethod.value="getDistData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comdistribute.jsp";
		document.forms[0].submit();
	}
	else
	{
		alert("Enter one value in Customer Name Column");
	}
}

function  validate()
{ 
	var flag;
	for (m=0;m<10;m++)
	{
		if(trimtxt(document.forms[0].name[m].value) != "")
		{
			
				return true ;
			
		}
		else
				flag = false; 
	}
	
return flag;

}

function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanGetMethod.value="getDistData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comdistribute.jsp";
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

var strvalue="corp_prodmark_mcexpo.htm";
function doHelp()     
{
  var hlpvar = appURL+"phlp/corp_prodmark_mcexpo.htm";
  var title = "MajorCustExport";
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
	class="outertable border1">
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
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Products -&gt; Marketing -&gt; Major Customers
		Export</td>
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
										<td width="15%" class="sub_tab_active"><b>Major
										Customers Export</b></td>
										<td width="15%" class="sub_tab_inactive"><b><a
											href="#"
											onClick="javascript:callLink('comdistributelocal.jsp','compro','getDistLocalData')">Major
										Customers Local</a></b></td>
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
												<td width="5%"><b>S.No</b></td>
												<td width="35%"><b>Customer Name</b></td>
												<td width="20%"><b>Name of the country</b></td>
												<td width="20%"><b>Product</b></td>
												<td width="20%"><b>%of total turnover</b></td>
											</tr>
											<tr class="dataheader">
												<td width="5%">&nbsp;</td>
												<td width="35%"><b>Export</b></td>
												<td width="20%">&nbsp;</td>
												<td width="20%">&nbsp;</td>
												<td width="20%">&nbsp;</td>
											</tr>
											<%
												ArrayList g1 = null;

												for (int l = 0; l < 10; l++) {

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
												<td width="5%" align="center"><%=l + 1%></td>
												<td width="35%" align="center"><input type="text"
													name="name"
													value="<%=Helper.correctNull((String) g1
											.get(3))%>"
													size="35" maxlength="49"
													onKeyPress="notAllowSplChar1(this)"></td>
												<td width="20%" align="center"><input type="text"
													name="country" size="30"
													value="<%=Helper.correctNull((String) g1
											.get(6))%>"
													maxlength="99" onKeyPress="notAllowSplChar1(this)">
												</td>
												<td width="20%" align="center"><input type="text"
													name="product" size="30"
													value="<%=Helper.correctNull((String) g1
											.get(4))%>"
													maxlength="99" onKeyPress="notAllowSplChar1(this)">
												</td>
												<td width="20%" align="center"><input type="text"
													name="total"
													value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) g1
											.get(5))))%>"
													onKeyPress="allowNumber(this)"
													onblur="checkPercentage(this);roundtxt(this)" size="30" maxlength="12">
												<input type="hidden" name="type" value="export"></td>
											</tr>
											<%
												} else {
											%>
											<tr>
												<td width="5%" align="center"><%=l + 1%></td>
												<td width="35%" align="center"><input type="text"
													name="name" size="35" maxlength="49"
													onKeyPress="notAllowSplChar1(this)"></td>
												<td width="20%" align="center"><input type="text"
													name="country" size="30" maxlength="99"
													onKeyPress="notAllowSplChar1(this)"></td>
												<td width="20%" align="center"><input type="text"
													name="product" size="30" maxlength="99"
													onKeyPress="notAllowSplChar1(this)"></td>
												<td width="20%" align="center"><input type="text"
													name="total" onKeyPress="allowNumber(this)"
													onblur="checkPercentage(this);roundtxt(this)" size="30" maxlength="12">
												<input type="hidden" name="type" value="export"></td>
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