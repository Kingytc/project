<%@include file="../share/directives.jsp"%>
<%
java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);
	ArrayList arrayrow	=	null;
	ArrayList arraycol	=	null;
	String opt			= 	null;
	opt=Helper.correctNull((String)hshValues.get("liab_option"));	
	%>
<html>
<head>
<title>LIABILITIES</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var opt="<%=opt%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/agrpage.jsp";
		document.forms[0].submit();
	}
}
	function callLink(page,bean,method)
{
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appURL+"action/"+page;
	document.forms[0].submit();
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
	document.forms[0].txt_unsec[2].readOnly=true;
	document.forms[0].txt_sec[2].readOnly=true;
	document.forms[0].txt_total[0].readOnly=true;
	document.forms[0].txt_total[1].readOnly=true; 	
	document.forms[0].txt_total[2].readOnly=true;
}
function doDelete()
{	
	if(varRecordFlag == "Y"){
	if( ConfirmMsg(101))
	{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanMethod.value="updateADVLiabilities";
		document.forms[0].hidBeanGetMethod.value="getADVLiabilities";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidSourceUrl.value="/action/adv_liabilities.jsp";	
		document.forms[0].action=appURL+"action/controllerServlet";	
		document.forms[0].submit();	
	} 
	}
}
function doEdit()
{
 	disableFields(false);
	document.forms[0].hidAction.value ="update"; 
	document.forms[0].hideditflag.value="Y";
	document.forms[0].sel_guarantee.focus();
	enableButtons(true, false, false, false, true);
}
function doSave()
{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidRecordflag.value = varRecordFlag;
	document.forms[0].hidBeanMethod.value="updateADVLiabilities";
	document.forms[0].hidBeanGetMethod.value="getADVLiabilities";
	document.forms[0].hidBeanId.value="ADV1151";
	document.forms[0].hidSourceUrl.value="/action/adv_liabilities.jsp";	
	document.forms[0].action=appURL+"action/controllerServlet";
	document.forms[0].submit();
}
function selguarantee()
{
	document.forms[0].hidBeanGetMethod.value="getADVLiabilities";
	document.forms[0].hidBeanId.value="ADV1151";
	document.forms[0].hidSourceUrl.value="/action/adv_liabilities.jsp";	
	document.forms[0].submit();
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="cancel"; 
		document.forms[0].hidSourceUrl.value="/action/adv_liabilities.jsp";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidBeanGetMethod.value="getADVLiabilities";
		document.forms[0].action=appURL+"action/controllerservlet";
		document.forms[0].submit(); 	
	}
}
function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}
function total()
{
	var txt_temp1;
	var txt_temp2;
	var temp=0;	
	txt_temp1=NanNumber(document.forms[0].txt_limit[0].value);
	txt_temp2=NanNumber(document.forms[0].txt_limit[1].value);
		if(txt_temp1=="")
			txt_temp1="0";
		if(txt_temp2=="")
		txt_temp2="0";
	temp=eval(parseFloat(txt_temp1))+eval(parseFloat(txt_temp2));	
	document.forms[0].txt_limit[2].value=temp;
	txt_temp1=NanNumber(document.forms[0].txt_unsec[0].value);
	txt_temp2=NanNumber(document.forms[0].txt_unsec[1].value);
		if(txt_temp1=="")
			txt_temp1="0";
		if(txt_temp2=="")
			txt_temp2="0";
	temp=eval(parseFloat(txt_temp1))+eval(parseFloat(txt_temp2));
	document.forms[0].txt_unsec[2].value=temp;	
	txt_temp1=NanNumber(document.forms[0].txt_sec[0].value);
	txt_temp2=NanNumber(document.forms[0].txt_sec[1].value);
		if(txt_temp1=="")
			txt_temp1="0";
		if(txt_temp2=="")
			txt_temp2="0";
	temp=eval(parseFloat(txt_temp1))+eval(parseFloat(txt_temp2));
	document.forms[0].txt_sec[2].value=temp;	
	roundtxt(document.forms[0].txt_unsec[2]);
	roundtxt(document.forms[0].txt_sec[2]);
	alltotal();
}
function alltotal()
{	var txt_temp1;
	var txt_temp2;
	var txt_temp3;
	var temp=0;
	for(var i=0;i<=2;i++)
	{		
		txt_temp1 =	NanNumber(document.forms[0].txt_limit[i].value);
		txt_temp2 =	NanNumber(document.forms[0].txt_unsec[i].value);
		txt_temp3 =	NanNumber(document.forms[0].txt_sec[i].value);
		if(txt_temp1=="")
			txt_temp1="0";
		if(txt_temp2=="")
			txt_temp2="0";
		if(txt_temp3=="")
			txt_temp3="0";
		temp=eval(parseFloat(txt_temp1))+eval(parseFloat(txt_temp2))+(parseFloat(txt_temp3));
		document.forms[0].txt_total[i].value=temp;		
		roundtxt(document.forms[0].txt_total[i]);
	}	
}							
function onloading()
{
	if(opt!= "")
		document.forms[0].sel_guarantee.value=opt;
	else
		document.forms[0].sel_guarantee.value=0;
	disableFields(true);
}			
</script>
</head>
<body onload="onloading();">
	<form name="liabilities" method="post" class="normal">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td> <jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="19" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Proposal -&gt; ADV1151 -&gt; Liabilities</td>
	</tr>
