<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
 <%
 java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
 nf.setMaximumFractionDigits(2);
 nf.setMinimumFractionDigits(2);
 nf.setGroupingUsed(false);
if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			ArrayList arrCol = new ArrayList();
			ArrayList arrRow = new ArrayList();

String strmsod=Helper.correctNull((String)request.getParameter("mon_msod"));
if(!strmsod.equalsIgnoreCase(""))
{
	strmsod=Helper.correctNull((String)hshValues.get("mon_msod"));
}			
String strstock=Helper.correctNull((String)request.getParameter("mon_stock"));
if(!strstock.equalsIgnoreCase(""))
{
	strstock=Helper.correctNull((String)hshValues.get("mon_stock"));
}
String strbkdebts=Helper.correctNull((String)request.getParameter("mon_bkdebts"));
if(!strbkdebts.equalsIgnoreCase(""))
{
	strbkdebts=Helper.correctNull((String)hshValues.get("mon_bkdebts"));
}
String strqpr=Helper.correctNull((String)request.getParameter("mon_qpr"));
if(!strqpr.equalsIgnoreCase(""))
{
	strqpr=Helper.correctNull((String)hshValues.get("mon_qpr"));
}		
%>
<html>
<head>
<title>Document msod</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var path   ="<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";

function placevalues()
{
	disableCommandButtons("load");
}

function doNew()
	{
	disableFields(false);
	disableCommandButtons("edit");
	document.forms[0].hidAction.value ="insert";
	
	}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");	
}

function doSave()
{
	
	document.forms[0].hidBeanId.value="mmrcommon";
	document.forms[0].hidSourceUrl.value="/action/mon_msod2.jsp";
	document.forms[0].hidBeanMethod.value="updatemonmsodBorrowing";
	document.forms[0].hidBeanGetMethod.value="getmonmsodBorrowing";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getmonmsodBorrowing";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].action=appURL+"action/mon_msod2.jsp";	
		document.forms[0].submit();
	}	
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value="delete";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="mmrcommon";
	document.forms[0].hidSourceUrl.value="/action/mon_msod2.jsp";
	document.forms[0].hidBeanMethod.value="updatemonmsodBorrowing";
	document.forms[0].hidBeanGetMethod.value="getmonmsodBorrowing";	
	document.forms[0].submit();
	}
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}

function selectValues(val1,val2,val3,val4,val5,val6)
{
   	document.forms[0].hidsno.value =val1;
	document.forms[0].sel_sourcebank.value =val2;
	document.forms[0].txt_nature.value=val3;
	document.forms[0].txt_limit.value=val4;
	document.forms[0].txt_Balance.value=val5;
	document.forms[0].txtmon_balancedate.value=val6;
	if(document.forms[0].statusflag.value=="O" && document.forms[0].readFlag.value.toUpperCase()=="W")
	{
	disableCommandButtons("radioselect");
	}
}

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdnew.disabled =false;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}
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
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=!val;
		}	 
	}
}

