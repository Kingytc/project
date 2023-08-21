<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	String stroptions = " ";
	String strappnonew = request.getParameter("appno");
	request.setAttribute("_cache_refresh", "true");
	String strFreeze=Helper.correctNull((String)request.getParameter("hidFreeze"));
	String prd_typecheck = Helper.correctNull((String) session.getAttribute("strProductType"));	
	if (objValues instanceof java.util.HashMap) 
	{
		hshValues = (java.util.HashMap) objValues;
	}
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	
	if (hshValues != null)
	{
		arrRow = (ArrayList) hshValues.get("arrRow");				
	}
	
	String strLoanpurpose = Helper.correctNull((String) hshValues.get("phpa_loan_purpose"));
	if(strLoanpurpose.equalsIgnoreCase(""))
	{
		strLoanpurpose = Helper.correctNull((String) hshValues.get("strProdPurpose"));
	}
	%>
<html>
<head>
<title>Lease Period</title>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2">
var varFlag = "<%=Helper.correctNull((String)hshValues.get("strMonthlyFlag"))%>";
function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}
function callonLoad()
{	
	disablefields(true);
	if(varFlag=="TRUE")
	{
		alert("Total Monthly Gross Rent amount is not equal to Monthly Gross Rent amount entered in the Loan product page.");
	}
}
function disablefields(val)
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
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}		
	}
}
function disableCommandButtons(valnew,valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdnew.disabled =valnew;
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmdclose.disabled=valclose;
}
function doNew()
{
	disablefields(false);
	disableCommandButtons(true,true,false,false,true,true);
	document.forms[0].hidAction.value ="insert";
	document.forms[0].txt_description.value="";
	document.forms[0].txt_frmdate.value="";
	document.forms[0].txt_todate.value="";
	document.forms[0].txt_monthlyincome.value="0.00";
}
function doEdit()
{
	disablefields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons(true,true,false,false,false,true);
}
function doSave()
{
	if(document.forms[0].txt_description.value=="")
	{
		ShowAlert(121,"Description");
		document.forms[0].txt_description.focus();
		return;
	}
	if(document.forms[0].txt_monthlyincome.value=="" || document.forms[0].txt_monthlyincome.value=="0.00")
	{
		ShowAlert(121,"Gross Rent");
		document.forms[0].txt_monthlyincome.focus();
		return;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="perapplicant";
	document.forms[0].hidBeanMethod.value="updateLeaseperiod";
	document.forms[0].hidBeanGetMethod.value="getLeaseperiod";
	document.forms[0].hidSourceUrl.value="/action/Per_leaseperiod.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function selValues(Sno,val1,val2,val3,val4)
{
	document.forms[0].hidSno.value=Sno;
	document.forms[0].txt_description.value=val1;
	document.forms[0].txt_frmdate.value=val2;
	document.forms[0].txt_todate.value=val3;
	document.forms[0].txt_monthlyincome.value=val4;
	document.forms[0].hidSelectedRent.value=val4;
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		disableCommandButtons(true,false,true,true,true,false);
	}
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].hidBeanGetMethod.value="getLeaseperiod";
		document.forms[0].action=appURL+"action/Per_leaseperiod.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";		
		document.forms[0].hidBeanMethod.value="updateLeaseperiod";
		document.forms[0].hidBeanGetMethod.value="getLeaseperiod";
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidSourceUrl.value="/action/Per_leaseperiod.jsp";			
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}

function checkGrossVal()
{
	var LoanGrossAmt    = parseFloat(document.forms[0].hidGrossRent.value);
	var TotalGrossRent  = parseFloat(document.forms[0].hidTotalRent.value);	
	var EnteredMonthAmt = parseFloat(document.forms[0].txt_monthlyincome.value);
	if(document.forms[0].hidAction.value=="update")
	{
	   var OldMonthAmt  = parseFloat(document.forms[0].hidSelectedRent.value);
	}
	else
	{
		var OldMonthAmt = 0.00;
	}		
	if(LoanGrossAmt<(TotalGrossRent-OldMonthAmt+EnteredMonthAmt))
	{
		alert("Total Gross month rent in greater than than the Gross month rent amount entered in the loan details page.");
		document.forms[0].txt_monthlyincome.value = "";
	}
}

