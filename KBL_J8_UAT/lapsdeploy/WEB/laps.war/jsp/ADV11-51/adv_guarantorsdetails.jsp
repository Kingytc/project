<%@include file="../share/directives.jsp"%>
<%ArrayList arrRow=new ArrayList();
ArrayList arrCol=null;
%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var guarantar="<%=Helper.correctNull((String)hshValues.get("adv_guaranteeoffered"))%>";
var renewal="<%=Helper.correctNull((String)hshValues.get("ADV_GUARANTORSRENEWAL"))%>";
var varRecordflag = "<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
function doClose()
{	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/agrpage.jsp";
		document.forms[0].submit();
	}
}
function callCalender(name)
	{
		if(document.forms[0].cmdedit.disabled==true)
		{
		showCal(appUrl,name);
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
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}
	}
}	
function doSave()
	{
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidRecordflag.value = varRecordflag;
	    document.forms[0].hidBeanGetMethod.value="getGuranteedetails";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidBeanMethod.value="updateGuranteedetails";
		document.forms[0].hidSourceUrl.value="/action/adv_guarantorsdetails.jsp";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit();
	}
	
function doEdit()
{ 	
	disableFields(false);
    document.forms[0].hidAction.value ="insert";
    document.forms[0].hideditflag.value="Y";
	disableCommandButtons("edit");	
}

function doDelete()
{
	if(varRecordflag == "Y")
	{
		if(ConfirmMsg(101))
		{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"controllerservlet";		
		document.forms[0].hidBeanGetMethod.value="getGuranteedetails";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidBeanMethod.value="updateGuranteedetails";
		document.forms[0].hidSourceUrl.value="action/adv_guarantorsdetails.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
		}
	}
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanGetMethod.value="getGuranteedetails";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidBeanMethod.value="getGuranteedetails";
		document.forms[0].hidSourceUrl.value="action/adv_guarantorsdetails.jsp";	
	    document.forms[0].submit();	
	}	
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
function onLoading()
{
	disableFields(true);
	if(renewal!="")
		{
		document.forms[0].sel_renewal.value=renewal;
		}
		else
		{
		document.forms[0].sel_renewal.value="0";
		}
		renewalguarantor();
}
function callLink(page,bean,method)
{
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].submit();
}

function renewalguarantor()
{
		if(document.forms[0].sel_renewal.value=="1")
			{
			document.all.date.style.visibility="visible";
			document.all.date.style.position="relative";
			document.all.amount.style.visibility="visible";
			document.all.amount.style.position="relative";
			document.all.guarantor.style.visibility="visible";
			document.all.guarantor.style.position="relative";
			}
		else
			{
			document.all.date.style.visibility="hidden";
			document.all.date.style.position="absolute";
			document.all.amount.style.visibility="hidden";
			document.all.amount.style.position="absolute";
			document.all.guarantor.style.visibility="hidden";
			document.all.guarantor.style.position="absolute";
			document.forms[0].txt_guaranteedate.value="";
			document.forms[0].txt_amount.value="";
			document.forms[0].txt_guarantors.value="";
			}
}
</script>
</head>
<body onload="onLoading()">
	<form name="gurantors" method="post" class="normal">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="19" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Proposal -&gt; ADV1151 -&gt; Guarantors Details</td>
	</tr>