</table>
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application /><br>	
	<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1" align="center">
	<tr class="dataheader">
	<td align="center"><B>LIABILITIES</B>
	</td>
	</tr>
	</table>	
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td> 
 					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
						<tr>
							<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td  width="50%"  align="center">
											<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
												<tr>
													<td> 
													  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor" align="center" >
														<tr class="datagrid"> 
														  <td align="center" >Liabilities</td>
														  <td width="85%"  align="center" colspan="8">
															<select name="sel_guarantee" tabindex="1" onChange="selguarantee()">
															  <option value="0" selected="selected">&lt;---Select---&gt;</option>
															  <option value="1">Guarantees</option>
															  <option value="2">D.P.Guarantees</option>
															</select>
														  </td>
														</tr>
														<tr class="dataheader"> 
														  <td align="center">&nbsp;</td>
														  <td   align="center">&nbsp;</td>
														  <td   align="center" colspan="2">OutStanding</td>
														  <td  align="center" rowspan="2">Total</td>
														  
														</tr>
														<tr class="dataheader"> 
														  <td align="center">&nbsp;</td>
														  <td  align="center">Limit</td>
														  <td  align="center">UnSecured</td>
														  <td  align="center">Secured</td>														  
														</tr>
															<%if (hshValues != null) 
                                	 						{
                                	  							arrayrow = (ArrayList) hshValues.get("Row");                                	 
                                	  							if(arrayrow!=null && arrayrow.size()>0)
                 												{
                                		 							for(int i=0;i<arrayrow.size();i++)
                   													{
                                		 								arraycol = (ArrayList) arrayrow.get(i);
                   														if(Helper.correctNull((String)arraycol.get(5)).equalsIgnoreCase("0"))                  															
                   										{%>
														<tr class="datagrid"> 
														  <td >INLAND</td>
														  <td align="center"> 
														  	<input type="hidden" name="txt_liabtype" value="0"/>
                                <lapschoice:CurrencyTag  name="txt_limit" size="16" tabindex="2" maxlength="12" onBlur="total()" value='<%=Helper.correctNull((String)arraycol.get(0))%>'/> 
                              </td>
														  <td align="center"> 
															<lapschoice:CurrencyTag name="txt_unsec" size="16"  tabindex="3" maxlength="12" onBlur="total()" value='<%=Helper.correctNull((String)arraycol.get(1))%>'/>
														  </td>
														  <td align="center"> 
															<lapschoice:CurrencyTag name="txt_sec" size="16" tabindex="4" maxlength="12" onBlur="total()" value='<%=Helper.correctNull((String)arraycol.get(2))%>' />
														  </td>
														  <td align="center"> 
															<lapschoice:CurrencyTag name="txt_total" size="16" tabindex="5" maxlength="12"  onBlur="alltotal()" value='<%=Helper.correctNull((String)arraycol.get(3))%>' />
														  </td></tr>
														  <% }else if(Helper.correctNull((String)arraycol.get(5)).equalsIgnoreCase("1")) { %>														
														<tr class="datagrid"> 
														  <td >FOREIGN</td>
														  <td align="center"> 
														  	<input type="hidden" name="txt_liabtype" value="1"/>
															<lapschoice:CurrencyTag  name="txt_limit" size="16" tabindex="2" maxlength="12"  onBlur="total()" value='<%=Helper.correctNull((String)arraycol.get(0))%>'/>
														  </td>
														  <td align="center"> 
															<lapschoice:CurrencyTag name="txt_unsec" size="16" tabindex="7" maxlength="12" onBlur="total()" value='<%=Helper.correctNull((String)arraycol.get(1))%>' />														  </td>
														  <td align="center" > 
															<lapschoice:CurrencyTag name="txt_sec" size="16" tabindex="8" maxlength="12" onBlur="total()" value='<%=Helper.correctNull((String)arraycol.get(2))%>' />														  </td>
														  <td align="center"> 
															<lapschoice:CurrencyTag name="txt_total" size="16" tabindex="9" maxlength="12"  onBlur="alltotal()" value='<%=Helper.correctNull((String)arraycol.get(3))%>' /></td>
													  
														</tr>
														<%} else if(Helper.correctNull((String)arraycol.get(5)).equalsIgnoreCase("2")) {%>
															<tr class="datagrid"> 
														  	<td >TOTAL</td>
														   	<td align="center"><input type="hidden" name="txt_liabtype" value="2"/>
																<lapschoice:CurrencyTag  name="txt_limit" size="16"  maxlength="12" value='<%=Helper.correctNull((String)arraycol.get(0))%>'/>
														  	</td>
														  	<td align="center"> 
																<lapschoice:CurrencyTag name="txt_unsec" size="16"  maxlength="12" value='<%=Helper.correctNull((String)arraycol.get(1))%>' />
														  	</td>
														  	<td align="center"> 
																<lapschoice:CurrencyTag name="txt_sec" size="16"  maxlength="12" value='<%=Helper.correctNull((String)arraycol.get(2))%>' />
														  	</td>
														  	<td align="center"> 
																<lapschoice:CurrencyTag name="txt_total" size="16"  maxlength="12" value='<%=Helper.correctNull((String)arraycol.get(3))%>'/>
														  	</td>
														  
															</tr>
														<%}}%>
														<%} else{ %>
														<tr class="datagrid"> 
														  <td >INLAND</td>
														  <td align="center">
														  	<input type="hidden" name="txt_liabtype" value="0"/> 
															<lapschoice:CurrencyTag  name="txt_limit" size="16" onBlur="total()" tabindex="2" maxlength="19"  value=''/>
														  </td>
														  <td align="center"> 
															<lapschoice:CurrencyTag name="txt_unsec" size="16" tabindex="3" maxlength="12" onBlur="total()" value=''/>
														  </td>
														  <td align="center"> 
															<lapschoice:CurrencyTag name="txt_sec" size="16" tabindex="4" maxlength="12" onBlur="total()" value=''/>
														  </td>
														  <td align="center"> 
															<lapschoice:CurrencyTag name="txt_total" size="16" tabindex="5" maxlength="12" onBlur="alltotal()" value=''/>
														  </td>
														  
														  </tr>
														  <tr class="datagrid"> 
														  <td >FOREIGN</td>
														  <td align="center"> 
														  	<input type="hidden" name="txt_liabtype" value="1"/>
															<lapschoice:CurrencyTag  name="txt_limit" size="16" tabindex="6" maxlength="19" onBlur="total()" value=''/>
														  </td>
														  <td align="center"> 
															<lapschoice:CurrencyTag name="txt_unsec" size="16" tabindex="7" maxlength="12" onBlur="total()" value=''/>
														  </td>
														  <td align="center"> 
															<lapschoice:CurrencyTag name="txt_sec" size="16" tabindex="8" maxlength="12" onBlur="total()" value=''/>
														  </td>
														  <td align="center"> 
															<lapschoice:CurrencyTag name="txt_total" size="16" tabindex="9" maxlength="12" onBlur="alltotal()" value=''/>
														  </td>
													  
														</tr>
														<tr class="datagrid"> 
														  <td >TOTAL</td>
														   <td align="center"><input type="hidden" name="txt_liabtype" value="2"/>
															<lapschoice:CurrencyTag name="txt_limit" size="16"  maxlength="12" value=''/>
														  </td>
														  <td align="center"> 
															<lapschoice:CurrencyTag name="txt_unsec" size="16"  maxlength="12" value='' />
														  </td>
														  <td align="center"> 
															<lapschoice:CurrencyTag name="txt_sec" size="16"  maxlength="12" value='' />
														  </td>
														  <td align="center"> 
															<lapschoice:CurrencyTag name="txt_total" size="16"  maxlength="12" value=''/>
														  </td>
														  
														</tr>														  
														<%}}%>														
													  </table>  
  												</td>
  											</tr>
  										</table>
  									</td>
  								</tr >
  							</table>
  						</td>
  					</tr>
			</table>
 
  		</td>
	</tr>
</table>
<br/>
  <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/><br> 
	<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr> 
      <td width="20%" ><b>&nbsp; 
        <a href="javascript:callLink('adv_billpurchase.jsp','ADV1151','getPurchaseDetails')" > 
        &lt;&lt; Previous </a>&nbsp;</b></td>
      <td width="60%" align="center"><b> 
        <jsp:include page="../ADV11-51/adv_links.jsp" flush="true" /> 
        </b></td>
      <td width="20%">&nbsp; 
        <div align="right"><b>Pg.14/19&nbsp;
        <a href="javascript:callLink('adv_comments.jsp','ADV1151','getComments')" > 
          Next &gt;&gt; </a></b></div>
      </td>
    </tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>	
</form>
</body>
</html>
