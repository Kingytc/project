<%@ include file="../../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%
	String str_report = Helper.correctNull((String) request.getParameter("report"));
	String str_multiple = "";
	if (str_report.equalsIgnoreCase("C")) {
		str_multiple = "multiple";
	} else {
		str_multiple = "";
	}
%>

<% ArrayList ArrRow=new ArrayList();
ArrayList ArrCol=new ArrayList();
ArrRow=(ArrayList)hshValues.get("ArrValues");
ArrayList ArrSolRow=(ArrayList)hshValues.get("ArrRow");
ArrayList ArrKpowRow=(ArrayList)hshValues.get("ArrKpowerRow");
int arrsize=0,arrSolsize=0,arrKpowersize=0;
if(ArrRow !=null)
{
	arrsize=ArrRow.size();
}
if(ArrSolRow!=null)
arrSolsize=ArrSolRow.size();
if(ArrKpowRow!=null)
	arrKpowersize=ArrKpowRow.size();
java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
jtn.setMaximumFractionDigits(2);
jtn.setMinimumFractionDigits(2);
jtn.setGroupingUsed(false);
%>

<html>
<head>
<title>DataValuation</title>

<script>
var path="<%=ApplicationParams.getAppUrl()%>";
var param="";
var userid ="<%=(String) session.getAttribute("strUserId")%>";
var rights ="<%=(String) session.getAttribute("strGroupRights")%>";
var report = "<%=str_report%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";

//alert(report);
</script>
<script>
	function callonLoad()
	{
			document.forms[0].hidBeanId.value="perrepappstatus";
			

	}

	function selectValues()
	{
		//document.forms[0].rpselect1.selectedIndex =-1;
		var bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
		document.all.ifrm.src=path+"action/iframeapprep.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname;
	}

	function showPeriod()
	{
		var purl = path+"jsp/share/repdateselect.jsp";
		var title = "ListofPeriod";
		var prop = "scrollbars=no,width=400,height=400";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 320) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,title,prop);
	}
	function doRunReport()
	{
		
		
		if(document.forms[0].sellevel.selectedIndex == 0)
		{
			ShowAlert('111',"Organisation Level");
			document.forms[0].sellevel.focus();
			return;
		}
		/*if(document.forms[0].rpselect1.selectedIndex == -1)
		{
			ShowAlert('111','Organisation');
			document.forms[0].rpselect1.focus();
			return;
		}*/
	
	
		if (document.forms[0].txtDate.value == "")
		{
		ShowAlert('121',"Period");
		document.forms[0].txtDate.focus();
		return false;
		}
		var level=document.forms[0].sellevel.value;
		//var orgselect=document.forms[0].rpselect1.value;
		var org_name="";
		var period=document.forms[0].txtDate.value;
		var org="";

		var count =0;
		/*for(x=0;x<document.forms[0].rpselect1.length;x++)
		{
			if (document.forms[0].rpselect1[x].selected)
			{
				count++;
				var c = document.forms[0].rpselect1.options[x].value;
				c = c.substring(2,c.length);
				org =org + "'"+c+"'"+",";
				
					c = document.forms[0].rpselect1.options[x].text;
					org_name =org_name + "," + c ;
			}
		}*/
		if (count > 0)
		{
			org= org.substring(0,org.length-1);
			org_name= org_name.substring(1,org_name.length);
		}
		
			document.forms[0].method="post";
			window.open(path+"action/com_datavalrunreport.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getDataValuationReport&sellevel="
						+level
						+"&org_name="+org
					    +"&txtDate="+period
						,"","scrollbars=Yes,toolbars=NO,menubar=NO ,width=900 , height=500,top=10,left=10");
	}

	
	function doExcelExport()
	{
		
		if(document.forms[0].sellevel.selectedIndex == 0)
		{
			ShowAlert('111',"Organisation Level");
			document.forms[0].sellevel.focus();
			return;
		}
		/*if(document.forms[0].rpselect1.selectedIndex == -1)
		{
			ShowAlert('111','Organisation');
			document.forms[0].rpselect1.focus();
			return;
		}*/
		if (document.forms[0].txtDate.value == "")
		{
		ShowAlert('121',"Period");
		document.forms[0].txtDate.focus();
		return false;
		}
		var level=document.forms[0].sellevel.value;
		//var orgselect=document.forms[0].rpselect1.value;
		var org_name="";
		var period=document.forms[0].txtDate.value;
		var org="";

		var count =0;
		/*for(x=0;x<document.forms[0].rpselect1.length;x++)
		{
			if (document.forms[0].rpselect1[x].selected)
			{
				count++;
				var c = document.forms[0].rpselect1.options[x].value;
				c = c.substring(2,c.length);
				org =org + "'"+c+"'"+",";
				
					c = document.forms[0].rpselect1.options[x].text;
					org_name =org_name + "," + c ;
			}
		}*/
		if (count > 0)
		{
			org= org.substring(0,org.length-1);
			org_name= org_name.substring(1,org_name.length);
		}
		
			var FileName='DataValuationExcelReport';
			var prop="scrollbars=no,menubar=no,width=1400, height=650, top=10, left=10";
		    window.open(path+"action/"+FileName+".xls?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getXLDataValuationReport&sellevel="+level+"&org_name="+org+"&txtDate="+period,"BuilderReport",prop);    	
			
	}
	function doReset()
	{
		document.forms[0].sellevel.options[0].selected =true;
		//document.forms[0].rpselect1.length =0;
		document.forms[0].txtFromDate.value="";
		document.forms[0].txtToDate.value="";
		document.forms[0].seldepartment.value="S";
		document.forms[0].seldesignaion.value="S";

	}
	function doClose()
	{
		if (ConfirmMsg("100"))
		{
		document.forms[0].hidBeanId.disabled=true;
		document.forms[0].action=path+"action/repnav.jsp?hidreportmis=DataValuation";
		document.forms[0].submit();
		}
	}
	function callCalender(cmdname) {
			showCal(appURL, cmdname);
	}
	/*function showValuersName()
	{
		var prop = "scrollbars=yes,width=500,height=400,top=100,left=250";
		var url=appURL+"action/valuersname.jsp?hidBeanId=staticdata&hidBeanGetMethod=getValuerMasterList&hidAction=search&strfrom=Securities&hidAppVal="+strAppVar+"&strsecuritytype="+strsecuritytype+"&strSecValue="+document.forms[0].txt_total_secval.value;
		window.open(url,"",prop);
		document.forms[0].txt_Valuers_name.readOnly=true;
	}*/
	
