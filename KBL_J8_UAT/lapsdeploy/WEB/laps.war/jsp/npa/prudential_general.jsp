<%@include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<%
			String flag = Helper.correctNull((String) hshValues.get("flag"));
			String comments = Helper.correctNull((String) hshValues
					.get("comments"));
			String strbankarrangement = Helper.correctNull((String) hshValues
					.get("bankarrangement"));
			
			HashMap hshAppdata=new HashMap();
			hshAppdata=(HashMap)hshValues.get("hshAppdata");
			
			String strAppno="";
			String strcbsid="";
			String appname="";
			String strAppstatus="";
			String appstatus="";
			String strAppname="";
			String readFlag="";
			String strBorrowertype="";
			String strmoduletype="";
			String strBTNEnable="";
			String npaorgscode="";
			String strAppholder="";
			String strOrgname="";
			
			strAppno = Helper.correctNull((String) hshAppdata.get("npaappno"));
			strcbsid = Helper.correctNull((String) hshAppdata.get("cbsid"));
			appname = Helper.correctNull((String) hshAppdata.get("customername"));
			strAppname=Helper.encodeAmpersand(appname);
			appstatus = Helper.correctNull((String) hshAppdata.get("status"));
			strBorrowertype = Helper.correctNull((String) hshAppdata.get("demoapptype"));
			strmoduletype = Helper.correctNull((String) hshAppdata.get("moduletype"));
			strBTNEnable = Helper.correctNull((String) hshAppdata.get("btnenable"));
			readFlag= Helper.correctNull((String) hshAppdata.get("readflag"));
			npaorgscode=Helper.correctNull((String) hshAppdata.get("createorgscode"));
			strAppholder=Helper.correctNull((String) hshAppdata.get("holduserid"));
			strOrgname=Helper.correctNull((String) hshAppdata.get("apporgname"));

			if(appstatus.equalsIgnoreCase("OP")||appstatus.equalsIgnoreCase("PP")){
				strAppstatus="Open/Pending";
			}
			else if(appstatus.equalsIgnoreCase("PA")){
				strAppstatus="Processed/Approved";
			}
			else if(appstatus.equalsIgnoreCase("PR")){
				strAppstatus="Processed/Rejected";
			}
			else if(appstatus.equalsIgnoreCase("CA")){
				strAppstatus="Closed/Approved";
			}
			else if(appstatus.equalsIgnoreCase("CR")){
				strAppstatus="Closed/Rejected";
			}
%>

<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css" />
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>	
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var flag="<%=flag%>";
var comments="<%=comments%>";
var varbankarrangement = "<%=strbankarrangement%>";
var varproposaltype="<%=Helper.correctNull((String)hshValues.get("propfor"))%>";
var unit="<%=Helper.correctNull((String)hshValues.get("unitstatus"))%>";
var unitwork="<%=Helper.correctNull((String)hshValues.get("unitrunfor"))%>";
var compro_ecgc="<%=Helper.correctNull((String)hshValues.get("ecgcclaimed"))%>";
var varOrgLevel="<%=strOrgLevel%>";


function disableCommandButtons(valedit,valapply,valcancel,valclose)
{
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmdsave.disabled=valapply;
	//document.forms[0].cmddelete.disabled=false;
	document.forms[0].cmdcancel.disabled=valcancel;		 
	document.forms[0].cmdclose.disabled=valclose;
}

function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
	}
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
	 		document.forms[0].elements[i].disabled=val;
	 	}	  
		if(document.forms[0].elements[i].type=='text')
	 	{
	 	
	 		if(document.forms[0].elements[i].name=="txt_activity")
	 			document.forms[0].elements[i].readOnly=true;
	 		else if(document.forms[0].elements[i].name=="txt_advancesince")
	 			document.forms[0].elements[i].readOnly=true;
	 		else if(document.forms[0].elements[i].name=="txt_npasince")
	 			document.forms[0].elements[i].readOnly=true;
	 		else if(document.forms[0].elements[i].name=="txtconstitution")
	 			document.forms[0].elements[i].readOnly=true;
	 		else	
				document.forms[0].elements[i].readOnly=val;
	 	}  
	}
}

