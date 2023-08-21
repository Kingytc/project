<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<%if (objValues instanceof java.util.HashMap) {
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
if(strqpr.equalsIgnoreCase(""))
{
	strqpr=Helper.correctNull((String)hshValues.get("mon_qpr"));
}	
%>

<html>
<head>
<title>Document Register</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var path      ="<%=ApplicationParams.getAppUrl()%>";
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
	document.forms[0].txt_propertyname.value="";
	document.forms[0].txt_invicedate.value="";
	document.forms[0].txt_upto90.value="";
	document.forms[0].txt_upto180.value="";
	document.forms[0].txt_above180.value="";
	document.forms[0].txt_totaldaysamount.value="";

	
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");	
}

function doSave()
{
	if(document.forms[0].txt_propertyname.value=="")
	{
		ShowAlert('121','Type of security');
		document.forms[0].txt_propertyname.focus();
		return;
	}
	

	document.forms[0].hidBeanId.value="mmrcommon";
	document.forms[0].hidSourceUrl.value="/action/mon_bookdebitsvalue.jsp";
	document.forms[0].hidBeanMethod.value="updateBookdebitsvalue";
	document.forms[0].hidBeanGetMethod.value="getBookdebitsvalue";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		
		document.forms[0].hidSourceUrl.value="mon_bookdebitsvalue.jsp";
		document.forms[0].hidBeanGetMethod.value="getBookdebitsvalue";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].action=appURL+"action/mon_bookdebitsvalue.jsp";	
		document.forms[0].submit();
	}	
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value="Delete";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="mmrcommon";
	document.forms[0].hidSourceUrl.value="/action/mon_bookdebitsvalue.jsp";
	document.forms[0].hidBeanMethod.value="updateBookdebitsvalue";
	document.forms[0].hidBeanGetMethod.value="getBookdebitsvalue";	
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

function selectValues(val1,val2, val3, val4, val5, val6, val7)
{
    document.forms[0].hidsno.value =val1;
	document.forms[0].txt_propertyname.value =val2;
	document.forms[0].txt_invicedate.value=val3;
	document.forms[0].txt_upto90.value=val4;
	document.forms[0].txt_upto180.value=val5;
	document.forms[0].txt_above180.value=val6;
	document.forms[0].txt_totaldaysamount.value=val7;
	//document.forms[0].txt_state.value=val8;
	
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
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}	  
	if(val=="disableall")
	{
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
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
	
	  
		document.forms[0].txt_totaldaysamount.readOnly=true;
		document.forms[0].txt_invicedate.readOnly=true;
}

function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
	 showCal(appURL,fname);
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
	/*else if(url=="com_takeoverworking.jsp")
	{
		document.forms[0].hidBeanId.value="comproposal";
	}*/
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

function sumamount()
{
	var uptoninety=document.forms[0].txt_upto90.value;
	if(uptoninety == "")
		uptoninety=0;
	var uptooneeigthy=document.forms[0].txt_upto180.value;
	if(uptooneeigthy == "")
		uptooneeigthy=0;
	var aboveoneeigthy=document.forms[0].txt_above180.value;
	if(aboveoneeigthy=="")
		aboveoneeigthy=0;
	



var totalamount=eval(uptoninety)+eval(uptooneeigthy)+eval(aboveoneeigthy);

document.forms[0].txt_totaldaysamount.value=NanNumber(totalamount);
roundtxt(document.forms[0].txt_totaldaysamount);

}

