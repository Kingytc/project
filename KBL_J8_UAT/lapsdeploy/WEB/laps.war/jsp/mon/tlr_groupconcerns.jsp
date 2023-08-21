<%@include file ="../share/directives.jsp"%>
<% request.setAttribute("_cache_refresh", "true"); %>
<%
ArrayList arryCol_grpcon=null;
double dblcontilimittotal=0.0, dblcontilimittotal1=0.0;
double dblcontiostotal=0.0,dblcontiostotal1=0.0;
double dblfbwclimittotal=0.0,dblfbwclimittotal1=0.0;
double dblfbwcdptotal=0.0,dblfbwcdptotal1=0.0;
double dblfbwcostotal=0.0,dblfbwcostotal1=0.0;
double dbltllimittotal=0.0,dbltllimittotal1=0.0;
double dbltlostotal=0.0,dbltlostotal1=0.0;
double dblinvesttotal=0.0,dblinvesttotal1=0.0;
%>
<html>
<head>
<title>Group Concern</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function keyvalid(obj)
{
	var key = window.event.keyCode
	if(key==13)
		window.event.keyCode=0;
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/mon_borrowersearch.jsp?hidmontype=MONITREVIEW";
		document.forms[0].submit();
	}
}
function selectValues(grpname,branch,coa,contil,contilos,fbwcl,fbwcdp,fbwcos,tllimit,tlos,investm,mor,irr,sno)
{

	document.forms[0].txt_concern.value = grpname;
	document.forms[0].txt_brch.value = branch;
	document.forms[0].txt_coa.value = coa;
	document.forms[0].txt_climit.value = contil;
	document.forms[0].txt_cos.value = contilos;
	document.forms[0].txt_fbwclim.value = fbwcl;
	document.forms[0].txt_fbwcdp.value = fbwcdp;
	document.forms[0].txt_fbwcos1.value = fbwcos;
	document.forms[0].txt_tllimit.value = tllimit;
	document.forms[0].txt_tlos.value = tlos;
	document.forms[0].txt_inv.value = investm;
	document.forms[0].txt_mor2.value = mor;
	document.forms[0].txt_irr.value = irr;
	document.forms[0].hidsno.value=sno;

	
if(document.forms[0].btnenable.value=="Y")
		enableButtons(true,false,true,true,false,false);
}

function doSave()
{
 	if(checktrim(document.forms[0].txt_concern.value)=="")
	{
		  ShowAlert(121,'Name of the concern');
		  return;
	}

	document.forms[0].hidBeanId.value="reviewtermloan";
	document.forms[0].hidBeanMethod.value="updateGroupConcernData";
	document.forms[0].hidBeanGetMethod.value="getGroupConcernData";
	document.forms[0].hidSourceUrl.value="/action/tlr_groupconcerns.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function enableButtons(valnew,valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdnew.disabled=valnew;
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
} 

function doEdit()
{
 	
	document.forms[0].hidAction.value="Update";
	disableFields(false);
	enableButtons(true,true,false,false,true,true);

}

function doNew()
{
	document.forms[0].hidAction.value="Insert";
	disableFields(false);
	enableButtons(true,true,false,false,true,true);
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
	document.forms[0].hidBeanId.value="reviewtermloan";
	document.forms[0].hidBeanGetMethod.value="getGroupConcernData";
	document.forms[0].action=appURL+"action/tlr_groupconcerns.jsp";
	document.forms[0].submit();
	}
}


