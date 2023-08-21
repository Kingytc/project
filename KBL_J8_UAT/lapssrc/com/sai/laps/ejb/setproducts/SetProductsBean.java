
package com.sai.laps.ejb.setproducts;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.SetupParams;
import com.sai.laps.tagdatahelper.TagDataHelper7;

@Stateless(name = "SetProductsBean", mappedName = "SetProductsHome")
@Remote (SetProductsRemote.class)

public class SetProductsBean extends BeanAdapter {
	private static final long serialVersionUID = 3375734576555026530L;
	static Logger log=Logger.getLogger(SetProductsBean.class);
	
	public HashMap updateData(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = null;
		String strAction = correctNull((String) hshValues.get("hidAction"));
		java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setMinimumIntegerDigits(4);
		nf.setGroupingUsed(false);
		String strProductCode = null;
		ResultSet rs = null;
		String strKeyId = "",strExp="$",strQuery=null;
		int intUpdateSize=0;
		String strProductInternet = null;	
		try {
			String strprdstop="",strloantype="",strstaffloan="",streligible="",strtermsid="",strtermdesc="";
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
		
			hshQueryValues.put("size", "2");
			//Added by Zahoorunnisa.S for allowing one internet product per type 
			if(correctNull((String) hshValues.get("sel_internet")).equalsIgnoreCase("Y")){
				if(Helper.correctNull((String)hshValues.get("prd_code")).trim().equalsIgnoreCase("New"))
				{
					strProductInternet = getProductCode();
				}
				else
				{
					strProductInternet = Helper.correctNull((String)hshValues.get("prd_code")).trim();
				}
			
			strQuery = SQLParser.getSqlQuery("prd_internet_select^" + correctNull((String)hshValues.get("prd_type"))+"^"+strProductInternet);
			rs = DBUtils.executeQuery(strQuery);	
			while(rs.next()){
					
					strExp = strExp	+ "Internet Product already exists for this Product type";
					throw new Exception(strExp);
				}
			}
            if(rs != null){
            	rs.close();
            }
			//End
			if (strAction.equalsIgnoreCase("insert")) {
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "ins_setproducts");
				strProductCode = getProductCode();
				arrValues = new ArrayList();
				arrValues.add(strProductCode);
				hshValues.put("prd_code", nf.format(Long.parseLong(strProductCode)));
				arrValues.add(correctNull((String)hshValues.get("prd_catid")));
				arrValues.add(correctNull((String)hshValues.get("prd_desc").toString().toUpperCase()));
				arrValues.add(correctNull((String)hshValues.get("prd_type")));
				arrValues.add(correctNull((String)hshValues.get("prd_rng_from")));
				arrValues.add(correctNull((String)hshValues.get("prd_rng_to")));
				arrValues.add(correctNull((String)hshValues.get("prd_intro_date")));
				arrValues.add(correctNull((String)hshValues.get("prd_mod_date")));
				arrValues.add(correctNull((String)hshValues.get("prd_stop")));
				arrValues.add(correctNull((String)hshValues.get("prd_eff_date")));
				arrValues.add(correctNull((String)hshValues.get("prd_term")));
				arrValues.add(correctNull((String)hshValues.get("prd_minterm")));
				arrValues.add(correctNull((String)hshValues.get("sec_unsecfl")));
				arrValues.add(correctNull((String)hshValues.get("int_tenorfl")));
				arrValues.add(correctNull((String)hshValues.get("int_amtfl")));
				arrValues.add(correctNull((String)hshValues.get("repay_schefl")));
				arrValues.add(correctNull((String)hshValues.get("prd_loantype")));
				arrValues.add(correctNull((String)hshValues.get("govtsponsor")));
				arrValues.add(correctNull((String)hshValues.get("txt_type_loan")));
				arrValues.add(correctNull((String)hshValues.get("schemecodeid1")));
				arrValues.add(correctNull((String)hshValues.get("txt_subsidary")));
				arrValues.add(correctNull((String) hshValues.get("prd_incomeflag")));
				arrValues.add(correctNull((String) hshValues.get("prd_principal")));
				arrValues.add(correctNull((String) hshValues.get("prd_interest")));
				arrValues.add(correctNull((String) hshValues.get("nsc_check")));
				arrValues.add(correctNull((String) hshValues.get("maxmetro")));
				arrValues.add(correctNull((String) hshValues.get("maxnonmetro")));
				arrValues.add(correctNull((String) hshValues.get("sel_staffloan")));
				if(correctNull((String)hshValues.get("prd_type")).equalsIgnoreCase("pE"))
				{
					arrValues.add(correctNull((String) hshValues.get("sel_splscheme")));
				}else{
					arrValues.add(correctNull((String) hshValues.get("sel_homeplus")));
				}
				arrValues.add(correctNull((String) hshValues.get("prd_validupto_date")));
				arrValues.add(correctNull((String) hshValues.get("sel_internet")));
				arrValues.add(correctNull((String) hshValues.get("txtprd_holiday")));
				arrValues.add(correctNull((String) hshValues.get("sel_schemetype")));
				arrValues.add(correctNull((String) hshValues.get("prd_addintrate")));
				arrValues.add(correctNull((String) hshValues.get("sel_whetheragri")));
				arrValues.add(correctNull((String)hshValues.get("sel_bankscheme")));
				arrValues.add(correctNull((String)hshValues.get("selintrate")));
				if(correctNull((String)hshValues.get("prd_type")).equalsIgnoreCase("pH"))
				{
					arrValues.add(correctNull((String)hshValues.get("sel_purpose_of_loan")));
				}
				else if(correctNull((String)hshValues.get("prd_type")).equalsIgnoreCase("pA"))
				{
					arrValues.add(correctNull((String)hshValues.get("sel_vehicletype")));
				}
				else if(correctNull((String)hshValues.get("prd_type")).equalsIgnoreCase("pE"))
				{
					arrValues.add(correctNull((String)hshValues.get("sel_edu_loan")));
				}
				else
				{
					arrValues.add("");
				}
				arrValues.add(correctNull((String)hshValues.get("selstaffloan_under")));
				arrValues.add(correctNull((String)hshValues.get("txt_repaytprincipal_staff")));
				arrValues.add(correctNull((String)hshValues.get("txt_repaytinterest_staff")));
				arrValues.add(correctNull((String)hshValues.get("hidRepaymentType")));
				arrValues.add(correctNull((String)hshValues.get("sel_deposittype")));
				arrValues.add(correctNull((String)hshValues.get("sel_loanfor")));
				arrValues.add(correctNull((String)hshValues.get("sel_ProAppFor")));
				arrValues.add(correctNull((String)hshValues.get("sel_VehiType")));
				arrValues.add(correctNull((String)hshValues.get("loan_again_share")));
				arrValues.add(correctNull((String)hshValues.get("sel_whtDigiProduct")));
				arrValues.add(correctNull((String)hshValues.get("hidInterestType")));
				arrValues.add(correctNull((String)hshValues.get("prd_termrest")));
				arrValues.add(correctNull((String)hshValues.get("prd_mintermrest")));
				arrValues.add(correctNull((String) hshValues.get("txtprd_holidayrest")));
				arrValues.add(correctNull((String) hshValues.get("sel_CGTMSE")));
				hshQuery.put("arrValues", arrValues);

				hshQueryValues.put("1", hshQuery);
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "setproductsbusins");
				arrValues = new ArrayList();
				arrValues.add(strProductCode);
				arrValues.add(hshValues.get("hidselid"));
				arrValues.add(hshValues.get("hidtermid"));
				arrValues.add(correctNull((String)hshValues.get("sel_busruleid")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				String strPrdType=Helper.correctNull((String)hshValues.get("prd_type"));
				if(strPrdType.equalsIgnoreCase("pG")||strPrdType.equalsIgnoreCase("pR"))
				{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId", "ins_prdinterest");
					arrValues.add(strProductCode);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
			}
			if (strAction.equalsIgnoreCase("update")) {
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "setproductsupd");
				arrValues = new ArrayList();
				arrValues.add(correctNull((String)hshValues.get("prd_catid")));
				arrValues.add(correctNull((String)hshValues.get("prd_desc").toString().toUpperCase()));
				arrValues.add(correctNull((String)hshValues.get("prd_type")));
				arrValues.add(correctNull((String)hshValues.get("prd_rng_from")));
				arrValues.add(correctNull((String)hshValues.get("prd_rng_to")));
				arrValues.add(correctNull((String)hshValues.get("prd_intro_date")));
				arrValues.add(correctNull((String)hshValues.get("prd_mod_date")));
				arrValues.add(correctNull((String)hshValues.get("prd_stop")));
				arrValues.add(correctNull((String)hshValues.get("prd_eff_date")));
				arrValues.add(correctNull((String)hshValues.get("prd_term")));
				arrValues.add(correctNull((String)hshValues.get("prd_minterm")));
				arrValues.add(correctNull((String)hshValues.get("sec_unsecfl")));
				arrValues.add(correctNull((String)hshValues.get("int_tenorfl")));
				arrValues.add(correctNull((String)hshValues.get("int_amtfl")));
				arrValues.add(correctNull((String)hshValues.get("repay_schefl")));
				arrValues.add(correctNull((String)hshValues.get("prd_loantype")));
				arrValues.add(correctNull((String)hshValues.get("govtsponsor")));
				arrValues.add(correctNull((String)hshValues.get("txt_type_loan")));
				arrValues.add(correctNull((String)hshValues.get("schemecodeid1")));
				arrValues.add(correctNull((String)hshValues.get("txt_subsidary")));
				arrValues.add(correctNull((String) hshValues.get("prd_incomeflag")));
				arrValues.add(hshValues.get("prd_principal"));
				arrValues.add(hshValues.get("prd_interest"));
				arrValues.add(hshValues.get("nsc_check"));
				arrValues.add(hshValues.get("maxmetro"));
				arrValues.add(hshValues.get("maxnonmetro"));
				arrValues.add(hshValues.get("sel_staffloan"));
				if(correctNull((String)hshValues.get("prd_type")).equalsIgnoreCase("pE"))
				{
					arrValues.add(correctNull((String) hshValues.get("sel_splscheme")));
				}else{
					arrValues.add(correctNull((String) hshValues.get("sel_homeplus")));
				}
				arrValues.add(correctNull((String) hshValues.get("prd_validupto_date")));
				arrValues.add(correctNull((String) hshValues.get("sel_internet")));
				arrValues.add(correctNull((String) hshValues.get("txtprd_holiday")));
				arrValues.add(correctNull((String) hshValues.get("sel_schemetype")));
				arrValues.add(correctNull((String) hshValues.get("prd_addintrate")));
				arrValues.add(correctNull((String) hshValues.get("sel_whetheragri")));
				arrValues.add(correctNull((String)hshValues.get("sel_bankscheme")));
				arrValues.add(correctNull((String)hshValues.get("selintrate")));
				if(correctNull((String)hshValues.get("prd_type")).equalsIgnoreCase("pH"))
				{
					arrValues.add(correctNull((String)hshValues.get("sel_purpose_of_loan")));
				}
				else if(correctNull((String)hshValues.get("prd_type")).equalsIgnoreCase("pA"))
				{
					arrValues.add(correctNull((String)hshValues.get("sel_vehicletype")));
				}
				else if(correctNull((String)hshValues.get("prd_type")).equalsIgnoreCase("pE"))
				{
					arrValues.add(correctNull((String)hshValues.get("sel_edu_loan")));
				}
				else
				{
					arrValues.add("");
				}
				arrValues.add(correctNull((String)hshValues.get("selstaffloan_under")));
				arrValues.add(correctNull((String)hshValues.get("txt_repaytprincipal_staff")));
				arrValues.add(correctNull((String)hshValues.get("txt_repaytinterest_staff")));
				arrValues.add(correctNull((String)hshValues.get("hidRepaymentType")));
				arrValues.add(correctNull((String)hshValues.get("sel_deposittype")));
				arrValues.add(correctNull((String)hshValues.get("sel_loanfor")));
				arrValues.add(correctNull((String)hshValues.get("sel_ProAppFor")));
				arrValues.add(correctNull((String)hshValues.get("sel_VehiType")));
				arrValues.add(correctNull((String)hshValues.get("loan_again_share")));
				arrValues.add(correctNull((String)hshValues.get("sel_whtDigiProduct")));
				arrValues.add(correctNull((String)hshValues.get("hidInterestType")));
				arrValues.add(correctNull((String)hshValues.get("prd_termrest")));
				arrValues.add(correctNull((String)hshValues.get("prd_mintermrest")));
				arrValues.add(correctNull((String) hshValues.get("txtprd_holidayrest")));
				arrValues.add(correctNull((String) hshValues.get("sel_CGTMSE")));
				arrValues.add(hshValues.get("prd_code"));
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "setproductsbusupd");
				arrValues = new ArrayList();
				arrValues.add(hshValues.get("hidselid"));
				arrValues.add(hshValues.get("seltermid"));
				arrValues.add(correctNull((String)hshValues.get("sel_busruleid")));
				arrValues.add(hshValues.get("prd_code"));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			if (strAction.equalsIgnoreCase("delete")) {
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdateSize++;
				
				hshQuery.put("strQueryId", "setproductsbusdel");
				
				arrValues.add(hshValues.get("prd_code"));
				hshQuery.put("arrValues", arrValues);
				
				hshQueryValues.put("size", Integer.toString(intUpdateSize));
				hshQueryValues.put(Integer.toString(intUpdateSize), hshQuery);

				//to delete entries in workflow table
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdateSize++;
				hshQuery.put("strQueryId", "setproductsworkdel");
				arrValues.add(hshValues.get("prd_code"));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdateSize));
				hshQueryValues.put(Integer.toString(intUpdateSize), hshQuery);

				//to delete entries in the documents table
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdateSize++;
				hshQuery.put("strQueryId", "setproductsdocdel");
				arrValues.add(hshValues.get("prd_code"));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdateSize));
				hshQueryValues.put(Integer.toString(intUpdateSize), hshQuery);

				//to delete entries in the authority table
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdateSize++;
				hshQuery.put("strQueryId", "setproductsauthdel");
				arrValues.add(hshValues.get("prd_code"));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdateSize));
				hshQueryValues.put(Integer.toString(intUpdateSize), hshQuery);

				//to delete the other charges table
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdateSize++;
				hshQuery.put("strQueryId", "setproductsinterestdel");
				arrValues.add(hshValues.get("prd_code"));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdateSize));
				hshQueryValues.put(Integer.toString(intUpdateSize), hshQuery);

				//to delete entries in used by table by Guhan.T
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdateSize++;
				hshQuery.put("strQueryId", "setprdusedbydel");
				arrValues.add(hshValues.get("prd_code"));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdateSize));
				hshQueryValues.put(Integer.toString(intUpdateSize), hshQuery);

				//to delete the entries in documents charges table
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdateSize++;
				hshQuery.put("strQueryId", "setproductsdocchrgdel");
				arrValues.add(hshValues.get("prd_code"));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdateSize));
				hshQueryValues.put(Integer.toString(intUpdateSize), hshQuery);

				//to delete the entries in product charges table
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdateSize++;
				hshQuery.put("strQueryId", "setproductsprocchrgdel");
				arrValues.add(hshValues.get("prd_code"));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdateSize));
				hshQueryValues.put(Integer.toString(intUpdateSize), hshQuery);

				//to delete entries in sanction limits table
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdateSize++;
				hshQuery.put("strQueryId", "setproductssancdel");
				arrValues.add(hshValues.get("prd_code"));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdateSize));
				hshQueryValues.put(Integer.toString(intUpdateSize), hshQuery);

				//substeprules table
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdateSize++;
				hshQuery.put("strQueryId", "setproductsstepdel");
				arrValues.add(hshValues.get("prd_code"));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdateSize));
				hshQueryValues.put(Integer.toString(intUpdateSize), hshQuery);

				//to delete entries in products table
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdateSize++;
				hshQuery.put("strQueryId", "setmargindel");
				arrValues.add(hshValues.get("prd_code"));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdateSize));
				hshQueryValues.put(Integer.toString(intUpdateSize), hshQuery);

				//to delete in repayment capcity page
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdateSize++;
				hshQuery.put("strQueryId", "delprdrepaycapacity");
				arrValues.add(hshValues.get("prd_code"));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdateSize));
				hshQueryValues.put(Integer.toString(intUpdateSize), hshQuery);
				
				//to delete data in specific conditions page by Guhan.T
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdateSize++;
				hshQuery.put("strQueryId", "del_specificeligible");
				arrValues.add(hshValues.get("prd_code"));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdateSize));
				hshQueryValues.put(Integer.toString(intUpdateSize), hshQuery);
				
				//to delete entries in products table
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdateSize++;
				hshQuery.put("strQueryId", "setproductsdel");
				arrValues.add(hshValues.get("prd_code"));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdateSize));
				hshQueryValues.put(Integer.toString(intUpdateSize), hshQuery);
				
				//to delete entries in activity codes table by Guhan.T
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdateSize++;
				hshQuery.put("strQueryId", "setactivitycodedel");
				arrValues.add(hshValues.get("prd_code"));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdateSize));
				hshQueryValues.put(Integer.toString(intUpdateSize), hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				
				ArrayList vecInt = (ArrayList) getDeleteMasterdata((String) hshValues.get("prd_code"));
				for (int k = 0; k < vecInt.size(); k++) 
				{					
					hshQuery = new HashMap();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "setproductsintlimitdel");
					arrValues = new ArrayList();
					arrValues.add(vecInt.get(k));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					
					hshQuery = new HashMap();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "setproductsintmastdel");
					arrValues = new ArrayList();
					arrValues.add(hshValues.get("prd_code"));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
			}
			
			String nsccheck="";
			
			strprdstop=correctNull((String)hshValues.get("prd_stop"));
			if(strprdstop.equalsIgnoreCase("N"))
			{
				strprdstop="No";
			}
			else if(strprdstop.equalsIgnoreCase("Y"))
			{
				strprdstop="Yes";
			}
			
			strloantype=correctNull((String)hshValues.get("prd_loantype"));
			
			if(strloantype.trim().equalsIgnoreCase("TL"))
			{
				strloantype="Term Loan";
			}
			else if(strloantype.trim().equalsIgnoreCase("DL"))
			{
				strloantype="Demand Loan";
			}
			else if(strloantype.trim().equalsIgnoreCase("OD"))
			{
				strloantype="Over Draft";
			}
			else if(strloantype.trim().equalsIgnoreCase("IP"))
			{
				strloantype="Loan for IPOs";
			}
               
			strstaffloan=correctNull((String)hshValues.get("sel_staffloan"));
			
			if(strstaffloan.trim().equalsIgnoreCase("Y"))
			{
				strstaffloan="Yes";
			}
			else
			{
				strstaffloan="No";
			}
			streligible=correctNull((String)hshValues.get("prd_incomeflag"));
			if(streligible.trim().equalsIgnoreCase("0"))
			{
				streligible="Gross Income";
			}
			if(streligible.trim().equalsIgnoreCase("1"))
			{
				streligible="Net Income";
			}
			else if(streligible.trim().equalsIgnoreCase("2"))
			{
				streligible="Both (Gross Income & Net Income)";
			}
			
			if(correctNull((String)hshValues.get("nsc_check")).equals("1"))
			{
				nsccheck = "Yes";
			}
			else
			{
				nsccheck = "No";
			}
			strtermsid=correctNull((String)hshValues.get("seltermid"));
			rs = DBUtils.executeLAPSQuery("getmodtermcond^"+strtermsid);
			if (rs.next()) {
				strtermdesc=Helper.correctNull((String) rs.getString("terms_desc"));
			}
			if (rs != null) {
				rs.close();
			}
			String getProduct = SetupParams.getSetupParams("ProductRetailandAgri",correctNull((String)hshValues.get("prd_type1")));
			StringBuilder sbAuditTrial=new StringBuilder();
			if(!strAction.equalsIgnoreCase("delete"))
			{
			sbAuditTrial.append(
			"~Creation Date=").append(correctNull((String)hshValues.get("prd_intro_date"))).append(
			"~Modified Date=").append(correctNull((String)hshValues.get("prd_mod_date"))).append("~Product Code=").append(correctNull((String)hshValues.get("prd_code")))
			.append("~Product For=").append(getProduct+" ").append(correctNull((String)hshValues.get("prd_type3")))
			.append( 
			"~Product Loan Type=").append(strloantype).append( 
			"~Scheme Code=").append(correctNull((String)hshValues.get("schemecodeid1"))).append( 
			"~Category=").append(correctNull((String)hshValues.get("catname"))).append( 
			"~Sub Category=").append(correctNull((String)hshValues.get("scatname"))).
			append( 
			"~Staff Loan=").append(strstaffloan);
			if(correctNull((String)hshValues.get("prd_type2")).equals("H"))
			{
				sbAuditTrial.append(
				"~Maximum Loan for Metro=").append(correctNull((String)hshValues.get("maxmetro"))).append(
				"~Union home plus=").append(correctNull((String)hshValues.get("sel_homeplus"))).append(
				"~Maximum Loan for Non-Metro=").append(correctNull((String)hshValues.get("maxnonmetro")));
			}
			if(correctNull((String)hshValues.get("prd_type2")).equals("E"))
			{
				sbAuditTrial.append("~Spl. scheme=").append(Helper.correctNull((String)hshValues.get("sel_splscheme")));
			}
			sbAuditTrial.append(
			"~Product Range From=").append(correctNull((String)hshValues.get("prd_rng_from"))).append(
			"~Product Range To=").append(correctNull((String)hshValues.get("prd_rng_to"))).append(
			"~Min. Repayment Period=").append(correctNull((String)hshValues.get("prd_minterm"))).append(
			"~Max. Repayment Period=").append(correctNull((String)hshValues.get("prd_term"))).append(
			"~Product Description=").append(correctNull((String)hshValues.get("prd_desc"))).append(
			"~Eligibility based on =").append(streligible).append(
			    "~NSC Loan=").append(nsccheck);
			if(strstaffloan.equals("Yes"))
			{
				sbAuditTrial.append(
			    "~Repayment Ratio(Principal)=").append(correctNull((String)hshValues.get("prd_principal"))).append(
			    "~Repayment Ratio(Interest)=").append(correctNull((String)hshValues.get("prd_interest")));
			}
			sbAuditTrial.append(
			  	"~Stop the product for current users=").append(strprdstop).append(
			    "~Scoring Pattern=").append((correctNull((String)hshValues.get("selid1")).equals("0"))?"":correctNull((String)hshValues.get("selid1"))).append(
			"~Product effective date=").append(correctNull((String)hshValues.get("prd_eff_date"))).append(
			"~Select Terms and Conditions=").append(strtermdesc).append("~Valid upto=").append(correctNull((String) hshValues.get("prd_validupto_date"))).append(
			"~Applicable Repayment types=").append(correctNull((String)hshValues.get("hidRepaymentType"))).append(
			"~Applicable Interest type=").append(correctNull((String)hshValues.get("hidInterestType")))
			.append("~Internet Product=").append(SetupParams.getSetupParams("YesNoFlag",Helper.correctNull((String) hshValues.get("sel_internet"))));
			
			if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y")){
				strProductCode=correctNull((String)hshValues.get("prd_code"));
				hshValues.put("hidAction", "update");
			}
			
			int intProductCode = Integer.parseInt(strProductCode);
			String strPrdCode= Integer.toString(intProductCode);					
			AuditTrial.auditLog(hshValues,"13",strPrdCode,sbAuditTrial.toString());
			}
			
			/*if(Helper.correctNull(ApplicationParams.getstrOnlineEnabled()).equalsIgnoreCase("YES")){
				if(correctNull((String) hshValues.get("sel_internet")).equalsIgnoreCase("Y")){
					updateOnline(hshValues);
				}}
			
			if(Helper.correctNull(ApplicationParams.getstrOnlineEnabled()).equalsIgnoreCase("YES")){
				if(correctNull((String) hshValues.get("sel_internet")).equalsIgnoreCase("Y")){
					updateOnlineRepayCapacity(hshValues);
				}}*/
						
			if (strAction.equalsIgnoreCase("insert")) {
				hshValues.put("prdCode",strProductCode);
				hshValues=getData(hshValues);
				return hshValues;
			} else {
				return null;
			}
			
		} 
		catch (Exception ce)
		{
			log.error(ce);
			throw new EJBException("Error in updateData " + ce.getMessage());
		}
		
		 finally 
		 {
				try
				{
				 	if (rs != null) 
					{
						rs.close();
					}
				}
				catch(Exception e)
				{
					log.error(e);
					throw new EJBException("Error closing the connection "+e.getMessage());
				}
			}
		
		
	}

	private String getProductCode() throws Exception {
		String strPrdCode = "";
		ResultSet rs = null;
		try {
			rs = DBUtils.executeLAPSQuery("setproductcode");
			if (rs.next()) {
				strPrdCode = rs.getString("prd_code");
			}
		} catch (Exception e) {
			log.error("exception in getProductCode.. " + e);
			throw e;
		} finally {
			if (rs != null) {
				rs.close();
			}
		}
		return strPrdCode;
	}

	public HashMap getLimitCode(HashMap hsh)  {
		ResultSet rs = null;
		String totalval = "";
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		HashMap hshvalues = new HashMap();
		try {
			rs = DBUtils.executeLAPSQuery("productcode");
			while (rs.next()) {
				totalval = correctNull(rs.getString("prd_code")) + "---"
						+ correctNull(rs.getString("prd_rng_from")) + "---"
						+ correctNull(rs.getString("prd_rng_to"));
				arr.add(totalval);
				arr1.add(correctNull(rs.getString("prd_code")));

			}
			hshvalues.put("arrVal", arr1);
			hshvalues.put("arrValdesc", arr);

		} catch (Exception e) {
			log.error("exception in getProductCode.. " + e);
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();

				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}
		}
		return hshvalues;
	}

	public HashMap getData(HashMap hshRequestValues)  {

		ResultSet rs = null;
		ResultSet rs1=null;
		HashMap hshRecord = null;
		String strProductCode = null;
		java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setMinimumIntegerDigits(4);
		nf.setGroupingUsed(false);
		boolean recordflag=false;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		try {

			strProductCode = correctNull((String)hshRequestValues.get("prdCode"));
			
			if (strProductCode.equals("")
					|| strProductCode.equalsIgnoreCase("New")) {				
		
				
				if(rs1!=null)
					rs1.close();
				
				rs1=DBUtils.executeLAPSQuery("selgetrulesall");
				while(rs1.next())
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull((String)rs1.getString("rsk_rule_id")));//0
					arrCol.add(Helper.correctNull((String)rs1.getString("rsk_rule_desc")));//1
					arrCol.add(Helper.correctNull((String)rs1.getString("rsk_rule_params")));//2
					arrRow.add(arrCol);
					
				}
				hshRecord = new HashMap();
				hshRecord.put("arrRow", arrRow);		
				return hshRecord;
			}

			rs = DBUtils.executeLAPSQuery("setproductssel^" + strProductCode);

			hshRecord = new HashMap();

			while (rs.next()) {
				recordflag=true;
				hshRecord.put("prd_code", nf.format(Long.parseLong(strProductCode)));
				hshRecord.put("prd_catid", correctNull((String) rs.getString("prd_catid")));
				hshRecord.put("scatname", correctNull((String) rs.getString("scatname")));
				hshRecord.put("cat_id", correctNull((String) rs.getString("cat_id")));
				hshRecord.put("catname", correctNull(rs.getString("catname")));
				hshRecord.put("prd_desc", correctNull(rs.getString("prd_desc")));
				hshRecord.put("prd_type", correctNull((String) rs.getString("prd_type")));
				hshRecord.put("prd_rng_from", correctNull(rs.getString("prd_rng_from")));
				hshRecord.put("prd_rng_to", correctNull((String) rs.getString("prd_rng_to")));
				hshRecord.put("prd_intro_date", correctNull((String) rs.getString("prd_intro_date")));
				hshRecord.put("prd_mod_date", correctNull((String) rs.getString("prd_mod_date")));
				hshRecord.put("prd_stop", correctNull((String) rs.getString("prd_stop")));
				hshRecord.put("prd_eff_date", correctNull((String) rs.getString("prd_eff_date")));
				hshRecord.put("prd_saveflag", correctNull((String) rs.getString("prd_saveflag")));
				hshRecord.put("prd_term", correctNull((String) rs.getString("prd_term")));
				hshRecord.put("prd_minterm", correctNull((String) rs.getString("prd_minterm")));
				hshRecord.put("sec_unsecfl", correctNull((String) rs.getString("sec_unsecfl")));
				hshRecord.put("int_tenorfl", correctNull((String) rs.getString("int_tenorfl")));
				hshRecord.put("int_amtfl", correctNull((String) rs.getString("int_amtfl")));
				hshRecord.put("repay_schefl", correctNull((String) rs.getString("repay_schefl")));
				hshRecord.put("buss_id", correctNull((String) rs.getString("buss_bussid")));
				hshRecord.put("terms_id", correctNull((String) rs.getString("buss_termid")));
				hshRecord.put("prd_loantype", correctNull((String) rs.getString("prd_loantype")));
				hshRecord.put("govt_sponsor", correctNull((String) rs.getString("govt_sponsor")));
				hshRecord.put("prd_loan_type", correctNull((String) rs.getString("prd_loan_type")));
				hshRecord.put("scheme_code", correctNull((String) rs.getString("scheme_code")));
				hshRecord.put("subsidary", correctNull((String) rs.getString("subsidary")));
				hshRecord.put("prd_incomeflag", correctNull((String) rs.getString("incomeflag")));
//				added by mohan for Repayment Ratio(Principal:Interest) on 21-aug-07
				hshRecord.put("prd_principal", correctNull((String) rs.getString("PRD_PRINCIPAL")));
				hshRecord.put("prd_interest", correctNull((String) rs.getString("PRD_INTEREST")));
				hshRecord.put("nscloan_check", correctNull((String) rs.getString("NSC_LOAN")));
				hshRecord.put("maxmetro", correctNull((String) rs.getString("maxmetro")));
				hshRecord.put("maxnon_metro", correctNull((String) rs.getString("maxnon_metro")));
				hshRecord.put("staffproduct_check", correctNull((String) rs.getString("prd_staffprd")));
				hshRecord.put("homeplus_check", correctNull((String) rs.getString("prd_homeplus")));
				hshRecord.put("subcode", correctNull((String) rs.getString("prd_subcode")));
				//Kamal for prd_validupto_date
				hshRecord.put("prd_validupto_date", correctNull((String) rs.getString("prd_validupto_date")));
				//end
				//Added By Zahoorunnisa.S for Online Interface
				hshRecord.put("prd_internet", correctNull((String) rs.getString("prd_internet")));
				hshRecord.put("prd_holiday", correctNull((String) rs.getString("prd_holiday")));
				hshRecord.put("prd_schemetype", correctNull((String) rs.getString("prd_schemetype")));
				hshRecord.put("prd_addintrate", correctNull((String) rs.getString("prd_addintrate")));
				hshRecord.put("prd_whetheragri", correctNull((String) rs.getString("prd_whetheragri")));
				hshRecord.put("prd_bankscheme", correctNull((String) rs.getString("prd_bankscheme")));
				hshRecord.put("prd_intrate", correctNull((String) rs.getString("PRD_INTRATE")));
				//Added By Arsath for Purpose/Type field for Housing & Vehicle Loan
				hshRecord.put("prd_purpose", correctNull((String) rs.getString("prd_purpose")));
				hshRecord.put("staff_under", correctNull((String) rs.getString("staff_under")));
				hshRecord.put("buss_ruleid", correctNull((String) rs.getString("buss_ruleid")));
				hshRecord.put("prd_staff_maxterm_prin", correctNull(rs.getString("prd_staff_maxterm_prin")));
				hshRecord.put("prd_staff_maxterm_intr", correctNull(rs.getString("prd_staff_maxterm_intr")));
				hshRecord.put("prd_repaytype", correctNull(rs.getString("prd_repaytype")));
				hshRecord.put("prd_deposittype", correctNull(rs.getString("prd_deposittype")));
				hshRecord.put("prd_depositloanfor", correctNull(rs.getString("prd_depositloanfor")));
				hshRecord.put("prd_applicablefor", correctNull(rs.getString("prd_applicablefor")));
				hshRecord.put("prd_vehitype", correctNull(rs.getString("prd_vehitype")));
				hshRecord.put("PRD_SHARETYPE", correctNull(rs.getString("PRD_SHARETYPE")));
				hshRecord.put("PRD_WHTDIGIPRD", correctNull(rs.getString("PRD_WHTDIGIPRD")));
				hshRecord.put("prd_interesttype", correctNull(rs.getString("prd_interesttype")));
				hshRecord.put("PRD_TERM_REST", correctNull(rs.getString("PRD_TERM_REST")));
				hshRecord.put("PRD_MINTERM_REST", correctNull(rs.getString("PRD_MINTERM_REST")));
				hshRecord.put("PRD_HOLIDAY_REST", correctNull(rs.getString("PRD_HOLIDAY_REST")));
				hshRecord.put("PRD_CGTMSEFALG", correctNull(rs.getString("PRD_CGTMSEFALG")));
			}
			hshRecord.put("checkApp", checkApplication(hshRequestValues));
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
			/*rs = null;
			String strquery=SQLParser.getSqlQuery("prdedusel^" + strProductCode);
			rs = DBUtils.executeQuery(strquery);

			if (rs.next()) {
				hshRecord.put("prd_eduflag", correctNull((String) rs.getString("prd_eduflag")));
				hshRecord.put("prd_penlimit", correctNull((String) rs.getString("prd_penlimit")));
				hshRecord.put("prd_incomeflag", correctNull((String) rs.getString("prd_incomeflag")));
			} else {
				hshRecord.put("prd_eduflag", "n");
				hshRecord.put("prd_penlimit", "");
				//hshRecord.put("prd_incomeflag", "");
			}*/
			
			if(rs1!=null)
				rs1.close();
			
			rs1=DBUtils.executeLAPSQuery("selgetrulesall");
			while(rs1.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull((String)rs1.getString("rsk_rule_id")));//0
				arrCol.add(Helper.correctNull((String)rs1.getString("rsk_rule_desc")));//1
				arrCol.add(Helper.correctNull((String)rs1.getString("rsk_rule_params")));//2
				arrRow.add(arrCol);
				
			}
			hshRecord.put("arrRow", arrRow);		
			
			
			
		} catch (Exception e) {
			log.error("exception in getData... " + e);
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}

		}
		return hshRecord;
	}

	public HashMap getCatgList(HashMap hshRequestValues)  {
		ResultSet rs = null;
		HashMap hshRecord = null;
		String strCatId = null;
		try {
			strCatId = (String) hshRequestValues.get("cat_id");
			rs = DBUtils.executeLAPSQuery("categorylist^" + strCatId);
			hshRecord = new HashMap();
			while (rs.next()) {
				String strId = rs.getString("cat_id");
				String strName = rs.getString("cat_name");
				hshRecord.put(strId, strName);
			}

		} catch (Exception ce) {
			log.error(ce.toString());
			throw new EJBException("Error in getCatgList " + ce.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();

				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}
		}
		return hshRecord;
	}

	public String checkProductSaveStatus(HashMap hshValues)  {
		ResultSet rs = null;
		String strPrdStatus = "";
		String strQuery = null;
		String strProductCode = Helper.correctNull((String) hshValues.get("prdCode"));
		if(strProductCode.equalsIgnoreCase(""))
		{ 
			strProductCode = correctNull((String) hshValues.get("fac_id"));
		}
		String strProductType="";
		try {
			strProductType=Helper.correctNull((String)hshValues.get("hidProductType"));
			if(strProductType.equalsIgnoreCase("")&&!strProductCode.equalsIgnoreCase(""))
			{
				strQuery = SQLParser.getSqlQuery("selproducttype^"+ strProductCode);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strProductType=Helper.correctNull((String)rs.getString("prd_type"));
				}
				if (rs != null) {
					rs.close();
				}
			}
			rs = DBUtils.executeLAPSQuery("checkprdused^" + strProductCode);
			rs.next();
			if (rs.getInt(1) == 0) {
				strPrdStatus += "u";
			}
			strQuery = SQLParser.getSqlQuery("checkprdauth^" + strProductCode);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			rs.next();
			if (rs.getInt(1) == 0) {
				strPrdStatus += "a";
			}
			strQuery = SQLParser.getSqlQuery("checkprdworkflow^"+ strProductCode + "^p");
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			rs.next();
			if (rs.getInt(1) == 0) {
				strPrdStatus += "w";
			}
			strQuery = SQLParser.getSqlQuery("checkprdworkflow^"+ strProductCode + "^a");
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			rs.next();
			if (rs.getInt(1) == 0) {
				strPrdStatus += "w";
			}
			strQuery = SQLParser.getSqlQuery("checkprdworkflow^"+ strProductCode + "^r");
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			rs.next();
			if (rs.getInt(1) == 0) {
				strPrdStatus += "w";
			}
			strQuery = SQLParser.getSqlQuery("checkprddoc^" + strProductCode);
			if (rs != null)

			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			rs.next();
			if (rs.getInt(1) == 0) {
				strPrdStatus += "d";
			}
			
			/*strQuery = SQLParser.getSqlQuery("checkprddocfee^"+ strProductCode);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			rs.next();
			if (rs.getInt(1) == 0) {
				strPrdStatus += "d";
			}*/
			strQuery = SQLParser.getSqlQuery("checkprdprocfee^"+ strProductCode);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			rs.next();
			if (rs.getInt(1) == 0) {
				strPrdStatus += "pr";
			}
			
			strQuery = SQLParser.getSqlQuery("checkprdmargin^"+ strProductCode);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			rs.next();
			if (rs.getInt(1) == 0) {
				strPrdStatus += "m";
			}
			if(!(strProductType.equalsIgnoreCase("pG")||strProductType.equalsIgnoreCase("aH")||
					strProductType.equalsIgnoreCase("pR")))
			{
				strQuery = SQLParser.getSqlQuery("checkprdinterest^"+ strProductCode);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				rs.next();
				if (rs.getInt(1) == 0) {
					strPrdStatus += "i";
				}
				strQuery = SQLParser.getSqlQuery("checkprdrepay^"+ strProductCode);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				rs.next();
				if (rs.getInt(1) == 0) {
					strPrdStatus += "r";
				}
			}
			if(strProductType.equalsIgnoreCase("pG")||strProductType.equalsIgnoreCase("aH"))
			{
				strQuery = SQLParser.getSqlQuery("checkprdrentinsurefee^"+ strProductCode);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				rs.next();
				if (rs.getInt(1) == 0) {
					strPrdStatus += "ri";
				}
				strQuery = SQLParser.getSqlQuery("checkprdjewelappraisalfee^"+ strProductCode);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				rs.next();
				if (rs.getInt(1) == 0) {
					strPrdStatus += "ja";
				}
			}
			/* Added for Checking entry in Products - Activity Codes */
			strQuery = SQLParser.getSqlQuery("checkprdactcode^"+ strProductCode);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			rs.next();
			if (rs.getInt(1) == 0) {
				strPrdStatus += "pa";
			}
			/* End - Checking entry in Products - Activity Codes */
			
			//Added by Punitha for Interest & terms check
			strQuery = SQLParser.getSqlQuery("checkprdinterestterms^" + strProductCode);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			rs.next();
			if (rs.getInt(1) == 0) {
				strPrdStatus += "it";
			}
			
			if (strPrdStatus.equals("")) {
				strPrdStatus = "c";
			}
		} catch (Exception e) {
			log.error("exception in checkProductSaveStatus... " + e);
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				log.error("Error closing connection.. " + e1);
			}
		}
		return strPrdStatus;
	}

	public void updateProductSaveStatus(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strPrdStatus = "";
		String strQuery="";
		ResultSet rs=null;
		String strCorpmodule=correctNull((String) hshValues.get("strCorpModule"));
		String strProductCode = correctNull((String) hshValues.get("prdCode"));
		if(strProductCode.equalsIgnoreCase(""))
		{
			strProductCode = correctNull((String) hshValues.get("fac_id"));
		}
		try {
			if((!strCorpmodule.equalsIgnoreCase("c")) && (strCorpmodule.equalsIgnoreCase("")))
			{
				strPrdStatus = checkProductSaveStatus(hshValues);
				
				
				//Digital Product - direct complete flag update
				String strwhtdigiprod="";
				strQuery=SQLParser.getSqlQuery("sel_productdesc^"+strProductCode);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strwhtdigiprod=Helper.correctNull((String)rs.getString("PRD_WHTDIGIPRD"));
				}	
				
				if(strwhtdigiprod.equals("Y"))
				{
					strPrdStatus="c";
				}
				//end
				
				hshQueryValues.put("size", "1");
	 			hshQuery.put("strQueryId", "setproductsupddate");
	   			arrValues.add(strProductCode);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				
				hshQueryValues.put("size", "2");
	
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "prdsavestatus");
	
				if (strPrdStatus.equals("c"))
					arrValues.add("c");
				else
					arrValues.add("p");
				arrValues.add(strProductCode);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			else
			{
				EJBInvoker.executeStateLess("corporatefacility", hshValues, "updateFacilitySaveStatus");
			}
		} catch (Exception e) {
			log.error("exception in updateProductSaveStatus.." + e);
			throw new EJBException(e.getMessage());
		}
	}

	public HashMap getAuthorityData(HashMap hshRequestValues)  {
		ResultSet rs = null;
		HashMap hshRecord = null;
		String strProductCode = null;
		ArrayList vecRec = new ArrayList();
		ArrayList vecVal = new ArrayList();
		String strId="7";
		boolean recordflag=false;
		try {
			strProductCode = (String) hshRequestValues.get("prdCode");
			rs = DBUtils.executeLAPSQuery("prdauthsel^" + strProductCode);
			hshRecord = new HashMap();
			while (rs.next()) 
			{
				recordflag=true;
				hshRecord.put("prd_skip", rs.getString("prd_skip"));
				hshRecord.put("prd_approval", rs.getString("prd_approval"));
				hshRecord.put("prd_maxintclass", rs.getString("prd_maxintclass"));
				hshRecord.put("prd_otherdevclass", rs.getString("prd_otherdevclass"));
				hshRecord.put("PRD_HO", rs.getString("PRD_HO"));
				hshRecord.put("PRD_RO", rs.getString("PRD_RO"));
				hshRecord.put("PRD_CLPU", rs.getString("PRD_CLPU"));
				hshRecord.put("PRD_BRANCH", rs.getString("PRD_BRANCH"));
				hshRecord.put("PRD_SANC_VALID", correctNull((String)rs.getString("PRD_SANC_VALID")));
				hshRecord.put("PRD_REVALID_DAYS", correctNull((String)rs.getString("PRD_REVALID_DAYS")));
				hshRecord.put("PRD_NOTAVAILED_DAYS", correctNull((String)rs.getString("PRD_NOTAVAILED_DAYS")));
				
			}
			
			if(!rs.equals(null))
			{
				rs.close();
			}
			strId="7";
			rs = DBUtils.executeLAPSQuery("selclasslist^"+strId);
			
			while (rs.next()) {
				
				vecRec = new ArrayList();
				vecRec.add(correctNull((String)rs.getString("stat_data_id")));
				vecRec.add(correctNull((String)rs.getString("stat_data_desc")));
				vecRec.add(correctNull((String)rs.getString("stat_data_desc1")));
				vecVal.add(vecRec);
			}

			hshRecord.put("class_list1", vecVal);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
		} catch (Exception e) {
			log.error("exception in getAuthorityData... " + e);
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}

		}
		
		return hshRecord;
	}

	public void updateAuthorityData(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strPrdCode = null;
		String strKeyId = "";
		try {
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			strPrdCode = (String) hshValues.get("prdCode");
			hshQueryValues.put("size", "2");
			hshQuery.put("strQueryId", "prdauthdel");
			arrValues.add(strPrdCode);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			hshQuery = new HashMap();
			hshQuery.put("strQueryId", "prdauthins");
			arrValues = new ArrayList();
			arrValues.add(hshValues.get("prdCode"));
			arrValues.add(hshValues.get("prd_skip"));
			arrValues.add(hshValues.get("prd_approval"));
			arrValues.add(hshValues.get("prd_maxintclass"));
			arrValues.add(Helper.correctNull((String)hshValues.get("prd_otherdev")));
			arrValues.add(hshValues.get("prd_HO"));
			arrValues.add(hshValues.get("prd_RO"));
			arrValues.add(hshValues.get("prd_CLPU"));
			arrValues.add(hshValues.get("prd_branch"));
			arrValues.add(hshValues.get("prd_sanc_days"));
			arrValues.add(hshValues.get("prd_revalid_days"));
			arrValues.add(hshValues.get("prd_notavailed_days"));
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("2", hshQuery);

			hshQuery = new HashMap();
			arrValues = new ArrayList();

			// for Entering the values into auditrial

			/*String strActionData = "prd_skip = "
					+ correctNull((String) hshValues.get("prd_skip"))
					+ "~prd_approval = "
					+ correctNull((String) hshValues.get("prd_approval"))
					+ "~prd_type = "
					+ correctNull((String) hshValues.get("prd_maxintclass"))
					+ "~prd_maxintclass= "
					+ correctNull((String) hshValues.get("prd_rng_from"))
					+ "~prd_code = "
					+ correctNull((String) hshValues.get("prd_code"));
			
			
			hshQuery.put("strQueryId", "audittrial");
			arrValues.add("100");
			arrValues.add(correctNull((String) hshValues.get("strUserId")));
			arrValues.add(correctNull((String) hshValues.get("strClientIP")));
			arrValues.add(correctNull((String) hshValues.get("prd_code")));
			arrValues.add(strActionData);
			arrValues.add("update");
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("3", hshQuery);*/
			
			
			
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			updateProductSaveStatus(hshValues);
			
			StringBuilder sbAuditTrial=new StringBuilder();
			sbAuditTrial.append("Product Code ="+strPrdCode).append("~Minimum Class for Modifying Interest Rate =").append(correctNull((String )hshValues.get("prd_int_descr")))
			.append("~Minimum Class for Approval / Rejection =").append(correctNull((String )hshValues.get("prd_app_descr")))
			.append("~Minimum Class for Skip flowpoints  =").append(correctNull((String )hshValues.get("prd_skip_descr")));
			if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
				hshValues.put("hidAction", "update");
			if(correctNull((String)hshValues.get("hidRecordflag")).equals("N"))
				hshValues.put("hidAction", "insert");
			int intProductCode = Integer.parseInt(strPrdCode);
			String strPrdCode1= Integer.toString(intProductCode);	
			AuditTrial.auditLog(hshValues,"15",strPrdCode1,sbAuditTrial.toString());
		} catch (Exception ce) {
			log.error("in bean... " + ce);
			throw new EJBException("Error in updateAuthorityData "	+ ce.toString());
		}
	}

	public HashMap getDocList(HashMap hshValues)  {
		HashMap hshRecord = new HashMap();
		ResultSet rs = null;
		ArrayList vecData = new ArrayList();
		ArrayList vecRec = new ArrayList();
		try {
			rs = DBUtils.executeLAPSQuery("prddoclist^"
					+ hshValues.get("doc_type"));
			while (rs.next()) {
				// added by balaji for aplha order on 29/03/2004
				vecRec = new ArrayList();
				vecRec.add(rs.getString("doc_code"));
				vecRec.add(rs.getString("doc_create_date"));
				vecRec.add(rs.getString("doc_desc"));
				vecData.add(vecRec);
				hshRecord.put("vecData", vecData);

			}
		} catch (Exception e) {
			log.error("Exception in getDocList.. " + e);
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				log.error("Error closing connection.. " + e1);
			}
		}
		return hshRecord;
	}

	public HashMap getDocData(HashMap hshRequestValues)  {
		ResultSet rs = null;
		String strPrdCode = null;
		HashMap hshRecord = new HashMap();
		ArrayList arrCode = new ArrayList();
		ArrayList arrDesc = new ArrayList();
		ArrayList arrDate = new ArrayList();
		ArrayList arrMand = new ArrayList();
		try {
			strPrdCode = correctNull((String)hshRequestValues.get("prdCode"));
			rs = DBUtils.executeLAPSQuery("prddocsel^" + strPrdCode + "^A");
			while (rs.next()) 
			{
				String strCode = correctNull((String)rs.getString("prd_doccode"));
				String strDesc = correctNull((String)rs.getString("doc_desc"));
				String strDate = correctNull((String)rs.getString("doc_create_date"));
				String strMand=correctNull((String)rs.getString("prd_mandatory"));
				if(strMand.equalsIgnoreCase(""))
				{
					strMand="N";
				}
				arrCode.add(strCode);
				arrDesc.add(strDesc);
				arrDate.add(strDate);
				arrMand.add(strMand);
			}
			hshRecord.put("appdoccode", arrCode);
			hshRecord.put("appdocdesc", arrDesc);
			hshRecord.put("appdocdate", arrDate);
			hshRecord.put("appdocmand", arrMand);
			rs.close();
			arrCode = new ArrayList();
			arrDesc = new ArrayList();
			arrDate = new ArrayList();
			arrMand = new ArrayList();

			rs = DBUtils.executeLAPSQuery("prddocsel^" + strPrdCode + "^I");
			while (rs.next()) {
				String strCode = correctNull((String)rs.getString("prd_doccode"));
				String strDesc = correctNull((String)rs.getString("doc_desc"));
				String strDate = correctNull((String)rs.getString("doc_create_date"));
				String strMand=correctNull((String)rs.getString("prd_mandatory"));
				if(strMand.equalsIgnoreCase(""))
				{
					strMand="N";
				}
				arrCode.add(strCode);
				arrDesc.add(strDesc);
				arrDate.add(strDate);
				arrMand.add(strMand);
			}
			hshRecord.put("intdoccode", arrCode);
			hshRecord.put("intdocdesc", arrDesc);
			hshRecord.put("intdocdate", arrDate);
			hshRecord.put("intdocmand", arrMand);
			hshRecord.put("prdType", correctNull((String)hshRequestValues.get("prdType")));
		} catch (Exception e) {
			log.error("exception in getDocData.. " + e);
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				log.error("Error closing connections.. " + e1);
			}
		}
		return hshRecord;
	}

	public HashMap interestTerm(HashMap hsh)  {
		
		java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
    	jtn.setMaximumFractionDigits(2);
    	jtn.setMinimumFractionDigits(2);
    	jtn.setGroupingUsed(false);
		
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQuery;
		HashMap hshValues = new HashMap();
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec = new ArrayList();
		ArrayList arr = new ArrayList();
		ArrayList arrValues;
		ResultSet rs = null;
		
		String[] strfrom = null;
		String[] strto = null;
		String[] total = null;
		String[] baserate = null;
		String[] adjust = null;
		String[] interest = null;
		String[] strpoint = null;
		String[] strtablecode = null;
		String[] strcreditRiskPremium = null;
		String[] strbusstrategicPremium = null;
		
		String val = "", id = "";
		String strQuery="";
		String strAmtfrom="";
		String strAmtto ="";
		String strPrdcode="";
		String strType="";
		String strExp="$";
		String strActionData="";
		boolean recordflag=false;  
		int intValue = 0;
		int intUpdatesize = 0;
		StringBuilder sbolddata=new StringBuilder();
		String strKeyId = "",strinternetproduct="",strprdtype="", strStaffPrd="";
		try 
		{	
			strKeyId = Helper.correctNull((String)hsh.get("hidkeyid"));
			val = correctNull((String)hsh.get("hidval"));
			
			strQuery= SQLParser.getSqlQuery("setproductssel^"+correctNull((String)hsh.get("prdCode")));
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()){
				strinternetproduct = Helper.correctNull((String)rs.getString("prd_internet")).equalsIgnoreCase("Y") ? "YES":"NO";
				strprdtype = Helper.correctNull((String)rs.getString("prd_type"));
				strStaffPrd=Helper.correctNull((String)rs.getString("prd_staffprd"));
				hshValues.put("strInteresttype",Helper.correctNull((String)rs.getString("prd_interesttype")));
			}
			hshValues.put("strStaffPrd",strStaffPrd);
			if(val.equals("update_terms"))
			{
				id = Helper.correctNull((String) hsh.get("ruleid"));
				rs = DBUtils.executeLAPSQuery("ruleresult^" + id);
				
				sbolddata.append("~Product Code="+ correctNull((String)hsh.get("prdCode")));
				sbolddata.append("~Interest type ="+hsh.get("wrk_flowtype1"));
				sbolddata.append("~Amount Range From="+ correctNull((String)hsh.get("amtfrom")));
				sbolddata.append("~Amount Range To ="+ correctNull((String)hsh.get("amtto")));
				
				while (rs.next()) 
				{
					sbolddata.append("~ Repayment Period from = "+Helper.correctNull((String)rs.getString("prd_termfrom")));
					sbolddata.append("~ Repayment Period To = "+Helper.correctNull((String)rs.getString("prd_termto")));
					sbolddata.append("~ Reference Rate = "+Helper.correctNull((String)rs.getString("prd_baserate")));
					sbolddata.append("~ Adjustments = "+Helper.correctNull((String)rs.getString("prd_adjust")));
					sbolddata.append("~ Interest Rate(%) = "+Helper.correctNull((String)rs.getString("prd_interest")));
				}
				if(rs!=null)
					rs.close();
			}
			if (val.equals("show_terms")) {
				id = (String) hsh.get("ruleid");
				rs = DBUtils.executeLAPSQuery("ruleresult^" + id);
				while (rs.next()) {
					recordflag=true;
					vecRec = new ArrayList();
					vecRec.add(rs.getString(1));
					vecRec.add(rs.getString(2));
					vecRec.add(correctNull(rs.getString(3)));
					vecRec.add(correctNull(rs.getString(4)));
					vecRec.add(rs.getString(5));
					vecRec.add(correctNull(rs.getString(6)));
					vecRec.add(correctNull(rs.getString(7)));
					vecRec.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("prd_creditrskpremium")))));
					vecRec.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("prd_busstrategicpremium")))));
					vecVal.add(vecRec);
				}
				hshValues.put("rangefrom", hsh.get("amfrom"));
				hshValues.put("rangeto", hsh.get("amto"));
				hshValues.put("ruleid", hsh.get("ruleid"));
				hshValues.put("wrk_flowtype1", hsh.get("work"));
				hshValues.put("vecVal", vecVal);
				if(recordflag)
					hshValues.put("recordflag","Y");
				else
					hshValues.put("recordflag","N");
			}
			String strinttype = "",strRefType="O";
			strinttype = correctNull((String)hsh.get("sel_inttype1"));
			if(strinttype.equalsIgnoreCase(""))
				strinttype = correctNull((String)hsh.get("hidInteresetType"));
			if (val.equals("insert_terms"))
				{
				strAmtfrom=correctNull((String)hsh.get("amtfrom"));
				strAmtto=correctNull((String)hsh.get("amtto"));
				strPrdcode=correctNull((String)hsh.get("prdCode"));
				strType=correctNull((String)hsh.get("work"));				
				strQuery=SQLParser.getSqlQuery("checkinterestprdrangeins^"+strPrdcode+"^"+strType
							+"^"+strAmtfrom+"^"+strAmtto
							+"^"+strAmtfrom+"^"+strAmtto
							+"^"+strAmtfrom+"^"+strAmtto+"^"+strinttype+"^"+strRefType);
				rs=DBUtils.executeQuery(strQuery);
				
				if(rs.next())
					{
					if(rs.getInt(1)!=0)
						{
						strExp = strExp + " Interest is already defined for the given amount range ";
						throw new Exception(strExp);
						}
					}
				arrValues = new ArrayList();
				if(rs!=null)
					rs.close();
						
				rs = DBUtils.executeLAPSQuery("intmaxterm");
				intUpdatesize = 1;
				if (rs.next()) 
					intValue = (rs.getInt(1));
					
				intValue = intValue + 1;
				id = Integer.toString(intValue);
				hshqueryval.put("size", Integer.toString(intUpdatesize));
				hshquery.put("strQueryId", "inttermins");
				arr.add(strPrdcode);
				arr.add(strType);
				arr.add(id);
				arr.add(strAmtfrom);
				arr.add(strAmtto);
				arr.add(strinttype);
				arr.add("");
				arr.add("");
				arr.add(strRefType);
				hshquery.put("arrValues", arr);
				hshqueryval.put("1", hshquery);
						
				strfrom = (String[]) hsh.get("from");
				strto = (String[]) hsh.get("to");
				total = (String[]) hsh.get("total");
				baserate = (String[]) hsh.get("baserate");
				adjust = (String[]) hsh.get("adjust");
				interest = (String[]) hsh.get("interestid");
				strtablecode = (String[]) hsh.get("tablecode");
				strcreditRiskPremium = (String[]) hsh.get("txtcreditrskpremium");
				strbusstrategicPremium = (String[]) hsh.get("txtbustratpremium");
						
				hshQuery = new HashMap();
				arrValues = new ArrayList();
						
				int num = 0;
				for (int k = 2; k < strfrom.length + 2; k++) 
					{
					if (!strfrom[k - 2].equals("")) 
						{
						num = num + 1;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize = intUpdatesize + 1;
						hshQuery.put("strQueryId", "intins");
						arrValues.add(id);
						arrValues.add(Integer.toString(num));
						arrValues.add(correctNull(strfrom[k - 2]));
						arrValues.add(correctNull(strto[k - 2]));
						arrValues.add(correctNull(baserate[k - 2]));
						arrValues.add(correctNull(adjust[k - 2]));
						arrValues.add(correctNull(total[k - 2]));
						arrValues.add(correctNull(interest[k - 2]));
						arrValues.add(correctNull(strtablecode[k - 2]));
						arrValues.add(correctNull(strcreditRiskPremium[k - 2]));
						arrValues.add(correctNull(strbusstrategicPremium[k - 2]));
						hshQuery.put("arrValues", arrValues);
						hshqueryval.put("size", Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(k), hshQuery);
						}
					}
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
//				for Entering the values into auditrial--> Added by Subha
				
				//delete rating based ROI for that Interest ID //
				hshQuery = new HashMap();
				hshqueryval=new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_retratingROIforprd");
				arrValues.add(id);
				hshQuery.put("arrValues", arrValues);
				hshqueryval.put("size", "1");
				hshqueryval.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshqueryval,"updateData");
				//end//
			  
				/*hshQuery = new HashMap();
				HashMap hshQueryValues2 = new HashMap();
				arrValues = new ArrayList();*/
				strActionData="~Product Code="+ strPrdcode+ "~Interest type ="+hsh.get("wrk_flowtype1")+"~Amount Range From="+ strAmtfrom+ "~Amount Range To ="+strAmtto;
				for (int i = 0; i < strfrom.length; i++) {
					if (!strfrom[i].equals("")) {
						strActionData =strActionData + "~Repayment Period From = "
								+ strfrom[i] + "~Repayment Period To ="
								+ strto[i]+ "~Reference Rate  ="
								+ baserate[i]+ "~Adjustments  ="
								+ adjust[i]+"~Interest Rate (%)="
								+ total[i];
					}
				}
