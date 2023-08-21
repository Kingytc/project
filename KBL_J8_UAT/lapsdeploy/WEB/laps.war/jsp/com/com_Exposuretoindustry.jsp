<%@ page import="com.sai.laps.helper.*" %>
<%@include file="../share/directives.jsp"%>
<% request.setAttribute("_cache_refresh", "true"); %>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}

	String strSessionModuleType = Helper.correctNull(
			(String) session.getAttribute("sessionModuleType")).trim();
	String natureOfActivity = Helper.correctNull((String) hshValues
			.get("activitycode"))
			+ " - "
			+ Helper
					.correctNull((String) hshValues.get("activitydesc"));
	if (natureOfActivity.trim().equals("-"))
		natureOfActivity = "";
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Exposure to Industry</title>

<script>
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var appid="<%=Helper.correctNull((String)request.getParameter("appno"))%>";
var sel_CalBase="<%=Helper.correctNull((String)hshValues.get("COM_CALBASE"))%>";
function callCalender(fname)
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}

function doCancel()
{
	if (ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidBeanGetMethod.value="getExposureIndustry";
		document.forms[0].action=appURL+"action/com_Exposuretoindustry.jsp";
		document.forms[0].submit();
	}
}

function disablefields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=val;
		}	  
		else if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		else if(document.forms[0].elements[i].type=='select-multiple')
		{
			document.forms[0].elements[i].disabled=val;
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}		
	}
	
}

function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdcomments.disabled=false;
}

function doEdit()
{	
	disablefields(false);
	document.forms[0].hidflag.value ="edit";
	document.forms[0].hidAction.value ="insert";
	document.forms[0].txt_NPAtoGBC.readOnly=true;
	document.forms[0].txt_PercentageofGBC.readOnly=true;
	document.forms[0].txt_GBCperdate.readOnly=true;
	document.forms[0].txt_activity.readOnly=true;
	enableButtons(true,false,false,false,false,false);
}

function onloading()
{
	disablefields(true);
	document.forms[0].cmdcomments.disabled=false;
	document.forms[0].txt_activity.readOnly=true;

	if(sel_CalBase!="")
	{
	document.forms[0].sel_CalBase.value =sel_CalBase;
	}
	CalcBasedOn();
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
}


function doComments()
{
	var btnenable=document.forms[0].btnenable.value;
	var strAppno = document.forms[0].hidAppNo.value;
	var pagetype = document.forms[0].hidCommentPage.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/com_comments.jsp?hidBeanId=comproposal&hidBeanGetMethod=getDataComments&pagetype="+pagetype+"&strAppno="+strAppno+"&appstatus="+appstatus+"&btnenable="+btnenable;
	window.open(url,"Comments",prop);
}

