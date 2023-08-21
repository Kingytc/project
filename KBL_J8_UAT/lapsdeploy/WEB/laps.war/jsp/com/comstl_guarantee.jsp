<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror/>
<%
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
arrRow=(ArrayList)hshValues.get("arrCol");
String strSSIType = Helper.correctNull((String) request.getParameter("hidSSIType"));
String strCategoryType = Helper.correctNull((String) request.getParameter("hidCategoryType"));
%>
<html>
<head>
<title>Short Term Loan</title>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";

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
	}
}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanGetMethod.value="getValues";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comstl_guarantee.jsp";
		document.forms[0].submit();
	 }
}
function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanMethod.value="updatePromoter";
		document.forms[0].hidBeanGetMethod.value="getValues";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comstl_guarantee.jsp";
 		document.forms[0].submit();
	 }
}
function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdapply.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddel.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}

function doNew()
{
		disableFields(false);
		document.forms[0].fname.focus();
		enableButtons(true,true,false,false,false,false);
		document.forms[0].hidAction.value="insert";
}

function doEdit()
{
	disableFields(false);
	enableButtons(true,true,false,false,false,true)
	document.forms[0].hidAction.value="update";
}

function doSave()
{
	if(document.forms[0].fname.value=="")
	{
		alert('Enter the Guarantor name');
		document.forms[0].sel_sanction.focus();
		return;
	}
	document.forms[0].cmdapply.disabled = true;
	document.forms[0].hidBeanId.value="compro"
	document.forms[0].hidBeanMethod.value="updatePromoter";
	document.forms[0].hidBeanGetMethod.value="getValues";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/comstl_guarantee.jsp";
	document.forms[0].submit();
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
}
function palceValues(val1,val2,val3)
{
	document.forms[0].fname.value=val1;
	document.forms[0].txt_means.value=val2;
	document.forms[0].cho.value=val3
	if(document.forms[0].btnenable.value=='Y')
	{
		enableButtons(true,false,true,true,true,false);
	}
	else
	{
		enableButtons(true,true,true,true,true,false);
	}
}
function callLink(page,bean,method)
{
	if(!document.forms[0].cmdapply.disabled)
	{
		ShowAlert(103);
		return;
	}
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
}


</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body onload="placeValues()">
<form name="slt" method=post>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td valign="top" colSpan=5>
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="2" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
<%if(strCategoryType.equalsIgnoreCase("STL")){ %>
	<tr>
	      <td class=page_flow>Home -&gt;Corporate &amp; SME -&gt; Short Term Loan  -&gt; Promotors</td>
	</tr>
<%}else if (strCategoryType.equalsIgnoreCase("ADC")){ %>
	<tr>
	      <td class=page_flow>Home -&gt;Corporate &amp; SME -&gt; Adhoc Limit  -&gt; Promotors</td>
	</tr>
<%} %>	
</table>
	
<span style="display:none;"><laps:borrowertype /></span><laps:application/>
<%if(!strCategoryType.equalsIgnoreCase("ADC")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center">
	<tr>
		<td valign="bottom">
		<table width="40%" border="0" cellspacing="3" cellpadding="3"
			align="left">
			<tr>
				<td width="34%" align="center" bgcolor="#71694F" id="prin"><b><font
					color="#FFFFFF">Promoters / Directors </font></b></td>
				<td width="33%" align="center" bgcolor="#EEEAE3" id="prin"><b><b><a
					href="javascript:callLink('comgroupcompanies.jsp','executive','getData7')"
					class="blackfont">Group Concerns </a></b></b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%} %>
<table width="90%" border="0" cellspacing="2" cellpadding="3" align="center">
    <tr> 
      <td colspan="4" align="center">&nbsp;</td>
    </tr>
    <tr > 
      <td width="22%" align="center">Name</td>
      <td width="30%"> 
        <input type="text" name="fname" size="50" maxlength="80"	onKeyPress="notAllowSplChar()">
      </td>
      <td width="24%" align="center">Means</td>
      <td width="24%"><laps:CurrencyTag name="txt_means" size="15" value='' maxlength="12"/></td>
    </tr>
    <tr> 
      <td  colspan="4">&nbsp;</td>
    </tr>
    <laps:combutton btntype="NO" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' /> 
    <tr> 
      <td colspan="4">&nbsp;</td>
    </tr>
    <tr> 
      <td  colspan="4"> 
        <table width="80%" border="0" cellspacing="1" cellpadding="3" align="center">
          <tr> 
            <td class="tabactivenew" width="6%">&nbsp; </td>
            <td class="tabactivenew" width="58%" align="center">Name</td>
            <td class="tabactivenew" width="36%" align="center">Means</td>
   		 </tr>
      <%
		if(arrRow!=null && arrRow.size()>0)
		{
			for(int i=0; i<arrRow.size();i++)
			{
				arrCol=(ArrayList)arrRow.get(i);
		%>
          <tr  valign="top"> 
            <td width="6%"> 
              <input type="radio" name="rdosec" onclick="palceValues('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))%>','<%=Helper.correctNull((String)arrCol.get(2))%>')" style="border:none">
            </td>
            <td width="58%"><%=Helper.correctNull((String)arrCol.get(0))%></td>
            <td width="36%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))%></td>
          </tr>
          <%
			}
		}
	%>
        </table>
      </td>
    </tr>
</table>
<br>
<laps:hiddentag/>
<input type="hidden" name="hidsno" />
<input type="hidden" name="hid_str_type" value="G@" />
<input type="hidden" name="cho" value="" />
</form>
</body>
</html>