// End			
				if(correctNull((String)hsh.get("hidRecordflag")).equals("Y"))
				hsh.put("hidAction", "update");
				if(correctNull((String)hsh.get("hidRecordflag")).equals("N"))
				hsh.put("hidAction", "insert");
				int intProductCode = Integer.parseInt(Helper.correctInt((String)hsh.get("prd_code")));
				String strPrdCode1= Integer.toString(intProductCode);	
				AuditTrial.auditNewLog(hsh,"23",strPrdCode1,strActionData.toString(),sbolddata.toString());
			}
			if (val.equals("update_terms")) 
				{
				strAmtfrom=correctNull((String)hsh.get("amtfrom"));
				strAmtto=correctNull((String)hsh.get("amtto"));
				strPrdcode=correctNull((String)hsh.get("prd_code"));
				strType=correctNull((String)hsh.get("work"));
				String strPrdsno=correctNull((String)hsh.get("ruleid"));
				
				strQuery=SQLParser.getSqlQuery("checkinterestprdrangeupd^"+strPrdcode+"^"+strType+"^"+strPrdsno
							+"^"+strAmtfrom+"^"+strAmtto
							+"^"+strAmtfrom+"^"+strAmtto
							+"^"+strAmtfrom+"^"+strAmtto+"^"+strinttype+"^"+strRefType);
				rs=DBUtils.executeQuery(strQuery);
				
				if(rs.next())
					{
					if(rs.getInt(1)!=0)
						{
						strExp = strExp + " Interest is already defined for the given amount range  ";
						throw new Exception(strExp);
						}
					}
				
				
				intUpdatesize = 1;
				hshqueryval.put("size", Integer.toString(intUpdatesize));
				hshquery = new HashMap();
				arr = new ArrayList();

				hshquery.put("strQueryId", "limitdel");
				arr.add(hsh.get("ruleid"));
				hshquery.put("arrValues", arr);
				hshqueryval.put("1", hshquery);
						
				intUpdatesize = intUpdatesize+1;
				hshqueryval.put("size", Integer.toString(intUpdatesize));
				hshquery = new HashMap();
				arr = new ArrayList();
				hshquery.put("strQueryId", "limitupd");
				arr.add(strAmtfrom);
				arr.add(strAmtto);
				arr.add("");
				arr.add("");
				arr.add(strRefType);
				arr.add(strPrdsno);
				hshquery.put("arrValues", arr);
				hshqueryval.put("2", hshquery);
				hshquery = new HashMap();
					
				strfrom = (String[]) hsh.get("from");
				strto = (String[]) hsh.get("to");
				strpoint = (String[]) hsh.get("total");
				baserate = (String[]) hsh.get("baserate");
				adjust = (String[]) hsh.get("adjust");
				interest = (String[]) hsh.get("interestid");
				strtablecode = (String[]) hsh.get("tablecode");
				strcreditRiskPremium = (String[]) hsh.get("txtcreditrskpremium");
				strbusstrategicPremium = (String[]) hsh.get("txtbustratpremium");
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				int num = 0;
				for (int k = 3; k < strfrom.length + 3; k++) 
					{
					if (!strfrom[k - 3].equals("")) 
						{
						num = num + 1;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize = intUpdatesize + 1;
						hshqueryval.put("size", Integer.toString(intUpdatesize));
						hshQuery.put("strQueryId", "intins");
						arrValues.add(strPrdsno);
						arrValues.add(Integer.toString(num));
						arrValues.add(correctNull(strfrom[k - 3]));
						arrValues.add(correctNull(strto[k - 3]));
						arrValues.add(correctNull(baserate[k - 3]));
						arrValues.add(correctNull(adjust[k - 3]));
						arrValues.add(correctNull(strpoint[k - 3]));
						arrValues.add(correctNull(interest[k - 3]));
						arrValues.add(correctNull(strtablecode[k - 3]));
						arrValues.add(correctNull(strcreditRiskPremium[k - 3]));
						arrValues.add(correctNull(strbusstrategicPremium[k - 3]));
						hshQuery.put("arrValues", arrValues);
						hshqueryval.put(Integer.toString(intUpdatesize), hshQuery);
						}
					}
				EJBInvoker.executeStateLess("dataaccess", hshqueryval,"updateData");
//				for Entering the values into auditrial--> Added by Subha
			    
				//delete rating based ROI for that Interest ID //
				hshQuery = new HashMap();
				hshqueryval=new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_retratingROIforprd");
				arrValues.add(id);
				hshQuery.put("arrValues", arrValues);
				hshqueryval.put("size", "1");
				hshqueryval.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshqueryval,"updateData");
				//end//
				
				/*hshQuery = new HashMap();
				HashMap hshQueryValues2 = new HashMap();
				arrValues = new ArrayList();*/
				strActionData="Product Code="+ strPrdcode+ "~Interest type ="+hsh.get("wrk_flowtype1")+"~Amount Range From="+ strAmtfrom+ "~Amount Range To ="+strAmtto;
		
				for (int i = 0; i < strfrom.length; i++) {
					if (!strfrom[i].equals("")) {
						strActionData =strActionData + "~Repayment Period From ="
								+ strfrom[i] + "~Repayment Period To ="
								+ strto[i]+ "~Reference Rate  ="
								+ baserate[i]+ "~Adjustments  ="
								+ adjust[i]+"~Interest Rate (%) ="
								+ strpoint[i];
					}
				}