</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="placevalues()">
<form name="frmbookdebts" method=post class="normal">
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
					<td class="Page_Flow">
						Home -&gt; Monitoring-&gt; 
  Monthly Monitoring -&gt;Accountwise Details -&gt;MSOD -&gt;BookDebts Statement
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
						<lapschoice:MonthlyMonitor />
	 <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
    <tr> 
      <td valign="bottom"> 
        <table width="60%" border="0" cellspacing="3" cellpadding="3" align="left" class="outertable">
          <tr> 
            <td width="20%" class="sub_tab_inactive" align="center"  id="prin" ><b><a href="javascript:call_page('mon_accountwisedetails.jsp','getAccountwise')" >Account-Wise Details</a>></b> </td>
           <%if(Helper.correctNull((String)hshValues.get("mon_msod")).equalsIgnoreCase("y"))
		 				 {%>
            <td width="20%" class="sub_tab_active" align="center" id="prin"><b>MSOD
               </b></td>
            <%} 
              if( Helper.correctNull((String)hshValues.get("mon_qpr")).equalsIgnoreCase("y")){%>
            <td width="20%" class="sub_tab_inactive" align="center"  id="prin"><b><a href="javascript:call_page('mon_qprperformance.jsp','getQprPerformance')" >QPR
              </a></b></td>
              <%}

		  %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
						<lapschoice:MonMSODTag msod='<%=strmsod%>' stock='<%=strstock%>' bookdebts='<%=strbkdebts%>' pageid="5"/>
						<lapschoice:Monitor strSource="MMR"/>
  
		<table width="100%" border="0" cellspacing="0" cellpadding="2"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						
                      <td> 
                        <table border="0" width="100%" height="71" class="outertable border1">
                          <tr class="dataHeader"> 
                            
                            <td width="18%" height="34" rowspan="2"><strong>Name 
                              of the Party</strong></td>
                            <td width="12%" height="34" rowspan="2"><strong>Date 
                              of Invoice</strong></td>
                            <td width="12%" height="19">Up to 90 days<br>
                              <small><small>(*consider for 
                              DP only)</small></small></td>
                            <td width="13%" height="19">91 to 180 days</td>
                            <td width="13%" height="19">Above 180 days</td>
                            <td width="13%" height="19">Amount</td>
                          </tr>
                          <tr> 
                          
                          </tr>
                          <tr> 
                           
                            <td width="18%" height="19"> 
                              <input size="30" name="txt_propertyname" onKeyPress="notAllowSplChar()"maxlength="30">
                            </td>
                            <td> 
        <input type="text" size="13" name="txt_invicedate" value="<%//=Helper.correctNull((String)hshValues.get("MONSEC_VALUATDATE"))%>" onBlur="checkDate(this);checkmaxdate(this,currentDate)"> 
			<a alt="Select date from calender" href="#"
																	onClick="callCalender('txt_invicedate')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border=0 alt="Select date from calender"></a>
      </td>
                            <td width="12%" height="19"> 
                              <lapschoice:CurrencyTag size="20" name="txt_upto90" onBlur="sumamount()" maxlength="15" />
                            </td>
                            <td width="13%" height="19"> 
                              <lapschoice:CurrencyTag size="20" name="txt_upto180" onBlur="sumamount()"maxlength="15" />
                            </td>
                            <td width="13%" height="19"> 
                              <lapschoice:CurrencyTag size="20" name="txt_above180" onBlur="sumamount()"maxlength="15" />
                            </td>
                             <td width="13%" height="19"> 
                              <lapschoice:CurrencyTag size="20" name="txt_totaldaysamount" maxlength="20" />
                            </td>
                          </tr>
                          
                        
                         
                        </table>
                      </td>
					</tr>
					<tr>
						<td><br>
						<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
						</td>
					</tr>
					<br>
					
					<tr>
					
						<td>

						<table width="100%" border="0" cellspacing="1" cellpadding="0"
							class="outertable">
							<tr>

								<td>

								<table width="98.3%" border="0" cellspacing="1" cellpadding="2"
									class="outertable">
									<tr class="dataHeader">
										<td width="3%" align="center">&nbsp;</td>
										<td width="13%" align="center"><b><strong>Name 
                              of the Party</strong></b></td>
										<td width="14%" align="center"><b><strong>Date 
                              of Invoice</strong></b></td>
										<td width="14%" align="center"><B>Amount Upto 90 days (Rs)</B></td>
										<td width="14%" align="center"><B> Amount Upto 180 days (Rs)</B></td>
										<td width="14%" align="center"><b><B>Amount above 180 days (Rs)</B></b></td>
										<td width="14%" align="center"><b>Amount</b></td>
									
									</tr>
								</table>

								</td>
							</tr>
							<tr>
								<td>
								<div class="cellcontainer">

								
                            <table width="100%" border="0" cellspacing="1" cellpadding="2"
									class="outertable">
                              <%
                              			double dbltotal=0.00;
										arrCol=new ArrayList();
										arrRow=(ArrayList)hshValues.get("arrRow");
										if(arrRow!=null && arrRow.size()>0)
										{
 							    			for(int i=0;i<arrRow.size();i++)
											{
 							    				arrCol=(ArrayList)arrRow.get(i);
 							    				dbltotal = dbltotal+Double.parseDouble(Helper.correctDouble(arrCol.get(8).toString()));	
									%>
                              <tr class="dataGrid">
										
                                <td width="3%" align="center"> 
                                  <input type="radio"
											style="border:none" name="radiobutton" value="radiobutton"
											onClick="javascript:selectValues(
												'<%=Helper.correctNull((String)arrCol.get(0))%>',
												'<%=Helper.correctNull((String)arrCol.get(3))%>',
												'<%=Helper.correctNull((String)arrCol.get(4))%>',
												'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))%>',
												'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))%>',
												'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7))))%>',
												'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(8))))%>',
												'<%=Helper.correctNull((String)arrCol.get(9))%>')">
											
                                          </td>
                                          
                                          
                                          
										
                                <td width="13%" align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(3))%></td>
										
                                <td width="14%" align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%></td>
										
                                <td width="14%" align="left">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))%></td>
										
                                <td width="14%" align="left">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))%></td>
										
                                <td width="14%" align="left">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7))))%></td>
										
                                <td width="14%" align="left">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(8))))%></td>
							
                               
									</tr>
									<%
									}
									}
									%>
									<tr class="dataGrid">
										
                                <td width="3%" align="center">&nbsp;</td>
										
                                <td width="13%" align="left">&nbsp;</td>
										
                                <td width="14%" align="left">&nbsp;</td>
										
                                <td width="14%" align="left">&nbsp;</td>
										
                                <td width="14%" align="left">&nbsp;</td>
										
                                <!-- <td width="14%" align="left">&nbsp;</td>
										
                                  <td width="14%" align="left">&nbsp;</td>-->
								
								<td width="14%"	align="left">Total</td>
								
								<td width="14%"align="left"><%=Helper.formatDoubleValue(dbltotal) %></td>
							
                               
									</tr>
								</table>
								</div>
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
<input type="hidden" name="hidsno" >
<input type="hidden" name="mon_accno" value="<%=Helper.correctNull((String)request.getParameter("mon_accno")) %>">
<input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)request.getParameter("cbsid"))%>">
<input type="hidden" name="mon_year" value="<%=Helper.correctNull((String)request.getParameter("mon_year"))%>">
<input type="hidden" name="mon_month" value="<%=Helper.correctNull((String)request.getParameter("mon_month"))%>">
<input type="hidden" name="cbsname" value="<%=Helper.correctNull((String)request.getParameter("cbsname"))%>">
<input type="hidden" name="grant_total" value="<%=dbltotal%>">
<input type="hidden" name="mon_msod" value="<%=strmsod%>">
<input type="hidden" name="mon_stock" value="<%=strstock%>">
<input type="hidden" name="mon_bkdebts" value="<%=strbkdebts%>">
<input type="hidden" name="mon_qpr" value="<%=strqpr%>">
</form>
</body>
</html>