</table>
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/>
	<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
							<tr>
								<td align="center"><b>GUARANTORS DETAILS</b>
								</td>
							</tr>
						</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>				
      <td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td  width="50%" align="center">
											<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
												<tr>													
                        <td>                          
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                          <tr> 
                              <td colspan="2">							   
                                <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                                  <tr class="dataheader"> 
                                    <td width="39%"><B>Name of the Guarantors</B></td>
                                    <td width="38%"><b>Address</b></td>
                                    <td width="23%"><b>Total Means</b></td>
                                  </tr>
								  <%arrRow=(ArrayList)hshValues.get("arrRowgua");
									if(arrRow!=null && arrRow.size()>0)
									{%>
								 <%for(int i=0;i<arrRow.size();i++)
								{%>
									
									<%arrCol=(ArrayList)arrRow.get(i);
									if(arrCol!=null && arrCol.size()>0)
									{%>
                                  <tr class="datagrid"> 
                                    <td width="39%"><%=Helper.correctNull((String)arrCol.get(0))%></td>
                                    <td width="38%"><%=Helper.correctNull((String)arrCol.get(2))%><br>
                                    <%if(!Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("")){ %>
                                    <%=Helper.correctNull((String)arrCol.get(3))%><br>
                                    <%}%><%if(!Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("")){ %>
                                    <%=Helper.correctNull((String)arrCol.get(4))%><br><%} %>
                                    <%=Helper.correctNull((String)arrCol.get(5))%><br><%=Helper.correctNull((String)arrCol.get(6))%><br>
                                    <%=Helper.correctNull((String)arrCol.get(7))%><br><%=Helper.correctNull((String)arrCol.get(8))%>
                                    </td>
                                    <td width="23%"><%=ApplicationParams.getCurrency()%><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))%></td>
                                  </tr>
                                  <tr class="datagrid"><td colspan="3">&nbsp;</td></tr>
								  <%}}}%>
                                </table>
                              </td>
                            </tr>
							<tr class="datagrid"> 
                              <td colspan="2">&nbsp;</td>
                            </tr>
                            <tr class="datagrid"> 
                              <td >If renewal</td>
							   <td> 
                                <select name="sel_renewal" tabindex="3" onChange="renewalguarantor()">
                                  <option value="0" selected="selected">select</option>
                                  <option value="1">Yes</option>
                                  <option value="2">No</option>
                                </select>
                              </td>
                            </tr>
							<tr class="datagrid"> 
                              <td colspan="2">&nbsp;</td>
                            </tr>
                            <tr id="date" class="datagrid"> 
                              <td>Date of letter of guarantee</td>
                              <td> 
                                <input type="text" name="txt_guaranteedate" maxlength="12" size="16" value='<%=Helper.correctNull((String) hshValues.get("adv_guaranteedate"))%>' onBlur="checkDate(this);checkmaxdate(this,currentDate)">
								<a alt="Select date from calender" href="#"
		onClick="callCalender('txt_guaranteedate')"
		onMouseOver="window.status='Date Picker';return true;"
		onMouseOut="window.status='';return true;"><img
		src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
		alt="Select date from calender" tabindex="4"></a>
                              </td>
                            </tr>
                            <tr id="amount" class="datagrid"> 
                              <td>Amount</td>
                              <td> <%=ApplicationParams.getCurrency()%>
                                <lapschoice:CurrencyTag  name="txt_amount" maxlength="15" size="16" tabindex="4" value='<%=Helper.correctNull((String) hshValues.get("adv_amount"))%>'/>
                              </td>
                            </tr>
                            <tr id="guarantor" class="datagrid"> 
                              <td height="109">Name of the guarantor(s)</td>
                              <td height="109"> 
                                <textarea name="txt_guarantors" cols="50" rows="5" tabindex="5" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" maxlength="4000"><%=Helper.correctNull((String) hshValues.get("adv_guarantors"))%></textarea>
                              </td>
                            </tr>
                            <tr class="datagrid"> 
                              <td>For sanctioning office use</td>
                              <td> 
                                <textarea name="txt_sanction" cols="50" rows="5" tabindex="6" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" maxlength="4000"><%=Helper.correctNull((String) hshValues.get("adv_sanction"))%></textarea>
                              </td>
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
<br/>
	<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
	<br> 
	<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr> 
      <td width="20%"><b>&nbsp; 
        <a href="javascript:callLink('adv_legalheirs.jsp','ADV1151','getLegalheirs')" > 
        &lt;&lt; Previous </a>&nbsp;</b> </td>
      <td width="60%" align="center"><b> 
        <jsp:include page="../ADV11-51/adv_links.jsp" flush="true" />
        </b></td>
      <td width="20%">&nbsp; 
        <div align="right"><b>Pg.6/19&nbsp;<a href="javascript:callLink('adv_otherbank.jsp','ADV1151','getotherbank')" > 
          Next &gt;&gt; </a></b></div>
      </td>
    </tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="pageval" value="FIA">	
</form>
</body>
</html>