// End			
				if(correctNull((String)hsh.get("hidRecordflag")).equals("Y"))
				hsh.put("hidAction", "update");
				if(correctNull((String)hsh.get("hidRecordflag")).equals("N"))
				hsh.put("hidAction", "insert");
				int intProductCode = Integer.parseInt(strPrdcode);
				String strPrdCode1= Integer.toString(intProductCode);	
				AuditTrial.auditNewLog(hsh,"23",strPrdCode1,strActionData.toString(),sbolddata.toString());	
				hshValues.put("rangefrom", strAmtfrom);
				hshValues.put("rangeto", strAmtto);
				hshValues.put("ruleid", strPrdsno);
				hshValues.put("wrk_flowtype1", hsh.get("wrk_flowtype1"));
				id = (String) hsh.get("ruleid");
				rs = DBUtils.executeLAPSQuery("ruleresult^" + id);
				while (rs.next()) 
					{
					vecRec = new ArrayList();
					vecRec.add(correctNull(rs.getString(1)));
					vecRec.add(correctNull(rs.getString(2)));
					vecRec.add(correctNull(rs.getString(3)));
					vecRec.add(correctNull(rs.getString(4)));
					vecRec.add(correctNull(rs.getString(5)));
					vecRec.add(correctNull(rs.getString(6)));
					vecRec.add(correctNull(rs.getString(7)));
					vecRec.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("prd_creditrskpremium")))));
					vecRec.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("prd_busstrategicpremium")))));
					vecVal.add(vecRec);
					}
				hshValues.put("vecVal", vecVal);
				
				hsh.put("strprdtype", strprdtype);
				
				/*if(Helper.correctNull(ApplicationParams.getstrOnlineEnabled()).equalsIgnoreCase("YES")){
				if(strinternetproduct.equalsIgnoreCase("YES")){
					updateOnline(hsh);
				}}*/
				
				
			
				if(val.equals("update_terms") || val.equals("insert_terms"))
				updateProductSaveStatus(hsh);
		}	
			
			int ratingcnt=0;
			rs=DBUtils.executeLAPSQuery("sel_countofratingCode");
			if(rs.next())
			{
				ratingcnt=Integer.parseInt(Helper.correctInt((String)rs.getString(1)));
			}
			hshValues.put("prdNoOfRatingDescription", String.valueOf(ratingcnt));
			hshValues.put("sel_inttype",strinttype);
			
			if(rs!=null)
				rs.close();
			
			rs = DBUtils.executeLAPSQuery("chk_prdfac_spreaddetails^"+correctNull((String)hsh.get("prdCode"))+"^P");
			if (rs.next()) 
			{
				hshValues.put("strSpreadFlag","Y");
			}
			 
			
		} catch (Exception e) {
			throw new EJBException(e.toString());
		} finally {
			try {

				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}
		}
		return hshValues;

	}

	public HashMap getDataHelp(HashMap hsh)  {
		ResultSet rs = null;
		HashMap hshValues = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		String str = "", val = "", totalval = "", code = "";
		try {
			val = correctNull((String) hsh.get("val"));
			str = (String) hsh.get("val");
			code = (String) hsh.get("code");
			if (val.equals("fixed") || val.equals("floating")) {
				rs = DBUtils.executeLAPSQuery("rulechoice^" + str + "^" + code+"^O");
				while (rs.next()) {
					arr.add(correctNull(rs.getString("prdint_sno")));
					totalval = correctNull(rs.getString("prd_amtrangefrom"))
							+ "---"
							+ correctNull(rs.getString("prd_amtrangeto"));
					arr1.add(totalval);
				}
				hshValues.put("arrVal", arr);
				hshValues.put("arrValdesc", arr1);
			}

			else if (val.equals("fixedselect")) {
				rs = DBUtils.executeLAPSQuery("fixedselect");
				while (rs.next()) {

					arr.add(correctNull(rs.getString("int_intvalue")) + "^"
							+ correctNull(rs.getString("int_intid")));
					totalval = correctNull(rs.getString("int_intdesc"));
					arr1.add(totalval);
				}
				hshValues.put("arrVal", arr);
				hshValues.put("arrValdesc", arr1);
			}

		}

		catch (Exception e) {
			log.error("error occured" + e.toString());
		}

		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				log.error("error occured" + e1.toString());
			}
		}
		return hshValues;
	}

	public void updateDocData(HashMap hshRequestValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strPrdCode = null;
		int intSize = 1;
		String[] strDocCode = null;
		String[] strDocDesc = null;
		String[] strDocDate = null;
		String[] strDocMand = null;
		String strActionData = "";
		try {
			strDocCode = (String[]) hshRequestValues.get("adoc_code");
			strDocDesc = (String[]) hshRequestValues.get("adoc_desc");
			strDocDate = (String[]) hshRequestValues.get("adoc_date");
			strDocMand= (String[]) hshRequestValues.get("adoc_mand1");
			strPrdCode = (String) hshRequestValues.get("prdCode");
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "prddocdel");
			arrValues.add(strPrdCode);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			intSize++;

			for (int i = 0; i < strDocDesc.length; i++) {
				if (!strDocDesc[i].equals("")) {
					hshQueryValues.put("size", String.valueOf(intSize));
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "prddocins");
					arrValues = new ArrayList();
					arrValues.add(strPrdCode);
					arrValues.add(strDocCode[i]);
					arrValues.add(strDocDate[i]);
					arrValues.add(strDocMand[i]);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(intSize), hshQuery);
					intSize++;
				}
			}
			strDocCode = null;
			strDocDesc = null;
			strDocDate = null;
			strDocMand = null;
			strDocCode = (String[]) hshRequestValues.get("idoc_code");
			strDocDesc = (String[]) hshRequestValues.get("idoc_desc");
			strDocDate = (String[]) hshRequestValues.get("idoc_date");
			strDocMand = (String[]) hshRequestValues.get("idoc_mand1");
			for (int i = 0; i < strDocDesc.length; i++) {
				if (!strDocDesc[i].equals("")) {
					hshQueryValues.put("size", String.valueOf(intSize));
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "prddocins");
					arrValues = new ArrayList();
					arrValues.add(strPrdCode);
					arrValues.add(strDocCode[i]);
					arrValues.add(strDocDate[i]);
					arrValues.add(strDocMand[i]);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(intSize), hshQuery);
					intSize++;
				}
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
				updateProductSaveStatus(hshRequestValues);
			}

			// Audit trail Report

			/*strDocCode = (String[]) hshRequestValues.get("adoc_code");
			strDocDesc = (String[]) hshRequestValues.get("adoc_desc");
			strDocDate = (String[]) hshRequestValues.get("adoc_date");
			//strDocMand=  (String[]) hshRequestValues.get("adoc_mand");
			strPrdCode = (String) hshRequestValues.get("prd_code");
			hshQuery = new HashMap();
			HashMap hshQueryValues2 = new HashMap();
			arrValues = new ArrayList();
			for (int i = 0; i < strDocDesc.length; i++) {
				if (!strDocDesc[i].equals("")) {
					strActionData = strActionData + "~adoc_desc = "
							+ strDocDesc[i];
				}
			}
			hshQueryValues2.put("size", "2");

			hshQuery.put("strQueryId", "audittrial");
			arrValues.add("16");
			arrValues.add(correctNull((String) hshRequestValues
					.get("strUserId")));
			arrValues.add(correctNull((String) hshRequestValues
					.get("strClientIP")));
			arrValues
					.add(correctNull((String) hshRequestValues.get("prd_code")));
			arrValues.add(strActionData);
			arrValues.add("update");
			hshQuery.put("arrValues", arrValues);
			hshQueryValues2.put("1", hshQuery);
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			strDocCode = (String[]) hshRequestValues.get("idoc_code");
			strDocDesc = (String[]) hshRequestValues.get("idoc_desc");
			strDocDate = (String[]) hshRequestValues.get("idoc_date");
			//strDocMand=  (String[]) hshRequestValues.get("idoc_mand");
			for (int i = 0; i < strDocDesc.length; i++) {
				if (!strDocDesc[i].equals("")) {
					strActionData = strActionData + "~idoc_desc = "
							+ strDocDesc[i];
				}
			}
			hshQuery.put("strQueryId", "audittrial");
			arrValues.add("16");
			arrValues.add(correctNull((String) hshRequestValues
					.get("strUserId")));
			arrValues.add(correctNull((String) hshRequestValues
					.get("strClientIP")));
			arrValues
					.add(correctNull((String) hshRequestValues.get("prd_code")));
			arrValues.add(strActionData);
			arrValues.add("update");
			hshQuery.put("arrValues", arrValues);
			hshQueryValues2.put("2", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues2,
					"updateData");
			*/
			String checkMand="";
			strDocMand = new String[40];
			strDocCode = (String[]) hshRequestValues.get("adoc_code");
			strDocDesc = (String[]) hshRequestValues.get("adoc_desc");
			strDocDate = (String[]) hshRequestValues.get("adoc_date");
			strDocMand=  (String[]) hshRequestValues.get("adoc_mand1");
			int j=0;
			StringBuilder sbAuditTrial=new StringBuilder();
			sbAuditTrial.append("Product Code =").append(correctNull((String )hshRequestValues.get("prd_code"))).append("~Document Category - Applicant");
			
			for (int i = 0; i < strDocDesc.length; i++)
			{
				if(correctNull(strDocMand[i]).equals("Y"))
				{
					checkMand ="Yes";
				}
				else
				{
					checkMand ="No";
				}
				
				if (!strDocDesc[i].equals("")) 
				{
					
					if(j!=0)
					{
						sbAuditTrial.append(",");
					}
					sbAuditTrial.append("~Document Name=").append(strDocDesc[i]).append("~Is Mandatory=").append(checkMand);
					j++;
				}
			}
			sbAuditTrial.append("~Document Category -  Bank ");
			
			strDocCode = (String[]) hshRequestValues.get("idoc_code");
			strDocDesc = (String[]) hshRequestValues.get("idoc_desc");
			strDocDate = (String[]) hshRequestValues.get("idoc_date");
			strDocMand=  (String[]) hshRequestValues.get("idoc_mand1");
			j=0;
			for (int i = 0; i < strDocDesc.length; i++) 
			{
				if(correctNull(strDocMand[i]).equals("Y"))
				{
					checkMand ="Yes";
				}
				else
				{
					checkMand ="No";
				}
				if (!strDocDesc[i].equals(""))
				{
					if(j!=0)
					{
						sbAuditTrial.append(",");
					}
					sbAuditTrial.append("~Document Name=").append(strDocDesc[i]).append("~Is Mandatory=").append(checkMand);
				}
			}
			AuditTrial.auditLog(hshRequestValues,"16","",sbAuditTrial.toString());
			updateProductSaveStatus(hshRequestValues);
		} catch (Exception e) {
			log.error("Exception in updateDocData.. " + e);
			throw new EJBException(e.getMessage());
		}
	}

	public HashMap getWorkflowList(HashMap hshRequestValues)
			 {
		ResultSet rs = null;
		String strWorkflowType = null;
		HashMap hshRecord = new HashMap();
		try {
			strWorkflowType = (String) hshRequestValues.get("wrk_flowtype");
			rs = DBUtils.executeLAPSQuery("workflowlist^" + strWorkflowType);
			while (rs.next()) {
				hshRecord.put(rs.getString("wrk_flowid"), rs
						.getString("wrk_flowname"));
			}
		} catch (Exception e) {
			log.error("Exception in getWorkList.. " + e);
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				log.error("Error closing connection.. " + e1);
			}
		}
		return hshRecord;
	}

	public HashMap getWorkflowData(HashMap hshRequestValues)
			 {
		String strQuery = null;
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arrWorkid = new ArrayList();
		ArrayList arrMaxclass = new ArrayList();
		//ArrayList arrFunction = new ArrayList();
		ArrayList arrDuration = new ArrayList();
		ArrayList arrWorkflowname = new ArrayList();
		String strPrdCode = null;
		String strWorkflowType = null;
		boolean recordflag=false;
		try {
			strPrdCode = correctNull((String)hshRequestValues.get("prdCode"));
			strWorkflowType = correctNull((String)hshRequestValues.get("wrk_flowtype"));
			if (strWorkflowType == null || strWorkflowType.trim().equals(""))
				strWorkflowType = "p";
			if(!strPrdCode.equals(""))
			{
				strQuery = SQLParser.getSqlQuery("prdworkflowsel^" + strPrdCode
						+ "^" + strWorkflowType);
				rs = DBUtils.executeQuery(strQuery);
	
				while (rs.next()) {
					recordflag=true;
					arrWorkid.add(rs.getString("prd_workid"));
					arrMaxclass.add(rs.getString("prd_maxclass"));
					//arrFunction.add(rs.getString("prd_function"));
					arrDuration.add(rs.getString("prd_duration"));
					arrWorkflowname.add(rs.getString("wrk_flowname"));
				}
			}
			hshRecord.put("prd_workid", arrWorkid);
			hshRecord.put("prd_maxclass", arrMaxclass);
			//hshRecord.put("prd_function", arrFunction);
			hshRecord.put("prd_duration", arrDuration);
			hshRecord.put("wrk_flowname", arrWorkflowname);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
			
		} catch (Exception e) {
			log.error("error in getWorkflowData.. " + e);
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				log.error("Error closing connection.." + e1);
			}
		}
		return hshRecord;
	}

	public void updateWorkflowData(HashMap hshRequestValues)
			 {
		String[] strPrd_workid = null;
		String[] strPrd_maxclass = null;
		String[] strPrd_duration = null;
		String[] strWrk_flowname = null;
		String strPrdCode = null;
		String strWrk_flowtype = null;
		String strQuery=null;
		ResultSet rs=null;
		String strPageName=null;
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		int intSize = 1;
		int intFlowpoint = 0;
		String strLoanType="";
		String strKeyId = "";
		try {
			strKeyId = Helper.correctNull((String)hshRequestValues.get("hidkeyid"));
			strLoanType=correctNull((String)hshRequestValues.get("prdtype"));
			strPrd_workid = (String[]) hshRequestValues.get("prd_workid");
			strPrd_maxclass = (String[]) hshRequestValues.get("prd_maxclass");
			strPrd_duration = (String[]) hshRequestValues.get("prd_duration");
			strPrdCode = correctNull((String) hshRequestValues.get("prdCode"));
			strWrk_flowtype = correctNull((String) hshRequestValues.get("wrk_flowtype"));
			if (strWrk_flowtype.equalsIgnoreCase("p")) {
				intFlowpoint = 1;
				strPageName="In Process";
			} else if (strWrk_flowtype.equalsIgnoreCase("a")) {
				intFlowpoint = 9;
				strPageName="Post Approval";
			} else {
				intFlowpoint = 17;
				strPageName="Post Rejection";
			}
			
			strWrk_flowname = (String[]) hshRequestValues.get("wrk_flowname");
			//For getting old record details
			StringBuilder sbolddata=new StringBuilder();
			if(correctNull((String)hshRequestValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
			{
				strQuery = SQLParser.getSqlQuery("prdworkflowsel^" + strPrdCode
						+ "^" + strWrk_flowtype);
				int count=0;
				rs = DBUtils.executeQuery(strQuery);
				
				sbolddata.append("~Product Code=") .append(strPrdCode);
				sbolddata.append("~Page Name="+strPageName);
				while (rs.next()) 
				{
					sbolddata.append("~Action=").append(correctNull(rs.getString("wrk_flowname")));
					sbolddata.append("~Minimum Class=").append( correctNull(rs.getString("stat_data_desc1")));
					sbolddata.append("~Duration=").append(correctNull(rs.getString("prd_duration")));
				}
			
			}
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "prdworkflowdel");
			arrValues.add(strPrdCode);
			arrValues.add(strWrk_flowtype);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			intSize++;
			for (int i = 0; i < strPrd_workid.length; i++) {
				if (!strWrk_flowname[i].equals("")) {
					hshQueryValues.put("size", String.valueOf(intSize));
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "prdworkflowins");
					arrValues = new ArrayList();
					arrValues.add(strPrdCode);
					arrValues.add(String.valueOf(intFlowpoint));
					arrValues.add(strPrd_workid[i]);
					arrValues.add(strPrd_maxclass[i]);
					arrValues.add(strPrd_duration[i]);
					arrValues.add("");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(intSize), hshQuery);
					intSize++;
					intFlowpoint++;
				}
			}
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			updateProductSaveStatus(hshRequestValues);
			
			//FOR AUDIT TRIAL
					
			StringBuilder sbAuditTrial=new StringBuilder();
			String maxclass[]=(String[])hshRequestValues.get("hid_prd_maxclass");

			sbAuditTrial.append("~Product Code=") .append(strPrdCode);
			sbAuditTrial.append("~Page Name="+strPageName);
			if(strWrk_flowtype.equals("p"))
			{
				for(int i=0;i<8;i++)
				{
					if(strWrk_flowname[i].equals(""))continue;
					sbAuditTrial.append("~Action=") .append(correctNull(strWrk_flowname[i]));
					sbAuditTrial.append("~Minimum Class=").append( correctNull(maxclass[i]));
					sbAuditTrial.append("~Duration=").append(correctNull(strPrd_duration[i]));
				}
			}
			else if(strWrk_flowtype.equals("a"))
			{
				for(int i=0;i<8;i++)
				{
					if(strWrk_flowname[i].equals(""))continue;
					sbAuditTrial.append("~Action=") .append(correctNull(strWrk_flowname[i]));
					sbAuditTrial.append("~Minimum Class=").append( correctNull(maxclass[i]));
					sbAuditTrial.append("~Duration=").append(correctNull(strPrd_duration[i]));
				}
			}
			else if(strWrk_flowtype.equals("r"))
			{
				for(int i=0;i<8;i++)
				{
					if(strWrk_flowname[i].equals(""))continue;
					sbAuditTrial.append("~Action=") .append(correctNull(strWrk_flowname[i]));
					sbAuditTrial.append("~Minimum Class=").append( correctNull(maxclass[i]));
					sbAuditTrial.append("~Duration=").append(correctNull(strPrd_duration[i]));
				}
			}
			String strCode="";
			
			if(strLoanType.equalsIgnoreCase("C"))
			{
				if(strWrk_flowtype.equals("p"))strCode="106";
				else if (strWrk_flowtype.equals("a"))strCode="126";
				else if (strWrk_flowtype.equals("r"))strCode="127";
			}
			else if(strLoanType.equalsIgnoreCase("T"))
			{
				if(strWrk_flowtype.equals("p"))strCode="114";
				else if (strWrk_flowtype.equals("a"))strCode="129";
				else if (strWrk_flowtype.equals("r"))strCode="130";
			}
			else
			{
				if(strWrk_flowtype.equals("p"))strCode="17";
				else if (strWrk_flowtype.equals("a"))strCode="18";
				else if (strWrk_flowtype.equals("r"))strCode="19";	
			}
			if(correctNull((String)hshRequestValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
			{
				hshRequestValues.put("hidAction","update");
			}else{
				hshRequestValues.put("hidAction","insert");
			}
			String strPrdCode1="";
			int intprdcode= Integer.parseInt(strPrdCode);
			//strPrdCode1=strPrdCode+"^"+strWrk_flowtype;
			strPrdCode1=strPrdCode;
			
			//AuditTrial.auditLog(hshRequestValues, strCode, strPrdCode1,sbAuditTrial.toString());
			AuditTrial.auditNewLog(hshRequestValues,strCode,strPrdCode,sbAuditTrial.toString(),sbolddata.toString());
		} catch (Exception e) {
			log.error("Exception in updateWorkflowdata.. " + e);
			throw new EJBException(e.getMessage());
		}
	}

	private String checkApplication(HashMap hshRequestValues) {
		ResultSet rs = null;
		String strProductCode = null;
		String strApp = "";
		try {
			strProductCode = correctNull((String)hshRequestValues.get("prdCode"));
			rs = DBUtils.executeLAPSQuery("checkapplication^" + strProductCode);
			if (rs.next()) {
				
				if (rs.getString(1).toString().equals("0")) {
					strApp = "No";
				} else {
					strApp = "Yes";
				}
			}

		} catch (Exception e) {
			log.error("exception in getData... " + e);
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();

				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}

		}
		return strApp;
	}
	
	public HashMap getnewSancLimit(HashMap hshRequestValues) 
	{
		HashMap hshValues = new HashMap();
		ResultSet rs = null;
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = new ArrayList();
		String strProductCode = null;
		try 
		{
			strProductCode = correctNull((String)hshRequestValues.get("prdCode"));
			if(strProductCode.equalsIgnoreCase(""))
			{
				strProductCode = correctNull((String)hshRequestValues.get("hidPrdCode"));
			}
			String strQuery = SQLParser.getSqlQuery("sel_staffexisprdlimit^"+strProductCode);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("present", Helper.correctNull((String)rs.getString("PRD_RNG_TO")));
				hshValues.put("user", Helper.correctNull((String)rs.getString("mod_user")));
				hshValues.put("mod_date", Helper.correctNull((String)rs.getString("PRD_MODIFIED_ON")));
			}
			
			if(rs!=null)rs.close();
			strQuery = SQLParser.getSqlQuery("sel_stafflimit_History^"+strProductCode);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("username")));
				arrCol.add(Helper.correctNull((String)rs.getString("PRD_CHANGEDON")));
				arrCol.add(Helper.correctNull((String)rs.getString("PRD_OLDVALUE")));
				arrCol.add(Helper.correctNull((String)rs.getString("PRD_NEWVALUE")));
				arrRow.add(arrCol);
			}
			
			hshValues.put("arrRow", arrRow);
			hshValues.put("prdCode", strProductCode);
			hshValues.put("strpageFrm", correctNull((String)hshRequestValues.get("varPageFrm")));
		} 
		catch (Exception e) 
		{
			log.error("exception in getData... " + e);
			throw new EJBException(e.getMessage());
		} 
		return hshValues;
	}
	
	public void updatenewSancLimit(HashMap hshRequestValues) 
	{
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strProductCode = null,strOldVal="",strNewVal="";
		try 
		{
			strProductCode = correctNull((String)hshRequestValues.get("prdCode"));
			if(strProductCode.equalsIgnoreCase(""))
			{
				strProductCode = correctNull((String)hshRequestValues.get("hidPrdCode"));
			}
			strOldVal = Helper.correctNull((String)hshRequestValues.get("txt_facold_limit"));
			strNewVal = Helper.correctNull((String)hshRequestValues.get("txt_facnew_limit"));
			int count=1;
			//Products table
			hshQuery.put("strQueryId", "upd_products_newlimit");
			arrValues.add(strNewVal);
			arrValues.add(strOldVal);
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("strUserId")));
			arrValues.add(strProductCode);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(""+count++, hshQuery);
			
			//insert into staff loan Backup table
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "ins_prdstaffloan_limit");
			arrValues.add(strProductCode);
			arrValues.add(Helper.correctNull((String)hshRequestValues.get("strUserId")));
			arrValues.add(strOldVal);
			arrValues.add(strNewVal);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(""+count++, hshQuery);
			
			//Processing Charges table
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "upd_charges_newlimit");
			arrValues.add(strNewVal);
			arrValues.add(strOldVal);
			arrValues.add(strProductCode);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(""+count++, hshQuery);
			
			//Processing delegation table
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "upd_delegation_newlimit");
			arrValues.add(strNewVal);
			arrValues.add(strOldVal);
			arrValues.add(strProductCode);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(""+count++, hshQuery);
			
			//Processing Interst table
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "upd_interest_newlimit");
			arrValues.add(strNewVal);
			arrValues.add(strOldVal);
			arrValues.add(strProductCode);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(""+count++, hshQuery);
			
			//Processing  repay capacity table
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "upd_repaycapcity_newlimit");
			arrValues.add(strNewVal);
			arrValues.add(strOldVal);
			arrValues.add(strProductCode);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(""+count++, hshQuery);
			
			//Processing collateral table
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "upd_collateral_newlimit");
			arrValues.add(strNewVal);
			arrValues.add(strOldVal);
			arrValues.add(strProductCode);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(""+count++, hshQuery);
			
			//Processing margin table
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "upd_margin_newlimit");
			arrValues.add(strNewVal);
			arrValues.add(strOldVal);
			arrValues.add(strProductCode);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(""+count, hshQuery);
			
			hshQueryValues.put("size", ""+count);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updatedata");
		} 
		catch (Exception e) 
		{
			log.error("exception in getData... " + e);
			throw new EJBException(e.getMessage());
		} 
	}

	public void renewProduct(HashMap hshValues)  {

		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		try {
			String strPrd_Type = Helper.correctNull((String)hshValues.get("prd_type"));
			if(strPrd_Type.equalsIgnoreCase(""))
			{
				strPrd_Type = Helper.correctNull((String)hshValues.get("hidProductType"));
			}
			String strOldPrdId = (String) hshValues.get("hidOldPrdId");
			String strProductCode = getProductCode();
			int querySize = 0;
			
			// insert data in products table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenproductsins");
			hshQueryValues.put(""+querySize, hshQuery);
			
			// update renew column in products table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenproductsupd");
			hshQueryValues.put(""+querySize, hshQuery);
			
			// insert data in to prod_business table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenprodbuss");
			hshQueryValues.put(""+querySize, hshQuery);
			
			// insert data in to prd_used table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenprodused");
			hshQueryValues.put(""+querySize, hshQuery);
			
			// insert data in to prd_authority table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenprodauth");
			hshQueryValues.put(""+querySize, hshQuery);
			
			// insert data in to prd_documents table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenproddoc");
			hshQueryValues.put(""+querySize, hshQuery);
			
			// insert data in to prd_workflow table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenprodwork");
			hshQueryValues.put(""+querySize, hshQuery);
			
			// insert data in to prd_interest table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenprodint");
			hshQueryValues.put(""+querySize, hshQuery);
			
			// insert data in to prd_sanction_limit table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenprodsanc");
			hshQueryValues.put(""+querySize, hshQuery);
			
			// insert data in to prd_documentcharge table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenproddoccharge");
			hshQueryValues.put(""+querySize, hshQuery);
			
			// insert data in to prd_processcharge table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenprodprocharge");
			hshQueryValues.put(""+querySize, hshQuery);
			
			//insert data in to prd_margintable table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenmarginamt");
			hshQueryValues.put(""+querySize, hshQuery);
			
			// insert data in to SubStepRules table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenprodstepup");
			hshQueryValues.put(""+querySize, hshQuery);
			
			// insert data in to General info table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrengeneinfo");
			hshQueryValues.put(""+querySize, hshQuery);
			
			//insert data in to prd_repaycapcity table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenrepaycapacity");
			hshQueryValues.put(""+querySize, hshQuery);
			//insert into terms and conditions table 
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrentermscodition");
			hshQueryValues.put(""+querySize, hshQuery);
			// end
			//insert data in to prd_specificconditions table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenspecificeligibility");
			hshQueryValues.put(""+querySize, hshQuery);
			
			//insert data in to Set_Prod_CollateralSecurity table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdinsertColSecData");
			hshQueryValues.put(""+querySize, hshQuery);

			if(strPrd_Type.equalsIgnoreCase("pG")||strPrd_Type.equalsIgnoreCase("aH"))
			{
				//insert data in to prd_rentinsurecharge table
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(strProductCode);
				arrValues.add(strOldPrdId);
				querySize++;
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "prdrenrentinsurecharge");
				hshQueryValues.put(""+querySize, hshQuery);
				
				//insert data in to prd_jewelappraisalcharge table
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(strProductCode);
				arrValues.add(strOldPrdId);
				querySize++;
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "prdrenjewelappraisalcharge");
				hshQueryValues.put(""+querySize, hshQuery);
			}
			//insert data into prd_activitycodes table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenactivitycodes");
			hshQueryValues.put(""+querySize, hshQuery);
			
			// insert data in to prdint_master table
			int mastersize = checkIntMasterSize(strOldPrdId);
		
			ArrayList vecMaster = (ArrayList) getMasterData(strOldPrdId);
		
			int intMaxIntcode = maxIntCode();
			for (int i = 0; i < mastersize; i++) {
				querySize++;
				ArrayList vecCol = (ArrayList) vecMaster.get(i);
		
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(strProductCode);
				arrValues.add(vecCol.get(1));
				arrValues.add(Integer.toString(intMaxIntcode));
				arrValues.add(vecCol.get(2));
				arrValues.add(vecCol.get(3));
				arrValues.add(vecCol.get(4));
				arrValues.add(vecCol.get(5));

				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "prdrenprodintmaster");
				hshQueryValues.put(Integer.toString(querySize), hshQuery);
				ArrayList vecLimt = (ArrayList) getLimitData((String) vecCol.get(0));
				for (int j = 0; j < vecLimt.size(); j++) {
					querySize++;
					ArrayList vecLimitCol = (ArrayList) vecLimt.get(j);
				
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					arrValues.add(Integer.toString(intMaxIntcode));
					arrValues.add(vecLimitCol.get(0));
					arrValues.add(vecLimitCol.get(1));
					arrValues.add(vecLimitCol.get(2));
					arrValues.add(vecLimitCol.get(3));
					arrValues.add(vecLimitCol.get(4));
					arrValues.add(vecLimitCol.get(5));
					arrValues.add(vecLimitCol.get(6));
					arrValues.add(vecLimitCol.get(7));
					arrValues.add(vecLimitCol.get(8));
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "prdrenprodintlimit");
					hshQueryValues.put(Integer.toString(querySize), hshQuery);
				}
				intMaxIntcode++;
			}
			hshQueryValues.put("size", Integer.toString(querySize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
					"updateData");

		} catch (Exception ce) {
			log.error("exception in Renew Product.. " + ce);
			throw new EJBException("Error in updateData " + ce.toString());
		}
	}

	private int checkIntMasterSize(String prdcode) {
		int intnos = 0;
		ResultSet rs = null;
		try {
			rs = DBUtils.executeLAPSQuery("prdrenprodintcount^" + prdcode);
			if (rs.next()) {
				intnos = rs.getInt(1);
			}
		} catch (Exception ce) {
			log.error("exception in getProductCode.. " + ce);
			throw new EJBException("Error in updateData " + ce.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}

		}
		return intnos;
	}

	private int checkIntLimitSize(String prdintid) {
		int intnos = 0;
		ResultSet rs = null;
		try {
			rs = DBUtils
					.executeLAPSQuery("prdrenprodintlimitcount^" + prdintid);
			if (rs.next()) {
				intnos = rs.getInt(1);
			}
		} catch (Exception ce) {
			log.error("exception in getProductCode.. " + ce);
			throw new EJBException("Error in updateData " + ce.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();

				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}

		}
		return intnos;
	}

	private int maxIntCode() {
		int intnos = 0;
		ResultSet rs = null;

		try {
			rs = DBUtils.executeLAPSQuery("prdrenprodmaxint");
			if (rs.next()) {
				intnos = rs.getInt(1);
			}
		} catch (Exception ce) {
			log.error("exception in getProductCode.. " + ce);
			throw new EJBException("Error in updateData " + ce.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();

				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}

		}
		return intnos;
	}

	private ArrayList findIntCode(String strOldPrdId) {
		ArrayList vIntCode = new ArrayList();
		ResultSet rs = null;

		try {
			rs = DBUtils.executeLAPSQuery("prdrenprodintselect^" + strOldPrdId);
			if (rs.next()) {
				vIntCode.add(rs.getString(1));
			}
		} catch (Exception ce) {
			log.error("exception in getProductCode.. " + ce);
			throw new EJBException("Error in updateData " + ce.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();

				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}

		}
		return vIntCode;
	}

	private ArrayList getMasterData(String strOldPrdId) {

		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		try {
			rs = DBUtils.executeLAPSQuery("prdrenprodintmasterselect^"
					+ strOldPrdId);
			ArrayList vecCol;
			while (rs.next()) {
				vecCol = new ArrayList();
				vecCol.add(rs.getString(1));
				vecCol.add(rs.getString(2));
				vecCol.add(rs.getString(3));
				vecCol.add(rs.getString(4));
				vecCol.add(rs.getString(5));
				vecCol.add(rs.getString(6));
				
				vecRow.add(vecCol);
			}


		} catch (Exception ce) {
			log.error("exception in getProductCode.. " + ce);
			throw new EJBException("Error in updateData " + ce.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}

		}
		return vecRow;

	}

	private ArrayList getLimitData(String strPrdId) {

		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		try {
			rs = DBUtils.executeLAPSQuery("prdrenprodintlimitselect^"
					+ strPrdId);
			ArrayList vecCol;
			while (rs.next()) {
				vecCol = new ArrayList();
				vecCol.add(rs.getString(1));
				vecCol.add(rs.getString(2));
				vecCol.add(rs.getString(3));
				vecCol.add(rs.getString(4));
				vecCol.add(rs.getString(5));
				vecCol.add(rs.getString(6));
				vecCol.add(rs.getString(7));
				vecCol.add(rs.getString("prd_creditrskpremium"));
				vecCol.add(rs.getString("prd_busstrategicpremium"));
				vecRow.add(vecCol);
			}

			
		} catch (Exception ce) {
			log.error("exception in getProductCode.. " + ce);
			throw new EJBException("Error in updateData " + ce.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();

				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}

		}
		return vecRow;

	}

	private ArrayList getDeleteMasterdata(String strPrdId) {
		ResultSet rs = null;
		ArrayList vecRow = new ArrayList();
		try {
			rs = DBUtils.executeLAPSQuery("setproductsintseldel^" + strPrdId);
			while (rs.next()) {
				vecRow.add(rs.getString(1));
			}

		} catch (Exception ce) {
			log.error("exception in getProductCode.. " + ce);
			throw new EJBException("Error in updateData " + ce.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();

				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}

		}
		return vecRow;
	}

	public void deleteTerms(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = null;
		String strActionData="";
		String strOldData="";
		
		String[] strfrom = null;
		String[] strto = null;
		String[] total = null;
		String[] baserate = null;
		String[] adjust = null;
		String[] interest = null;
		String[] strpoint = null;
		String strPrdcode="";
		try {
			
			strPrdcode=correctNull((String)hshValues.get("prd_code"));
			strfrom = (String[]) hshValues.get("from");
			strto = (String[]) hshValues.get("to");
			total = (String[]) hshValues.get("total");
			baserate = (String[]) hshValues.get("baserate");
			adjust = (String[]) hshValues.get("adjust");
			interest = (String[]) hshValues.get("interestid");
			
			hshQueryValues.put("size", "3");

			hshQuery = new HashMap();
			hshQuery.put("strQueryId", "delprdintlimit");
			arrValues = new ArrayList();
			arrValues.add(hshValues.get("select_rule"));
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);

			hshQuery = new HashMap();
			hshQuery.put("strQueryId", "delprdintmaster");
			arrValues = new ArrayList();
			arrValues.add(hshValues.get("select_rule"));
			arrValues.add(hshValues.get("prd_code"));
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("2", hshQuery);
			
			hshQuery = new HashMap();
			hshQuery.put("strQueryId", "del_retratingROIforprd");
			arrValues = new ArrayList();
			arrValues.add(hshValues.get("select_rule"));
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("3", hshQuery);

			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
					"updateData");

		  	//---------------------Audittrial----------------------------------
			hshQuery = new HashMap();
			HashMap hshQueryValues2 = new HashMap();
			arrValues = new ArrayList();
			strActionData="~Product Code="+ strPrdcode+ "~Interest type ="+hshValues.get("wrk_flowtype1")+"~Amount Range From="+ correctNull((String)hshValues.get("amtfrom"))+ "~Amount Range To ="+correctNull((String)hshValues.get("amtto"));
			for (int i = 0; i < strfrom.length; i++) {
				if (!strfrom[i].equals("")) {
					strActionData =strActionData + "~Repayment Period From = "
							+ strfrom[i] + "~Repayment Period To ="
							+ strto[i]+ "~Reference Rate  ="
							+ baserate[i]+ "~Adjustments  ="
							+ adjust[i]+"~Interest Rate (%)="
							+ total[i];
				}
			}
		
			int intProductCode = Integer.parseInt(Helper.correctInt((String)hshValues.get("prd_code")));
			String strPrdCode1= Integer.toString(intProductCode);	
			
			
			String atrworktype=correctNull((String)hshValues.get("wrk_flowtype1"));
			hshQueryValues2.put("size", "1");

			hshQuery.put("strQueryId", "audittrial");
			if(atrworktype.equalsIgnoreCase("fixed"))
			 {
			      arrValues.add("23");
			 }
			else
			 {
				 arrValues.add("24");
			 }
			
			arrValues.add(correctNull((String) hshValues
					.get("strUserId")));
			arrValues.add(correctNull((String) hshValues
					.get("strClientIP")));
			arrValues.add(strPrdCode1);
			arrValues.add(strActionData);
			arrValues.add("delete");
			hshQuery.put("arrValues", arrValues);
			hshQueryValues2.put("1", hshQuery);
			
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues2,"updateData");
          //End		
			
		} catch (Exception ce) {
			log.error("in bean... " + ce);
			throw new EJBException("Error in updateData " + ce.toString());
		}

	}
	public void updateStaffLoan(HashMap hshValues) 
	{
		
		HashMap hshQueryVal=new HashMap();
		HashMap hshQuery=new HashMap();
		
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null;
		String strQuery;
		String strsno="";
		String strAction=(String)hshValues.get("hidAction");
		String strPrdCode=correctNull((String)hshValues.get("prd_code"));
		String strMinService=correctNull((String)hshValues.get("txt_minservice"));
		String strMaxService=correctNull((String)hshValues.get("txt_maxservice"));
		String strExp="$ Check the Service Range";
		int intUpdatesize=0;
		String strKeyId="";
		int intkeyid=0;
		try
		{
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intkeyid = Integer.parseInt(Helper.correctInt((String)hshValues.get("prd_code")));
			
			if(strAction.equalsIgnoreCase("Insert"))
			{
				
				strQuery=SQLParser.getSqlQuery("checkstaffserviceins^"+strPrdCode+"^"
						+strMinService+"^"+strMaxService
						+"^"+strMinService+"^"+strMaxService
						+"^"+strMinService+"^"+strMaxService);
				
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())

				{
					if(rs.getInt(1)!=0)
					{
						throw new Exception(strExp);
					}
				}
				if(rs!=null)
				{
					rs.close();
				}
				strQuery="selmaxsstaffloan^"+strPrdCode;
				rs=DBUtils.executeLAPSQuery(strQuery);
				if(rs.next())
				{
					 strsno=Helper.correctNull((String)rs.getString("snorelmax"));
				}
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				++intUpdatesize;
				hshQuery.put("strQueryId","insstaffloan");
				
				arrValues.add(strsno);
				arrValues.add(strMinService);
				arrValues.add(strMaxService);
				arrValues.add(correctNull((String)hshValues.get("txt_maxamount")));
				arrValues.add(strPrdCode);
				hshQuery.put("arrValues",arrValues);
					
			}
			else if(strAction.equalsIgnoreCase("Update"))
			{
				String strStaffId=correctNull((String)hshValues.get("hidstaff_id"));
				strQuery=SQLParser.getSqlQuery("checkstaffserviceupd^"+strPrdCode+"^"+strStaffId+"^"
				+strMinService+"^"+strMaxService
				+"^"+strMinService+"^"+strMaxService
				+"^"+strMinService+"^"+strMaxService);
		
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())

			{
				if(rs.getInt(1)!=0)
				{
					throw new Exception(strExp);
				}
			}
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				++intUpdatesize;
				hshQuery.put("strQueryId","updstaffloan");
										
				arrValues.add(strMinService);
				arrValues.add(strMaxService);
				arrValues.add(correctNull((String)hshValues.get("txt_maxamount")));
				arrValues.add(strPrdCode);
				arrValues.add(strStaffId);
				hshQuery.put("arrValues",arrValues);
						
			}
			else if(strAction.equalsIgnoreCase("Delete"))
			{
				++intUpdatesize;
				hshQuery.put("strQueryId","delstaffloan");
				arrValues.add(correctNull((String)hshValues.get("hidstaff_id")));
				hshQuery.put("arrValues",arrValues);
			}
			hshQueryVal.put("size",Integer.toString(intUpdatesize));
			hshQueryVal.put(Integer.toString(intUpdatesize),hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryVal,"updateData");
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(!strAction.equalsIgnoreCase("Delete")){
			sbAuditTrial.append("Product Code ="+intkeyid).append("~Minimum Service =").append(correctNull((String )hshValues.get("txt_minservice")))
			.append("~Maximum Service =").append(correctNull((String )hshValues.get("txt_maxservice")))
			.append("~Eligible Loan Amount  =").append(correctNull((String )hshValues.get("txt_maxamount")));
		}
			AuditTrial.auditLog(hshValues,"128",Integer.toString(intkeyid),sbAuditTrial.toString());
		}
		catch(Exception e1)
		{
			throw new EJBException(e1.getMessage());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}	
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
		
	}
	public HashMap getStaffloan(HashMap hshValues) 
	{
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		
		String strProductCode = correctNull((String) hshValues.get("prd_code"));
		if(strProductCode.equalsIgnoreCase(""))
		{
			strProductCode = correctNull((String) hshValues.get("prdcode"));
		}
		try
		{
			rs=DBUtils.executeLAPSQuery("selstaffloan^"+strProductCode);
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull((String)rs.getString("STAFF_ID")));
				vecCol.add(correctNull((String)rs.getString("min_service")));
				vecCol.add(correctNull((String)rs.getString("max_service")));
				vecCol.add(correctNull((String)rs.getString("MAX_ELIGIBLE_AMOUNT")));
				vecRow.add(vecCol);
			}
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("selstaffloanamt^"+strProductCode);
			if(rs.next())
			{
				hshRecord.put("range_from",correctNull((String)rs.getString("prd_rng_from")));
				hshRecord.put("range_to",correctNull((String)rs.getString("prd_rng_to")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			hshRecord.put("vecRow",vecRow);
			hshRecord.put("strProductCode",strProductCode);
			
		}
		catch(Exception e1)
		{
			throw new EJBException(e1.getMessage());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
		hshRecord.put("prdcode",strProductCode);
		return hshRecord;
	}	
	public HashMap getWorkflowNPA(HashMap hshRequestValues) 
	{
				String strQuery = null;
				ResultSet rs = null;
				HashMap hshRecord = new HashMap();
				ArrayList arrWorkid = new ArrayList();
				ArrayList arrMaxclass = new ArrayList();
				ArrayList arrFunction = new ArrayList();
				ArrayList arrDuration = new ArrayList();
				ArrayList arrWorkflowname = new ArrayList();
				String strPrdCode = null;
				String strWorkflowType = null;
				boolean recordflag=false; 
				try {
					strPrdCode = (String) hshRequestValues.get("prdCode");
					strWorkflowType = (String) hshRequestValues.get("wrk_flowtype");
					if (strWorkflowType == null || strWorkflowType.trim().equals(""))
						strWorkflowType = "p";
					
					strQuery = SQLParser.getSqlQuery("npaworkflowsel^" + strPrdCode
							+ "^" + strWorkflowType);
					rs = DBUtils.executeQuery(strQuery);
				
					while (rs.next()) {
						recordflag=true;
						arrWorkid.add(rs.getString("npa_workid"));
						arrMaxclass.add(rs.getString("npa_maxclass"));
						arrFunction.add(rs.getString("npa_function"));
						arrDuration.add(rs.getString("npa_duration"));
						arrWorkflowname.add(rs.getString("wrk_flowname"));
					}
					hshRecord.put("prd_workid", arrWorkid);
					hshRecord.put("prd_maxclass", arrMaxclass);
					hshRecord.put("prd_function", arrFunction);
					hshRecord.put("prd_duration", arrDuration);
					hshRecord.put("wrk_flowname", arrWorkflowname);
					hshRecord.put("strPrdCode",strPrdCode);
					if(recordflag)
						hshRecord.put("recordflag","Y");
					else
						hshRecord.put("recordflag","N");
					
				} catch (Exception e) {
					log.error("error in getWorkflowData.. " + e);
					throw new EJBException(e.getMessage());
				} finally {
					try {
						if (rs != null) {
							rs.close();
						}
					} catch (Exception e1) {
						log.error("Error closing connection.." + e1);
					}
				}
				return hshRecord;
				}
	public void updateNPAWorkflowData(HashMap hshRequestValues) 
	{
					String[] strPrd_workid = null;
					String[] strPrd_maxclass = null;
					//String[] strPrd_function = null;
					String[] strPrd_duration = null;
					String[] strWrk_flowname = null;
					String strPrdCode = null;
					String strWrk_flowtype = null;
					String strPageid = null;
					HashMap hshQueryValues = new HashMap();
					HashMap hshQuery = new HashMap();
					ArrayList arrValues = new ArrayList();
					int intSize = 1;
					int intFlowpoint = 0;
					String strKeyId = "",strPageName="";
					StringBuilder sbolddata = new StringBuilder();
					ResultSet rs = null;
					TagDataHelper7 tagData = new TagDataHelper7();
					try 
					{
						strPrdCode = (String) hshRequestValues.get("prdCode");
						strWrk_flowtype = (String) hshRequestValues.get("wrk_flowtype");
						if (strWrk_flowtype.equalsIgnoreCase("p")) {
							intFlowpoint = 1;
							strPageName="In Process";
						} else if (strWrk_flowtype.equalsIgnoreCase("a")) {
							intFlowpoint = 9;
							strPageName="Post Approval";
						} else {
							intFlowpoint = 17;
							strPageName="Post Rejection";
						}
						
						strWrk_flowname = (String[]) hshRequestValues.get("wrk_flowname");
						strKeyId = Helper.correctNull((String)hshRequestValues.get("hidkeyid"));
						rs = DBUtils.executeLAPSQuery("npaworkflowsel^"+strPrdCode+"^"+strWrk_flowtype);
						int count=1;
						while(rs.next())
						{
							if(count == 1){
							sbolddata.append("~ Page Name = "+strPageName);
							sbolddata.append("~ Select NPA Module = ").append(SetupParams.getSetupParams("NPA",correctNull(strPrdCode)));
						    }
							sbolddata.append("~ Action = "+Helper.correctNull((String)rs.getString("wrk_flowname")));
							sbolddata.append("~ Minimum Class = "+ Helper.correctNull((String)tagData.getStaticDataDesc("7",Helper.correctNull((String)rs.getString("npa_maxclass")))));
							sbolddata.append("~ Duration = "+Helper.correctNull((String)rs.getString("npa_duration")));
							count++;
						}
						if(rs!=null)
						rs.close();
						strPrd_workid = (String[]) hshRequestValues.get("prd_workid");
						strPrd_maxclass = (String[]) hshRequestValues.get("prd_maxclass");					
						strPrd_duration = (String[]) hshRequestValues.get("prd_duration");					
						
					
						hshQueryValues.put("size", "1");
						hshQuery.put("strQueryId", "npaworkflowdel");
						arrValues.add(strPrdCode);
						arrValues.add(strWrk_flowtype);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1", hshQuery);
						intSize++;
						for (int i = 0; i < strPrd_workid.length; i++)
						{
							if (!strWrk_flowname[i].equals("")) 
							{
								hshQueryValues.put("size", String.valueOf(intSize));
								hshQuery = new HashMap();
								hshQuery.put("strQueryId", "npaworkflowins");
								arrValues = new ArrayList();
								arrValues.add(strPrdCode);
								arrValues.add(String.valueOf(intFlowpoint));
								arrValues.add(strPrd_workid[i]);
								arrValues.add(strPrd_maxclass[i]);
								arrValues.add(strPrd_duration[i]);
								arrValues.add("");
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put(String.valueOf(intSize), hshQuery);
								intSize++;
								intFlowpoint++;
							}
						}
					
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					
						
//						FOR AUDIT TRIAL
						
						StringBuilder sbAuditTrial=new StringBuilder();
						String maxclass[]=(String[])hshRequestValues.get("hid_prd_maxclass");
						sbAuditTrial.append("~ Page Name = "+strPageName);
						for(int i=0;i<8;i++)
						{
							if(strWrk_flowname[i].equals(""))continue;
							
							if(i==0){
						sbAuditTrial.append("~ Select NPA Module=").append(SetupParams.getSetupParams("NPA",correctNull(strPrdCode)));
							}
						sbAuditTrial.append("~ Action=").append(correctNull(strWrk_flowname[i]));
						sbAuditTrial.append("~ Minimum Class=").append(Helper.correctNull((String)tagData.getStaticDataDesc("7",correctNull(strPrd_maxclass[i]))));
						sbAuditTrial.append("~ Duration=").append(correctNull(strPrd_duration[i]));
						}
						if(correctNull((String)hshRequestValues.get("hidRecordflag")).equals("Y"))
						hshRequestValues.put("hidAction","update");	
						AuditTrial.auditNewLog(hshRequestValues,"95",strKeyId,sbAuditTrial.toString(),sbolddata.toString());
					
					} 
					catch (Exception e) 
					{
						log.error("Exception in updateNPAWorkflowData.. " + e);
						throw new EJBException(e.getMessage());
					}
	}

	public void updateNPADelegatePower(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		
		String delegatepower=Helper.correctNull((String)hshValues.get("grouplimitslist"));
		if(delegatepower.equalsIgnoreCase(""))
		delegatepower=Helper.correctNull((String)hshValues.get("hidgrouplimit"));
		String strKeyId = "";
		String strQuery = "";
		ResultSet rs = null,rs1= null;
		java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		try 
		{
			if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("N"))
			{
				hshValues.put("hidAction","insert");
			}
			else if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
			{
				hshValues.put("hidAction","Update");
			}
			
			StringBuilder strOldAudit = new StringBuilder();
			String strAction = Helper.correctNull((String)hshValues.get("hidAction"));
			if(strAction.equalsIgnoreCase("Update"))
			{
				strQuery = SQLParser.getSqlQuery("getdelegatepower^"+delegatepower);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()){
					strOldAudit.append("~Lending power=");
					rs1 = DBUtils.executeLAPSQuery("sel_setnpadelegate_audittrial^"+Helper.correctNull((String)rs.getString("npa_delegatepower")));
					if(rs1.next())
					{
						strOldAudit.append(Helper.correctNull((String)rs1.getString("disc_grpname")));
					}
					else
					{
						strOldAudit.append("");
					}
					strOldAudit.append("~Sacrifice Limit=");
					strOldAudit.append(nf.format(Double.parseDouble(Helper.correctDouble(Helper.correctDouble((String)rs.getString("npa_sacrificelimit"))))));
					strOldAudit.append("~Sacrifice limit can involves Write Off=");
					if(Helper.correctNull((String)rs.getString("npa_sacrificewriteoff")).equalsIgnoreCase("Y"))
					{
						strOldAudit.append("Yes");
					}
					else if(Helper.correctNull((String)rs.getString("npa_sacrificewriteoff")).equalsIgnoreCase("N"))
					{
						strOldAudit.append("No");
					}
					else
					{
						strOldAudit.append("");
					}
					strOldAudit.append("~Prudential/Absolute Write Off=");
					strOldAudit.append(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("npa_writeofflimit")))));
					strOldAudit.append("~Sarfaesi Act=");
					strOldAudit.append(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("npa_sarfaesilimit")))));
					strOldAudit.append("~Filing of Suit=");
					strOldAudit.append(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("npa_suitlimit")))));
					strOldAudit.append("~Status Note =");
					strOldAudit.append(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("npa_statusnote")))));
				}
			}
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			hshQueryValues.put("size", "2");
 			hshQuery.put("strQueryId", "deldelegatepower");
 		    arrValues.add(delegatepower);
 		    hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);

		    hshQuery = new HashMap();
		    arrValues = new ArrayList();
		    hshQuery.put("strQueryId", "insdelegatepower");
   			arrValues.add(delegatepower);
   			arrValues.add(Helper.correctNull((String)hshValues.get("txt_saclimit")));
   			arrValues.add(Helper.correctNull((String)hshValues.get("sel_writeoff")));
   			arrValues.add(Helper.correctNull((String)hshValues.get("txt_writeoff")));
   			arrValues.add(Helper.correctNull((String)hshValues.get("txt_sarfaesi")));
   			arrValues.add(Helper.correctNull((String)hshValues.get("txt_suit")));
   			arrValues.add(Helper.correctNull((String)hshValues.get("txt_status")));
			
		    hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("2", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
			SetupParams setupParams = new SetupParams();
			String Sacrifice = setupParams.getSetupParams("SacrificeLimit",correctNull((String )hshValues.get("sel_writeoff")));
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("Update")||strAction.equalsIgnoreCase("Insert"))
			{
			sbAuditTrial.append("Lending power=").append(correctNull((String )hshValues.get("grouplimitslist1"))).append("~Sacrifice Limit =").append(nf.format(Double.parseDouble(Helper.correctDouble((String )hshValues.get("txt_saclimit")))))
			.append("~Sacrifice limit can involves Write Off =").append(Sacrifice).append("~Prudential/Absolute Write Off =").append(nf.format(Double.parseDouble(Helper.correctDouble((String )hshValues.get("txt_writeoff")))))
			.append("~Sarfaesi Act  =").append(nf.format(Double.parseDouble(Helper.correctDouble((String )hshValues.get("txt_sarfaesi"))))).append("~Filing of Suit  =").append(nf.format(Double.parseDouble(Helper.correctDouble((String )hshValues.get("txt_suit")))))
			.append("~Status Note  =").append(nf.format(Double.parseDouble(Helper.correctDouble((String )hshValues.get("txt_status")))));
			}
		//	if(correctNull((String)hshValues.get("hidRecordflag")).equals("Y"))
			//	hshValues.put("hidAction", "update");
			AuditTrial.auditNewLog(hshValues,"97",strKeyId,sbAuditTrial.toString(),strOldAudit.toString());
			
		}
		catch(Exception e)
		{
				log.error("Exception in updateNPADelegatePower.. " + e);
				throw new EJBException(e.getMessage());
		}
	
	}
	public HashMap getNPADelegatePower(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		String strlendpower=Helper.correctNull((String)hshValues.get("grouplimitslist"));
		String strVal=Helper.correctNull((String)hshValues.get("hidval"));
		boolean recordflag=false;
		try 
		{
			if(strlendpower.equalsIgnoreCase(""))
			{
				strlendpower=Helper.correctNull((String)hshValues.get("hidgrouplimit"));
			}
			if(!strlendpower.equalsIgnoreCase("0"))
			{
				rs = DBUtils.executeLAPSQuery("getdelegatepower^" + strlendpower);
				
				if(rs.next())
				{
					recordflag=true;
					hshRecord.put("npa_delegatepower", Helper.correctNull((String)rs.getString("npa_delegatepower")));
					hshRecord.put("npa_sacrificelimit", Helper.correctNull((String)rs.getString("npa_sacrificelimit")));
					hshRecord.put("npa_sacrificewriteoff", Helper.correctNull((String)rs.getString("npa_sacrificewriteoff")));
					hshRecord.put("npa_writeofflimit", Helper.correctNull((String)rs.getString("npa_writeofflimit")));
					hshRecord.put("npa_sarfaesilimit", Helper.correctNull((String)rs.getString("npa_sarfaesilimit")));
					hshRecord.put("npa_suitlimit", Helper.correctNull((String)rs.getString("npa_suitlimit")));
					hshRecord.put("npa_statusnote", Helper.correctNull((String)rs.getString("npa_statusnote")));
				}
				
			}
			hshRecord.put("hidval",strVal);
			hshRecord.put("npa_delegatepower", strlendpower);
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
		}
		catch(Exception e)
		{
				log.error("Exception in getNPADelegatePower.. " + e);
				throw new EJBException(e.getMessage());
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				log.error("Error closing connection.." + e1);
			}
		}
		return hshRecord;
	}
	public HashMap updateNPAAuthority(HashMap hshValues)
	{
		HashMap hshRecord = new HashMap();
		ResultSet rs = null;
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		try 
		{
			hshQueryValues.put("size", "2");
 			hshQuery.put("strQueryId", "delnpaauthority");
 		    arrValues.add(Helper.correctNull((String)hshValues.get("prdCode")));
 		    hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);

		    hshQuery = new HashMap();
		    arrValues = new ArrayList();
		    hshQuery.put("strQueryId", "insnpaauthority");
   			arrValues.add(Helper.correctNull((String)hshValues.get("prdCode")));
   			arrValues.add(Helper.correctNull((String)hshValues.get("prd_appclass")));
   			arrValues.add(Helper.correctNull((String)hshValues.get("prd_rejclass")));
   			arrValues.add(Helper.correctNull((String)hshValues.get("prd_skipclass")));
   			
		    hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("2", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
//			FOR AUDIT TRIAL
			
			StringBuilder sbAuditTrial=new StringBuilder();
			sbAuditTrial.append(" ~Select NPA Module= ") .append(SetupParams.getSetupParams("NPA",Helper.correctNull((String)hshValues.get("prdCode"))));
			sbAuditTrial.append(" ~Minimum Class for Approval= ") .append(Helper.correctNull((String)hshValues.get("hid_prd_appclass")));
			sbAuditTrial.append(" ~Minimum Class for Rejection= ").append(Helper.correctNull((String)hshValues.get("hid_prd_rejclass")));
			sbAuditTrial.append(" ~Minimum Class for Skip flowpoints= ").append(Helper.correctNull((String)hshValues.get("hid_prd_skipclass")));
			
			
			hshValues.put("hidAction","update");	
			AuditTrial.auditLog(hshValues,"96","",sbAuditTrial.toString());
			
			hshRecord=(HashMap) getNPAAuthority(hshValues);
		}
		catch(Exception e)
		{
				log.error("Exception in updateNPAAuthority.. " + e);
				throw new EJBException(e.getMessage());
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				log.error("Error closing connection.." + e1);
			}
		}
		return hshRecord;
	}
	public HashMap getNPAAuthority(HashMap hshValues)
	{
		ResultSet rs=null;
		String prdcode=Helper.correctNull((String)hshValues.get("prdCode"));
		HashMap hshRecord = new HashMap();
		try 
		{
		
		rs = DBUtils.executeLAPSQuery("getnpaauthority^" + prdcode);
		
		if(rs.next())
		{
			hshRecord.put("npa_module", rs.getString("npa_module"));
			hshRecord.put("npa_approve", rs.getString("npa_approve"));
			hshRecord.put("npa_reject", rs.getString("npa_reject"));
			hshRecord.put("npa_skip", rs.getString("npa_skip"));
		}
		}
		catch(Exception e)
		{
				log.error("Exception in getNPAAuthority.. " + e);
				throw new EJBException(e.getMessage());
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				log.error("Error closing connection.." + e1);
			}
		}
		return hshRecord;
	}
	
	public HashMap getWorkflowmonitoring(HashMap hshRequestValues) 
	{
				String strQuery = null;
				ResultSet rs = null;
				HashMap hshRecord = new HashMap();
				ArrayList arrWorkid = new ArrayList();
				ArrayList arrMaxclass = new ArrayList();
				ArrayList arrFunction = new ArrayList();
				ArrayList arrDuration = new ArrayList();
				ArrayList arrWorkflowname = new ArrayList();
				String strPrdCode = null;
				String strWorkflowType = null;
				boolean recordflag = false;
				try {
					strPrdCode = (String) hshRequestValues.get("prdCode");
					strWorkflowType = (String) hshRequestValues.get("wrk_flowtype");
					if (strWorkflowType == null || strWorkflowType.trim().equals(""))
						strWorkflowType = "p";
					
					strQuery = SQLParser.getSqlQuery("monworkflowsel^" + strPrdCode
							+ "^" + strWorkflowType);
					rs = DBUtils.executeQuery(strQuery);
				
					while (rs.next()) {
						arrWorkid.add(rs.getString("mon_workid"));
						arrMaxclass.add(rs.getString("mon_maxclass"));
						arrFunction.add(rs.getString("mon_function"));
						arrDuration.add(rs.getString("mon_duration"));
						arrWorkflowname.add(rs.getString("wrk_flowname"));
						recordflag = true;
					}
					if(recordflag){
						hshRecord.put("recordflag", "Y");
					}else{
						hshRecord.put("recordflag", "N");
					}
					hshRecord.put("prd_workid", arrWorkid);
					hshRecord.put("prd_maxclass", arrMaxclass);
					hshRecord.put("prd_function", arrFunction);
					hshRecord.put("prd_duration", arrDuration);
					hshRecord.put("wrk_flowname", arrWorkflowname);
					hshRecord.put("strPrdCode",strPrdCode);
					
					
				} catch (Exception e) {
					log.error("error in getWorkflowData.. " + e);
					throw new EJBException(e.getMessage());
				} finally {
					try {
						if (rs != null) {
							rs.close();
						}
					} catch (Exception e1) {
						log.error("Error closing connection.." + e1);
					}
				}
				return hshRecord;
				}
	
	public void updateMONWorkflowData(HashMap hshRequestValues) 
	{
					String[] strPrd_workid = null;
					String[] strPrd_maxclass = null;
					String[] strPrd_duration = null;
					String[] strWrk_flowname = null;
					String[] hid_prd_maxclass=null;
					String strPrdCode = null;
					String strWrk_flowtype = null;
					HashMap hshQueryValues = new HashMap();
					HashMap hshQuery = new HashMap();
					ArrayList arrValues = new ArrayList();
					int intSize = 1;
					StringBuilder sbAt = new StringBuilder();
					int intFlowpoint = 0;
					ResultSet rs = null;
					ResultSet rs1 = null;
					StringBuilder sbolddata = new StringBuilder();
					String strKeyId = "";
					try 
					{
						strKeyId = Helper.correctNull((String)hshRequestValues.get("hidkeyid"));
						strPrd_workid = (String[]) hshRequestValues.get("prd_workid");
						strPrd_maxclass = (String[]) hshRequestValues.get("prd_maxclass");
					    strPrd_duration = (String[]) hshRequestValues.get("prd_duration");
						hid_prd_maxclass=(String[])hshRequestValues.get("hid_prd_maxclass");
					
						strPrdCode = correctNull((String) hshRequestValues.get("prdCode"));
						strWrk_flowtype = (String) hshRequestValues.get("wrk_flowtype");
						rs = DBUtils.executeLAPSQuery("monworkflowsel^" + strPrdCode+ "^" + strWrk_flowtype);
						while(rs.next())
						{
							sbolddata.append("~ Flow Point = "+Helper.correctNull((String)rs.getString("mon_flowpoint")))
							.append("~Action = "+Helper.correctNull((String)rs.getString("wrk_flowname")));
				
							rs1 = DBUtils.executeLAPSQuery("getstaticdata_soldid^" + '7'+ "^" + Helper.correctNull((String)rs.getString("mon_maxclass")));
							
							if(rs1.next()){
							sbolddata.append(" ~Minimum Class = "+Helper.correctNull((String)rs1.getString("stat_data_desc1")));
							}
							
							sbolddata.append(" ~Duration (in Days) = "+Helper.correctNull((String)rs.getString("mon_duration")));
							
						}
						if(rs!=null){
						rs.close();}
						if(rs1!=null){
						rs1.close();}
						
						if (strWrk_flowtype.equalsIgnoreCase("p")) {
							intFlowpoint = 1;
						} else if (strWrk_flowtype.equalsIgnoreCase("a")) {
							intFlowpoint = 9;
						} else {
							intFlowpoint = 17;
						}
						strWrk_flowname = (String[]) hshRequestValues.get("wrk_flowname");
						hshQueryValues.put("size", "1");
						hshQuery.put("strQueryId", "monaworkflowdel");
						arrValues.add(strPrdCode);
						arrValues.add(strWrk_flowtype);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1", hshQuery);
						intSize++;
						//if(correctNull(strPrdCode).equals("MON"))
						//sbAt.append(" ~Select Module =").append("Monitoring");
									
						for (int i = 0; i < strPrd_workid.length; i++) {
							if (!strWrk_flowname[i].equals("")) {
								hshQueryValues.put("size", String.valueOf(intSize));
								hshQuery = new HashMap();
								hshQuery.put("strQueryId", "monworkflowins");
								arrValues = new ArrayList();
								arrValues.add(strPrdCode);
								arrValues.add(String.valueOf(intFlowpoint));
								arrValues.add(strPrd_workid[i]);
								arrValues.add(strPrd_maxclass[i]);
								arrValues.add(strPrd_duration[i]);
								arrValues.add("");
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put(String.valueOf(intSize), hshQuery);
								
								
								sbAt.append("~Flow Point= "+String.valueOf(intFlowpoint))
								.append(" ~Action= "+strWrk_flowname[i])
								.append(" ~Minimum Class= "+hid_prd_maxclass[i])
								.append(" ~Duration (in Days)= "+strPrd_duration[i]);
								
								intSize++;
								intFlowpoint++;
							}
						}
					
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
						if(correctNull((String)hshRequestValues.get("hidRecordflag")).equals("Y"))
						  hshRequestValues.put("strAction","update");
						else
							hshRequestValues.put("strAction","new");
					    AuditTrial.auditNewLog(hshRequestValues,"124",strKeyId,sbAt.toString(),sbolddata.toString());
					
					} catch (Exception e) {
						log.error("Exception in getNPADelegatePower.. " + e);
						throw new EJBException(e.getMessage());
					}
					}

	
	
	
	public HashMap getMONAuthority(HashMap hshValues)
	{
		ResultSet rs=null;
		String prdcode=Helper.correctNull((String)hshValues.get("prdCode"));
		HashMap hshRecord = new HashMap();
		try 
		{
		
		rs = DBUtils.executeLAPSQuery("getmonauthority^" + prdcode);
		
		if(rs.next())
		{
			hshRecord.put("mon_module", rs.getString("mon_module"));
			hshRecord.put("mon_approve", rs.getString("mon_approve"));
			hshRecord.put("mon_reject", rs.getString("mon_reject"));
			hshRecord.put("mon_skip", rs.getString("mon_skip"));
		}
		}
		catch(Exception e)
		{
				log.error("Exception in getNPAAuthority.. " + e);
				throw new EJBException(e.getMessage());
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				log.error("Error closing connection.." + e1);
			}
		}
		return hshRecord;
	}
	public HashMap updateMONAuthority(HashMap hshValues)
	{
		HashMap hshRecord = new HashMap();
		ResultSet rs = null;
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		try 
		{
			hshQueryValues.put("size", "2");
 			hshQuery.put("strQueryId", "delmonauthority");
 		    arrValues.add(Helper.correctNull((String)hshValues.get("prdCode")));
 		    hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);

		    hshQuery = new HashMap();
		    arrValues = new ArrayList();
		    hshQuery.put("strQueryId", "insmonauthority");
   			arrValues.add(Helper.correctNull((String)hshValues.get("prdCode")));
   			arrValues.add(Helper.correctNull((String)hshValues.get("prd_appclass")));
   			arrValues.add(Helper.correctNull((String)hshValues.get("prd_rejclass")));
   			arrValues.add(Helper.correctNull((String)hshValues.get("prd_skipclass")));
   			
		    hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("2", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
			hshRecord=(HashMap) getMONAuthority(hshValues);
		}
		catch(Exception e)
		{
				log.error("Exception in updateNPAAuthority.. " + e);
				throw new EJBException(e.getMessage());
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				log.error("Error closing connection.." + e1);
			}
		}
		return hshRecord;
	}

	public HashMap getWorkflowBST(HashMap hshRequestValues) 
	{
		String strQuery = null;
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arrWorkid = new ArrayList();
		ArrayList arrMaxclass = new ArrayList();
		ArrayList arrDuration = new ArrayList();
		ArrayList arrWorkflowname = new ArrayList();
		String strWorkflowType = null;
		try {
			strWorkflowType = (String) hshRequestValues.get("wrk_flowtype");
			if (strWorkflowType == null || strWorkflowType.trim().equals(""))
				strWorkflowType = "p";
			
			strQuery = SQLParser.getSqlQuery("bst_workflowsel^" + strWorkflowType);
			rs = DBUtils.executeQuery(strQuery);
		
			while (rs.next()) {
				arrWorkid.add(rs.getString("bst_workid"));
				arrMaxclass.add(rs.getString("bst_minclass"));
				arrDuration.add(rs.getString("bst_duration"));
				arrWorkflowname.add(rs.getString("wrk_flowname"));
			}
			hshRecord.put("prd_workid", arrWorkid);
			hshRecord.put("prd_maxclass", arrMaxclass);
			hshRecord.put("prd_duration", arrDuration);
			hshRecord.put("wrk_flowname", arrWorkflowname);
		} 
		catch (Exception e) 
		{
			log.error("error in getWorkflowBST.. " + e);
			throw new EJBException(e.getMessage());
		}
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
				}
			} 
			catch (Exception e1) 
			{
				log.error("Error closing connection.." + e1);
			}
		}
		return hshRecord;
	}

	public void updateWorkflowBST(HashMap hshRequestValues) 
	{

		String[] strPrd_workid = null;
		String[] strPrd_maxclass = null;
		String[] strPrd_duration = null;
		String[] strWrk_flowname = null;
		String strWrk_flowtype = null;
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		int intSize = 1;
		int intFlowpoint = 0;
		StringBuilder sbAt=new StringBuilder();
		StringBuilder sbolddata = new StringBuilder();
		String strKeyId = "";
		String[] strTextclass = null;
		String[] strwrk_flowname = null;
		String strwrkflwstatus = "";
		try
		{
			strPrd_workid = (String[]) hshRequestValues.get("prd_workid");
			strwrk_flowname = (String[]) hshRequestValues.get("wrk_flowname");
			strPrd_maxclass = (String[]) hshRequestValues.get("prd_maxclass");
			strPrd_duration = (String[]) hshRequestValues.get("prd_duration");
			strWrk_flowtype = (String) hshRequestValues.get("wrk_flowtype");
			strTextclass = (String[]) hshRequestValues.get("hid_prd_maxclass");
			strKeyId = Helper.correctNull((String)hshRequestValues.get("hidkeyid"));
			if (strWrk_flowtype.equalsIgnoreCase("p"))
			{
				intFlowpoint = 1;
				strwrkflwstatus = "In Process";				
			}
			else if (strWrk_flowtype.equalsIgnoreCase("a")) 
			{
				intFlowpoint = 9;
				strwrkflwstatus = "Post Approval";		
			}
			else 
			{
				intFlowpoint = 17;
				strwrkflwstatus = "Post Rejection";		
			}
			strWrk_flowname = (String[]) hshRequestValues.get("wrk_flowname");
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "bst_workflowdel");
			arrValues.add(strWrk_flowtype);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			intSize++;
			for (int i = 0; i < strPrd_workid.length; i++)
			{
				if (!strWrk_flowname[i].equals("")) 
				{
					hshQueryValues.put("size", String.valueOf(intSize));
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "bst_workflowins");
					arrValues = new ArrayList();
					arrValues.add(String.valueOf(intFlowpoint));
					arrValues.add(strPrd_workid[i]);
					arrValues.add(strPrd_maxclass[i]);
					arrValues.add(strPrd_duration[i]);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(intSize), hshQuery);
					intSize++;
					intFlowpoint++;					
				}
			}
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			if (strWrk_flowtype.equalsIgnoreCase("p"))
			{
				intFlowpoint = 1;
			}
			else if (strWrk_flowtype.equalsIgnoreCase("a")) 
			{
				intFlowpoint = 9;
			}
			else 
			{
				intFlowpoint = 17;
			}
			sbAt.append("~ Page Name = "+strwrkflwstatus);
			for (int i = 0; i < strPrd_workid.length; i++)
			{
				if (!strWrk_flowname[i].equals("")) 
				{
				
					sbAt.append("~ Flow Point = "+String.valueOf(intFlowpoint));
					sbAt.append("~ Action = "+strwrk_flowname[i]);
					sbAt.append("~ Minimum Class = "+strTextclass[i]);
					sbAt.append("~ Duration in Days = "+strPrd_duration[i]);
					intSize++;
					intFlowpoint++;	
				}
			}
			hshRequestValues.put("hidAction","Update");
			
				
			AuditTrial.auditLog(hshRequestValues,"358",strKeyId,sbAt.toString());			
		}
		catch (Exception e) 
		{
			log.error("Exception in updateBSTWorkflowData.. " + e);
			throw new EJBException(e.getMessage());
		}
	}
	/**
	 * 	
	 * @author:Zahoorunnisa.S
	 * @date:July 09, 2012-12:46:54 PM
	 * @category to copy the Product
	 * @return
	 * @
	 */

	public void copyProduct(HashMap hshValues)  {

		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strPrddesc = "";
		
		try {
			String strPrd_Type = Helper.correctNull((String)hshValues.get("prd_type"));
			if(strPrd_Type.equalsIgnoreCase(""))
			{
				strPrd_Type = Helper.correctNull((String)hshValues.get("hidProductType"));
			}
			
			String strOldPrdId = (String) hshValues.get("hidOldPrdId");
			String strProductCode = getProductCode();
			int querySize = 0;
			
			// insert data in products table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenproductsins");
			hshQueryValues.put(""+querySize, hshQuery);
			
			// update renew column in products table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdcopyproductsupd");
			hshQueryValues.put(""+querySize, hshQuery);
			
			// insert data in to prod_business table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenprodbuss");
			hshQueryValues.put(""+querySize, hshQuery);
			
			// insert data in to prd_used table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenprodused");
			hshQueryValues.put(""+querySize, hshQuery);
			
			// insert data in to prd_authority table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenprodauth");
			hshQueryValues.put(""+querySize, hshQuery);
			
			// insert data in to prd_documents table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenproddoc");
			hshQueryValues.put(""+querySize, hshQuery);
			
			// insert data in to prd_workflow table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenprodwork");
			hshQueryValues.put(""+querySize, hshQuery);
			
			// insert data in to prd_interest table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenprodint");
			hshQueryValues.put(""+querySize, hshQuery);
			
			// insert data in to prd_sanction_limit table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenprodsanc");
			hshQueryValues.put(""+querySize, hshQuery);
			
			// insert data in to prd_documentcharge table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenproddoccharge");
			hshQueryValues.put(""+querySize, hshQuery);
			
			// insert data in to prd_processcharge table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenprodprocharge");
			hshQueryValues.put(""+querySize, hshQuery);
			
			//insert data in to prd_margintable table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenmarginamt");
			hshQueryValues.put(""+querySize, hshQuery);
			
			// insert data in to SubStepRules table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenprodstepup");
			hshQueryValues.put(""+querySize, hshQuery);
			
			// insert data in to General info table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrengeneinfo");
			hshQueryValues.put(""+querySize, hshQuery);
			
			//insert data in to prd_repaycapcity table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenrepaycapacity");
			hshQueryValues.put(""+querySize, hshQuery);
			//insert into terms and conditions table 
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrentermscodition");
			hshQueryValues.put(""+querySize, hshQuery);
			// end
			//insert data in to prd_specificconditions table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenspecificeligibility");
			hshQueryValues.put(""+querySize, hshQuery);
			if(strPrd_Type.equalsIgnoreCase("pG")||strPrd_Type.equalsIgnoreCase("aH"))
			{
				//insert data in to prd_rentinsurecharge table
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(strProductCode);
				arrValues.add(strOldPrdId);
				querySize++;
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "prdrenrentinsurecharge");
				hshQueryValues.put(""+querySize, hshQuery);
				
				//insert data in to prd_jewelappraisalcharge table
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(strProductCode);
				arrValues.add(strOldPrdId);
				querySize++;
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "prdrenjewelappraisalcharge");
				hshQueryValues.put(""+querySize, hshQuery);
			}
			//insert data into prd_activitycodes table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			arrValues.add(strProductCode);
			arrValues.add(strOldPrdId);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "prdrenactivitycodes");
			hshQueryValues.put(""+querySize, hshQuery);
			
			// insert data in to prdint_master table
			int mastersize = checkIntMasterSize(strOldPrdId);
		
			ArrayList vecMaster = (ArrayList) getMasterData(strOldPrdId);
		
			int intMaxIntcode = maxIntCode();
			for (int i = 0; i < mastersize; i++) {
				querySize++;
				ArrayList vecCol = (ArrayList) vecMaster.get(i);
		
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(strProductCode);
				arrValues.add(vecCol.get(1));
				arrValues.add(Integer.toString(intMaxIntcode));
				arrValues.add(vecCol.get(2));
				arrValues.add(vecCol.get(3));
				arrValues.add(vecCol.get(4));
				arrValues.add(vecCol.get(5));

				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "prdrenprodintmaster");
				hshQueryValues.put(Integer.toString(querySize), hshQuery);
				ArrayList vecLimt = (ArrayList) getLimitData((String) vecCol.get(0));
				for (int j = 0; j < vecLimt.size(); j++) {
					querySize++;
					ArrayList vecLimitCol = (ArrayList) vecLimt.get(j);
				
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					arrValues.add(Integer.toString(intMaxIntcode));
					arrValues.add(vecLimitCol.get(0));
					arrValues.add(vecLimitCol.get(1));
					arrValues.add(vecLimitCol.get(2));
					arrValues.add(vecLimitCol.get(3));
					arrValues.add(vecLimitCol.get(4));
					arrValues.add(vecLimitCol.get(5));
					arrValues.add(vecLimitCol.get(6));
					arrValues.add(vecLimitCol.get(7));
					arrValues.add(vecLimitCol.get(8));
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "prdrenprodintlimit");
					hshQueryValues.put(Integer.toString(querySize), hshQuery);
				}
				intMaxIntcode++;
			}
			
			hshQueryValues.put("size", Integer.toString(querySize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
			rs = DBUtils.executeLAPSQuery("setproductssel^"+ strProductCode);
			if (rs.next()) {
				strPrddesc = Helper.correctNull((String)rs.getString("prd_desc"));
			}
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			hshQueryValues= new HashMap();
			
			
			//Update Product desc  data in products table
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			hshQueryValues= new HashMap();
			arrValues.add(strPrddesc+" (Copy)");
			arrValues.add(strProductCode);
			querySize++;
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "copy_updatePrdDesc");
			hshQueryValues.put(""+querySize, hshQuery);
			hshQueryValues.put("1", hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					

		} catch (Exception ce) {
			log.error("exception in Copy Product.. " + ce);
			throw new EJBException("Error in updateData " + ce.toString());
		}
	}
	
	private void updateOnline(HashMap hshValues)  {
		HashMap hshqueryval = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = null;
		String strQuery="", strprdtype="";
		ResultSet rs= null;
		int intUpdatesize=1;
		String strPrdcode="";
		int count=0;
		int intsno = 0;
	   
		try {
			strPrdcode = correctNull((String)hshValues.get("prdCode")).trim();
			if(strPrdcode.equalsIgnoreCase("") || strPrdcode.equalsIgnoreCase("New"))
			{
				strPrdcode = correctNull((String)hshValues.get("prd_code"));
			}
			strprdtype =  Helper.correctNull((String)hshValues.get("strprdtype")).trim();
			if(strprdtype.equalsIgnoreCase(""))
			{
				strprdtype = correctNull((String)hshValues.get("prd_type"));
			}
			
			//Deletion
			
			rs = DBUtils.executeInternetQuery("sel_interest_master_count^"+SetupParams.getSetupParams("OnlinePrdCode",strprdtype));
			while(rs.next()){
				count = rs.getInt("count");
			}
			
			if(rs != null){
				rs.close();
			}
			
			String[] strseqno=new String[count];
			int i=0;
			rs = DBUtils.executeInternetQuery("sel_interest_master_seqno^"+SetupParams.getSetupParams("OnlinePrdCode", strprdtype));
			while(rs.next()){
				strseqno[i] = Helper.correctNull(rs.getString("int_seqno"));
				i++;
			}
			
			if(rs != null){
				rs.close();
			}
			
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshqueryval = new HashMap();
			hshQuery.put("strQueryId", "del_interest_master");
			arrValues.add(SetupParams.getSetupParams("OnlinePrdCode", strprdtype));
			hshQuery.put("arrValues", arrValues);
			hshqueryval.put(Integer.toString(intUpdatesize), hshQuery);
			
			for(int x=0; x<count; x++){
			intUpdatesize++;
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			hshQuery.put("strQueryId", "del_interest_value");
			arrValues.add(strseqno[x]);
			hshQuery.put("arrValues", arrValues);
			hshqueryval.put(Integer.toString(intUpdatesize), hshQuery);
			}
			hshqueryval.put("size", Integer.toString(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateInternetData");
			
			
			//Insertion
			
			strQuery= SQLParser.getSqlQuery("prdrenprodintcount^"+strPrdcode);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next()){
				intsno = rs.getInt("prdcount");
			}
			
			if(rs != null){
				rs.close();
			}
			
			
			intUpdatesize=0;
			int j=0;
			String[] strsno=new String[intsno];
			hshqueryval = new HashMap();
			
			strQuery= SQLParser.getSqlQuery("prdrenprodintmasterinternet^"+strPrdcode);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next()){
				intUpdatesize++;
				strsno[j] = Helper.correctNull(rs.getString("prdint_sno"));
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "ins_interest_master");
				arrValues.add(SetupParams.getSetupParams("OnlinePrdCode", strprdtype));
				arrValues.add(strsno[j]);
				arrValues.add(Helper.correctNull(rs.getString("prd_amtrangefrom")));
				arrValues.add(Helper.correctNull(rs.getString("prd_amtrangeto")));
				hshQuery.put("arrValues", arrValues);
				hshqueryval.put(Integer.toString(intUpdatesize), hshQuery);
				j++;
			}
			
			if(rs != null){
				rs.close();
			}
			
			
			for(int y=0; y<intsno; y++){
				int z=0;
				strQuery= SQLParser.getSqlQuery("prdrenprodintlimitselect^"+strsno[y]);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next()){
					intUpdatesize++;
					z++;
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "ins_interest_value");
					arrValues.add(Helper.correctNull(rs.getString("prd_intid")));
					arrValues.add(Integer.toString(z));
					arrValues.add(Helper.correctNull(rs.getString("prd_termfrom")));
					arrValues.add(Helper.correctNull(rs.getString("prd_termto")));
					arrValues.add(Helper.correctNull(rs.getString("prd_interest")));
					hshQuery.put("arrValues", arrValues);
					hshqueryval.put(Integer.toString(intUpdatesize), hshQuery);
				}
			}
			
			hshqueryval.put("size", Integer.toString(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateInternetData");
			
			//End
			
		} catch (Exception ce) {
			log.error("in bean... " + ce);
			throw new EJBException("Error in updateData " + ce.toString());
		}

	}
	
	public void updateOnlineRepayCapacity(HashMap hshValues)  {
		HashMap hshqueryval = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = null;
		String strQuery="", strprdtype="";
		ResultSet rs= null;
		int intUpdatesize=1;
		String strPrdcode="";
		int count=0;
		int intsno = 0;
	   
		try {
			strPrdcode = correctNull((String)hshValues.get("prdCode")).trim();
			if(strPrdcode.equalsIgnoreCase("") || strPrdcode.equalsIgnoreCase("NEW"))
			{
				strPrdcode = correctNull((String)hshValues.get("prd_code"));
			}
			strprdtype =  Helper.correctNull((String)hshValues.get("strprdtype")).trim();
			if(strprdtype.equalsIgnoreCase(""))
			{
				strprdtype = correctNull((String)hshValues.get("prd_type"));
			}
				
			//Deletion
			
			rs = DBUtils.executeInternetQuery("sel_prd_repaycapacity_count^"+SetupParams.getSetupParams("OnlinePrdCode",strprdtype));
			while(rs.next()){
				count = rs.getInt("count");
			}
			
			if(rs != null){
				rs.close();
			}
			
			String[] strRepayid=new String[count];
			int i=0;
			rs = DBUtils.executeInternetQuery("sel_prd_repaycapacity_repayid^"+SetupParams.getSetupParams("OnlinePrdCode", strprdtype));
			while(rs.next()){
				strRepayid[i] = Helper.correctNull(rs.getString("repay_id"));
				i++;
			}
			
			if(rs != null){
				rs.close();
			}
			
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshqueryval = new HashMap();
			hshQuery.put("strQueryId", "del_online_repaycapacity");
			arrValues.add(SetupParams.getSetupParams("OnlinePrdCode", strprdtype));
			hshQuery.put("arrValues", arrValues);
			hshqueryval.put(Integer.toString(intUpdatesize), hshQuery);
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateInternetData");
			
			
			//Insertion
			
			strQuery= SQLParser.getSqlQuery("onlineRepaycount^"+strPrdcode);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next()){
				intsno = rs.getInt("repaycount");
			}
			
			if(rs != null){
				rs.close();
			}
			
			if(intsno != 0)
			{
			intUpdatesize=0;
			int j=0;
			String[] strsno=new String[intsno];
			hshqueryval = new HashMap();
			
			strQuery= SQLParser.getSqlQuery("onlineRepayselect^"+strPrdcode);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next()){
				intUpdatesize++;
				strsno[j] = Helper.correctNull(rs.getString("REPAY_ID"));
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "ins_onlineRepay");
				arrValues.add(SetupParams.getSetupParams("OnlinePrdCode", strprdtype));
				arrValues.add(strsno[j]);
				arrValues.add(Helper.correctNull(rs.getString("REPAY_INCRANGEFROM")));
				arrValues.add(Helper.correctNull(rs.getString("REPAY_INCRANGETO")));
				arrValues.add(Helper.correctNull(rs.getString("REPAY_SALARIEDSUSTANECE")));
				arrValues.add(Helper.correctNull(rs.getString("REPAY_NONSALARIEDSUSTANECE")));
				arrValues.add(Helper.correctNull(rs.getString("REPAY_ARTIFICIALSUSTANECE")));
				arrValues.add(Helper.correctNull(rs.getString("REPAY_CREDIT")));
				hshQuery.put("arrValues", arrValues);
				hshqueryval.put(Integer.toString(intUpdatesize), hshQuery);
				j++;
			}
			
			hshqueryval.put("size", Integer.toString(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateInternetData");
			}
			
			//End
			
		} catch (Exception ce) {
			log.error("in bean... " + ce);
			throw new EJBException("Error in updateOnlineRepayCapacity " + ce.toString());
		}

	}
	public HashMap getSchemeCodeData(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		ResultSet rs=null;
		String strSchemeId ="";
		String strLoanType="";
		ArrayList arrCol=new ArrayList();
		String strSchemeCode="";

		try
		{
			strLoanType=Helper.correctNull((String)hshValues.get("loantype"));
			//strSchemeCode=Helper.correctNull((String)hshValues.get("schemecode"));
			if(strLoanType.equalsIgnoreCase("TL") || strLoanType.equalsIgnoreCase("DL"))
			{
				strSchemeId="LAA";
			}
			else if(strLoanType.equalsIgnoreCase("OD"))
			{
				strSchemeId="ODA";
			}
			rs=DBUtils.executeLAPSQuery("sel_distschemecode^"+strSchemeId);
			while(rs.next())
			{
				arrCol.add(Helper.correctNull((String)rs.getString("sch_datavalue")));
			}
			hshRecord.put("arrCol",arrCol);
			hshRecord.put("strSchemeId",strSchemeId);
			//hshRecord.put("schemecode",strSchemeCode);
		
		}
		catch(Exception ce)
		{
		
			throw new EJBException("Error in getdata "+ce.toString());
		}
		
		return hshRecord;
	}
	public HashMap getRepaymentTypeData(HashMap hshValues) 
	{
		ResultSet rs=null;
		String strLoanType="",strPrdCode="",strCBSAccNo="",strType="",strappno="";
		ArrayList arrCol=new ArrayList();

		try
		{
			strLoanType=Helper.correctNull((String)hshValues.get("strModType"));
			strPrdCode=Helper.correctInt((String)hshValues.get("strPrdcode"));
			strCBSAccNo=Helper.correctInt((String)hshValues.get("cbsAccNo"));
			strappno=Helper.correctInt((String)hshValues.get("appno"));
			strType=Helper.correctNull((String)hshValues.get("type"));
			hshValues.put("Limittype",Helper.correctNull((String)hshValues.get("Limit")));
			
			if(strType.equalsIgnoreCase("E"))
			{
				if(strLoanType.equalsIgnoreCase("AGR") || strLoanType.equalsIgnoreCase("CORP"))
				{
					rs=DBUtils.executeLAPSQuery("sel_existing_limit^"+strCBSAccNo+"^"+strappno);
					if(rs.next())
					{
						hshValues.put("FACILITY_SANCAMT",Helper.correctNull(rs.getString("FACILITY_SANCAMT")));
						hshValues.put("FACILITY_FACNATURE",Helper.correctNull(rs.getString("FACILITY_FACNATURE")));
					}
				}
				else
				{
					
				}
			}
			else
			{
				if(strLoanType.equalsIgnoreCase("AGR") || strLoanType.equalsIgnoreCase("CORP"))
				{
					rs=DBUtils.executeLAPSQuery("sel_facilitycorp_desc^"+strPrdCode);
					if(rs.next())
					{
						hshValues.put("strRepaymentType",Helper.correctNull(rs.getString("fac_repaytype")));
					}
					
				}else{
					rs=DBUtils.executeLAPSQuery("setproductssel^"+strPrdCode);
					if(rs.next())
					{
						hshValues.put("strRepaymentType",Helper.correctNull(rs.getString("prd_repaytype")));
					}
				}
			}
		}
		catch(Exception ce)
		{
		
			throw new EJBException("Error in getdata "+ce.toString());
		}
		
		return hshValues;
	}
	
	public void updatePrdAcitivityCodeData(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		try
		{
			String strPrdCode=Helper.correctNull((String)hshValues.get("prdCode"));
			String strcorpmodule=Helper.correctNull((String)hshValues.get("strCorpModule"));
			if(strcorpmodule.equalsIgnoreCase(""))
			{
				strcorpmodule="p";
			}
			if(strPrdCode.equalsIgnoreCase(""))
			{
				 strPrdCode=Helper.correctNull((String)hshValues.get("fac_id"));
			}
			String strActivityCodeChosen=Helper.correctNull((String)hshValues.get("hidActivityCodeChosen"));
			strActivityCodeChosen = strActivityCodeChosen.substring(0,strActivityCodeChosen.length()-1);
			hshQuery.put("strQueryId", "del_PrdActivityCodes");
			arrValues.add(strPrdCode);
			arrValues.add(strcorpmodule);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId", "ins_PrdActivityCodes");
			arrValues.add(strPrdCode);
			arrValues.add(strActivityCodeChosen);
			arrValues.add(strcorpmodule);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("2", hshQuery);
			
			hshQueryValues.put("size", "2");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updatedata");
			updateProductSaveStatus(hshValues);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updatePrdAcitivityCodeData "+ce.toString());
		}
	}
	public HashMap getPrdAcitivityCodeData(HashMap hshValues) 
	{
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
		String strQuery="";
		String strQuery1="";
		String strPurposeslno="",strPurposeDesc="",strPurposeDescnew="";
		HashMap hshActivity = new HashMap();
		try
		{
			String strmodule=Helper.correctNull((String)hshValues.get("strCorpModule"));
			if(strmodule.equalsIgnoreCase(""))
			{
				strmodule="p";
			}
			String strPrdCode=Helper.correctNull((String)hshValues.get("prdCode"));
			if(strPrdCode.equalsIgnoreCase(""))
			{
				 strPrdCode=Helper.correctNull((String)hshValues.get("fac_id"));
			}
			if(strPrdCode.equalsIgnoreCase(""))
			{
				strPrdCode=Helper.correctNull((String)hshValues.get("fac_id1"));
			}
			String strActivityCodes="";
			strQuery=SQLParser.getSqlQuery("sel_PrdActivityCodes^"+strPrdCode+"^"+strmodule);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strActivityCodes=correctNull(Helper.CLOBToString(rs.getClob("prdact_activitycode")));
			}
			if(!strActivityCodes.equals(""))
			{
				if(strActivityCodes.indexOf(strActivityCodes.length())== -1)
					strActivityCodes = strActivityCodes.substring(0,(strActivityCodes.length()-1));
				strQuery1=SQLParser.getSqlQuery("sel_PurposeCode^"+"3");
				rs1=DBUtils.executeQuery(strQuery1);
				while(rs1.next())
				{
					strPurposeslno=Helper.correctNull((String)rs1.getString("mis_slno"));
					strPurposeDesc=Helper.correctNull((String)rs1.getString("mis_static_data_desc"));
					hshActivity.put(strPurposeslno,strPurposeDesc);
				}
				StringTokenizer st = new StringTokenizer(strActivityCodes,"~");
				while(st.hasMoreTokens())
				{
					arrCol=new ArrayList();
					String strCode = (String)st.nextToken();
					if(!strCode.equals(""))
					{
						String[] strDesc=strCode.split("&");
						if(strDesc!=null)
						{
							if(hshActivity!=null&&hshActivity.size()>0)
							{
							strPurposeDescnew = Helper.correctNull((String)hshActivity.get(strDesc[1].trim()));
							}
							arrCol.add(strCode);
							arrCol.add(strDesc[0]+"-"+strPurposeDescnew);
						}
					}
					arrRow.add(arrCol);
				}
			}
			hshValues.put("strmodule",strmodule);
			hshValues.put("arrRow",arrRow);
		}
		catch (Exception e) 
		{
			log.error("error in getPrdAcitivityCodeData.. " + e);
			throw new EJBException(e.getMessage());
		}
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
				}
				if (rs1 != null) 
				{
					rs1.close();
				}
			} 
			catch (Exception e1) 
			{
				log.error("Error closing connection.." + e1);
			}
		}
		return hshValues;
	}
	public HashMap corpinterestTerm(HashMap hsh)  {
		
		java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
    	jtn.setMaximumFractionDigits(2);
    	jtn.setMinimumFractionDigits(2);
    	jtn.setGroupingUsed(false);
		
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQuery;
		HashMap hshValues = new HashMap();
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec = new ArrayList();
		ArrayList arr = new ArrayList();
		ArrayList arrValues;
		ResultSet rs = null;
		ResultSet rs5 = null;
		String val = "", id = "";
		int intValue = 0;
		String strQuery="";
		String strExp="$";
		int curLimitId=0;
		String strLimitFrom=Helper.correctNull((String)hsh.get("amtfrom"));
		String strLimitTo=Helper.correctNull((String)hsh.get("amtto"));
		String wrk_flowtype1=Helper.correctNull((String)hsh.get("wrk_flowtype1"));
		String sel_indtype =Helper.correctNull((String)hsh.get("sel_indtype"));
		String sel_inttype =Helper.correctNull((String)hsh.get("sel_inttype"));
		String selindtype =Helper.correctNull((String)hsh.get("selindtype"));
		String fac_id = Helper.correctNull((String) hsh.get("fac_id1"));
		String strAmtfrom="";
		String strAmtto ="";
		String strPrdcode=Helper.correctNull((String) hsh.get("fac_id1"));;
		String strType="",strRefType="O";
		 strExp="$";
		 StringBuilder sbOldAudit = new StringBuilder();
		try {
			val = Helper.correctNull((String) hsh.get("hidval"));

			strAmtfrom=correctNull((String)hsh.get("amtfrom"));
			strAmtto=correctNull((String)hsh.get("amtto"));
			
			if(rs!=null)
			{
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("getprdcodelimitlist^"+strPrdcode);
			if (rs.next()) {
				
				hshValues.put("com_minrepayperiod",Helper.correctNull(rs.getString("com_minrepayperiod")));
				hshValues.put("com_maxrepayperiod",Helper.correctNull(rs.getString("com_maxrepayperiod")));
				hshValues.put("com_rangefrom",Helper.correctNull(rs.getString("com_rangefrom")));
				hshValues.put("com_rangeto",Helper.correctNull(rs.getString("com_rangeto")));
				hshValues.put("com_facintdef",Helper.correctNull(rs.getString("com_facintdef")));
				hshValues.put("fac_interesttype",Helper.correctNull(rs.getString("fac_interesttype")));
			
			}
			
			
			if (val.equals("insert_terms")) 
			{
				strAmtfrom=correctNull((String)hsh.get("amtfrom"));
				strAmtto=correctNull((String)hsh.get("amtto"));
				strType=correctNull((String)hsh.get("work"));
				
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("corpcheckintprdrangeins1^"+fac_id+"^"+strType
							+"^"+strAmtfrom+"^"+strAmtto
							+"^"+strAmtfrom+"^"+strAmtto
							+"^"+strAmtfrom+"^"+strAmtto
							+"^"+sel_inttype+"^"+strRefType);
				rs=DBUtils.executeQuery(strQuery);
				
				
				if(rs.next())
					{
					if(rs.getInt(1)!=0)
						{
						strExp = strExp + " Check the existing amount range ";
						throw new Exception(strExp);
						}
					}
				
				
				
				arrValues = new ArrayList();
				if(rs!=null)
					rs.close();

				String[] strfrom = null;
				String[] strto = null;
				String[] total = null;
				String[] baserate = null;
				String[] adjust = null;
				String[] interest = null;
				
				String[] adjust1=null;
				String[] total1 = null;
				
				int intUpdatesize = 0;
				arrValues = new ArrayList();
				if(rs!=null)
				{
					rs.close();
				}
				rs = DBUtils.executeLAPSQuery("corpintmaxterm^"+strPrdcode);
				intUpdatesize = 1;
				if (rs.next()) {
					intValue = (rs.getInt(1));
				}

				intValue = intValue + 1;
				id = Integer.toString(intValue);
				hshqueryval.put("size", Integer.toString(intUpdatesize));
				hshquery.put("strQueryId", "corpinttermins");
				arr.add(fac_id);
				arr.add(hsh.get("work"));
				arr.add(id);
				arr.add(hsh.get("amtfrom"));
				arr.add(hsh.get("amtto"));
				arr.add(hsh.get("sel_indtype"));
				arr.add(hsh.get("sel_inttype"));
				arr.add("");
				arr.add("");
				arr.add(strRefType);
				hshquery.put("arrValues", arr);
				hshqueryval.put("1", hshquery);
				
				
				
				
				//updateRatingBasedRoiCorporate(hsh,id);
				if(sbOldAudit==null)
				{
					sbOldAudit.append("");
				}
				hsh.put("sbOldAudit", sbOldAudit);
				updateInterestCorpData(hsh,id);

				EJBInvoker.executeStateLess("dataaccess", hshqueryval,
						"updateData");
				
				HashMap hshTemp = new HashMap();
				hshTemp.put("fac_id",hsh.get("fac_id1"));
				hshValues.put("rangefrom", hsh.get("amfrom"));
				hshValues.put("rangeto", hsh.get("amto"));
				hshValues.put("ruleid", hsh.get("ruleid"));
				hshValues.put("wrk_flowtype1", hsh.get("work"));
				hshValues.put("selindtype",hsh.get("sel_indtype"));
				hshValues.put("selinttype",hsh.get("sel_inttype"));
				EJBInvoker.executeStateLess("corporatefacility",hshTemp,"updateFacilitySaveStatus");

			}
			if (val.equals("update_terms")) {
				
				strAmtfrom=correctNull((String)hsh.get("amtfrom"));
				strAmtto=correctNull((String)hsh.get("amtto"));
				strType=correctNull((String)hsh.get("work"));
				String strPrdsno=correctNull((String)hsh.get("ruleid"));
				strQuery=SQLParser.getSqlQuery("corpcheckinterestprdrangeupd^"+fac_id+"^"+strType
						+"^"+strAmtfrom+"^"+strAmtto
						+"^"+strAmtfrom+"^"+strAmtto
						+"^"+strAmtfrom+"^"+strAmtto+
						"^"+sel_inttype+"^"+strPrdsno+"^"+strRefType);
				
				rs=DBUtils.executeQuery(strQuery);
				
				if(rs.next())
					{
					if(rs.getInt(1)!=0)
						{
						strExp = strExp + " Check the existing amount range ";
						throw new Exception(strExp);
						}
					}
				
				

				int intUpdatesize = 0;
				String[] strfrom = null;
				String[] strto = null;
				String[] strpoint = null;
				String[] baserate = null;
				String[] adjust = null;
				String[] interest = null;
				
				String[] stradjust1 = null;
				String[] strtotal1=null;
				
				String termfrom="";
				String termto="";
				
				/***
				 * For Audit Trial Old Data - By Karthikeyan.S on 10/10/2013
				 */
				String strPageFrom=Helper.correctNull((String)hsh.get("wrk_flowtype1"));
				String strPageDesc="";
				if(strPageFrom.equalsIgnoreCase("fixed"))
				{
					strPageDesc="Fixed Rate";
				}
				else if(strPageFrom.equalsIgnoreCase("floating"))
				{
					strPageDesc="Floating";
				}
				boolean boolFlag=false;
				strQuery=SQLParser.getSqlQuery("select_intterms^"+strPrdcode+"^"+strPageFrom+"^"+strAmtfrom+"^"+strAmtto+"^"+sel_inttype);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					if(boolFlag==false)
					{
						sbOldAudit
						.append("~Interest Type=").append(strPageDesc)
						.append("~Amount Range From=").append(strAmtfrom)
						.append("~Amount Range To=").append(strAmtto);
						boolFlag=true;
					}
					sbOldAudit
					.append("~S.No=").append(Helper.correctNull((String)rs.getString("corpprd_sno")))
					.append("~Loan Period From=").append(Helper.correctNull((String)rs.getString("corpprd_termfrom")))
					.append("~Loan Period To=").append(Helper.correctNull((String)rs.getString("corpprd_termto")))
					.append("~Reference Rate=").append(Helper.correctNull((String)rs.getString("corpprd_baserate")))
					.append("~Adjustments (+/-)=").append(Helper.correctNull((String)rs.getString("corpprd_adjust")))
					.append("~Interest Rate (%)=").append(Helper.correctNull((String)rs.getString("corpprd_interest")));
				}
				/***
				 * End - Audit Trial Old Data
				 */
				
				intUpdatesize = 1;
				hshqueryval.put("size", Integer.toString(intUpdatesize));
				hshquery = new HashMap();
				arr = new ArrayList();

				hshquery.put("strQueryId", "corplimitdel");
				arr.add(hsh.get("ruleid"));
				hshquery.put("arrValues", arr);
				hshqueryval.put("1", hshquery);
				intUpdatesize = 2;
				hshqueryval.put("size", Integer.toString(intUpdatesize));
				hshquery = new HashMap();
				arr = new ArrayList();
				hshquery.put("strQueryId", "corplimitupd");
				arr.add(hsh.get("amtfrom"));
				arr.add(hsh.get("amtto"));
				arr.add("");
				arr.add("");
				arr.add(strRefType);
				arr.add(hsh.get("ruleid"));
				hshquery.put("arrValues", arr);
				hshqueryval.put("2", hshquery);
				

				EJBInvoker.executeStateLess("dataaccess", hshqueryval,
						"updateData");
				id = (String) hsh.get("ruleid");
				//updateRatingBasedRoiCorporate(hsh,id);
				if(sbOldAudit==null)
				{
					sbOldAudit.append("");
				}
				hsh.put("sbOldAudit", sbOldAudit);
				updateInterestCorpData(hsh,id);
				HashMap hshTemp = new HashMap();
				hshTemp.put("fac_id",hsh.get("fac_id1"));	
				hshTemp.put("selindtype",hsh.get("sel_indtype"));
				EJBInvoker.executeStateLess("corporatefacility",hshTemp,"updateFacilitySaveStatus");
				
				
				
				hshValues.put("rangefrom", hsh.get("amtfrom"));
				hshValues.put("rangeto", hsh.get("amtto"));
				hshValues.put("ruleid", hsh.get("ruleid"));
				hshValues.put("wrk_flowtype1", hsh.get("wrk_flowtype1"));
				
				hshValues.put("corpprd_industrytype", hsh.get("sel_indtype"));
				hshValues.put("corpprd_interesttype", hsh.get("sel_inttype"));
				
				
				id = (String) hsh.get("ruleid");
					if(rs!=null)
					{
						rs.close();
					}
					
				rs = DBUtils.executeLAPSQuery("corpruleresult^" + id+"^"+strPrdcode+"^"+strAmtfrom+"^"+strAmtto);
				while (rs.next()) {
					vecRec = new ArrayList();
					vecRec.add(correctNull(rs.getString("corpprd_termfrom")));
					vecRec.add(correctNull(rs.getString("corpprd_termto")));
					vecRec.add(correctNull(rs.getString("corpprd_baserate")));
					vecRec.add(correctNull(rs.getString("corpprd_adjust")));
					vecRec.add(correctNull(rs.getString("corpprd_interest")));
					vecRec.add(correctNull(rs.getString("corpprd_interestid")));
					vecRec.add(correctNull(rs.getString("corpprd_adjust1")));
					vecRec.add(correctNull(rs.getString("corpprd_interest1")));
					vecRec.add(correctNull(rs.getString("corpprd_tablecodegen")));
					vecRec.add(correctNull(rs.getString("corpprd_tablecode")));
					if(Helper.correctNull(rs.getString("corpprd_creditrskpremium")).equalsIgnoreCase(""))
						vecRec.add("");
					else
						vecRec.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("corpprd_creditrskpremium")))));
					if(Helper.correctNull(rs.getString("corpprd_busstrategicpremium")).equalsIgnoreCase(""))
						vecRec.add("");
					else
						vecRec.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("corpprd_busstrategicpremium")))));
					
					vecVal.add(vecRec);
				}

				hshValues.put("vecVal", vecVal);
				if (rs != null) {
					rs.close();
				}
				
				int ratingcnt=0;
				rs=DBUtils.executeLAPSQuery("sel_countofratingCode");
				if(rs.next())
				{
					ratingcnt=Integer.parseInt(Helper.correctInt((String)rs.getString(1)));
				}
				hshValues.put("prdNoOfRatingDescription", String.valueOf(ratingcnt));
				
				vecRec = new ArrayList();
				vecVal = new ArrayList();
				strQuery=SQLParser.getSqlQuery("corpprd_interest_limit_selectByAmountId^" + id + "^"+"1");
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) 
				{
					vecRec = new ArrayList();
					if(ratingcnt>0){
					vecRec.add(correctNull(rs.getString("corpprd_termfrom"))); //0
					vecRec.add(correctNull(rs.getString("corpprd_termto"))); //1
					vecRec.add(correctNull(rs.getString("corpprd_baserate")));//2
					vecRec.add(correctNull(rs.getString("corpprd_intid")));//3
					
					vecVal.add(vecRec);
					}
				}
				hshValues.put("vecRatingRoi1", vecVal);
				if (rs != null) {
					rs.close();
				}
				vecRec = new ArrayList();
				vecVal = new ArrayList();
				strQuery=SQLParser.getSqlQuery("corpprd_interest_limit_selectByAmountId^" + id + "^"+"2");
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) 
				{
					vecRec = new ArrayList();
					if(ratingcnt>0){
					vecRec.add(correctNull(rs.getString("corpprd_termfrom"))); //0
					vecRec.add(correctNull(rs.getString("corpprd_termto"))); //1
					vecRec.add(correctNull(rs.getString("corpprd_baserate")));//2
					vecRec.add(correctNull(rs.getString("corpprd_intid")));//3
					
					vecVal.add(vecRec);
					}
				}
				hshValues.put("vecRatingRoi2", vecVal);
				if (rs != null) {
					rs.close();
				}
				vecRec = new ArrayList();
				vecVal = new ArrayList();
				strQuery=SQLParser.getSqlQuery("corpprd_interest_limit_selectByAmountId^" + id + "^"+"3");
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) 
				{
					vecRec = new ArrayList();
					if(ratingcnt>0){
					vecRec.add(correctNull(rs.getString("corpprd_termfrom"))); //0
					vecRec.add(correctNull(rs.getString("corpprd_termto"))); //1
					vecRec.add(correctNull(rs.getString("corpprd_baserate")));//2
					vecRec.add(correctNull(rs.getString("corpprd_intid")));//3
					
					vecVal.add(vecRec);
					}
				}
				if (rs != null) {
					rs.close();
				}
				hshValues.put("vecRatingRoi3", vecVal);
				if (rs != null) {
					rs.close();
				}
				vecRec = new ArrayList();
				vecVal = new ArrayList();
				strQuery=SQLParser.getSqlQuery("corpprd_interest_limit_selectByAmountId^" + id + "^"+"4");
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) 
				{
					vecRec = new ArrayList();
					if(ratingcnt>0){
					vecRec.add(correctNull(rs.getString("corpprd_termfrom"))); //0
					vecRec.add(correctNull(rs.getString("corpprd_termto"))); //1
					vecRec.add(correctNull(rs.getString("corpprd_baserate")));//2
					vecRec.add(correctNull(rs.getString("corpprd_intid")));//3
					
					vecVal.add(vecRec);
					}
				}
				hshValues.put("vecRatingRoi4", vecVal);
				if (rs != null) {
					rs.close();
				}
				vecRec = new ArrayList();
				vecVal = new ArrayList();
				strQuery=SQLParser.getSqlQuery("corpprd_interest_limit_selectByAmountId^" + id + "^"+"5");
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) 
				{
					vecRec = new ArrayList();
					if(ratingcnt>0){
					vecRec.add(correctNull(rs.getString("corpprd_termfrom"))); //0
					vecRec.add(correctNull(rs.getString("corpprd_termto"))); //1
					vecRec.add(correctNull(rs.getString("corpprd_baserate")));//2
					vecRec.add(correctNull(rs.getString("corpprd_intid")));//3
					
					vecVal.add(vecRec);
					}
				}
				hshValues.put("vecRatingRoi5", vecVal);
			
				hshValues.put("selindtype",hsh.get("sel_indtype"));
				hshValues.put("selinttype",hsh.get("sel_inttype"));
			}
			if ((val.equals("show_terms"))) {
			
				id = (String) hsh.get("ruleid");
				
				if(rs!=null)
				{
					rs.close();
				}
				rs = DBUtils.executeLAPSQuery("corpruleresult^" + id+"^"+strPrdcode+"^"+strAmtfrom+"^"+strAmtto);
				while (rs.next()) {
					vecRec = new ArrayList();
					vecRec.add(correctNull(rs.getString("corpprd_termfrom")));
					vecRec.add(correctNull(rs.getString("corpprd_termto")));
					vecRec.add(correctNull(rs.getString("corpprd_baserate")));
					vecRec.add(correctNull(rs.getString("corpprd_adjust")));
					vecRec.add(correctNull(rs.getString("corpprd_interest")));
					vecRec.add(correctNull(rs.getString("corpprd_interestid")));
					vecRec.add(correctNull(rs.getString("corpprd_adjust1")));
					vecRec.add(correctNull(rs.getString("corpprd_interest1")));
					vecRec.add(correctNull(rs.getString("corpprd_tablecodegen")));
					vecRec.add(correctNull(rs.getString("corpprd_tablecode")));
					if(Helper.correctNull(rs.getString("corpprd_creditrskpremium")).equalsIgnoreCase(""))
						vecRec.add("");
					else
						vecRec.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("corpprd_creditrskpremium")))));
					if(Helper.correctNull(rs.getString("corpprd_busstrategicpremium")).equalsIgnoreCase(""))
						vecRec.add("");
					else
						vecRec.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("corpprd_busstrategicpremium")))));
					vecVal.add(vecRec);
				}
				hshValues.put("vecVal", vecVal);
				
				strQuery=SQLParser.getSqlQuery("corpindandinttype^"+strAmtfrom+"^"+strAmtto+"^"+fac_id+"^"+id);
				if(rs5!=null)
				{
					rs5.close();
				}
				rs5=DBUtils.executeQuery(strQuery);
				if(rs5.next())
				  {
					hshValues.put("corpprd_industrytype", Helper.correctNull((String)rs5.getString("corpprd_industrytype")));
					hshValues.put("corpprd_interesttype", Helper.correctNull((String)rs5.getString("corpprd_interesttype")));
				 }
				hshValues.put("rangefrom", hsh.get("amfrom"));
				hshValues.put("rangeto", hsh.get("amto"));
				hshValues.put("ruleid", hsh.get("ruleid"));
				hshValues.put("wrk_flowtype1", hsh.get("work"));
				hshValues.put("selindtype",hsh.get("sel_indtype"));
				
				
				
				if (rs != null) {
					rs.close();
				}
				int ratingcnt=0;
				rs=DBUtils.executeLAPSQuery("sel_countofratingCode");
				if(rs.next())
				{
					ratingcnt=Integer.parseInt(Helper.correctInt((String)rs.getString(1)));
				}
				hshValues.put("prdNoOfRatingDescription", String.valueOf(ratingcnt));
				vecRec = new ArrayList();
				vecVal = new ArrayList();
				strQuery=SQLParser.getSqlQuery("corpprd_interest_limit_selectByAmountId^" + id + "^"+"1");
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) 
				{
					vecRec = new ArrayList();
					if(ratingcnt>0){
						vecRec.add(correctNull(rs.getString("corpprd_termfrom"))); //0
						vecRec.add(correctNull(rs.getString("corpprd_termto"))); //1
						vecRec.add(correctNull(rs.getString("corpprd_baserate")));//2
						vecRec.add(correctNull(rs.getString("corpprd_intid")));//3
						vecVal.add(vecRec);
					}
				}
				hshValues.put("vecRatingRoi1", vecVal);
				if (rs != null) {
					rs.close();
				}
				vecRec = new ArrayList();
				vecVal = new ArrayList();
				strQuery=SQLParser.getSqlQuery("corpprd_interest_limit_selectByAmountId^" + id + "^"+"2");
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) 
				{
					vecRec = new ArrayList();
					if(ratingcnt>0){
					vecRec.add(correctNull(rs.getString("corpprd_termfrom"))); //0
					vecRec.add(correctNull(rs.getString("corpprd_termto"))); //1
					vecRec.add(correctNull(rs.getString("corpprd_baserate")));//2
					vecRec.add(correctNull(rs.getString("corpprd_intid")));//3
					vecVal.add(vecRec);
					}
				}
				hshValues.put("vecRatingRoi2", vecVal);
				if (rs != null) {
					rs.close();
				}
				vecRec = new ArrayList();
				vecVal = new ArrayList();
				strQuery=SQLParser.getSqlQuery("corpprd_interest_limit_selectByAmountId^" + id + "^"+"3");
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) 
				{
					vecRec = new ArrayList();
					if(ratingcnt>0){
					vecRec.add(correctNull(rs.getString("corpprd_termfrom"))); //0
					vecRec.add(correctNull(rs.getString("corpprd_termto"))); //1
					vecRec.add(correctNull(rs.getString("corpprd_baserate")));//2
					vecRec.add(correctNull(rs.getString("corpprd_intid")));//3
					
					vecVal.add(vecRec);
					}
				}
				if (rs != null) {
					rs.close();
				}
				hshValues.put("vecRatingRoi3", vecVal);
				if (rs != null) {
					rs.close();
				}
				vecRec = new ArrayList();
				vecVal = new ArrayList();
				strQuery=SQLParser.getSqlQuery("corpprd_interest_limit_selectByAmountId^" + id + "^"+"4");
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) 
				{
					vecRec = new ArrayList();
					if(ratingcnt>0){
					vecRec.add(correctNull(rs.getString("corpprd_termfrom"))); //0
					vecRec.add(correctNull(rs.getString("corpprd_termto"))); //1
					vecRec.add(correctNull(rs.getString("corpprd_baserate")));//2
					vecRec.add(correctNull(rs.getString("corpprd_intid")));//3
					
					vecVal.add(vecRec);
					}
				}
				hshValues.put("vecRatingRoi4", vecVal);
				if (rs != null) {
					rs.close();
				}
				vecRec = new ArrayList();
				vecVal = new ArrayList();
				strQuery=SQLParser.getSqlQuery("corpprd_interest_limit_selectByAmountId^" + id + "^"+"5");
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) 
				{
					vecRec = new ArrayList();
					if(ratingcnt>0){
					vecRec.add(correctNull(rs.getString("corpprd_termfrom"))); //0
					vecRec.add(correctNull(rs.getString("corpprd_termto"))); //1
					vecRec.add(correctNull(rs.getString("corpprd_baserate")));//2
					vecRec.add(correctNull(rs.getString("corpprd_intid")));//3
					
					vecVal.add(vecRec);}
				}
				hshValues.put("vecRatingRoi5", vecVal);
			}
			if (val.equals("show_indterms")) {
				
				hshValues.put("corpprd_interesttype", hsh.get("sel_inttype"));
				hshValues.put("rangefrom", hsh.get("amfrom"));
				hshValues.put("rangeto", hsh.get("amto"));
				hshValues.put("ruleid", hsh.get("ruleid"));
				hshValues.put("wrk_flowtype1", hsh.get("work"));
				hshValues.put("selindtype",hsh.get("sel_indtype"));
				hshValues.put("selinttype",hsh.get("sel_inttype"));
				
			
			}
			
			//rating required
			rs = DBUtils.executeLAPSQuery("setproductsselcorporate^"+ fac_id);
			if(rs.next())
			{
				hshValues.put("com_facRating",Helper.correctNull((String)rs.getString("com_facRating")));
			}
			hshValues.put("prd_saveflag",Helper.correctNull((String)hsh.get("prd_saveflag")));
			hshValues.put("sel_inttype",sel_inttype);
			
			if(rs!=null)
				rs.close();
			
			strQuery=SQLParser.getSqlQuery("chk_prdfac_spreaddetails^"+fac_id+"^A','C");
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshValues.put("strSpreadFlag","Y");
			}
			//end
		} catch (Exception e) {
			
			throw new EJBException(e.toString());
		} finally {
			try {

				if (rs != null) {
					rs.close();
				}
				hshQuery=null;
				arr=null;
				hshqueryval=null;
				arrValues=null;
				vecVal=null;
				vecRec=null;
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}
		}
		return hshValues;
	}
	public void deletecorpTerms(HashMap hshValues)  {

		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = null;
		try {
			hshQueryValues.put("size", "3");

			hshQuery = new HashMap();
			hshQuery.put("strQueryId", "delcorpprdintlimit");
			arrValues = new ArrayList();
			arrValues.add(hshValues.get("select_rule"));
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);

			hshQuery = new HashMap();
			hshQuery.put("strQueryId", "delcorpprdintmaster");
			arrValues = new ArrayList();
			arrValues.add(hshValues.get("select_rule"));
			arrValues.add(hshValues.get("fac_id"));
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("2", hshQuery);
			
			hshQuery = new HashMap();
			hshQuery.put("strQueryId", "del_ratingROIforfacility");
			arrValues = new ArrayList();
			arrValues.add(hshValues.get("select_rule"));
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("3", hshQuery);

			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
					"updateData");
		} catch (Exception ce) {
			log.error("in bean... " + ce);
			throw new EJBException("Error in updateData " + ce.toString());
		}
		finally{
			hshQueryValues=null;
			arrValues=null;
			hshQuery=null;
		}

	}
	private void updateRatingBasedRoiCorporate(HashMap hsh, String id) 
	{
		String[] strfrom5 = null,strfrom1 = null,strfrom2 = null,strfrom3= null,strfrom4 = null;
		String[] strto1 = null,strto2 = null,strto3 = null,strto4 = null,strto5 = null;
		String[] total1 = null,total2 = null,total3 = null,total4 = null,total5 = null;
		String[] ratingtotal1 = null,ratingtotal2 = null,ratingtotal3 = null,ratingtotal4 = null,ratingtotal5 = null;
		String[] baserate1 = null,baserate2 = null,baserate3 = null,baserate4 = null,baserate5 = null;
		String[] adjust1 = null,adjust2 = null,adjust3 = null,adjust4 = null,adjust5 = null;
		String[] ratingadjust1 = null,ratingadjust2 = null,ratingadjust3 = null,ratingadjust4 = null,ratingadjust5 = null;
		String[] interest1 = null,interest2 = null,interest3 = null,interest4 = null,interest5 = null;
		String[] tenorrate1=null,tenorrate2=null,tenorrate3=null,tenorrate4=null,tenorrate5=null;
		String[] strRatingsno1=null,strRatingsno2=null,strRatingsno3=null,strRatingsno4=null,strRatingsno5=null;
		String[] strRatingdesc1=null,strRatingdesc2=null,strRatingdesc3=null,strRatingdesc4=null,strRatingdesc5=null;
		String[] strTableCode1=null,strTableCode2=null,strTableCode3=null,strTableCode4=null,strTableCode5=null;
		
		String[] facility_adjust = (String[])hsh.get("adjust");;
		String[] facility_total =(String[])hsh.get("total");
		String[] strTableCodegen=(String[])hsh.get("tablecode_gen");
		
		
		String wrk_flowtype1=Helper.correctNull((String)hsh.get("wrk_flowtype1"));
		HashMap hshqueryval = new HashMap();
		HashMap hshQuery;
		ArrayList arrValues = new ArrayList();
		int intUpdatesize=0;
		
		String[] str_From  = (String[])hsh.get("from");
		String[] str_To  = (String[])hsh.get("to");
		
		
		//for first row
		strfrom1 = (String[]) hsh.get("hidroi_from1");
		strto1 = (String[]) hsh.get("hidroi_to1");
		total1 = (String[]) hsh.get("hidroi_total1");
		baserate1 = (String[]) hsh.get("hidroi_baserate1");
		adjust1 = (String[]) hsh.get("hidroi_adjust1");
		interest1 = (String[]) hsh.get("hidroi_interestid1");
		strRatingsno1 = (String[]) hsh.get("hidroi_ratingsno1");
		strRatingdesc1 = (String[]) hsh.get("hidroi_ratingdesc1");
		strTableCode1 = (String[]) hsh.get("hidroi_tablecode1");
		ratingadjust1 = (String[]) hsh.get("hidroi_ratingadj1");
		ratingtotal1 = (String[]) hsh.get("hidroi_ratingtot1");
		
		//second
		strfrom2 = (String[]) hsh.get("hidroi_from2");
		strto2 = (String[]) hsh.get("hidroi_to2");
		total2 = (String[]) hsh.get("hidroi_total2");
		baserate2 = (String[]) hsh.get("hidroi_baserate2");
		adjust2= (String[]) hsh.get("hidroi_adjust2");
		interest2 = (String[]) hsh.get("hidroi_interestid2");
		strRatingsno2 = (String[]) hsh.get("hidroi_ratingsno2");
		strRatingdesc2 = (String[]) hsh.get("hidroi_ratingdesc2");
		strTableCode2 = (String[]) hsh.get("hidroi_tablecode2");
		ratingadjust2 = (String[]) hsh.get("hidroi_ratingadj2");
		ratingtotal2 = (String[]) hsh.get("hidroi_ratingtot2");

		//third
		strfrom3 = (String[]) hsh.get("hidroi_from3");
		strto3 = (String[]) hsh.get("hidroi_to3");
		total3 = (String[]) hsh.get("hidroi_total3");
		baserate3 = (String[]) hsh.get("hidroi_baserate3");
		adjust3 = (String[]) hsh.get("hidroi_adjust3");
		interest3 = (String[]) hsh.get("hidroi_interestid3");
		strRatingsno3 = (String[]) hsh.get("hidroi_ratingsno3");
		strRatingdesc3 = (String[]) hsh.get("hidroi_ratingdesc3");
		strTableCode3 = (String[]) hsh.get("hidroi_tablecode3");
		ratingadjust3 = (String[]) hsh.get("hidroi_ratingadj3");
		ratingtotal3 = (String[]) hsh.get("hidroi_ratingtot3");

		//fourth
		strfrom4 = (String[]) hsh.get("hidroi_from4");
		strto4 = (String[]) hsh.get("hidroi_to4");
		total4 = (String[]) hsh.get("hidroi_total4");
		baserate4 = (String[]) hsh.get("hidroi_baserate4");
		adjust4 = (String[]) hsh.get("hidroi_adjust4");
		interest4 = (String[]) hsh.get("hidroi_interestid4");
		strRatingsno4 = (String[]) hsh.get("hidroi_ratingsno4");
		strRatingdesc4 = (String[]) hsh.get("hidroi_ratingdesc4");
		strTableCode4 = (String[]) hsh.get("hidroi_tablecode4");
		ratingadjust4 = (String[]) hsh.get("hidroi_ratingadj4");
		ratingtotal4 = (String[]) hsh.get("hidroi_ratingtot4");

		//fifth
		strfrom5 = (String[]) hsh.get("hidroi_from5");
		strto5 = (String[]) hsh.get("hidroi_to5");
		total5 = (String[]) hsh.get("hidroi_total5");
		baserate5 = (String[]) hsh.get("hidroi_baserate5");
		adjust5 = (String[]) hsh.get("hidroi_adjust5");
		interest5 = (String[]) hsh.get("hidroi_interestid5");
		strRatingsno5 = (String[]) hsh.get("hidroi_ratingsno5");
		strRatingdesc5 = (String[]) hsh.get("hidroi_ratingdesc5");
		strTableCode5 = (String[]) hsh.get("hidroi_tablecode5");
		ratingadjust5 = (String[]) hsh.get("hidroi_ratingadj5");
		ratingtotal5 = (String[]) hsh.get("hidroi_ratingtot5");

		try
		{
			//for first row
			hshQuery = new HashMap();
			hshqueryval = new HashMap();
			arrValues = new ArrayList();
			int num = 0;
			num = 0;intUpdatesize=0;
			for (int k = 0; k < strfrom1.length ; k++) 
			{
				if (!strfrom1[k].equals("")) 
				{
					num = num + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize = intUpdatesize + 1;
					//corpprd_intid,corpprd_sno,corpprd_termfrom,corpprd_termto,corpprd_baserate,
					//corpprd_adjust,corpprd_interest,corpprd_interestid,corpprd_adjust1,corpprd_interest1,corpprd_indtype
					hshQuery.put("strQueryId", "corpintins");
					arrValues.add(id); //Key that maps amount table
					arrValues.add("1"); //Sno of first row
					arrValues.add(correctNull(str_From[0]));
					arrValues.add(correctNull(str_To[0]));
					if(!baserate1[k].equalsIgnoreCase(""))
						arrValues.add(correctNull(baserate1[k]));
					else
						arrValues.add("0.00");
					if(!facility_adjust[0].equalsIgnoreCase(""))
						arrValues.add(correctNull(facility_adjust[0]));
					else
						arrValues.add("0.00");
					if(!facility_total[0].equalsIgnoreCase(""))
						arrValues.add(correctNull(facility_total[0]));
					else
						arrValues.add("0.00");
					if(!interest1[k].equalsIgnoreCase(""))
					{
						arrValues.add(correctNull(interest1[k]));
					}
					else
					{
						arrValues.add("0.00");
					}
					if(!ratingadjust1[k].equalsIgnoreCase(""))
						arrValues.add(correctNull(ratingadjust1[k]));
					else
						arrValues.add("0.00");
					if(!ratingtotal1[k].equalsIgnoreCase(""))
						arrValues.add(correctNull(ratingtotal1[k]));
					else
						arrValues.add("0.00");
					
					
					arrValues.add(correctNull(strRatingsno1[k]));
					arrValues.add(correctNull(strRatingdesc1[k]));
					arrValues.add(correctNull(strTableCodegen[0]));
					arrValues.add(correctNull(strTableCode1[k]));
					arrValues.add("0.00");
					arrValues.add("0.00");
					hshQuery.put("arrValues", arrValues);
					hshqueryval
							.put("size", Integer.toString(intUpdatesize));
					hshqueryval.put(Integer.toString(k+1), hshQuery);
				}
			}
			if(num!=0)
			{
			
			EJBInvoker.executeStateLess("dataaccess", hshqueryval,
					"updateData");
			}
			
			//for second row
			
			hshQuery = new HashMap();
			hshqueryval = new HashMap();
			arrValues = new ArrayList();
			num = 0;intUpdatesize=0;
			for (int k = 0; k < strfrom2.length; k++) 
			{
				if (!strfrom2[k].equals("")) 
				{
					num = num + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize = intUpdatesize + 1;
					hshQuery.put("strQueryId", "corpintins");
					arrValues.add(id); //Key that maps amount table
					arrValues.add("2"); //Sno of second row
					arrValues.add(correctNull(str_From[1]));
					arrValues.add(correctNull(str_To[1]));
					if(!baserate2[k].equalsIgnoreCase(""))
						arrValues.add(correctNull(baserate2[k]));
					else
						arrValues.add("0.00");
					if(!facility_adjust[1].equalsIgnoreCase(""))
						arrValues.add(correctNull(facility_adjust[1]));
					else
						arrValues.add("0.00");
					if(!facility_total[1].equalsIgnoreCase(""))
						arrValues.add(correctNull(facility_total[1]));
					else
						arrValues.add("0.00");
					if(!interest2[k].equalsIgnoreCase(""))
					{
						arrValues.add(correctNull(interest2[k]));
					}
					else
					{
						arrValues.add("0.00");
					}
					if(!ratingadjust2[k].equalsIgnoreCase(""))
						arrValues.add(correctNull(ratingadjust2[k]));
					else
						arrValues.add("0.00");
					if(!ratingtotal2[k].equalsIgnoreCase(""))
						arrValues.add(correctNull(ratingtotal2[k]));
					else
						arrValues.add("0.00");
					arrValues.add(correctNull(strRatingsno2[k]));
					arrValues.add(correctNull(strRatingdesc2[k]));
					arrValues.add(correctNull(strTableCodegen[1]));
					arrValues.add(correctNull(strTableCode2[k]));
					arrValues.add("0.00");
					arrValues.add("0.00");
					hshQuery.put("arrValues", arrValues);
					hshqueryval
							.put("size", Integer.toString(intUpdatesize));
					hshqueryval.put(Integer.toString(k+1), hshQuery);
				}
			}
			if(num!=0)
			{
				EJBInvoker.executeStateLess("dataaccess", hshqueryval,
					"updateData");
			}
			
			//for third row
			
			hshQuery = new HashMap();
			hshqueryval = new HashMap();
			arrValues = new ArrayList();
			num = 0;intUpdatesize=0;
			for (int k = 0; k < strfrom3.length; k++) 
			{
				if (!strfrom3[k].equals("")) 
				{
					num = num + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize = intUpdatesize + 1;
					hshQuery.put("strQueryId", "corpintins");
					arrValues.add(id); //Key that maps amount table
					arrValues.add("3"); //Sno of third row
					arrValues.add(correctNull(str_From[2]));
					arrValues.add(correctNull(str_To[2]));
					if(!baserate3[k].equalsIgnoreCase(""))
						arrValues.add(correctNull(baserate3[k]));
					else
						arrValues.add("0.00");
					if(!facility_adjust[2].equalsIgnoreCase(""))
						arrValues.add(correctNull(facility_adjust[2]));
					else
						arrValues.add("0.00");
					if(!facility_total[2].equalsIgnoreCase(""))
						arrValues.add(correctNull(facility_total[2]));
					else
						arrValues.add("0.00");
					if(!interest3[k].equalsIgnoreCase(""))
					{
						arrValues.add(correctNull(interest3[k]));
					}
					else
					{
						arrValues.add("0.00");
					}
					if(!ratingadjust3[k].equalsIgnoreCase(""))
						arrValues.add(correctNull(ratingadjust3[k]));
					else
						arrValues.add("0.00");
					if(!ratingtotal3[k].equalsIgnoreCase(""))
						arrValues.add(correctNull(ratingtotal3[k]));
					else
						arrValues.add("0.00");
					arrValues.add(correctNull(strRatingsno3[k]));
					arrValues.add(correctNull(strRatingdesc3[k]));
					arrValues.add(correctNull(strTableCodegen[2]));
					arrValues.add(correctNull(strTableCode3[k]));
					arrValues.add("0.00");
					arrValues.add("0.00");
					hshQuery.put("arrValues", arrValues);
					hshqueryval
							.put("size", Integer.toString(intUpdatesize));
					hshqueryval.put(Integer.toString(k+1), hshQuery);
				}
			}
			if(num!=0)
			{
				EJBInvoker.executeStateLess("dataaccess", hshqueryval,
					"updateData");
			}
			//for fourth row
			
			hshQuery = new HashMap();
			hshqueryval = new HashMap();
			arrValues = new ArrayList();
			num = 0;intUpdatesize=0;
			for (int k = 0; k < strfrom4.length; k++) 
			{
				if (!strfrom4[k].equals("")) 
				{
					num = num + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize = intUpdatesize + 1;
					hshQuery.put("strQueryId", "corpintins");
					arrValues.add(id); //Key that maps amount table
					arrValues.add("4"); //Sno of fourth row
					arrValues.add(correctNull(str_From[3]));
					arrValues.add(correctNull(str_To[3]));
					if(!baserate4[k].equalsIgnoreCase(""))
						arrValues.add(correctNull(baserate4[k]));
					else
						arrValues.add("0.00");
					if(!facility_adjust[3].equalsIgnoreCase(""))
						arrValues.add(correctNull(facility_adjust[3]));
					else
						arrValues.add("0.00");
					if(!facility_total[3].equalsIgnoreCase(""))
						arrValues.add(correctNull(facility_total[3]));
					else
						arrValues.add("0.00");
					if(!interest4[k].equalsIgnoreCase(""))
					{
						arrValues.add(correctNull(interest4[k]));
					}
					else
					{
						arrValues.add("0.00");
					}
					if(!ratingadjust4[k].equalsIgnoreCase(""))
						arrValues.add(correctNull(ratingadjust4[k]));
					else
						arrValues.add("0.00");
					if(!ratingtotal4[k].equalsIgnoreCase(""))
						arrValues.add(correctNull(ratingtotal4[k]));
					else
						arrValues.add("0.00");
					arrValues.add(correctNull(strRatingsno4[k]));
					arrValues.add(correctNull(strRatingdesc4[k]));
					arrValues.add(correctNull(strTableCodegen[3]));
					arrValues.add(correctNull(strTableCode4[k]));
					arrValues.add("0.00");
					arrValues.add("0.00");
					hshQuery.put("arrValues", arrValues);
					hshqueryval
							.put("size", Integer.toString(intUpdatesize));
					hshqueryval.put(Integer.toString(k+1), hshQuery);
				}
			}
			if(num!=0)
			{
				EJBInvoker.executeStateLess("dataaccess", hshqueryval,
					"updateData");
			}
			//for fifth row
			
			hshQuery = new HashMap();
			hshqueryval = new HashMap();
			arrValues = new ArrayList();
			num = 0;intUpdatesize=0;
			for (int k = 0; k < strfrom5.length; k++) 
			{
				if (!strfrom5[k].equals("")) 
				{
					num = num + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize = intUpdatesize + 1;
					hshQuery.put("strQueryId", "corpintins");
					arrValues.add(id); //Key that maps amount table
					arrValues.add("5"); //Sno of fifth row
					arrValues.add(correctNull(str_From[4]));
					arrValues.add(correctNull(str_To[4]));
					if(!baserate5[k].equalsIgnoreCase(""))
						arrValues.add(correctNull(baserate5[k]));
					else
						arrValues.add("0.00");
					if(!facility_adjust[4].equalsIgnoreCase(""))
						arrValues.add(correctNull(facility_adjust[4]));
					else
						arrValues.add("0.00");
					if(!facility_total[4].equalsIgnoreCase(""))
						arrValues.add(correctNull(facility_total[4]));
					else
						arrValues.add("0.00");
					if(!interest5[k].equalsIgnoreCase(""))
					{
						arrValues.add(correctNull(interest5[k]));
					}
					else
					{
						arrValues.add("0.00");
					}
					if(!ratingadjust5[k].equalsIgnoreCase(""))
						arrValues.add(correctNull(ratingadjust5[k]));
					else
						arrValues.add("0.00");
					if(!ratingtotal5[k].equalsIgnoreCase(""))
						arrValues.add(correctNull(ratingtotal5[k]));
					else
						arrValues.add("0.00");
					arrValues.add(correctNull(strRatingsno5[k]));
					arrValues.add(correctNull(strRatingdesc5[k]));
					arrValues.add(correctNull(strTableCodegen[4]));
					arrValues.add(correctNull(strTableCode5[k]));
					arrValues.add("0.00");
					arrValues.add("0.00");
					hshQuery.put("arrValues", arrValues);
					hshqueryval
							.put("size", Integer.toString(intUpdatesize));
					hshqueryval.put(Integer.toString(k+1), hshQuery);
				}
			}
			if(num!=0)
			{
				EJBInvoker.executeStateLess("dataaccess", hshqueryval,
					"updateData");
			}
		}
		catch (Exception e) 
		{
			//Logger.log("in bean" + e);
			throw new EJBException("Exception in updateRatingBasedRoiCorporate"+e.toString());
		} 
		
	}
	private void updateInterestCorpData(HashMap hshValues,String id) 
	{
		HashMap hshQueryVal=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues = new ArrayList();
		int intUpdatesize=0;
		StringBuilder sbAuditTrial=new StringBuilder();
		StringBuilder sbOldAudit = new StringBuilder();
		ResultSet rs=null;
		String strQuery="";
		try
		{
			String[] str_From  = (String[])hshValues.get("from");
			String[] str_To  = (String[])hshValues.get("to");
			String[] facility_adjust = (String[])hshValues.get("adjust");;
			String[] facility_total =(String[])hshValues.get("total");
			String[] baserate =(String[])hshValues.get("baserate");
			String[] interest =(String[])hshValues.get("interestid");
			String[] strCRPVal =(String[])hshValues.get("txtcreditrskpremium");
			String[] strBSPVal =(String[])hshValues.get("txtbustratpremium");
			String strAmtRangeFrom=Helper.correctNull((String)hshValues.get("amtfrom"));
			String strAmtRangeTo=Helper.correctNull((String)hshValues.get("amtto"));
			hshQueryVal = new HashMap();
			String strPrdcode=Helper.correctNull((String) hshValues.get("fac_id1"));
			sbOldAudit=(StringBuilder)hshValues.get("sbOldAudit");
			// First Row
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			intUpdatesize = intUpdatesize + 1;
			hshQuery.put("strQueryId", "corpintins");
			arrValues.add(id);
			arrValues.add("1");
			arrValues.add(correctNull(str_From[0]));
			arrValues.add(correctNull(str_To[0]));
			arrValues.add(correctNull(baserate[0]));
			arrValues.add(correctNull(facility_adjust[0]));
			arrValues.add(correctNull(facility_total[0]));
			arrValues.add(correctNull(interest[0]));
			arrValues.add("0.00");
			arrValues.add("0.00");
			arrValues.add(correctNull(""));
			arrValues.add(correctNull(""));
			arrValues.add(correctNull(""));
			arrValues.add(correctNull(""));
			arrValues.add(strCRPVal[0]);
			arrValues.add(strBSPVal[0]);
			hshQuery.put("arrValues", arrValues);
			hshQueryVal.put(Integer.toString(intUpdatesize), hshQuery);

			// Second Row
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			intUpdatesize = intUpdatesize + 1;
			hshQuery.put("strQueryId", "corpintins");
			arrValues.add(id);
			arrValues.add("2");
			arrValues.add(correctNull(str_From[1]));
			arrValues.add(correctNull(str_To[1]));
			arrValues.add(correctNull(baserate[1]));
			arrValues.add(correctNull(facility_adjust[1]));
			arrValues.add(correctNull(facility_total[1]));
			arrValues.add(correctNull(interest[1]));
			arrValues.add("0.00");
			arrValues.add("0.00");
			arrValues.add(correctNull(""));
			arrValues.add(correctNull(""));
			arrValues.add(correctNull(""));
			arrValues.add(correctNull(""));
			arrValues.add(strCRPVal[1]);
			arrValues.add(strBSPVal[1]);
			hshQuery.put("arrValues", arrValues);
			hshQueryVal.put(Integer.toString(intUpdatesize), hshQuery);
			
			// Third Row
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			intUpdatesize = intUpdatesize + 1;
			hshQuery.put("strQueryId", "corpintins");
			arrValues.add(id);
			arrValues.add("3");
			arrValues.add(correctNull(str_From[2]));
			arrValues.add(correctNull(str_To[2]));
			arrValues.add(correctNull(baserate[2]));
			arrValues.add(correctNull(facility_adjust[2]));
			arrValues.add(correctNull(facility_total[2]));
			arrValues.add(correctNull(interest[2]));
			arrValues.add("0.00");
			arrValues.add("0.00");
			arrValues.add(correctNull(""));
			arrValues.add(correctNull(""));
			arrValues.add(correctNull(""));
			arrValues.add(correctNull(""));
			arrValues.add(strCRPVal[2]);
			arrValues.add(strBSPVal[2]);
			hshQuery.put("arrValues", arrValues);
			hshQueryVal.put(Integer.toString(intUpdatesize), hshQuery);
			
			// Fourth Row
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			intUpdatesize = intUpdatesize + 1;
			hshQuery.put("strQueryId", "corpintins");
			arrValues.add(id);
			arrValues.add("4");
			arrValues.add(correctNull(str_From[3]));
			arrValues.add(correctNull(str_To[3]));
			arrValues.add(correctNull(baserate[3]));
			arrValues.add(correctNull(facility_adjust[3]));
			arrValues.add(correctNull(facility_total[3]));
			arrValues.add(correctNull(interest[3]));
			arrValues.add("0.00");
			arrValues.add("0.00");
			arrValues.add(correctNull(""));
			arrValues.add(correctNull(""));
			arrValues.add(correctNull(""));
			arrValues.add(correctNull(""));
			arrValues.add(strCRPVal[3]);
			arrValues.add(strBSPVal[3]);
			hshQuery.put("arrValues", arrValues);
			hshQueryVal.put(Integer.toString(intUpdatesize), hshQuery);
			// Fifth Row
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			intUpdatesize = intUpdatesize + 1;
			hshQuery.put("strQueryId", "corpintins");
			arrValues.add(id);
			arrValues.add("5");
			arrValues.add(correctNull(str_From[4]));
			arrValues.add(correctNull(str_To[4]));
			arrValues.add(correctNull(baserate[4]));
			arrValues.add(correctNull(facility_adjust[4]));
			arrValues.add(correctNull(facility_total[4]));
			arrValues.add(correctNull(interest[4]));
			arrValues.add("0.00");
			arrValues.add("0.00");
			arrValues.add(correctNull(""));
			arrValues.add(correctNull(""));
			arrValues.add(correctNull(""));
			arrValues.add(correctNull(""));
			arrValues.add(strCRPVal[4]);
			arrValues.add(strBSPVal[4]);
			hshQuery.put("arrValues", arrValues);
			hshQueryVal.put(Integer.toString(intUpdatesize), hshQuery);
			hshQueryVal.put("size", Integer.toString(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryVal,"updateData");
			
			

			//delete rating based Roi for that Interest ID //
			hshQuery = new HashMap();
			hshQueryVal=new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "del_ratingROIforfacility");
			arrValues.add(id);
			hshQuery.put("arrValues", arrValues);
			hshQueryVal.put("size", "1");
			hshQueryVal.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryVal,"updateData");
			//end//
			
			/***
			 * For Audit Trial New Data - By Karthikeyan.S on 10/10/2013
			 */
			String strPageFrom=Helper.correctNull((String)hshValues.get("wrk_flowtype1"));
			String strPageDesc="";
			if(strPageFrom.equalsIgnoreCase("fixed"))
			{
				strPageDesc="Fixed Rate";
			}
			else if(strPageFrom.equalsIgnoreCase("floating"))
			{
				strPageDesc="Floating";
			}
			sbAuditTrial
			.append("~Interest Type=").append(strPageDesc)
			.append("~Amount Range From=").append(strAmtRangeFrom)
			.append("~Amount Range To=").append(strAmtRangeTo)
			.append("~S.No=").append("1")
			.append("~Loan Period From=").append(Helper.correctNull((String)str_From[0]))
			.append("~Loan Period To=").append(Helper.correctNull((String)str_To[0]))
			.append("~Reference Rate=").append(Helper.correctNull((String)baserate[0]))
			.append("~Adjustments (+/-)=").append(Helper.correctNull((String)facility_adjust[0]))
			.append("~Interest Rate (%)=").append(Helper.correctNull((String)facility_total[0]))
			.append("~Credit Risk Premium=").append(Helper.correctNull((String)strCRPVal[0]))
			.append("~Business strategic Premium=").append(Helper.correctNull((String)strBSPVal[0]))
			.append("~S.No=").append("2")
			.append("~Loan Period From=").append(Helper.correctNull((String)str_From[1]))
			.append("~Loan Period To=").append(Helper.correctNull((String)str_To[1]))
			.append("~Reference Rate=").append(Helper.correctNull((String)baserate[1]))
			.append("~Adjustments (+/-)=").append(Helper.correctNull((String)facility_adjust[1]))
			.append("~Interest Rate (%)=").append(Helper.correctNull((String)facility_total[1]))
			.append("~Credit Risk Premium=").append(Helper.correctNull((String)strCRPVal[1]))
			.append("~Business strategic Premium=").append(Helper.correctNull((String)strBSPVal[1]))
			.append("~S.No=").append("3")
			.append("~Loan Period From=").append(Helper.correctNull((String)str_From[2]))
			.append("~Loan Period To=").append(Helper.correctNull((String)str_To[2]))
			.append("~Reference Rate=").append(Helper.correctNull((String)baserate[2]))
			.append("~Adjustments (+/-)=").append(Helper.correctNull((String)facility_adjust[2]))
			.append("~Interest Rate (%)=").append(Helper.correctNull((String)facility_total[2]))
			.append("~Credit Risk Premium=").append(Helper.correctNull((String)strCRPVal[2]))
			.append("~Business strategic Premium=").append(Helper.correctNull((String)strBSPVal[2]))
			.append("~S.No=").append("4")
			.append("~Loan Period From=").append(Helper.correctNull((String)str_From[3]))
			.append("~Loan Period To=").append(Helper.correctNull((String)str_To[3]))
			.append("~Reference Rate=").append(Helper.correctNull((String)baserate[3]))
			.append("~Adjustments (+/-)=").append(Helper.correctNull((String)facility_adjust[3]))
			.append("~Interest Rate (%)=").append(Helper.correctNull((String)facility_total[3]))
			.append("~Credit Risk Premium=").append(Helper.correctNull((String)strCRPVal[3]))
			.append("~Business strategic Premium=").append(Helper.correctNull((String)strBSPVal[3]))
			.append("~S.No=").append("5")
			.append("~Loan Period From=").append(Helper.correctNull((String)str_From[4]))
			.append("~Loan Period To=").append(Helper.correctNull((String)str_To[4]))
			.append("~Reference Rate=").append(Helper.correctNull((String)baserate[4]))
			.append("~Adjustments (+/-)=").append(Helper.correctNull((String)facility_adjust[4]))
			.append("~Interest Rate (%)=").append(Helper.correctNull((String)facility_total[4]))
			.append("~Credit Risk Premium=").append(Helper.correctNull((String)strCRPVal[4]))
			.append("~Business strategic Premium=").append(Helper.correctNull((String)strBSPVal[4]));
			/***
			 * End - Audit Trial New Data
			 */
			AuditTrial.auditNewLog(hshValues,"104",strPrdcode,sbAuditTrial.toString(),sbOldAudit.toString());
		}
		catch (Exception e) 
		{
			throw new EJBException("Exception in updateInterestCorpData"+e.toString());
		} 
	}	
	public HashMap getCorporateRatings(HashMap hsh)  
	{
		HashMap hshResult =  new HashMap();
		ArrayList arrRatingDesc =  new ArrayList();
		ArrayList arrRatingSno =  new ArrayList();
		ResultSet rs = null;
		String strScoringPattern = Helper.correctNull((String)hsh.get("scoringpattern"));
		String strAmountSno = Helper.correctNull((String)hsh.get("varRuleId")); //amount wise serial no
		String strTenorSno = Helper.correctNull((String)hsh.get("slno")); //Tenor wise serial no
		int intTenorSno =0;
		if(strTenorSno!="")
		{
			intTenorSno = Integer.parseInt(strTenorSno)+1;
		}
		
		try
		{
			rs = DBUtils.executeLAPSQuery("sel_ratingCode");
			while(rs.next()) 
			{
				arrRatingDesc.add(Helper.correctNull((String)rs.getString(2)));
				arrRatingSno.add(Helper.correctNull((String)rs.getString(1)));
			}
			if(rs!=null)
			{
				 rs.close();
			}
			if(rs!=null)
			{
				 rs.close();
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateData "+ce.toString());
		}
		hshResult.put("arrRatingDesc", arrRatingDesc);
		hshResult.put("arrRatingSno", arrRatingSno);
		hshResult.put("score", strScoringPattern);

		return hshResult;
	}
	public HashMap getratingBasedROI(HashMap hshValues)  
	{
		HashMap hshResult =  new HashMap();
		ArrayList arrRatingDesc =  new ArrayList();
		ArrayList arrRatingSno =  new ArrayList();
		ResultSet rs = null;
		String strScoringPattern = Helper.correctNull((String)hshValues.get("scoringpattern"));
		String strAmountSno = Helper.correctNull((String)hshValues.get("varRuleId")); //amount wise serial no
		String strTenorSno = Helper.correctNull((String)hshValues.get("slno")); //Tenor wise serial no
		String strslno=Helper.correctNull((String)hshValues.get("slno"));
		String strSector=Helper.correctNull((String)hshValues.get("sel_sector"));
		String strIntId=Helper.correctNull((String)hshValues.get("interest_id"));
		ArrayList arrcol=new ArrayList();
		ArrayList arrratingvalues=new ArrayList();
		String strrefrate=Helper.correctNull((String)hshValues.get("ref_rate"));
		try
		{
			rs = DBUtils.executeLAPSQuery("sel_ratingCode");
			while(rs.next()) 
			{
				arrRatingDesc.add(Helper.correctNull((String)rs.getString(2)));
				arrRatingSno.add(Helper.correctNull((String)rs.getString(1)));
			}
			if(rs!=null)
			{ rs.close();}
			
			arrratingvalues=new ArrayList();
			rs = DBUtils.executeLAPSQuery("sel_ratingROI^"+strIntId+"^"+String.valueOf(Integer.parseInt(strslno)+1)+"^"+strSector);
			while(rs.next()) 
			{
				arrcol=new ArrayList();
				arrcol.add(Helper.correctNull((String)rs.getString("roi_intid")));
				arrcol.add(Helper.correctNull((String)rs.getString("roi_intsno")));
				arrcol.add(Helper.correctNull((String)rs.getString("roi_ratingcode")));
				arrcol.add(Helper.correctNull((String)rs.getString("roi_baserate")));
				arrcol.add(Helper.correctNull((String)rs.getString("roi_adjust")));
				arrcol.add(Helper.correctNull((String)rs.getString("roi_interest")));
				arrcol.add(Helper.correctNull((String)rs.getString("roi_crp")));
				arrcol.add(Helper.correctNull((String)rs.getString("roi_bsp")));
				arrratingvalues.add(arrcol);
			}
			hshResult.put("hidAction", Helper.correctNull((String)hshValues.get("hidAction")));
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateData "+ce.toString());
		}
		hshResult.put("arrRatingDesc", arrRatingDesc);
		hshResult.put("arrRatingSno", arrRatingSno);
		hshResult.put("arrratingvalues", arrratingvalues);
		hshResult.put("score", strScoringPattern);
		hshResult.put("slno", strslno);
		hshResult.put("interest_id", strIntId);
		hshResult.put("ref_rate", strrefrate);
		hshResult.put("sector", strSector);
		return hshResult;
	}
	
	public void setratingBasedROI(HashMap hshValues)  
	{
		HashMap hshQuery =  new HashMap();
		HashMap hshqueryval =  new HashMap();
		int intUpdatesize=0;
		ArrayList arrValues =  new ArrayList();
		ArrayList arrRatingSno =  new ArrayList();
		ResultSet rs = null;
		String strScoringPattern = Helper.correctNull((String)hshValues.get("scoringpattern"));
		String strAmountSno = Helper.correctNull((String)hshValues.get("varRuleId")); //amount wise serial no
		String strTenorSno = Helper.correctNull((String)hshValues.get("slno")); //Tenor wise serial no
		String strslno=Helper.correctNull((String)hshValues.get("slno"));
		String strSector=Helper.correctNull((String)hshValues.get("sel_sector"));
		String id=Helper.correctNull((String)hshValues.get("interest_id"));
		String strrefrate=Helper.correctNull((String)hshValues.get("ref_rate"));
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		try
		{
			String[] strfrom1=null;
			if(hshValues.get("from1") instanceof String)
			{
				strfrom1=new String[1];
				strfrom1[0]=Helper.correctNull((String)hshValues.get("from1"));
			}
			else
			{
				strfrom1=(String[])hshValues.get("from1");
			}
			String[] baserate1=null;
			if(hshValues.get("baserate1") instanceof String)
			{
				baserate1=new String[1];
				baserate1[0]=Helper.correctNull((String)hshValues.get("baserate1"));
			}
			else
			{
				baserate1=(String[])hshValues.get("baserate1");
			}
			String[] ratingadjust1=null;
			if(hshValues.get("adjust1") instanceof String)
			{
				ratingadjust1=new String[1];
				ratingadjust1[0]=Helper.correctNull((String)hshValues.get("adjust1"));
			}
			else
			{
				ratingadjust1=(String[])hshValues.get("adjust1");
			}
			String[] ratingtotal1=null;
			if(hshValues.get("total1") instanceof String)
			{
				ratingtotal1=new String[1];
				ratingtotal1[0]=Helper.correctNull((String)hshValues.get("total1"));
			}
			else
			{
				ratingtotal1=(String[])hshValues.get("total1");
			}
			String[] strRatingdesc1=null;
			if(hshValues.get("txt_ratingDesc") instanceof String)
			{
				strRatingdesc1=new String[1];
				strRatingdesc1[0]=Helper.correctNull((String)hshValues.get("txt_ratingDesc"));
			}
			else
			{
				strRatingdesc1=(String[])hshValues.get("txt_ratingDesc");
			}
			String[] strCRP=null;
			if(hshValues.get("txtcreditrskpremium") instanceof String)
			{
				strCRP=new String[1];
				strCRP[0]=Helper.correctNull((String)hshValues.get("txtcreditrskpremium"));
			}
			else
			{
				strCRP=(String[])hshValues.get("txtcreditrskpremium");
			}
			String[] strBSP=null;
			if(hshValues.get("txtbustratpremium") instanceof String)
			{
				strBSP=new String[1];
				strBSP[0]=Helper.correctNull((String)hshValues.get("txtbustratpremium"));
			}
			else
			{
				strBSP=(String[])hshValues.get("txtbustratpremium");
			}
			if(strAction.equalsIgnoreCase("insert"))
			{
				
				hshQuery = new HashMap();
				hshqueryval = new HashMap();
				arrValues = new ArrayList();
				//delete
				hshQuery.put("strQueryId", "del_ratingROI");
				arrValues.add(id);
				arrValues.add(String.valueOf(Integer.parseInt(strslno)+1));
				arrValues.add(strSector);
				hshQuery.put("arrValues", arrValues);
				hshqueryval
						.put("size", "1");
				hshqueryval.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshqueryval,
				"updateData");
				//end
				
				//insert
				hshQuery = new HashMap();
				hshqueryval = new HashMap();
				arrValues = new ArrayList();
				int num = 0;
				num = 0;intUpdatesize=0;
				for (int k = 0; k < strfrom1.length ; k++) 
				{
					if (!strRatingdesc1[k].equals("")) 
					{
						num = num + 1;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize = intUpdatesize + 1;
						//corpprd_intid,corpprd_sno,corpprd_termfrom,corpprd_termto,corpprd_baserate,
						//corpprd_adjust,corpprd_interest,corpprd_interestid,corpprd_adjust1,corpprd_interest1,corpprd_indtype
						hshQuery.put("strQueryId", "ins_ratingROI");
						
						arrValues.add(id); 
						
						arrValues.add(String.valueOf(Integer.parseInt(strslno)+1)); 
						
						arrValues.add(correctNull(strRatingdesc1[k]));
						
						arrValues.add(correctNull(strSector));
						
						if(!baserate1[k].equalsIgnoreCase(""))
							arrValues.add(correctNull(baserate1[k]));
						else
							arrValues.add("0.00");
						
						if(!ratingadjust1[k].equalsIgnoreCase(""))
							arrValues.add(correctNull(ratingadjust1[k]));
						else
							arrValues.add("0.00");
						
						if(!ratingtotal1[k].equalsIgnoreCase(""))
							arrValues.add(correctNull(ratingtotal1[k]));
						else
							arrValues.add("0.00");
						
						arrValues.add(correctNull(strCRP[k]));
						arrValues.add(correctNull(strBSP[k]));
						
						hshQuery.put("arrValues", arrValues);
						hshqueryval
								.put("size", Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(k+1), hshQuery);
					}
				}
				if(num!=0)
				{
				EJBInvoker.executeStateLess("dataaccess", hshqueryval,
						"updateData");
				}
			}
			String StrQuery11 = SQLParser.getSqlQuery("sel_intratebyrating^"+id);
			ResultSet rs11 = DBUtils.executeQuery(StrQuery11);
			if(rs11.next())
			{
				hshValues.put("fac_id",Helper.correctNull((String)rs11.getString("CORPPRDINT_PRDCODE")));
			}
			EJBInvoker.executeStateLess("corporatefacility", hshValues, "updateFacilitySaveStatus");
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateData "+ce.toString());
		}
		
	}
	public HashMap getSchemesubheadCodeData(HashMap hshValues)  
	{
		HashMap hshRecord = new HashMap();
		ResultSet rs=null;
		String strScheme ="";
		String strLoanType="";
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=new ArrayList();
		String strSchemeCode="";

		try
		{
			strScheme=Helper.correctNull((String)hshValues.get("schemecode"));
			rs=DBUtils.executeLAPSQuery("sel_schemesubhead^"+strScheme);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("sch_datasno")));
				arrCol.add(Helper.correctNull((String)rs.getString("sch_datavalue")));
				arrCol.add(Helper.correctNull((String)rs.getString("sch_datadescription")));
				arrRow.add(arrCol);
			}
			hshRecord.put("arrCol",arrRow);
			hshRecord.put("strScheme",strScheme);
		
		}
		catch(Exception ce)
		{
		
			throw new EJBException("Error in getdata "+ce.toString());
		}
		return hshRecord;
	}
	
