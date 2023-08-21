package com.sai.laps.helper;


public class SetupParams
{
 	
	public static String getSetupParams(String paramcode, String paramvalue)
	{	
		paramcode = Helper.correctNull((String)paramcode.trim());
		paramvalue = Helper.correctNull((String)paramvalue.trim());
		
		if(paramcode.equals("BranchType"))
		{
			if(paramvalue.equals("0"))
			{
				paramvalue ="";
			}
			else if(paramvalue.equals("1"))
			{
				paramvalue ="SSI";
			}
			else if(paramvalue.equals("2"))
			{
				paramvalue ="NRI";
			}
			else if(paramvalue.equals("3"))
			{
				paramvalue ="Overseas";
			}
			else if(paramvalue.equals("4"))
			{
				paramvalue ="IFB";
			}
			else if(paramvalue.equals("5"))
			{
				paramvalue ="STB";
			}
			else if(paramvalue.equalsIgnoreCase("6"))
			{
				paramvalue="PBB";
			}
		}
		if(paramcode.equals("BranchIn"))
		{
			if(paramvalue.equals("0"))
			{
				paramvalue ="";
			}
			else if(paramvalue.equals("1"))
			{
				paramvalue ="METRO";
			}
			else if(paramvalue.equals("2"))
			{
				paramvalue ="URBAN";
			}
			else if(paramvalue.equals("3"))
			{
				paramvalue ="SEMI_URBAN";
			}
			else if(paramvalue.equals("4"))
			{
				paramvalue ="RURAL";
			}
		}
		if(paramcode.equals("Region"))
		{
			if(paramvalue.equals("0"))
			{
				paramvalue ="";
			}
			else if(paramvalue.equals("1"))
			{
				paramvalue ="NORTHERN";
			}
			else if(paramvalue.equals("2"))
			{
				paramvalue ="NORTH EAST";
			}
			else if(paramvalue.equals("3"))
			{
				paramvalue ="EASTERN";
			}
			else if(paramvalue.equals("4"))
			{
				paramvalue ="CENTRAL";
			}
			else if(paramvalue.equals("6"))
			{
				paramvalue ="WESTERN";
			}
			else if(paramvalue.equals("7"))
			{
				paramvalue ="SOUTHERN";
			}
		}
		if(paramcode.equals("SAABranch"))
		{
			if(paramvalue.equals("0"))
			{
				paramvalue ="";
			}
		    else if(paramvalue.equals("1"))
			{
				paramvalue ="Yes";
			}
			else if(paramvalue.equals("2"))
			{
				paramvalue ="No";
			}
			else 
			{
				paramvalue ="";
			}
		}
		if(paramcode.equals("ProductRetailandAgri"))
		{
			if(paramvalue.equals("0"))
			{
				paramvalue ="";
			}
		    else if(paramvalue.equals("p"))
			{
				paramvalue ="Retail";
			}
			else if(paramvalue.equals("a"))
			{
				paramvalue ="Agriculture";
			}
		}
		if(paramcode.equals("NPA"))
		{
			if(paramvalue.equals("S"))
			{
				paramvalue ="";
			}
		    else if(paramvalue.equals("OTSCO"))
			{
				paramvalue ="COMPROMISE PROPOSAL";
			}
			else if(paramvalue.equals("PAWO"))
			{
				paramvalue ="PRUDENTIAL WRITE OFF/ABSOLUTE WRITE OFF";
			}
			else if(paramvalue.equals("SUIT"))
			{
				paramvalue ="FILING OF SUIT";
			}
			else if(paramvalue.equals("STAT"))
			{
				paramvalue ="STATUS NOTE";
			}
			else if(paramvalue.equals("SARFI"))
			{
				paramvalue ="SARFAESI ACT";
			}
		}
		if(paramcode.equals("ProductRetailandAgri"))
		{
			if(paramvalue.equals("0"))
			{
				paramvalue ="";
			}
		    else if(paramvalue.equals("p"))
			{
				paramvalue ="Retail";
			}
			else if(paramvalue.equals("a"))
			{
				paramvalue ="Agriculture";
			}
		}
		if(paramcode.equals("SacrificeLimit"))
		{
			if(paramvalue.equals("0"))
			{
				paramvalue ="";
			}
		    else if(paramvalue.equalsIgnoreCase("Y"))
			{
				paramvalue ="Yes";
			}
			else if(paramvalue.equalsIgnoreCase("N"))
			{
				paramvalue ="No";
			}
			else if(paramvalue.equalsIgnoreCase("s"))
			{
				paramvalue ="";
			}
		}
		if(paramcode.equals("CoffeeCrop"))
		{
			if(paramvalue.equals("s"))
			{
				paramvalue ="";
			}
		    else if(paramvalue.equals("1"))
			{
				paramvalue ="Arabica";
			}
			else if(paramvalue.equals("2"))
			{
				paramvalue ="Robusta";
			}
		}
		if(paramcode.equals("CoffeeType"))
		{
			if(paramvalue.equals("s"))
			{
				paramvalue ="";
			}
		    else if(paramvalue.equals("1"))
			{
				paramvalue ="Parachment";
			}
			else if(paramvalue.equals("2"))
			{
				paramvalue ="Cherry";
			}
		}
		if(paramcode.equals("MasterAction"))
		{
			if(paramvalue.equals("1"))
			{
				paramvalue ="Enabled";
			}
			else
			{
				paramvalue ="Disabled";
			}
		}
		
		if(paramcode.equals("Education"))
		{
			if(paramvalue.equals("0"))
			{
				paramvalue ="";
			}
		   else if(paramvalue.equals("1"))
			{
				paramvalue ="Yes";
			}
			else if(paramvalue.equals("2"))
			{
				paramvalue ="No";
			}
		}
		if(paramcode.equals("Studies"))
		{
			if(paramvalue.equals("0"))
			{
				paramvalue ="";
			}
		   else if(paramvalue.equals("1"))
			{
				paramvalue ="In India";
			}
			else if(paramvalue.equals("2"))
			{
				paramvalue ="Abroad";
			}
		}
		
		if(paramcode.equals("Course"))
		{
			if(paramvalue.equals("0"))
			{
				paramvalue ="";
			}
		   else if(paramvalue.equals("1"))
			{
				paramvalue ="Part Time";
			}
			else if(paramvalue.equals("2"))
			{
				paramvalue ="Full Time";
			}
			else if(paramvalue.equals("3"))
			{
				paramvalue ="Evening Course";
			}
			else if(paramvalue.equals("4"))
			{
				paramvalue ="Correspondense";
			}
			else if(paramvalue.equals("5"))
			{
				paramvalue ="Vocational";
			}
		}
		
		
		if(paramcode.equals("Qualification"))
		{
			if(paramvalue.equals("0"))
			{
				paramvalue ="";
			}
		   else if(paramvalue.equals("1"))
			{
				paramvalue ="Doctorate /Other Professional";
			}
			else if(paramvalue.equals("2"))
			{
				paramvalue ="Post Graduate";
			}
			else if(paramvalue.equals("3"))
			{
				paramvalue ="Graduate";
			}
			else if(paramvalue.equals("4"))
			{
				paramvalue ="Diploma/Certification";
			}
			else if(paramvalue.equals("5"))
			{
				paramvalue ="Higher Secondary";
			}
			else if(paramvalue.equals("6"))
			{
				paramvalue ="Below Higher Secondary";
			}
		}
		 
		if(paramcode.equals("admission"))
		{
			if(paramvalue.equals("0"))
			{
				paramvalue ="";
			}
		   else if(paramvalue.equals("1"))
			{
				paramvalue ="Entrance Test";
			}
			else if(paramvalue.equals("2"))
			{
				paramvalue ="Selection Process";
			}
			else if(paramvalue.equals("3"))
			{
				paramvalue ="Direct on merit";
			}
		}
		if(paramcode.equals("fintype"))
		{
			if(paramvalue.equals("S"))
			{
				paramvalue ="";
			}
		   else if(paramvalue.equals("1"))
			{
				paramvalue ="Aggregate Limits Upto 100 lacs";
			}
			else if(paramvalue.equals("2"))
			{
				paramvalue ="Aggregate Limits Above 100 lacs";
			}
			else if(paramvalue.equals("3"))
			{
				paramvalue ="Union Trade Scheme above 50 Lacs";
			}
		}
		if(paramcode.equals("BankType"))
		{
			if(paramvalue.equals("0"))
			{
				paramvalue ="";
			}
			else if(paramvalue.equals("1"))
			{
				paramvalue ="Sole";
			}
			else if(paramvalue.equals("2"))
			{
				paramvalue ="Consortium";
			}
			else if(paramvalue.equals("3"))
			{
				paramvalue ="Multiple";
			}
			else if(paramvalue.equals("4"))
			{
				paramvalue ="Sole/Consortium";
			}
			else if(paramvalue.equals("5"))
			{
				paramvalue ="Sole/Multiple";
			}
			else if(paramvalue.equals("6"))
			{
				paramvalue ="Consortium/Multiple";
			}
			else if(paramvalue.equals("7"))
			{
				paramvalue ="Sole/Consortium/Multiple";
			}
		}
		if(paramcode.equals("AccountStatus"))
		{
			if(paramvalue.equals("0"))
			{
				paramvalue ="";
			}
		   else if(paramvalue.equals("1"))
			{
				paramvalue ="Regular";
			}
			else if(paramvalue.equals("2"))
			{
				paramvalue ="EAS I";
			}
			else if(paramvalue.equals("3"))
			{
				paramvalue ="EAS II";
			}
			else if(paramvalue.equals("4"))
			{
				paramvalue ="SMA";
			}
		}
		
		if(paramcode.equals("YesNoFlag"))
		{
			if(paramvalue.equals("0"))
			{
				paramvalue ="";
			}
		    else if(paramvalue.equalsIgnoreCase("y") || paramvalue.equalsIgnoreCase("1"))
			{
				paramvalue ="Yes";
			}
			else if(paramvalue.equalsIgnoreCase("n") || paramvalue.equalsIgnoreCase("2"))
			{
				paramvalue ="No";
			}
			else 
			{
				paramvalue ="";
			}
		}
		if(paramcode.equals("YesNo"))
		{
			if(paramvalue.equals("0"))
			{
				paramvalue ="Yes";
			}
		    else if(paramvalue.equals("1"))
			{
				paramvalue ="No";
			}
			else 
			{
				paramvalue ="";
			}
		}
		if(paramcode.equals("AccountCategory"))
		{
			if(paramvalue.equals("0"))
			{
				paramvalue ="";
			}
		   else if(paramvalue.equals("1"))
			{
				paramvalue ="Standard";
			}
			else if(paramvalue.equals("2"))
			{
				paramvalue ="EAS I";
			}
			else if(paramvalue.equals("3"))
			{
				paramvalue ="EAS II";
			}
			else if(paramvalue.equals("4"))
			{
				paramvalue ="SMA";
			}
			else
			{
				paramvalue ="";
			}
		}
		if(paramcode.equals("mulbank"))
		{
			if(paramvalue.equals("0"))
			{
				paramvalue ="";
			}
		   else if(paramvalue.equals("1"))
			{
				paramvalue ="Sole";
			}
			else if(paramvalue.equals("2"))
			{
				paramvalue ="Consortium";
			}
			else if(paramvalue.equals("3"))
			{
				paramvalue ="Multiple";
			}
			else if(paramvalue.equals("4"))
			{
				paramvalue ="Sole/Consortium";
			}
			else if(paramvalue.equals("5"))
			{
				paramvalue ="Sole/Multiple";
			}
			else if(paramvalue.equals("6"))
			{
				paramvalue ="Consortium/Multiple";
			}
			else if(paramvalue.equals("7"))
			{
				paramvalue ="Sole/Consortium/Multiple";
			}
			else
			{
				paramvalue ="";
			}
		}
		
		if(paramcode.equals("AssetClassification"))
		{
		    if(paramvalue.equals("1"))
			{
				paramvalue ="Standard";
			}
			else if(paramvalue.equals("2"))
			{
				paramvalue ="Sub Standard";
			}
			else if(paramvalue.equals("3"))
			{
				paramvalue ="Loss";
			}
			else if(paramvalue.equals("4"))
			{
				paramvalue ="Doubtful";
			}
			else
			{
				paramvalue ="";
			}
		}
		
		if(paramcode.equals("OnlinePrdCode")){
			
			if (paramvalue.equals("pH")) { 
				paramvalue = "1";//Housing Loan
			} else if (paramvalue.equals("pP")) {
				paramvalue = "3";//Cash Loan
			}else if (paramvalue.equals("pA")) {
				paramvalue = "4";//Vehicle Loan
			}else if (paramvalue.equals("pD")) {
				paramvalue = "6";//Consumer Durables Loan 
			}else if (paramvalue.equals("pE")) {
				paramvalue = "5";//Education Loan
			}else if (paramvalue.equals("pM")) {
				paramvalue = "2";//Mortgage Loan
			}else if (paramvalue.equals("pI")) {
				paramvalue = "8";//Health Loan
			}else if (paramvalue.equals("pG")) {
				paramvalue = "9";//Gold Loan
			}else if (paramvalue.equals("pT")) {
				paramvalue = "10";//Top Up Loan
			}else if (paramvalue.equals("pO")) {
				paramvalue = "11";//Smiles Loan
			}else if (paramvalue.equals("pR")) {
				paramvalue = "7";//Loan against Deposits Loan
			}else if (paramvalue.equals("aC")) {
				paramvalue = "51";//Agriculture - Crop Loan
			}else if (paramvalue.equals("aF")) {
				paramvalue = "52";//Agriculture - Farm Mechanisation
			}else if (paramvalue.equals("aD")) {
				paramvalue = "53";//Agriculture - Dairy development
			}else if (paramvalue.equals("aU")) {
				paramvalue = "54";//Agriculture - Irrigation
			}
		}
		
			if(paramcode.equals("accessfor")){
			
			if (paramvalue.equals("O")) { 
				paramvalue = "Online Module Only";
			} else if (paramvalue.equals("OL")) {
				paramvalue = "Online & LAPS";
			}else{
				paramvalue = "";
			}
		}
			
			if(paramcode.equals("OnlinePrdCodeDesc")){
				
				if (paramvalue.equals("1")) { 
					paramvalue = "Housing Loan";//Housing Loan
				} else if (paramvalue.equals("3")) {
					paramvalue = "Cash Loan";//Cash Loan
				}else if (paramvalue.equals("4")) {
					paramvalue = "Vehicle Loan";//Vehicle Loan
				}else if (paramvalue.equals("6")) {
					paramvalue = "Consumer Durables Loan";//Consumer Durables Loan 
				}else if (paramvalue.equals("5")) {
					paramvalue = "Education Loan";//Education Loan
				}else if (paramvalue.equals("2")) {
					paramvalue = "Mortgage Loan";//Mortgage Loan
				}else if (paramvalue.equals("8")) {
					paramvalue = "Health Loan";//Health Loan
				}else if (paramvalue.equals("9")) {
					paramvalue = "Gold Loan";//Gold Loan
				}else if (paramvalue.equals("10")) {
					paramvalue = "Top Up Loan";//Top Up Loan
				}else if (paramvalue.equals("11")) {
					paramvalue = "Smiles Loan";//Smiles Loan
				}else if (paramvalue.equals("7")) {
					paramvalue = "Loan against Deposits Loan";//Loan against Deposits Loan
				}
				else if (paramvalue.equals("51")) {
					paramvalue = "Crop Loan";//Agriculture - Crop Loan
				}else if (paramvalue.equals("52")) {
					paramvalue = "Farm Machinery";//Agriculture - Farm Machinery
				}
				else if (paramvalue.equals("53")) {
					paramvalue = "Dairy development";//Agriculture - Dairy development
				}
				else if (paramvalue.equals("54")) {
					paramvalue = "Irrigation";//Agriculture - Irrigation
				}
				else if (paramvalue.equals("C")) {
					paramvalue = "Corporate Loan";//Agriculture - Irrigation
				}
			}
			
			if(paramcode.equals("OnlineAppStatus")){
				
				if (paramvalue.equals("Q")) { 
					paramvalue = "Requested";
				} else if (paramvalue.equals("D")) {
					paramvalue = "Detailed";
				} else if (paramvalue.equals("U")) {
					paramvalue = "Uploaded to LAPS";
				}else if (paramvalue.equals("O")) {
					paramvalue = "Pending";
				}else if (paramvalue.equals("A")) {
					paramvalue = "Approved";
				}else if (paramvalue.equals("R")) {
					paramvalue = "Rejected";
				}else{
					paramvalue = "";
				}
			}
		
 		return paramvalue.trim();
	}
}
