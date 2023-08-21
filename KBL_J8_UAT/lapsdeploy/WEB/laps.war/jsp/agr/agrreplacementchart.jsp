<%@include file="../share/directives.jsp"%>
<%@ page import="com.sai.fw.management.utils.*"%>
<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%
	ArrayList arryCol = null;
	ArrayList arryBatch = (ArrayList) hshValues.get("arrlist");
	ArrayList arryYear = null;
	
	String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
	if(schemetype. trim().equalsIgnoreCase(""))
		{
			schemetype="0";
		}
	String strFacSNo=Helper.getfacilitySno(schemetype);
	int intNoofBatches=Integer.parseInt(Helper.correctInt((String)hshValues.get("strNoofBatches")));
	System.out.println("intNoofBatches==="+intNoofBatches);
	String printYearCheck[] = new String[intNoofBatches+1];	
	String printYearCheckFlag[] = new String[intNoofBatches+1];	
	String strArrShedNo[]=null;
	int intSize=0;
	if(intNoofBatches!=0)
	{
	for (int p=1;p<=intNoofBatches;p++)
	 {
		printYearCheck[p]= String.valueOf(p);
		printYearCheckFlag[p]="false";
	 }
	strArrShedNo =  (String[])hshValues.get("strArrShedNo");
	intSize=arryBatch.size();
	}
	int strPeriod=Integer.parseInt(Helper.correctInt((String)hshValues.get("strPeriod")));
%>


