<%@include file="../share/directives.jsp"%>
<%
	java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
	nf.setGroupingUsed(true);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);

	ArrayList vecRow = new ArrayList();
	ArrayList vecCol = new ArrayList();
	vecRow = (ArrayList) hshValues.get("vecRow");
	String strSector = Helper.correctNull((String) request
			.getParameter("hidsector"));
	String strappliedfor = Helper.correctNull((String) request
			.getParameter("appliedfor"));
	String strSaral = Helper.correctNull((String) request
			.getParameter("hidsaral"));
	String strProposal = Helper.correctNull((String) request
			.getParameter("hidproposal"));

	//Added by Zahoorunnisa.S for button functionality
    String strapplevel = Helper.correctNull((String)request.getParameter("applevel"));
	String strstatus = Helper.correctNull((String) request.getParameter("hidstatus"));
	if (strstatus.equals(""))
		strstatus = Helper.correctNull((String) hshValues.get("status"));
		//end
%>
<html>
<head>
<title>ROC Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
var varOrgLevel="<%=strOrgLevel%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";
function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}

function selectValues(val1,val2,val3,val4,val5,val7,val8,val9,i,size)
{
	document.forms[0].hid_strsno.value=val1;
	document.forms[0].comapp_date.value=val2;
	document.forms[0].comapp_date4.value=val8;
	document.forms[0].comapp_date2.value=val3;
	document.forms[0].comapp_amtofcreat.value=val9;
	document.forms[0].comapp_date3.value=val4;
	document.forms[0].comapp_mod2.value=val7;
	document.forms[0].comapp_mod.value=val5;
	if(size==1)
	{
		document.forms[0].comapp_details.value=document.forms[0].hidother.value;
	}
	else
	{
		document.forms[0].comapp_details.value=document.forms[0].hidother[i].value;
	}
	
	//Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh

	//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
		if("<%=strstatus%>"=="O"  &&  varright=="w"){
		    enableButtons(true,false,true,true,true,false);
		}else{
			enableButtons(true,true,true,true,true,false);	
		}
			
	} else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		
		enableButtons(true,true,true,true,true,false);	
		
    }else{
		
		if("<%=strapplevel%>" == "S"){
			enableButtons(true,true,true,true,true,false);
		}else{
			if(document.forms[0].btnenable.value=="Y"){
				enableButtons(true,false,true,true,true,false);
				
			}else {
				
				enableButtons(true,true,true,true,true,false);
			}
		}

		
	}

	//End

}
function doNew()
{
	disableFields(false);
	enableButtons(true,true,false,false,true,true);
	document.forms[0].hideditflag.value ="Y";	
	document.forms[0].hidAction.value ="insert";
   
}

function onloading()
{	

//Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh
	
	//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
		if("<%=strstatus%>"=="O"  &&  varright=="w"){
		    enableButtons(false,true,true,true,true,false);
		}else{
			enableButtons(true,true,true,true,true,false);	
		}
			
	} else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		
		enableButtons(true,true,true,true,true,false);
			
    }else{
		
		if("<%=strapplevel%>" == "S"){
			enableButtons(true,true,true,true,true,false);
		}
	}

	//End
	
  
}

function disableFields(val)
{	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}		  
	}
}

function callCalender(fname)
{
 	if(document.forms[0].cmdsave.disabled==false)
 	{
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}
 

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
}

