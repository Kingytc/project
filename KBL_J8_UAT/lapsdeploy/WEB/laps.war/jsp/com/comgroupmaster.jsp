<%@ include file="../share/directives.jsp"%>
<%
	String mode = Helper.correctNull(request.getParameter("mode"));
	String expid = Helper.correctNull(request.getParameter("expid"));
	if(expid.equalsIgnoreCase("")){
		expid = Helper.correctNull((String)hshValues.get("expid"));
	}
	String exptype = Helper.correctNull((String) hshValues
			.get("exptype"));
%>
<html>
<head>
<title>Commercial-Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 150;
	overflow: auto;
}
</STYLE>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script langauge="Javascript">
var mode="<%=mode%>";
var isnew="false";
var appURL="<%=ApplicationParams.getAppUrl()%>"; 
 function callCalender(tname)
 {
	 if(document.forms[0].cmdedit.disabled)
		 showCal("<%=ApplicationParams.getAppUrl()%>",tname);
 }

function enableHelp()
{
	if(document.forms[0].exp_type.selectedIndex==1)
	{
		if(mode=="new" || mode=="Insert")
		{
			document.all.helpid.style.visibility="visible";
			document.all.industry1.style.visibility="hidden";
			document.all.industry2.style.visibility="hidden";
			document.all.industry3.style.visibility="hidden";
			document.forms[0].exp_desc.readOnly=true;
		}
		else {
			document.all.industry1.style.visibility="visible";
			document.all.industry2.style.visibility="visible";
			document.all.industry3.style.visibility="visible";
			document.forms[0].exp_bsrdesc.readOnly=true;
		}
	}
	else
	{
		document.all.helpid.style.visibility="hidden";
		document.all.industry1.style.visibility="hidden";
		document.all.industry2.style.visibility="hidden";
		document.all.industry3.style.visibility="hidden";
		document.forms[0].exp_desc.readOnly=false;
		document.forms[0].exp_bsrdesc.value="";
		document.forms[0].exp_bsrdesc.readOnly=false;
		document.forms[0].exp_bsrmaxexp.value="";
		document.forms[0].exp_bsrexpirydate.value="";
	}
}

function enableHelp1()
{
	var exptyp="<%=exptype%>";
	if(exptyp==null) exptyp="";
	if(exptyp=="Industry")
	{
		document.all.helpid.style.visibility="visible";
		document.forms[0].exp_desc.readOnly=true;
	}
	else
	{
		document.all.helpid.style.visibility="hidden";
		document.forms[0].exp_desc.readOnly=false;
	}
}

function menuOptionDivMouseDown (url) {
		if(!document.forms[0].cmdsave.disabled)
	{
		ShowAlert(103);
		return;
	}
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			//window.location=url;
			document.forms[0].action=url;
			document.forms[0].submit();
			//}
		}
function loadVal()
{
	if(mode=="new")
	{
		disablebuttons(true,false,true,true,true,false);
		disableControls(false,false,false,false);
	}
	else
	{
		disablebuttons(false,true,true,false,false,false);
		disableControls(true,true,true,true);
	}
	enableHelp();
	document.forms[0].exp_desc.readOnly=true;

	document.forms[0].hidBeanId.value="exposure";
	document.forms[0].hidBeanMethod.value="updateExp";
	document.forms[0].hidBeanGetMethod.value="getExpData";
}

function disablebuttons(flg1,flg2,flg3,flg4,flg5,flg6)
{
	document.forms[0].cmdedit.disabled=flg1;
	document.forms[0].cmdsave.disabled=flg2;
	document.forms[0].cmdcancel.disabled=flg3;
	document.forms[0].cmddelete.disabled=flg4;
//	document.forms[0].help.disabled=flg5;
	document.forms[0].cmdclose.disabled=flg6;
}

function disableControls(flg1,flg2,flg3,flg4)
{
	document.forms[0].exp_type.disabled=flg1;
	document.forms[0].exp_desc.readOnly=flg2;
	document.forms[0].exp_maxexp.readOnly=flg3;
	document.forms[0].exp_expirydate.readOnly=flg4;
}

function doSave()
{
	if(mode=="new") 
		mode="Insert";
	var currdate = "<%=Helper.getCurrentDateTime()%>";
	var d1 = new Date(document.forms[0].exp_expirydate.value); 
	var d2 = new Date(currdate);

	if(document.forms[0].exp_type.value=="")
	{
		alert("Select the Type");
		document.forms[0].exp_type.focus();
	}
	else if(document.forms[0].exp_desc.value=="")
	{
		alert("Enter the Description");
		document.forms[0].exp_desc.focus();
	}
	else if(parseFloat(document.forms[0].exp_maxexp.value)==0.00)
	{
		alert("Enter the Maximum Exposure Limit");
		document.forms[0].exp_maxexp.focus();
	}
	else if(document.forms[0].exp_expirydate.value=="")
	{
		alert("Enter the Expiry Date");
		document.forms[0].exp_expirydate.focus();
	}
	else if(document.forms[0].txt_panno.value=="")
	{
		alert("Enter the Group PAN No");
		document.forms[0].txt_panno.focus();
		return;
	}
	
	else
	{
		if(d1<d2)
		{
			alert("Expiry Date should be greater than Current Date");
			return false;
		}
		document.forms[0].mode.value=mode;
		document.forms[0].exp_type.disabled=false;
	/*	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
		//hidBeanId=exposure&hidBeanMethod=updateExp";
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidBeanId.value="exposure";
		document.forms[0].hidBeanMethod.value="updateExp";
		document.forms[0].hidBeanGetMethod.value="getExpData";
		document.forms[0].hidSourceUrl.value = "/action/comgroupmaster.jsp?hidBeanId=exposure&hidBeanGetMethod=getExpData";
		document.forms[0].submit();*/ 
		//old one crashing server modified mck
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comgroupmaster.jsp";
		document.forms[0].submit();
	}
}

