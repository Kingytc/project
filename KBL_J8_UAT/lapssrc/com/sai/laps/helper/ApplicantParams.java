package com.sai.laps.helper;

public class ApplicantParams {

	public static String getApplicantParams(String paramcode, String paramvalue) 
	{
		paramcode = Helper.correctNull((String) paramcode.trim());
		paramvalue = Helper.correctNull((String) paramvalue.trim());
		if (paramcode.equals("EducationalQualification")) {
			if (paramvalue.equals("1")) {
				paramvalue = "M.B.B.S/MD/MS";
			} else if (paramvalue.equals("2")) {
				paramvalue = "C.A";
			} else if (paramvalue.equals("3")) {
				paramvalue = "M.B.A";
			} else if (paramvalue.equals("4")) {
				paramvalue = "A.C.S";
			} else if (paramvalue.equals("5")) {
				paramvalue = "Professional";
			} else if (paramvalue.equals("6")) {
				paramvalue = "Post Graduate";
			}else if (paramvalue.equals("7")) {
				paramvalue = "Graduate";
			}else if (paramvalue.equals("8")) {
				paramvalue = "Diploma";
			}else if (paramvalue.equals("9")) {
				paramvalue = "PUC / Plus 2";
			}else if (paramvalue.equals("10")) {
				paramvalue = "SSLC";
			}else if (paramvalue.equals("11")) {
				paramvalue = "VIII Pass";
			}else if (paramvalue.equals("12")) {
				paramvalue = "Illiterate";
			}else if (paramvalue.equals("13")) {
				paramvalue = "LLB/LLM";
			}else {
				paramvalue = "";
			}
		} else if (paramcode.equals("MaritalStatus")) {
			if (paramvalue.equals("1")) {
				paramvalue = "Married";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Single";
			} else if (paramvalue.equals("3")) {
				paramvalue = "Divorced";
			} else if (paramvalue.equals("4")) {
				paramvalue = "Widowed";
			}else if (paramvalue.equals("5")) {
				paramvalue = "Other";
			} else {
				paramvalue = "";
			}
		} else if (paramcode.equals("Mobility")) {
			if (paramvalue.equals("1")) {
				paramvalue = "> 3 Years";
			} else if (paramvalue.equals("2")) {
				paramvalue = "> 2 Years";
			} else if (paramvalue.equals("3")) {
				paramvalue = "> 1 Years";
			} else {
				paramvalue = "";
			}
		} else if (paramcode.equals("EmploymentStatus")) {
			if (paramvalue.equals("1")) {
				paramvalue = "Employee";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Business Man";
			} else if (paramvalue.equals("3")) {
				paramvalue = "Professionals";
			} else if (paramvalue.equals("4")) {
				paramvalue = "Agriculture and allied activities";
			} else if (paramvalue.equals("5")) {
				paramvalue = "Non Govt. Organization";
			} else if (paramvalue.equals("6")) {
				paramvalue = "Retail Trade";
			} else if (paramvalue.equals("7")) {
				paramvalue = "SME (Services)";
			} else if (paramvalue.equals("8")) {
				paramvalue = "SME (Manufacturing)";
			} else if (paramvalue.equals("9")) {
				paramvalue = "Pensioner";
			} else if (paramvalue.equals("10")) {
				paramvalue = "Student";
			}else if (paramvalue.equals("11")) {
				paramvalue = "Un Employed";
			} else {
				paramvalue = "";
			}
		} else if (paramcode.equals("Designation")) {
			if (paramvalue.equals("1")) {
				paramvalue = "Executive";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Managerial / Self Employed";
			} else if (paramvalue.equals("3")) {
				paramvalue = "Junior/Clerk";
			} else if (paramvalue.equals("4")) {
				paramvalue = "Others";
			} else {
				paramvalue = "";
			}
		}
		else if (paramcode.equals("Liabilities")) {
			if (paramvalue.equals("1")) {
				paramvalue = "No";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Yes";
			}
		}
		else if (paramcode.equals("PropertyQuality")
				|| paramcode.equals("PropertyLocation")
				|| paramcode.equals("PropertyAmenities")
				|| paramcode.equals("PropertyMarket")) {
			if (paramvalue.equals("1")) {
				paramvalue = "Very Good";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Good";
			} else if (paramvalue.equals("3")) {
				paramvalue = "Fair";
			} else if (paramvalue.equals("4")) {
				paramvalue = "Poor";
			} else {
				paramvalue = "";
			}
		}
		else if (paramcode.equals("PropertyStage")) {
			if (paramvalue.equals("1")) {
				paramvalue = "Final Stage";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Intermediate Stage";
			} else if (paramvalue.equals("3")) {
				paramvalue = "Foundation Stage";
			} else if (paramvalue.equals("4")) {
				paramvalue = "Planning Stage (Plot)";
			} else {
				paramvalue = "";
			}
		}
		else if (paramcode.equals("PresenceGurantor")
				|| paramcode.equals("PresenceCollateral")
				|| paramcode.equals("AccountHolder")) {
			if (paramvalue.equals("1")) {
				paramvalue = "Yes";
			} else if (paramvalue.equals("2")) {
				paramvalue = "No";
			}
		}
		else if (paramcode.equals("TypeVehicle")) {
			if (paramvalue.equals("1")) {
				paramvalue = "< 4 Lacs";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Between 4 to 6 Lacs";
			} else if (paramvalue.equals("3")) {
				paramvalue = "> 6 Lacs";
			}
		}
		else if (paramcode.equals("AgeVehicle")) {
			if (paramvalue.equals("1")) {
				paramvalue = "< 1 Year";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Between 1 to 3 Year";
			} else if (paramvalue.equals("3")) {
				paramvalue = "Between 3 to 5 Year";
			}
			else
			{
				paramvalue="";
			}
		} else if (paramcode.equals("Purchase_vehicle")) {
			if (paramvalue.equals("0")) {
				paramvalue = "";
			} else if (paramvalue.equals("1")) {
				paramvalue = "Private";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Public";
			} else if (paramvalue.equals("3")) {
				paramvalue = "Commercial";
			} else if (paramvalue.equals("4")) {
				paramvalue = "Others";
			}
		}
		else if (paramcode.equals("Type_vehicle")) {
			if (paramvalue.equals("0")) {
				paramvalue = "";
			} else if (paramvalue.equals("1")) {
				paramvalue = "Two Wheeler";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Three Wheeler";
			} else if (paramvalue.equals("3")) {
				paramvalue = "Four Wheeler";
			}
		}
		else if (paramcode.equals("Category_vehicle")) {
			if (paramvalue.equals("0")) {
				paramvalue = "";
			} else if (paramvalue.equals("1")) {
				paramvalue = "New Vehicle";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Second Hand Vehicle";
			}
		}
		else if (paramcode.equals("Fuel")) {
			if (paramvalue.equals("0")) {
				paramvalue = "";
			} else if (paramvalue.equals("1")) {
				paramvalue = "Diesel";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Petrol";
			} else if (paramvalue.equals("3")) {
				paramvalue = "CNG";
			} else if (paramvalue.equals("4")) {
				paramvalue = "Battery";
			}
		}
		else if (paramcode.equals("Reference")) {
			if (paramvalue.equals("0")) {
				paramvalue = "";
			} else if (paramvalue.equals("1")) {
				paramvalue = "The Manufactures / Their Reg.Office";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Visit made";
			} else if (paramvalue.equals("3")) {
				paramvalue = "Local Dealer of same or similar product";
			}
		}
		else if (paramcode.equals("RawMaterials")) {
			if (paramvalue.equals("S")) {
				paramvalue = "";
			} else if (paramvalue.equals("imp")) {
				paramvalue = "Imported";
			} else if (paramvalue.equals("ind")) {
				paramvalue = "Indigenous";
			}

		} 
		else if (paramcode.equals("RepaymentCorporate")) {
			if (paramvalue.equalsIgnoreCase("S")) {
				paramvalue = "";
			}
			else if (paramvalue.equalsIgnoreCase("M")) {
				paramvalue = "Monthly";
			} else if (paramvalue.equalsIgnoreCase("Q")) {
				paramvalue = "Quarterly";
			} else if (paramvalue.equalsIgnoreCase("H")) {
				paramvalue = "Half-Yearly";
			} else if (paramvalue.equalsIgnoreCase("Y")) {
				paramvalue = "Yearly";
			} else if (paramvalue.equalsIgnoreCase("C")) {
				paramvalue = "Customise";
			} else if (paramvalue.equalsIgnoreCase("N")) {
				paramvalue = "Not Applicable";
			}
		}
		else if (paramcode.equals("TertiaryCategory")) {
			if (paramvalue.equals("0")) {
				paramvalue = "";
			} else if (paramvalue.equals("1")) {
				paramvalue = "import";
			} else if (paramvalue.equals("2")) {
				paramvalue = "industry";
			} else if (paramvalue.equals("3")) {
				paramvalue = "export";
			} else if (paramvalue.equals("4")) {
				paramvalue = "Small scale";
			} else if (paramvalue.equals("5")) {
				paramvalue = "Trade &amp; COM";
			} else if (paramvalue.equals("6")) {
				paramvalue = "Agriculture";
			} else if (paramvalue.equals("7")) {
				paramvalue = "Transport operator";
			} else if (paramvalue.equals("8")) {
				paramvalue = "SM Trader other than Fert";
			} else if (paramvalue.equals("9")) {
				paramvalue = "Trader in Fert";
			} else if (paramvalue.equals("10")) {
				paramvalue = "Self Employed";
			} else if (paramvalue.equals("11")) {
				paramvalue = "SM Business";
			} else if (paramvalue.equals("12")) {
				paramvalue = "Others";
			}
		}
		else if (paramcode.equals("adv_borrpayment")) {
			if (paramvalue.equals("1")) {
				paramvalue = "Normal";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Prompt";
			} else if (paramvalue.equals("3")) {
				paramvalue = "Tardy";
			}
		} 
		else if (paramcode.equals("adv_borrpayment")) {
			if (paramvalue.equals("")) {
				paramvalue = "";
			}
			if (paramvalue.equals("1")) {
				paramvalue = "Normal";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Prompt";
			} else if (paramvalue.equals("3")) {
				paramvalue = "Tardy";
			}
		} else if (paramcode.equals("adv_local")) {
			if (paramvalue.equals("")) {
				paramvalue = "";
			}
			if (paramvalue.equals("1")) {
				paramvalue = "At Sight";
			} else if (paramvalue.equals("2")) {
				paramvalue = "After";
			}
		} else if (paramcode.equals("adv_dishonours")) {
			if (paramvalue.equals("")) {
				paramvalue = "";
			}
			if (paramvalue.equals("1")) {
				paramvalue = "Regularly";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Occasionaly";
			}
		} else if (paramcode.equals("apptype")) {
			if (paramvalue.equals("")) {
				paramvalue = "";
			}
			if (paramvalue.equals("M")) {
				paramvalue = "Male";
			} else if (paramvalue.equals("F")) {
				paramvalue = "Female";
			} else if (paramvalue.equals("O")) {
				paramvalue = "Others";
			}
		}
		else if (paramcode.equals("VirtualityVehicle")) {
			if (paramvalue.equals("0")) {
				paramvalue = "";
			} else if (paramvalue.equals("1")) {
				paramvalue = "Existing";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Proposed";
			}
		}
		else if (paramcode.equals("EquipmentType")) {
			if (paramvalue.equals("0")) {
				paramvalue = "";
			} else if (paramvalue.equals("1")) {
				paramvalue = "Indigenous";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Imported";
			}
		} else if (paramcode.equals("EquipmentCategory")) {
			if (paramvalue.equals("0")) {
				paramvalue = "";
			} else if (paramvalue.equals("N")) {
				paramvalue = "New";
			} else if (paramvalue.equals("S")) {
				paramvalue = "Second Hand";
			}
		}
		else if (paramcode.equals("SanctionNatureOfAdvance")) {
			if (paramvalue.equals("0")) {
				paramvalue = "";
			} else if (paramvalue.equals("001")) {
				paramvalue = "Secured";
			} else if (paramvalue.equals("002")) {
				paramvalue = "Partly Secured";
			} else if (paramvalue.equals("003")) {
				paramvalue = "Unsecured";
			}
		} else if (paramcode.equals("SanctionModOfPayment")) {
			if (paramvalue.equals("0")) {
				paramvalue = "";
			} else if (paramvalue.equals("S")) {
				paramvalue = "Recover From Salary";
			} else if (paramvalue.equals("P")) {
				paramvalue = "Post Dated Cheque";
			} else if (paramvalue.equals("E")) {
				paramvalue = "Transfer from Saving/Current a/c";
			} else if (paramvalue.equals("D")) {
				paramvalue = "Electronic Cheque Clearing(ECS)";
			} else if (paramvalue.equals("N")) {
				paramvalue = "Cash Recovery";
			}
		}
		else if (paramcode.equals("LandHoldingsSecutrity")) {
			if (paramvalue.equals("0")) {
				paramvalue = "";
			} else if (paramvalue.equals("1")) {
				paramvalue = "Already Taken as Security";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Not Offered as Security";
			} else if (paramvalue.equals("3")) {
				paramvalue = "Offered as Security";
			}
		} else if (paramcode.equals("LandHoldingsMortgage")) {
			if (paramvalue.equals("0")) {
				paramvalue = "";
			} else if (paramvalue.equals("1")) {
				paramvalue = "Equitable";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Registered";
			} else if (paramvalue.equals("3")) {
				paramvalue = "Creation of Charge";
			} else if (paramvalue.equals("4")) {
				paramvalue = "Third party property";
			}
		} else if (paramcode.equals("LandHoldingsParticulars")) {
			if (paramvalue.equals("0")) {
				paramvalue = "";
			} else if (paramvalue.equals("1")) {
				paramvalue = "Irrigated";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Dry Land";
			} else if (paramvalue.equals("3")) {
				paramvalue = "Non-Cultivable";
			}
		} else if (paramcode.equals("AgricultureTechnicalAspects")) {
			if (paramvalue.equals("0")) {
				paramvalue = "";
			} else if (paramvalue.equals("1")) {
				paramvalue = "Scale of finance";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Without Scale of finance";
			} else if (paramvalue.equals("3")) {
				paramvalue = "Land Holding Eligibility";
			}
		}else if (paramcode.equals("AgricultureProposedCrops")) {
			if (paramvalue.equals("0")) {
				paramvalue = "";
			} else if (paramvalue.equals("1")) {
				paramvalue = "Irrigated";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Rainfed";
			} 
		}else if (paramcode.equals("AgricultureCroppingSeason")) {
			if (paramvalue.equals("0")) {
				paramvalue = "";
			} else if (paramvalue.equals("1")) {
				paramvalue = "Kharif";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Rabi";
			} else if (paramvalue.equals("3")) {
				paramvalue = "Summer";
			} else if (paramvalue.equals("4")) {
				paramvalue = "Annual";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Perennial";
			} 
		}else if (paramcode.equals("AgricultureConfirmation")) {
			if (paramvalue.equals("s")) {
				paramvalue = "";
			} else if (paramvalue.equals("h")) {
				paramvalue = "Hypothecation of";
			} else if (paramvalue.equals("m")) {
				paramvalue = "Mortgage of";
			} else if (paramvalue.equals("l")) {
				paramvalue = "Lien of";
			} else if (paramvalue.equals("a")) {
				paramvalue = "Assignment of";
			} else if (paramvalue.equals("p")) {
				paramvalue = "Pledge of";
			} 
		}else if (paramcode.equals("InfrastructureAvailable")) {
			if (paramvalue.equals("1")) {
				paramvalue = "Available";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Provision made in Proposed Scheme";
			} else if (paramvalue.equals("3")) {
				paramvalue = "Shall be purchased/devloped in later date";
			}  else {
				paramvalue = "";
			}
		}else if (paramcode.equals("LiveStock")) {
			if (paramvalue.equals("1")) {
				paramvalue = "Cows";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Buffalo/es";
			}  else {
				paramvalue = "";
			}
		}else if (paramcode.equals("TechnicalData")) {
			if (paramvalue.equals("1")) {
				paramvalue = "Available";
			} else if (paramvalue.equals("2")) {
				paramvalue = "Not Available";
			} else {
				paramvalue = "";
			}
		}else if(paramcode.equals("BUSINESSABILITY"))	{
			if(paramvalue.equals("1")){
				paramvalue="CAPABLE";
			}else if(paramvalue.equals("2")){
				paramvalue="INCAPABLE";
			}else if(paramvalue.equals("3")){
				paramvalue="EXPERIENCED";
			}else if(paramvalue.equals("4")){
				paramvalue="INEXPERIENCED";
			}else if(paramvalue.equals("5")){
				paramvalue="NOT APPLICABLE";
			}else{
				paramvalue="";
			}
		}else if(paramcode.equals("BUSINESSCONDUCTED"))
		{
			if(paramvalue.equals("1")){
				paramvalue="SPECULATIVE";
			}else if(paramvalue.equals("2")){
				paramvalue="OVERTRADE";
			}else if(paramvalue.equals("3")){
				paramvalue="CONSERVATIVE";
			}else if(paramvalue.equals("4")){
				paramvalue="PRUDENT";
			}else if(paramvalue.equals("5")){
				paramvalue="CAUTIOUS";
			}else if(paramvalue.equals("6")){
				paramvalue="STEADY";
			}else if(paramvalue.equals("7")){
				paramvalue="NOT APPLICABLE";
			}else{
				paramvalue="";
			}
		}
		else if(paramcode.equals("DEFAULTYESNO"))
		{
			if(paramvalue.equalsIgnoreCase("s")){
				paramvalue="";
			}else if(paramvalue.equalsIgnoreCase("y")){
				paramvalue="Yes";
			}else if(paramvalue.equalsIgnoreCase("n")){
				paramvalue="No";
			}else{
				paramvalue="";
			}
		}
		else if(paramcode.equals("PROMOTORTYPE"))
		{
			if(paramvalue.equalsIgnoreCase("G")){
				paramvalue="Guarantor";
			}else if(paramvalue.equalsIgnoreCase("O")){
				paramvalue="Share Holders";
			}else if(paramvalue.equalsIgnoreCase("D")){
				paramvalue="Directors";
			}else if(paramvalue.equalsIgnoreCase("SP")){
				paramvalue="Sole Proprietor";
			}else if(paramvalue.equalsIgnoreCase("PT")){
				paramvalue="Partner";			
			}else if(paramvalue.equalsIgnoreCase("OT")){
				paramvalue="Others";
			}else{
				paramvalue="";
			}
		}
		else if(paramcode.equals("LOANTYPE"))
		{
			if(paramvalue.equalsIgnoreCase("HL")){
				paramvalue="Housing Loan";
			}else if(paramvalue.equalsIgnoreCase("CL")){
				paramvalue="Cash Loan";
			}else if(paramvalue.equalsIgnoreCase("VL")){
				paramvalue="Vehicle Loan";
			}else if(paramvalue.equalsIgnoreCase("CD")){
				paramvalue="Consumer Durables Loan";			
			}else if(paramvalue.equalsIgnoreCase("EL")){
				paramvalue="Education Loan";
			}else if(paramvalue.equalsIgnoreCase("ML")){
				paramvalue="Mortgage Loan";
			}else if(paramvalue.equalsIgnoreCase("AL")){
				paramvalue="Health Loan";
			}else if(paramvalue.equalsIgnoreCase("GL")){
				paramvalue="Gold Loan";			
			}else if(paramvalue.equalsIgnoreCase("TL")){
				paramvalue="Top Up";
			}else if(paramvalue.equalsIgnoreCase("SL")){
				paramvalue="Smiles Loan";
			}else if(paramvalue.equalsIgnoreCase("CC")){
				paramvalue="Credit Card";
			}else if(paramvalue.equalsIgnoreCase("PL")){
				paramvalue="Personal Loan";
			}else if(paramvalue.equalsIgnoreCase("OL")){
				paramvalue="Others";
			}else{
				paramvalue="";
			}
		}
		else if(paramcode.equals("SECTOR"))
		{
			if(paramvalue.equalsIgnoreCase("p")){
				paramvalue="Retail";
			}else if(paramvalue.equalsIgnoreCase("C")){
				paramvalue="Corporate & SME";
			}else if(paramvalue.equalsIgnoreCase("T")){
				paramvalue="Tertiary";
			}else if(paramvalue.equalsIgnoreCase("A")){
				paramvalue="Agriculture";			
			}else{
				paramvalue="";
			}
		}
		else if(paramcode.equals("PROPOSALTYPE"))
		{
			if(paramvalue.equalsIgnoreCase("C")){
				paramvalue="Regular Proposal";
			}else if(paramvalue.equalsIgnoreCase("H")){
				paramvalue="Adhoc Proposal";
			}else if(paramvalue.equalsIgnoreCase("V")){
				paramvalue="Short term loan";
			}else if(paramvalue.equalsIgnoreCase("E")){
				paramvalue="Short Review/Extension";			
			}else{
				paramvalue="";
			}
		}
		else if(paramcode.equals("ENQUIRYPURPOSE"))
		{
			if(paramvalue.equalsIgnoreCase("01")){
				paramvalue="Auto Loan";
			}else if(paramvalue.equalsIgnoreCase("02")){
				paramvalue="Housing Loan";
			}else if(paramvalue.equalsIgnoreCase("03")){
				paramvalue="Loan Against Shares/Securities";
			}else if(paramvalue.equalsIgnoreCase("04")){
				paramvalue="Property Loan";			
			}else{
				paramvalue="";
			}
		}
		else if(paramcode.equals("ACCOUNTSTATUS"))
		{
			if(paramvalue.equalsIgnoreCase("0"))
			{
				paramvalue = "";
			}else if(paramvalue.equals("1")){
				paramvalue = "Regular";
			}else if(paramvalue.equals("2")){
				paramvalue = "NPA";
			}else{
				paramvalue = "";
			}
		}
		else if(paramcode.equals("BNKACCOUNTSTATUS"))
		{
			if(paramvalue.equalsIgnoreCase("0"))
			{
				paramvalue = "";
			}else if(paramvalue.equals("1")){
				paramvalue = "NPA";
			}else if(paramvalue.equals("2")){
				paramvalue = "PWO";
			}else{
				paramvalue = "";
			}
		}
		else if(paramcode.equals("FACTORYPREMISES"))
		{
			if(paramvalue.equalsIgnoreCase("0"))
			{
				paramvalue = "";
			}else if(paramvalue.equals("1")){
				paramvalue = "Rented";
			}else if(paramvalue.equals("2")){
				paramvalue = "Owned";
			}else if(paramvalue.equals("3")){
				paramvalue = "Leased";
			}else{
				paramvalue = "";
			}
		}
		else if(paramcode.equals("BANKINGARRANGEMENT"))
		{
			if(paramvalue.equalsIgnoreCase("0"))
			{
				paramvalue = "";
			}else if(paramvalue.equals("1")){
				paramvalue = "Sole";
			}else if(paramvalue.equals("2")){
				paramvalue = "Consortium";
			}else if(paramvalue.equals("3")){
				paramvalue = "Multiple Banking";
			}else{
				paramvalue = "";
			}
		}
		else if(paramcode.equals("UNITSTATUS"))
		{
			if(paramvalue.equalsIgnoreCase("0"))
			{
				paramvalue = "";
			}else if(paramvalue.equals("1")){
				paramvalue = "Working";
			}else if(paramvalue.equals("2")){
				paramvalue = "Closed";
			}else{
				paramvalue = "";
			}
		}
		else if(paramcode.equals("SECURITYTYPE"))
		{
			if(paramvalue.equalsIgnoreCase("S") || paramvalue.equalsIgnoreCase("0"))
			{
				paramvalue = "";
			}else if(paramvalue.equals("P") || paramvalue.equalsIgnoreCase("1") || paramvalue.equalsIgnoreCase("Primary")){
				paramvalue = "Primary";
			}else if(paramvalue.equals("C") || paramvalue.equalsIgnoreCase("2") || paramvalue.equalsIgnoreCase("Collateral")){
				paramvalue = "Collateral";
			}else{
				paramvalue = "";
			}
		}
		else if(paramcode.equals("OTSCOMMENTS"))
		{
			if(paramvalue.equalsIgnoreCase("0"))
			{
				paramvalue = "";
			}else if(paramvalue.equals("1")){
				paramvalue = "Yes";
			}else if(paramvalue.equals("2")){
				paramvalue = "No";
			}else{
				paramvalue = "";
			}
		}
		else if(paramcode.equals("COURTNAME"))
		{
			if(paramvalue.equalsIgnoreCase("0"))
			{
				paramvalue = "";
			}else if(paramvalue.equals("1")){
				paramvalue = "Civil";
			}else if(paramvalue.equals("2")){
				paramvalue = "DRT";
			}else if(paramvalue.equals("3")){
				paramvalue = "Revenue Recovery";
			}else if(paramvalue.equals("4")){
				paramvalue = "High Court";
			}else if(paramvalue.equals("5")){
				paramvalue = "Others";
			}else{
				paramvalue = "";
			}
		}
		else if(paramcode.equals("PROPOSALSETTLEMENT"))
		{
			if(paramvalue.equalsIgnoreCase("0"))
			{
				paramvalue = "";
			}else if(paramvalue.equals("1")){
				paramvalue = "COUNTER OFFER";
			}else if(paramvalue.equals("2")){
				paramvalue = "COMPROMISE";
			}else{
				paramvalue = "";
			}
		}
		else if(paramcode.equals("WORKINGSTATUS"))
		{
			if(paramvalue.equalsIgnoreCase("0"))
			{
				paramvalue = "";
			}else if(paramvalue.equals("1")){
				paramvalue = "Own Account";
			}else if(paramvalue.equals("2")){
				paramvalue = "Doing Job Work";
			}else{
				paramvalue = "";
			}
		}
		else if(paramcode.equals("DOCUMENTENFORCE"))
		{
			if(paramvalue.equalsIgnoreCase("1"))
			{
				paramvalue = "";
			}else if(paramvalue.equals("2")){
				paramvalue = "YES";
			}else if(paramvalue.equals("3")){
				paramvalue = "NO";
			}else{
				paramvalue = "";
			}
		}
		else if(paramcode.equals("TYPEOFDOCUMENT"))
		{
			if(paramvalue.equalsIgnoreCase("1"))
			{
				paramvalue = "";
			}else if(paramvalue.equals("2")){
				paramvalue = "CHARGE";
			}else if(paramvalue.equals("3")){
				paramvalue = "HYPOTHECATION";
			}else if(paramvalue.equals("4")){
				paramvalue = "MORTGAGE";
			}else{
				paramvalue = "";
			}
		}
		else if(paramcode.equals("TYPEOFPROPOSAL"))
		{
			if(paramvalue.equalsIgnoreCase("0"))
			{
				paramvalue = "";
			}else if(paramvalue.equals("1")){
				paramvalue = "Prudential Writeoff";
			}else if(paramvalue.equals("2")){
				paramvalue = "Absolute Writeoff";
			}else{
				paramvalue = "";
			}
		}
		else if(paramcode.equals("PROPOSALS"))
		{
			if(paramvalue.equalsIgnoreCase("1"))
			{
				paramvalue = "";
			}else if(paramvalue.equals("2")){
				paramvalue = "DRT";
			}else if(paramvalue.equals("3")){
				paramvalue = "CIVIL COURT";
			}else if(paramvalue.equals("4")){
				paramvalue = "RRA";
			}else if(paramvalue.equals("5")){
				paramvalue = "LOK ADALAT";
			}else if(paramvalue.equals("6")){
				paramvalue = "OTHERS";
			}else{
				paramvalue = "";
			}
		}
		else if(paramcode.equals("TERMLOANTYPE"))
		{
			if(paramvalue.equalsIgnoreCase("1"))
			{
				paramvalue = "";
			}else if(paramvalue.equals("2")){
				paramvalue = "Short Term";
			}else if(paramvalue.equals("3")){
				paramvalue = "medium Term";
			}else if(paramvalue.equals("4")){
				paramvalue = "Long Term";
			}else{
				paramvalue = "";
			}
		}
		else if(paramcode.equals("PROPOSALTYPES"))
		{
			if(paramvalue.equalsIgnoreCase("S"))
			{
				paramvalue = "";
			}else if(paramvalue.equals("0")){
				paramvalue = "Retail / Tertiary";
			}else if(paramvalue.equals("1")){
				paramvalue = "SME";
			}else if(paramvalue.equals("2")){
				paramvalue = "Corporate";
			}else{
				paramvalue = "";
			}
		}
		else if(paramcode.equals("PROPOSALIN"))
		{
			if(paramvalue.equalsIgnoreCase("S"))
			{
				paramvalue = "";
			}else if(paramvalue.equals("A")){
				paramvalue = "Amount in Rs";
			}else if(paramvalue.equals("L")){
				paramvalue = "Rs. In Lacs";
			}else if(paramvalue.equals("C")){
				paramvalue = "Rs. In Crores";
			}else{
				paramvalue = "";
			}
		}
		else if(paramcode.equals("CommonLoanfor"))
		{
			if(paramvalue.equalsIgnoreCase("0"))
			{
				paramvalue = "";
			}else if(paramvalue.equals("1")){
				paramvalue = "Tissue culture";
			}else if(paramvalue.equals("2")){
				paramvalue = "Others";
			}
		}else if(paramcode.equals("cibilinterface"))
		{
			if(paramvalue.equalsIgnoreCase("0"))
			{
				paramvalue = "";
			}else if(paramvalue.equals("1")){
				paramvalue = "Secured";
			}else if(paramvalue.equals("2")){
				paramvalue = "Unsecured";
			}
		}
		
		return paramvalue.trim();
	}
}
