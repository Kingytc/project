<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="lapschoice"  uri="/WEB-INF/laps.tld" %>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%

String strSSIType  =Helper.correctNull((String)request.getParameter("hidSSIType"));
String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));

if(strCategoryType.equals("CORPORATE"))
{
	strCategoryType ="CORP";
}

%>

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/agrborrowersearch.jsp";
		document.forms[0].submit();
	}

}
	function callLink(page,bean,method)
{
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appURL+"action/"+page;
	document.forms[0].submit();
}
function disableFields(one)
{	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	
		if(document.forms[0].elements[i].type=='textarea')
		{
			document.forms[0].elements[i].readOnly=one;
		}  
		
	} 	
}	

function doDelete()
{		
		if( ConfirmMsg(101))
		{
			document.forms[0].hidAction.value ="delete";
			document.forms[0].hidBeanMethod.value="updateADVMarketBorrowing";
			document.forms[0].hidBeanGetMethod.value="getADVMarketBorrowing";
			document.forms[0].hidBeanId.value="ADV1151";
			document.forms[0].hidSourceUrl.value="/action/adv_marketborrowing.jsp";	
			document.forms[0].action=appURL+"action/controllerServlet";
			document.forms[0].submit();
		}
	 
}
function doEdit()
{
 	disableFields(false);
	document.forms[0].hidAction.value ="update";
	document.forms[0].txt_marketborrow.focus(); 
	enableButtons(true, false, false, false, true);
}
function doSave()
{
	document.forms[0].cmdapply.disabled=true;
	document.forms[0].hidBeanMethod.value="updateADVMarketBorrowing";
	document.forms[0].hidBeanGetMethod.value="getADVMarketBorrowing";
	document.forms[0].hidBeanId.value="ADV1151";
	document.forms[0].hidSourceUrl.value="/action/adv_marketborrowing.jsp";	
	document.forms[0].action=appURL+"action/controllerServlet";
	document.forms[0].submit();
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="cancel"; 
		document.forms[0].hidSourceUrl.value="/action/adv_marketborrowing.jsp";
		document.forms[0].hidBeanId.value="ADV1151";
		//document.forms[0].hidBeanMethod.value="";
		document.forms[0].hidBeanGetMethod.value="getADVMarketBorrowing";
		document.forms[0].action=appURL+"action/controllerservlet";
		document.forms[0].submit(); 	
	}
}

function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdapply.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;

}
function onloading()
{
	disableFields(true);
	if(document.forms[0].appstatus.value=="Open/Pending")
    	enableButtons(false, true, true, true, false);
    else
    	enableButtons(true, true, true, true, false);
	
	
}			


</script>
</head>

<body onload="onloading()">
<form name="marketborrowing" method="post" action="">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="19" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<b><i>Home-&gt;
Tertiary-&gt; Proposal-&gt;ADV1151 -&gt;Market Borrowing</i></b>
<br>
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application />

<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1" align="center">
													<tr>
													
                              						<td align="center"><b>MARKET BORROWING</b> </td>
													</tr>
													</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
			<tr>
				
							<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
									<tr>
										<td  width="50%" height="60%" align="center">
											
													
									 					<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1" align="center">
															  <tr>
																  <td>Extent of Market borrowings</td>
																  <td><%=ApplicationParams.getCurrency()%>

																	<lapschoice:CurrencyTag name="txt_marketborrow" size="16" tabindex="1" maxlength="12" value='<%=Helper.correctNull((String)hshValues.get("extent")) %>'/>
																  </td>
															  </tr>
															  <tr>
																  <td>Nature of Market Borrowings</td>
																<td>
																	<textarea name="area_nature" cols="50" rows="5" tabindex="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("nature")) %></textarea>
																  </td>
															  </tr>
															  <tr>
																  <td>For Sanction office use</td>
																<td>
																	<textarea name="area_sanction" cols="50" rows="5" tabindex="3" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("sanction")) %></textarea>
																  </td>
															  </tr>
															</table>
   												</td><!-- added-->
  											</tr>
  										</table>
  
 
  		</td>
	</tr>
</table>
<br/>
	<table border='1' cellspacing='0'cellpadding='0' bordercolorlight='#FFFFFB' bordercolordark='#DEDACF' bgcolor='#DEDACF' align='center'>
		<tr>
			<td>
				<table width='0%' border='0' cellspacing='0' cellpadding='3'>
					<tr valign='top'>
						<td><input type='button' name='cmdedit' value='Edit' onClick="doEdit()" tabindex="4"  
						class="buttonStyle"></td>
						<td><input type='button'name='cmdapply' value='Save' onClick="doSave()"  tabindex="5"
						class="buttonStyle"></td>
						<td><input type='button' name='cmdcancel' value='Cancel' onClick="doCancel()" tabindex="6"
						class="buttonStyle"></td>
						<td width="0"><input type="button" name="cmddel" value="Delete" tabindex="7"
											class="buttonStyle"
											onClick="doDelete()"></td>
						<td><input type='button' name='cmdclose' value='Close' onClick="doClose()" tabindex="8"
						class="buttonClose"></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="3">
	<tr> 
      <td width="20%" align="left"><b>&nbsp; 
        <a href="javascript:callLink('adv_commentsonstatus.jsp','ADV1151','getcommentsonstatus')" class="blackfont"> 
        &lt;&lt; Previous </a>&nbsp;</b> </td>
      <td width="60%" align="center"><b> 
        <jsp:include page="../ADV11-51/adv_links.jsp" flush="true" /> 
        </b></td>
      <td width="20%">&nbsp; 
        <div align="right"><b>Pg.3/24&nbsp;<a href="javascript:callLink('adv_dishonours.jsp','ADV1151','getdishonours')" class="blackfont"> 
          Next &gt;&gt; </a></b></div>
      </td>
    </tr>
</table>
	<lapschoice:hiddentag/> 
</form>
</body>
</html>