<head>
<title>Flock Replacement Chart</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var varappno="<%=Helper.correctNull((String)hshValues.get("strAppno"))%>";
function doClose()
{
if( ConfirmMsg(100))
	{
		window.close();
	}
}
function callCalender(val)
{
		 showCal(appUrl,val);
}
function callFlowChart()
{
	var varschemetype=document.forms[0].hidscheme.value;
	var varDate=document.forms[0].txt_purchasedate.value;
	var purl ="<%=ApplicationParams.getAppUrl()%>action/agrreplacementchart.jsp?hidBeanGetMethod=getbroiagrflocknew&hidBeanId=agriloanassessment&strappno="+varappno+"&schemetype="+varschemetype+"&txt_purchasedate="+varDate+"&appno="+varappno;
	var xpos = (screen.width - 900) / 2;
	var ypos = (screen.height - 700) / 2;
	var prop = 'scrollbars=yes,menubar=YES,width=900,height=550,status=yes';
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'Deviation',prop);
}
function callFunction()
{
	 window.opener.ClearFields();
	<%for(int i=0;i<strPeriod;i++)
	{
	if(strPeriod>1){%>
	 	window.opener.document.forms[0].txt_batch[<%=i%>].value=document.forms[0].txtpurchase[<%=i%>].value;
	 	window.opener.document.forms[0].txtbrood[<%=i%>].value=document.forms[0].txtbwk[<%=i%>].value;
	 	window.opener.document.forms[0].txtgrower[<%=i%>].value=document.forms[0].txtgwk[<%=i%>].value;
	 	window.opener.document.forms[0].txtlayer[<%=i%>].value=document.forms[0].txtlwk[<%=i%>].value;
	 	window.opener.document.forms[0].txt_broodermon[<%=i%>].value=document.forms[0].txttotal[<%=i%>].value;
	<%}else if(strPeriod==1){%>
		window.opener.document.forms[0].txt_batch.value=document.forms[0].txtpurchase.value;
		window.opener.document.forms[0].txtbrood.value=document.forms[0].txtbwk.value;
	 	window.opener.document.forms[0].txtgrower.value=document.forms[0].txtgwk.value;
	 	window.opener.document.forms[0].txtlayer.value=document.forms[0].txtlwk.value;
	 	window.opener.document.forms[0].txt_broodermon.value=document.forms[0].txttotal.value;
	<%}}%>
	window.close();
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems"><script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>
<form name="frmpri" class="normal" method=post>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
      <td class="page_flow">Home -> Agriculture -> Flock Replacement</td>
	</tr>
</table>

<table width="98%" border="0" cellspacing="0" cellpadding="5" class="outertable border1" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="2" cellpadding="2">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="2" cellpadding="2">
					<tr>

						<td>
						<table width="90%" border="0" align="center" cellspacing="0" cellpadding="1" bordercolorlight="#FFFFFF" bordercolordark="#dleef">
							<tr>
								<td colspan="13">
								<table width="100%" border="1" align="center" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFF" bordercolordark="#dleef">
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td>
												<table width="99%" border="0" cellspacing="1"
													cellpadding="2">
													<tr>
														<td colspan="13" align="center" class="dataheader">Replacement
														Particulars</td>
													</tr>
													<tr class="dataheader">
													<td colspan="10">First Purchase Date&nbsp;</td>
													<td colspan="3" nowrap="nowrap"><input type="text" name="txt_purchasedate"  value="<%=Helper.correctNull((String)hshValues.get("strPurchaseDate"))%>"  size="20%" onBlur="checkDate(this);callFlowChart();"> &nbsp;&nbsp;
    														<a href="#" onClick="callCalender('txt_purchasedate')"
															title="Click to view calender" border=0><img
															src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"		border="0"></a></td>
													</tr>
													<tr  class="dataheader">
														<td align="center">Year</td>
														<td align="center">Batch No.</td>
														<td align="center">Date of Purchased</td>
														<td align="center">Date of shift to grower shed</td>
														<td align="center">Date of shift to layer shed</td>
														<td align="center">Layer shed no</td>
														<td align="center">Date of first lay</td>
														<td align="center">Date of culling</td>
														<td align="center">Year End</td>
														<td align="center">No.of Brooder weeks</td>
														<td align="center">No.of Grower weeks</td>
														<td align="center">No.of Layer weeks</td>
														<td align="center">No.of Batches Sold</td>
													</tr>
													<%int intTotalPatches=0;
													if(arryBatch !=null && arryBatch.size()>0){
														int bwk=0,gwk=0,lwk=0,cullcount=0,intpurchase=0;
														for (int i = 0; i < arryBatch.size(); i++) {
															arryYear=new ArrayList();
															arryYear=(ArrayList)arryBatch.get(i);
															bwk=0;gwk=0;lwk=0;cullcount=0;intpurchase=0;
															if(arryYear !=null && arryYear.size()>0){
																for (int j = 0; j < arryYear.size(); j++) {
																	String strPrintFlag="false";
																arryCol=new ArrayList();
																arryCol=(ArrayList)arryYear.get(j);
																for (int p=1;p<=intNoofBatches;p++)
																 {
																	if(printYearCheck[p].equalsIgnoreCase(arryCol.get(0).toString())&& (printYearCheckFlag[p].equalsIgnoreCase("false")))
																	{
																		strPrintFlag="true";
																		printYearCheckFlag[p]="true";
																	}
																 }
													%>
														<tr align="center" class="datagrid">
														<%String strPatch=Helper.correctInt((String)arryCol.get(0));
														int inPatch=Integer.parseInt(strPatch);
														if(j==0){%>
														<td><%=i+1 %></td>
															<td><%=arryCol.get(0) %></td>
															
														<%}else{ %>
														<td>&nbsp;</td>
															<td><%=arryCol.get(0) %></td>
														<%} %>
														<%if(strPrintFlag.equalsIgnoreCase("true")) {
														intpurchase=intpurchase+1;%>
														<td><%=arryCol.get(1) %></td>
														<%}else{ %>
														<td>&nbsp;</td>
														<%} %>
														<td><%=arryCol.get(6) %>&nbsp;</td>
														<td><%=arryCol.get(7) %>&nbsp;</td>
														<td><%=Helper.correctNull(strArrShedNo[inPatch-1])%>&nbsp;</td>
														<td><%=arryCol.get(8) %>&nbsp;</td>
														<td><%=arryCol.get(9) %>&nbsp;</td>
														<td><%=arryCol.get(10) %>&nbsp;</td>
														<td><%=arryCol.get(2) %></td>
														<td><%=arryCol.get(3) %></td>
														<td><%=arryCol.get(4) %></td>
														<td>&nbsp;</td>
														</tr>
											<%
											bwk=bwk+Integer.parseInt(Helper.correctInt((String)arryCol.get(2)));
											gwk=gwk+Integer.parseInt(Helper.correctInt((String)arryCol.get(3)));
											lwk=lwk+Integer.parseInt(Helper.correctInt((String)arryCol.get(4)));
											String strCull=arryCol.get(5).toString();
											if(strCull.equalsIgnoreCase("cull"))
											{
												cullcount=cullcount+1;
												intTotalPatches=intTotalPatches+1;
											}
												}}%>
												<tr class="dataheader">
												<td colspan="2">Year <%=i+1 %>&nbsp;<input type="hidden" name="txtpurchase" value="<%=intpurchase %>"></td>
												<td colspan="7" align="right">Total&nbsp;</td>
												<td align="center"><%=bwk %>&nbsp;<input type="hidden" name="txtbwk" value="<%=bwk %>"></td>
												<td align="center"><%=gwk %>&nbsp;<input type="hidden" name="txtgwk" value="<%=gwk %>"></td>
												<td align="center"><%=lwk %>&nbsp;<input type="hidden" name="txtlwk" value="<%=lwk %>"></td>
												<td align="center"><%=cullcount %>&nbsp;<input type="hidden" name="txttotal" value="<%=cullcount %>"></td>
												</tr>				
												<%}}
												%>
												<tr  class="dataheader">
												<td colspan="12" align="right">&nbsp;No of Patches Sold</td>
												<td align="center"><%=intTotalPatches %>&nbsp;</td>
												</tr>
												</table>
												</td>
											</tr>
										</table>
										</td>
									</tr>
								</table>								
							</td></tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<BR>
</td>
</tr>
</table>	
<br>		
<table width="20%" border="0" cellspacing="1" cellpadding="2" align="center">
<tr>
		<td  align="center" nowrap><input type="button" value="Pass Values to the Proposal" onClick="callFunction()" class="buttonOthers"></td>
		<td align="center"><input type="button" value="Close" onClick="doClose()" class="buttonClose"></td>
</tr>
</table>
<input type="hidden" name="hidscheme" value="<%=Helper.correctNull((String)hshValues.get("strSchemetype")) %>">
</form>
</body>
</html>
