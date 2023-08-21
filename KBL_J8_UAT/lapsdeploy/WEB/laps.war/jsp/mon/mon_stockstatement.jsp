<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);
String type[]=null;
if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			ArrayList arrCol = new ArrayList();
			ArrayList arrRow = new ArrayList();
			arrCol=new ArrayList();
			if(hshValues!=null) {
			arrRow=(ArrayList)hshValues.get("vecRow");
			type=new String[arrRow.size()];
			if(arrRow!=null && arrRow.size()>0)
			{
				
	    			for(int i=0;i<arrRow.size();i++)
				{
	    			arrCol=(ArrayList)arrRow.get(i);
					type[i]=Helper.correctNull((String)arrCol.get(9));

					
				}
	    			
			}
			}	
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
<title>Stock Statement</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var path      ="<%=ApplicationParams.getAppUrl()%>";
function placevalues()
{
	disableCommandButtons("load");
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
	if(document.forms[0].sel_stocktype.value != "" && document.forms[0].sel_stocktype.value != 0)
	{
		document.forms[0].hidBeanId.value="Register";
		document.forms[0].hidSourceUrl.value="/action/mon_stockstatement.jsp";
		document.forms[0].hidBeanMethod.value="updateStockStatement";
		document.forms[0].hidBeanGetMethod.value="getStockStatement";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
	else
	{
		alert("Please Select Type");
	}
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getStockStatement";
		document.forms[0].hidBeanId.value="Register";
		document.forms[0].action=appURL+"action/mon_stockstatement.jsp";	
		document.forms[0].submit();
	}	
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
	document.forms[0].sel_stocktype.disabled=false;
	document.forms[0].hidAction.value="delete";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="Register";
	document.forms[0].hidSourceUrl.value="/action/mon_stockstatement.jsp";
	document.forms[0].hidBeanMethod.value="updateStockStatement";
	document.forms[0].hidBeanGetMethod.value="getStockStatement";	
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

function selectValues(val1, val2, val3, val4, val5, val6, val7, val8, val9)
{
   	document.forms[0].hidsno.value =val1;
	document.forms[0].txt_accountno.value =val2;
	document.forms[0].sel_stocktype.value=val3;
	document.forms[0].txt_matdesc.value=val4;
	document.forms[0].txt_storplace.value=val5;
	document.forms[0].txt_packageno.value=val6;
	document.forms[0].txt_quantity.value=val7;
	document.forms[0].txt_rate.value=val8;
	document.forms[0].txt_value.value=val9;
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
	 showCal(appURL,fname);
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


function check() {
	var c=document.forms[0].sel_stocktype.value;
	var type1=new Array();
	

<%
	for(int j=0;j<type.length;j++) {%>
		type1[<%=j%>]=<%=type[j]%>;

			if(c==type1[<%=j%>]) {
				alert("already stored ple select any other");
				document.forms[0].sel_stocktype.value="";
			}
		
	<%}%>

}




</script>
<style>
Div.cellcontainer
{
	height:150px;
	overflow:auto;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
					<td class="Page_Flow">Home -&gt; Monitoring-&gt; 
  Monthly Monitoring -&gt;Accountwise Details -&gt;MSOD -&gt;Stock Statement</td>
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
            <td width="20%" id="prin"  class="sub_tab_inactive" ><b><a href="javascript:call_page('mon_accountwisedetails.jsp','getAccountwise')" >Account-Wise Details</a></b> </td>
            <%if(Helper.correctNull((String)hshValues.get("mon_msod")).equalsIgnoreCase("y"))
		 				 {%>
            <td width="20%"  align="center"  class="sub_tab_active"  id="prin"><b>MSOD
               </b></td>
                <%} 
              if(Helper.correctNull((String)hshValues.get("mon_qpr")).equalsIgnoreCase("y")){%>
            <td width="20%"  align="center"  class="sub_tab_inactive"  id="prin"><b><a href="javascript:call_page('mon_qprperformance.jsp','getQprPerformance')" >QPR
              </a></b></td>
             <%}
		  %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  
<lapschoice:MonMSODTag msod='<%=strmsod%>' stock='<%=strstock%>' bookdebts='<%=strbkdebts%>' pageid="3"/>
						<lapschoice:Monitor strSource="MMR"/>
<table width="100%" border="0" cellpadding="5" cellspacing="0"
	class="outertable border1">
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
                      
                      <tr> 
                        <td align="left" width="18%" height="33">Type</td>
                        <td align="left" width="34%" height="33"> 
                          <select name="sel_stocktype" onchange="check()">
                            <option value="0">--select--</option>
                            <%String apptype = "39";%>
                            <lapschoice:StaticDataNewTag apptype='<%=apptype%>'/> 
                          </select>
                        </td>
                        <td align="left" colspan="2" height="33">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td align="left" width="14%">Description of Materials</td>
                        <td align="left" width="34%"> 
                          <input type="text"
									name="txt_matdesc" onKeyPress="notAllowSplChar()"
									 maxlength="20">
                        </td>
                        <td align="left" width="18%">Place of Storage</td>
                        <td align="left" width="34%"> 
                          <input type="text"
									name="txt_storplace" onKeyPress="notAllowSplChar()"
									 maxlength="20">
                        </td>
                      </tr>
                      <tr> 
                        <td align="left" width="14%">No. of Package</td>
                        <td align="left" width="34%"> 
                          <input type="text"
									name="txt_packageno" onKeyPress="allowInteger()"
									 maxlength="10">
                        </td>
                        <td align="left" width="18%">Quantity</td>
                        <td align="left" width="34%"> 
                          <input type="text"
									name="txt_quantity" onKeyPress="allowInteger()"
									 maxlength="10">
                        </td>
                      </tr>
                      <tr> 
                        <td align="left" width="14%">Rate</td>
                        <td align="left" width="34%"> 
                          <lapschoice:CurrencyTag
									name="txt_rate" onKeyPress="allowInteger()"
									 maxlength="15"/>
                        </td>
                        <td align="left" width="18%">Value</td>
                        <td align="left" width="34%"> 
                          <lapschoice:CurrencyTag
									name="txt_value" onKeyPress="allowInteger()"
									 maxlength="15"/>
                        </td>
                      </tr>
                    </table>
						</td>
					</tr>
					<tr>
						<td>
						<br>
						<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
						</td>
					</tr>
					<br>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="0"
							class="outertable ">
							<tr>

								<td>

								<table width="100%" border="0" cellspacing="1" cellpadding="2"
									class="outertable linebor">
									<tr class="dataHeader">
										<td width="3%" align="center">&nbsp;</td>
										
                              <td width="13%" align="center"><b>Type</b></td>
										
                              <td width="14%" align="center"><b>Description 
                                of Materials</b></td>
										
                              <td width="14%" align="center"><B>Place 
                                of Storage</B></td>
										
                              <td width="14%" align="center"><B> No. of 
                                Package </B></td>
										
                              <td width="14%" align="center"><b> Quantity</b></td>
										
                              <td width="14%" align="center"><b>Rate</b></td>
										
                              <td width="14%" align="center"><b>Value</b></td>
									</tr>
								</table>

								</td>
							</tr>
							<tr>
								<td>
								<div class="cellcontainer">

								
                            <table width="100%" border="0" cellspacing="1" cellpadding="2"
									class="outertable">
                              <%     double dblTotcost1=0.00;
										arrCol=new ArrayList();
										arrRow=(ArrayList)hshValues.get("vecRow");
										if(arrRow!=null && arrRow.size()>0)
										{
											//type=new String[arrRow.size()];
 							    			for(int i=0;i<arrRow.size();i++)
											{
 							    			arrCol=(ArrayList)arrRow.get(i);
											dblTotcost1 = dblTotcost1+Double.parseDouble(Helper.correctDouble((String)arrCol.get(8)));	
											//type[i]=Helper.correctNull((String)arrCol.get(3));
											
									%>
									
									
                              <tr class="dataGrid">
										
                                <td width="3%" align="center"> 
                                  <input type="radio"
											style="border:none" name="radiobutton" value="radiobutton"
											onClick="javascript:selectValues(
												'<%=Helper.correctNull((String)arrCol.get(0))%>',
												'<%=Helper.correctNull((String)arrCol.get(1))%>',
												'<%=Helper.correctNull((String)arrCol.get(9))%>',
												'<%=Helper.correctNull((String)arrCol.get(3))%>',
												'<%=Helper.correctNull((String)arrCol.get(4))%>',
												'<%=Helper.correctNull((String)arrCol.get(5))%>',
												'<%=Helper.correctNull((String)arrCol.get(6))%>',
												'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7))))%>',
												'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(8))))%>'
												)">
											
                                          </td>
										
                                <td width="13%" align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(2))%></td>
										
                                <td width="14%" align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(3))%></td>
										
                                <td width="14%" align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%></td>
										
                                <td width="14%" align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(5))%></td>
										
                                <td width="14%" align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(6))%></td>
										
                                <td width="14%" align="left">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7))))%></td>
										
                                <td width="14%" align="left">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(8))))%></td>
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
										
                                <td width="14%" align="left">&nbsp;</td>
										
                                <td width="14%" align="left">&nbsp;Total</td>
										
                                <td width="14%" align="left">&nbsp;<%=Helper.formatDoubleValue(dblTotcost1) %></td>
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
		</td>
</table>
			<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidsno" >
<input type="hidden" name="mon_accno" value="<%=Helper.correctNull((String)request.getParameter("mon_accno")) %>">
<input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)request.getParameter("cbsid"))%>">
<input type="hidden" name="mon_year" value="<%=Helper.correctNull((String)request.getParameter("mon_year"))%>">
<input type="hidden" name="mon_month" value="<%=Helper.correctNull((String)request.getParameter("mon_month"))%>">
<input type="hidden" name="cbsname" value="<%=Helper.correctNull((String)request.getParameter("cbsname"))%>">
<input type="hidden" name="txt_accountno">
<input type="hidden" name="mon_msod" value="<%=strmsod%>">
<input type="hidden" name="mon_stock" value="<%=strstock%>">
<input type="hidden" name="mon_bkdebts" value="<%=strbkdebts%>">


<input type="hidden" name="mon_qpr" value="<%=strqpr%>">
</form>
</body>
</html>