function doDelete()
{
		if(ConfirmMsg(101))
		{
			document.forms[0].hidAction.value ="delete";
			document.forms[0].hidBeanId.value="comproposal";		
			document.forms[0].hidBeanMethod.value="updateExposureIndustry";
			document.forms[0].hidBeanGetMethod.value="getExposureIndustry";
			document.forms[0].action=appURL+"action/ControllerServlet";	
			document.forms[0].hidSourceUrl.value="/action/com_Exposuretoindustry.jsp";			
			document.forms[0].method="post";			
			document.forms[0].submit();	
		}	
}
function doSave()
{
	if(document.forms[0].txt_activity.value=="")
	{
		ShowAlert(121,"Nature of Activity");
		document.forms[0].txt_activity.focus();
		return;
	}

	if(document.forms[0].txt_Advancedate.value=="")
	{
		ShowAlert(121,"Advance Date");
		document.forms[0].txt_Advancedate.focus();
		return;
	}
	if(document.forms[0].txt_Advanceamount.value=="")
	{
		ShowAlert(121,"Advance Amount");
		document.forms[0].txt_Advanceamount.focus();
		return;
	}
	if(document.forms[0].txt_Npaamount.value=="")
	{
		ShowAlert(121,"Amount of NPA");
		document.forms[0].txt_Npaamount.focus();
		return;
	}
	if(document.forms[0].txt_GBCdate.value=="")
	{
		ShowAlert(121,"GBC Date");
		document.forms[0].txt_GBCdate.focus();
		return;
	}
	if(document.forms[0].txt_GBCamount.value=="" || document.forms[0].txt_GBCamount.value=="0.00")
	{
		ShowAlert(121,"GBC Ammount");
		document.forms[0].txt_GBCamount.focus();
		return;
	}
	if(document.forms[0].sel_CalBase.value=="0")
	{
		ShowAlert(111,"Calculation Based on");
		document.forms[0].sel_CalBase.focus();
		return;
	}

	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updateExposureIndustry";
	document.forms[0].hidBeanGetMethod.value="getExposureIndustry";
	document.forms[0].hidSourceUrl.value="/action/com_Exposuretoindustry.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function SetDate()
{
	document.forms[0].txt_GBCperdate.value=document.forms[0].txt_GBCdate.value;
}

function funCalAmt()
{
		var vargbcamt=0.00;
		var varAdvanceamount=0.00;
		var varPercentageofGBC=0.00;
		var varNpagbcamt=0.00;
		var varNpagbctot=0.00;
		vargbcamt=document.forms[0].txt_GBCamount.value;
		if((vargbcamt=="")||(vargbcamt=="0.00"))
		{			
			document.forms[0].txt_PercentageofGBC.value="0.00";
			document.forms[0].txt_NPAtoGBC.value="0.00";
		}
		else
		{
			varAdvanceamount=document.forms[0].txt_Advanceamount.value;
			varNpagbcamt=document.forms[0].txt_Npaamount.value;
		    varPercentageofGBC=eval(varAdvanceamount)*eval(100/(vargbcamt));
			varNpagbctot=eval(varNpagbcamt)*eval(100/(vargbcamt));
			document.forms[0].txt_PercentageofGBC.value=roundVal(varPercentageofGBC);
			document.forms[0].txt_NPAtoGBC.value=roundVal(varNpagbctot);
			document.forms[0].txt_PercentageofGBC.value=roundtxt(document.forms[0].txt_PercentageofGBC);
			document.forms[0].txt_NPAtoGBC.value=roundtxt(document.forms[0].txt_NPAtoGBC);
		}
}
function callLink1(page,bean,method)
{
	if(document.forms[0].cmdsave.disabled==true)
	{
 	 document.forms[0].hidAction.value="";
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
		return;
	}
}
function showExposureIndustry()
{
	if(document.forms[0].cmdsave.disabled==false)
	{		var strAppno = document.forms[0].hidAppNo.value;
			var varQryString =appURL+"action/searchexposureindustry.jsp?hidBeanId=facilitymaster&hidBeanGetMethod=getexposureindustry&strAppno="+strAppno;
			var title = "City";
			var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
			var xpos = (screen.width - 350) / 2;
			var ypos = (screen.height - 120) / 2;
			prop = prop + ",left=50,top=50";
			window.open(varQryString,title,prop);
	}
}
function CalcBasedOn()
{
	if(document.forms[0].sel_CalBase.value=="2")
  {
	  document.all.cpl.innerText="% of NPA to Exposure";
	  document.all.cpl1.innerText="Percentage to Exposure as on ";
	  document.all.cpl2.innerText="Exposure as on ";
	  document.all.cpl3.innerText=" ";
  }
	if(document.forms[0].sel_CalBase.value=="1")
  {
		  document.all.cpl.innerText="% of NPA to GBC";
		  document.all.cpl1.innerText="Percentage to GBC as on ";
		  document.all.cpl2.innerText="GBC as on ";
		  document.all.cpl3.innerText="Note : GBC = Gross Bank Credit";
  }
}
</script>
</head>
<body onload="onloading();">
<form method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="22" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<%
		if (strSessionModuleType.equals("AGR")) {
	%>
	<tr>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Proposal -&gt; Exposure to Industry / Other Info  -&gt;  Exposure to Industry</td>
	</tr>
	<%
		} else {
	%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Exposure to Industry / Other Info  -&gt;  Exposure to Industry</td>
	</tr>
	<%
		}
	%>
</table>
<span style="display: none"><lapschoice:borrowertype /></span><lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
<td>


 	<table width="70%" border="0" cellspacing="1" cellpadding="3"> 
	<tr align="center">
		<td width="13%" height="14" class="sub_tab_active" nowrap="nowrap"> Exposure to Industry</td>
		 <td width="13%" height="14" class="sub_tab_inactive" nowrap="nowrap"><a href="javascript:callLink1('com_industryanalysis.jsp','compro','get_Others')">Industry analysis</a></td>
		 <td width="12%" height="14" class="sub_tab_inactive" nowrap="nowrap"> <a href="javascript:callLink1('com_swotanalysis.jsp','compro','get_swotanalysis')">Swot Analysis</a></td> 
		 <td width="13%" height="14" class="sub_tab_inactive" nowrap="nowrap"> <a href="javascript:callLink1('com_interfirmcomp.jsp','comassestsliab','getInterfirmComp')">Inter Firm Comparsion</a></td>
		 <td width="12%" height="14" class="sub_tab_inactive" nowrap="nowrap"> <a href="javascript:callLink1('com_management.jsp','compro','get_Management')">Other Details</a></td> </tr> 
	</table>







</td>
</tr>
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
								<tr class="dataheader">
									<td colspan="5" align="center">Exposure to industry</td>
								</tr>
								<tr class="dataheader">
									<td colspan="2" align="center">Calculation Based on</td>
									<td colspan="3" align="center"><select name="sel_CalBase" onchange="CalcBasedOn();">
									<option value="0">-----Select-----</option>
									<option value="1">GBC</option>
									<option value="2">Exposure</option>
									</select>
									</td>
								</tr>
								<tr class="dataheader"><td align="center">Industry <span class="mantatory">*</span></td>
								<td align="center">Amount of advance as at <span class="mantatory">*</span> <br/> <input type="text" name="txt_Advancedate" maxlength="10" size="12" value="<%=Helper.correctNull((String) hshValues
							.get("COM_ADVANCEDATE"))%>" onBlur="checkDate(this);" tabindex="1">
								<a style="vertical-align: middle;" onClick="callCalender('txt_Advancedate')" onMouseOver="window.status='Date Picker';return true;"
								onMouseOut="window.status='';return true;" tabindex="2"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0" alt="Select date from calender" ></a>
								</td>
								<td align="center"><span id="cpl1">Percentage to GBC as on </span><br/> <input type="text" name="txt_GBCperdate" maxlength="10" class="derivedFld" size="12" value="<%=Helper.correctNull((String)hshValues.get("COM_PERCENTAGEGBCDATE"))%>"  onBlur="checkDate(this);"></td>
								<td align="center">Amount of NPA under this activity <span class="mantatory">*</span></td>
								<td align="center"><span id="cpl">% of NPA to GBC</span></td>
								</tr>
								<tr class="datagrid">
												<td align="center"><input type="text"
													name="txt_activity" maxlength="30" size="30" tabindex="2"
													tabindex="4" onKeyPress="allowAlphaNumeric()" value="<%=Helper.correctNull((String)hshValues.get("COM_ACTIVITY"))%>">
												  <a href="#" onClick="showExposureIndustry()" style="cursor: hand" tabindex="22">
												  <img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex="21"></a></td>
												<td align="center"><lapschoice:CurrencyTag name="txt_Advanceamount" maxlength="15" size="12" tabindex="5" onKeyPress="allowDecimals(this)" style="text-align:right" onBlur="roundtxt(this);funCalAmt();" value='<%=Helper.correctNull((String) hshValues
							.get("COM_ADVANCEAMOUNT"))%>' /></td>
									<td align="center"><lapschoice:CurrencyTag styleClass="derivedFld" name="txt_PercentageofGBC" maxlength="15" size="12" onKeyPress="allowDecimals(this)" style="text-align:right" onBlur="roundtxt(this);" value='<%=Helper.correctNull((String) hshValues
							.get("COM_GBCPERCENTAGE"))%>' other="readOnly"/></td>
									<td align="center"><lapschoice:CurrencyTag name="txt_Npaamount" maxlength="15" size="12" tabindex="6" onKeyPress="allowDecimals(this)" style="text-align:right" onBlur="roundtxt(this);funCalAmt();" value='<%=Helper.correctNull((String) hshValues
							.get("COM_NPAAMOUNT"))%>'/></td>
									<td align="center"><lapschoice:CurrencyTag styleClass="derivedFld" name="txt_NPAtoGBC" maxlength="15" size="12" onKeyPress="allowDecimals(this)" style="text-align:right" onBlur="roundtxt(this)" value='<%=Helper.correctNull((String) hshValues
							.get("COM_NPAGBCPERCENTAGE"))%>' other="readOnly" /></td>
								</tr>
								<tr class="datagrid">
								<TD colspan="5"><span id="cpl2">GBC as on </span><span class="mantatory">*</span> <input type="text" name="txt_GBCdate" maxlength="10" size="12" onBlur="checkDate(this);SetDate()" value="<%=Helper.correctNull((String)hshValues.get("COM_GBCDATE"))%>" tabindex="1">
								<a style="vertical-align: middle;"  onClick="callCalender('txt_GBCdate')" onMouseOver="window.status='Date Picker';return true;"
								onMouseOut="window.status='';return true;" tabindex="2"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0" alt="Select date from calender" ></a> = Rs. <lapschoice:CurrencyTag name="txt_GBCamount" maxlength="15" size="12" tabindex="7" onKeyPress="allowDecimals(this);" onBlur="roundtxt(this);funCalAmt();" style="text-align:right" value='<%=Helper.correctNull((String)hshValues.get("COM_GBCAMOUNT"))%>' />(B)</TD>
								</tr>
								<tr class="datagrid">
								<TD colspan="5" class="mantatory"><span id="cpl3">Note : GBC = Gross Bank Credit</span></TD>
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
</td>
</tr>
</table>
<br/>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Comments_Audit Trail'  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidpage" value="Industry">
<input type="hidden" name="cattype" value="<%=strCategoryType%>">
<input type="hidden" name="hidflag" value="">
<input type="hidden" name="hidCommentPage" value="exptoinds">  
<input type="hidden" name="hidAppNo" value="<%=Helper.correctNull((String)request.getParameter("appno"))%>">
</form>

</body>
</html>