</script>
</head>
<body onload="callonLoad()">
 <div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form class="normal">
  <table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
    <tr> 
      <td>
        <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="1" />
        </jsp:include>
      </td>
    </tr>
    <tr> 
      <td class="page_flow">Home -&gt; Retail -&gt; Application -&gt; Loan Particulars -&gt; Lease Period</td>
    </tr>
  </table>
  <lapschoice:application /> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td valign="bottom"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="left" class="outertable">
          <tr align="center"> 
            <td>
              <jsp:include page="../per/applicanttab.jsp" flush="true"> 
              <jsp:param name="linkid" value="9" />
              </jsp:include>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="5" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td align="center">
								<table width="80%" border="0" cellspacing="1" cellpadding="5" class="outertable">
									<tr align="center" class="dataheader">
									<td align="center" rowspan="2">Description <span class="mantatory">*</span></td>
									<td align="center" colspan="2">Lease Period</td>
									<td align="center" rowspan="2">Monthly Gross Rent <span class="mantatory">*</span></td>	
									</tr>
									<tr align="center" class="dataheader">
									<td align="center">From</td>
									<td align="center">To</td>
									</tr>
									<tr align="center" class="datagrid">
									<td><input type="text" name="txt_description" tabindex="1" maxlength="70" size="70" onKeyPress="allowAlphaNumericSpace()"></td>
									<td>
									<table><tr><td>
									<input type="text" name="txt_frmdate" tabindex="2" maxlength="10" size="15" onBlur="checkDate(this)" ></td>
									<td> 
									<a alt="Select date from calender" tabindex="3"
												href="javascript:callCalender('txt_frmdate')"><img
												src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
												border="0"></a></td>
												</tr></table>
									</td>
									<td>
									<table><tr><td>
									<input type="text" name="txt_todate" tabindex="4" maxlength="10" size="15" 
									onBlur="checkDate(this);checkmindate(this,document.forms[0].txt_frmdate.value)" ></td>
									<td>
									<a alt="Select date from calender" tabindex="5"
												href="javascript:callCalender('txt_todate');"><img
												src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
												border="0"></a>
												</td>
											</tr>
										</table>			
									</td>
									<td><input type="text" name="txt_monthlyincome" tabindex="6" maxlength="17" size="20"  onKeyPress="allowDecimals(this)" style="text-align:right"
											onBlur="roundtxt(this);checkGrossVal();"></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
			<tr><td>&nbsp;</td></tr>		
			<lapschoice:combuttonnew btnnames="New_Edit_Save_Delete_Cancel_Audit Trail"
								btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/><br>
			<tr><td align="center">
					<table width="80%" border="0" cellspacing="1" cellpadding="5" class="outertable">
									<tr align="center" class="dataheader">
									<td align="center" rowspan="2" width="5%">&nbsp;</td>
									<td align="center" rowspan="2" width="55%">Description</td>
									<td align="center" colspan="2" width="20%">Lease Period</td>
									<td align="center" rowspan="2" width="20%">Monthly Gross Rent</td>	
									</tr>
									<tr align="center" class="dataheader">
									<td align="center" width="10%">From</td>
									<td align="center" width="10%">To</td>
									</tr>
									<%									
									if(arrRow != null && arrRow.size()>0){
										for(int i=0;i<arrRow.size();i++)
										{
											arrCol=(ArrayList)arrRow.get(i);											
									%>
									<tr align="center" class="datagrid">
									<td align="left" width="5%" ><input type="radio" name="sno" style="border-style:none" onClick="selValues('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(1))%>'
									,'<%=Helper.correctNull((String)arrCol.get(2))%>','<%=Helper.correctNull((String)arrCol.get(3))%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))%>');"></td>
									<td align="left" width="55%"><%=Helper.correctNull((String)arrCol.get(1))%></td>
									<td align="center" width="10%"><%=Helper.correctNull((String)arrCol.get(2))%></td>
									<td align="center" width="10%"><%=Helper.correctNull((String)arrCol.get(3))%></td>
									<td align="right" width="20%"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))%></td>	
									</tr>
									<%}%>
									<tr class="datagrid">
										<td colspan="3">&nbsp;</td>
										<td align="right">TOTAL</td>
										<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblTotalMonthRent"))))%></td>
										</tr>
										<%}else{ %>
												<tr class="datagrid">
												<td width="5%">&nbsp;</td>
												<td width="55%">&nbsp;</td>
												<td width="10%">&nbsp;</td>
												<td width="10%">&nbsp;</td>
												<td width="20%">&nbsp;</td>
											</tr>
											<tr class="datagrid">
												<td width="5%">&nbsp;</td>
												<td width="55%" align="center">--No Records Found--</td>
												<td width="10%">&nbsp;</td>
												<td width="10%">&nbsp;</td>
												<td width="20%">&nbsp;</td>
											</tr>
											<tr class="datagrid">
												<td width="5%">&nbsp;</td>
												<td width="55%">&nbsp;</td>
												<td width="10%">&nbsp;</td>
												<td width="10%">&nbsp;</td>
												<td width="20%">&nbsp;</td>
											</tr>
										<%}%>
										
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
	<input type="hidden" name="hidSno" value="">
	<input type="hidden" name="hidGrossRent" value="<%=Helper.correctNull((String)hshValues.get("dblMonthlyRent"))%>">	
	<input type="hidden" name="hidTotalRent" value="<%=Helper.correctNull((String)hshValues.get("dblTotalMonthRent"))%>">
	<input type="hidden" name="hidSelectedRent" value="">
  </form>
</body>
</html>