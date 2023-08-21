<%@include file="../share/directives.jsp"%>
<%
	
	  ArrayList arrRow = (ArrayList)hshValues.get("arrRow");
	  int paramSize=0;
	  if(arrRow != null)
	  {
		  paramSize= arrRow.size();
	  }
%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>


<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var paramSize="<%=paramSize%>";
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	
	}
	
	if(val=="edit")
	{	 
		
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	if(val=="rowcheck")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdsave.disabled=true;
		 document.forms[0].cmdcancel.disabled=true;		 
		 document.forms[0].cmdclose.disabled=false;	 
		 disableFields(false);
	}
	if(val=="rowselect")
	{	
	 
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	
	}
	
	
}
function onLoading()
{
  	     if(paramSize!=0)
  		 {
   			disableCommandButtons("load");
   		 }
   		 else{
   		   disableCommandButtons("rowcheck");
   		 }	
   		
}
function doEdit()
{
     document.forms[0].hidAction.value="update";
	 disableCommandButtons("edit");
	 document.forms[0].txt_facname.readOnly=true;
	 document.forms[0].txt_existlimit.readOnly=true;
	 document.forms[0].txt_oslimit.readOnly=true;
	 document.forms[0].txt_overdue.readOnly=true;
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
		 
	}

}
function doSave()
{
	    document.forms[0].hidBeanId.value="reviewtermloantwo";
	    document.forms[0].hidBeanMethod.value="updateTermLoanReviewFacilities";
		document.forms[0].hidBeanGetMethod.value="getTermLoanReviewFacilities";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/tlr_facilitydetails.jsp";
		document.forms[0].submit();
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="tlr_facilitydetails.jsp";
		document.forms[0].hidBeanId.value="reviewtermloantwo";
		document.forms[0].hidBeanGetMethod.value="getTermLoanReviewFacilities";
		document.forms[0].action=appURL +"action/tlr_facilitydetails.jsp";
	    document.forms[0].submit();	
	}	

}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/mon_borrowersearch.jsp?hidmontype=MONITREVIEW";
		document.forms[0].submit();
	}
}
function doDelete()
{
	   if(ConfirmMsg(101))
		{	
			document.forms[0].hidAction.value ="delete";
			document.forms[0].action=appURL+"action/ControllerServlet";		
			document.forms[0].hidBeanMethod.value="updateTermLoanReviewFacilities";
			document.forms[0].hidBeanGetMethod.value="getTermLoanReviewFacilities";
			document.forms[0].hidBeanId.value="reviewtermloantwo";
			document.forms[0].hidSourceUrl.value="action/tlr_facilitydetails.jsp";	
			document.forms[0].method="post";			
			document.forms[0].submit();	
		}
}
function callOtherLink(page,bean,method)
{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	
}
function selectValues(facid,facname,existlimit,proposedlimit,oslimit,overduelimit,purpose,intrecomm,intremarks)
{
    document.forms[0].hidfacid.value=facid;
	document.forms[0].txt_facname.value=facname;
	document.forms[0].txt_existlimit.value=existlimit;
	document.forms[0].txt_proposedlimit.value=proposedlimit;
	document.forms[0].txt_oslimit.value=oslimit;
	document.forms[0].txt_overdue.value=overduelimit;
	document.forms[0].txt_purpose.value=purpose;
	document.forms[0].txt_intrecomm.value=intrecomm;
	document.forms[0].txt_intRemarks.value=intremarks;
	if(document.forms[0].btnenable.value=="Y")
	{
		disableCommandButtons("rowselect");
	}
}
</script>
</head>
<body onload="onLoading()">
<form name="safaeri3" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td><lapschoice:tlrtag pageid="2"
			reviewof='<%=Helper.correctNull((String)request.getParameter("reviewOf"))%>' valuesin='<%=Helper.correctNull((String)request.getParameter("valuesin"))%>'/>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>

		<td valign="top" colspan="5" class="page_flow">Home -&gt; Term Loan - Review -&gt; Facilities</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
			<tr>
				<td><lapschoice:MonitorReview /></td>
			</tr>
</table>
<br><br>
<table width="80%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable border1">
<tr>
	<td valign="top" align="center">