public void updateSolKpowerData(HashMap hshRequestValues)
	 {
String[] strPrd_workid = null;
String[] strPrd_maxclass = null;
String[] strPrd_duration = null;
String[] strWrk_flowname = null;
String strPrdCode = null;
String strWrk_flowtype = null;
String strQuery=null;
ResultSet rs=null;
String strPageName=null;
HashMap hshQueryValues = new HashMap();
HashMap hshQuery = new HashMap();
ArrayList arrValues = new ArrayList();
int intSize = 0;
int intFlowpoint = 0;
String strLoanType="";
String strKeyId = "";
String strproduct="";
String strminclass="";
String strminclasstxt="";
String strminskip="";
String strminskiptxt="";
String  strAction="";
String straction="";
try {
	
	strKeyId = Helper.correctNull((String)hshRequestValues.get("hidkeyid"));
	strLoanType=correctNull((String)hshRequestValues.get("prdtype"));
	strPrd_workid = (String[]) hshRequestValues.get("prd_workid");
	strPrd_maxclass = (String[]) hshRequestValues.get("prd_maxclass");
	strPrd_duration = (String[]) hshRequestValues.get("prd_duration");
	strPrdCode = correctNull((String) hshRequestValues.get("prdCode"));
	strWrk_flowtype = correctNull((String) hshRequestValues.get("wrk_flowtype"));
	strproduct=correctNull((String) hshRequestValues.get("sel_prd"));
	strminclass=correctNull((String) hshRequestValues.get("prd_approval"));
	strminclasstxt=correctNull((String) hshRequestValues.get("prd_app_descr"));
	strminskip=correctNull((String) hshRequestValues.get("prd_skip"));
	strminskiptxt=correctNull((String) hshRequestValues.get("prd_skip_descr"));
	strAction=correctNull((String) hshRequestValues.get("hidAction"));
	
	if (strWrk_flowtype.equalsIgnoreCase("p")) {
		intFlowpoint = 1;
		strPageName="In Process";
	} else if (strWrk_flowtype.equalsIgnoreCase("a")) {
		intFlowpoint = 9;
		strPageName="Post Approval";
	} else {
		intFlowpoint = 17;
		strPageName="Post Rejection";
	}
	strWrk_flowname = (String[]) hshRequestValues.get("wrk_flowname");
	
	
	if(strAction.equalsIgnoreCase("insert"))
	{	
		intSize++;
		arrValues = new ArrayList();
		hshQuery = new HashMap();		
		hshQuery.put("strQueryId", "prdsolkpowflowactivitydel");
		arrValues.add(strproduct);
		hshQuery.put("arrValues", arrValues);
		hshQueryValues.put(Integer.toString(intSize), hshQuery);		
		
		intSize++;
		arrValues = new ArrayList();
		hshQuery = new HashMap();
		hshQuery.put("strQueryId","prdsolkpowflowactivityins");		
		arrValues.add(strproduct);
		arrValues.add(strminclass);
		arrValues.add(strminclasstxt);
		arrValues.add(strminskip);
		arrValues.add(strminskiptxt);
		arrValues.add(strWrk_flowtype);
		hshQuery.put("arrValues", arrValues);
		hshQueryValues.put(Integer.toString(intSize),hshQuery);
				
		
		intSize++;
		arrValues = new ArrayList();
		hshQuery = new HashMap();
		hshQuery.put("strQueryId","prdsolkpowdel");
		arrValues.add(strproduct);
		arrValues.add(strWrk_flowtype);
		hshQuery.put("arrValues", arrValues);
		hshQueryValues.put(Integer.toString(intSize),hshQuery);		
		
	   for (int i = 0; i < strPrd_workid.length; i++) 
	   {
		if (!strWrk_flowname[i].equals("")) 
		{	
			intSize++;
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			hshQuery.put("strQueryId","prdsolkpowflowins");			
			arrValues.add(strproduct);
		    arrValues.add(String.valueOf(intFlowpoint));
			arrValues.add(strPrd_workid[i]);
			arrValues.add(strPrd_maxclass[i]);
			arrValues.add(strPrd_duration[i]);
			arrValues.add(strWrk_flowtype);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(String.valueOf(intSize),hshQuery);			
			intFlowpoint++;
		}
	}
	hshQueryValues.put("size",Integer.toString(intSize));
	EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");	
	}
	
} catch (Exception e) {
	log.error("Exception in updateSolKpowerData.. " + e);
	throw new EJBException(e.getMessage());
}
}
public HashMap getSolKpowerData(HashMap hshRequestValues)  
{
	String strQuery = null;
	ResultSet rs = null;
	HashMap hshRecord = new HashMap();
	ArrayList arrWorkid = new ArrayList();
	ArrayList arrMaxclass = new ArrayList();
	ArrayList arrDuration = new ArrayList();
	ArrayList arrWorkflowname = new ArrayList();
	ArrayList arrflowpoint = new ArrayList();
	String strPrdCode = null;
	String strWorkflowType = null;
	String strWrk_flowtype=null;
	
	try {
		strPrdCode = correctNull((String) hshRequestValues.get("sel_prd"));
		strWrk_flowtype = correctNull((String) hshRequestValues.get("wrk_flowtype"));
		
		if(strPrdCode.equalsIgnoreCase(""))
		{
			strPrdCode=Helper.correctNull((String)hshRequestValues.get("hidprdcode"));	
		}
		if(!strPrdCode.equals(""))
		{
			strQuery = SQLParser.getSqlQuery("prdsolkpowsel^" + strPrdCode + "^" +strWrk_flowtype);
			rs = DBUtils.executeQuery(strQuery);	

			while (rs.next()) 
			{
				arrWorkid.add(rs.getString("prd_workid"));
				arrMaxclass.add(rs.getString("prd_minclass"));
				arrDuration.add(rs.getString("prd_duration"));
				arrflowpoint.add(rs.getString("prd_flowpoint"));
				arrWorkflowname.add(rs.getString("wrk_flowname"));
			}
		}
		        hshRecord.put("strPrdCode", strPrdCode);
		        
				hshRecord.put("prd_workid", arrWorkid);
				hshRecord.put("prd_minclass", arrMaxclass);
				hshRecord.put("prd_duration", arrDuration);
				hshRecord.put("arrflowpoint", arrflowpoint);
				hshRecord.put("wrk_flowname", arrWorkflowname);
				
				strQuery = SQLParser.getSqlQuery("prdsolkpowactivitysel^" + strPrdCode);
				rs = DBUtils.executeQuery(strQuery);	

				 if(rs.next()) 
				{
				
				hshRecord.put("prd_minclassapproval",correctNull(rs.getString("prd_minclassapproval")));
				hshRecord.put("prd_minclassapprovaltxt",correctNull(rs.getString("prd_minclassapprovaltxt")));
				hshRecord.put("prd_minclassskip",correctNull(rs.getString("prd_minclassskip")));
				hshRecord.put("prd_minclassskiptxt",correctNull(rs.getString("prd_minclassskiptxt")));
				
				}
				hshRecord.put("prd_code",strPrdCode);
		
	} catch (Exception e) {
		log.error("error in getSolKpowerData.. " + e);
		throw new EJBException(e.getMessage());
	} finally {
		try {
			if (rs != null) {
				rs.close();
			}
		} catch (Exception e1) {
			log.error("Error closing connection.." + e1);
		}
	}
	return hshRecord;
}
public void UpdatePerratingBasedROI(HashMap hshValues)  
{
	HashMap hshQuery =  new HashMap();
	HashMap hshqueryval =  new HashMap();
	int intUpdatesize=0;
	ArrayList arrValues =  new ArrayList();
	ArrayList arrRatingSno =  new ArrayList();
	ResultSet rs = null;
	String strslno=Helper.correctNull((String)hshValues.get("slno"));
	String strSector=Helper.correctNull((String)hshValues.get("sel_sector"));
	String id=Helper.correctNull((String)hshValues.get("interest_id"));
	String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
	try
	{
		String[] baserate1=null;
		if(hshValues.get("baserate1") instanceof String)
		{
			baserate1=new String[1];
			baserate1[0]=Helper.correctNull((String)hshValues.get("baserate1"));
		}
		else
		{
			baserate1=(String[])hshValues.get("baserate1");
		}
		String[] ratingadjust1=null;
		if(hshValues.get("adjust1") instanceof String)
		{
			ratingadjust1=new String[1];
			ratingadjust1[0]=Helper.correctNull((String)hshValues.get("adjust1"));
		}
		else
		{
			ratingadjust1=(String[])hshValues.get("adjust1");
		}
		String[] ratingtotal1=null;
		if(hshValues.get("total1") instanceof String)
		{
			ratingtotal1=new String[1];
			ratingtotal1[0]=Helper.correctNull((String)hshValues.get("total1"));
		}
		else
		{
			ratingtotal1=(String[])hshValues.get("total1");
		}
		String[] strRatingdesc1=null;
		if(hshValues.get("txt_ratingDesc") instanceof String)
		{
			strRatingdesc1=new String[1];
			strRatingdesc1[0]=Helper.correctNull((String)hshValues.get("txt_ratingDesc"));
		}
		else
		{
			strRatingdesc1=(String[])hshValues.get("txt_ratingDesc");
		}
		String[] strCRP=null;
		if(hshValues.get("txtcreditrskpremium") instanceof String)
		{
			strCRP=new String[1];
			strCRP[0]=Helper.correctNull((String)hshValues.get("txtcreditrskpremium"));
		}
		else
		{
			strCRP=(String[])hshValues.get("txtcreditrskpremium");
		}
		String[] strBSP=null;
		if(hshValues.get("txtbustratpremium") instanceof String)
		{
			strBSP=new String[1];
			strBSP[0]=Helper.correctNull((String)hshValues.get("txtbustratpremium"));
		}
		else
		{
			strBSP=(String[])hshValues.get("txtbustratpremium");
		}
		if(strAction.equalsIgnoreCase("insert"))
		{
			
			hshQuery = new HashMap();
			hshqueryval = new HashMap();
			arrValues = new ArrayList();
			//delete
			hshQuery.put("strQueryId", "del_retratingROI");
			arrValues.add(id);
			arrValues.add(String.valueOf(Integer.parseInt(strslno)+1));
			arrValues.add(strSector);
			hshQuery.put("arrValues", arrValues);
			hshqueryval
					.put("size", "1");
			hshqueryval.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshqueryval,
			"updateData");
			//end
			
			//insert
			hshQuery = new HashMap();
			hshqueryval = new HashMap();
			arrValues = new ArrayList();
			int num = 0;
			num = 0;intUpdatesize=0;
			for (int k = 0; k < strRatingdesc1.length ; k++) 
			{
				if (!strRatingdesc1[k].equals("")) 
				{
					num = num + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize = intUpdatesize + 1;
					hshQuery.put("strQueryId", "ins_retratingROI");
					
					arrValues.add(id); 
					
					arrValues.add(String.valueOf(Integer.parseInt(strslno)+1)); 
					
					arrValues.add(correctNull(strRatingdesc1[k]));
					
					arrValues.add(correctNull(strSector));
					
					arrValues.add(correctNull(baserate1[k]));
					
					arrValues.add(correctNull(ratingadjust1[k]));
					
					arrValues.add(correctNull(ratingtotal1[k]));
					
					arrValues.add(correctNull(strCRP[k]));
					arrValues.add(correctNull(strBSP[k]));
					
					hshQuery.put("arrValues", arrValues);
					hshqueryval
							.put("size", Integer.toString(intUpdatesize));
					hshqueryval.put(Integer.toString(k+1), hshQuery);
				}
			}
			if(num!=0)
			{
			EJBInvoker.executeStateLess("dataaccess", hshqueryval,
					"updateData");
			}
		}
	}
	catch(Exception ce)
	{
		throw new EJBException("Error in UpdatePerratingBasedROI "+ce.toString());
	}
	
}
public HashMap getPerratingBasedROI(HashMap hshValues)  
{
	HashMap hshResult =  new HashMap();
	ArrayList arrRatingDesc =  new ArrayList();
	ArrayList arrRatingSno =  new ArrayList();
	ResultSet rs = null;
	String strScoringPattern = Helper.correctNull((String)hshValues.get("scoringpattern"));
	String strAmountSno = Helper.correctNull((String)hshValues.get("varRuleId")); //amount wise serial no
	String strTenorSno = Helper.correctNull((String)hshValues.get("slno")); //Tenor wise serial no
	String strslno=Helper.correctNull((String)hshValues.get("slno"));
	String strSector=Helper.correctNull((String)hshValues.get("sel_sector"));
	String strIntId=Helper.correctNull((String)hshValues.get("interest_id"));
	ArrayList arrcol=new ArrayList();
	ArrayList arrratingvalues=new ArrayList();
	String strrefrate=Helper.correctNull((String)hshValues.get("ref_rate"));
	try
	{
		rs = DBUtils.executeLAPSQuery("sel_ratingCode");
		while(rs.next()) 
		{
			arrRatingDesc.add(Helper.correctNull((String)rs.getString(2)));
			arrRatingSno.add(Helper.correctNull((String)rs.getString(1)));
		}
		if(rs!=null)
		{ rs.close();}
		
		arrratingvalues=new ArrayList();
		rs = DBUtils.executeLAPSQuery("sel_retratingROI^"+strIntId+"^"+String.valueOf(Integer.parseInt(strslno)+1)+"^"+strSector);
		while(rs.next()) 
		{
			arrcol=new ArrayList();
			arrcol.add(Helper.correctNull((String)rs.getString("roi_intid")));
			arrcol.add(Helper.correctNull((String)rs.getString("roi_intsno")));
			arrcol.add(Helper.correctNull((String)rs.getString("roi_ratingcode")));
			arrcol.add(Helper.correctNull((String)rs.getString("roi_baserate")));
			arrcol.add(Helper.correctNull((String)rs.getString("roi_adjust")));
			arrcol.add(Helper.correctNull((String)rs.getString("roi_interest")));
			arrcol.add(Helper.correctNull((String)rs.getString("roi_crp")));
			arrcol.add(Helper.correctNull((String)rs.getString("roi_bsp")));
			arrratingvalues.add(arrcol);
		}
		hshResult.put("hidAction", Helper.correctNull((String)hshValues.get("hidAction")));
	}
	catch(Exception ce)
	{
		throw new EJBException("Error in updateData "+ce.toString());
	}
	hshResult.put("arrRatingDesc", arrRatingDesc);
	hshResult.put("arrRatingSno", arrRatingSno);
	hshResult.put("arrratingvalues", arrratingvalues);
	hshResult.put("score", strScoringPattern);
	hshResult.put("slno", strslno);
	hshResult.put("interest_id", strIntId);
	hshResult.put("ref_rate", strrefrate);
	hshResult.put("sector", strSector);
	return hshResult;
}
public HashMap getOtherinterestTerm(HashMap hsh)  {
	
	java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
	jtn.setMaximumFractionDigits(2);
	jtn.setMinimumFractionDigits(2);
	jtn.setGroupingUsed(false);
	
	HashMap hshqueryval = new HashMap();
	HashMap hshquery = new HashMap();
	HashMap hshQuery;
	HashMap hshValues = new HashMap();
	ArrayList vecVal = new ArrayList();
	ArrayList vecRec = new ArrayList();
	ArrayList arr = new ArrayList();
	ArrayList arrValues;
	ResultSet rs = null;
	
	String[] strfrom = null;
	String[] strto = null;
	String[] strcreditRiskPremium = null;
	String[] strbusstrategicPremium = null;
	
	String val = "", id = "";
	String strQuery="";
	String strAmtfrom="",strTenorFrom="",strTenorTo="";
	String strAmtto ="";
	String strPrdcode="";
	String strType="",strRefType="";
	String strExp="$";
	String strActionData="";
	boolean recordflag=false;  
	int intValue = 0;
	int intUpdatesize = 0;
	StringBuilder sbolddata=new StringBuilder();
	String strprdtype="", strStaffPrd="";
	try 
	{	
		val = correctNull((String)hsh.get("hidval"));
		
		strQuery= SQLParser.getSqlQuery("setproductssel^"+correctNull((String)hsh.get("prdCode")));
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next()){
			strprdtype = Helper.correctNull((String)rs.getString("prd_type"));
			strStaffPrd=Helper.correctNull((String)rs.getString("prd_staffprd"));
			hshValues.put("strInteresttype",Helper.correctNull((String)rs.getString("prd_interesttype")));
		}
		hshValues.put("strStaffPrd",strStaffPrd);
		if(val.equals("update_terms"))
		{
			id = Helper.correctNull((String) hsh.get("ruleid"));
			rs = DBUtils.executeLAPSQuery("ruleresult^" + id);
			
			sbolddata.append("~Product Code="+ correctNull((String)hsh.get("prdCode")));
			sbolddata.append("~Interest type ="+hsh.get("wrk_flowtype1"));
			sbolddata.append("~Amount Range From="+ correctNull((String)hsh.get("amtfrom")));
			sbolddata.append("~Amount Range To ="+ correctNull((String)hsh.get("amtto")));
			sbolddata.append("~Tenor Range From ="+ correctNull((String)hsh.get("tenorfrom")));
			sbolddata.append("~Tenor Range To ="+ correctNull((String)hsh.get("tenorto")));
			
			while (rs.next()) 
			{
				sbolddata.append("~ Range from = "+Helper.correctNull((String)rs.getString("prd_termfrom")));
				sbolddata.append("~ Range To = "+Helper.correctNull((String)rs.getString("prd_termto")));
				sbolddata.append("~ Credit Risk Premium = "+Helper.correctNull((String)rs.getString("prd_creditrskpremium")));
				sbolddata.append("~ Business Strategic Premium = "+Helper.correctNull((String)rs.getString("prd_busstrategicpremium")));
			}
			if(rs!=null)
				rs.close();
		}
		if (val.equals("show_terms")) {
			id = (String) hsh.get("ruleid");
			rs = DBUtils.executeLAPSQuery("ruleresult^" + id);
			while (rs.next()) {
				recordflag=true;
				vecRec = new ArrayList();
				vecRec.add(rs.getString(1));
				vecRec.add(rs.getString(2));
				vecRec.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("prd_creditrskpremium")))));
				vecRec.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("prd_busstrategicpremium")))));
				vecVal.add(vecRec);
			}
			hshValues.put("rangefrom", hsh.get("amtfrom"));
			hshValues.put("rangeto", hsh.get("amtto"));
			hshValues.put("tenorfrom", hsh.get("tenorfrom"));
			hshValues.put("tenorto", hsh.get("tenorto"));
			hshValues.put("ruleid", hsh.get("ruleid"));
			hshValues.put("sel_inttype", hsh.get("sel_inttype"));
			hshValues.put("sel_inttype1", hsh.get("sel_inttype1"));
			hshValues.put("wrk_flowtype1", hsh.get("work"));
			hshValues.put("vecVal", vecVal);
			if(recordflag)
				hshValues.put("recordflag","Y");
			else
				hshValues.put("recordflag","N");
		}
		if (val.equals("insert_terms"))
			{
			strAmtfrom=correctNull((String)hsh.get("amtfrom"));
			strAmtto=correctNull((String)hsh.get("amtto"));
			strPrdcode=correctNull((String)hsh.get("prdCode"));
			strType=correctNull((String)hsh.get("work"));
			strTenorFrom=correctNull((String)hsh.get("tenorfrom"));
			strTenorTo=correctNull((String)hsh.get("tenorto"));
			strRefType=correctNull((String)hsh.get("sel_inttype1"));
			
			strQuery=SQLParser.getSqlQuery("checkotherinterestprdrangeins^"+strPrdcode+"^"+strType
						+"^"+strAmtfrom+"^"+strAmtto
						+"^"+strAmtfrom+"^"+strAmtto
						+"^"+strAmtfrom+"^"+strAmtto+"^"+correctNull((String)hsh.get("sel_inttype"))+"^"+strTenorFrom+"^"+strTenorTo+"^"+strTenorFrom+"^"+strTenorTo
						+"^"+strTenorFrom+"^"+strTenorTo+"^"+strRefType);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
				{
				if(rs.getInt(1)!=0)
					{
					strExp = strExp + " Interest is already defined for the given amount range ";
					throw new Exception(strExp);
					}
				}
			arrValues = new ArrayList();
			if(rs!=null)
				rs.close();
					
			rs = DBUtils.executeLAPSQuery("intmaxterm");
			intUpdatesize = 1;
			if (rs.next()) 
				intValue = (rs.getInt(1));
				
			intValue = intValue + 1;
			id = Integer.toString(intValue);
			hshqueryval.put("size", Integer.toString(intUpdatesize));
			hshquery.put("strQueryId", "inttermins");
			arr.add(strPrdcode);
			arr.add(strType);
			arr.add(id);
			arr.add(strAmtfrom);
			arr.add(strAmtto);
			arr.add(Helper.correctNull((String)hsh.get("sel_inttype")));
			arr.add(strTenorFrom);
			arr.add(strTenorTo);
			arr.add(strRefType);
			hshquery.put("arrValues", arr);
			hshqueryval.put("1", hshquery);
					
			strfrom = (String[]) hsh.get("from");
			strto = (String[]) hsh.get("to");
			strcreditRiskPremium = (String[]) hsh.get("txtcreditrskpremium");
			strbusstrategicPremium = (String[]) hsh.get("txtbustratpremium");
					
			hshQuery = new HashMap();
			arrValues = new ArrayList();
					
			int num = 0;
			for (int k = 2; k < strfrom.length + 2; k++) 
				{
				if (!strfrom[k - 2].equals("")) 
					{
					num = num + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize = intUpdatesize + 1;
					hshQuery.put("strQueryId", "intins");
					arrValues.add(id);
					arrValues.add(Integer.toString(num));
					arrValues.add(correctNull(strfrom[k - 2]));
					arrValues.add(correctNull(strto[k - 2]));
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add(correctNull(strcreditRiskPremium[k - 2]));
					arrValues.add(correctNull(strbusstrategicPremium[k - 2]));
					hshQuery.put("arrValues", arrValues);
					hshqueryval.put("size", Integer.toString(intUpdatesize));
					hshqueryval.put(Integer.toString(k), hshQuery);
					}
				}
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			
		  
			strActionData="~Product Code="+ strPrdcode+ "~Interest type ="+hsh.get("wrk_flowtype1")+"~Amount Range From="+ strAmtfrom+ "~Amount Range To ="+strAmtto;
			for (int i = 0; i < strfrom.length; i++) {
				if (!strfrom[i].equals("")) {
					strActionData =strActionData + "~Repayment Period From = "
							+ strfrom[i] + "~Repayment Period To ="
							+ strto[i];
				}
			}
			if(correctNull((String)hsh.get("hidRecordflag")).equals("Y"))
			hsh.put("hidAction", "update");
			if(correctNull((String)hsh.get("hidRecordflag")).equals("N"))
			hsh.put("hidAction", "insert");
			int intProductCode = Integer.parseInt(Helper.correctInt((String)hsh.get("prd_code")));
			String strPrdCode1= Integer.toString(intProductCode);	
			AuditTrial.auditNewLog(hsh,"23",strPrdCode1,strActionData.toString(),sbolddata.toString());
		}
		if (val.equals("update_terms")) 
			{
			strAmtfrom=correctNull((String)hsh.get("amtfrom"));
			strAmtto=correctNull((String)hsh.get("amtto"));
			strPrdcode=correctNull((String)hsh.get("prd_code"));
			strType=correctNull((String)hsh.get("work"));
			String strPrdsno=correctNull((String)hsh.get("ruleid"));
			strTenorFrom=correctNull((String)hsh.get("tenorfrom"));
			strTenorTo=correctNull((String)hsh.get("tenorto"));
			strRefType=correctNull((String)hsh.get("sel_inttype1"));
			
			strQuery=SQLParser.getSqlQuery("checkotherinterestprdrangeupd^"+strPrdcode+"^"+strType+"^"+strPrdsno
						+"^"+strAmtfrom+"^"+strAmtto
						+"^"+strAmtfrom+"^"+strAmtto
						+"^"+strAmtfrom+"^"+strAmtto+"^"+Helper.correctNull((String)hsh.get("sel_inttype"))+"^"+strTenorFrom+"^"+strTenorTo+"^"+strTenorFrom+"^"+strTenorTo
						+"^"+strTenorFrom+"^"+strTenorTo+"^"+strRefType);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
				{
				if(rs.getInt(1)!=0)
					{
					strExp = strExp + " Interest is already defined for the given amount range  ";
					throw new Exception(strExp);
					}
				}
			
			
			intUpdatesize = 1;
			hshqueryval.put("size", Integer.toString(intUpdatesize));
			hshquery = new HashMap();
			arr = new ArrayList();

			hshquery.put("strQueryId", "limitdel");
			arr.add(hsh.get("ruleid"));
			hshquery.put("arrValues", arr);
			hshqueryval.put("1", hshquery);
					
			intUpdatesize = intUpdatesize+1;
			hshqueryval.put("size", Integer.toString(intUpdatesize));
			hshquery = new HashMap();
			arr = new ArrayList();
			hshquery.put("strQueryId", "limitupd");
			arr.add(strAmtfrom);
			arr.add(strAmtto);
			arr.add(strTenorFrom);
			arr.add(strTenorTo);
			arr.add(strRefType);
			arr.add(strPrdsno);
			hshquery.put("arrValues", arr);
			hshqueryval.put("2", hshquery);
			hshquery = new HashMap();
				
			strfrom = (String[]) hsh.get("from");
			strto = (String[]) hsh.get("to");
			strcreditRiskPremium = (String[]) hsh.get("txtcreditrskpremium");
			strbusstrategicPremium = (String[]) hsh.get("txtbustratpremium");
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			int num = 0;
			for (int k = 3; k < strfrom.length + 3; k++) 
				{
				if (!strfrom[k - 3].equals("")) 
					{
					num = num + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize = intUpdatesize + 1;
					hshqueryval.put("size", Integer.toString(intUpdatesize));
					hshQuery.put("strQueryId", "intins");
					arrValues.add(strPrdsno);
					arrValues.add(Integer.toString(num));
					arrValues.add(correctNull(strfrom[k - 3]));
					arrValues.add(correctNull(strto[k - 3]));
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add(correctNull(strcreditRiskPremium[k - 3]));
					arrValues.add(correctNull(strbusstrategicPremium[k - 3]));
					hshQuery.put("arrValues", arrValues);
					hshqueryval.put(Integer.toString(intUpdatesize), hshQuery);
					}
				}
			EJBInvoker.executeStateLess("dataaccess", hshqueryval,"updateData");
		    
			
			strActionData="Product Code="+ strPrdcode+ "~Interest type ="+hsh.get("wrk_flowtype1")+"~Amount Range From="+ strAmtfrom+ "~Amount Range To ="+strAmtto;
	
			for (int i = 0; i < strfrom.length; i++) {
				if (!strfrom[i].equals("")) {
					strActionData =strActionData + "~Repayment Period From ="
							+ strfrom[i] + "~Repayment Period To ="
							+ strto[i];
				}
			}
//End			
			if(correctNull((String)hsh.get("hidRecordflag")).equals("Y"))
			hsh.put("hidAction", "update");
			if(correctNull((String)hsh.get("hidRecordflag")).equals("N"))
			hsh.put("hidAction", "insert");
			int intProductCode = Integer.parseInt(strPrdcode);
			String strPrdCode1= Integer.toString(intProductCode);	
			AuditTrial.auditNewLog(hsh,"23",strPrdCode1,strActionData.toString(),sbolddata.toString());	
			hshValues.put("rangefrom", strAmtfrom);
			hshValues.put("rangeto", strAmtto);
			hshValues.put("tenorfrom", strTenorFrom);
			hshValues.put("tenorto", strTenorTo);
			
			hshValues.put("ruleid", strPrdsno);
			hshValues.put("sel_inttype", Helper.correctNull((String)hsh.get("sel_inttype")));
			hshValues.put("wrk_flowtype1", hsh.get("wrk_flowtype1"));
			id = (String) hsh.get("ruleid");
			rs = DBUtils.executeLAPSQuery("ruleresult^" + id);
			while (rs.next()) 
				{
				vecRec = new ArrayList();
				vecRec.add(correctNull(rs.getString(1)));
				vecRec.add(correctNull(rs.getString(2)));
				vecRec.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("prd_creditrskpremium")))));
				vecRec.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("prd_busstrategicpremium")))));
				vecVal.add(vecRec);
				}
			hshValues.put("vecVal", vecVal);
			
			hsh.put("strprdtype", strprdtype);
			
		
			if(val.equals("update_terms") || val.equals("insert_terms"))
			updateProductSaveStatus(hsh);
	}	
		
	} catch (Exception e) {
		throw new EJBException(e.toString());
	} finally {
		try {

			if (rs != null) {
				rs.close();
			}
		} catch (Exception cf) {
			throw new EJBException("Error closing the connection "
					+ cf.getMessage());

		}
	}
	return hshValues;

}
public HashMap getOtherinterestTypes(HashMap hsh)  {
	
	java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
	jtn.setMaximumFractionDigits(2);
	jtn.setMinimumFractionDigits(2);
	jtn.setGroupingUsed(false);
	
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	ResultSet rs = null;
	
	
	String strPrdcode="",strIntType="",strInterestFor="",strRefereceType="";
	try 
	{	
		strPrdcode=Helper.correctNull((String)hsh.get("prdCode"));
		strIntType=Helper.correctNull((String)hsh.get("inttype"));
		strInterestFor=Helper.correctNull((String)hsh.get("interestfor"));
		strRefereceType=Helper.correctNull((String)hsh.get("strROIType"));
		if(Helper.correctNull((String)hsh.get("strModule")).equalsIgnoreCase("C"))
		{
			rs = DBUtils.executeLAPSQuery("corprulechoice1^" + strIntType + "^" + strPrdcode+"^"+strInterestFor+"^"+strRefereceType);
			while (rs.next()) 
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("corpprdint_sno")));
				arrCol.add(correctNull(rs.getString("corpprd_amtrangefrom"))+ "---"+ correctNull(rs.getString("corpprd_amtrangeto"))+ "---"+correctNull(rs.getString("corpprd_tenorfrom"))+ "---"+ correctNull(rs.getString("corpprd_tenorto")));
				arrRow.add(arrCol);
			}
		}
		else
		{
			rs = DBUtils.executeLAPSQuery("rulechoice1^" + strIntType + "^" + strPrdcode+"^"+strInterestFor+"^"+strRefereceType);
			while (rs.next()) 
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("prdint_sno")));
				arrCol.add(correctNull(rs.getString("prd_amtrangefrom"))+ "---"+ correctNull(rs.getString("prd_amtrangeto"))+ "---"+correctNull(rs.getString("prd_tenorfrom"))+ "---"+ correctNull(rs.getString("prd_tenorto")));
				arrRow.add(arrCol);
			}
			
		}
		if(rs!=null)
			rs.close();
		
		hsh.put("arrRow",arrRow);
		
	} catch (Exception e) {
		throw new EJBException(e.toString());
	} finally {
		try {

			if (rs != null) {
				rs.close();
			}
		} catch (Exception cf) {
			throw new EJBException("Error closing the connection "
					+ cf.getMessage());

		}
	}
	return hsh;

}
public HashMap getCorpOtherinterestTerm(HashMap hsh)  {
	
	java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
	jtn.setMaximumFractionDigits(2);
	jtn.setMinimumFractionDigits(2);
	jtn.setGroupingUsed(false);
	
	HashMap hshqueryval = new HashMap();
	HashMap hshquery = new HashMap();
	HashMap hshQuery;
	HashMap hshValues = new HashMap();
	ArrayList vecVal = new ArrayList();
	ArrayList vecRec = new ArrayList();
	ArrayList arr = new ArrayList();
	ArrayList arrValues;
	ResultSet rs = null;
	
	String[] strfrom = null;
	String[] strto = null;
	String[] strcreditRiskPremium = null;
	String[] strbusstrategicPremium = null;
	
	String val = "", id = "";
	String strQuery="";
	String strAmtfrom="",strTenorFrom="",strTenorTo="";
	String strAmtto ="";
	String strPrdcode="";
	String strType="";
	String strExp="$";
	String strActionData="";
	boolean recordflag=false;  
	int intValue = 0;
	int intUpdatesize = 0;
	StringBuilder sbolddata=new StringBuilder();
	String strprdtype="", strStaffPrd="",strRefType="";
	try 
	{	
		val = correctNull((String)hsh.get("hidval"));
		
		rs = DBUtils.executeLAPSQuery("getprdcodelimitlist^"+correctNull((String)hsh.get("prdCode")));
		if (rs.next()) {
			
			hshValues.put("com_facintdef",Helper.correctNull(rs.getString("com_facintdef")));
			hshValues.put("fac_interesttype",Helper.correctNull(rs.getString("fac_interesttype")));
		
		}
		if(val.equals("update_terms"))
		{
			id = Helper.correctNull((String) hsh.get("ruleid"));
			rs = DBUtils.executeLAPSQuery("corpruleresult1^" + id);
			
			sbolddata.append("~Facility Code="+ correctNull((String)hsh.get("prdCode")));
			sbolddata.append("~Interest type ="+hsh.get("wrk_flowtype1"));
			sbolddata.append("~Amount Range From="+ correctNull((String)hsh.get("amtfrom")));
			sbolddata.append("~Amount Range To ="+ correctNull((String)hsh.get("amtto")));
			sbolddata.append("~Tenor Range From ="+ correctNull((String)hsh.get("tenorfrom")));
			sbolddata.append("~Tenor Range To ="+ correctNull((String)hsh.get("tenorto")));
			sbolddata.append("~ROI Type ="+ correctNull((String)hsh.get("sel_inttype")));
			sbolddata.append("~Reference Type ="+ correctNull((String)hsh.get("sel_inttype1")));
			
			while (rs.next()) 
			{
				sbolddata.append("~ Range from = "+Helper.correctNull((String)rs.getString("CORPPRD_TERMFROM")));
				sbolddata.append("~ Range To = "+Helper.correctNull((String)rs.getString("CORPPRD_TERMTO")));
				sbolddata.append("~ Credit Risk Premium = "+Helper.correctNull((String)rs.getString("CORPPRD_CREDITRSKPREMIUM")));
				sbolddata.append("~ Business Strategic Premium = "+Helper.correctNull((String)rs.getString("CORPPRD_BUSSTRATEGICPREMIUM")));
			}
			if(rs!=null)
				rs.close();
		}
		if (val.equals("show_terms")) {
			id = (String) hsh.get("ruleid");
			rs = DBUtils.executeLAPSQuery("corpruleresult1^" + id);
			while (rs.next()) {
				recordflag=true;
				vecRec = new ArrayList();
				vecRec.add(rs.getString("CORPPRD_TERMFROM"));
				vecRec.add(rs.getString("CORPPRD_TERMTO"));
				vecRec.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("CORPPRD_CREDITRSKPREMIUM")))));
				vecRec.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("CORPPRD_BUSSTRATEGICPREMIUM")))));
				vecVal.add(vecRec);
			}
			hshValues.put("rangefrom", hsh.get("amtfrom"));
			hshValues.put("rangeto", hsh.get("amtto"));
			hshValues.put("tenorfrom", hsh.get("tenorfrom"));
			hshValues.put("tenorto", hsh.get("tenorto"));
			hshValues.put("ruleid", hsh.get("ruleid"));
			hshValues.put("sel_inttype", hsh.get("sel_inttype"));
			hshValues.put("sel_inttype1", hsh.get("sel_inttype1"));
			hshValues.put("wrk_flowtype1", hsh.get("work"));
			hshValues.put("vecVal", vecVal);
			if(recordflag)
				hshValues.put("recordflag","Y");
			else
				hshValues.put("recordflag","N");
		}
		if (val.equals("insert_terms"))
			{
			strAmtfrom=correctNull((String)hsh.get("amtfrom"));
			strAmtto=correctNull((String)hsh.get("amtto"));
			strPrdcode=correctNull((String)hsh.get("prdCode"));
			strType=correctNull((String)hsh.get("work"));
			strTenorFrom=correctNull((String)hsh.get("tenorfrom"));
			strTenorTo=correctNull((String)hsh.get("tenorto"));
			strRefType=correctNull((String)hsh.get("sel_inttype1"));
			
			strQuery=SQLParser.getSqlQuery("corpcheckintprdrangeins2^"+strPrdcode+"^"+strType
						+"^"+strAmtfrom+"^"+strAmtto
						+"^"+strAmtfrom+"^"+strAmtto
						+"^"+strAmtfrom+"^"+strAmtto+"^"+correctNull((String)hsh.get("sel_inttype"))+"^"+strTenorFrom+"^"+strTenorTo+"^"+strTenorFrom+"^"+strTenorTo
						+"^"+strTenorFrom+"^"+strTenorTo+"^"+strRefType);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
				{
				if(rs.getInt(1)!=0)
					{
					strExp = strExp + " Interest is already defined for the given amount range ";
					throw new Exception(strExp);
					}
				}
			arrValues = new ArrayList();
			if(rs!=null)
				rs.close();
					
			rs = DBUtils.executeLAPSQuery("corpintmaxterm^"+strPrdcode);
			intUpdatesize = 1;
			if (rs.next()) {
				intValue = (rs.getInt(1));
			}
				
			intValue = intValue + 1;
			id = Integer.toString(intValue);
			hshqueryval.put("size", Integer.toString(intUpdatesize));
			hshquery.put("strQueryId", "corpinttermins");
			arr.add(strPrdcode);
			arr.add(strType);
			arr.add(id);
			arr.add(strAmtfrom);
			arr.add(strAmtto);
			arr.add("");
			arr.add(Helper.correctNull((String)hsh.get("sel_inttype")));
			arr.add(strTenorFrom);
			arr.add(strTenorTo);
			arr.add(strRefType);
			hshquery.put("arrValues", arr);
			hshqueryval.put("1", hshquery);
					
			strfrom = (String[]) hsh.get("from");
			strto = (String[]) hsh.get("to");
			strcreditRiskPremium = (String[]) hsh.get("txtcreditrskpremium");
			strbusstrategicPremium = (String[]) hsh.get("txtbustratpremium");
					
			hshQuery = new HashMap();
			arrValues = new ArrayList();
					
			int num = 0;
			for (int k = 2; k < strfrom.length + 2; k++) 
				{
				if (!strfrom[k - 2].equals("")) 
					{
					num = num + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize = intUpdatesize + 1;
					hshQuery.put("strQueryId", "corpintins");
					arrValues.add(id);
					arrValues.add(Integer.toString(num));
					arrValues.add(correctNull(strfrom[k - 2]));
					arrValues.add(correctNull(strto[k - 2]));
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add(correctNull(strcreditRiskPremium[k - 2]));
					arrValues.add(correctNull(strbusstrategicPremium[k - 2]));
					hshQuery.put("arrValues", arrValues);
					hshqueryval.put("size", Integer.toString(intUpdatesize));
					hshqueryval.put(Integer.toString(k), hshQuery);
					}
				}
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			
		}
		if (val.equals("update_terms")) 
			{
			strAmtfrom=correctNull((String)hsh.get("amtfrom"));
			strAmtto=correctNull((String)hsh.get("amtto"));
			strPrdcode=correctNull((String)hsh.get("prd_code"));
			strType=correctNull((String)hsh.get("work"));
			String strPrdsno=correctNull((String)hsh.get("ruleid"));
			strTenorFrom=correctNull((String)hsh.get("tenorfrom"));
			strTenorTo=correctNull((String)hsh.get("tenorto"));
			strRefType=correctNull((String)hsh.get("sel_inttype1"));
			
			strQuery=SQLParser.getSqlQuery("corpcheckinterestprdrangeupd2^"+strPrdcode+"^"+strType
						+"^"+strAmtfrom+"^"+strAmtto
						+"^"+strAmtfrom+"^"+strAmtto
						+"^"+strAmtfrom+"^"+strAmtto+"^"+Helper.correctNull((String)hsh.get("sel_inttype"))+"^"+strPrdsno+"^"+strTenorFrom+"^"+strTenorTo+"^"+strTenorFrom+"^"+strTenorTo
						+"^"+strTenorFrom+"^"+strTenorTo+"^"+strRefType);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
				{
				if(rs.getInt(1)!=0)
					{
					strExp = strExp + " Interest is already defined for the given amount range  ";
					throw new Exception(strExp);
					}
				}
			
			
			intUpdatesize = 1;
			hshqueryval.put("size", Integer.toString(intUpdatesize));
			hshquery = new HashMap();
			arr = new ArrayList();

			hshquery.put("strQueryId", "corplimitdel");
			arr.add(hsh.get("ruleid"));
			hshquery.put("arrValues", arr);
			hshqueryval.put("1", hshquery);
					
			intUpdatesize = intUpdatesize+1;
			hshqueryval.put("size", Integer.toString(intUpdatesize));
			hshquery = new HashMap();
			arr = new ArrayList();
			hshquery.put("strQueryId", "corplimitupd");
			arr.add(strAmtfrom);
			arr.add(strAmtto);
			arr.add(strTenorFrom);
			arr.add(strTenorTo);
			arr.add(strRefType);
			arr.add(strPrdsno);
			hshquery.put("arrValues", arr);
			hshqueryval.put("2", hshquery);
			hshquery = new HashMap();
				
			strfrom = (String[]) hsh.get("from");
			strto = (String[]) hsh.get("to");
			strcreditRiskPremium = (String[]) hsh.get("txtcreditrskpremium");
			strbusstrategicPremium = (String[]) hsh.get("txtbustratpremium");
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			int num = 0;
			for (int k = 3; k < strfrom.length + 3; k++) 
				{
				if (!strfrom[k - 3].equals("")) 
					{
					num = num + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize = intUpdatesize + 1;
					hshqueryval.put("size", Integer.toString(intUpdatesize));
					hshQuery.put("strQueryId", "corpintins");
					arrValues.add(strPrdsno);
					arrValues.add(Integer.toString(num));
					arrValues.add(correctNull(strfrom[k - 3]));
					arrValues.add(correctNull(strto[k - 3]));
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add(correctNull(strcreditRiskPremium[k - 3]));
					arrValues.add(correctNull(strbusstrategicPremium[k - 3]));
					hshQuery.put("arrValues", arrValues);
					hshqueryval.put(Integer.toString(intUpdatesize), hshQuery);
					}
				}
			EJBInvoker.executeStateLess("dataaccess", hshqueryval,"updateData");
		    
			
			hshValues.put("rangefrom", strAmtfrom);
			hshValues.put("rangeto", strAmtto);
			hshValues.put("tenorfrom", hsh.get("tenorfrom"));
			hshValues.put("tenorto", hsh.get("tenorto"));
			hshValues.put("ruleid", strPrdsno);
			hshValues.put("sel_inttype", Helper.correctNull((String)hsh.get("sel_inttype")));
			hshValues.put("sel_inttype1", Helper.correctNull((String)hsh.get("sel_inttype1")));
			hshValues.put("wrk_flowtype1", hsh.get("wrk_flowtype1"));
			id = (String) hsh.get("ruleid");
			rs = DBUtils.executeLAPSQuery("corpruleresult1^" + id);
			while (rs.next()) 
				{
				vecRec = new ArrayList();
				vecRec.add(rs.getString("CORPPRD_TERMFROM"));
				vecRec.add(rs.getString("CORPPRD_TERMTO"));
				vecRec.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("CORPPRD_CREDITRSKPREMIUM")))));
				vecRec.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("CORPPRD_BUSSTRATEGICPREMIUM")))));
				vecVal.add(vecRec);
				}
			hshValues.put("vecVal", vecVal);
			
			hsh.put("strprdtype", strprdtype);
			
		
	}	
		
		
		if(val.equals("update_terms") || val.equals("insert_terms"))
		{
			HashMap hshTemp=new HashMap();
			hshTemp.put("fac_id", correctNull((String)hsh.get("prdCode")));
			EJBInvoker.executeStateLess("corporatefacility",hshTemp,"updateFacilitySaveStatus");
		}
		
		if(rs!=null)
			rs.close();
		
		strQuery=SQLParser.getSqlQuery("chk_prdfac_spreaddetails^"+correctNull((String)hsh.get("prdCode"))+"^A','C");
		rs = DBUtils.executeQuery(strQuery);
		if (rs.next()) 
		{
			hshValues.put("strSpreadFlag","Y");
		}
		
	} catch (Exception e) {
		throw new EJBException(e.toString());
	} finally {
		try {

			if (rs != null) {
				rs.close();
			}
		} catch (Exception cf) {
			throw new EJBException("Error closing the connection "
					+ cf.getMessage());

		}
	}
	return hshValues;

}
	//vindhya begin

