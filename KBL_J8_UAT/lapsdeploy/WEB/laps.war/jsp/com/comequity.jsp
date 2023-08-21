<%@include file="../share/directives.jsp"%>
<%
	ArrayList vec = null;
	int vecsize = 0;

	if (hshValues != null) {
		vec = (ArrayList) hshValues.get("vecVal");
	}

	if (vec != null) {
		vecsize = vec.size();

	}
	java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
	jtn.setMaximumFractionDigits(2);
	jtn.setMinimumFractionDigits(2);
%>
<html>
<head>
<title>Proposal</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
	<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
function placeValues()
{
	disableFields(true);
}

function validateDate()
{
if(document.forms[0].mardate.value!="")
 {   
   return false;
 }
 
}

function callCalender(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		 showCal(appURL,val);
	}
}

function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
		}
	}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanGetMethod.value="getEquity";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comequity.jsp";
		document.forms[0].submit();
	 }
	
}
function doDelete()
{
		
	if(varRecordFlag=="Y")
		{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanMethod.value="updateEquity";
		document.forms[0].hidBeanGetMethod.value="getEquity";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comequity.jsp";
 		document.forms[0].submit();
	 }
	   }
	  else{
	 ShowAlert(158);
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
	document.forms[0].hideditflag.value="Y";
		for(var i=0;i<document.forms[0].mardate.length;i++)
		{
		  document.forms[0].mardate[i].readOnly=true;		  
		}
}
function doSave()
{
		var flag = validate();
		
		
	
if(flag ){
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidRecordflag.value=varRecordFlag;
		document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanMethod.value="updateEquity";
		document.forms[0].hidBeanGetMethod.value="getEquity";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comequity.jsp";
		document.forms[0].submit();
		}
else	{
			alert("Enter values in Name/Company Field");
		}
		

}

function  validate()
{ 
	var flag;
	for (m=0;m<8;m++)
	{
		if(trimtxt(document.forms[0].concern[m].value) != "")
		{
			
				return true ;
			
		}
		else
				flag = false; 
	}
	
return flag;

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
		Alert(103);
	}
}

var strvalue="corp_otherinf.htm";
function doHelp()     
{
  var hlpvar = appURL+"phlp/corp_otherinf.htm";
  var title = "OtherInformation";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>

<body onload="placeValues()">
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
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top" colSpan="5"><jsp:include
			page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="8" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable border1">
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Other Info. -&gt; Equity Invested</td>
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr align="center">
				<td width="40%" class="sub_tab_active"><b>Equity Invested</b></td>
				<td width="40%" class="sub_tab_inactive"><b><a href="#"
					onclick="javascript:gotoTab(appURL,'compro','getLitigation','comlitigation.jsp')">Litigations</a></b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="1" cellspacing="0" cellpadding="3"
	align="center" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="1" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="3"
									class="outertable">
									<tr class="dataheader">
										<td width="2%" align="center"><b>S.No</b></td>
										<td width="21%" align="center"><b>Name of the Concern</b></td>
										<td width="21%" align="center"><b>Nature and details
										of transaction</b></td>
										<td width="11%" align="center"><b>Amount invested</b></td>
										<td width="11%" align="center"><b>Market Value</b></td>
										<td width="14%" align="center"><b>Date</b></td>
										<td colspan="2" align="center" width="20%"><b>Remarks</b></td>
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
										<td width="2%" align="center"><%=l + 1%></td>
										<td width="21%" align="center"><input type="text"
											name="concern" size="30" onKeyPress="notAllowSplChar1(this)"
											value="<%=Helper.correctNull((String) g1
											.get(2))%>"
											maxlength="100"></td>
										<td width="21%" align="center"><input type="text"
											name="nature" size="30" onKeyPress="notAllowSplChar1(this)"
											value="<%=Helper.correctNull((String) g1
											.get(3))%>"
											maxlength="100"></td>
										<td width="11%" align="center"><input type="text"
											name="amount" size="15"
											value="<%=jtn.format(Double.parseDouble(Helper
									.correctDouble((String) g1.get(4))))%>"
											maxlength="12" style="text-align: right"
											onKeyPress="allowNumber(this)"
											onBlur="javascript:roundtxt(this)"></td>

										<td width="11%" align="center"><input type="text"
											name="marketvalue" size="15" maxlength="12"
											style="text-align: right"
											value="<%=jtn.format(Double.parseDouble(Helper
									.correctDouble((String) g1.get(7))))%>"
											onKeyPress="allowNumber(this)"
											onBlur="javascript:roundtxt(this)"></td>
										<td width="14%" align="center" nowrap="nowrap"><input
											type="text" name="mardate" size="15"
											value="<%=Helper.correctNull((String) g1
											.get(8))%>"
											maxlength="10" style="text-align: right"
											onBlur="validateDate();checkmaxdate(this,currentDate)">
                                <a alt="Select date from calender" href="#"
											onClick="callCalender('mardate[<%=l%>]')"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											border=0 alt="Select date from calender"></a></td>
										<td colspan="2" align="center" width="20%"><input
											type="text" name="remarks" size="25"
											onKeyPress="notAllowSplChar1(this)"
											value="<%=Helper.correctNull((String) g1
											.get(5))%>"
											maxlength="200"> <input type="hidden" name="type"
											size="25" value="company"></td>
									</tr>
									<%
										} else {
									%>
									<tr>
										<td width="2%" align="center"><%=l + 1%></td>
										<td width="21%" align="center"><input type="text"
											name="concern" size="30" maxlength="100"
											onKeyPress="notAllowSplChar1(this)"></td>
										<td width="21%" align="center"><input type="text"
											name="nature" size="30" maxlength="100"
											onKeyPress="notAllowSplChar1(this)"></td>
										<td width="11%" align="center"><input type="text"
											name="amount" size="15" maxlength="12"
											style="text-align: right" onKeyPress="allowNumber(this)"
											onBlur="javascript:roundtxt(this)"></td>
										<td width="11%" align="center"><input type="text"
											name="marketvalue" size="15" maxlength="12"
											style="text-align: right" onKeyPress="allowNumber(this)"
											onBlur="javascript:roundtxt(this)"></td>
										<td width="14%" align="center" nowrap="nowrap"><input
											type="text" name="mardate" size="15" maxlength="10"
											style="text-align: right"
											onBlur="validateDate();checkmaxdate(this,currentDate)">
                                <a alt="Select date from calender" href="#"
											onClick="callCalender('mardate[<%=l%>]')"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											border=0 alt="Select date from calender"></a></td>
										<td colspan="2" align="center" width="20%"><input
											type="text" name="remarks" size="25" maxlength="200"
											onKeyPress="notAllowSplChar1(this)"> <input
											type="hidden" name="type" size="25" value="company">
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
		</table>
		</td>
	</tr>
</table>
<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel_Audit Trail"
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' /></form>
</body>
</html>

