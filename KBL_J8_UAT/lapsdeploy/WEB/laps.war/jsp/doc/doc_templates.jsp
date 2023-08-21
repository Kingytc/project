<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Insert title here</title>
<script>
	function keywordselect() {
		var keywordname = document.forms[0].keywordlist.value;
		if (keywordname != "") {
			document.all.ifrm.src = appURL
					+ "action/iframeDynamicDocKeyword.jsp?keywordname="
					+ keywordname;
		}
	}
	function callClose()
	{
		window.close();
	}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form method=post class="normal">
<table width="96%" border="0" cellspacing="0" cellpadding="3"
	align="center" class="outertable">
	<tr>
		<td valign="top">
		<table width="96%" border="0" cellspacing="0" cellpadding="3"
			align="center" class="outertable">
			<tr>
				<td class="dataheader">Keywords</td>
			</tr>
			<tr>
				<td><select multiple size="12" name="keywordlist"
					onclick="keywordselect()">
					<option value="ParticularsofSecurityPledged">SecurityPledged---@ParticularsofSecurityPledged</option>
					<option value="ParticularsofInstallments">ParticularsofInstallments---@ParticularsofInstallments</option>
					<option value="DescriptionofSecurity">DescriptionofSecurity---@DescriptionofSecurity</option>
					<option value="scheduleTAB">scheduleTAB---@scheduleTAB</option>
					<option value="Descriptionofgoldornaments">Descriptionofgoldornaments---@Descriptionofgoldornaments</option>
					<option value="Activity">Activity---@Activity</option>
					<option value="Areaundercultivation">Areaundercultivation---@Areaundercultivation</option>
					<option value="Agridev">Agridev---@Agridev</option>
					<option value="CreditFacilities">CreditFacilities---@CreditFacilities</option>
					<option value="Litigations">Litigations---@Litigations</option>
					<option value="ParticularsofDoc">ParticularsofDoc---@ParticularsofDoc</option>
					<option value="guadetails">Guarantor details---@guadetails</option>
					<option value="guaAddress">Guarantor Address---@guaAddress</option>
					<option value="coappDetails">co-applicant Details---@coappDetails</option>
				   	<option value="coappAddress">co-applicant Address---@coappAddress</option>
				   	<option value="appDetails">Applicant Details---@appDetails</option>
				   	<option value="appAddress">Applicant Address---@appAddress</option>
				   	
				   	<option value="CoobligantDetails">Co-obligant Details---@CoobligantDetails</option>
				   	<option value="CoobligantAddress">Co-obligant Address---@CoobligantAddress</option>
				   	<option value="ProprietorDetails">Proprietor Details---@ProprietorDetails</option>
				   	<option value="ProprietorAddress">Proprietor Address---@ProprietorAddress</option>
				   	
				   	<option value="InstallmentsDetails">Installment Details---@InstallmentsDetails</option>
					<option value="TitleDeedDepositDetails">TitleDeed Deposit Details---@TitleDeedDepositDetails</option>
					
					<option value="HypothecationDescription">Hypothecation Description---@hypsecdesc</option>
					<option value="EquitablemortgageDescription">Equitable mortgage Description---@emsecdesc</option>
					<option value="AssignmentDescription">Assignment Description---@assecdesc</option>
					<option value="PledgeDescription">Pledge Descriptoin---@plsecdesc</option>
					<option value="RegisteredMortgageDescription">Registered Mortgage Description---@rmsecdesc</option>
					<option value="TransferableDescription">Transferable Description---@trsecdesc</option>
					
					<option value="HypothecationAddress">hypothecation  Address---@hysecurityowneraddress</option>
					<option value="EquitableMortgageAddresss">Equitable Mortgage Addresss---@emsecurityowneraddress</option>
					<option value="AssignmentAddress">Assignment Address---@assecurityowneraddress</option>
					<option value="PledgeAddress">Pledge Address---@plsecurityowneraddress</option>
					<option value="RegisteredMortgageAddress">Registered Mortgage Address ---@rmsecurityowneraddress</option>
					<option value="TransferableAddress">Transferable Address---@trsecurityowneraddress</option>
					
					<option value="HypothecationDetails">Hypothecation Details---@hysecurityownerdetails</option>
					<option value="EquitableMortgageDetails">Equitable Mortgage Details---@emsecurityownerdetails</option>
					<option value="AssignmentDetails">Assignment Details---@assecurityownerdetails</option>
					<option value="PledgeDetails">Pledge Details---@plsecurityownerdetails</option>
					<option value="RegisteredMortgageDetails">Registered Mortgage Details---@rmsecurityownerdetails</option>
					<option value="TransferableDetails">Transferable Details---@trsecurityownerdetails</option>
					
					<option value="StockPremisesOwneraddress">Stock Premises Owneraddress---@stockpremisesowneraddress</option>
		            <option value="StockPremisesOwnerdetails">Stock Premises Ownerdetails---@stockpremisesownerdetails</option>
					<option value="StockHypothecation">Stock Hypothecation---@stockhypothecation</option>@livestockhypothecation
					<option value="BookDebtHypothecation">Book Debt Hypothecation---@bookdebtshypothecation</option>
					<option value="FurnitureHypothecation">Furniture Hypothecation---@furniturehypothecation</option>
					<option value="LiveStockHypothecation">Live Stock Hypothecation---@livestockhypothecation</option> 
					<option value="MachineryHypothecation">Machinery Hypothecation---@machineryhypothecation</option>
					<option value="CropHypothecation">Crop Hypothecation---@crophypothecation</option>
					
				</select></td>
			</tr>
			<tr>
				<td class="dataheader">Design</td>
			</tr>
			<tr>
			<td><iframe height="250" width="800" id="ifrm"
					frameborder="1" style="border: 2"></iframe></td>
			</tr>
			<tr>
				<td align="center"><br />
				<input type="button" name="cmdclose" value="Close"
					onclick="callClose();" class="buttonClose"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
</body>
</html>