function onLoading()
{
	if(comments!="")
	{
		alert(comments);
		document.forms[0].action=appURL+"action/npa_mainlinknav.jsp";
		document.forms[0].submit();
	}	
	
	if(document.forms[0].appno.value=="NEW")
	{
		disableFields(false);
		document.forms[0].hidAction.value ="insert";
		document.forms[0].hideditflag.value="Y";
		document.forms[0].selproptype.focus();
		disableCommandButtons(true,false,true,false);	
	}
	else
	{
		if(varbankarrangement!="")
		{
			document.forms[0].sel_bankarrangement.value=varbankarrangement;
		}
		if(varproposaltype!="")
		{
			document.forms[0].selproptype.value=varproposaltype;
		}
		
		if(unit!="")
		{
			document.forms[0].sel_unitstatus.value=unit;
		}
		else
		{
			document.forms[0].sel_unitstatus.value="0";
		}
		if(unitwork!="")
		{
			document.forms[0].sel_unitrunfor.value=unitwork;
		}
		if(compro_ecgc!="")
		{
			document.forms[0].sel_ecgc.value=compro_ecgc;
		}
		else
		{
			document.forms[0].sel_ecgc.value="0";
		}
		showECGC();
		showworkstatus();
		disableFields(true);	
		//disableCommandButtons(false,true,true,false);	
	}
	document.all.cmddelete.style.visibility="hidden";
	document.all.cmddelete.style.position="absolute";
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hideditflag.value="Y";
	disableCommandButtons(true,false,false,true);	
	document.forms[0].txt_provision.focus();
}

function doSave()
{
	if(document.forms[0].txt_propamt.value=="")
	{
		ShowAlert('121','Nominal Balance');
		document.forms[0].txt_propamt.focus();
		return;
	}
	if(document.forms[0].selproptype.value=="" || document.forms[0].selproptype.value=="0")
	{
		ShowAlert('111','Proposal Type');
		document.forms[0].selproptype.focus();
		return;
	}
	document.forms[0].hidSourceUrl.value="/action/prudential_general.jsp";
	document.forms[0].hidBeanId.value="npacommon";
	document.forms[0].hidBeanGetMethod.value="updateGeneralinfoData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getGeneralinfoData";
		document.forms[0].action=appURL +"action/prudential_general.jsp";
		document.forms[0].submit(); 		
	}	
}

function doClose()
{
	if(ConfirmMsg('100'))
	{
		document.forms[0].action=appURL+"action/npa_mainlinknav.jsp";
		document.forms[0].submit();
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{	
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidSourceUrl.value="/action/prudential_general.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updateGeneralinfoData";
		document.forms[0].hidBeanGetMethod.value="getGeneralinfoData";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit(); 
	}
}	

function callLink(page,bean,method)
{
	if (document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
}	

function clearAllFeilds()
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].value="";
		}
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].value="";
		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].value="0";
		}			  
	}
}

function showECGC()
{
	if(document.forms[0].sel_ecgc.value=="1")
	{
		document.all.ecgc1.style.visibility="visible";
		document.all.ecgc2.style.visibility="visible";
	}
	else
	{
		document.all.ecgc1.style.visibility="hidden";
		document.all.ecgc2.style.visibility="hidden";
		document.forms[0].txt_excessdate.value="";
	}
}

function showworkstatus()
{
	if(document.forms[0].sel_unitstatus.value=="1")
	{
		document.forms[0].txt_unitclosedsince.value="";
		document.all.close.style.visibility="hidden";
		document.all.close.style.position="absolute";
		document.all.status.style.visibility="visible";
		//document.all.status.style.position="absolute";
	}
	else if(document.forms[0].sel_unitstatus.value=="2")
	{
		document.all.close.style.visibility="visible";
		document.all.close.style.position="relative";
		document.forms[0].sel_unitrunfor.value="0";
		document.all.status.style.visibility="hidden";
		document.all.status.style.position="relative";
	}
	else
	{
		document.forms[0].sel_unitrunfor.value="0";
		document.all.status.style.visibility="hidden";
		document.all.status.style.position="relative";
		document.forms[0].txt_unitclosedsince.value="";
		document.all.close.style.visibility="hidden";
		document.all.close.style.position="absolute";
	}
}
</script>
</head>
<body onload="onLoading()">
<form name="prudential_general" method="post" class="normal">

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable"
			align="left">
			<tr>
				<td><lapstab:pwourltag pageid="1" /></td>
			</tr>
			<tr>
				<td valign="top" class="page_flow">Home -&gt; NPA -&gt; Write Off
				-&gt;General -&gt; Banking Details</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
 <table width="100%" border="0" cellspacing="0" cellpadding="3"  class="outertable linebor">
	<tr class='applicationheader'>
		<td nowrap><b>Application No :</b></td>
		<td nowrap><b><%=strAppno%></b></td>

		<td nowrap><b>Applicant Name:</b></td>
		<td nowrap><b><%=appname%></b></td>
		
		<td nowrap><b>CBS CUSTOMER ID:</b></td>
		<td nowrap><b><%=strcbsid%></b></td>

		<td nowrap><b>Status:</b></td>
		<td nowrap><b><%=strAppstatus%></b></td>
	</tr>
	<tr class='applicationheader'>
		<td nowrap><b>Application Holder:</b></td>
		<td nowrap><b><%=strAppholder%></b></td>

		<td nowrap><b>Application Recd. from:</b></td>
		<td nowrap><b><%=strOrgname%></b></td>
		
		<td colspan="4">&nbsp;
		<input type="hidden" name="appstatus" value="<%=appstatus%>">
		<input type="hidden" name="appname" value="<%=strAppname%>">
		<input type="hidden" name="cbsid" value="<%=strcbsid%>">
		<input type="hidden" name="npaorgcode" value="<%=npaorgscode%>">
		<input type="hidden" name="appno" value="<%=strAppno%>">
		<input type="hidden" name="readFlag" value="<%=readFlag%>">
		<input type="hidden" name="hidmoduletype" value="<%=strmoduletype%>">
		<input type="hidden" name="hidborrowertype" value="<%=strBorrowertype%>">
		<input type="hidden" name="btnenable" value="<%=strBTNEnable%>">
		<input type="hidden" name="appholder" value="<%=strAppholder%>">
		<input type="hidden" name="apporgname" value="<%=strOrgname%>">
		</td>
		
	</tr>
