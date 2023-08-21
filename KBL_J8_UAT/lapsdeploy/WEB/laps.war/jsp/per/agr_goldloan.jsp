<%@include file="../share/directives.jsp"%>
<%ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();%>
<html>
<head>
<title>Gold Ornaments Details</title>
<script>
var varGoldCoinNetweight="<%=Helper.correctNull((String)hshValues.get("strGoldCoinNetweight"))%>";
var varMaxNetWeight="<%=Helper.correctNull((String)hshValues.get("strMaxNetWeight"))%>";
var varAccoutNo ="<%=Helper.correctNull((String)hshValues.get("AccoutNo"))%>";
var varTotalNet=varGoldCoinNetweight;
function selectValues(val1, val2, val3, val4, val5, val6,val7,val8,val9, val10,val11, val12, val13, val14,val15)
{
	if(document.forms[0].btnenable.value=="Y")
	{
		disableCommandButtons(true,false,true,true,false,true);
	}
 	document.forms[0].hidgoldsno.value =val2;
	document.forms[0].txt_artdesc.value= val3;
	document.forms[0].txt_gross.value= val4;
	document.forms[0].txt_net.value= val5;
	document.forms[0].txt_qtytouch.value = val6;
	document.forms[0].txt_totmktrate.value = val7;
	document.forms[0].txt_rate.value = val8;
	document.forms[0].txt_esti.value = val9;
	document.forms[0].txt_quantity.value = val10;
	document.forms[0].txt_bankvalue.value=val11;
	if(val12==""||val12==null)
	{
		document.forms[0].hidGRSNo.value="<%=Helper.correctNull((String)hshValues.get("strGRSNo"))%>";
	}
	else
	{
		document.forms[0].hidGRSNo.value=val12;
	}
	document.forms[0].hidSecurityId.value = val13;
	document.forms[0].sel_ArticleType.value = val14;
	document.forms[0].txt_estimated.value = val15;
	showDescOfArt();
}
function netgrossweight()
{
	var netweight=document.forms[0].txt_net.value;
	var grossweight=document.forms[0].txt_gross.value;
if(eval(parseFloat(netweight))>eval(parseFloat(grossweight)))
  	{
		alert("Net Weight should be less than Gross Weight");
  		document.forms[0].txt_net.value="";
 		document.forms[0].txt_net.focus();
  		return false;
  	}
}

function doSave()
{
  netgrossweight();doMaxNetWeightCheck();estimatedvalue();estimatedbankvalue();
   
	if(document.forms[0].sel_ArticleType.value=="")
	{
		alert("Select Article type");
		document.forms[0].sel_ArticleType.focus();
		return;
	}
	if(document.forms[0].sel_ArticleType.value=="O")
	{
		if(document.forms[0].txt_artdesc.value==0)
		{
			alert("Enter the value for description of articles");
			document.forms[0].txt_artdesc.focus();
			return;
		}
	}
	else if(document.forms[0].sel_ArticleType.value=="G")
	{
		document.forms[0].txt_artdesc.value=document.forms[0].sel_ArticleType.options[document.forms[0].sel_ArticleType.selectedIndex].text;
	}
	if(document.forms[0].txt_quantity.value=='' || document.forms[0].txt_quantity.value==0)
	{
		alert("Enter the value for Quantity");
		document.forms[0].txt_quantity.focus();
		return;
	}
	if(document.forms[0].txt_gross.value==0)
	{
		alert("Enter the value for Gross");
		document.forms[0].txt_gross.focus();
		return;
	}
	if(document.forms[0].txt_net.value==0)
	{
		alert("Enter the value for Net");
		document.forms[0].txt_net.focus();
		return;
	}
	if(document.forms[0].txt_qtytouch.value==0)
	{
	alert("Enter the value for Purity");
	document.forms[0].txt_qtytouch.focus();
	return;
	}
	if(document.forms[0].txt_totmktrate.value==0)
	{
	alert("Enter the value for Market rate");
	document.forms[0].txt_totmktrate.focus();
	return;
	}
	var varMaxGoldCheck=doNetWeightCheck();
	if(varMaxGoldCheck==true)
	{
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidBeanId.value="agrotherassets";
		document.forms[0].hidSourceUrl.value="/action/agr_goldloan.jsp";
		document.forms[0].hidBeanMethod.value="updategolddetails";
		document.forms[0].hidBeanGetMethod.value="getgolddetails";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}

function disableCommandButtons(valnew,valedit,valapply,valcancel,valdel,valclose)
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
	document.forms[0].hidAction.value ="update";
	document.forms[0].hideditflag.value ="Y";
	disableCommandButtons(true,true,false,false,true,true);	
	disableFields(false);
	document.forms[0].txtgoldcointot.value=eval(document.forms[0].txtgoldcointot.value)-eval(document.forms[0].txt_net.value);
	//varGoldCoinNetweight=eval(varGoldCoinNetweight)-eval(document.forms[0].txt_net.value);
}


