<%@include file="../share/directives.jsp"%>
<%
java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);
String stryears[]={"a)Inventory","b)Receivables","c)Other CA","d)TOTAL CA","e)Bank Borrowings for WC",
		"f)Sundry Creditors","g)Other CL","h)TOTAL CL","i)NWC(d-h)","j)Current ratio(d/h)"};
	ArrayList vecrow = new ArrayList();
	ArrayList veccol = new ArrayList();
	ArrayList vecyearlyincome= new ArrayList();

	String[][] row = new String[25][25];
	String stryearlyincome[] = new String[20];
		int intyearsize=0;
		if (hshValues != null) {
			intyearsize =Integer.parseInt((String) hshValues.get("intyearsize"));
			
	}
		String stryear=Helper.correctNull((String)request.getParameter("mon_year"));
		if(!stryear.equalsIgnoreCase(""))
		{
			stryear=Helper.correctNull((String)hshValues.get("mon_year"));
		}
		String strmonth=Helper.correctNull((String)request.getParameter("mon_month"));

		if(!strmonth.equalsIgnoreCase(""))
		{
			strmonth=Helper.correctNull((String)hshValues.get("mon_month"));
		}
		
		
		
		
		String strmsod=Helper.correctNull((String)request.getParameter("mon_msod"));
		if(strmsod.equalsIgnoreCase(""))
		{
			strmsod=Helper.correctNull((String)hshValues.get("mon_msod"));
		}			
		String strstock=Helper.correctNull((String)request.getParameter("mon_stock"));
		if(strstock.equalsIgnoreCase(""))
		{
			strstock=Helper.correctNull((String)hshValues.get("mon_stock"));
		}
		String strbkdebts=Helper.correctNull((String)request.getParameter("mon_bkdebts"));
		if(strbkdebts.equalsIgnoreCase(""))
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
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<SCRIPT LANGUAGE="JavaScript">
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";

function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;

}
function callClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appUrl+"action/mainnav.jsp";
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
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updateworkingcapitalfunds";
		document.forms[0].hidBeanGetMethod.value="getworkingcapitalfunds";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidSourceUrl.value="/action/mon_workingcapitalfunds.jsp";	
			
		document.forms[0].submit();	
	} 
}



function doSave()
{
	for(var i=0;i<10;i++)
	{
		var txt_monyear1=document.forms[0].txt_monyear1[i].value;
		var txt_monyear2=document.forms[0].txt_monyear2[i].value;
		var txt_monyearsub=document.forms[0].txt_monyearsub[i].value;
		var txt_monyear4=document.forms[0].txt_monyear4[i].value;
		
	   if (txt_monyear1=="")
		{
		   txt_monyear1=0;
		}
		if (txt_monyear2=="")
		{
		   txt_monyear2=0;
		}
		if (txt_monyearsub=="")
		{
		   txt_monyearsub=0;
		}
		if (txt_monyear4=="")
		{
		   txt_monyear4=0;
		}
		
	
	}
	document.forms[0].hidBeanId.value="mmrcommon";		
	document.forms[0].hidSourceUrl.value="/action/mon_workingcapitalfunds.jsp";
	document.forms[0].hidBeanMethod.value="updateworkingcapitalfunds";
	document.forms[0].hidBeanGetMethod.value="getworkingcapitalfunds";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();	
}

function doEdit()
{
 	disableFields(false);
	document.forms[0].hidAction.value ="insert"; 
	
	enableButtons(true, false, false, false, true);
	for(var i=0; i<10; i++)
	{
		//document.forms[0].txt_monyear1[i].readOnly=true;
		//document.forms[0].txt_monyear2[i].readOnly=true;
		document.forms[0].txt_monyearsub[i].readOnly=true;
		//document.forms[0].txt_monyear4[i].readOnly=true;
			
	}
	
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="cancel"; 
		document.forms[0].hidSourceUrl.value="mon_workingcapitalfunds.jsp";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidBeanGetMethod.value="getworkingcapitalfunds";
		document.forms[0].action=appUrl+"action/mon_workingcapitalfunds.jsp";
		document.forms[0].submit(); 	
	}
}



