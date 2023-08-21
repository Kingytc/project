<%@include file="../share/directives.jsp"%>
<%	String bowpayment=Helper.correctNull((String)hshValues.get("adv_bowpayment"));
	String sellocal=Helper.correctNull((String)hshValues.get("adv_local"));
	String selcommit=Helper.correctNull((String)hshValues.get("adv_commit"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<SCRIPT LANGUAGE="JavaScript">
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var bowpayment="<%=bowpayment%>";
var sellocal="<%=sellocal%>";
var selcommit="<%=selcommit%>";

function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
}
function disableFields(one)
{	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	
		if(document.forms[0].elements[i].type=="textarea")
		{
		  document.forms[0].elements[i].readOnly=one;
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=one;
		}
	} 	
}
function callload() 
{
    document.forms[0].sel_bowpayment.value=bowpayment;
    document.forms[0].sel_local.value=sellocal;
    document.forms[0].sel_commit.value=selcommit;    
    disableFields(true);	
	changeDays();
}
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appUrl+"action/agrpage.jsp";
		document.forms[0].submit();
	}
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if( ConfirmMsg(101))
		{
			document.forms[0].hidAction.value ="delete";
			document.forms[0].action=appUrl+"action/controllerservlet";	
			document.forms[0].hidBeanMethod.value="updatecommentsonstatus";
			document.forms[0].hidBeanGetMethod.value="getcommentsonstatus";
			document.forms[0].hidBeanId.value="ADV1151";
			document.forms[0].hidSourceUrl.value="/action/adv_commentsonstatus.jsp";	
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
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].submit();
}
function doSave()
{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidRecordflag.value = varRecordFlag;
	document.forms[0].hidBeanId.value="ADV1151";		
	document.forms[0].hidSourceUrl.value="/action/adv_commentsonstatus.jsp";
	document.forms[0].hidBeanMethod.value="updatecommentsonstatus";
	document.forms[0].hidBeanGetMethod.value="getcommentsonstatus";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();	
}
function doEdit()
{
 	disableFields(false);
	document.forms[0].hidAction.value ="insert"; 
	document.forms[0].hideditflag.value="Y";
	enableButtons(true, false, false, false, true);
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="cancel"; 
		document.forms[0].hidSourceUrl.value="/action/adv_commentsonstatus.jsp";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidBeanMethod.value="updatecommentsonstatus";
		document.forms[0].hidBeanGetMethod.value="getcommentsonstatus";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 	
	}
}
function changeDays()
{	
	if(document.forms[0].sel_local.value=="2")
	{
		document.all.l1.style.visibility="visible";
		document.all.l1.style.position="relative";
		document.all.l2.style.visibility="visible";
		document.all.l2.style.position="relative";
	}
	else
	{	
		document.all.l1.style.visibility="hidden";
		document.all.l2.style.visibility="hidden";
		document.all.l1.style.position="absolute";
		document.all.l2.style.position="absolute";
		document.forms[0].status_days.value="";
	}
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callload()">
<form name="finForm" action="" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
	<tr>
		<td> <jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="19" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home-&gt;Tertiary-&gt; Proposal-&gt;ADV1151 -&gt;Comments on Status</td>
	</tr>
</table>
<lapschoice:borrowertype /> <lapschoice:application /><br>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
     <tr class="dataheader"> 
			<td align="center"><b>Comments on Status Report</b></td>
	</tr>
	<tr>
		<td valign="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable" align="center">
            	<tr> 
                    <td width="50%">
                    	<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable linebor" align="center">
                            <tr class="datagrid"> 
                            	<td width="25%">(I) Borrower's Payments</td>
                              	<td width="25%"> 
                                	<select name="sel_bowpayment" tabindex="1">
                                  		<option value="" selected="selected">--Select--</option>
                                  		<option value="1">Normal</option>
                                  		<option value="2">Prompt</option>
                                  		<option value="3">Tardy</option>
                                	</select>
                              	</td>
                              	<td width="25%">Local Practise</td>
                              	<td width="25%"> 
                                	<select name="sel_local" tabindex="2" onChange="changeDays()">
                                  		<option value="" selected="selected">--Select--</option>
                                  		<option value="1">At Sight</option>
                                  		<option value="2">After</option>
                                	</select>
                              	</td>
                            </tr>
                            <tr class="datagrid"> 
                              <td width="25%">Whether meeting the commitment</td>
                              <td width="25%"> 
                                <select name="sel_commit" tabindex="3">
                                  <option value="" selected="selected">--Select--</option>
                                  <option value="1">Yes</option>
                                  <option value="2">No</option>
                                </select>
                              </td>
                              
                  <td id="l1">No of days</td>
                              <td id="l2">
                    <input type="text" name="status_days" 
                                	size="16" tabindex="5" 
                                	maxlength="5" onKeyPress="allowNumber(this)" value="<%=Helper.correctNull((String)hshValues.get("adv_status_days"))%>">
                 </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr class="datagrid"> 
                        <td width="100%"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="2" align="center" class="outertable linebor">
                            <tr class="datagrid"> 
                              <td width="25%">(II) Extent of Credit available from Suppliers </td>
                              <td width="25%"> 
                                <input type="text" name="txt_suppliers" size="16" tabindex="5" 
                                	maxlength="5" onKeyPress="allowNumber(document.forms[0].txt_suppliers)"value="<%=Helper.correctNull((String)hshValues.get("adv_suppliers")) %>">
                    			Days
                    		</td>
                            <td width="25%"> Extent of Credit to customer</td>
                              <td width="25%">
                                <input type="text" name="txt_customer" size="16" tabindex="6" maxlength="5"onKeyPress="allowNumber(document.forms[0].txt_customer)" value="<%=Helper.correctNull((String)hshValues.get("adv_customer")) %>">Days </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable linebor" align="center">
								<tr class="datagrid">
									<td>(III) Extent of Market borrowings</td>
									<td><%=ApplicationParams.getCurrency()%>
										<lapschoice:CurrencyTag name="txt_marketborrow" size="16" tabindex="1" 
										maxlength="12" value='<%=Helper.correctNull((String)hshValues.get("extent")) %>'/>
									</td>
								</tr>
								<tr class="datagrid">
									<td>Nature of Market Borrowings</td>
									<td>
										<textarea name="area_nature" cols="50" rows="5" tabindex="2" 
										onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("nature")) %></textarea>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable linebor" align="center">
								<tr class="datagrid">
									<td><b>Comments:</b></td>
									<td>
										<textarea name="area_sanction" cols="50" rows="5" tabindex="3" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("sanction")) %></textarea>
									</td>
								</tr>
							</table>
   						</td>
  					</tr>
				</table>
			</td>
		</tr>
	</table><br>
	<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
	<br>
	<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
		<tr> 
			<td width="20%" align="left"><b>&nbsp; 
        		<a href="javascript:callLink('adv_borrowingpower.jsp','ADV1151','getadvBorrowingPower')"> 
        		&lt;&lt; Previous </a></b></td>
      		<td width="60%" align="center"><b> 
        		<jsp:include page="../ADV11-51/adv_links.jsp" flush="true"> </jsp:include>
        		</b></td>
      		<td width="20%">&nbsp; 
        		<div align="right"><b>Pg.2/19&nbsp;<a href="javascript:callLink('adv_generalcomments.jsp','ADV1151','getGeneralComments')"> 
          		Next &gt;&gt; </a></b></div>
      		</td>
    	</tr>
	</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidsno" >
</form>
</body>
</html>