function doNew()
{
	document.forms[0].sel_ArticleType.value="";	 
	document.forms[0].txt_artdesc.value="";	 
	document.forms[0].txt_gross.value="";
	document.forms[0].txt_net.value="";
	document.forms[0].txt_qtytouch.value="";
	document.forms[0].txt_totmktrate.value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("strGoldRate"))))%>";
	document.forms[0].txt_rate.value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("strAvgRate"))))%>";
	document.forms[0].txt_esti.value="";
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hideditflag.value ="Y";
	disableCommandButtons(true,true,false,false,true,true);	
	disableFields(false);
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agrotherassets";
		document.forms[0].hidBeanGetMethod.value="getgolddetails";
		document.forms[0].action=appURL+"action/agr_goldloan.jsp";
		document.forms[0].method="post";
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
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=(!val);
		}	 
	}
	document.forms[0].txt_esti.readOnly=true;
	document.forms[0].txt_rate.readOnly=true;
	document.forms[0].txt_totmktrate.readOnly=true;
}


function doDelete()
{
	if(ConfirmMsg('101'))
	{
	    document.forms[0].hidAction.value ="Delete";
		document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updategolddetails";
		document.forms[0].hidBeanGetMethod.value="getgolddetails";	
		document.forms[0].hidBeanId.value="agrotherassets";
		document.forms[0].hidSourceUrl.value="action/agr_goldloan.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();		
	}
}

function callOnLoad()
{	 
	disableFields(true);
	showDescOfArt();
	newAppraisal();
}


function estimatedvalue()
{
	var market_value=document.forms[0].txt_net.value;
	var net_grms=document.forms[0].txt_totmktrate.value;
	if(market_value=="")
	{
		market_value=0;
	}
	if(net_grms=="")
	{
		net_grms=0;
	}
	var varnet_value=(eval(parseFloat(market_value))*eval((net_grms)));
	document.forms[0].txt_estimated.value=varnet_value;
}

function estimatedbankvalue()
{
	var mark_value=document.forms[0].txt_net.value;
	var net_rate=document.forms[0].txt_rate.value;
	if(mark_value=="")
	{
		mark_value=0;
	}
	if(net_rate=="")
	{
		net_rate=0;
	}
	var varbank_value=(eval(parseFloat(mark_value))*eval(parseFloat(net_rate)));
	document.forms[0].txt_bankvalue.value=varbank_value;
	var varestimated=document.forms[0].txt_estimated.value
	if(parseFloat(varestimated)>parseFloat(varbank_value))
	{
		document.forms[0].txt_esti.value=varbank_value;
	}else{
		document.forms[0].txt_esti.value=varestimated;
	}
}

