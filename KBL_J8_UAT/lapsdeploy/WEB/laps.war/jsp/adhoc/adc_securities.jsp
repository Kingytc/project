<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<laps:handleerror />
<%ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrRow");
			String Valuesin = Helper.correctNull((String) request
					.getParameter("valuesin"));
%>
<html>
<head>
<title>Adhoc Security</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentdate ="<%=Helper.getCurrentDateTime()%>";
function enableButtons(valnew,valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdnew.disabled=valnew;
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmdapply.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddel.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
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
		else if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		
		}
	}
	
	document.forms[0].txtsecdesc.readOnly=true;
}

function onLoad()
{
	disableFields(true);
}

function doNew()
{
	document.forms[0].hidAction.value="Insert";
	disableFields(false);
	enableButtons(true,true,false,false,true,true);
}

function doEdit()
{
	document.forms[0].hidAction.value="Update";
	disableFields(false);
	enableButtons(true,true,false,false,false,true);
}

function doSave()
{
	if(document.forms[0].txtsecdesc.value=="")
	{
		ShowAlert(121,'Security');
		document.forms[0].txtsecdesc.focus();
		return true;
	}
	else if(document.forms[0].selsectype.value=="S")
	{
		ShowAlert(111,'Security Type');
		document.forms[0].selsectype.focus();
		return true;
	}
	else if(document.forms[0].txtsecvalue.value=="")
	{
		ShowAlert(121,'Security Value');
		document.forms[0].txtsecvalue.focus();
		return true;
	}
	
	else if(document.forms[0].txtsecdetails.value=="")
	{
		ShowAlert(121,'Security Details');
		document.forms[0].txtsecdetails.focus();
		return true;
	}
	
	else if(document.forms[0].txtsecvaldate.value=="")
	{
		ShowAlert(121,'Security Value as On ');
		document.forms[0].txtsecvaldate.focus();
		return true;
	}
	
	
	
	document.forms[0].hidBeanId.value="adhoc"
	document.forms[0].hidBeanMethod.value="updateSecurityData";
	document.forms[0].hidBeanGetMethod.value="getSecurityData"
	document.forms[0].hidSourceUrl.value="/action/adc_securities.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doCancel()
{
	document.forms[0].hidBeanId.value="adhoc"
	document.forms[0].hidBeanGetMethod.value="getSecurityData"
	document.forms[0].action=appURL+"action/adc_securities.jsp";
	document.forms[0].submit();
}

function doDelete()
{
	document.forms[0].hidAction.value="Delete";
	document.forms[0].hidBeanId.value="adhoc"
	document.forms[0].hidBeanMethod.value="updateSecurityData";
	document.forms[0].hidBeanGetMethod.value="getSecurityData"
	document.forms[0].hidSourceUrl.value="/action/adc_securities.jsp";
	document.forms[0].action=appURL+"controllerservlet";
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


function callDescHelp(id)
{	
	if(document.forms[0].cmdapply.disabled ==false  &&  document.forms[0].readFlag.value.toUpperCase()=="W")
	{
		var varQryString = appURL+"action/staticdatahelp.jsp?id="+id;
		var title = "IndustryHelp";
		var prop = "scrollbars=no,width=650,height=400";	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);	
	}
}

function palceValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13)
{
	document.forms[0].hidsno.value=val1;
	document.forms[0].hidsecid.value=val2;
	document.forms[0].txtsecdesc.value=val3;
	document.forms[0].txtsecdetails.value=document.getElementById("hidsecdesc"+val4).value;
	document.forms[0].txtsecvalue.value=val5;
	document.forms[0].txtsecvaldate.value=val6;
	document.forms[0].txtsectenor.value=val7;
	document.forms[0].selsectype.value=val8;
	if(val8=="Primary")
	{
		document.all.idfacility.style.visibility="visible";
		document.all.idfacility.style.position="relative";
		document.forms[0].sellimit.value=val13;
	}
	else
	{
		document.all.idfacility.style.visibility="hidden";
		document.all.idfacility.style.position="absolute";
		document.forms[0].sellimit.value="S";
	}
	document.forms[0].txtvaluername.value=val9;
	document.forms[0].txtinsuranceamt.value=val10;
	document.forms[0].txtinsexpdate.value=val11;
	document.forms[0].txtremarks.value=document.getElementById("hidsecremarks"+val4).value;
	if(document.forms[0].btnenable.value=='Y')
	{
		enableButtons(true,false,true,true,true,false);
	}
	else
	{
		enableButtons(true,true,true,true,true,false);
	}
}

