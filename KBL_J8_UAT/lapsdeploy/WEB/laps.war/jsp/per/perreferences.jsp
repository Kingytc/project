<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%ArrayList v = new ArrayList();
			String strFromLink = Helper.correctNull((String) request
					.getParameter("strfrom"));
			String strcomid = Helper.correctNull((String) hshValues.get("id1"));
			if (strcomid.equalsIgnoreCase("")) {
			 strcomid = Helper.correctNull((String) request
					.getParameter("hid_comappid1"));
			}

			if (strcomid.equalsIgnoreCase("")) {
				strcomid = Helper.correctNull((String) hshValues
						.get("hid_comappid2"));
			}%>
<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			ArrayList g1 = new ArrayList();
			String strAppname=Helper.correctNull((String)request.getParameter("hidapp_name"));
			if(strAppname.equals(""))
			{
				strAppname=Helper.correctNull((String)hshValues.get("strAppname"));
			}
			%>
			
			
<html>
<head>
<title>Existing Reference details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>htm/link.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var path      ="<%=ApplicationParams.getAppUrl()%>";
var strAction="<%=request.getParameter("hidAction")%>";
var  ref_id="<%=Helper.correctNull((String)hshValues.get("ref_id"))%>";
var  strid="<%=Helper.correctNull((String)hshValues.get("strid"))%>";
var  strName="<%=Helper.correctNull((String)hshValues.get("strName"))%>";
var  strDesg="<%=Helper.correctNull((String)hshValues.get("strDesg"))%>";
var strPhn="<%=Helper.correctNull((String)hshValues.get("strPhn"))%>";
var  strDet="<%=Helper.correctNull((String)hshValues.get(" strDet"))%>";
var varpageid="<%=Helper.correctNull((String)hshValues.get("PageId"))%>";

function selectValues(val1, val2, val3, val4, val5, val6)
{
   	document.forms[0].hid_sno.value =val1;
	document.forms[0].hid_comappid.value = val2;
	document.forms[0].txt_name.value= val3;
	document.forms[0].txt_design.value= val4;
	document.forms[0].txt_phone.value= val5;
	document.forms[0].txt_comments.value = val6;
	if(document.forms[0].readFlag.value.toUpperCase()=="W")
	{
		callDisableControls(true,false,true,true,true,false);
	}
}

function doSave()
{
    if((trimtxt(document.forms[0].txt_name.value)=="") && document.forms[0].hidAction.value=="insert")
	{
		 alert("Enter the reference name");
		 document.forms[0].txt_name.focus();
		 return;
	}
	if((trimtxt(document.forms[0].txt_phone.value)=="") && document.forms[0].hidAction.value=="insert")
	{
		 alert("Enter the phone number ");
		 document.forms[0].txt_phone.focus();
		 return;
	}	
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidSourceUrl.value="/action/perreferences.jsp";
	document.forms[0].hidBeanMethod.value="updrefData";
	document.forms[0].hidBeanId.value="refdetails";
	document.forms[0].hidBeanGetMethod.value="getrefData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function callDisableControls(cmdNew,cmdEdit,cmdApply,cmdCancel,cmdDelete,cmdClose)
{
	document.forms[0].cmdnew.disabled=cmdNew;
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdApply;
	document.forms[0].cmddelete.disabled=cmdDelete;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	callDisableControls(true,true,false,false,false,true)
}

function callhelp()
{
	var title = "ApplicantDemographics";
	var prop = "scrollbars=no,width=600,height=450";	
	prop = prop + ",left=200,top=150";
	window.open(varQryString,title,prop);
}

function doNew()
{
	disableFields(false);
	callDisableControls(true,true,false,false,true,true);
	document.forms[0].txt_name.value="";	 
	document.forms[0].txt_design.value="";
	document.forms[0].txt_phone.value="";
	document.forms[0].txt_comments.value="";
	document.forms[0].hidAction.value ="insert";
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='radio')
	 	{
			document.forms[0].elements[i].checked=false;
		}	  
	}
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="/action/perreferences.jsp";
		document.forms[0].hidBeanId.value="refdetails";
		document.forms[0].hidBeanGetMethod.value="getrefData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit(); 		
	}
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='textarea')
		{
			document.forms[0].elements[i].disabled=val;
		}	
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=(!val);
		}	 
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].hidBeanMethod.value="updrefData";
		document.forms[0].hidBeanGetMethod.value="getrefData";
		document.forms[0].hidBeanId.value="refdetails";
		document.forms[0].hidSourceUrl.value="/action/perreferences.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();		
	}	
}

