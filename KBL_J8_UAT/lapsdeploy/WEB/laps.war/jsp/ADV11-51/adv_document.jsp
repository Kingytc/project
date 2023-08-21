<%@include file="../share/directives.jsp"%>
<%		java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		nf.setGroupingUsed(false);
			ArrayList arrayRow = new ArrayList();
			ArrayList arrayCol = new ArrayList();
			arrayRow =(ArrayList)hshValues.get("arrayRow");			
			%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function selectValues(val1,val2,val3,val4,val5,val6,i,size)
	{
	document.forms[0].rowno.value = val1;
	document.forms[0].txt_naturelimit.value = val3;
    document.forms[0].txt_name.value = val4 ;
	document.forms[0].txt_amount.value = val5;
	document.forms[0].txt_date.value = val6;
	if(size==1)
	{
		document.forms[0].area_remark.value=document.forms[0].hidother.value;		
	}
	else
	{
		document.forms[0].area_remark.value=document.forms[0].hidother[i].value;
	}
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
		disableCommandButtons("radioselect"); 
		}
	}	
	function callOnload()
	{
		disableFields(true);
	}

function doNew()
{
	disableFields(false);
	disableCommandButtons("edit");	
	document.forms[0].hidAction.value ="new";
	document.forms[0].hideditflag.value="Y";
   	document.forms[0].txt_naturelimit.focus();
}
function doSave()
{	
	if(document.forms[0].txt_naturelimit.value=="")
	{
		ShowAlert('121',"Nature of limit");
		document.forms[0].txt_naturelimit.focus();
	}
	else
	{
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidBeanMethod.value="updateADVDocument";
		document.forms[0].hidBeanGetMethod.value="getADVDocument";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidSourceUrl.value="/action/adv_document.jsp";
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
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=(!val);
		}	
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		} 
	}
	document.forms[0].txt_date.readOnly=true;
}
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
	}
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/agrpage.jsp";
		document.forms[0].submit();
	}
}
function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanGetMethod.value="getADVDocument";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].action=appURL+"action/adv_document.jsp";	
		document.forms[0].submit();
	}
}
function doEdit()
{	
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit"); 
	document.forms[0].hideditflag.value="Y";
	document.forms[0].txt_naturelimit.focus();
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		var varconfirm=ConfirmMsg('101');
		if(varconfirm)
		{
			document.forms[0].hidAction.value ="delete";
			document.forms[0].hidBeanMethod.value="updateADVDocument";
		    document.forms[0].hidBeanGetMethod.value="getADVDocument";
			document.forms[0].hidBeanId.value="ADV1151";
			document.forms[0].hidSourceUrl.value="/action/adv_document.jsp";
		    document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].method="post";	
			document.forms[0].submit();	
		}
	}
	else
	{
		
		ShowAlert(158);
	}
}
function callLink(page,bean,method)
{	
	 if (document.forms[0].cmdsave.disabled)
		{
			document.forms[0].hidSourceUrl.value=page;
			document.forms[0].hidBeanGetMethod.value=method;
			document.forms[0].hidBeanId.value=bean;
			document.forms[0].action=appURL+"action/"+page;
			document.forms[0].submit();
		}
	else
		{
			ShowAlert(103);
		}
}
function disableCommandButtons(val)
{
	if(val=="edit")
	{
		 document.forms[0].cmdnew.disabled =true;
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
    if(val=="radioselect")
	{	
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=false;
	}
    if(val=="load")
	{  
		disableFields(true);
		if(document.forms[0].appstatus.value=="Open/Pending")
    		document.forms[0].cmdnew.disabled =false;
    	else
    		document.forms[0].cmdnew.disabled =true;		
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}	
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callOnload()">
<form name="advdocument" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top"> <jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="19" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home-&gt; Tertiary-&gt; Proposal-&gt;ADV1151 -&gt;Documents</td>
	</tr>
</table>
<lapschoice:borrowertype /> <lapschoice:application /><br>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
<TR class="dataheader">
<TD ALIGN="CENTER"><B>DOCUMENTS</B>
</TD>
</TR>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td>
 
 					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
						<tr>
							<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td  width="50%"  align="center">
											<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
												<tr valign="bottom">
													<td valign="bottom"><!-- added-->
														<table   width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable linebor" align="center">
															  <tr class="dataheader">
																<td width="20%" rowspan="2">Nature of limit<span class="mantatory">*&nbsp;</span></td>
																<td width="60%" colspan="3" align="center">Documents Obtained</td>
																<td width="20%" rowspan="2" align="center">Remarks</td>
															  </tr>
															  <tr class="dataheader">
																<td width="20%" align="center">Name</td>
																<td width="20%" align="center">Amount </td>
																<td width="20%" align="center">Date</td>
															  </tr>
															  <tr class="datagrid">
																<td width="20%">
																<input type="text" name="txt_naturelimit" tabindex="1" size="16" maxlength="50" value="">
															  </td>
															  <td width="20%">
																<input type="text" name="txt_name" 	tabindex="2" size="16" maxlength="50" value="" onKeyPress="notAllowSplChar();notAllowSingleQuote();notAllowedDouble();">
															  </td>
																<td width="20%"><lapschoice:CurrencyTag name="txt_amount" size="16" maxlength="15" tabindex="3" value=''/></td>
																<td width="20%">
																	<table>
																		<tr>
																			<td><input type="text" name="txt_date"   size="16" value="" onBlur="checkDate(this);checkmaxdate(this,currentDate)"></td>
																			<td><a href="#" onClick="callCalender('txt_date')"
																				title="Click to view calender"><img
																				src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
																				border="0" tabindex="4"></a></td>
																		</tr>
																	</table>
																</td>
																<td width="20%"><textarea rows="6" name="area_remark" tabindex="5" cols="32" maxlength="1000" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"></textarea></td>
															  </tr>
															</table>
												</td>
  											</tr>
  										</table>
  									</td>
  								</tr >
  							</table>
  						</td>
  					</tr>
			</table>
<br>
 <lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
 <br> 	
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
		<tr>
		<td valign="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
				<tr class="dataheader">					
                  <td width="9%">&nbsp;</td>					
                  <td width="23%">Nature of limit</td>					
                  <td width="23%">Name</td>					
                  <td width="22%">Amount</td>					
                  <td width="23%" >Date</td>
				</tr>
				<% if(arrayRow!=null && arrayRow.size()>0)
				{
                          		int size= arrayRow.size();
                            		for(int i=0;i<arrayRow.size();i++)
                            		{
                            			arrayCol =(ArrayList)arrayRow.get(i);%>
				<tr class="datagrid">
					<td width="9%"> 
                      <input type="radio" name="radiobutton"
							value="radiobutton" style="border-style:none"
							onClick="selectValues('<%=Helper.correctNull((String)arrayCol.get(0))%>',
									      '<%=Helper.correctNull((String)arrayCol.get(1))%>',
									      '<%=Helper.correctNull((String)arrayCol.get(2))%>',
									      '<%=Helper.correctNull((String)arrayCol.get(3))%>',
										  '<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrayCol.get(4))))%>',
										  '<%=Helper.correctNull((String)arrayCol.get(5))%>','<%=i%>','<%=size%>')">
										  
						<input type="hidden" name="hidother" value="<%=Helper.correctNull((String)arrayCol.get(6))%>">				
					</td>
					<td width="23%"><%=Helper.correctNull((String)arrayCol.get(2))%>&nbsp;</td>
					<td width="23%"><%=Helper.correctNull((String)arrayCol.get(3))%>&nbsp;</td>
					<td width="22%"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrayCol.get(4))))%>&nbsp;</td>
					<td width="23%"><%=Helper.correctNull((String)arrayCol.get(5))%>&nbsp;</td>
				</tr>
				<%}}else{%>
					<tr class="datagrid">
						
                    <td width="9%">&nbsp;</td>
						
                    <td width="23%">&nbsp;</td>
						
                    <td width="23%">&nbsp;</td>
						
                    <td width="22%">&nbsp;</td>
						
                    <td width="23%">&nbsp;</td>
					</tr>
					<tr class="datagrid">
						
                    <td width="9%">&nbsp;</td>
						
                    <td width="23%">&nbsp;</td>
						
                    <td width="23%">&nbsp;</td>
						
                    <td width="22%">&nbsp;</td>
						
                    <td width="23%">&nbsp;</td>
					</tr>
					
				<%}%>
			</table>
			</td>
		</tr>
	</table>
  		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr> 
      <td width="20%" ><b>&nbsp; 
        <a href="javascript:callLink('adv_comments.jsp','ADV1151','getComments')"> 
        &lt;&lt; Previous </a>&nbsp;</b> </td>
      <td width="60%" align="center"><b> 
        <jsp:include page="../ADV11-51/adv_links.jsp" flush="true" /> 
        </b></td>
      <td width="20%">&nbsp; 
        <div align="right"><b>Pg.16/19&nbsp;
        <a href="javascript:callLink('adv_borrowerexp.jsp','ADV1151','getADVBorrowerExp')"> 
          Next &gt;&gt; </a></b></div>
      </td>
    </tr>
</table>
	<input type="hidden" name="rowno"> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
	<input type="hidden" name="pageval" value="FIA">
</form>
</body>
</html>