function doSave()
{
	if(trim(document.forms[0].comapp_date.value) == "")
 	{
		alert("Enter Date of Initial Creation");
 		document.forms[0].comapp_date.focus();
 		return;
 	}
	if(trim(document.forms[0].comapp_amtofcreat.value) == "")
 	{
 		alert("Enter Amount of Creation");
 		document.forms[0].comapp_amtofcreat.focus();
 		return;
 	}
 	if(document.forms[0].comapp_date4.value != "" && document.forms[0].comapp_mod2.value=="")
 	{
 		alert("Enter Modification of Charge");
 		document.forms[0].comapp_mod2.focus();
 		return;
 	}
 	if(document.forms[0].comapp_date4.value == "" && document.forms[0].comapp_mod2.value !="" && document.forms[0].comapp_mod2.value != 0 )
 	{
 		alert("Enter Date of Modification of Charge");
 		document.forms[0].comapp_date4.focus();
 		return;
 	}
 	if(document.forms[0].comapp_date2.value != "" && document.forms[0].comapp_mod.value=="")
 	{
 		alert("Enter Satisfaction of Charge");
 		document.forms[0].comapp_mod.focus();
 		return;
 	}
 	if(document.forms[0].comapp_date2.value == "" && document.forms[0].comapp_mod.value!="" && document.forms[0].comapp_mod.value != 0)
 	{
 		alert("Enter Date of Satisfaction of Charge");
 		document.forms[0].comapp_date2.focus();
 		return;
 	}
 	document.forms[0].cmdsave.disabled = true;
 	document.forms[0].hidBeanId.value="commappmaster";		
	document.forms[0].hidBeanMethod.value="updaterocdetails";
	document.forms[0].hidBeanGetMethod.value="getrocdetails";
	document.forms[0].hidSourceUrl.value="action/rocdetails.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}  

function doEdit()
{ 
	disableFields(false);
	enableButtons(true,true,false,false,false,true);
	document.forms[0].hidAction.value ="Update";
	document.forms[0].hideditflag.value ="Y";
}

  
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="commappmaster";
		document.forms[0].hidBeanGetMethod.value="getrocdetails";
		document.forms[0].action=appURL+"action/rocdetails.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}

  
  
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		var varconfirm=ConfirmMsg('101');
		if(varconfirm)
		{
			document.forms[0].hidAction.value ="Delete";
			document.forms[0].action=appURL+"action/ControllerServlet";	
			document.forms[0].hidBeanMethod.value="updaterocdetails";
			document.forms[0].hidBeanGetMethod.value="getrocdetails";	
			document.forms[0].hidBeanId.value="commappmaster";
			document.forms[0].hidSourceUrl.value="action/rocdetails.jsp";	
			document.forms[0].method="post";			
			document.forms[0].submit();	
		}	
	}
	else
	{
		ShowAlert(158);
	}
}	


</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 200;
	overflow: auto;
}
</STYLE>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">