function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false){
	
	 showCal(appURL,fname);
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
function call_page(url,method)
{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].method="post";

	if(url=="mon_stockstatement.jsp")
	{
		document.forms[0].hidBeanId.value="mmrcommon";
	}
	else if(url=="mon_workingcapitalfunds.jsp")
	{
		document.forms[0].hidBeanId.value="mmrcommon";
	}
	else if(url=="mon_accountwisedetails.jsp")
	{
		document.forms[0].hidBeanId.value="mmrcommon";
	}
	
	else
	{
		document.forms[0].hidBeanId.value="mmrcommon";
	}
	document.forms[0].action=appURL+"action/"+url;
	document.forms[0].submit();
	
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>

<body onload="placevalues()">
<form name="frmstock" method="post" class="normal">

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapschoice:monthlymonitortag pageid="5"/>
					</td>
				</tr>
				<tr>
					<td class="Page_Flow">Home -&gt; Monitoring-&gt; 
  Monthly Monitoring -&gt;Accountwise Details -&gt;MSOD -&gt;Msod Borrowings</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
						<tr>
							<td>
								<lapschoice:MonthlyMonitor />
							</td>
						</tr>
					</table>
				</td>
			</tr>
	</table>  
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
    <tr> 
      <td valign="bottom"> 
        <table width="60%" border="0" cellspacing="3" cellpadding="3" align="left" class="outertable">
          <tr> 
            <td width="20%"  align="center" class="sub_tab_inactive" id="prin" ><b><a href="javascript:call_page('mon_accountwisedetails.jsp','getAccountwise')" >Account-Wise Details</a></b> </td>
            <%if(Helper.correctNull((String)hshValues.get("mon_msod")).equalsIgnoreCase("y"))
		 				 {%>
            <td width="20%"  align="center" class="sub_tab_active" id="prin"><b>MSOD
              </b></td>
                <%} 
              if( Helper.correctNull((String)hshValues.get("mon_qpr")).equalsIgnoreCase("y")){%>
            <td width="20%"  align="center"  class="sub_tab_inactive" id="prin"><b><a href="javascript:call_page('mon_qprperformance.jsp','getQprPerformance')" >QPR
              </a></b></td>
              <%}
		  %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
						<lapschoice:MonMSODTag msod='<%=strmsod%>' stock='<%=strstock%>' bookdebts='<%=strbkdebts%>' pageid="2"/>
						<lapschoice:Monitor strSource="MMR"/>
<table border="0" width="86%" height="164" align="center" class="outertable border1">
  <tr> 
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr class="dataHeader"> 
    <td width="5%"><strong>E)</strong></td>
    <td width="95%" colspan="4"><strong>SHORT TERM BORROWING FROM BANKS/ OTHER 
      SOURCES &nbsp;&nbsp; (Incl. Bills Discounted / Negotiated)   (Rs. in lacs).</strong></td>
  </tr>
  <tr class="dataHeader"> 
    <td width="5%">&nbsp;</td>
    <td width="36%" align="center">&nbsp;</td>
    <td width="16%" align="center"><strong>Nature of Facility </strong></td>
    <td width="17%" align="center"><strong>Limit</strong></td>
    <td width="17%" align="center"> 
      <p align="left"><strong>Balance outstanding with Banks / Others as 
        on 		<table border="0" cellspacing="0" cellpadding="3" width="40%" class="outertable">
                          <tr> 
                            <td> 
                              <input type="text" name="txtmon_balancedate" size="12"
											maxlength="10" tabindex="8"
											onBlur="checkDate(this);checkmaxdate(this,currentDate)">
                            </td>
                            <td><a href="#" onClick="callCalender('txtmon_balancedate')"
											title="Click to view calender" border=0><img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											width="0" border="0" tabindex="7"></a></td>
                             <td><font size="1" face="MS Sans Serif">&nbsp;(dd/mm/yyyy)</font></td>
                          </tr>
                        </table>
                        </strong>
    </td>
  </tr>
  <tr> 
    <td width="5%">&nbsp;</td>
    <td width="36%"> 
      <select name="sel_sourcebank" size="1">
      <option value="">--select--</option>
        <option value="a) From Bank/s (Incl. Consortium members)">a) From Bank/s 
        (Incl. Consortium members)</option>
        <option value="b) From other sources (NBFCs / Pvt. Borrowing etc.)">b) 
        From other sources (NBFCs / Pvt. Borrowing etc.)</option>
      </select>
    </td>
    <td width="16%"> 
      <input type="text" name="txt_nature" size="20" maxlength="20">
    </td>
    <td width="17%"> 
      <lapschoice:CurrencyTag name="txt_limit" size="20" maxlength="15" onKeyPress="allowNumber(document.forms[0].txt_limit)" />
    </td>
    <td width="37%" align="center"> 
      <lapschoice:CurrencyTag name="txt_Balance" maxlength="15" size="20" onKeyPress="allowNumber(document.forms[0].txt_Balance)"/>
    </td>
  </tr>