function onloading()
{	 
	callDisableControls(false,true,true,true,true,false);
}

function call_page(url)
{
	document.forms[0].action=appURL+"action/"+url;
	document.forms[0].submit();
}

function callCalender()
{
	 showCal(appURL,'expirydate');
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		window.close();
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form name="frmpri" method=post class="normal">
<table width="98%" border="0" cellpadding="5" cellspacing="0"
	class="outertable"
	align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable linebor">
									<tr class="dataheader" align="center">
										<td width="21%">FamilyMember\Contact Person Name<span class="mantatory">*&nbsp;</span></td>
										<td width="26%">Relationship\Designation with the applicant</td>
										<td width="13%">Phone\Mobile Number<span class="mantatory">*&nbsp;</span> </td>
										<td width="27%">Address\Other Details </td>
									</tr>
									<tr class="datagrid" align="center">
										<td  width="21%"><input type="text" name="txt_name"
											size="20" maxlength="25" onKeyPress="notAllowSplChar()">
										</td>
										<td width="26%"><input type="text"
											name="txt_design" size="30" maxlength="40">
										</td>
										<td  width="13%"><input type="text" name="txt_phone"
											size="15" maxlength="15" onKeyPress="allowPhone()"
											style={text-align=left}>
										</td>
										<td  width="27%"><textarea name="txt_comments"
											onKeyPress="NoallowEnterandDoubleQuote();notAllowSingleQuote();textlimit(txt_comments,249)" onKeyUp="textlimit(this,249)"
											rows="3" cols="30" wrap="virtual"></textarea>
										</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td><br>
								<table width="12%" border="0" align="center" cellpadding="0"
									cellspacing="0" class="outertable"	>
									<tr>
										<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td><br>
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="outertable"	>
									<tr >
										<td>
										<table width="98.3%" border="0" cellspacing="0" cellpadding="2"
											class="outertable linebor">
											<tr class="dataheader" align="center">
												<td width="5%" align="center">&nbsp;</td>
												<td width="25%" align="center">
													Contact Person Name</td>
												<td width="30%" align="center">
													Relationship with the applicant</td>
												<td width="20%" align="center">
													Phone Number </td>
												<td width="20%" align="center">
													Address Details </td>
											</tr>
											</table>
											</td></tr>
											<tr>
											<td>
											<%if (v != null) {if(v.size()>6){ %>
								<div class="cellContainer">
								<%} }%>
								<table width="100%" border="0" cellspacing="1" cellpadding="3">
                                    <%v = (ArrayList) hshValues.get("vecData");
											String inside = "N";
											if (v != null) {
												int vecsize = v.size();
												for (int l = 0; l < vecsize; l++) {
													g1 = (ArrayList) v.get(l);
								
													%>
                                    <tr class="datagrid">
												<td width="5%" align="center"><input type="radio"
													style="border:none" name="radiobutton" value="radiobutton"
													onClick="javascript:selectValues('<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)g1.get(1))%>','<%=Helper.correctNull((String)g1.get(2))%>','<%=Helper.correctNull((String)g1.get(3))%>','<%=Helper.correctNull((String)g1.get(4))%>','<%=Helper.correctNull((String)g1.get(5))%>')">
												</td>
												<td width="25%"><%=Helper.correctNull((String) g1.get(2))%></td>
												<td width="30%">&nbsp;<%=Helper.correctNull((String) g1.get(3))%></td>
												<td width="20%">&nbsp;<%=Helper.correctNull((String) g1.get(4))%></td>
												<td width="20%">&nbsp;<%=Helper.correctNull((String) g1.get(5))%></td>
											</tr>
											<%}
										}%>
																					
										</table><%if (v != null) {if(v.size()>6){ %></div><%}} %>
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
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hid_comappid" value="<%=strcomid%>"> 
<input type="hidden" name="hid_sno" value="<%=Helper.correctNull((String)hshValues.get("strid"))%>">
<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
<input type="hidden" name="hidapp_name" value="<%=strAppname%>">
</form>
</body>
</html>