function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		
		}
	}
	
	
}
function doDelete()
{
	document.forms[0].hidAction.value="Delete";
	document.forms[0].hidBeanId.value="reviewtermloan";
	document.forms[0].hidBeanMethod.value="updateGroupConcernData";
	document.forms[0].hidBeanGetMethod.value="getGroupConcernData";
	document.forms[0].hidSourceUrl.value="/action/tlr_groupconcerns.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function callOtherLink(page,bean,method)
{
	if(!document.forms[0].reviewYear.value=="")
	{
		document.forms[0].reviewOf.disabled=false;
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		alert("Select Review Year");
	}
}
	
function onloading()
{	  
	disableFields(true);
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<lapschoice:tlrtag pageid="3" reviewof='<%=Helper.correctNull((String)request.getParameter("reviewOf"))%>' valuesin='<%=Helper.correctNull((String)request.getParameter("valuesin"))%>'/>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>

		<td valign="top" colspan="5" class="page_flow">Home -&gt; Term Loan - Review -&gt; Promoter -&gt; Group Concerns</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
			<tr>
				<td><lapschoice:MonitorReview /></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="30%" border="0" cellspacing="1" cellpadding="3" align="left" class="outertable">
			<tr>
				<td width="15%" align="center" class="sub_tab_inactive"><b><a
					href="JavaScript:callOtherLink('tlr_promoterdetails.jsp','reviewtermloan','getPromotersData')">Promoter</a></b></td>
				<td width="15%" align="center" class="sub_tab_active"><b>Group Concerns</b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td colspan="3">
								<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
									<tr>
										<td colspan="13"><b>Details of Associates / Subsidiary / Group
										Companies </b></td>
									</tr>
									<tr align="center" class="dataheader">
										<td width="13%" rowspan="2"><b>Name of
										the Concern</b></td>
										<td width="25%" rowspan="2"><b>Branch</b></td>
										<td width="1%" rowspan="2"><b>CoA</b></td>
										<td width="1%" colspan="2"><b>Contingent</b></td>
										<td colspan="3"><b>FBWC</b></td>
										<td colspan="2"><b>Term Loan</b></td>
										<td width="16%" rowspan="2"><b>Investment</b></td>
										<td width="16%" rowspan="2"><b>MOR</b></td>
										<td width="16%" rowspan="2"><b>Irregularity,if
										any</b></td>
									</tr>
									<tr align="center" class="dataheader">
										<td width="0%">Limit</td>
										<td width="1%">O/S</td>
										<td width="10%">Limit</td>
										<td width="10%">DP</td>
										<td width="10%">O/S</td>
										<td width="10%">Limit</td>
										<td width="10%">O/S</td>
									</tr>
									<tr align="center">
										<td width="13%"><input type="text"
											name="txt_concern" size="20" maxlength="100"></td>
										<td width="25%"><input type="text"
											name="txt_brch" size="10" maxlength="99"
											onKeyPress="notAllowSplChar()"></td>
										<td width="1%"><input type="text"
											name="txt_coa" size="10" maxlength="20"></td>
										<td width="0%"><lapschoice:CurrencyTag
											name="txt_climit" tabindex="3" size="10" maxlength="10" /></td>
										<td width="1%"><lapschoice:CurrencyTag
											name="txt_cos" tabindex="3" size="10" maxlength="10" /></td>
										<td width="10%"><lapschoice:CurrencyTag
											name="txt_fbwclim" tabindex="3" size="10" maxlength="10" /></td>
										<td width="10%"><lapschoice:CurrencyTag
											name="txt_fbwcdp" tabindex="3" size="10" maxlength="10" /></td>
										<td width="10%"><lapschoice:CurrencyTag
											name="txt_fbwcos1" tabindex="3" size="10" maxlength="10" /></td>
										<td width="10%"><lapschoice:CurrencyTag
											name="txt_tllimit" tabindex="3" size="10" maxlength="10" /></td>
										<td width="10%"><lapschoice:CurrencyTag
											name="txt_tlos" tabindex="3" size="10" maxlength="10" /></td>
										<td width="16%"><lapschoice:CurrencyTag
											name="txt_inv" tabindex="3" size="10" maxlength="10" /></td>
										<td width="16%"><input type="text"
											name="txt_mor2" tabindex="3" size="10" maxlength="15"
											onKeyPress="notAllowSplChar()"></td>
										<td width="16%"><input type="text"
											name="txt_irr" tabindex="3" size="10" maxlength="15"
											onKeyPress="notAllowSplChar()"></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
							 <td colspan="3">&nbsp;</td>
							</tr>
							<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
							<tr>
								<td colspan="2" valign="top"><br>
								<br>
								<div class="cellcontainer">
								<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
									<tr class="dataheader">
										<td rowspan="2" width="3%">&nbsp;</td>
										<td rowspan="2" width="9%">Name of the
										Concern</td>
										<td rowspan="2" align="center">Branch</td>
										<td rowspan="2" align="center">CoA</td>
										<td colspan="2" align="center">Contingent</td>
										<td colspan="3" align="center">FBWC</td>
										<td colspan="2" align="center">Term Loan</td>
										<td rowspan="2" align="center">Investment</td>
										<td rowspan="2" align="center">MOR</td>
										<td rowspan="2" align="center">Irregularity,if
										any</td>
									</tr>
									<tr class="dataheader">
										<td width="8%">Limit</td>
										<td width="8%">O/S</td>
										<td width="5%" align="center">Limit</td>
										<td width="7%" align="center">DP</td>
										<td width="8%" align="center">O/S</td>
										<td width="7%" align="center">Limit</td>
										<td width="7%" align="center">O/S</td>
									</tr>
									<%
									
                           		ArrayList operinfo =(ArrayList) hshValues.get("arrRow");
								if(operinfo!=null && operinfo.size()>0)
								{
									for(int i=0;i<operinfo.size();i++){
									arryCol_grpcon=(ArrayList)operinfo.get(i);
							%>
									<tr class="datagrid">
									<td align="center" width="3%"><input
											type="radio" name="sno" style="border-style:none"
											onClick="selectValues('<%=Helper.correctNull((String)arryCol_grpcon.get(0))%>',
													  '<%=Helper.correctNull((String)arryCol_grpcon.get(1))%>',
													  '<%=Helper.correctNull((String)arryCol_grpcon.get(2))%>',
													  '<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryCol_grpcon.get(3))))%>',
													  '<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryCol_grpcon.get(4))))%>',
													  '<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryCol_grpcon.get(5))))%>',
													  '<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryCol_grpcon.get(6))))%>',
													  '<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryCol_grpcon.get(7))))%>',
													  '<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryCol_grpcon.get(8))))%>',
													  '<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryCol_grpcon.get(9))))%>',
													  '<%=Helper.correctNull((String)arryCol_grpcon.get(10))%>',
													  '<%=Helper.correctNull((String)arryCol_grpcon.get(11))%>',
													  '<%=Helper.correctNull((String)arryCol_grpcon.get(12))%>',
													  '<%=Helper.correctNull((String)arryCol_grpcon.get(13))%>')">
										</td>
										<td width="9%"><%=Helper.correctNull((String)arryCol_grpcon.get(0))%>
										</td>
										<td width="6%"><%=Helper.correctNull((String)arryCol_grpcon.get(1))%>
										</td>
										<td width="9%"><%=Helper.correctNull((String)arryCol_grpcon.get(2))%>
										</td>
										<td width="8%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryCol_grpcon.get(3))))%>

										</td>
										<td width="8%" align="right"><%=Helper.correctNull((String)arryCol_grpcon.get(4))%>
										</td>
										<td width="5%" align="right">&nbsp; <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryCol_grpcon.get(5))))%>

										</td>
										<td width="7%" align="right">&nbsp; <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryCol_grpcon.get(6))))%>

										</td>
										<td width="8%" align="right"><%=Helper.correctNull((String)arryCol_grpcon.get(7))%>
										</td>
										<td width="7%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryCol_grpcon.get(8))))%>
										</td>
										<td width="7%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryCol_grpcon.get(9))))%>
										&nbsp;</td>
										<td width="7%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arryCol_grpcon.get(10))))%>
										</td>
										<td width="7%" align="right"><%=Helper.correctNull((String)arryCol_grpcon.get(11))%>

										</td>
										<td width="9%" align="right"><%=Helper.correctNull((String)arryCol_grpcon.get(12))%>

										</td>
									</tr>
									<%
								
													
								dblcontilimittotal=Double.parseDouble(Helper.correctDouble((String) arryCol_grpcon.get(3)));
								dblcontilimittotal1=dblcontilimittotal1+dblcontilimittotal;
								
								dblcontiostotal=Double.parseDouble(Helper.correctDouble((String) arryCol_grpcon.get(4)));
								dblcontiostotal1=dblcontiostotal1+dblcontiostotal;
								
								dblfbwclimittotal=Double.parseDouble(Helper.correctDouble((String) arryCol_grpcon.get(5)));
								dblfbwclimittotal1=dblfbwclimittotal1+dblfbwclimittotal;
								
								dblfbwcdptotal=Double.parseDouble(Helper.correctDouble((String) arryCol_grpcon.get(6)));
								dblfbwcdptotal1=dblfbwcdptotal1+dblfbwcdptotal;
								
								dblfbwcostotal=Double.parseDouble(Helper.correctDouble((String) arryCol_grpcon.get(7)));
								dblfbwcostotal1=dblfbwcostotal1+dblfbwcostotal;
								
								dbltllimittotal=Double.parseDouble(Helper.correctDouble((String) arryCol_grpcon.get(8)));
								dbltllimittotal1=dbltllimittotal1+dbltllimittotal;
								
								dbltlostotal=Double.parseDouble(Helper.correctDouble((String) arryCol_grpcon.get(9)));
								dbltlostotal1=dbltlostotal1+dbltlostotal;
								
								dblinvesttotal=Double.parseDouble(Helper.correctDouble((String) arryCol_grpcon.get(10)));
								dblinvesttotal1=dblinvesttotal1+dblinvesttotal;
								
							}
					%>			<tr>
										<td align="center" width="3%">&nbsp;</td>
										<td width="9%">&nbsp;</td>
										<td width="6%">&nbsp;</td>
										<td width="9%"><b>Total Exposures</b></td>
										<td width="8%" align="right"><b><%=Helper.formatDoubleValue(dblcontilimittotal1)%></b></td>
										<td width="8%" align="right"><b><%=Helper.formatDoubleValue(dblcontiostotal1)%></b></td>
										<td width="5%" align="right"><b><%=Helper.formatDoubleValue(dblfbwclimittotal1)%></b></td>
										<td width="7%" align="right"><b><%=Helper.formatDoubleValue(dblfbwcdptotal1)%></b></td>
										<td width="8%" align="right"><b><%=Helper.formatDoubleValue(dblfbwcostotal1)%></b></td>
										<td width="7%" align="right"><b><%=Helper.formatDoubleValue(dbltllimittotal1)%></b></td>
										<td width="7%" align="right"><b><%=Helper.formatDoubleValue(dbltlostotal1)%></b></td>
										<td width="7%" align="right"><b><%=Helper.formatDoubleValue(dblinvesttotal1)%></b></td>
										<td width="7%" align="right"><b>&nbsp;</b></td>
										<td width="9%" align="right"><b>&nbsp;</b></td>
									</tr>

									<%
                            }%>
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
	</tr>
</table>
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidsno" />
<input type="hidden" name="hidflag" value=""> <input type="hidden" name="hidval"> 
<input type="hidden" name="appnum">
<INPUT TYPE="hidden" NAME="hidPageSource" VALUE="">
<input type="hidden" name="reviewOf" value="<%=request.getParameter("reviewOf")%>">
</form>
</body>
</html>
