package com.sai.laps.helper;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import com.sai.laps.helper.Helper;

import javax.ejb.EJBException;

public class UpdateDairyData {
	
	public HashMap updateDataForDairy(HashMap hshValues) throws Exception
	{
		
		ResultSet rs =  null;
		HashMap hshRecord = new HashMap();
		
		try
		{
	 		String strQuery = "";
	 		
	 		ArrayList arrRow = new ArrayList();
	 		ArrayList arrData = new ArrayList();
	 		

			String appno = Helper.correctNull((String)hshValues.get("strappno"));
	 		java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
	 		nf.setMinimumIntegerDigits(7);
			nf.setGroupingUsed(false);
			String agr_batch ="";
			String agr_batch_purchased="";
			double incomgober =0.00,TotalCostDryDays=0.00,TotalCostLacDays=0.00,veterinaryAid=0.00,Insurance=0.00,
			selOtherExpenses=0.00,selCalfIncome=0.00,selMilkPrice=0.00,electricityExpenses=0.00,totalOtherIncome=0.00,
			noOfLabour=0.00,salaryMonthly=0.00,expensesOfLabour=0.00,valueOfAnimal=0.00;
			
		
			strQuery = SQLParser.getSqlQuery("agrdiaryfindatasel^" +appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				
				selMilkPrice = Double.parseDouble(Helper.correctDouble(rs.getString("milkprice")));
				
				veterinaryAid = Double.parseDouble(Helper.correctDouble(rs.getString("vetaid")));
				
				electricityExpenses   = Double.parseDouble(Helper.correctDouble(rs.getString("elecexp")))*12.0;
				
				TotalCostLacDays = Double.parseDouble(Helper.correctDouble(rs.getString("totcostlact")));
				
				TotalCostDryDays =Double.parseDouble(Helper.correctDouble(rs.getString("totcostdry")));
					
				noOfLabour =Double.parseDouble(Helper.correctDouble(rs.getString("nooflabour")));
				
				salaryMonthly = Double.parseDouble(Helper.correctDouble(rs.getString("salmonth")));

				expensesOfLabour = noOfLabour * salaryMonthly * 12;
				 
				selOtherExpenses =Double.parseDouble(Helper.correctDouble(rs.getString("otherexp")));
				
				Insurance = Double.parseDouble(Helper.correctDouble(rs.getString("inspremium")));
				
				incomgober = Double.parseDouble(Helper.correctDouble(rs.getString("incomgober")));
				
				selCalfIncome = Double.parseDouble(Helper.correctDouble(rs.getString("inccalves")));
			
				totalOtherIncome = Double.parseDouble(Helper.correctDouble(rs.getString("otherincome")));
				
				valueOfAnimal = Double.parseDouble(Helper.correctDouble(rs.getString("value_animal")));
			
				
			}
			
			double[] milkYearLac = new double[7];
			double[] milkYeardry = new double[7];
			
			strQuery = SQLParser.getSqlQuery("selmilkflow_total^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				
				milkYearLac[0] = Double.parseDouble(Helper.correctDouble(rs.getString("firstyearlac")));
				milkYeardry[0] = Double.parseDouble(Helper.correctDouble(rs.getString("firstyeardry")));
				
				milkYearLac[1] = Double.parseDouble(Helper.correctDouble(rs.getString("secondyearlac")));
				milkYeardry[1] = Double.parseDouble(Helper.correctDouble(rs.getString("secondyeardry")));

				milkYearLac[2] = Double.parseDouble(Helper.correctDouble(rs.getString("thirdyearlac")));
				milkYeardry[2] = Double.parseDouble(Helper.correctDouble(rs.getString("thirdyeardry")));
				
				milkYearLac[3] = Double.parseDouble(Helper.correctDouble(rs.getString("fourthyearlac")));
				milkYeardry[3] = Double.parseDouble(Helper.correctDouble(rs.getString("fourthyeardry")));

				milkYearLac[4] = Double.parseDouble(Helper.correctDouble(rs.getString("fifthyearlac")));
				milkYeardry[4] = Double.parseDouble(Helper.correctDouble(rs.getString("fifthyeardry")));
				
				milkYearLac[5] = Double.parseDouble(Helper.correctDouble(rs.getString("sixthyearlac")));
				milkYeardry[5] = Double.parseDouble(Helper.correctDouble(rs.getString("sixthyeardry")));
				
				milkYearLac[6] = Double.parseDouble(Helper.correctDouble(rs.getString("seventhyearlac")));
				milkYeardry[6] = Double.parseDouble(Helper.correctDouble(rs.getString("seventhyeardry")));
				
			}	
			
			if(rs!= null)
			{
				rs.close();
			}
			
			
			double adultCattle =0.00, femaleCattle=0.00,IncomeCowdung1=0.00,yearTotallac=0.00,yearTotaldry=0.00,
			ExpensesVeterinaryAid=0.00,insurancePremium=0.00,otherExpenses=0.00,calfIncome=0.00,totalanimal=0.00,
			averageMilkYeild=0.00,yearExpensesTotal=0.00,milkPrice=0.00,totalIncome=0.00,yearSurplus=0.00,totalvalueOfAnimal=0.00;
			
			
			strQuery = SQLParser.getSqlQuery("agrsel_stockdetails^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				agr_batch = Helper.correctNull((String)rs.getString("agr_batch"));
				agr_batch_purchased = Helper.correctNull((String)rs.getString("agr_batch_purchased"));
				
				if(!agr_batch.equalsIgnoreCase("0"))
				{					
					totalanimal =  totalanimal + Double.parseDouble(Helper.correctDouble(rs.getString("agr_noanimals")));
					
					averageMilkYeild = averageMilkYeild + Double.parseDouble(Helper.correctDouble(rs.getString("agr_avg_milk")));
				}
				
			}
			if(agr_batch_purchased.equalsIgnoreCase("2"))
			{
				averageMilkYeild = averageMilkYeild/2;
			}
			ArrayList arrInsert= new ArrayList();
			int tempInt=0;
			strQuery = SQLParser.getSqlQuery("agrselcattlechart^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			double dblbatchpurchased=Double.parseDouble(Helper.correctDouble(agr_batch_purchased));
			if(dblbatchpurchased==0.0)
				dblbatchpurchased=1;
				
			while (rs.next()) 
			{
				arrRow = new ArrayList();
				
				adultCattle = Double.parseDouble(Helper.correctDouble((String)rs.getString("ADULTONE")));
				femaleCattle = Double.parseDouble(Helper.correctDouble((String)rs.getString("FEMALECALVES")));
				
				IncomeCowdung1 = incomgober*adultCattle;
				
				yearTotallac =  (adultCattle * milkYearLac[tempInt] * TotalCostLacDays)/dblbatchpurchased;
				
				yearTotaldry = 	(adultCattle * milkYeardry[tempInt] * TotalCostDryDays)/dblbatchpurchased;
				
				ExpensesVeterinaryAid  = adultCattle * veterinaryAid;
				
				insurancePremium  = Insurance * adultCattle;
				
				otherExpenses = selOtherExpenses * adultCattle;
				
				calfIncome = femaleCattle * selCalfIncome;
				
				yearExpensesTotal = yearTotallac + yearTotaldry + ExpensesVeterinaryAid + expensesOfLabour +
									insurancePremium + otherExpenses +electricityExpenses + calfIncome;
				 
				milkPrice = (selMilkPrice * averageMilkYeild * adultCattle * milkYearLac[tempInt])/dblbatchpurchased;
				
				totalIncome = milkPrice + IncomeCowdung1 + totalOtherIncome;
				
				yearSurplus = totalIncome - yearExpensesTotal;
				
				arrRow.add(Helper.formatDoubleValue(yearTotallac));//0
				arrRow.add(Helper.formatDoubleValue(yearTotaldry));//1
				arrRow.add(Helper.formatDoubleValue(expensesOfLabour));//2
				arrRow.add(Helper.formatDoubleValue(calfIncome));//3
				arrRow.add(Helper.formatDoubleValue(ExpensesVeterinaryAid));//4
				arrRow.add(Helper.formatDoubleValue(electricityExpenses));//5
				arrRow.add(Helper.formatDoubleValue(insurancePremium));//6
				arrRow.add(Helper.formatDoubleValue(otherExpenses));//7
				arrRow.add(Helper.formatDoubleValue(yearExpensesTotal));//8
				arrRow.add(Helper.formatDoubleValue(milkPrice));//9
				arrRow.add(Helper.formatDoubleValue(IncomeCowdung1));//10
				arrRow.add(Helper.formatDoubleValue(totalOtherIncome));//11
				arrRow.add(Helper.formatDoubleValue(totalIncome));//12
				arrRow.add(Helper.formatDoubleValue(yearSurplus));//13
				
				
				arrInsert.add(Helper.formatDoubleValue(yearSurplus));
				
				arrData.add(arrRow);
				
				
				if(tempInt==6)
				{
					totalvalueOfAnimal = valueOfAnimal * (adultCattle + femaleCattle);
				}
					
				tempInt++;
			}
			hshRecord.put("totalvalueOfAnimal",Helper.formatDoubleValue(totalvalueOfAnimal));
			hshRecord.put("arrDatacattle", arrData);
			hshValues.put("arrInsert",arrInsert);
			if(!Helper.correctNull((String)hshValues.get("strCheck")).equals(""))
			{
				updateIncomeAndExpensesData(hshValues);
			}
		}
		catch(Exception e)
		{
			
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
		if(!Helper.correctNull((String)hshValues.get("strCheck")).equals(""))
		{
			return null;
		}
		else
		{	
			return hshRecord;
		}
	}
	
	
	public void updateCattleChartData(HashMap hshValues)  
	{
		
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		
		ArrayList arrcattledetails=new ArrayList();
		ArrayList arrValues=new ArrayList();
		
		String strQuery="";
		String strappno="";
		int sel_calves=0;
		
		ResultSet rs=null;
		
		int femalePrecent=50;
		int mortalityPecent=5;
		int adultAge=0;
		int projectYear=7;
	    int startAnimal=0;
	    int cowtype=0;		
	    double adult[]=new double[projectYear];
		double female[]=new double[projectYear];
		double male[]=new double[projectYear];
		double malecalves=0.0;
		double femalecalves=0.0;	
	    
		try{
			strappno = Helper.correctNull((String) hshValues.get("strappno"));
			if(strappno.equalsIgnoreCase("null") || strappno.equalsIgnoreCase(""))
			{
				strappno = Helper.correctNull((String)hshValues.get("appno"));
			}
			strQuery = SQLParser.getSqlQuery("sel_agrfemalecalves^" + strappno);
			rs = DBUtils.executeQuery(strQuery);
						
			if(rs.next()){
				sel_calves=((rs.getInt("sel_calves")));
			}
			
			if(rs != null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("agrsel_stockdetails^" + strappno);
			rs = DBUtils.executeQuery(strQuery);
			
	
			while (rs.next()) 
			{
				startAnimal=startAnimal+rs.getInt("agr_noanimals");
				if(cowtype==0)
				{
					cowtype = rs.getInt("agr_milchcattle");
					if(cowtype==1)
					{
						adultAge=2;
					}
					else if(cowtype==2)
					{
						adultAge=3;
					}
				}
			}
			if(rs != null)
			{
				rs.close();
			}
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "agrdelcattlechart");
			arrValues.add(strappno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
		
			for(int year=0;year<=projectYear-1;year++){
				arrcattledetails=new ArrayList();
				if((year-adultAge)<0){
					adult[year]=startAnimal;
				}
				else if(adultAge>0 && sel_calves==1)
				{
					adult[year]=adult[year-1]+female[year-adultAge];				
				}
				else
				{
					if(year>0)
						adult[year] = adult[year - 1];
				}
				double kids=adult[year]-Math.ceil(adult[year]*mortalityPecent/100);		
				female[year]=(double)Math.round(Math.ceil(kids*femalePrecent/100));	
				male[year]=kids-female[year];
				malecalves=male[year];
				if(sel_calves==1)
				{
					if((year-adultAge)<0){
						femalecalves=femalecalves+female[year];
					}
					else if(adultAge>0)
					{
						femalecalves=femalecalves+female[year]-female[year-adultAge];
					}
				}
				else
				{
					femalecalves=female[year];
				}
				arrcattledetails.add(strappno);
				arrcattledetails.add(Integer.toString(year+1));
				arrcattledetails.add(Integer.toString((int)adult[year]));
				arrcattledetails.add(Integer.toString((int)femalecalves));
				arrcattledetails.add(Integer.toString((int)malecalves));
			
				hshQuery.put("strQueryId", "agrinscattlechart");
				hshQuery.put("arrValues", arrcattledetails);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				
			 }
			}
			catch(Exception e)
			{
				throw new EJBException("Error in getting data "+ e.getMessage());
			}
			finally
			{
					try
					{
						if(rs != null)
							rs.close();
					}
					catch(Exception exp)
					{
						throw new EJBException("Error in closing the connection in getcattlechartdetails - agrcropsBean  "+ exp.toString()); 
					}
			}
	}
	
	private void updateIncomeAndExpensesData(HashMap hshRequestValues)
	{
		String appno=Helper.correctNull((String)hshRequestValues.get("appno"));
		if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
		{
			appno=Helper.correctNull((String)hshRequestValues.get("strappno"));
		}
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ArrayList arrValues1 = new ArrayList();
		arrValues =(ArrayList) hshRequestValues.get("arrInsert");
 		ResultSet rs =  null;
 		String strQuery = "";
		int intUpdatesize = 0;
		boolean bstate = false;
		try
		{
			strQuery = SQLParser.getSqlQuery("sel_agr_dairyfarming^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			bstate = rs.next();
			if(bstate == true)
			{
				intUpdatesize = intUpdatesize + 1;
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "upd_dairyfarming_IE");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);	
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			else
			{
				intUpdatesize = intUpdatesize + 1;
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "ins_dairyfarming_IE");
				arrValues1.add(appno);
				arrValues1.addAll(arrValues);
				hshQuery.put("arrValues", arrValues1);	
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
		}	
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
		
	}

}
