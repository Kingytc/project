<%@include file="../share/directives.jsp"%>
<html>
<head>
<%
java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);
String com_appid=Helper.correctNull((String)request.getParameter("com_appid"));
if(com_appid=="")
{
	com_appid=Helper.correctNull((String)hshValues.get("strid"));
}
String RecordFlag = Helper.correctNull((String)hshValues.get("recordflag"));
if(strCategoryType.equals("CORPORATE"))
{
	strCategoryType ="CORP";
}%>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css" />
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="javascript">
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag = "<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
function doClose()
{
	if(ConfirmMsg(100))
	{
	document.forms[0].action=appUrl+"action/agrpage.jsp";
	document.forms[0].submit();
	}
}

function doSave()
{
	if(document.forms[0].sel_rate.value=='S')
	{
		ShowAlert('111','IS CREDIT RATING APPLICABLE ?');
		return;
	}
	if(document.forms[0].sel_rate.value=='1')
	{
		
		if(document.forms[0].rating.value=="")
		{
			ShowAlert('121', 'score');
			document.forms[0].rating.focus();
			return;	
		}
		if(document.forms[0].rating_grade.value=="")
		{
			ShowAlert('121', 'Rating Grade');
			document.forms[0].rating_grade.focus();
			return;	
		}		
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidRecordflag.value = varRecordFlag;
	document.forms[0].hidSourceUrl.value="/action/adv_meanscapital.jsp";
	document.forms[0].hidBeanId.value="ADV1151";
	document.forms[0].hidBeanMethod.value="updateMeansCapital";
	document.forms[0].hidBeanGetMethod.value="getMeansCapital";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
} 

function doEdit()
{
	disableFields(false);
	document.forms[0].hidAction.value="insert";
	disableCommandButtons("edit");	
}
function onloading()
{
    var selvalue='<%=Helper.correctNull((String)hshValues.get("rate_check"))%>';
    if(selvalue!="")
    {   
	document.forms[0].sel_rate.value=selvalue;
    }
    else
    {
       
    	document.forms[0].sel_rate.value='S';   
    }
	enablescore();
	disableFields(true);
}
function disableCommandButtons(val)
{	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	
		 disableFields(false);
	}
}
  function enablescore()
   {
	if(document.forms[0].sel_rate.value=='1')
	{		
		document.all.score.style.visibility="visible";
		document.all.score.style.position="relative";				
	} 
	else
	{		
		document.all.score.style.visibility="hidden";
		document.all.score.style.position="absolute";
		document.forms[0].rating.value="";
		document.forms[0].rating_grade.value="";			
	} 
   }
function doDelete()
{
	if(varRecordFlag == "Y"){
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidSourceUrl.value="/action/adv_meanscapital.jsp";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidBeanMethod.value="updateMeansCapital";
		document.forms[0].hidBeanGetMethod.value="getMeansCapital";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}
	}
}
function doCancel()
{
	document.forms[0].hidSourceUrl.value="/action/adv_meanscapital.jsp";
	document.forms[0].hidBeanId.value="ADV1151";
	document.forms[0].hidBeanMethod.value="getMeansCapital";
	document.forms[0].hidBeanGetMethod.value="getMeansCapital";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}		 
	}
}
function callLink(page,bean,method)
{
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].submit();
}
</script>
</head>
<body onload="onloading()">
<form name="frmpri" method = "post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true"> 
        <jsp:param name="pageid" value="18" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
     <tr> 
  <td class="page_flow">Home -&gt; Tertiary -&gt; Application -&gt; Credit Rating Details</td>
 </tr>
  </table>
  <span style="display:none">
  <lapschoice:borrowertype /></span> <lapschoice:application/>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
			  <td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
					<tr>
						<td width="100%" align="center">
				   			 <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" valign="bottom">
									<tr valign="bottom">									
                        <td valign="bottom"> 
                          <table border="0" width="100%" align="center" class="outertable">						  
						  <tr>
                              <td >
                                <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
                                  <tr>
                                    <td width="29%"><b>IS CREDIT RATING 
                                      APPLICABLE ? </b><span class="mantatory">*</span></td>
                                    <td width="71%"> 
                                      <select name="sel_rate" onChange="enablescore()">
									<option value="S" selected="selected">&lt;---Select---&gt;</option>
									<option value="1">Yes</option>
									<option value="2">No</option>
									 </select>
									</td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
									<tr>
										<td width="50%">
										<br>
										<table border="0" width="70%" cellspacing="0" cellpadding="5" class="outertable border1" align="center" id="score">
											<tr>											
                                    <td width="21%">&nbsp;Score<span class="mantatory">*</span></td>											
                                    <td width="21%">&nbsp; 
                                      <input type="text" name="rating" size="13" maxlength="10"
					value="<%=Helper.correctNull((String)hshValues.get("rating"))%>"></td>
											
                                    <td width="16%">&nbsp;Rating Grade<span class="mantatory">*</span></td>											
                                    <td width="42%">&nbsp;