public HashMap getSetTermsandConditions(HashMap hsh)  {
	
	
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	ResultSet rs = null;
	ResultSet rs1 = null;
	
	String strMode="";
	String strprepost="";
	String strModule="";
	String strQuery="";
	String strQuery1="";
	
	String strQuery2="";
	String strQuery3="";
	
	try 
		{
		
		String strPrdCode=Helper.correctNull((String)hsh.get("prdCode"));		
		if(strPrdCode.equalsIgnoreCase(""))
		{
			 strPrdCode=Helper.correctNull((String)hsh.get("fac_id"));
		}
		String strmodule=Helper.correctNull((String)hsh.get("strCorpModule"));
		if(strmodule.equalsIgnoreCase(""))
		{
			strmodule="R";
		}
		else if(strmodule.equalsIgnoreCase("a"))
		{
			strmodule="A";
		}
		else if(strmodule.equalsIgnoreCase("c"))
		{
			strmodule="C";
		}
		strMode=correctNull((String)hsh.get("select_termstype"));
		strprepost=correctNull((String)hsh.get("hidsel_prepost"));
		if(!(strMode.equalsIgnoreCase("")))
		{	
		if(strMode.equalsIgnoreCase("G"))
		{
			strQuery=SQLParser.getSqlQuery("select_TermsConditions^"+strMode+"^"+strprepost+"^"+strmodule);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{	
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("fac_sno")));
				arrCol.add(Helper.replaceForJavaScriptString(correctNull(rs.getString("fac_terms"))));
				arrCol.add(correctNull(rs.getString("fac_facilitycode")));
				arrCol.add(Helper.correctInt(rs.getString("fac_parent_id")));
				arrCol.add(Helper.correctNull(rs.getString("fac_action")));
				arrRow.add(arrCol);
				
				strQuery1=SQLParser.getSqlQuery("sel_termschildele^"+correctNull(rs.getString("fac_sno")));
				rs1 = DBUtils.executeQuery(strQuery1);
				while(rs1.next())
				{
					if(Helper.correctNull(rs1.getString("fac_action")).equalsIgnoreCase("E"))
					{
					arrCol = new ArrayList();
					arrCol.add(correctNull(rs1.getString("fac_sno")));
					arrCol.add(Helper.replaceForJavaScriptString(correctNull(rs1.getString("fac_terms"))));
					arrCol.add(correctNull(rs1.getString("fac_facilitycode")));
					arrCol.add(Helper.correctInt(rs1.getString("fac_parent_id")));
					arrCol.add(Helper.correctNull(rs1.getString("fac_action")));
					arrRow.add(arrCol);		
					}
				}
				
				if(rs1!=null)
				{
					rs1.close();
				}
			}
			
		}
		else if((strMode.equalsIgnoreCase("O"))||(strMode.equalsIgnoreCase("B"))||(strMode.equalsIgnoreCase("P")))//Other Terms & Conditions and Instructions to the Branch t&c
		{
		
			strQuery=SQLParser.getSqlQuery("select_OtherTermsConditions^"+strMode+"^"+strmodule);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{	
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("fac_sno")));
				arrCol.add(Helper.replaceForJavaScriptString(correctNull(rs.getString("fac_terms"))));
				arrCol.add(correctNull(rs.getString("fac_facilitycode")));
				arrCol.add(correctNull(rs.getString("fac_parent_id")));
				arrCol.add(Helper.correctNull(rs.getString("fac_action"))); 
				arrRow.add(arrCol);	
				
				strQuery1=SQLParser.getSqlQuery("sel_termschildele^"+correctNull(rs.getString("fac_sno")));
				rs1 = DBUtils.executeQuery(strQuery1);
				while(rs1.next())
				{
					arrCol = new ArrayList();
					if(Helper.correctNull(rs1.getString("fac_action")).equalsIgnoreCase("E"))
					{
					arrCol.add(correctNull(rs1.getString("fac_sno")));
					arrCol.add(Helper.replaceForJavaScriptString(correctNull(rs1.getString("fac_terms"))));
					arrCol.add(correctNull(rs1.getString("fac_facilitycode")));
					arrCol.add(Helper.correctInt(rs1.getString("fac_parent_id")));
					arrCol.add(Helper.correctNull(rs1.getString("fac_action")));
					arrRow.add(arrCol);	
					}
				}
				if(rs1!=null)
				{
					rs1.close();
				}
				
				
			}	
			
			
		}
		else
		{
			if(strmodule.equalsIgnoreCase("a") || strmodule.equalsIgnoreCase("c"))
			{	
				if(!strPrdCode.equalsIgnoreCase(""))
				{
					String strTermsMode="S";
					strQuery=SQLParser.getSqlQuery("select_SpecialTermsConditions^"+strTermsMode+"^"+strmodule+"^"+strPrdCode);
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next())
					{	
						arrCol = new ArrayList();
						arrCol.add(correctNull(rs.getString("fac_sno")));
						arrCol.add(Helper.replaceForJavaScriptString(correctNull(rs.getString("fac_terms"))));
						arrCol.add(correctNull(rs.getString("fac_facilitycode")));
						arrCol.add(Helper.correctInt(rs.getString("fac_parent_id")));
						arrCol.add(Helper.correctNull(rs.getString("fac_action")));
						arrRow.add(arrCol);	
						
						
						strQuery1=SQLParser.getSqlQuery("sel_termschildele^"+correctNull(rs.getString("fac_sno")));
						rs1 = DBUtils.executeQuery(strQuery1);
						while(rs1.next())
						{
							arrCol = new ArrayList();
							if(Helper.correctNull(rs1.getString("fac_action")).equalsIgnoreCase("E"))
							{
							arrCol.add(correctNull(rs1.getString("fac_sno")));
							arrCol.add(Helper.replaceForJavaScriptString(correctNull(rs1.getString("fac_terms"))));
							arrCol.add(correctNull(rs1.getString("fac_facilitycode")));
							arrCol.add(Helper.correctInt(rs1.getString("fac_parent_id")));
							arrCol.add(Helper.correctNull(rs1.getString("fac_action")));							
							arrRow.add(arrCol);	
							}
						}
						if(rs1!=null)
						{
							rs1.close();
						}
					}
					
					}
			}
			else
			{
				//strQuery=SQLParser.getSqlQuery("sel_prodfacterms^"+strMode);
				strQuery=SQLParser.getSqlQuery("sel_prodfacterms^"+strPrdCode);
				
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{	
					if(correctNull(rs.getString("terms_action")).equalsIgnoreCase("E"))
					{	
					arrCol = new ArrayList();
					arrCol.add(correctNull(rs.getString("terms_id")));	
					arrCol.add(Helper.replaceForJavaScriptString(correctNull(rs.getString("terms_content"))));	
					arrCol.add(correctNull(rs.getString("terms_desc")));
					arrCol.add(correctNull(rs.getString("terms_ruleno")));					
					arrCol.add(correctNull(rs.getString("terms_action")));					
					arrRow.add(arrCol);	
					}
				}
			}
			
				
		}
		
		strQuery2=SQLParser.getSqlQuery("sel_termsandconditionsmaster^"+strPrdCode+"^"+strMode+"^"+strprepost+"^"+strmodule);
		rs = DBUtils.executeQuery(strQuery2);
		ArrayList termsidrow = new ArrayList();
		ArrayList termsidCol = new ArrayList();
		while(rs.next())
		{	
			termsidCol = new ArrayList();
			termsidCol.add(correctNull(rs.getString("TERMSCODE")));
			termsidCol.add(correctNull(rs.getString("CONSTITUTIONCODE")));
			termsidCol.add(correctNull(rs.getString("INSURANCECOVERED")));					
			termsidCol.add(correctNull(rs.getString("HOLIDAYPERIOD")));
			termsidCol.add(correctNull(rs.getString("INTERESTSUBTYPE")));
			termsidCol.add(correctNull(rs.getString("termsflag")));			
			termsidrow.add(termsidCol);					
		}
		hsh.put("termsidrow",termsidrow);
		System.out.println("termsidrow==> "+termsidrow);
		}
			
		hsh.put("strMode",strMode);
		hsh.put("strprepost",strprepost);
		hsh.put("strmodule",strmodule);
		hsh.put("arrRow",arrRow);
		
		
		
	} catch (Exception e) {
		throw new EJBException(e.toString());
	} finally {
		try {

			if (rs != null) {
				rs.close();
			}
		} catch (Exception cf) {
			throw new EJBException("Error closing the connection "
					+ cf.getMessage());

		}
	}
	return hsh;

}

