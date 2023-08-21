<%@ include file="../share/directives.jsp"%>
<%ArrayList arryRow = (ArrayList) hshValues.get("arryRow");
			ArrayList arryCol = null;
			//String strComm ="";
			String strPar = "";
%>

<html>
<head>
<title>Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
DIV.cellContainer {	
  width: 100%; height: 250;
  overflow: auto;
}
</style>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/setsearch.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="javascript">
<!--
var appURL = "<%=ApplicationParams.getAppUrl()%>";

var strSaveType = "<%=Helper.correctNull(request.getParameter("hidprd_save"))%>";
var strType = "<%=Helper.correctNull(request.getParameter("hid_producttype"))%>";
var strSearchType = "<%=Helper.correctNull(request.getParameter("prd_range"))%>";
var strRangeFrom = "<%=Helper.correctNull(request.getParameter("textrng"))%>";
var strRangeTo = "<%=Helper.correctNull(request.getParameter("textto"))%>";
var strext = "<%=Helper.correctNull(request.getParameter("prd_choose"))%>";
var strcat= "<%=Helper.correctNull(request.getParameter("hidprd_cat"))%>";
var strTerm = "<%=request.getParameter("prd_term")%>";
var varprodavail="<%=Helper.correctNull((String)request.getParameter("hid_prodavail"))%>";

//-->
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="disRadio();loadDatas()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="renew" method="get" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home
		-&gt; Setup -&gt; Retail Products -&gt; Search
		Products </td>
	</tr>
	
</table>

