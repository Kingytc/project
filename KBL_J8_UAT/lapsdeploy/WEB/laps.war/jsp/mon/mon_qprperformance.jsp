<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);

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
	strmsod=Helper.correctNull((String)hshValues.get("mon_checkmsod"));
}			
String strstock=Helper.correctNull((String)request.getParameter("mon_stock"));
if(strstock.equalsIgnoreCase(""))
{
	strstock=Helper.correctNull((String)hshValues.get("mon_checkstock"));
}
String strbkdebts=Helper.correctNull((String)request.getParameter("mon_bkdebts"));
if(strbkdebts.equalsIgnoreCase(""))
{
	strbkdebts=Helper.correctNull((String)hshValues.get("mon_checkbkdebts"));
}
String strqpr=Helper.correctNull((String)request.getParameter("mon_qpr"));
if(strqpr.equalsIgnoreCase(""))
{
	strqpr=Helper.correctNull((String)hshValues.get("mon_checkqpr"));
}

%>

<html>
<head>
<title>Document Recovered</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var path   ="<%=ApplicationParams.getAppUrl()%>";

function placevalues()
{
	disableCommandButtons("load");
	document.forms[0].txt_monproachieve.readOnly = true;
	document.forms[0].txt_mondomachieve.readOnly = true;
	document.forms[0].txt_monexpachieve.readOnly = true;
}


function add()
 {
 	var t1=0;
 	
 	if(document.forms[0].txt_monproann.value == ""){
 		alert("Please enter Production(Quantity)");
 		document.forms[0].txt_monproann.value=t1;
 	}
 	if(document.forms[0].txt_monprocum.value == ""){
 		alert("Please enter Production(Quantity)");
 		document.forms[0].txt_monprocum.value=t1;
 	}
 	
	if(document.forms[0].txt_monproann.value != "" && document.forms[0].txt_monprocum.value != "") 
	{
    	var a1 = eval(document.forms[0].txt_monproann.value);
		var a3 = eval(document.forms[0].txt_monprocum.value);	
		if(a1!=0.00) {	
		var a4=eval(a3/a1*100);
		}
		document.forms[0].txt_monproachieve.value=NanNumber(a4);	
		//roundtxt(document.forms[0].txt_monproachieve);
	}
	
	roundtxt(document.forms[0].txt_monproachieve);
	
}

function add1() {
	if(document.forms[0].txt_monprodomann.value != "" && document.forms[0].txt_mondomcum.value != "" ) {
    	var a1 = eval(document.forms[0].txt_monprodomann.value);
		var a3 =eval(document.forms[0].txt_mondomcum.value);
		if(a1!=0.00) {	
		var a4= eval(a3/a1*100);
		}
		document.forms[0].txt_mondomachieve.value=NanNumber(a4);	
		//roundtxt(document.forms[0].txt_mondomachieve.value);
	}
	roundtxt(document.forms[0].txt_mondomachieve);
	
}
function add2() {
	if(document.forms[0].txt_monexpann.value != "" && document.forms[0].txt_monexpcum.value != "") {
    	var a1 = eval(document.forms[0].txt_monexpann.value);
		var a3 = eval(document.forms[0].txt_monexpcum.value);	
		if(a1!=0.00){
		var a4= eval(a3/a1*100);
		}
		document.forms[0].txt_monexpachieve.value=NanNumber(a4);	
		//roundtxt(document.forms[0].txt_monexpachieve.value);
	}
	roundtxt(document.forms[0].txt_monexpachieve);
	
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
	document.forms[0].txt_monproachieve.readOnly = true;	
	document.forms[0].txt_mondomachieve.readOnly = true;
	document.forms[0].txt_monexpachieve.readOnly = true;
}