public void updateSetTermsandConditions(HashMap hshValues) 
{
	HashMap hshQueryValues=new HashMap();
	HashMap hshQuery=new HashMap();
	ArrayList arrValues=new ArrayList();
	ArrayList arrValues1 = new ArrayList();
	String strQuery="";	
	HashMap hshQuery1=new HashMap();
	
	HashMap hshQueryValues1 = null;
	String strQuery1 = "";
	String maxslno="";
	ResultSet rs=null;
	String strUserId=Helper.correctNull((String)hshValues.get("strUserId"));
	try
	{
		String[] Termcode =null;
		String[] checked =null;
		String[] holidayperiod=null;
		String[] constitution=null;
		String[] insurancecovered=null;
		String[] interestsubtype=null;
		
		if(hshValues.get("hid_chk_status") instanceof String[])
		{
			checked= ((String[]) hshValues.get("hid_chk_status"));		
		}else
		{
			checked=new String[1];
			checked[0]= ((String) hshValues.get("hid_chk_status"));
		}
		if(hshValues.get("hidtermCode") instanceof String[])
		{
			Termcode= ((String[]) hshValues.get("hidtermCode"));		
		}else
		{
			Termcode=new String[1];
			Termcode[0]= ((String) hshValues.get("hidtermCode"));
		}
		if(hshValues.get("hid_Holidayperiod") instanceof String[])
		{
			holidayperiod= ((String[]) hshValues.get("hid_Holidayperiod"));		
		}else
		{
			holidayperiod=new String[1];
			holidayperiod[0]= ((String) hshValues.get("hid_Holidayperiod"));
		}
		if(hshValues.get("hid_constitution") instanceof String[])
		{
			constitution= ((String[]) hshValues.get("hid_constitution"));		
		}else
		{
			constitution=new String[1];
			constitution[0]= ((String) hshValues.get("hid_constitution"));
		}
		
		if(hshValues.get("hid_insurancecovered") instanceof String[])
		{
			insurancecovered= ((String[]) hshValues.get("hid_insurancecovered"));		
		}else
		{
			insurancecovered=new String[1];
			insurancecovered[0]= ((String) hshValues.get("hid_insurancecovered"));
		}
		
		if(hshValues.get("hid_interestsubtype") instanceof String[])
		{
			interestsubtype= ((String[]) hshValues.get("hid_interestsubtype"));		
		}else
		{
			interestsubtype=new String[1];
			interestsubtype[0]= ((String) hshValues.get("hid_interestsubtype"));
		}
		
		
		String strPrdCode=Helper.correctNull((String)hshValues.get("prdCode"));
		String strcorpmodule=Helper.correctNull((String)hshValues.get("strCorpModule"));
		if(strcorpmodule.equalsIgnoreCase(""))
		{
			strcorpmodule="R";
		}		
		else if(strcorpmodule.equalsIgnoreCase("a"))
		{
			strcorpmodule="A";
		}
		else if(strcorpmodule.equalsIgnoreCase("c"))
		{
			strcorpmodule="C";
		}
		String strMode=correctNull((String)hshValues.get("select_termstype"));
		String strprepost=correctNull((String)hshValues.get("hidsel_prepost"));
		if(strPrdCode.equalsIgnoreCase(""))
		{
			 strPrdCode=Helper.correctNull((String)hshValues.get("fac_id"));
		}
		
		hshQuery1 = new HashMap();
		arrValues1 = new ArrayList();
		hshQueryValues1=new HashMap();
		arrValues1.add(strPrdCode);
		arrValues1.add(strMode);
		arrValues1.add(strprepost);
		arrValues1.add(strcorpmodule);
		hshQuery1.put("strQueryId", "deletetermsandcondmaster");
		hshQuery1.put("arrValues", arrValues1);
		hshQueryValues1.put("size","1");
		hshQueryValues1.put("1",hshQuery1);
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues1,"updateData");
		
		
		int TotalNo = Termcode.length;
		for(int i=0;i<TotalNo;i++)
		{
			strQuery = SQLParser.getSqlQuery("getmaxtermsandcond^" + strPrdCode+"^"+Termcode[i]);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				maxslno=Helper.correctNull((String)rs.getString("MAXSLNO"));			
		
				arrValues = new ArrayList();
			    hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues.add(strPrdCode);
				arrValues.add(strMode);
				arrValues.add(strprepost);
				arrValues.add(strcorpmodule);
				arrValues.add(Termcode[i]);
				arrValues.add(maxslno);		
				arrValues.add(constitution[i]);		
				arrValues.add(insurancecovered[i]);	
				arrValues.add(holidayperiod[i]);
				arrValues.add(interestsubtype[i]);
				arrValues.add(checked[i]);
				arrValues.add(strUserId);			
					
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","insertinto_termsandcond");			
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			}
			if(rs!=null)
			{
				rs.close();
			}
		}
	}
	catch(Exception ce)
	{
		throw new EJBException("Error in updateSetTermsandConditions "+ce.toString());
	}
}

	//vindhya end
}
	
	