</table>
<lapstab:npabankingdetails module='<%=strmoduletype%>' pageid="5" bankarrangement='<%=strbankarrangement%>'/>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td>

				<table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
					<tr>
						
                  <td width="19%">CONSTITUTION</td>
						
                  <td width="26%">
<input type="text"
							name="txtconstitution"
							value="<%=Helper.correctNull((String)hshValues.get("constitution"))%>"
							class="interfacefields"></td>
						
                  <td width="18%">PROVISION</td>
						
                  <td width="2%"><%=ApplicationParams.getCurrency()%></td>
						
                  <td width="35%">
<input type="text" name="txt_provision"
							maxlength="15" tabindex="2"  class="interfacefields"
							value='<%=Helper.correctNull((String)hshValues.get("provision"))%>'
							size="20" /></td>
					</tr>
					<tr>
						
                  <td width="19%"></td>
						
                  <td width="26%"></td>
					</tr>
					<tr>
						
                  <td width="19%" height="50">ACTIVITY</td>
						
                  <td width="26%"><b> 
                    <input type="text" name="txt_activity" maxlength="18"
							value="<%=Helper.correctNull((String)hshValues.get("activity"))%>"
							class="interfacefields" size="25"> </b></td>
						
                  <td width="18%">ADVANCE SINCE</td>
						
                  <td width="2%">&nbsp;</td>
						
                  <td width="35%"> 
                    <table width="20%" class="outertable">
							<tr>
								<td><input type="text" name="txt_advancesince" maxlength="10"
									value="<%=Helper.correctNull((String)hshValues.get("advancesince"))%>"
									size="12" class="interfacefields"
									onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')">
								</td>
								<td><!-- <a href="#" onClick="callCalender('txt_advancesince')"
									title="Click to view calender" border=0> <img
									src="<%//=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0"> </a> --></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						
                  <td width="19%">NPA SINCE</td>
						
                  <td width="26%"> 
                    <table width="20%" class="outertable">
							<tr>
								<td><input type="text" name="txt_npasince" maxlength="10"
									value="<%=Helper.correctNull((String)hshValues.get("npasince"))%>"
									size="12" class="interfacefields"
									onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')">
								</td>
								<td><!--<a href="#" onClick="callCalender('txt_npasince')"
									title="Click to view calender" border=0> <img
									src="<%//=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0"> </a>--></td>
							</tr>
						</table>
						</td>
						
                  <td width="18%">DOUBTFUL/LOSS SINCE</td>
						
                  <td width="2%">&nbsp;</td>
						
                  <td width="35%"> 
                    <table width="20%" class="outertable">
							<tr>
								<td><input type="text" name="txt_lossdoubtfulsince" maxlength="10"
									value="<%=Helper.correctNull((String)hshValues.get("lossdoubtsince"))%>"
									size="12"
									onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')">
								</td>
								<td><a href="#" onClick="callCalender('txt_lossdoubtfulsince')"
									title="Click to view calender" border=0> <img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0"> </a></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						
                  <td width="19%">PROPOSAL TYPE</td>
						
                  <td width="26%">