<input type="text" name="rating_grade" size="13" maxlength="10"
					value="<%=Helper.correctNull((String)hshValues.get("rating_grade"))%>"></td>
											</tr>
										</table>	</td>	</tr>						
										<b>MEANS :INDIVIDUAL/FIRM/DIRECTORS<span
											style="font-family:APS-C-DV-Prakash;mso-ansi-language:EN-US;
												  layout-grid-mode:line">
										 (<%=ApplicationParams.getCurrency()%> in Lacs)</span> </b>	<tr>
										 <td>									 
										<table border="0" width="70%" cellspacing="0" cellpadding="5" class="outertable linebor" align="center">
											<tr class="dataheader">
												<td width="40%" align="center">NAME</td>
												<td width="20%" align="center">AMOUNT</td>
												<td width="20%" align="center">SOURCE</td>
												<td width="20%" align="center">DATE</td>
											</tr>
											<%ArrayList arrCol = new ArrayList();
			ArrayList arrRow = new ArrayList();

			arrRow = (ArrayList) hshValues.get("arrRow5");
			
			if (arrRow != null && arrRow.size() > 0) {
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = (ArrayList) arrRow.get(i);	
						if(arrCol!=null)
						{%>					<tr class="datagrid">
												<td width="40%" align="left">&nbsp;<%=Helper.correctNull((String) arrCol.get(0))%></td>
												<td width="20%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))%></td>
												<%if(!(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("0.00")) && !(Helper.correctNull((String) arrCol.get(1)).equalsIgnoreCase(""))) {%>
                                                <td width="20%" align="center">Credit Report</td>
                                                <%}else{%>
                                                <td width="20%" align="center">&nbsp;</td>
                                                <%} %>
												<td width="20%" align="center">&nbsp;<%=Helper.correctNull((String) arrCol.get(1))%></td>
											</tr>
											<%}}}%>
										</table></td></tr>
										<p><b>CAPITAL : COMPANY <span
											style="font-family:APS-C-DV-Prakash;mso-ansi-language:EN-US;
												  layout-grid-mode:line">
									 (<%=ApplicationParams.getCurrency()%> in Lacs)</span></b></p><tr><td>
										<table border="0" width="100%" cellspacing="0" cellpadding="5" class="outertable linebor">
											<tr class="dataheader" align="center">
												<td width="25%">Authorised</td>
												<td width="27%">Subscribed</td>
												<td width="23%">Paidup</td>
												<td width="20%">Reserve</td>
											</tr>
											<tr class="datagrid" align="right">
												<td width="25%">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues
									.get("PERAPP_AUTHORISED"))))%></td>
												<td width="27%">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues
							.get("PERAPP_SUBSCRIBED"))))%></td>
												<td width="23%">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues
							.get("PERAPP_PAIDUP"))))%></td>
												<td width="20%">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues
							.get("PERAPP_RESERVE"))))%></td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td width="25%"><small><b>FOR SANCTIONING OFFICE USE</b></small><br>
										<textarea rows="5" name="txt_sanctionuse" cols="120" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("advcap_sanctioncomments"))%></textarea></td>
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
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