function gototab(beanid,methodname,pagename)
{
	if(document.forms[0].hideditflag.value!="Y")
	{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}
function showDescOfArt()
{
	if(document.forms[0].sel_ArticleType.value=="O")
	{
		document.all.id_lblDescOfArticle.style.display="table-cell";
		document.all.id_txtDescOfArticle.style.display="table-cell";
	}
	else
	{
		document.all.id_lblDescOfArticle.style.display="none";
		document.all.id_txtDescOfArticle.style.display="none";
	}
}
function doNetWeightCheck()
{
	if(document.forms[0].sel_ArticleType.value=="G")
	{
		varTotalNet=eval(parseFloat(varTotalNet))+eval(parseFloat(document.forms[0].txt_net.value));
		if(eval(parseFloat(varTotalNet))>eval(parseFloat(varMaxNetWeight)))
		{
			alert("Maximum Net Weightage of Gold coins (per borrower) is "+varMaxNetWeight+" gm,\n"+varGoldCoinNetweight+" gm were availed already");
			document.forms[0].txtgoldcointot.value=eval(parseFloat(document.forms[0].txtgoldcointot.value))-eval(parseFloat(document.forms[0].txt_net.value));
			document.forms[0].txt_net.value="";
			document.forms[0].txt_net.focus();
			varTotalNet=varGoldCoinNetweight;
			return false;
		}
		else
		{
			return true;
		} 
	}
	else
	{
		return true;
	}
}
function doMaxNetWeightCheck()
{
	if(document.forms[0].sel_ArticleType.value=="G")
	{
		if(eval(parseFloat(document.forms[0].txt_net.value))>eval(parseFloat(varMaxNetWeight)))
		{
			alert("Maximum Net Weightage of Gold coins (per borrower) is "+varMaxNetWeight+" gm");
			document.forms[0].txt_net.value="";
			document.forms[0].txt_net.focus();
			return false;
		} 
	} 
}
function doClearFields()
{
	document.forms[0].txt_artdesc.value="";
	document.forms[0].txt_quantity.value="";
	document.forms[0].txt_gross.value="";
	document.forms[0].txt_net.value="";
	document.forms[0].txt_qtytouch.value="";
	document.forms[0].txt_esti.value="";
}
function doAppraiserDetails()
{
	appno = document.forms[0].appno.value;
	var prop = "scrollbars=no,width=650,height=400,top=25,left=180";
	var url=appURL+"action/per_appraiserdetails.jsp?hidBeanId=agrotherassets&hidBeanGetMethod=getGoldAppraiserdet&appno="+appno+"&appstatus="+document.forms[0].appstatus.value;
	window.open(url,"appraiser",prop);

}
function newAppraisal()
{
	if(varAccoutNo != "")
	{
		document.forms[0].cmdreappraisaldetails.disabled=false;
	}else
	{
		document.forms[0].cmdreappraisaldetails.disabled=true;
	}
}

function doReAppraisalDetails()
{
	appno = document.forms[0].appno.value;
	var prop = "scrollbars=no,width=1050,height=600,top=25,left=180";
	var url=appURL+"action/gold_reappraisal.jsp?hidBeanId=agrotherassets&hidBeanGetMethod=getGoldReAppraiserdet&appno="+appno+"&appstatus="+document.forms[0].appstatus.value;
	window.open(url,"appraiser",prop);
}

</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="callOnLoad();">
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/Applurllinkper.jsp">
			<jsp:param name="pageid" value="1" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" class="page_flow">Home -&gt; Retail -&gt; Loan
		Particulars -&gt; Gold Ornaments</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><lapschoice:application /></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="bottom">
		<table width="93%" border="0" cellspacing="0" cellpadding="0" class="outertable"
			align="left">
			<tr align="center">
				<td><jsp:include page="../per/applicanttab.jsp" flush="true">
					<jsp:param name="linkid" value="8" />
				</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="98%" border="0" cellpadding="5" cellspacing="0" class="outertable"
	align="center">
	<tr>
		<td>
		<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="2" class="outertable">
			<TR>
				<TD>
				<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0" class="outertable">
					<TR>
						<TD>
						<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="3" class="outertable">
							<TR>
								<TD>

								<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="2" class="outertable">
									<TR align="center" class="dataheader">
										<TD ROWSPAN="2" width="13%"><B>Article Type</B></TD>
										<TD ROWSPAN="2" width="14%" id="id_lblDescOfArticle"><B>Description of Articles</B></TD>
										<TD ROWSPAN="2" width="10%"><b>Quantity</b></TD>
										<TD COLSPAN="2"><B>Weight Of Articles (gm.)<BR></B></TD>
										<TD ROWSPAN="2" width="10%"><B>Purity </B></TD>
										<TD ROWSPAN="2" width="10%"><B>Last Market Rate as per IBJA</B></TD>
										<TD ROWSPAN="2" width="12%"><B>Average of previous 30 day's closing Gold Rate as per IBJA </B></TD>
										<TD ROWSPAN="2" width="13%"><B>Estimated value of the article (in Rs.)</B></TD>
									</TR>
									<TR class="dataheader">
										<TD ALIGN="center" width="9%"><B>Gross</B></TD>
										<TD ALIGN="center" width="9%" nowrap><B>Net (in 22 carat)</B></TD>
									</TR>
									<TR align="center" class="datagrid">
										<TD>
											<select name="sel_ArticleType" onChange="showDescOfArt();doClearFields();" style="width: 80%">
												<option value="">&nbsp;--select--&nbsp;</option>
												<option value="G">&nbsp;Gold coins&nbsp;</option>
												<option value="O">&nbsp;Others&nbsp;</option>
											</select>
										</TD>
										<TD id="id_txtDescOfArticle"><INPUT TYPE="text" NAME="txt_artdesc" SIZE="35"
											MAXLENGTH="30" VALUE=""></TD>
										<TD><input type="text" name="txt_quantity" size="5"
											maxlength="3" onkeypress="allowNumber(this);">&nbsp;Nos.</TD>
										<TD><INPUT TYPE="text" NAME="txt_gross" SIZE="7"
											MAXLENGTH="5" ONKEYPRESS="allowNumber(this)"
											VALUE=""></TD>
										<TD><INPUT TYPE="text" NAME="txt_net" SIZE="7" MAXLENGTH="5"
											ONKEYPRESS="allowNumber(this)"
											ONBLUR="netgrossweight();doMaxNetWeightCheck();estimatedvalue();estimatedbankvalue()">
											</TD>
										<TD><INPUT TYPE="text" NAME="txt_qtytouch" SIZE="10"
											MAXLENGTH="50">
										</TD>
										<TD>Rs.&nbsp;<lapschoice:CurrencyTag name="txt_totmktrate" size="12" style="border: 0; background-color: #ece1ea;"
											onBlur="estimatedvalue();estimatedbankvalue();" maxlength="7" /></TD>
										<TD>Rs.&nbsp;<lapschoice:CurrencyTag name="txt_rate" size="12" style="border: 0; background-color: #ece1ea;"
											onBlur="estimatedbankvalue()" maxlength="7" /></TD>
										<TD BGCOLOR="">Rs.&nbsp;<lapschoice:CurrencyTag name="txt_esti"
											size="18" maxlength="10" /> <INPUT TYPE="hidden"
											NAME="txt_bankvalue"><INPUT TYPE="hidden"
											NAME="txt_estimated"></TD>
									</TR>
								</TABLE>
								</TD>
							</TR>
							<!--<tr>
								<td>
									<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="2" class="outertable">
									<TR align="center" class="dataheader">
										<TD width="50%"><B>Rent & Insurance</B></TD>
										<TD width="50%"><B>Jewel Appraisal</B></TD>
									</TR>
									<TR align="center" class="datagrid">
										<td>Rs.&nbsp;<%=Helper.correctDouble((String)hshValues.get("dblRentInsureVal"))%></td>
										<td>Rs.&nbsp;<%=Helper.correctDouble((String)hshValues.get("dblJewelAppraisal"))%></td>
									</TR>
									</table>
								</td>
							</tr>
							--><TR>
								<TD><BR>
								<TABLE WIDTH="12%" BORDER="0" ALIGN="center" CELLPADDING="0"
									CELLSPACING="0" class="outertable">
									<TR>
										<TD><lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail_Appraiser Details_Re Appraisal Details'
											btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
										</TD>
									</TR>
								</TABLE>
								</TD>
							</TR>
							<TR>
								<TD>
								<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0" class="outertable">
									<TR>
										<TD>

										<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3" class="outertable">
											<TR  align="center" class="dataheader">
												<TD WIDTH="4%" ROWSPAN="2"><B> &nbsp;</B></TD>
												<TD WIDTH="21%" ROWSPAN="2"><B>Description of Articles</B></TD>
												<TD WIDTH="10%" ROWSPAN="2"><b>Quantity&nbsp;(Nos.)</b></TD>
												<TD COLSPAN="2"><B>Weight Of Articles (gm.)</B><B></B></TD>
												<TD WIDTH="10%" ROWSPAN="2"><B>Purity </B></TD>
												<TD WIDTH="13%" ROWSPAN="2"><B>Last Market Rate as per IBJA &nbsp;(Rs.)</B></TD>
												<TD WIDTH="13%" ROWSPAN="2"><B>Average of previous 30 day's closing Gold Rate as per IBJA</B></TD>
												<TD WIDTH="13%" ROWSPAN="2"><B><B>Estimated value of the
												article&nbsp;(Rs.)</B></B></TD>
											</TR>
											<TR class="dataheader">
												<TD WIDTH="8%" align="center"><B>Gross</B></TD>
												<TD WIDTH="8%" align="center" nowrap><B>Net (in 22 carat)</B></TD>
											</TR>
										</TABLE>
										</TD>
									</TR>
									<TR>
										<TD>
										<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="3" class="outertable linebor">
											<%double dblTemp=0.00;
											if(hshValues!=null&&hshValues.size()>0)
											{
												arrRow = (ArrayList) hshValues.get("arrRow");
												String inside = "N";
												if (arrRow != null && arrRow.size() > 0) {
									
													for (int l = 0; l < arrRow.size(); l++) {
														arrCol = (ArrayList) arrRow.get(l);
														if(Helper.correctNull((String) arrCol.get(13)).equalsIgnoreCase("G"))
														{
															dblTemp=dblTemp+Double.parseDouble(Helper.correctDouble((String) arrCol.get(4)));
														}
									
														%>
											<TR valign="top" class="datagrid">
												<TD WIDTH="4%" ALIGN="center"><INPUT TYPE="radio"
													STYLE="border:none" NAME="radiobutton" VALUE="radiobutton"
													ONCLICK="javascript:selectValues('<%=Helper.correctNull((String)arrCol.get(0))%>',
													'<%=Helper.correctNull((String)arrCol.get(1))%>',
													'<%=Helper.correctNull((String)arrCol.get(2))%>',
													'<%=Helper.correctNull((String)arrCol.get(3))%>',
													'<%=Helper.correctNull((String)arrCol.get(4))%>',
													'<%=Helper.correctNull((String)arrCol.get(5))%>',
													'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))%>',
													'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7))))%>',
													'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(8))))%>',
													'<%=Helper.correctNull((String) arrCol.get(9))%>',
													'<%=Helper.correctNull((String) arrCol.get(10))%>',
													'<%=Helper.correctNull((String) arrCol.get(11))%>',
													'<%=Helper.correctNull((String) arrCol.get(12))%>',
													'<%=Helper.correctNull((String) arrCol.get(13))%>','<%=Helper.correctNull((String) arrCol.get(14))%>')">
												</TD>
												<TD WIDTH="21%" ALIGN="left"><%=Helper.correctNull((String) arrCol.get(2))%></TD>
												<TD WIDTH="10%" ALIGN="left">&nbsp;<%=Helper.correctNull((String) arrCol.get(9))%></TD>
												<TD WIDTH="8%" ALIGN="left">&nbsp;<%=Helper.correctNull((String) arrCol.get(3))%></TD>
												<TD WIDTH="8%" ALIGN="left"><%=Helper.correctNull((String) arrCol.get(4))%></TD>
												<TD WIDTH="10%" ALIGN="left"><%=Helper.correctNull((String) arrCol.get(5))%></TD>
												<TD WIDTH="13%" ALIGN="right"><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(6))))%></TD>
												<TD WIDTH="13%" ALIGN="right"><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(7))))%></TD>
												<TD WIDTH="13%" ALIGN="right"><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(8))))%></TD>
											</TR>
											<%}%>
											<tr class="datagrid">
												<td colspan="4" align="right">&nbsp;
												</td>
												<td><input type="hidden" value="<%=dblTemp %>" name="txtgoldcointot"><%=Helper.correctDouble((String)hshValues.get("strNetWeight"))%>&nbsp;</td>
												<td colspan="3" align="right">Total&nbsp;
												</td>
												<td WIDTH="13%" align="right">
													<%=Helper.correctDouble((String)hshValues.get("dbESTRATE1"))%>&nbsp;
												</td>
											</tr>
											<%}
												else{%>
												<tr class="datagrid">
											<td colspan="8" align="center">&nbsp;No Record Found<input type="hidden" name="txtgoldcointot"></td>
											</tr>
													<%}
												}%>
											
										</TABLE>
										</TD>
									</TR>
								</TABLE>
								</TD>
							</TR>
						</TABLE>
						</TD>
					</TR>
				</TABLE>
				</TD>
			</TR>
		</TABLE>
		</td>
	</tr>
</table>
<input type="hidden" name="hidgoldsno">
<input type="hidden" name="hidGRSNo">
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="radLoan" value="Y">
<input type="hidden" name="hidSecurityId" value="<%=Helper.correctNull((String) hshValues.get("strSecId"))%>">
</form>
</body>
</html>
