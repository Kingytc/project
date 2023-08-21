<%@ include file="../share/directives.jsp"%>
<%@ page import="java.util.ArrayList" %>
<%
ArrayList vecRow=(ArrayList)hshValues.get("vecRow");
ArrayList vecCol=new ArrayList();	
%>

<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/link.css" type="text/css"/>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
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
	if(val=="disabled")
	{	 
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}  
}
function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9)
{
	document.forms[0].hid_strsno.value=val1;
	document.forms[0].sel_security.value=val2;
	document.forms[0].txt_nature.value=val3;
	document.forms[0].txt_renew_valuedate.value=val4;
	document.forms[0].txt_renew_valueamount.value=val5;
	document.forms[0].txt_present_valuedate.value=val6;
	document.forms[0].txt_present_valueamount.value=val7;
	document.forms[0].txt_present_inspecdate.value=val8;
	document.forms[0].txt_present_inspecby.value=val9;
	if(document.forms[0].readFlag.value.toUpperCase()=="W")
	{
 disableCommandButtons("radioselect");
//disableCommandButtons("disabled");
	}
}
function doNew()
{
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");
	document.forms[0].sel_security.focus();	
	
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");	
	document.forms[0].sel_security.focus();
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value="";
		document.forms[0].hidSourceUrl.value="/action/prudential_securities.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getSecurities";
		document.forms[0].hidBeanMethod.value="updateSecurities";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit(); 		
	}	
}

function doSave()
{
	if(document.forms[0].sel_security.value=="0")
	{
		ShowAlert('111', 'Type of Security');
		return;
	}
	if(document.forms[0].txt_present_valuedate.value=="")
	{
		alert("Enter the Valuation Date");
		document.forms[0].txt_present_valuedate.focus();
		return;
	}
	if(document.forms[0].txt_present_valueamount.value=="")
	{
		alert("Enter the Valuation Amount");
		document.forms[0].txt_present_valueamount.focus();
		return;
	}
	if(document.forms[0].txt_present_inspecdate.value=="")
	{
		alert("Enter the inspection Date");
		document.forms[0].txt_present_inspecdate.focus();
		return;
	}
	if(document.forms[0].txt_present_inspecby.value=="")
	{
		alert("Enter Inspected By");
		document.forms[0].txt_present_inspecby.focus();
		return;
	}
		document.forms[0].hidSourceUrl.value="/action/prudential_securities.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updateSecurities";
		document.forms[0].hidBeanGetMethod.value="getSecurities";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/prudential_securities.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updateSecurities";
		document.forms[0].hidBeanGetMethod.value="getSecurities";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
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
			document.forms[0].elements[i].disabled=(!val);
		}		  
		 
	}
	document.forms[0].txt_renew_valuedate.readOnly=true;	
}
function callLink(page,bean,method)
	{
	if (document.forms[0].cmdsave.disabled)
			{
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

function onLoading()
{		
		disableCommandButtons("load");
		disableFields(true);
}
function doClose()
	{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/npa_mainlinknav.jsp";
		document.forms[0].submit();
		
	}
}	
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);		
	}
}
</script>
</head>
<body onload="onLoading()">

<form name="prudential_securities" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
				<tr>
					<td>
						<lapstab:pwourltag pageid="4"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
           <td valign="top" colspan=5 class="page_flow">Home 
				-&gt; NPA-&gt; Prudential Write Off -&gt;Securities  
          </tr>
        </table>
 <table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><lapschoice:npaapplication />
		<INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" />
		</td>
	</tr>