function doEdit()
{
	mode="update";
	disablebuttons(true,false,false,true,true,true);
	disableControls(true,false,false,false);
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		mode="delete";
		document.forms[0].mode.value=mode;
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
		document.forms[0].hidBeanId.value="exposure";
		document.forms[0].hidBeanMethod.value="updateExp";
		//hidBeanId=exposure&hidBeanMethod=updateExp";
		document.forms[0].hidSourceUrl.value = "/action/comgroupmaster.jsp";
		document.forms[0].submit();
	}
}

function callIndcodehelp()
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		var prop = "scrollbars=no,width=450,height=300";	
		prop = prop + ",left=200,top=160";
		var url="<%=ApplicationParams.getAppUrl()%>action/comindlist.jsp?hidBeanId=exposure&hidBeanGetMethod=getExpData&expid=1";
		window.open(url,"",prop);
	}
	else
	{
		alert("Help is not available now");
	}
}

function callDescHelp(page)
{	
	if(isnew!="true")
	{
		if(page=="industrymaster")
		{
			//var varQryString = appURL+"action/comindlist.jsp?page="+page;
			var varQryString = appURL+"action/ops_sanctionhelp.jsp?id=47&pagename="+page;
			var title = "IndustryGroupHelp";
			var prop = "scrollbars=no,width=450,height=300";	
			prop = prop + ",left=200,top=160";
			window.open(varQryString,title,prop);
		}
		else if(document.forms[0].txt_grpcode.value!="" && page=="industry")
		{
			if(document.forms[0].cmdedit.disabled)
			{
				var varQryString = appURL+"action/comindlist.jsp?page="+page+"&grpcode="+document.forms[0].txt_grpcode.value;
				var title = "IndustryHelp";
				var prop = "scrollbars=no,width=450,height=300";	
				prop = prop + ",left=200,top=160";	
				window.open(varQryString,title,prop);
			}
			else
			{
				alert('Press Edit to continue');
			}
		}
	}
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/comcustsearch.jsp";
		document.forms[0].submit();
	}
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/comgroupmaster.jsp";
		document.forms[0].submit();		
	}
}
function checkpanno(field)
{
	var panvaluetemp=field.value;
	var panvalue=panvaluetemp.toUpperCase();
	field.value=panvalue;
	var regExp = /^[A-Z]$/;	
	var regExpnum = /^[0-9]$/;	

	if(panvalue!="")
	{
		if(panvalue.length==5 && panvalue=="NOPAN")
		{
			return;
		}
		else if(panvalue.length!=10)
		{
			alert('Enter NOPAN, if PANNO not available or else enter correct PANNO');
			field.value="";
			field.focus();
			return;
		}
		
		else
		{
			for(var si=0;si<5;si++)
			{
				if (!panvalue.charAt(si).match(regExp))
				{
					alert('FIRST FIVE Characters should be ALPHABETS');
					field.value="";
					field.focus();
					break;
				}
				
			}
			for(var si=5;si<9;si++)
			{
				if (!panvalue.charAt(si).match(regExpnum))
				{
					alert('SIXTH TO NINTH CHARACTER MUST BE NUMBER');
					field.value="";
					field.focus();
					break;
				}
			}
			
			if(panvalue.length==10 && !(panvalue.charAt(9).match(regExp)))
			{
				alert('LAST character must be ALPHABET');
				field.value="";
				field.focus();
				return;
			}
	    	if(panvalue.length >= 5 && panvalue.substring(0,5)=='NOPAN')
			{
			  alert('Enter NOPAN only');
			  field.value="";
			  field.focus();
			  return;
			}
		}
	}
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">

</head>

<body  onload="loadVal()">

<form name="appform" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Commercial(Applicant Master)
		-&gt; Group Master Details -&gt;Exposure Limit</td>
	</tr>
	<tr>
		<td align="right">&nbsp;</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5"
	class="outertable" align="center">
	<tr>
		<td valign="top"><br>
		<br>
		<table border="0" cellspacing="0" cellpadding="15" align="center"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="10"
					class="outertable border1" align="center">
					<tr>
						<td valign="top">
						<div align="left"></div>
						<table width="100%" border="0" cellspacing="0" cellpadding="10"
							align="center" class="outertable">
							<tr>
								<td width="59%">Type</td>
								<td width="34%"><select name="exp_type"
									onChange="enableHelp()">
									<option value="" selected>----Select----</option>
									<option value="Industry"
										<%if (exptype.equalsIgnoreCase("Industry"))
				out.println("selected");%>>Industry
									</option>
									<option value="Group"
										<%if (exptype.equalsIgnoreCase("Group"))
				out.println("selected");%>>Group</option>
								</select></td>
							</tr>
							<tr>
								<td width="59%">Description</td>
								<td width="34%"><input type="text" name="exp_desc"
									size="80" maxlength="100" style="text-align: left;"
									onKeyPress="notAllowedDouble()"
									value="<%=Helper.correctNull((String) hshValues.get("expdesc"))%>"
									readOnly></td>
								<td id="helpid" style="visibility: hidden" width="7%"><b><span
									onClick="callDescHelp('industrymaster')" style="cursor: hand"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0" tabindex="81"></span></b></td>
							</tr>
							<tr>
								<td width="59%">Maximum Exposure Limit&nbsp;&nbsp;(%)</td>
								<td width="34%"><input type="text" name="exp_maxexp"
									size="20" maxlength="12"
									style="text-align: left; border-style: groove; text-align: right"
									onKeyPress="allowNumber(this)" onBlur="checkPercentage(this)"
									value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues.get("expmax"))))%>"
									onblur="roundtxt(this)"></td>
							</tr>
							<tr>
								<td width="59%">Expiry Date</td>
								<td width="34%">
								<table width="30%" border="0" cellspacing="0" cellpadding="0" class="outertable">
									<tr>
										<td width="70%"><input type="text" name="exp_expirydate"
											size="15" maxlength="10" style="text-align: left;"
											onBlur="checkDate(this);checkmindate(this,'<%=Helper.getCurrentDateTime()%>')"
											onKeyPress="notAllowedDouble();notAllowSpace()"
											value="<%=Helper.correctNull((String) hshValues.get("expdate"))%>">
										</td>
										<td width="30%" align="center"><a
											href="javascript:callCalender('exp_expirydate')"
											title="Click to view calender" border=0><img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											border="0"></a></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td width="59%">Group PAN No.</td>
								<td width="34%"><input type="text" name="txt_panno"
									size="20" maxlength="12" style="text-align: left;"
									 onBlur="checkpanno(this)" value="<%=Helper.correctNull((String) hshValues.get("exp_panno"))%>"/></td>
							</tr>
							<tr>		 
								<td width="59%">Group Borrower Name</td>
								<td width="34%"><input type="text" name="txt_borrowername"
									size="20" maxlength="20" style="text-align: left;"
									value="<%=Helper.correctNull((String) hshValues.get("exp_groupborr"))%>"/></td>
							</tr>
							<tr id="industry1">
								<td width="59%">BSR CODE</td>
								<td width="34%"><input type="text" name="exp_bsrdesc"
									size="80" maxlength="100" style="text-align: left;"
									value="<%=Helper.correctNull((String) hshValues.get("expbsrdesc"))%>"
									onKeyPress="notAllowedDouble()" readOnly></td>
								<td width="7%"><b><span
									onClick="callDescHelp('industry')" style="cursor: hand"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0" tabindex="81"></span></b></td>
							</tr>
							<tr id="industry2">
								<td width="59%">Maximum Exposure Limit&nbsp;&nbsp;(%) <br> (BSR code)</td>
								<td width="34%"><input type="text" name="exp_bsrmaxexp"
									size="20" maxlength="12"
									style="text-align: left; border-style: groove; text-align: right"
									onKeyPress="allowNumber(this)" onblur="roundtxt(this)"
									value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("expbsrmaxexp"))))%>">
								</td>
							</tr>
									
							<tr id="industry3">
								<td width="59%">Expiry Date <br> (BSR code)</td>
								<td width="34%">
								<table width="30%" border="0" cellspacing="0" cellpadding="0" class="outertable">
									<tr>
										<td width="70%"><input type="text"
											name="exp_bsrexpirydate" size="15" maxlength="10"
											style="text-align: left;"
											onBlur="checkDate(this);checkmindate(this,'<%=Helper.getCurrentDateTime()%>');notAllowedDouble();notAllowSpace()"
											value="<%=Helper.correctNull((String) hshValues.get("expbsrexpirydate"))%>">
										</td>
										<td width="30%" align="center"><a
											href="javascript:callCalender('exp_bsrexpirydate')"
											title="Click to view calender" border=0><img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											border="0"></a></td>
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
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
							
 <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="mode">  <input type="hidden" name="expid"
	value="<%=expid%>"> <input type="hidden" name="hidid">
<input type="hidden" name="txt_bsrcode"> <input type="hidden"
	name="txt_grpcode"
	value="<%=Helper.correctNull((String) hshValues
									.get("expgrp"))%>">
<input type="hidden" name="hidindcode"
	value="<%=Helper.correctNull((String) hshValues.get("expindcode"))%>">
<input type="hidden" name="exptype" value="<%=exptype%>">
<input type="hidden" name="hidkeyid" value="set">
</body>
</html>