function doSave()
{
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="mmrcommon";
	document.forms[0].hidSourceUrl.value="/action/mon_qprperformance.jsp";
	document.forms[0].hidBeanMethod.value="updateQprPerformance";
	document.forms[0].hidBeanGetMethod.value="getQprPerformance";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
		{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";		
		document.forms[0].hidBeanMethod.value="updateQprPerformance";
		document.forms[0].hidBeanGetMethod.value="getQprPerformance";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidSourceUrl.value="action/mon_qprperformance.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
		}
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getQprPerformance";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].action=appURL+"action/mon_qprperformance.jsp";	
		document.forms[0].submit();
	}	
}

function callDelete()
{
	if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value="delete";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="mmrcommon";
	document.forms[0].hidSourceUrl.value="/action/mon_qprperformance.jsp";
	document.forms[0].hidBeanMethod.value="updateQprPerformance";
	document.forms[0].hidBeanGetMethod.value="getQprPerformance";	
	document.forms[0].submit();
	}
}

function callClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}



function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
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
	
}  
	
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	  
		
		
	}
	//document.forms[0].txt_monproachieve.readOnly=true;
	//document.forms[0].txt_mondomachieve.readOnly=true;
	//document.forms[0].txt_monexpachieve.readOnly=true;
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

	if(url=="mon_qprperformance.jsp")
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



</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="placevalues()">
<form name="frmstock" method=post class="normal">
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
						 Home -&gt;Monitoring -&gt; Monthly Monitoring -&gt;QPR-&gt;QPR--Performance
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

						<lapschoice:MonthlyMonitor />



<!-- add new -->
 <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
    <tr> 
      <td valign="bottom"> 
        <table width="60%" border="0" cellspacing="1" cellpadding="3" align="left" class="outertable">
          <tr> 
            <td width="20%"  class="sub_tab_inactive" align="center"   id="prin" ><b><a href="javascript:call_page('mon_accountwisedetails.jsp','getAccountwise')" >Account-Wise Details</a></b> </td>
            <%if(strmsod.equalsIgnoreCase("y"))
		 				 {%>
            <td width="20%"  class="sub_tab_inactive" align="center"  id="prin"><b><a href="javascript:call_page('mon_msodestimates.jsp','getmsodestimate')" >MSOD</a>
             </b></td>
             <%} 
              if(strqpr.equalsIgnoreCase("y")){%>
            <td width="20%" class="sub_tab_active" align="center"  id="prin"><b><a href="javascript:call_page('mon_qprperformance.jsp','getQprPerformance')" >QPR
              </a></b></td>
              <%}

		  %>
          </tr>
        </table>
      </td>
    </tr>
   </table>
						<lapschoice:MonQPRTag  pageid="1"/>
						<lapschoice:Monitor strSource="MMR"/>

<!-- end -->




		</td>
	</tr>
	<tr>
	<td>
	