<select name="selproptype" tabindex="3">
							<option value="0" selected>Select</option>
							<option value="1">Prudential Writeoff</option>
							<option value="2">Absolute Writeoff</option>
						</select></td>
						
                  <td width="18%">NOMINAL BALANCE</td>
						
                  <td width="2%"><%=ApplicationParams.getCurrency()%></td>
						
                  <td width="35%"><laps:CurrencyTag name="txt_propamt" maxlength="15"
							tabindex="4"
							value='<%=Helper.correctNull((String)hshValues.get("propamt"))%>'
							size="20" /></td>
					</tr>
					<tr>
						
                  <td width="19%" rowspan="1">BANKING ARRANGEMENT</td>
						<td colspan="4"><input type="hidden" name="sel_bankarrangement" value="<%=Helper.correctNull((String)hshValues.get("bankarrangement"))%>">
						<input type="text" name="txt_bankarrangement" class="interfacefields"
						value="<%=Helper.correctNull((String)hshValues.get("bankarrangement")).equals("1")?"Sole":Helper.correctNull((String)hshValues.get("bankarrangement")).equals("2")?"Consortium":Helper.correctNull((String)hshValues.get("bankarrangement")).equals("3")?"Multiple":"" %>" />
						</td>
					</tr>
					<tr>
						
                  <td width="19%" rowspan="1">DICGC / ECGC CLAIMS SETTLED</td>
						
                  <td width="26%">
<select name="sel_ecgc" onChange="showECGC()"
					tabindex="11">
					<option value="0" selected>----Select----</option>
					<option value="1">YES</option>
					<option value="2">NO</option>
				</select></td>
				  <td id="ecgc1"   width="18%" colspan="1">DATE OF SETTLEMENT </td>
				  <td  width="2%">&nbsp;</td>
				  <td id="ecgc2" width="35%">
<table width="20%">
							<tr>
								<td> <input type="text"
					name="txt_excessdate" size="12" maxlength="10" tabindex="12"
					value="<%=Helper.correctNull((String)hshValues.get("sinceexcess"))%>"
					onBlur="checkDate(this)"></td>
								<td> <a href="#"
					onClick="callCalender('txt_excessdate')"
					title="Click to view calender" border=0><img
					src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
					border="0" tabindex="12"></a></td>
							</tr>
						</table></td>
					</tr>
					
					<tr> 
                  <td width="19%">WHETHER UNIT IS RUNNING OR CLOSED.</td>
                  <td width="26%"> 
                    <input type="hidden" name="sel_unitstatus" value="<%=Helper.correctNull((String)hshValues.get("unitstatus"))%>">
                    <input type="text" name="txt_unitstatus" class="interfacefields"
						value="<%=Helper.correctNull((String)hshValues.get("unitstatus")).equals("1")?"Working":Helper.correctNull((String)hshValues.get("unitstatus")).equals("2")?"Closed":"" %>" />
						
                  </td>
                  <td width="18%"></td> 
                  <td width="2%"></td>
                  <td width="35%"></td> 
                </tr>
                <tr id="status">
                	
                  <td width="19%">If Running</td>
                  	
                  <td width="26%"> 
                    <input type="hidden" name="sel_unitrunfor" value="<%=Helper.correctNull((String)hshValues.get("unitrunfor"))%>">
                    	 <input type="text" name="txt_unitrunfor" class="interfacefields"
						value="<%=Helper.correctNull((String)hshValues.get("unitrunfor")).equals("1")?"Own Account":Helper.correctNull((String)hshValues.get("unitrunfor")).equals("2")?"Job Work":"" %>" />
					
                  	</td>
                  	
                  <td width="18%">&nbsp;</td>
                  	
                  <td width="2%">&nbsp;</td>
                  	
                  <td width="35%">&nbsp;</td>
                </tr>
                <tr id="close"> 
                  <td width="19%">SINCE WHEN UNIT IS CLOSED</td>
                  <td width="26%"> 
                    <table width="22%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                      <tr> 
                        <td> 
                          <input type="text" name="txt_unitclosedsince" size="12"
				maxlength="10" tabindex="3" onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')"
				value="<%=Helper.correctNull((String)hshValues.get("unitclosedsince"))%>" class="interfacefields">
                        </td>
                        <td> <!-- <a href="#" onClick="callCalender('unitclosedsince')"
				title="Click to view calender" border=0> <img src="<%//=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="3"></a> --> </td>
                      </tr>
                    </table>
                  </td>
                  <td  colspan="3">&nbsp; </td>
                </tr>
                <tr> 
                  <td width="19%">SOURCES OF LIVELIHOOD </td>
                  <td colspan="4"> 
                    <textarea rows="5" cols="40" name="txt_srclivehood" class="interfacefields"
                    onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" tabindex="4"><%=Helper.correctNull((String) hshValues
									.get("livehoodsrc"))%></textarea>
                  </td>
                </tr>
				</table>
				</td>
			</tr>
		</table>
		
		</td>
	</tr>
</table>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trial" btnenable='<%=strBTNEnable%>' /> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidclaimsettled" value="<%=Helper.correctNull((String)request.getParameter("hidclaimsettled"))%>" />
<input type="hidden" name="hidbankarrangement" value="<%=strbankarrangement%>">
<input type="hidden" name="hidDataFlag" value="<%=Helper.correctNull((String)hshValues.get("recordFlag"))%>">
</form>
</body>
</html>
