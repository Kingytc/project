<%@include file="../share/directives.jsp"%>
<%ArrayList arrCol = new ArrayList();
ArrayList arrRow = new ArrayList();%>
<html>
<head>
<title>Document Register</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var path      ="<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varOrgLev = "<%=strOrgLevel%>";

function placevalues()
{
	if(varOrgLev != 'A')
	{
		disableCommandButtons(true,true,true,true,true,false,true);
	}
	else
	{
		disableCommandButtons(false,true,true,true,true,false,true);
	}
}

function doNew()
{
	disableFields(false);
	disableCommandButtons(true,true,false,false,false,true,true);
	document.forms[0].hidAction.value ="insert";
	document.forms[0].sel_securitytype.value ="0";
	document.forms[0].sel_securitynature.value="0";
	document.forms[0].txt_otherdetails.value="";
	document.forms[0].txt_add1.value="";
	document.forms[0].txt_add2.value="";
	document.forms[0].txt_city.value="";
	document.forms[0].txt_state.value="";
	document.forms[0].txt_pincode.value="";
	document.forms[0].txt_insuranceno.value="";
    document.forms[0].txt_valueamout.value="";
	document.forms[0].txt_valuedate.value="";
	document.forms[0].txt_valuationdoneby.value="";
	document.forms[0].txt_inspectedon.value="";
	document.forms[0].txt_inspectedby.value="";
	document.forms[0].sel_addresscheck.value="0";
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons(true,true,false,false,false,true,true);
}

function doSave()
{
	if(document.forms[0].sel_securitytype.value=="0")
	{
		ShowAlert('111','Type of security');
		document.forms[0].sel_securitytype.focus();
		return;
	}
	if(document.forms[0].sel_securitynature.value=="0")
	{
	   document.forms[0].sel_securitynature.focus();
		ShowAlert('111','Nature of security');
		return;
	}
	document.forms[0].hid_securityNature.value = document.forms[0].sel_securitynature[document.forms[0].sel_securitynature.selectedIndex].text;
	document.forms[0].hidBeanId.value="Register";
	document.forms[0].hidSourceUrl.value="/action/mon_securityregirter.jsp";
	document.forms[0].hidBeanMethod.value="updatemonSecurityregister";
	document.forms[0].hidBeanGetMethod.value="getmonSecurityregister";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanGetMethod.value="getmonSecurityregister";
		document.forms[0].hidBeanId.value="Register";
		document.forms[0].action=appURL+"action/mon_securityregirter.jsp";	
		document.forms[0].submit();
	}	
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="Delete";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="Register";
		document.forms[0].hidSourceUrl.value="/action/mon_securityregirter.jsp";
		document.forms[0].hidBeanMethod.value="updatemonSecurityregister";
		document.forms[0].hidBeanGetMethod.value="getmonSecurityregister";	
		document.forms[0].submit();
	}
}
function doMask()
{
		document.forms[0].hidAction.value ="Mask";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="Register";
		document.forms[0].hidSourceUrl.value="/action/mon_securityregirter.jsp";
		document.forms[0].hidBeanMethod.value="updatemonSecurityregister";
		document.forms[0].hidBeanGetMethod.value="getmonSecurityregister";	
		document.forms[0].submit();
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

function selectValues(val1,val22,val2, val3, val7, val8, val9,val10, val11, val12, val13, val14, val15, val16, val17,i,size,val19)
{
	document.forms[0].sel_securitytype.value =val2;
	document.forms[0].sel_securitynature.value=val3;
	document.forms[0].txt_add1.value=document.getElementById("hidaddr1"+i).value;
	document.forms[0].txt_add2.value=document.getElementById("hidaddr2"+i).value;
	document.forms[0].txt_city.value=val7;
	document.forms[0].txt_state.value=val8;
	document.forms[0].txt_pincode.value=val9;
	document.forms[0].txt_insuranceno.value=val10;
	document.forms[0].txt_valueamout.value=val11;
	document.forms[0].txt_valuedate.value=val12;
	document.forms[0].txt_valuationdoneby.value=val13;
	document.forms[0].txt_inspectedon.value=val15;
	document.forms[0].txt_inspectedby.value=val14;
	document.forms[0].sel_addresscheck.value=val16;
	document.forms[0].hidsno.value =val1;
	if(size==1)
	{
		document.forms[0].txt_otherdetails.value=document.forms[0].hidother.value;
	}
	else
	{
		document.forms[0].txt_otherdetails.value=document.forms[0].hidother[i].value;
	}
	document.forms[0].shortfallnotice.value=val19;
	if(document.forms[0].statusflag.value=="O" && document.forms[0].readFlag.value.toUpperCase()=="W")
	{
		disableCommandButtons(true,false,false,true,true,false,false);
	}
}
function disableCommandButtons(cmdnew,cmdedit,cmdsave,cmddel,cmdcancel,cmdclose,cmdmask)
{  
	 document.forms[0].cmdnew.disabled=cmdnew;
	 document.forms[0].cmdedit.disabled=cmdedit;	  
	 document.forms[0].cmdsave.disabled=cmdsave;
	 document.forms[0].cmddelete.disabled=cmddel;
	 document.forms[0].cmdcancel.disabled=cmdcancel;
	 document.forms[0].cmdclose.disabled=cmdclose;
	 document.forms[0].cmdmask.disabled=cmdmask;	
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
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=!val;
		}	 
	}	
	    document.forms[0].txt_inspectedon.readOnly=true;
		document.forms[0].txt_valuedate.readOnly=true;
		document.forms[0].txt_insuranceno.readOnly=true;
}