</td>
</tr> 
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2"
			class="outertable border1">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td>
						
                    <table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
                      <tr class="dataHeader"> 
                        <td width="12%">Activity </td>
                        <td width="13%">Annual Plan(1) </td>
						 
                        <td width="13%">Current Year(2) </td>
						  
                        <td width="15%">Cumulative upto quarter ending(3)</td>
						   
                        <td width="14%"> 
                          <p>% of achievement</p>
                          <p>(3)/(1)*100</p>
                        </td>
						
                       
                      </tr>
                      <tr> 
                        <td align="left" width="12%" height="33">Production(Quantity)</td>
                        <td align="left" width="13%" height="33"> 
                          <input type="text"  name="txt_monproann" maxlength="15" style="text-align:right" onKeyPress="allowNumber(document.forms[0].txt_monproann)" onBlur="add()" value="<%=Helper.correctNull((String)hshValues.get("mon_qprproann"))%>" >
                        </td>
                        <td align="left" height="33" width="13%"> 
                          <input type="text"  name="txt_monprocurrent" maxlength="15" style="text-align:right" onKeyPress="allowNumber(document.forms[0].txt_monprocurrent)" value="<%=Helper.correctNull((String)hshValues.get("mon_qprprocurrent"))%>" >
                        </td>
						<td align="left" height="33" width="13%"> 
                          <input type="text"  name="txt_monprocum" maxlength="15" style="text-align:right" onKeyPress="allowNumber(document.forms[0].txt_monprocum)" onBlur="add()" value="<%=Helper.correctNull((String)hshValues.get("mon_qprprocum"))%>" >
                        </td>
						<%
						double dblqprproachieve=Double.parseDouble(Helper.correctDouble((String)hshValues.get("mon_qprproachieve")));
						%>
						<td align="left" height="33" width="13%"> 
                          <input type="text"  name="txt_monproachieve" maxlength="15" onKeyPress="allowNumber(document.forms[0].txt_monproachieve)"  value="<%=nf.format(dblqprproachieve)%>" >
                        </td>
                      </tr>
                      <tr> 
                        <td align="left" width="12%">NET SALES</td>
                        <td align="left" width="13%">&nbsp; </td>
                        <td align="left" width="13%">&nbsp; </td>
						 
                        <td align="left" width="13%">&nbsp; </td>
						 
                        <td align="left" width="13%">&nbsp; </td>
                        
                      </tr>
                      <tr> 
                        <td align="left" width="12%">a)Domestic</td>
                        <td align="left" width="13%"> 
                          <lapschoice:CurrencyTag name="txt_monprodomann" onBlur="add1()" value='<%=Helper.correctNull((String)hshValues.get("mon_qprdomann"))%>' maxlength="15" />
                        </td>
                        <td align="left" width="13%"> 
                          <lapschoice:CurrencyTag name="txt_mondomcurrent" value='<%=Helper.correctNull((String)hshValues.get("mon_qprdomcurrent"))%>' maxlength="15"/>
                        </td>
						 <td align="left" width="13%"> 
                          <lapschoice:CurrencyTag name="txt_mondomcum" onBlur="add1()" value='<%=Helper.correctNull((String)hshValues.get("mon_qprdomcum"))%>' maxlength="15"/>
                        </td>
                        <%
                        double dblqprdomachieve=Double.parseDouble(Helper.correctDouble((String)hshValues.get("mon_qprdomachieve")));
						%>
						 <td align="left" width="13%"> 
                          <input type="text" name="txt_mondomachieve" value="<%=nf.format(dblqprdomachieve)%>" maxlength="15">
                        </td>
                      
                      </tr>
                      <tr> 
                        <td align="left" width="12%">b)Exports</td>
                        <td align="left" width="13%"> 
                          <lapschoice:CurrencyTag name="txt_monexpann" onBlur="add2()" value='<%=Helper.correctNull((String)hshValues.get("mon_qprexpann"))%>' maxlength="15"/>
                        </td>
                        <td align="left" width="13%">
                          <lapschoice:CurrencyTag name="txt_monexpcurrent" value='<%=Helper.correctNull((String)hshValues.get("mon_qprexpcurrent"))%>' maxlength="15"/>
                        </td>
						<td align="left" width="13%">
                          <lapschoice:CurrencyTag name="txt_monexpcum" onBlur="add2()" value='<%=Helper.correctNull((String)hshValues.get("mon_qprexpcum"))%>' maxlength="15"/>
                        </td>
                        <%
                        double dblqprexpachieve=Double.parseDouble(Helper.correctDouble((String)hshValues.get("mon_qprexpachieve")));
						%>
						<td align="left" width="13%">
                          <input type="text" name="txt_monexpachieve" value="<%=nf.format(dblqprexpachieve)%>" maxlength="15">
                        </td>
                        
                      </tr>
                    </table>
						</td>
					</tr>
					<tr>
						<td><br>
						<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
	
						</td>
					</tr>
					<br>
					
					<tr>
					
						
                  <td>&nbsp; </td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
</table>
	<lapschoice:hiddentag pageid='<%=PageId%>'/> 
						
<input type="hidden" name="hidsno" >
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
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>">
</form>
</body>
</html>