</table>
<br>

						<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
								<br>
								
						<table width="100%" border="0" cellspacing="1" cellpadding="0"
							class="outertable">
							<tr>

								<td>

								<table width="100%" border="0" cellspacing="1" cellpadding="2"
									class="outertable">
									<tr class="dataHeader">
										<td width="3%" align="center">&nbsp;</td>
										
                              
            <td width="13%" align="center"><b></b></td>
										
                              
            <td width="14%" align="center"><b>Nature 
              of Facility</b></td>
										
                              
            <td width="14%" align="center"><B>Limit</B></td>
										
                              
            <td width="14%" align="center"><B> Balance OutStanding </B></td>
										
                                  
            <td width="14%" align="center"><B> Date</B></td>
									</tr>
								</table>

								</td>
							</tr>
							<tr>
								
      <td height="65"> 
        <div class="cellcontainer">

								
                            <table width="100%" border="0" cellspacing="1" cellpadding="2"
									class="outertable border1">
                              <%
                              //double dblTotcost1=0.00;
										arrCol=new ArrayList();
										arrRow=(ArrayList)hshValues.get("vecRow");
										if(arrRow!=null && arrRow.size()>0)
										{
 							    			for(int i=0;i<arrRow.size();i++)
											{
 							    				arrCol=(ArrayList)arrRow.get(i);
 							    				//dblTotcost1 = dblTotcost1+Double.parseDouble(Helper.correctDouble((String)arrCol.get(5)));	
									%>
                              <tr class="dataGrid">
										
                                <td width="3%" align="center"> 
                                  <input type="radio"
											style="border:none" name="radiobutton" value="radiobutton"
											onClick="javascript:selectValues(
												'<%=Helper.correctNull((String)arrCol.get(0))%>',
												'<%=Helper.correctNull((String)arrCol.get(1))%>',
												'<%=Helper.correctNull((String)arrCol.get(2))%>',
												'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))%>',
												'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))%>',
												'<%=Helper.correctNull((String)arrCol.get(5))%>')">
											
                                          </td>
										
                                <td width="13%" align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(1))%></td>
										
                                <td width="14%" align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(2))%></td>
										
                                <td width="14%" align="left">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))%></td>
										
                                <td width="14%" align="left">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))%></td>
                                
								<td width="14%" align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(5))%></td>
							
									</tr>
									<%
									}
									}
									%>
									<tr>
										
                                <td width="3%" align="center">&nbsp;</td>
										
                                <td width="13%" align="left">&nbsp;</td>
										
                                <td width="14%" align="left">&nbsp;</td>
										
                                <td width="14%" align="left">&nbsp;</td>
										
                                <td width="14%" align="left">&nbsp;</td>
								
                                
									</tr>
								</table>
								</div>
								</td>
							</tr>
						</table>
						<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidsno" >
<input type="hidden" name="accno" value="10000" >
<input type="hidden" name="cbsaccno" value="<%=request.getParameter("cbsaccno")%>">
<input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)request.getParameter("cbsid"))%>">
<input type="hidden" name="mon_year" value="<%=Helper.correctNull((String)request.getParameter("mon_year"))%>">
<input type="hidden" name="mon_month" value="<%=Helper.correctNull((String)request.getParameter("mon_month"))%>">
<input type="hidden" name="cbsname" value="<%=Helper.correctNull((String)request.getParameter("cbsname"))%>">
<input type="hidden" name="mon_accno" value="<%=Helper.correctNull((String)request.getParameter("mon_accno")) %>">
<input type="hidden" name="mon_msod" value="<%=strmsod%>">
<input type="hidden" name="mon_stock" value="<%=strstock%>">
<input type="hidden" name="mon_bkdebts" value="<%=strbkdebts%>">
<input type="hidden" name="mon_qpr" value="<%=strqpr%>">
</form>
 
</body>
</html>