</table>
<lapstab:npapresentpostion
	module='<%=Helper.correctNull((String)request.getParameter("hidmoduletype"))%>'
	pageid="2" />
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
    <tr> 
      <td> 
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
	<tr> 
		<td> 
  			<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
    			<tr> 
      				<td width="14%">TYPE OF SECURITY<span class="mantatory">*&nbsp;</span>
      				</td>
      				<td width="43%"> 
        				<select  name="sel_security" tabindex="1" >
          					<option value="S">--SELECT--</option>
          					<option value="P">PRIMARY</option>
          					<option value="C">COLLATERAL</option>
        				</select>
      				</td>
      				<td width="13%">NATURE OF SECURITY</td>
				    <td width="3%">&nbsp;</td>
				    <td width="27%"> 
				    	<input type="text" name="txt_nature" size="25" maxlength="35" tabindex="2">
				    </td>
    			</tr>
    			<tr> 
      				<td colspan="4" align="left"><b>AT THE TIME OF RENEWAL </b></td>
    			</tr>
    			<tr> 
      				<td width="14%">VALUATION DATE</td>
      				<td width="43%"> 
        				<table width="25%" class="outertable">
      						<tr>
      							<td>
      								<input type="text" name="txt_renew_valuedate" size="12" maxlength="10"  tabindex="3"
      								onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')">
								</td>
								<td>
        							<a href="#" onClick="callCalender('txt_renew_valuedate')"
									title="Click to view calender" border=0>
									<img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0" tabindex="3"></a> 
								</td>
							</tr>
						</table>
					</td>
      				<td width="13%">VALUATION AMOUNT</td>
      				<td width="3%"><b><%=ApplicationParams.getCurrency()%></b></td>
      				<td width="27%"> <lapschoice:CurrencyTag name="txt_renew_valueamount" size="16"
							maxlength="12" tabindex="4" value=''/> </td>
    			</tr>
    			<tr> 
			   		<td colspan="4" align="left"><b>PRESENT POSITION</b></td>
			    </tr>
			    <tr> 
			    	<td width="14%" >VALUATION DATE<span class="mantatory">*&nbsp;</span>
			    	</td>
			      	<td width="43%" > 
			        	<table width="25%" class="outertable">
			      			<tr>
			      				 <td>
			      					<input type="text" name="txt_present_valuedate" size="12" maxlength="10" tabindex="5" 
									onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')">
								</td> 
								 <td>		
			        				<a href="#" onClick="callCalender('txt_present_valuedate')"
									title="Click to view calender" border=0>
									<img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0" tabindex="5"></a> 
								</td>
							</tr>
						</table>
      				<td width="13%" >VALUATION AMOUNT<span class="mantatory">*&nbsp;</span>
      				</td>
      				<td width="3%"><b><%=ApplicationParams.getCurrency()%></b></td>
      				<td width="27%" > 
      					<lapschoice:CurrencyTag name="txt_present_valueamount" size="16" maxlength="12" tabindex="6" value=''/> 
      				</td>
    			</tr>
    			<tr> 
			      <td width="14%"> INSPECTION DATE <span class="mantatory">*&nbsp;</span>
			      </td>
			      <td width="43%" > 
			      	<table width="25%" class="outertable">
			      		<tr>
			      			<td>
			      				<input type="text" name="txt_present_inspecdate" size="12" maxlength="10" tabindex="7" 
									onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')">
							</td>
							<td>
			        			<a href="#" onClick="callCalender('txt_present_inspecdate')"
								title="Click to view calender" border=0>
								<img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
								width="0" border="0" tabindex="7"></a> 
							</td>
						</tr>
					</table>
				</td>
      			<td width="13%" > INSPECTED BY<span class="mantatory">*&nbsp;</span>
      			</td>
      			<td width="3%">&nbsp;</td>
      			<td width="27%" > 
        			<input type="text" name="txt_present_inspecby" size="25" onKeyPress="notAllowSplChar()"
						maxlength="35" tabindex="8">
      			</td>
    		</tr>
  		</table>
  	</td>
  </tr>
 </table>
 </td>
 </tr>
 </table><br>
 <lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Audit Trial"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'	 />
 <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
  	<tr align="center"> 
    	<td colspan="2"> 
        	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
        		<tr>
                	<td>
	                	<table width="98.3%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
                  			<tr class="dataheader">
                  	         	<td width="4%"  rowspan="2">&nbsp;</td>
                    			<td width="10%"  align="center" rowspan="2"><b>TYPE OF SECURITY</b></td>
                    			<td width="18%"  align="center" rowspan="2"><b>NATURE</b></td>
                    			<td colspan="2"  align="center"><b>AT THE TIME OF RENEWAL</b></td>
                    			<td colspan="4"  align="center"><b>PRESENT POSITION</b></td>
                  			</tr>
                  			<tr class="dataheader"> 
                     			<td width="10%"  align="center"><b>VALUED DATE</b></td>
                      			<td width="11%"  align="center"><b> VALUATION AMOUNT (RS.)</b></td>
                      			<td width="10%"  align="center"> <b> VALUED DATE</b></td>
                      			<td width="11%"  align="center"><b>VALUATION AMOUNT (RS.)</b></td>
                    			<td width="10%"  align="center"><b>INSPECTION DATE</b></td>
                    			<td width="15%"  align="center"><b>INSPECTED BY</b></td>
                  			</tr>
                  <%
                  vecRow=(ArrayList)hshValues.get("vecRow");
					if(vecRow.size()>0 && vecRow!=null)
					{
						for(int i=0;i<vecRow.size();i++)
						{
						vecCol = (ArrayList)vecRow.get(i);
					%>
                  		<tr class="datagrid"> 
                    		<td width="4%" align=center>
                      			<input type="radio" 
													style="border:none" name="radiobutton" value="radiobutton"
													onClick="selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
													'<%=Helper.correctNull((String)vecCol.get(1))%>',
													'<%=Helper.correctNull((String)vecCol.get(2))%>',
													'<%=Helper.correctNull((String)vecCol.get(3))%>',
													'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(4))))%>',
                            						'<%=Helper.correctNull((String)vecCol.get(5))%>',
                            						'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(6))))%>',
                            						'<%=Helper.correctNull((String)vecCol.get(7))%>',
                            						'<%=Helper.correctNull((String)vecCol.get(8))%>')">
                      			</td>
                    <%
					  String security=Helper.correctNull((String)vecCol.get(1));
					  if(security.equalsIgnoreCase("p"))
					  {
						  security="PRIMARY";
					  }
					  else if(security.equalsIgnoreCase("c"))
					  {
						  security="COLLATERAL";
					  }
					  %>
                    <td width="10%">&nbsp;<%=security%></td>
                    <td width="18%">&nbsp;<%=Helper.correctNull((String)vecCol.get(2))%></td>
                    <td width="10%">&nbsp;<%=Helper.correctNull((String)vecCol.get(3))%></td>
                    <td width="11%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(4))))%></td>
                    <td width="10%">&nbsp;<%=Helper.correctNull((String)vecCol.get(5))%></td>
                    <td width="11%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(6))))%></td>
                    <td width="10%">&nbsp;<%=Helper.correctNull((String)vecCol.get(7))%></td>
                    <td width="15%">&nbsp;<%=Helper.correctNull((String)vecCol.get(8))%></td>
                  </tr>
                  <%
					 }
					 }
				  	else
                	{
               %>
                  <tr class="datagrid"> 
                    <td align="center" colspan="11">No 
                      Data Found</td>
                  </tr>
                  <%
                	}
                %>
                </table>
            </td>
          </tr>
        </table>
    </td>
  </tr>
  </table>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
  <input type="hidden" name="hid_strsno" value="<%=Helper.correctNull((String)hshValues.get("SECU_SNO"))%>"/>
  <input type="hidden" name="hidclaimsettled" value="<%=Helper.correctNull((String)request.getParameter("hidclaimsettled"))%>"/>
</form>
</body>
</html>