</head>
<body onLoad="onloading()">
<form method="post" class="normal">
<%
	if (strSaral.equalsIgnoreCase("saral")) {
%> <lapschoice:saralreportTag tabid="11" sector='<%=strSector%>'
	applied='<%=strappliedfor%>' proposal='<%=strProposal%>' /> <lapschoice:inward />
<%
	} else {
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="6" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; ROC
		Details</td>
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span><lapschoice:application /><br>
<table width="100%" border="0" cellspacing="0" cellpadding="5"
	align="center" class="outertablecolor">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td valign="top">
				<%
					}
				%>
				<table width="100%" border="0" cellspacing="0" cellpadding="4"
					class="outertable border1">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="4"
							class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="3"
									class="outertable">
									<tr>
										<td>Date of Initial Creation <span class="mantatory">*&nbsp;</span></td>
										<td>&nbsp;</td>
										<td><input type="text" name="comapp_date"
											onBlur="checkDate(this);checkmaxdate(this,currentDate)"
											value="" style="text-align: left;"> <a
											alt="Select date from calender"
											href="javascript:callCalender('comapp_date')"><img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											width="21" height="18" border="0"></a></td>
										<td>Amount of Creation <span class="mantatory">*&nbsp;</span></td>
										<td><input type="text" name="comapp_amtofcreat"
											onKeyPress="allowDecimals(this)" maxlength="15"
											onBlur="roundtxt(this)" value="" style="text-align: right;"></td>
									</tr>
									<tr>
										<td width="26%" nowrap="nowrap" colspan="2"></td>
										<td colspan="3"></td>
									</tr>
									<tr>
										<td>Modification of Charge &amp; Date</td>
										<td>&nbsp;</td>
										<td><input type="text" name="comapp_mod2"
											onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
											value="" maxlength="15" style="text-align: right;"></td>
										<td><input type="text" name="comapp_date4"
											onBlur="checkDate(this);checkmaxdate(this,currentDate)"
											value="" style="text-align: left;"> <a
											alt="Select date from calender"
											href="javascript:callCalender('comapp_date4')"><img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											width="21" height="18" border="0"></a></td>
										<td width="26%"></td>
									</tr>
									<tr>
										<td>Satisfaction of Charge &amp; Date, if any</td>
										<td>&nbsp;</td>
										<td><input type="text" name="comapp_mod"
											onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)"
											value="" maxlength="15" style="text-align: right;"></td>
										<td><input type="text" name="comapp_date2"
											onBlur="checkDate(this);checkmaxdate(this,currentDate)"
											value="" style="text-align: left;"> <a
											alt="Select date from calender"
											href="javascript:callCalender('comapp_date2')"><img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											width="21" height="18" border="0"></a></td>
										<td width="26%"></td>
									</tr>
									<tr>
										<td>Latest Search Report Date</td>
										<td>&nbsp;</td>
										<td colspan="3"><input type="text" name="comapp_date3"
											onBlur="checkDate(this);checkmaxdate(this,currentDate)"
											value="" style="text-align: left;"> <a
											alt="Select date from calender"
											href="javascript:callCalender('comapp_date3')"><img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											width="21" height="18" border="0"></a></td>
									</tr>
									<tr>
										<td>Details of Charges</td>
										<td>&nbsp;</td>
										<td colspan="3"><textarea name="comapp_details" cols="50"
											rows="6" onkeypress="textlimit(comapp_details,999)" onKeyUp="textlimit(this,999)"></textarea>
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
<lapschoice:combuttonnew
	btnnames='New_Edit_Save_Cancel_Delete_Audit Trail'
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3"
			class="outertable linebor">
			<tr class="dataheader">
				<td width="3%">&nbsp;</td>
				<td align="center" width="12%"><b>Date of Initial Creation</b></td>
				<td align="center" width="15%"><b>Amount of Creation </b></td>
				<td align="center" width="15%"><b>Modification of Charge
				&amp; Date </b></td>
				<td align="center" width="15%"><b>Satisfaction of Charge
				&amp; Date </b></td>
				<td align="center" width="15%"><b>Latest Search Report Date</b></td>
				<td align="center" width="15%"><b>Details of Charges </b></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<%
			if (vecRow.size() > 6) {
		%><div class="cellContainer">
		<%
			}
		%>
		<table width="100%" border="0" cellspacing="1" cellpadding="3">
			<%
				vecRow = (ArrayList) hshValues.get("vecRow");
				if (vecRow != null && vecRow.size() > 0) {
					int size = vecRow.size();
					for (int i = 0; i < vecRow.size(); i++) {
						vecCol = (ArrayList) vecRow.get(i);
			%>
			<tr class="datagrid">
				<td width="3%" align="center"><input type="radio"
					style="border: none" name="radiobutton" value="radiobutton"
					onClick="selectValues('<%=Helper.correctNull((String) vecCol.get(0))%>',
						'<%=Helper.correctNull((String) vecCol.get(1))%>','<%=Helper.correctNull((String) vecCol.get(2))%>',
						'<%=Helper.correctNull((String) vecCol.get(3))%>','<%=Helper.correctNull((String) vecCol.get(4))%>',
						'<%=Helper.correctNull((String) vecCol.get(6))%>','<%=Helper.correctNull((String) vecCol.get(7))%>',
						'<%=Helper.correctNull((String) vecCol.get(8))%>','<%=i%>','<%=size%>')">
				<input type="hidden" name="hidother"
					value="<%=Helper.correctNull((String) vecCol.get(5))%>">
				</td>
				<td width="12%">&nbsp;<%=Helper.correctNull((String) vecCol.get(1))%></td>
				<td width="15%" align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String) vecCol.get(8))))%></td>
				<td width="15%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(6))))%>&nbsp;&nbsp;<%=Helper.correctNull((String) vecCol.get(7))%></td>
				<td width="15%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(4))))%>&nbsp;&nbsp;<%=Helper.correctNull((String) vecCol.get(2))%></td>
				<td width="15%">&nbsp;<%=Helper.correctNull((String) vecCol.get(3))%></td>
				<td width="15%">&nbsp;<%=Helper.correctNull((String) vecCol.get(5))%></td>
			</tr>
			<%
				}
			%>
		</table>
		<%
			if (vecRow.size() > 6) {
		%>
		</div>
		<%
			}
		%> <%
 	} else {
 %>
		</td>
		</tr>
	<tr>
		<td align="center" colspan="8">No Data Found</td>
	</tr>
	<%
		}
	%>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="hid_strsno" value="" /> 
<!--	<input type="hidden" name="comapp_id" value="<%=Helper.correctNull((String) hshValues.get("comapp_id"))%>">-->
</form>
</body>
</html>
