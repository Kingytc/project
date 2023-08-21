<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>

<html>
<head>
<title>Productwise Status Reports</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 150;
	overflow: auto;
}
</STYLE>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/per/perrepappproduct.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>

var path="<%=ApplicationParams.getAppUrl()%>";
var bnkname="";
var param="";
var userid ="<%=(String) session.getAttribute("strUserId")%>";
var rights ="<%=(String) session.getAttribute("strGroupRights")%>";

function callCalender(fname)
 {
	 showCal(path,fname);
 }
 
 function menuOptionDivMouseDown (url) {
		//if (! isMac) {
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			//window.location=url;
			document.forms[0].action=url;
			document.forms[0].submit();
			//}
		}
function changeLoanType()
{	 
 	if(document.forms[0].prodttype.value.toUpperCase()=="A")
 	{
	 	document.forms[0].prodcat.length=22;
	 	document.forms[0].prodcat.options[1] = new Option('Poultry Boiler','A');
	 	document.forms[0].prodcat.options[2] = new Option('Bullock Cart','B');
        document.forms[0].prodcat.options[3] = new Option('Crop Loans','C');
        document.forms[0].prodcat.options[4] = new Option('Diary Farming','D');
        document.forms[0].prodcat.options[5] = new Option('Animal Rearing','E');
        document.forms[0].prodcat.options[6] = new Option('Farm Machinery','F');
        document.forms[0].prodcat.options[7] = new Option('Gobar Gas Plant','G');
        document.forms[0].prodcat.options[8] = new Option('Gold Loan','H');
        document.forms[0].prodcat.options[9] = new Option('Consumption Loan','I');
        document.forms[0].prodcat.options[10] = new Option('Sericulture','J');
        document.forms[0].prodcat.options[11] = new Option('Loan Against Warehouse Receipts','L');
        document.forms[0].prodcat.options[12] = new Option('Vehicle Loan','M');
        document.forms[0].prodcat.options[13] = new Option('Fisheries','N');
        document.forms[0].prodcat.options[14] = new Option('Poultry Layering','P');
        document.forms[0].prodcat.options[15] = new Option('Plantation Term Loan','Q');
        document.forms[0].prodcat.options[16] = new Option('Loan Against deposit','R');
		document.forms[0].prodcat.options[17] = new Option('Minor Irrigation','U');
		document.forms[0].prodcat.options[18] = new Option('Common Product','K');
		document.forms[0].prodcat.options[19] = new Option('Union General Credit Card','V');
		document.forms[0].prodcat.options[20] = new Option('Purchase of fodder','T');
		document.forms[0].prodcat.options[21] = new Option('Union Bhumiheen Card','W');
        document.forms[0].prodcat.options[22] = new Option('Coffee Plantation','O'); 
		
     }
  	if(document.forms[0].prodttype.value.toUpperCase()=="P")
	{
		document.forms[0].prodcat.length=15;
		document.forms[0].prodcat.options[1] = new Option('Housing Loan','H');
		document.forms[0].prodcat.options[2] = new Option('Salaried Person','P');
		document.forms[0].prodcat.options[3] = new Option('Vehicle Loan','A');
		document.forms[0].prodcat.options[4] = new Option('Mortgage Loan','M');
		document.forms[0].prodcat.options[5] = new Option('Gold Loans','G');
		document.forms[0].prodcat.options[6] = new Option('Loan against Deposits','R');
        document.forms[0].prodcat.options[7] = new Option('Mahila Udyog','U');
        document.forms[0].prodcat.options[8] = new Option('Ravi Kiran','K');
        document.forms[0].prodcat.options[9] = new Option('Education Loan','E');
        document.forms[0].prodcat.options[10] = new Option('Leased Loan','L');
        document.forms[0].prodcat.options[11] = new Option('Instacash Loan','I');
        document.forms[0].prodcat.options[12] = new Option('Clean Loan','C');
        document.forms[0].prodcat.options[13] = new Option('NSC Loan','N');
        document.forms[0].prodcat.options[14] = new Option('Suvidha Loan','V');
        document.forms[0].prodcat.options[15] = new Option('General Loan','J');
 	}
}