function callCalender(val)
{
	if(document.forms[0].cmdapply.disabled==false)
	{
		 showCal(appURL,val);
	}
}
function callFacilities()
{
	if(document.forms[0].selsectype.value=="Primary")
	{
		document.all.idfacility.style.visibility="visible";
		document.all.idfacility.style.position="relative";
	}
	else
	{
		document.all.idfacility.style.visibility="hidden";
		document.all.idfacility.style.position="absolute";
		document.forms[0].sellimit.value="S";
	}
}
</script>
</head>
<body class="bgcolor" onload="onLoad()">
<form name="security" method="post"><lapstab:applurllinksadc pageid="2" />
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="page_flow">Corporate &amp; SME -&gt; Adhoc -&gt; Details of Secutites</td>
	</tr>
</table>
<laps:ADCApplications/> <laps:hiddentag/> 
<table width="100%" border="0" cellspacing="0" cellpadding="5"
	bgcolor="#DEDACF" class="outertable border1">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="2"
			class="outertable border1">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td>Security Type <span class="redfont"><b>*</b></span></td>
						<td><select name="selsectype" onchange="callFacilities()" tabindex="1">
							<option value="S" selected="selected">&lt;---Select---&gt;</option>
							<option value="Primary">Primary</option>
							<option value="Collateral">Collateral</option>
						</select></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr id="idfacility">
						<td>Main Limit</td>
						<td>
							<select name="sellimit" tabindex="2">
								<option value="S" selected="selected">&lt;---Select---&gt;</option>
								<laps:adcfacility/>
							</select>
						</td>
						
					</tr>
					
					<tr>
						<td valign="top">Security <span class="redfont"><b>*</b></span></td>
						<td><input type="text" name="txtsecdesc" size="70" maxlength="100" />
						<input type="hidden" name="hidsecid" /> <span
							onClick="callDescHelp('12')" style="cursor:hand"> <img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0" tabindex="3"></span></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top">Security Details <b><span class="redfont">*</span></b></td>
						<td valign="top"><textarea name="txtsecdetails" cols="50" rows="3"
							wrap="VIRTUAL" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" tabindex="4"></textarea></td>
						<td valign="top">Remarks</td>
						<td><textarea name="txtremarks" cols="50" rows="3" wrap="VIRTUAL"
							onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" tabindex="5"></textarea></td>
					</tr>
					<tr>
						<td valign="top">Security Value <span class="redfont"><b>*</b></span></td>
						<td valign="top"><laps:CurrencyTag name="txtsecvalue" size="15"
							maxlength="12" tabindex="6"/></td>
						<td>Security Value as On <span class="redfont"><b>*</b></span></td>
						<td><input type="text" name="txtsecvaldate" size="12"
							maxlength="10" onkeypress="checkDate(this)" onblur="checkmaxdate(this,currentdate)" tabindex="7"/> <a alt="Select date from calender" href="#"
							onClick="callCalender('txtsecvaldate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;">&nbsp;<img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender"></a></td>
					</tr>
					<tr>
						<td>Valuers Name</td>
						<td><input type="text" name="txtvaluername" size="70"
							maxlength="80" onkeypress="allowAlphabets()" tabindex="8"></td>
						<td>Security Tenor(In Months)</td>
						<td><input type="text" name="txtsectenor" size="5" maxlength="4" onkeypress="allowInteger()" tabindex="9"/>
						</td>
					</tr>
					<tr>
						<td>Insurance Amount</td>
						<td><laps:CurrencyTag name="txtinsuranceamt" size="15"
							maxlength="10" tabindex="10"/></td>
						<td>Insurance Expiry Date</td>
						<td><input type="text" name="txtinsexpdate" size="12"
							maxlength="10" onkeypress="checkDate(this)" onblur="checkmindate(this,currentdate)" tabindex="11"> <a alt="Select date from calender" href="#"
							onClick="callCalender('txtinsexpdate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;">&nbsp;<img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender"></a></td>
					</tr>
				</table>
				<br>
				<laps:combutton btntype="NO"
					btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />

				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="1" cellpadding="3">
	<tr align="center">
		<td class="tabactivenew" width="2%">&nbsp;</td>
		<td class="tabactivenew" width="24%"><b>Nature / Description of
		collateral security </b></td>
		<td class="tabactivenew" width="11%"><b>Value</b></td>
		<td class="tabactivenew" width="19%"><b>Date of Valuation along with
		name of Valuer</b></td>
		<td class="tabactivenew" width="17%"><b>Insurance Amount &amp; Date of
		Expiry</b></td>
		<td class="tabactivenew" width="27%"><b>Remarks</b></td>
	</tr>
	<%if (arrRow != null && arrRow.size() > 0) {
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = (ArrayList) arrRow.get(i);

					%>
	<tr bgcolor="#EAE4DB" valign="top">
		<td width="2%"><input type="radio" name="rdosec"
			onclick="palceValues('<%=Helper.correctNull((String)arrCol.get(0))%>',
			'<%=Helper.correctNull((String)arrCol.get(1))%>','<%=Helper.correctNull((String)arrCol.get(2))%>',
			'<%=i%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))%>',
			'<%=Helper.correctNull((String)arrCol.get(5))%>','<%=Helper.correctNull((String)arrCol.get(6))%>',
			'<%=Helper.correctNull((String)arrCol.get(7))%>', '<%=Helper.correctNull((String)arrCol.get(8))%>',
			'<%=Helper.correctNull((String)arrCol.get(9))%>', '<%=Helper.correctNull((String)arrCol.get(10))%>'
			,'<%=Helper.correctNull((String)arrCol.get(11))%>','<%=Helper.correctNull((String)arrCol.get(12))%>')"
			style="border: none"> <input type="hidden" name="hidsecdesc<%=i%>"
			value="<%=Helper.correctDoubleQuotesHtml((String)arrCol.get(3))%>"> <input
			type="hidden" name="hidsecremarks<%=i%>"
			value="<%=Helper.correctDoubleQuotesHtml((String)arrCol.get(11))%>">
		</td>
		<td width="24%"><%=Helper.correctNull((String) arrCol.get(3))%></td>
		<td width="11%" align="right"><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(4))))%></td>
		<td width="19%" align="center"><%=Helper.correctNull((String) arrCol.get(5))%>
		- <%=Helper.correctNull((String) arrCol.get(8))%></td>
		<td width="17%" align="center">&nbsp; <%if (Helper.formatDoubleValue(
							Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(9))))
							.equals("0.00")) {
						out.println("-");
					} else {%> <%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(9))))%>
		- <%=Helper.correctNull((String) arrCol.get(10))%></td>
		<%}%>
		<td width="27%"><%=Helper.correctNull((String) arrCol.get(11))%></td>
	</tr>
	<%}
			}

			%>
</table>
<iframe height="0" width="0" name="ifrm" frameborder="0" style="border:0"></iframe>
<input type="hidden" name="hidsno" /> 


<script>
						     var msg ="<%=Helper.correctNull((String)hshValues.get("msg"))%>";
						     if(msg!="")
						     {
						   	  alert(msg);
						     }
</script>
</form>
</body>
</html>