<table width="98%" border="0" cellspacing="0" cellpadding="2" class="outertable" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable"
					align="center">
					<tr>
						<td colspan="3">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
									<tr>
										<td width="8%"><input type="radio" name="prd_choose"
											value="New" style="border-style:none"
											onclick="callLink('New')"></td>
										<td width="23%"><b> Create New</b></td>
										<td width="8%"><input type="radio" name="prd_choose"
											value="Existing" style="border-style:none"
											onclick="showcomm()"></td>
										<td width="23%"><b>Existing Products</b></td>
										<td width="8%"><input type="radio" name="prd_choose"
											value="renew" style="border-style:none" onClick="showcomm()">
										</td>
										<td width="23%"><b>Old Products</b></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
							<tr>
								<td colspan="8">&nbsp;</td>
							</tr>
							<tr>
								<td colspan="8">
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
									<tr>
										<td width="50%">
										<fieldset style="width:450"><legend> <b> Product For</b> </legend>
										
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
											<tr>
												<td width="3%" id="prdtype"><input type="radio"
													name="prd_producttype" value="Retail"
													style="border-style:none" onClick="producttype()" checked="checked">
												</td>
												<td width="46%">Retail</td>
												

											</tr>
										</table>
										</fieldset>
										</td>
										<td>
										<fieldset style="width:450"><legend><b>Save type</b></legend>
										
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
											<tr>
												<td width="3%"><input type="radio" name="prd_save"
													value="Partial" style="border-style:none"
													onClick="saveassign()"></td>
												<td width="46%">Partial</td>
												<td width="8%"><input type="radio" name="prd_save"
													value="Complete" style="border-style:none"
													onClick="saveassign()"></td>
												<td width="46%">Completed</td>
											</tr>
										</table>
										</fieldset>
										</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td colspan="8">
								<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable" align="center"> 
									<tr>
										<td width="50%">

										<fieldset  style="width:450"><legend><b>Search by </b> </legend>
										<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable" align="center">
											<tr >
												<td width="4%"><input type="radio" name="prd_range"
													value="Category" style="border-style:none"
													onClick="showtxt();clears()"></td>
												<td width="21%">Category</td>
												<td width="4%"><input type="radio" name="prd_range"
													value="Range" style="border-style:none"
													onClick="showtxt();clears()"></td>
												<td width="21%">Range</td>
												<td width="4%" id="range1" style="visibility:hidden;">From</td>
												<td width="21%" id="range3" style="visibility:hidden;"><input
													type="text" name="textrng" size="15"
													onKeyPress="notAllowedDouble();allowEntry(document.forms[0].textrng)">
												</td>
												<td width="4%" id="range2" style="visibility:hidden;">To</td>
												<td width="21%" id="range4" style="visibility:hidden;"><input
													type="text" name="textto" size="15"
													onKeyPress="notAllowedDouble();allowEntry(document.forms[0].textto)">
												</td>
											</tr>
										</table>
										</fieldset>
										</td>
										<td>
										<fieldset  style="width:450"><legend><b>Available to Users</b></legend>
										<table width="100%" border="0" cellpadding="2" cellspacing="0" class="outertable" align="center">
											<tr>
												<td width="3%">
                                      <input type="radio" name="prodavail"
													value="Y" checked="checked" style="border-style:none">
                                    </td>
												<td width="46%">Yes</td>
												<td width="8%"><input type="radio" name="prodavail"
													value="N" style="border-style:none"></td>
												<td width="46%">No</td>
											</tr>
										</table>
										</fieldset>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td width="38%"></td>
						<td width="32%" align="right"></td>
						<td width="18%"></td>
					</tr>
				</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
					<tr>
						<td height="20" valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable" align="center">
							<tr>
								<td colspan="4">
								<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable" align="center">
									<tr>
										<td>
										
                                <table width="100%" border="0" cellpadding="1" cellspacing="0" class="outertable" align="center">
                                  <tr class="dataheader">
                                  	<td width="5%" align="center"><b>Sl.No</b></td>
                                    <td width="12%" align="center"><b>Category</b></td>
                                    <td width="17%" align="center"><b>Sub Category 
                                      </b></td>
                                    <td width="9%" align="center"><b>Product Code</b></td>
                                    <td width="30%" align="center"><b>Product 
                                      Description</b></td>
                                    <td width="8%" align="center"><b>Range From 
                                      </b></td>
                                    <td width="10%" align="center"><b>Range To 
                                      </b></td>
                                   
                                    <td width="9%" align="center"><b>Save Type 
                                      </b></td>
                                    <!-- <td width="7%" align="center"><b>Available</b></td>-->
                                  </tr>
                                  <tr> 
                                    <td colspan="8"> 
                                      <div class="cellContainer"> 
                                        <table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
													
                                          <%if (arryRow != null) {
				for (int i = 0; i < arryRow.size(); i++) {
					arryCol = (ArrayList) arryRow.get(i);

					if (Helper.correctNull((String) arryCol.get(7))
							.equalsIgnoreCase("p")) {
						strPar = "Partial";
					} else if (Helper.correctNull((String) arryCol.get(7))
							.equalsIgnoreCase("c")) {
						strPar = "Completed";
					}

					%>
                                          <tr class="datagrid">
                                          	<td width="5%" align="center"><b><%=i+1%></b></td>
                                            <td width="12%" ><b><a
															href="#" onclick="callLink(<%=Helper.correctNull((String)arryCol.get(0))%>)"
															> 
                                              <%=Helper.correctNull((String) arryCol.get(2))%></a></b></td>
                                            <td width="17%" align="left" ><%=Helper.correctNull((String) arryCol.get(3))%></td>
                                            <td width="9%" align="center" ><%=Helper.correctNull((String) arryCol.get(0))%></td>
                                            <td width="30%" align="left" ><%=Helper.correctNull((String) arryCol.get(1))%></td>
                                            <td width="8%" align="right" ><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arryCol
													.get(4))))%></td>
                                            <td width="10%" align="right" ><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arryCol
													.get(5))))%></td>
                                            
											 <td width="9%" align="center" ><%=strPar%></td>
											  <!-- <td width="7%" align="center" ><%=Helper.correctNull((String) arryCol.get(8))%></td> -->
                                          </tr>
                                          <%}
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
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="Get Products_Reset"
btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />

 <lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidprd_type"
	value="<%=Helper.correctNull(request.getParameter("hidprd_type"))%>"> <input
	type="hidden" name="hidprd_term"
	value="<%=Helper.correctNull(request.getParameter("hidprd_term"))%>"> <input
	type="hidden" name="hidprd_save"
	value="<%=Helper.correctNull(request.getParameter("hidprd_save"))%>"> <input
	type="hidden" name="hidprd_cat"
	value="<%=Helper.correctNull(request.getParameter("hidprd_cat"))%>"> <input
	type="hidden" name="hidprd_select"
	value="<%=Helper.correctNull(request.getParameter("hidprd_select"))%>">
<input type="hidden" name="hidprd_rng"
	value="<%=Helper.correctNull(request.getParameter("hidprd_rng"))%>"> <input
	type="hidden" name="prdCode"
	value="<%=Helper.correctNull(request.getParameter("prd_code"))%>"> <input
	type="hidden" name="hid_producttype"
	value="<%=Helper.correctNull(request.getParameter("hid_producttype"))%>">
<input type="hidden" name="hid_prodavail" value="<%=Helper.correctNull(request.getParameter("hid_prodavail"))%>"/>
</form>
</body>
</html>