function cashFlowCal(j)
{
	var temp1="0";
	var temp2="0";
	var temp3="0";
	var temp4="0";
	
	var temp5="0";
	var temp6="0";
	var temp7="0";
	var temp8="0";
	for(var i=0;i<10;i++)
	{
	 
		var txt_monyear1=NanNumber(document.forms[0].txt_monyear1[i].value);
		var txt_monyear2=NanNumber(document.forms[0].txt_monyear2[i].value);
		var txt_monyearsub=NanNumber(document.forms[0].txt_monyearsub[i].value);
		var txt_monyear4=NanNumber(document.forms[0].txt_monyear4[i].value);
		
		
		if(txt_monyear1=="")
		{
			txt_monyear1="0";
		}
		if(txt_monyear2=="")
		{
			txt_monyear2="0";
		}
		if(txt_monyearsub=="")
		{
			txt_monyearsub="0";
		}
		if(txt_monyear4=="")
		{
			txt_monyear4="0";
		}
		var temp="0";
		
		temp=parseInt(txt_monyear2)-parseInt(txt_monyear1);
		document.forms[0].txt_monyearsub[i].value=Math.abs((temp));
		
		
		
		
		roundtxt(document.forms[0].txt_monyear1[i]);
		roundtxt(document.forms[0].txt_monyear2[i]);
		roundtxt(document.forms[0].txt_monyearsub[i]);
		roundtxt(document.forms[0].txt_monyear4[i]);
		
		if(i<3) {
		temp1=eval(temp1)+eval(txt_monyear1);
		document.forms[0].txt_monyear1[3].value=temp1;
		
		temp2=eval(temp2)+eval(txt_monyear2);
		document.forms[0].txt_monyear2[3].value=temp2;
		
		temp3=eval(temp3)+eval(txt_monyearsub);
		document.forms[0].txt_monyearsub[3].value=temp3;
		
		temp4=eval(temp4)+eval(txt_monyear4);
		document.forms[0].txt_monyear4[3].value=temp4;
		}
		if(i>3 && i<7) {
		
		temp5=eval(temp5)+eval(txt_monyear1);
		document.forms[0].txt_monyear1[7].value=temp5;
		
		temp6=eval(temp6)+eval(txt_monyear2);
		document.forms[0].txt_monyear2[7].value=temp6;
		
		temp7=eval(temp7)+eval(txt_monyearsub);
		document.forms[0].txt_monyearsub[7].value=temp7;
		
		temp8=eval(temp8)+eval(txt_monyear4);
		document.forms[0].txt_monyear4[7].value=temp8;
		}
		
		if(i==8) {
		document.forms[0].txt_monyear1[8].value=Math.abs((document.forms[0].txt_monyear1[3].value)-(document.forms[0].txt_monyear1[7].value));
		document.forms[0].txt_monyear2[8].value=Math.abs((document.forms[0].txt_monyear2[3].value)-(document.forms[0].txt_monyear2[7].value));
		
		document.forms[0].txt_monyearsub[8].value=Math.abs((document.forms[0].txt_monyearsub[3].value)-(document.forms[0].txt_monyearsub[7].value));
		document.forms[0].txt_monyear4[8].value=Math.abs((document.forms[0].txt_monyear4[3].value)-(document.forms[0].txt_monyear4[7].value));
		
		}
		
		
		if(i==9) {
		
		if(document.forms[0].txt_monyear1[3].value!="" && document.forms[0].txt_monyear1[7].value !=""){
		
			if(document.forms[0].txt_monyear1[7].value!=0.00) {
				var monyear9 = eval(document.forms[0].txt_monyear1[3].value)/eval(document.forms[0].txt_monyear1[7].value);
				document.forms[0].txt_monyear1[9].value=NanNumber(monyear9);
			}else {
				monyear9=0.00;
				document.forms[0].txt_monyear1[9].value=monyear9;
			}
		}
		//NanNumber(document.forms[0].txt_monyear1[3].value)/NanNumber(document.forms[0].txt_monyear1[7].value);
		
		if(document.forms[0].txt_monyear2[3].value!="" && document.forms[0].txt_monyear2[7].value !=""){
			
			if(document.forms[0].txt_monyear2[7].value!=0.00) {
				var monyear2=eval(document.forms[0].txt_monyear2[3].value)/eval(document.forms[0].txt_monyear2[7].value);
				document.forms[0].txt_monyear2[9].value=NanNumber(monyear2);
			}else {
				monyear2=0.00;
				document.forms[0].txt_monyear2[9].value=monyear2;
			}
		}
		//NanNumber(document.forms[0].txt_monyear2[3].value)/NanNumber(document.forms[0].txt_monyear2[7].value);
		if(document.forms[0].txt_monyearsub[3].value!="" && document.forms[0].txt_monyearsub[7].value !=""){
		
			if(document.forms[0].txt_monyearsub[7].value!=0.00) {
				var yearsub=eval(document.forms[0].txt_monyearsub[3].value)/eval(document.forms[0].txt_monyearsub[7].value);
				document.forms[0].txt_monyearsub[9].value=NanNumber(yearsub);
			}else {
				yearsub=0.00;
				document.forms[0].txt_monyearsub[9].value=yearsub;
			}
		}
		
		if(document.forms[0].txt_monyear4[3].value!="" && document.forms[0].txt_monyear4[7].value !=""){
			if(document.forms[0].txt_monyear4[7].value!=0.00) {
				var monyear4=eval(document.forms[0].txt_monyear4[3].value)/eval(document.forms[0].txt_monyear4[7].value);
				document.forms[0].txt_monyear4[9].value=NanNumber(monyear4);
			}else {
				monyear4=0.00;
				document.forms[0].txt_monyear4[9].value=monyear4;
			}
		}
		
		//document.forms[0].txt_monyearsub[9].value=NanNumber(document.forms[0].txt_monyearsub[3].value)/NanNumber(document.forms[0].txt_monyearsub[7].value);
		//document.forms[0].txt_monyear4[9].value=NanNumber(document.forms[0].txt_monyear4[3].value)/NanNumber(document.forms[0].txt_monyear4[7].value);
		
		}
		roundtxt(document.forms[0].txt_monyear1[9]);
		roundtxt(document.forms[0].txt_monyear2[9]);
		roundtxt(document.forms[0].txt_monyearsub[9]);
		roundtxt(document.forms[0].txt_monyear4[9]);
		
		
		
	}	
}

