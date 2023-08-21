<%@include file="../share/directives.jsp"%>
<%String stryears[]={"(i)Limit","(ii)TurnOver","(iii)Maximum Debit","(iv)Minimum Debit","(v)No of Days A/C in Debit",
		"(vi)Avg Debit Balance(Only of last 12 Months)"};
String strmonth[]={"Jan","Feb","March","April","May","June"};
String strmonth1[]={"July","Aug","Sep","Oct","Nov","Dec"};
String stryears1[]={"(vii)Present O/S","(viii)Overdue","(ix)Stocks Last Inspected","(x)Stock Stmt Last received"};


	ArrayList vecrow1 = new ArrayList();
	ArrayList veccol1 = new ArrayList();
	ArrayList vecrow2 = new ArrayList();
	ArrayList veccol2 = new ArrayList();	
	ArrayList vecrow = new ArrayList();
	ArrayList veccol = new ArrayList();		
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
function callload() {
    disableFields(true);
}
function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
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

function disableFields(one)
{	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}		
	} 	
}	

function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if( ConfirmMsg(101))
		{
			document.forms[0].hidAction.value ="delete";		
			document.forms[0].action=appUrl+"action/ControllerServlet";	
			document.forms[0].hidBeanMethod.value="updateworkingcapital";
			document.forms[0].hidBeanGetMethod.value="getworkingcapital";
			document.forms[0].hidBeanId.value="ADV1151";
			document.forms[0].hidSourceUrl.value="/action/adv_workingcapital.jsp";				
			document.forms[0].submit();	
		} 
	}
	else
	{
		
		ShowAlert(158);
	}
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/agrpage.jsp";
		document.forms[0].submit();		
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
	for(var i=0;i<6;i++)
	{
		var txt_cclast12month=document.forms[0].txt_cclast12month[i].value;
		var txt_ccprevious12month=document.forms[0].txt_ccprevious12month[i].value;
		var txt_hyplast12month=document.forms[0].txt_hyplast12month[i].value;
		var txt_hypprevious12month=document.forms[0].txt_hypprevious12month[i].value;
		
	   if (txt_cclast12month=="")
		{
		   txt_cclast12month=0;
		}
		if (txt_ccprevious12month=="")
		{
		   txt_ccprevious12month=0;
		}
		if (txt_hyplast12month=="")
		{
		   txt_hyplast12month=0;
		}
		if (txt_hypprevious12month=="")
		{
		   txt_hypprevious12month=0;
		}	
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidRecordflag.value=varRecordFlag;	
	document.forms[0].hidBeanId.value="ADV1151";		
	document.forms[0].hidSourceUrl.value="/action/adv_workingcapital.jsp";
	document.forms[0].hidBeanMethod.value="updateworkingcapital";
	document.forms[0].hidBeanGetMethod.value="getworkingcapital";
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
		document.forms[0].hidSourceUrl.value="/action/adv_workingcapital.jsp";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidBeanMethod.value="updateworkingcapital";
		document.forms[0].hidBeanGetMethod.value="getworkingcapital";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 	
	}
}
function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
	 {
	 showCal(appUrl,fname);
	 }
}
function checkYearsDays(obj)
{
     var temp_year=0;     
     if(!(new String(obj.value)=="" || new String(obj.value)=="0.00" || new String(obj.value)=="0"))
     {     
         temp_year=parseFloat(obj.value);         
         if(temp_year > 366 || temp_year < 0)
         {
             alert("No Of Days Should not be greater than 366");
             obj.value="";
             return false; 
             }     
     }
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callload()">
<form name="finForm" class="normal" method="post">
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
		<td class="page_flow">Home -&gt; Tertiary -&gt; Proposal -&gt; ADV1151 -&gt; Working Capital</td>
	</tr>
</table>
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application /><br>
 <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
 <tr class="dataheader">
 <td align="center"><b>WORKING CAPITAL</b></td>
 </tr>
 </table>
				<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
							<tr>								
                  <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor" align="center">
                      <tr class="dataheader"> 
                        <td width="11%"  align="center" ><b>(b)Working Capital</b></td>
                        <td  align="center" colspan="4" ><b>Cash Credit (Pledge)</b></td>
                        <td  align="center" colspan="4" ><b>Cash Credit (Hyp)</b></td>
                      </tr>
                      <tr class="dataheader"> 
                        <td width="11%"  align="center">&nbsp;</td>
                        <td  colspan="2" align="center">Last 12 Month (<%=ApplicationParams.getCurrency()%>)</td>
                        <td  colspan="2" align="center">Previous 12 
                          Month (<%=ApplicationParams.getCurrency()%>)</td>
                        <td  colspan="2" align="center">Last 12 Month (<%=ApplicationParams.getCurrency()%>)</td>
                        <td  colspan="2" align="center">Previous 12 
                          Month (<%=ApplicationParams.getCurrency()%>)</td>
                      </tr>
                      <%vecrow = (ArrayList) hshValues.get("vecData");                                	 
                                	  if(vecrow!=null && vecrow.size()>0)
                 						{                 						
                   							for(int i=0;i<6;i++)
                   							{                   							
                   							if(6<=vecrow.size())                   								
                         					{	
                     							veccol = (ArrayList) vecrow.get(i);%>
                      <tr class="datagrid">
                      <%if(i==4){ %>                       
                        <td width="11%"  ><%=stryears[i] %></td>                        
                        <td align="center" colspan="2" > <lapschoice:CurrencyTag  name="txt_cclast12month" tabindex="1" maxlength="12" value='<%=Helper.correctNull((String)veccol.get(0))%>'  other="onKeyUp='checkYearsDays(this);'"/></td>
                        <td align="center" colspan="2" > <lapschoice:CurrencyTag  name="txt_ccprevious12month" tabindex="2" maxlength="12" value='<%=Helper.correctNull((String)veccol.get(1))%>'  other="onKeyUp='checkYearsDays(this);'"/></td>
                        <td  align="center"colspan="2" > <lapschoice:CurrencyTag  name="txt_hyplast12month"  tabindex="3" maxlength="12" value='<%=Helper.correctNull((String)veccol.get(2))%>'  other="onKeyUp='checkYearsDays(this);'"/></td>
                        <td  align="center"colspan="2" > <lapschoice:CurrencyTag  name="txt_hypprevious12month" tabindex="4" maxlength="12" value='<%=Helper.correctNull((String)veccol.get(3))%>'  other="onKeyUp='checkYearsDays(this);'"/></td>
                        <%}else{ %>
                         <td width="11%"  ><%=stryears[i] %></td>
                         <td align="center" colspan="2" > <lapschoice:CurrencyTag  name="txt_cclast12month" tabindex="1" maxlength="12" value='<%=Helper.correctNull((String)veccol.get(0))%>'/> 
                        </td>
                        <td align="center" colspan="2" > <lapschoice:CurrencyTag  name="txt_ccprevious12month" tabindex="2" maxlength="12" value='<%=Helper.correctNull((String)veccol.get(1))%>'/> 
                        </td>
                        <td  align="center"colspan="2" > <lapschoice:CurrencyTag  name="txt_hyplast12month"  tabindex="3" maxlength="12" value='<%=Helper.correctNull((String)veccol.get(2))%>'/> 
                        </td>
                        <td  align="center"colspan="2" > <lapschoice:CurrencyTag  name="txt_hypprevious12month" tabindex="4" maxlength="12" value='<%=Helper.correctNull((String)veccol.get(3))%>'/> 
                        </td>
                        
                        
                      </tr>
                      <%}}else{%>
                      <tr class="datagrid"> 
                      <%if(i==4){ %>
                        
                        <td width="11%"  ><%=stryears[i] %></td>

                        <td align="center" colspan="2" > <lapschoice:CurrencyTag  name="txt_cclast12month" tabindex="5" maxlength="12"  other="onKeyUp='checkYearsDays(this);'"/> 
                        </td>
                        <td  align="center"colspan="2" > <lapschoice:CurrencyTag  name="txt_ccprevious12month" tabindex="6" maxlength="12"  other="onKeyUp='checkYearsDays(this);'"/> 
                        </td>
                        <td  align="center"colspan="2" > <lapschoice:CurrencyTag  name="txt_hyplast12month" tabindex="7" maxlength="12"  other="onKeyUp='checkYearsDays(this);'"/> 
                        </td>
                        <td align="center" colspan="2" > <lapschoice:CurrencyTag  name="txt_hypprevious12month" tabindex="8" maxlength="12"  other="onKeyUp='checkYearsDays(this);'" /> 
                        </td>
                                               
                        <%}else{ %>
                          <td width="11%"  ><%=stryears[i] %></td>

                        <td align="center" colspan="2" > <lapschoice:CurrencyTag  name="txt_cclast12month" tabindex="5" maxlength="12" /> 
                        </td>
                        <td  align="center"colspan="2" > <lapschoice:CurrencyTag  name="txt_ccprevious12month" tabindex="6" maxlength="12" /> 
                        </td>
                        <td  align="center"colspan="2" > <lapschoice:CurrencyTag  name="txt_hyplast12month" tabindex="7" maxlength="12"/> 
                        </td>
                        <td align="center" colspan="2" > <lapschoice:CurrencyTag  name="txt_hypprevious12month" tabindex="8" maxlength="12"  /> 
                        </td>
                        
                      </tr>
                      <%}} }}%>
                      <tr class="datagrid"> 
                        <td width="11%"  rowspan="7">&nbsp;</td>
                        <td width="9%"  align="center" >Month</td>
                        <td width="14%"  align="center" >Amount (<%=ApplicationParams.getCurrency()%>)</td>
                        <td width="8%"  align="center" >Month</td>
                        <td width="14%"  align="center" >Amount (<%=ApplicationParams.getCurrency()%>)</td>
                        <td width="8%"  align="center" >Month</td>
                        <td width="14%"  align="center" >Amount (<%=ApplicationParams.getCurrency()%>)</td>
                        <td width="7%"  align="center" >Month</td>
                        <td width="15%"  align="center" >Amount (<%=ApplicationParams.getCurrency()%>)</td>
                      </tr>
                      <%vecrow1 = (ArrayList) hshValues.get("vecData1");                                	 
                                	  if(vecrow1!=null && vecrow1.size()>0)
                 						{                 						
                   							for(int i=0;i<6;i++)
                   							{                   							
                   							if(6<=vecrow1.size())                   								
                         					{	
                     							veccol1 = (ArrayList) vecrow1.get(i);%>
                      <tr class="datagrid"> 
                        <td width="9%"  ><%=strmonth[i] %></td>
                        <td width="14%"  > <lapschoice:CurrencyTag name="txt_pledgeamount1" tabindex="9" maxlength="12" value='<%=Helper.correctNull((String)veccol1.get(0))%>'/> 
                        </td>
                        <td width="8%"  ><%=strmonth1[i] %></td>
                        <td width="14%"  > <lapschoice:CurrencyTag name="txt_pledgeamount2" tabindex="10" maxlength="12" value='<%=Helper.correctNull((String)veccol1.get(1))%>'/> 
                        </td>
                        <td width="8%"  ><%=strmonth[i] %></td>
                        <td width="14%"  > <lapschoice:CurrencyTag name="txt_hypamount1" tabindex="11" maxlength="12" value='<%=Helper.correctNull((String)veccol1.get(2))%>'/> 
                        </td>
                        <td width="7%"  ><%=strmonth1[i] %></td>
                        <td width="15%"  > <lapschoice:CurrencyTag name="txt_hypamount2" tabindex="12" maxlength="12" value='<%=Helper.correctNull((String)veccol1.get(3))%>'/> 
                        </td>
                      </tr>
                      <%}else{%>
                      <tr class="datagrid"> 
                        <td width="9%"  ><%=strmonth[i] %></td>
                        <td width="14%"  > <lapschoice:CurrencyTag name="txt_pledgeamount1" tabindex="9" maxlength="12"/> 
                        </td>
                        <td width="8%"  ><%=strmonth1[i] %></td>
                        <td width="14%"  > <lapschoice:CurrencyTag name="txt_pledgeamount2" tabindex="10" maxlength="12"/> 
                        </td>
                        <td width="8%"  ><%=strmonth[i] %></td>
                        <td width="14%"  > <lapschoice:CurrencyTag name="txt_hypamount1" tabindex="11" maxlength="12"/> 
                        </td>
                        <td width="7%"  ><%=strmonth1[i] %></td>
                        <td width="15%"  > <lapschoice:CurrencyTag name="txt_hypamount2" tabindex="12" maxlength="12"/> 
                        </td>
                      </tr>
                      <%} }}%>
                      <tr class="dataheader"> 
                        <td width="11%"  >&nbsp;</td>
                        <td  colspan="2" align="center" >Amount (<%=ApplicationParams.getCurrency()%>)</td>
                        <td  colspan="2" align="center" >Date</td>
                        <td  colspan="2" align="center" >Amount (<%=ApplicationParams.getCurrency()%>)</td>
                        <td  colspan="2" align="center" >Date</td>
                      </tr>
                      <%vecrow2 = (ArrayList) hshValues.get("vecData2");                                	 
                                	  if(vecrow2!=null && vecrow2.size()>0)
                 						{
                                		  for(int i=0;i<4;i++)
                   							{
                   							if(4<=vecrow2.size())                   								
                         					{	
                     							veccol2 = (ArrayList) vecrow2.get(i);%>
                      <tr class="datagrid"> 
                        <td width="11%"  ><%=stryears1[i]%></td>
                        <td align="center" colspan="2" > <lapschoice:CurrencyTag name="txt_amount1" tabindex="13" maxlength="12" value='<%=Helper.correctNull((String)veccol2.get(0))%>'/> 
                        </td>
                        <td align="center" colspan="2" > 
                          <table border="0" cellspacing="0" cellpadding="3" width="40%" class="outertable">
                            <tr> 
                              <td> 
                                <input type="text" name="txt_date1" size="12"value="<%=Helper.correctNull((String)veccol2.get(1))%>"
											maxlength="10" tabindex="14"
											onBlur="checkDate(this);checkmaxdate(this,currentDate)">
                              </td>
                              <td><a href="#" onClick="callCalender('txt_date1[<%=i%>]')"
											title="Click to view calender"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											width="0" border="0" tabindex="15"></a></td>
                              <td>&nbsp;(dd/mm/yyyy)</td>
                            </tr>
                          </table>
                        </td>
                        <td  align="center"colspan="2" > <lapschoice:CurrencyTag name="txt_amount2" tabindex="16" maxlength="12" value='<%=Helper.correctNull((String)veccol2.get(2))%>'/> 
                        </td>
                        <td align="center" colspan="2" > 
                          <table border="0" cellspacing="0" cellpadding="3" width="40%" class="outertable">
                            <tr> 
                              <td> 
                                <input type="text" name="txt_date2" size="12"value="<%=Helper.correctNull((String)veccol2.get(3))%>"
											maxlength="10" tabindex="17"
											onBlur="checkDate(this);checkmaxdate(this,currentDate)">
                              </td>
                              <td><a href="#" onClick="callCalender('txt_date2[<%=i%>]')"
											title="Click to view calender"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											width="0" border="0" tabindex="18"></a></td>
                              <td>&nbsp;(dd/mm/yyyy)</td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <%}else{%>
                      <tr class="datagrid"> 
                        <td width="11%"  ><%=stryears1[i]%></td>
                        <td  colspan="2" > <lapschoice:CurrencyTag name="txt_amount1" tabindex="13" maxlength="12"/> 
                        </td>
                        <td  colspan="2" > 
                          <table border="0" cellspacing="0" cellpadding="3" width="40%" class="outertable">
                            <tr> 
                              <td> 
                                <input type="text" name="txt_date1" size="12"
											maxlength="10" tabindex="14"
											onBlur="checkDate(this);checkmaxdate(this,currentDate)">
                              </td>
                              <td><a href="#" onClick="callCalender('txt_date1[<%=i%>]')"
											title="Click to view calender"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											width="0" border="0" tabindex="15"></a></td>
                              <td>&nbsp;(dd/mm/yyyy)</td>
                            </tr>
                          </table>
                        </td>
                        <td  colspan="2" > <lapschoice:CurrencyTag name="txt_amount2" tabindex="16" maxlength="12"/> 
                        </td>
                        <td  colspan="2" > 
                          <table border="0" cellspacing="0" cellpadding="3" width="40%" class="outertable">
                            <tr> 
                              <td> 
                                <input type="text" name="txt_date2" size="12"
											maxlength="10" tabindex="17"
											onBlur="checkDate(this);checkmaxdate(this,currentDate)">
                              </td>
                              <td><a href="#" onClick="callCalender('txt_date2[<%=i%>]')"
											title="Click to view calender"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											width="0" border="0" tabindex="18"></a></td>
                              <td>&nbsp;(dd/mm/yyyy)</td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <%} }}%>
                    </table>
                </td>
               </tr>
              </table>
             </td>
            </tr>
           </table>
           <br>
      <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr> 
      <td width="20%" ><b>&nbsp; 
        <a href="javascript:callLink('adv_connectedaccounts.jsp','ADV1151','getconnectedaccts')" > 
        &lt;&lt; Previous </a>&nbsp;</b> </td>
      <td width="60%" align="center"><b> 
        <jsp:include page="../ADV11-51/adv_links.jsp" flush="true"/> 
        </b></td>
      <td width="20%">&nbsp; 
        <div align="right"><b>Pg.12/19&nbsp;
        <a href="javascript:callLink('adv_billpurchase.jsp','ADV1151','getPurchaseDetails')" > 
          Next &gt;&gt; </a></b></div>
      </td>
    </tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidsno" >
</form>
</body>
</html>