function setParam()
{
	var opfields="";
	var dbfields="";
	var orgcode="";
	var orgname="";
	var count=0;
	var prd="";
	var org="";
	param="";
	var org_name="";
	
	if(document.forms[0].sellevel.selectedIndex != 0 
		&& document.forms[0].prodcat.selectedIndex != 0  
		&&	document.forms[0].rpselect1.selectedIndex != -1 
		&&	document.forms[0].rpprod.selectedIndex != -1 ) 
	{
	//if (document.forms[0].txtDate.value == "")
	//{
	//	document.forms[0].txtDate.value="All";
	//}
   var dt =document.forms[0].txtDate.value;
	var cat =document.forms[0].prodcat.options[document.forms[0].prodcat.selectedIndex].value;
	//var subcat =document.forms[0].subcat.options[document.forms[0].subcat.selectedIndex].value;
		
		for (i=0;i<document.forms[0].rpselect2.length;i++)
        {
			if (document.forms[0].rpselect2.options[i].selected == true)
			{
				count++;
			}
        }

//		if(count < 6)
		if(count == 0)
		{
//			for(i=0;i<6;i++)
			for(i=0;i<6;i++)
			{
				document.forms[0].rpselect2.options[i].selected = true;
			}
		}
		
		
		
	orgcode =document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].text;
   
   
   
   
    count =0;
		for(x=0;x<document.forms[0].rpselect1.length;x++)
		{
			if (document.forms[0].rpselect1[x].selected)
			{
				count++;
				var c = document.forms[0].rpselect1.options[x].value;
				c = c.substring(2,c.length);
				org =org + c+",";
				c = document.forms[0].rpselect1.options[x].text;
				org_name =org_name + "," + c ;		
			}
		}
		if (count > 0)
		{
			org= org.substring(0,org.length-1);
			org_name= org_name.substring(1,org_name.length);
		}
		
		count =0;
		var subcat="";
		for(x=0;x<document.forms[0].rpprod.length;x++)
		{
			if (document.forms[0].rpprod[x].selected)
			{
				count++;
				prd =prd +document.forms[0].rpprod.options[x].text+",";
				subcat =subcat +document.forms[0].rpprod.options[x].value+",";
			}										
			
		}
		if (count > 0)
		{
			prd= prd.substring(0,prd.length-1);
			subcat= subcat.substring(0,subcat.length-1);
		}				
		
   
    param =orgcode+";"+org+";"+subcat+";"+dt+";P;P;";

		count =0;
		for(x=0;x<document.forms[0].rpselect2.length;x++)
		{
			
				count++;
				opfields =opfields +document.forms[0].rpselect2.options[x].value+",";
				dbfields =dbfields +document.forms[0].rpselect2.options[x].text+",";
							
			
		}
		//dbfields =dbfields + "Proposal Type,";
		//opfields =opfields + "app_renew_flag,";
		if (count > 0)
		{
			dbfields= dbfields.substring(0,dbfields.length-1);
			opfields= opfields.substring(0,opfields.length-1);
		}
	
	param +=opfields+";";
	param +=dbfields;

	document.forms[0].hidParam.value=param;
	document.forms[0].hidOrgCode.value =org;	
	document.forms[0].hidOpFields.value =opfields;	
	document.forms[0].hidSelFields.value =dbfields;	
	document.forms[0].hidCatFields.value =subcat;
	document.forms[0].hidOrgName.value =org_name;	
	document.forms[0].hidprd.value =prd
	}
	else if(document.forms[0].sellevel.selectedIndex == 0)
	{
		ShowAlert('111',"Organisation Level");
		document.forms[0].sellevel.focus();
		return false;
	}
	else if(document.forms[0].prodcat.selectedIndex == 0)
	{
		ShowAlert('111',"Category");
		document.forms[0].prodcat.focus();
		return false;
	}
	
	else if(document.forms[0].rpselect1.selectedIndex == -1)
	{
		ShowAlert('111','Organisation');
		document.forms[0].rpselect1.focus();
		return false;
	}
		else if(document.forms[0].rpprod.selectedIndex == -1)
	{
		ShowAlert('111','Product');
		document.forms[0].rpprod.focus();
		return false;
	}
	
	return param;
}