function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
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
function showOrgSearch1(varBranchCode,varBranchName)
{
	if(document.forms[0].cmdsave.disabled==false)
		{
		var cbsaccno = document.forms[0].cbsaccno.value;
		var varQryString = "<%=ApplicationParams.getAppUrl()%>action/serchinsuranceregister.jsp?cbsaccno="+cbsaccno;
		var title = "Organization";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes,status=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
		}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="placevalues()">
<form name="frmdocumentregister" method=post class="normal">
<lapschoice:monitortag pageid="3" />
<table width="98%" border="0" cellpadding="5" cellspacing="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td class="page_flow">Home -&gt;Monitoring-&gt;Monitoring Register -&gt; Security Details</td>
			</tr>
		</table>
		</td>
	</tr>	
	</table>
	<lapschoice:Monitor strSource="MREG"/>
		<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
					<tr>
						<td>						
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                      <tr> 
                        <td width="19%">Type of security<span class="mantatory">*&nbsp;</span></td>
                        <td width="29%"> 
                          <select name="sel_securitytype" tabindex="1">
                            <option value="0" selected>---select---</option>
                            <option value="1">Primary</option>
                            <option value="2">Collateral</option>
                          </select>
                        </td>
                        <td width="33%">Nature of security<span class="mantatory">*&nbsp;</span></td>
                        <td width="19%"> 
                          <select name="sel_securitynature" tabindex="2">
                            <option value="0">---Select-----</option>
                            <%String apptype="46"; %>
                            <lapschoice:StaticDataNewTag apptype='<%=apptype%>'/> 
                          </select>
                        </td>
                      </tr>
                      <tr> 
                        <td width="19%"><b>Location </b></td>
                        <td width="29%">&nbsp; </td>
                        <td width="33%">Other Details</td>
                        <td width="19%"> 
                          <textarea name="txt_otherdetails" tabindex="3" onKeyPress="textlimit(this,299)" onKeyUp="textlimit(this,299)" value="<%=Helper.correctNull((String)hshValues.get("limit_custid"))%>"></textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td width="19%">Address1</td>
                        <td width="29%"> 
                          <input type="text" name="txt_add1" tabindex="4" maxlength="25" value="<%=Helper.correctNull((String)hshValues.get("MONSEC_ADD1"))%>">
                        </td>
                        <td width="33%">Valuation Amount (Rs)</td>
                        <td width="19%"> <lapschoice:CurrencyTag name="txt_valueamout" tabindex="5" maxlength="15" value='<%=Helper.correctDouble((String)hshValues.get("MONSEC_VALUATAMOUNT"))%>'/> 
                        </td>
                      <tr> 
                        <td width="19%">Address2</td>
                        <td width="29%"> 
                          <input type="text" name="txt_add2" maxlength="25" tabindex="6" value="<%=Helper.correctNull((String)hshValues.get("MONSEC_ADD2"))%>">
                        </td>
                        <td width="33%">Valued Date</td>
                        <td width="19%"> 
                          <input type="text" size="13" name="txt_valuedate" value="<%=Helper.correctNull((String)hshValues.get("MONSEC_VALUATDATE"))%>" onBlur="checkDate(this);checkmaxdate(this,currentDate)">
                          <a alt="Select date from calender" href="#"
																	onClick="callCalender('txt_valuedate')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border=0 alt="Select date from calender" tabindex="7"></a> 
                        </td>
                      </tr>
                      <tr> 
                        <td width="19%">City</td>
                        <td width="29%"> 
                          <input type="text" name="txt_city" maxlength="25" tabindex="8" value="<%=Helper.correctNull((String)hshValues.get("MONSEC_CITY"))%>">
                        </td>
                        <td width="33%">Valuation Done By</td>
                        <td width="19%"> 
                          <input type="text" name="txt_valuationdoneby" tabindex="9" maxlength="50" onKeyPress="allowAlphabets()" value="<%=Helper.correctNull((String)hshValues.get("MONSEC_VALUTDONEBY"))%>">
                        </td>
                      </tr>
                      <tr> 
                        <td width="19%">State</td>
                        <td width="29%"> 
                          <input type="text" name="txt_state" maxlength="25" tabindex="10" value="<%=Helper.correctNull((String)hshValues.get("MONSEC_STATE"))%>">
                        </td>
                        <td width="33%">Last Inspected On</td>
                        <td width="19%"> 
                          <input type="text" size="13" name="txt_inspectedon" value="<%=Helper.correctNull((String)hshValues.get("MONSEC_INSPECTEDON"))%>" onBlur="checkDate(this);checkmaxdate(this,currentDate)">
                          <a alt="Select date from calender" href="#"
																	onClick="callCalender('txt_inspectedon')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border=0 alt="Select date from calender" tabindex="11"></a> 
                        </td>
                      </tr>
                      <tr> 
                        <td width="19%">Pincode</td>
                        <td width="29%"> 
                          <input type="text" name="txt_pincode" tabindex="12" maxlength="6" value="<%=Helper.correctNull((String)hshValues.get("MONSEC_PINCODE"))%>" onKeyPress="allowInteger()">
                        </td>
                        <td width="33%">Last Inspected By</td>
                        <td width="19%"> 
                          <input type="text" name="txt_inspectedby" tabindex="13" onKeyPress="allowAlphabets()" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("MONSEC_INSPECTEDBY"))%>">
                        </td>
                      </tr>
                      <tr> 
                         <input type="hidden" name="txt_insuranceno" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("MONSEC_INSURANCENO"))%>" readOnly><b>
                        <td width="33%">Whether the address in the Insurance register is same</td>
                        <td width="19%"> 
                          <select name="sel_addresscheck" tabindex="15">
                            <option value="0" selected>---select---</option>
                            <option value="1">Yes</option>
                            <option value="2">No</option>
                          </select>
                        </td>
                      </tr>
                      <tr>
                        <td width="19%">Whether any shortfall noticed if so, corrective action initiated</td>
                        <td width="29%"> 
                          <textarea name="shortfallnotice" tabindex="3" cols="70" rows="3"  onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" value="<%=Helper.correctNull((String)hshValues.get("limit_custid"))%>"></textarea>
                        </td>
                        <td width="33%">&nbsp;</td>
                        <td width="19%">&nbsp;</td>
                      </tr>
                    </table>
						</td>
					</tr>
					</table>
					<br>
					<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail_Mask' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
					<br> 
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
							<tr>
								<td>
								<table width="98.3%" border="0" cellspacing="0" cellpadding="2" class="outertable linebor">
									<tr class="dataheader">
										<td width="3%" align="center"></td>
										<td width="13%" align="center"><b>Type of security</b></td>
										<td width="14%" align="center"><b>Nature of security</b></td>
										<td width="14%" align="center"><B>Valuation Amount (Rs)</B></td>
										<td width="14%" align="center"><B> Valuation Done By</B></td>
										<td width="14%" align="center"><b>Valued Date</b></td>
										<td width="14%" align="center"><b>Insurance No</b></td>
										<td width="14%" align="center"><b>Last Inspected On</b></td>
									</tr>								
                              <%
										arrCol=new ArrayList();
										arrRow=(ArrayList)hshValues.get("arrRow");
										if(arrRow!=null && arrRow.size()>0)
										{
 							    			for(int i=0;i<arrRow.size();i++)
											{
 							    				int size=arrRow.size();
 							    				arrCol=(ArrayList)arrRow.get(i);
											//System.out.print("arrCol------>"+arrCol);
											%>	
                              <tr class="datagrid">										
                                <td width="3%" align="center"> 
                                  <input type="radio"
											style="border:none" name="radiobutton" value="radiobutton"
											onClick="javascript:selectValues(
												'<%=Helper.correctNull((String)arrCol.get(0))%>',
												'<%=Helper.correctNull((String)arrCol.get(1))%>',
												'<%=Helper.correctNull((String)arrCol.get(2))%>',
												'<%=Helper.correctNull((String)arrCol.get(3))%>',
											
												'<%=Helper.correctNull((String)arrCol.get(7))%>',
												'<%=Helper.correctNull((String)arrCol.get(8))%>',
												'<%=Helper.correctNull((String)arrCol.get(9))%>',
												'<%=Helper.correctDouble((String)arrCol.get(10))%>',
												'<%=Helper.correctNull((String)arrCol.get(11))%>',
												'<%=Helper.correctNull((String)arrCol.get(12))%>',
												'<%=Helper.correctNull((String)arrCol.get(13))%>',
												'<%=Helper.correctNull((String)arrCol.get(14))%>',
												'<%=Helper.correctNull((String)arrCol.get(15))%>',
												'<%=Helper.correctNull((String)arrCol.get(16))%>',
												'<%=Helper.correctNull((String)arrCol.get(17))%>','<%=i%>','<%=size%>','<%=Helper.replaceForJavaScriptString((String)arrCol.get(19))%>')">
											<input type="hidden" name="hidother" value="<%=Helper.correctNull((String)arrCol.get(4))%>">
											<input type="hidden" name="hidaddr1<%=i%>" value="<%=Helper.correctNull((String)arrCol.get(5))%>">
											<input type="hidden" name="hidaddr2<%=i%>" value="<%=Helper.correctNull((String)arrCol.get(6))%>">
                                          </td>                                          
                                          <%String strsecurity=Helper.correctNull((String)arrCol.get(2));
                                          String strsecutype="";
                                          if(strsecurity.equalsIgnoreCase("1"))
                                          {
                                        	  strsecutype="Primary";
                                          }
                                          else if(strsecurity.equalsIgnoreCase("2"))
                                          {
                                        	  strsecutype="Collateral";
                                          }
                                          else
                                          {
                                        	  strsecutype="";
                                          }%>										
                                <td width="13%" >&nbsp;<%=strsecutype%></td>										
                                <td width="14%" >&nbsp;<%=Helper.correctNull((String)arrCol.get(17))%></td>										
                                <td width="14%" >&nbsp;<%=Helper.correctNull((String)arrCol.get(11))%></td>										
                                <td width="14%" >&nbsp;<%=Helper.correctNull((String)arrCol.get(13))%></td>										
                                <td width="14%" >&nbsp;<%=Helper.correctNull((String)arrCol.get(12))%></td>										
                                <td width="14%" >&nbsp;<%=Helper.correctNull((String)arrCol.get(10))%></td>										
                                <td width="14%" >&nbsp;<%=Helper.correctNull((String)arrCol.get(15))%></td>
									</tr>
									<%}}%>
									<tr class="datagrid">										
                                <td width="3%" align="center">&nbsp;</td>										
                                <td width="13%" >&nbsp;</td>										
                                <td width="14%" >&nbsp;</td>										
                                <td width="14%" >&nbsp;</td>										
                                <td width="14%" >&nbsp;</td>										
                                <td width="14%" >&nbsp;</td>										
                                <td width="14%" >&nbsp;</td>										
                                <td width="14%" >&nbsp;</td>
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
<input type="hidden" name="hid_securityNature">
<input type="hidden" name="hidkeyid" value="<%=Helper.correctNull((String)hshValues.get("cbsaccno")) %>">
</form>
</body>
</html>
