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



<html>
<head>
<title>MSME Report Generation</title>

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
		document.forms[0].rpselect1.selectedIndex =-1;
		var bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
		document.all.ifrm.src=path+"action/iframeapprep.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname;
	}

	function showPeriod()
	{
		document.forms[0].txtDate.value="";
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
		if(document.forms[0].sellevel.value=="")
		{
			alert("Select Organisation Level");
			return;
		}
		
		if(document.forms[0].rpselect1.value=="")
		{
			alert("Select Organisation");
			return;
		}
		if (document.forms[0].txtDate.value == "")
		{
			ShowAlert('121',"Period");
			document.forms[0].txtDate.focus();
			return false;
	    }
		if (document.forms[0].txt_cbsid.value == "" && document.forms[0].txt_proposalno.value =="" )
		{
			alert("Enter atleast one Customer ID/Proposal No")
			return false;
	    }
	    varCBS=document.forms[0].txt_cbsid.value
	    varCBS=varCBS.toUpperCase();
		if (document.forms[0].txt_cbsid.value != "" && varCBS != "ALL" )
		{
			var regex =  /^\d+$/;
		
        var isValid = regex.test(document.forms[0].txt_cbsid.value);
        if (!isValid) {
            alert("Not a Valid Customer ID");
            document.forms[0].txt_cbsid.value = "";
            document.forms[0].txt_cbsid.focus();
			return false;
        } }
		
		if (document.forms[0].txt_cbsid.value.length != ""  && document.forms[0].txt_cbsid.value.length != 9  && varCBS != "ALL"){
			alert("Customer ID should be of 9 characters")
			return false;
		}
		if (document.forms[0].txt_proposalno.value !="" && document.forms[0].txt_proposalno.value.length != 11){
			alert("Proposal Number should be of 11 characters")
			return false;
		}
	    
		var code =document.forms[0].rpselect1.value;
		var orglevel=document.forms[0].sellevel.value;
		
		var txtDate=document.forms[0].txtDate.value;
		var sdt=document.forms[0].txtSaveDate.value;
		var orgname = document.forms[0].hidOrgName.value;
		var cbsid=document.forms[0].txt_cbsid.value;
		var appno=document.forms[0].txt_proposalno.value;
		
		var count =0;
		var org="";
		var org_name="";
		for(x=0;x<document.forms[0].rpselect1.length;x++)
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
		}
		if (count > 0)
		{
			org= org.substring(0,org.length-1);
			org_name= org_name.substring(1,org_name.length);
		}
		var prop = "scrollbars=yes,width=1100,height=700,top=25,left=180";
		var url=appURL+"action/msmerunrepot.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getMsmeReport&txtDate="+txtDate+"&txtSaveDate="+sdt+"&hidOrgCode="+org+"&orglevel="+orglevel+"&hidOrgName="+org_name+"&cbsid="+cbsid+"&appno="+appno;
		window.open(url,"MSME",prop);			
	}

	function doReset()
	{
		document.forms[0].sellevel.options[0].selected =true;
		document.forms[0].rpselect1.length =0;
		document.forms[0].txtDate.value="";
		
		document.forms[0].txt_cbsid.value="";
		document.forms[0].txt_proposalno.value="";
	}
	function doClose()
	{
		if (ConfirmMsg("100"))
		{
		document.forms[0].hidBeanId.disabled=true;
		document.forms[0].action=path+"action/repnav.jsp";
		document.forms[0].submit();
		}
	}
	function callCalender(cmdname) {
			showCal(appURL, cmdname);
	}
	
</script>
</head>
<body onload="">
<form name="perappstat" method="post" class="normal"><iframe
	height="0" width="0" id="ifrm" frameborder=0 style="border: 0"></iframe>
<br>
<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="0">
	<tr>
		<td class="page_flow">Home -&gt; Reports -&gt; MSME
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
								<td width="30%" align="center">Organisation Level</td>
						        <td width="30%" align="center">CBS Customer ID</td>
				                <td width="30%" align="center">MSME Proposal Number</td>										
								
							</tr>
							<tr>
								<td width="30%" align="center"><select name="sellevel"
									style="width: 100px;" onChange="selectValues();" tabindex="1">
									<option selected>---Select---</option>
									<laps:reptag beanid="setupreport" methodname="getOrgLevels"
										param="" />
								</select></td>
								<td width="30%" align="center"><input type="text" maxlength="11" name="txt_cbsid" value="" style="text-transform: uppercase" onkeypress="allowAlphaNumeric();">
								<td width="30%" align="center"><input type="text" maxlength="11" name="txt_proposalno" value="" onkeypress="allowInteger();">
								
							</tr>

						</table>
						</td>
					</tr>
					<tr>
						<td width="75%" valign="top" colspan="2">
						<table class="outertable" width="100%" border="0" cellspacing="0"
							cellpadding="4">
							<tr align="center">
								<td width="50%">Select Organisation</td>
							</tr>
							<tr align="center">
								<td width="50%"><select name="rpselect1" size="11"
									style="width: 230" tabindex="3" <%=str_multiple%>>
								</select></td>
							</tr>

						</table>
						</td>
					</tr>
					<tr align="center">
						<td align="center" colspan="2">
						<table class="outertable border1" width="69%" border="0" cellspacing="0"
							cellpadding="3" align="center">
							<tr>
								<td>
								<table class="outertable" width="100%" border="0"
									cellspacing="0" cellpadding="0" align="center">
									<tr>
												<td width="21%" align="center">Sanctioned between period</td>
												<td width="79%" align="center">&nbsp; <input
													type="text" name="txtDate" maxlength="21" readonly
													size="27" onFocus="document.forms[0].cmdrunreport.focus();">
												<a href="#" onClick="showPeriod()" tabindex="5">?</a></td>
											</tr>
												</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr><td style="color:red;font-size:14px;align-center;">*If entire report during the period is required then enter <b>ALL</b> in Customer ID field</td></tr>
							
				</table>
				</td>
			</tr>
			<
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="Run Report_Reset" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
 <input type="hidden"
	name="hidOrgCode"> <input type="hidden" name="userid">
<input type="hidden" name="hidusr_id"> <input type="hidden"
	name="txtSaveDate" value='<%=Helper.getCurrentDateTime()%>'> <input
	type="hidden" name="hidOrgName"> <iframe height="0" width="0"
	name="ifrmsancauthority" frameborder="0" style="border: 0"></iframe> <input
	type="hidden" name="report" value="<%=str_report %>"></form>
		<input type="hidden" name ="hidOrgCode" value ="">
	<input type="hidden" name="repname" value ="">
	<input type="hidden" name="txtDate1" value='<%=Helper.getCurrentDateTime()%>'>
</body>
</html>