//-->
</script>
</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
<form name="orgfrm" method="post" class="normal"><iframe height="0" width="0"
	id="ifrm" frameborder=0 style="border: 0"></iframe> <br>
<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="page_flow">Home -&gt; Retail -&gt; Reports -&gt;
		Productwise Status Reports
	</tr>
	<tr>
		<td align="right">&nbsp;</td>
	</tr>
</table>
<table class="outertable"  width="100%" border="1" cellspacing="0" cellpadding="20">
	<tr>
		<td valign="middle">
		<table class="outertable"  width="90%" border="1" cellspacing="0" cellpadding="3"
			align="center">
			<tr>
				<td>
				<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="5"
					align="center">
					<tr>
						<td width="24%">Organisation Level</td>
						<td rowspan="10">
						<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="4">
							<tr align="center">
								<td align="center" width="34%">Select Organisation</td>
								<td align="center" width="60%">Select Product</td>
								<td align="center" width="6%">&nbsp;</td>
							</tr>
							<tr align="center">
								<td width="34%"><select name="rpselect1" size="11"
									style="width: 180" onChange="selectProd()" tabindex="4">
								</select></td>
								<td width="60%"><select name="rpprod" size="11"
									style="width: 350" tabindex="5">
								</select></td>
								<td width="6%"><select name="rpselect2" size="11"
									style="width: 15%;visibility:hidden" multiple tabindex="6">
									<option value="1">Proposal Number</option>
									<option value="2">Applicant Name</option>
									<option value="3">Date Approved</option>
									<option value="4">Loan Amount Applied</option>
									<option value="5">Loan Amount Sanctioned</option>
								    <option value="5">Proposal Type</option>
									
								</select></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td width="24%" height="41"><select name="sellevel"
							style="width: 250" onChange="selectValues()" tabindex="1">
							<option selected>---Select---</option>
							<laps:reptag beanid="setupreport" methodname="getLevels" param="" />
						</select></td>
					</tr>
					<tr>
						<td width="24%" align="left">Loan Type</td>
					</tr>
					<tr>
						<td width="24%"><select name="prodttype" style="width: 250"
							onChange="changeLoanType()" tabindex="2">
							<option selected value="0">---Select---</option>
							<option value="p">Retail</option>
						</select></td>
					</tr>
					<tr>
						<td width="24%" align="left">Category</td>
					</tr>
					<tr>
						<td width="24%"><iframe height="0" width="0" id="ifrmp"
							frameborder=0 style="border: 0"></iframe> <select name="prodcat"
							style="width: 250" tabindex="2" onchange="deSelect()">
							<option selected value="0">---Select---</option>
						</select></td>
					</tr>
					<tr>
						<td>Period</td>
					</tr>
					<tr>
						<td><input type="text" name="txtDate" maxlength="21" readonly
							size="25" onFocus="document.forms[0].cmdrunreport.focus();">
						<a href="#" onClick="showPeriod()"><b class="fontstyle"
							tabindex="7">?</b></a></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="Run Report_Reset"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
   <lapschoice:hiddentag pageid='<%=PageId%>'/> <input
	type="hidden" name="hidOrgCode"> <input type="hidden"
	name="hidOpFields"> <input type="hidden" name="hidSelFields">
<input type="hidden" name="hidCatFields"> <input type="hidden"
	name="userid"> <input type="hidden" name="repname"
	value="Personal Credit Activity Report"> <input type="hidden"
	name="txtprofile_name"> <input type="hidden" name="hidParam">
<input type="hidden" name="hidOrgName"> <input type="hidden"
	name="hidprodcat_text" value=""> <input type="hidden"
	name="hidPage" value="perrunappcredit.jsp"> <input
	type="hidden" name="txtSaveDate"
	value='<%=Helper.getCurrentDateTime()%>'> <input type="hidden"
	name="hidprd"></form>
</body>
</html>