</script>
</head>
<body onload="">
<form name="perappstat" method="post" class="normal"><iframe
	height="0" width="0" id="ifrm" frameborder=0 style="border: 0"></iframe>
<br>
<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="0">
	<tr>
		<td class="page_flow">Home -&gt; Reports -&gt; DataValuation
		Reports</td>
	</tr>
	<tr>
		<td align="right">&nbsp;</td>
	</tr>
</table>
<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="20">
	<tr>
		<td valign="middle">
		<table class="outertable border1 tableBg" border="0" cellspacing="0" cellpadding="3"
			align="center" width="65%">
			<tr>
				<td>
				<table class="outertable" width="100%" border="0" cellspacing="0"
					cellpadding="5" align="center">
					<tr>
						<td colspan="2" height="30">
						<table class="outertable" width="100%" border="0" cellspacing="0"
							cellpadding="3">
							<tr>
								<td width="39%" align="center">Organisation Level</td>
							</tr>
							<tr>
								<td width="39%" align="center"><select name="sellevel"
									style="width: 100px;" onChange="selectValues();" tabindex="1">
									<option selected>---Select---</option>
									<laps:reptag beanid="setupreport" methodname="getOrgLevels"
										param="" />
								</select></td>
							</tr>

						</table>
						</td>
					</tr>
				<!-- 	<tr>
						<td width="75%" valign="top" colspan="2">
						<table class="outertable" width="100%" border="0" cellspacing="0"
							cellpadding="4">
							<tr align="center">
								<td width="50%">Select Organisation</td>
								<td width="50%">Name of the Valuer</td>
							</tr>
							<tr align="center">
								<td width="50%"><select name="rpselect1" size="11"
									style="width: 230" tabindex="3" <%=str_multiple%>>
								</select></td>
								<td width="50%"><select name="" size="11"
									style="width: 230" tabindex="3">
								</select></td>
							</tr>

						</table>
						</td>
					</tr> -->
					<tr align="center">
						<td align="center" colspan="2">
						<table class="outertable border1" width="69%" border="0" cellspacing="0"
							cellpadding="3" align="center">
							<tr>
								<td>
								<table class="outertable" width="100%" border="0"
									cellspacing="0" cellpadding="0" align="center">
									<tr>
										<td width="21%" align="center">Period</td>
										<td width="79%" align="center"><input type="text"
											name="txtDate" maxlength="21" readonly size="25"
											onFocus="document.forms[0].cmdrunreport.focus();"> <a
											href="#" onClick="showPeriod()" class="blackfont"
											tabindex="6"><b>?</b></a></td>
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
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="Run Report_Excel Export_Reset" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
 <input type="hidden"
	name="hidOrgCode"> <input type="hidden" name="userid">
<input type="hidden" name="hidusr_id"> <input type="hidden"
	name="txtSaveDate" value='<%=Helper.getCurrentDateTime()%>'> <input
	type="hidden" name="hidOrgName"> <iframe height="0" width="0"
	name="ifrmsancauthority" frameborder="0" style="border: 0"></iframe> <input
	type="hidden" name="report" value="<%=str_report %>"></form>
</body>
</html>
