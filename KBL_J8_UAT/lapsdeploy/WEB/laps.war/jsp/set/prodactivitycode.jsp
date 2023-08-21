<%@ include file="../share/directives.jsp"%>
<%
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=new ArrayList();
	if(hshValues!=null&&hshValues.size()>0)
	{
		arrRow=(ArrayList)hshValues.get("arrRow");
	}
	String prdcode=Helper.correctNull((String) hshValues.get("strmodule"));
%>
<html>
<head>
<title>Setup(Activity Code)</title>
<script language="JavaScript">
var val = "<%=request.getParameter("hidval")%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function setValues()
{
	<%		if(arrRow!=null&&arrRow.size()>0)
		{
			for(int i=0;i<arrRow.size();i++)
			{
				arrCol=new ArrayList();
				arrCol=(ArrayList)arrRow.get(i);
			%>
				document.forms[0].sel_ActivityCodeChosen.options[<%=i%>] = new Option("<%=Helper.correctNull((String)arrCol.get(1))%>","<%=Helper.correctNull((String)arrCol.get(0))%>");
			<%
			}
		}
	%>
	//sortSelect(document.forms[0].sel_ActivityCodeChosen);
}
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/prodactivitycode.js"></script>
</head>
<body onload="callOnLoad();setValues();loadUsedApp();">
<form name="prdactivitycode" method="post" action="<%=ApplicationParams.getAppUrl()%>controllerservlet" class="normal">
<% if (prdcode.equalsIgnoreCase("c")||prdcode.equalsIgnoreCase("a")){%>
<lapstab:setproductstabcorp tabid="8"/>
<% } else {%>
<lapstab:setproductstab tabid="11" prdtype='<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>'/>
<%} %>
<% if (prdcode.equalsIgnoreCase("c")||prdcode.equalsIgnoreCase("a")){%>  
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
<tr>
	<td class="page_flow">Home -&gt; Setup -&gt; Corporate & Agri Products  &amp; Facility Creation -&gt; Activity Code</td>
</tr>
</table>
<%}else {%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
<tr>
	<td class="page_flow">Home -&gt; Setup -&gt; Retail &amp; Agriculture Products -&gt; Products -&gt; Activity Code</td>
</tr>
</table>
<%}%>
<table width="100%" border="0" cellspacing="3" cellpadding="0" class="outertable" align="center">
<tr>
	<td>
		<table width="100%" border="0" cellspacing="3" cellpadding="0" class="outertable" align="center">
		<tr>
			<td>
				<table width="100%" border="0" cellspacing="3" cellpadding="0" class="outertable">
				<tr> 
					<td valign="top"> 
					<fieldset> 
						<table width="100%" border="0" cellspacing="3" cellpadding="0" class="outertable">
						<tr> 
						<%if (prdcode.equalsIgnoreCase("c")||prdcode.equalsIgnoreCase("a"))	{%>
							<td><lapschoice:facility /></td>
						<%} else {%>
							<td> <lapschoice:products /></td>
						<%}	%>
						</tr>
						</table>
					</fieldset> 
					</td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<table class="outertable border1" width="98%" cellspacing="0" cellpadding="1" border="0" align="center"> 
				<tr>
					<td>
						<table align="center" width="90%" border="0" cellspacing="7" cellpadding="0" class="outertable">
						<tr>
							<td width="45%" align="center" class="dataheader">Select Activity Codes</td>
							<td width="10%">&nbsp;</td>
							<td width="45%" align="center" class="dataheader">Selected Activity Codes</td>
						</tr>
						<tr>
							<td align="center">
								<select multiple="multiple" name="sel_ActivityCode" size="10" style="width: 95%">
									<lapschoice:MISActivityCodeTag apptype=""/>
								</select>
							</td>
							<td align="center">
								<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">
								<tr>
									<td align="center">
										<input type="button" name="cmdMove" value="Move"
											class="buttonOthers" onClick="javascript:selectedProduct()">
									</td>
								</tr>
								<tr>
									<td>&nbsp;
									</td>
								</tr>
								<tr>
									<td align="center">
										<input type="button" name="cmdRemove" value="Remove"
											class="buttonOthers" onClick="javascript:checkRemove()">
									</td>
								</tr>
								</table>
							</td>
							<td align="center">
								<select multiple="multiple" name="sel_ActivityCodeChosen" size="10" style="width: 95%" onDblClick="checkRemove()">
								</select>
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
<tr><td>&nbsp;</td></tr>
</table>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidProductType" value="<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>">
<input type="hidden" name="hidActivityCodeChosen" value="">
<input type="hidden" name="checkApp" value="<%=request.getParameter("checkApp")%>">
<input type="hidden" name="hidmoduletype" value="<%=Helper.correctNull((String) hshValues.get("strmodule"))%>">
</form>
</body>
</html>