function call_page(url,method)
{
	
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].method="post";

	if(url=="mon_workingcapitalfunds.jsp")
	{
		document.forms[0].hidBeanId.value="mmrcommon";
	}
	else if(url=="com_takeoverworking.jsp")
	{
		document.forms[0].hidBeanId.value="comproposal";
	}
	else if(url=="mon_accountwisedetails.jsp")
	{
		document.forms[0].hidBeanId.value="mmrcommon";
	}
	
	else
	{
		document.forms[0].hidBeanId.value="mmrcommon";
	}
	document.forms[0].action=appUrl+"action/"+url;
	document.forms[0].submit();
	
}



function callLink(page,bean,method)
{
	
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
	
}


function callonload() {
	
 enableButtons(false,true,true,true,false);
 disableFields(true);
}

</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body  onload="callonload()">
<form name="finForm" action="" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left"  class="outertable"> 
				<tr>
					<td>
						<lapschoice:monthlymonitortag pageid="5"/>
					</td>
				</tr>
				<tr>
					<td class="Page_Flow">
						Home -&gt; Monitoring-&gt; 
  Monthly Monitoring -&gt;Accountwise Details-&gt;QPR-&gt;Working Capital Funds
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
            <td width="20%" class="sub_tab_inactive" align="center"   id="prin" ><b><a href="javascript:call_page('mon_accountwisedetails.jsp','getAccountwise')" ">Account-Wise Details</a></b> </td>
            <%if(Helper.correctNull((String)hshValues.get("mon_checkmsod")).equalsIgnoreCase("y"))
		 				 {%>
            <td width="20%" class="sub_tab_inactive" align="center"  id="prin"><b><a href="javascript:call_page('mon_msodestimates.jsp','getmsodestimate')" >MSOD</a>
               </b></td>
             <%} 
              if( Helper.correctNull((String)hshValues.get("mon_checkqpr")).equalsIgnoreCase("y")){%>
            <td width="20%" class="sub_tab_active" align="center"  id="prin"><b><a href="javascript:call_page('mon_qprperformance.jsp','getQprPerformance')" >QPR
              </a></b></td>
              <%}

		  %>
          </tr>
        </table>
      </td>
    </tr>
   </table>
						<lapschoice:MonQPRTag  pageid="2"/>
						<lapschoice:Monitor strSource="MMR"/>
  <table width="100%" border="0" cellspacing="0" cellpadding="5"
					height="100%" class="outertable border1">
	<tr>
		<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5"
					height="100%" class="outertable border1" >
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="4"
							class="outertable border1">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="outertable">
											<tr valign="top">
												
                              <td colspan="7"> 
                                <table width="100%" border="0" cellspacing="0"
													cellpadding="3" class="outertable border1">
                                  <tr class="dataHeader" align="center"> 
                                    <td rowspan="2"  width="14%">Project 
                                      Year</td>
                                    <td rowspan="2"  width="22%">
                                      At the end of last year(1) </td>
                                    <td rowspan="2"  width="27%">
                                      At the current quarter ending(2)</td>
                                    <td rowspan="2" width="20%">
                                      Change during the current year(2)-(1)</td>
                                   
                                    <td rowspan="2"  width="17%">
                                      Estimates of the end of the current year(4) 
                                      </td>
                                   
                                  </tr>
                                  <tr>
                                  </tr>
                                  <tr class="dataGrid" >
                     				<td colspan="5">Current Assets(CA)</td>
                     				</tr>
                                  <%if (hshValues != null) 
                                	 {
                                	  vecrow = (ArrayList) hshValues.get("vecData");
                                	 
                                	  if(vecrow!=null && vecrow.size()>0)
                 						{
                                		 
                 						
                   							for(int i=0;i<intyearsize;i++)
                   							{
                   							
                   							
                   							if(intyearsize<=vecrow.size())
                   								
                         					{	
                     							veccol = (ArrayList) vecrow.get(i);
                     				%>
                     				<%if(i==4) { %>
                     				 <tr class="dataGrid">
                     				<td colspan="5">Current Liabilities(CL)</td>
                     				</tr>
                     				<%} %>
                                  <tr class="dataGrid"> 
                                    <td align="left" width="14%" ><font size="2" face="MS Sans Serif"><%=stryears[i] %></font></td>
                                    <td align="center" width="22%" > 
                                      <input type="text"  name="txt_monyear1" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)veccol.get(0))))%>" size="12" 
															maxlength="12" onKeyPress="allowDecimals(this)"  onBlur="cashFlowCal(<%=i%>);"
															style="text-align:right" readOnly>
                                    </td>
                                    <td width="27%" align="center" > 
                                      <input type="text" name="txt_monyear2" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)veccol.get(1))))%>" size="12" 
															maxlength="12" onKeyPress="allowDecimals(this)"  onBlur="cashFlowCal(<%=i%>);"
															style="text-align:right" readOnly>
                                    </td>
                                    <td width="20%" align="center" > 
                                      <input type="text"
															name="txt_monyearsub" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)veccol.get(2))))%>" size="12" 
															maxlength="12" onKeyPress="allowDecimals(this)"  onBlur="cashFlowCal(<%=i%>);"
															style="text-align:right" readOnly>
                                    </td>
                                    <td width="17%" align="center" > 
                                      <input type="text"
															name="txt_monyear4" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)veccol.get(3))))%>" size="12" 
															maxlength="12" onKeyPress="allowDecimals(this)"  onBlur="cashFlowCal(<%=i%>);"
															style="text-align:right" readOnly>
                                    </td>
                                    
                                  </tr>
                                  <%}
										
										else
										{%>
										<%if(i==4) { %>
                     				 <tr class="dataGrid">
                     				<td colspan="5">Current Liabilities(CL)</td>
                     				</tr>
                     				<%} %>
										
                                  <tr class="dataGrid"> 
                                    <td align="left" width="14%" ><font size="2" face="MS Sans Serif"><%=stryears[i] %> 
                                      </font></td>
                                    <td align="center" width="22%" > 
                                      <input type="text"name="txt_monyear1"  size="12" 
															maxlength="12" onKeyPress="allowDecimals(this)"  onBlur="cashFlowCal(<%=i%>);"
															style="text-align:right" readOnly>
                                    </td>
                                    <td width="27%" align="center" > 
                                      <input type="text" name="txt_monyear2"  size="12" 
															maxlength="12" onKeyPress="allowDecimals(this)"  onBlur="cashFlowCal(<%=i%>);"
															style="text-align:right" readOnly>
                                    </td>
                                    <td width="20%" align="center" > 
                                      <input type="text"
															name="txt_monyearsub"  size="12" 
															maxlength="12" onKeyPress="allowDecimals(this)"  onBlur="cashFlowCal(<%=i%>);"
															style="text-align:right" readOnly>
                                    </td>
									 
                                    <td width="17%" align="center" > 
                                      <input type="text"
															name="txt_monyear4"  size="12" 
															maxlength="12" onKeyPress="allowDecimals(this)"  onBlur="cashFlowCal(<%=i%>);"
															style="text-align:right" readOnly>
                                    </td>
                                    
                                  </tr>
                                  <%} 
                                       }
                   							}
                                      }%>
                                </table>
												</td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								
								<tr>
						<td><br>
						<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
						</td>
					</tr>
								
								
						</table>
					
				</table>
			
			
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidsno" >
<input type="hidden" name="cbsaccno" value="<%=request.getParameter("cbsaccno")%>">
<input type="hidden" name="mon_accno" value="<%=Helper.correctNull((String)request.getParameter("mon_accno")) %>">
<input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)request.getParameter("cbsid"))%>">
<input type="hidden" name="mon_year" value="<%=Helper.correctNull((String)request.getParameter("mon_year"))%>">
<input type="hidden" name="mon_month" value="<%=Helper.correctNull((String)request.getParameter("mon_month"))%>">
<input type="hidden" name="cbsname" value="<%=Helper.correctNull((String)request.getParameter("cbsname"))%>">
<input type="hidden" name="mon_msod" value="<%=strmsod%>">
<input type="hidden" name="mon_stock" value="<%=strstock%>">
<input type="hidden" name="mon_bkdebts" value="<%=strbkdebts%>">
<input type="hidden" name="mon_qpr" value="<%=strqpr%>">


<input type="hidden" name="mon_checkqpr" value="<%=strqpr%>">
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>">


</form>
</body>
</html>