<table width="98%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
	<tr>
		<td width="17%" nowrap="nowrap">Nature of
		facilities</td>
		<td width="33%" nowrap="nowrap" colspan="3"><input type="text"
			name="txt_facname" size="35"
			style="text-align:left;border-style=groove" onKeyPress="formattext()"
			class="interfacefields"> <input type="hidden" name="hidfacid"
			value=""></td>

	</tr>
	<tr>
		<td width="17%" nowrap="nowrap">Existing
		Limit</td>
		<td width="33%" nowrap="nowrap"><input type="text" name="txt_existlimit"
			style="text-align:right" onKeyPress="allowNumber(this)"
			maxlength="15" class="interfacefields" value=""></td>
		<td width="19%" nowrap="nowrap">Proposed
		Limit</td>
		<td width="31%" nowrap="nowrap"><input type="text" name="txt_proposedlimit"
			onKeyPress="allowNumber(this)" style="text-align:right"
			maxlength="15" size="24" value=""></td>
	</tr>
	<tr>
		<td width="17%" nowrap="nowrap">O/s as on
		</td>
		<td width="33%" nowrap="nowrap"><input type="text" name="txt_oslimit"
			style="text-align:right" onKeyPress="allowNumber(this)"
			maxlength="15" class="interfacefields" value=""></td>
		<td width="19%" nowrap="nowrap">Overdue, if
		any</td>
		<td width="31%" nowrap="nowrap"><input type="text" name="txt_overdue"
			style="text-align:right" onKeyPress="allowNumber(this)"
			maxlength="15" class="interfacefields" value=""></td>
	</tr>
	<tr>
		<td width="17%" nowrap="nowrap">Purpose of
		Loan</td>
		<td width="33%" nowrap="nowrap"><input type="text" name="txt_purpose" size="24"
			maxlength="100" value=""></td>
		<td width="19%" nowrap="nowrap">Interest
		Recommended</td>
		<td width="31%" nowrap="nowrap"><input type="text" name="txt_intrecomm"
			size="24" maxlength="100" value=""></td>
	</tr>
	<tr>
		<td width="17%" nowrap="nowrap">Interest
		Remarks</td>
		<td width="33%" nowrap="nowrap" colspan="3"><textarea name="txt_intRemarks"
			onKeyUp="textlimit(this,3999)" onKeyPress="textlimit(this,3999)"
			rows="5" cols="80" wrap="virtual">&nbsp;</textarea></td>

	</tr>
</table>
	</td>
  </tr>
 </table><br>	
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br>
<table width="99%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable linebor">
	<tr align="center"  class="dataheader">
		<td width="3%">&nbsp;</td>
		<td width="25%"><b>Nature of facilities</b></td>
		<td width="12%"><b>Existing Limit</b></td>
		<td width="12%"><b>Proposed Limit</b></td>
		<td width="12%"><b>O/s as on</b></td>
		<td width="12%"><b>Overdue,if any</b></td>
		<td width="25%"><b>Purpose of Loan</b></td>
	</tr>
	<% 
  
    if(arrRow != null && arrRow.size()>0){
   
    	for(int i=0;i<arrRow.size();i++){
    		ArrayList arrCol = (ArrayList)arrRow.get(i);
    		if(arrCol != null){
    %>
	<tr class="datagrid">
		<td><input type="radio" style="border:none" name="opt_radio" value=""
			onClick="selectValues('<%=Helper.correctNull((String)arrCol.get(0))%>',
								 '<%= Helper.correctNull((String)arrCol.get(1))%>',
								 '<%= Helper.correctNull((String)arrCol.get(3))%>',
								 '<%= Helper.correctNull((String)arrCol.get(7))%>',
								 '<%= Helper.correctNull((String)arrCol.get(4))%>',
								 '<%= Helper.correctNull((String)arrCol.get(5))%>',
								 '<%= Helper.correctNull((String)arrCol.get(2))%>',
								 '<%= Helper.correctNull((String)arrCol.get(8))%>',
								 '<%= Helper.replaceForJavaScriptString((String)arrCol.get(9))%>')">
		</td>
		<td><%=Helper.correctNull((String)arrCol.get(1))%></td>
		<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))%>
		</td>
		<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7))))%></td>
		<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))%>
		</td>
		<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))%>
		</td>
		<td><%=Helper.correctNull((String)arrCol.get(2))%></td>
	</tr>
	<%}}}else{ %>
	<tr class="datagrid">
		<td colspan="7" align="center">No Data</td>
	</tr>
	<%} %>
</table><br>
<input type="hidden" name="reviewOf" value="<%=request.getParameter("reviewOf")%>">
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>

