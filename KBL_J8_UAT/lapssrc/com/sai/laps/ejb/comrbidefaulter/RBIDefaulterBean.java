package com.sai.laps.ejb.comrbidefaulter;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.SQLParser;


@Stateless(name = "RBIDefaulterBean", mappedName = "RBIDefaulterHome")
@Remote (RBIDefaulterRemote.class)
public class RBIDefaulterBean extends BeanAdapter
{	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	


	static Logger log=Logger.getLogger(RBIDefaulterBean.class);	



	public HashMap getData(HashMap hshRequestValues) 
	{
		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arrValues = new ArrayList();
		ArrayList arrDescription = new ArrayList();

		String strQuery="";
		String strRBITableName ="";
		String strTemp ="";
		String strId ="";

		int i =0;
		
		try
		{	
			
			hshRecord = new HashMap();
			strRBITableName =(String)hshRequestValues.get("strRBITableName");
			strTemp =(String)hshRequestValues.get("strTemp");
			strId =(String)hshRequestValues.get("valid");			
			strQuery = SQLParser.getSqlQuery("selrbisearch^"+strRBITableName+"^"+strTemp);
			
			rs = DBUtils.executeQuery(strQuery);
			i=1;

			while (rs.next())
			{
				arrValues = new ArrayList();
				arrValues.add(correctNull((String)rs.getString("SCTG")));
				arrValues.add(correctNull((String)rs.getString("BKNM")));
				arrValues.add(correctNull((String)rs.getString("BKBR")));
				arrValues.add(correctNull((String)rs.getString("STATE")));
				arrValues.add(correctNull((String)rs.getString("SRNO")));
				arrValues.add(correctNull((String)rs.getString("PRTY")));
				arrValues.add(correctNull((String)rs.getString("REGADDR")));
				arrValues.add(correctNull((String)rs.getString("OSAMT")));
				arrValues.add(correctNull((String)rs.getString("SUIT")));
				arrValues.add(correctNull((String)rs.getString("OTHER_BK")));
				arrValues.add(correctNull((String)rs.getString("DIR1")));
				arrValues.add(correctNull((String)rs.getString("DIR2")));
				arrValues.add(correctNull((String)rs.getString("DIR3")));
				arrValues.add(correctNull((String)rs.getString("DIR4")));
				arrValues.add(correctNull((String)rs.getString("DIR5")));
				arrValues.add(correctNull((String)rs.getString("DIR6")));
				arrValues.add(correctNull((String)rs.getString("DIR7")));
				arrValues.add(correctNull((String)rs.getString("DIR8")));
				arrValues.add(correctNull((String)rs.getString("DIR9")));
				arrValues.add(correctNull((String)rs.getString("DIR10")));
				arrValues.add(correctNull((String)rs.getString("DIR11")));
				arrValues.add(correctNull((String)rs.getString("DIR12")));
				arrValues.add(correctNull((String)rs.getString("DIR13")));
				arrValues.add(correctNull((String)rs.getString("DIR14")));
				
				arrValues.add(correctNull((String)rs.getString("BIFR")));
				arrValues.add(correctNull((String)rs.getString("CDR")));
				arrValues.add(correctNull((String)rs.getString("GCDR")));
				arrValues.add(correctNull((String)rs.getString("OTS")));
				arrValues.add(correctNull((String)rs.getString("BANK")));
				arrValues.add(correctNull((String)rs.getString("RBINSF")));
				arrValues.add(correctNull((String)rs.getString("RBIWILL")));
				
				hshRecord.put(Integer.toString(i),arrValues);
				i++;
			}
				arrDescription.add("SCTG");
				arrDescription.add("Bank Name");
				arrDescription.add("Branch Name");
				arrDescription.add("State");
				arrDescription.add("SR NO.");
				arrDescription.add("Party Name");
				arrDescription.add("Registered Address");
				arrDescription.add("Outstanding Amount");
				arrDescription.add("SUIT");
				arrDescription.add("OTHER Bank");
				arrDescription.add("Director-1");
				arrDescription.add("Director-2");
				arrDescription.add("Director-3");
				arrDescription.add("Director-4");
				arrDescription.add("Director-5");
				arrDescription.add("Director-6");
				arrDescription.add("Director-7");
				arrDescription.add("Director-8");
				arrDescription.add("Director-9");
				arrDescription.add("Director-10");
				arrDescription.add("Director-11");
				arrDescription.add("Director-12");
				arrDescription.add("Director-13");
				arrDescription.add("Director-14");
				
				arrDescription.add("BIFR A/C");
				arrDescription.add("A/c in CDR");
				arrDescription.add("A/c of Group in CDR");
				arrDescription.add("Compromise/OTS");
				arrDescription.add("Bank's Caution");
				arrDescription.add("RBI Defaulter(Non Suit File)");
				arrDescription.add("RBI Defaulter(Willful)");

			hshRecord.put("i",Integer.toString(i));
			hshRecord.put("valid",strId);
			hshRecord.put("arrDescription",arrDescription);
				
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData RBI Defaultere Search List "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}


public HashMap getSearchData(HashMap hshRequestValues) 
	{
		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		
		String strSearchCriteria ="";
		String strRBITableName ="";

		String strFieldName  ="";
		String strFieldValue  ="";
		String strLike  ="like upper('";
		String strTemp = "";
		String strTemp1 = "";


		int i=0;

		try
		{				

			hshRecord = new HashMap();
			strRBITableName = "rbi_defaulter";
			strSearchCriteria=correctNull((String)hshRequestValues.get("hidsearch"));
			
			StringTokenizer strId = new StringTokenizer(strSearchCriteria,"~");

			while (strId.hasMoreTokens())
			{	
				strFieldName = (String)strId.nextToken();
				
				if(strFieldName.equals("DIR"))
				{	
					
					strFieldValue = correctNull((String)hshRequestValues.get(strFieldName));
										
					//if(!strFieldValue.equals(""))
					{	strTemp =strTemp+"(";
						for(i =1;i<=14;i++)
						{	
							strTemp1 = strFieldName;						
							strTemp1 = "upper("+strTemp1+Integer.toString(i)+")";
							//arrCriterias.add((String)getDescription(strTemp1));
											
							strTemp =strTemp+ strTemp1+" "+strLike+"%"+strFieldValue+"%'"+") or ";
							strTemp1="";							
						}
					}
					
					strTemp =strTemp.substring(0,(strTemp.length())-3);
					strTemp = strTemp+")";
					strTemp = strTemp+" and ";
				}
				else
				{
					//arrCriterias.add((String)getDescription(strFieldName));
					strFieldValue = correctNull((String)hshRequestValues.get(strFieldName));
					if((strFieldName.equals("SUIT")) && (strFieldValue.equals("")))
					{	
						//strTemp =strTemp+ strFieldName+" "+strLike+strFieldValue+"%'";
						
					}
					else if((strFieldName.equals("BIFR")) && (strFieldValue.equals("")))
					{	
						
										
					}
					else if((strFieldName.equals("CDR")) && (strFieldValue.equals("")))
					{	
						
										
					}
					else if((strFieldName.equals("GCDR")) && (strFieldValue.equals("")))
					{	
						
										
					}
					else if((strFieldName.equals("OTS")) && (strFieldValue.equals("")))
					{	
						
										
					}
					else if((strFieldName.equals("BANK")) && (strFieldValue.equals("")))
					{	
						
										
					}
					else if((strFieldName.equals("RBINSF")) && (strFieldValue.equals("")))
					{	
						
										
					}
					else if((strFieldName.equals("RBIWILL")) && (strFieldValue.equals("")))
					{	
						
										
					}
					else 
					{
						
						strTemp =strTemp+ "upper("+strFieldName+") "+strLike+"%"+strFieldValue+"%')";
						strTemp = strTemp+" and ";
					}
					//
				}
				
			}
			strTemp =strTemp.substring(0,(strTemp.length())-4);
			
			hshRequestValues.put("strRBITableName",strRBITableName);
			hshRequestValues.put("strTemp",strTemp);
			hshRequestValues.put("valid","1");

			hshRecord = (HashMap)getData(hshRequestValues);			
			i =Integer.parseInt((String)hshRecord.get("i"));
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getSearchData RBIDEFAULTERS "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		//hshRecord.put("arrCriterias",arrCriterias);
		hshRecord.put("arrValueSize",Integer.toString(i-1));
		hshRecord.put("strRBITableName",strRBITableName);
		hshRecord.put("strTemp",strTemp);

		return hshRecord;
	}


//	private String getDescription(String strName)
//	{
//		
//		String strDescription ="";
//		String []strDescriptionName = new String[31];
//		String []strFieldName = new String[31];
//		try
//		{
//			strFieldName[0]  ="SCTG";		strDescriptionName[0]  ="SCTG";
//			strFieldName[1]  ="BKNM";		strDescriptionName[1]  ="Bank Name";
//			strFieldName[2]  ="BKBR";		strDescriptionName[2]  ="Branch Name";
//			strFieldName[3]  ="STATE";		strDescriptionName[3]  ="State";
//			strFieldName[4]  ="SRNO";		strDescriptionName[4]  ="SR NO.";
//			strFieldName[5]  ="PRTY";		strDescriptionName[5]  ="Party Name";
//			strFieldName[6]  ="REGADDR";	strDescriptionName[6]  ="Registered Address";
//			strFieldName[7]  ="OSAMT";		strDescriptionName[7]  ="Outstanding Amount";
//			strFieldName[8]  ="SUIT";		strDescriptionName[8]  ="SUIT";
//			strFieldName[9]  ="OTHER_BK";	strDescriptionName[9]  ="OTHER Bank";
//			strFieldName[10] ="DIR1";		strDescriptionName[10] ="Director-1";
//			strFieldName[11] ="DIR2";		strDescriptionName[11] ="Director-2";
//			strFieldName[12] ="DIR3";		strDescriptionName[12] ="Director-3";
//			strFieldName[13] ="DIR4";		strDescriptionName[13] ="Director-4";
//			strFieldName[14] ="DIR5";		strDescriptionName[14] ="Director-5";
//			strFieldName[15] ="DIR6";		strDescriptionName[15] ="Director-6";
//			strFieldName[16] ="DIR7";		strDescriptionName[16] ="Director-7";
//			strFieldName[17] ="DIR8";		strDescriptionName[17] ="Director-8";
//			strFieldName[18] ="DIR9";		strDescriptionName[18] ="Director-9";
//			strFieldName[19] ="DIR10";		strDescriptionName[19] ="Director-10";
//			strFieldName[20] ="DIR11";		strDescriptionName[20] ="Director-11";
//			strFieldName[21] ="DIR12";		strDescriptionName[21] ="Director-12";
//			strFieldName[22] ="DIR13";		strDescriptionName[22] ="Director-13";
//			strFieldName[23] ="DIR14";		strDescriptionName[23] ="Director-14";
//			
//			strFieldName[24] ="BIFR";		strDescriptionName[24] ="BIFR A/C";
//			strFieldName[25] ="CDR";		strDescriptionName[25] ="A/c in CDR";
//			strFieldName[26] ="GCDR";		strDescriptionName[26] ="A/c of Group in CDR";
//			strFieldName[27] ="OTS";		strDescriptionName[27] ="Compromise/OTS";
//			strFieldName[28] ="BANK";		strDescriptionName[28] ="Bank's Caution";
//			strFieldName[29] ="RBINSF";		strDescriptionName[29] ="RBI Defaulter(Non Suit File)";
//			strFieldName[30] ="RBIWILL";	strDescriptionName[30] ="RBI Defaulter(Willful)";
//
//			for(int i=0; i<31;i++)
//			{
//				if(strFieldName[i].equals(strName))
//				{
//					strDescription = strDescriptionName[i];
//					break;
//				}
//			}
//			
//		}
//		catch(Exception cf)
//		{
//			throw new EJBException("Error in getDescription-->"+cf.getMessage());
//		}
//
//		return strDescription;
//	}
}