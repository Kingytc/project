

package com.sai.laps.ejb.comformula;

import java.sql.ResultSet;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
@Stateless(name = "ComformulaBean", mappedName = "ComformulaHome")
@Remote (ComformulaRemote.class)
public class ComformulaBean extends BeanAdapter
{

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String strIsQisFormula = null;
    String strColName = null;
    String strFrom = null;
    String strTo = null;
    String strFormulaApply = null;

    public ComformulaBean()
    {
        strIsQisFormula = "";
        strColName = "";
        strFrom = "";
        strTo = "";
        strFormulaApply = "";
    }

    public HashMap getFormulaResult(HashMap hashtable)
        
    {       
        ResultSet resultset = null;
        HashMap hashtable1 = new HashMap();
        String s7 = "";
        String s10 = "0";
        String s21 = "";
        double d = 0.0D;
        int i = 0;
               
        java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setGroupingUsed(false);
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
        try
        {
            try
            {
                String s9 = correctNull((String)hashtable.get("access"));
                s9 = s9.trim();
                String s6 = correctNull((String)hashtable.get("formula"));
                String s18 = correctNull((String)hashtable.get("formulano"));                
                String s23 = correctNull((String)hashtable.get("formulano"));
                s6 = s6.trim();
                String s14 = correctNull((String)hashtable.get("indcode"));
                String s16 = correctNull((String)hashtable.get("date"));
                if(!s14.trim().equals("") && !s18.trim().equals(""))
                {
                    String s2 = SQLParser.getSqlQuery("selindratio^" + s18);
                    if(resultset!=null)
                    	resultset.close();
                  
                    resultset = DBUtils.executeQuery(s2);
                    if(resultset.next())
                    {
                        s21 = correctNull(resultset.getString("formula_type"));
                        s10 = correctNull(resultset.getString("formula_cma_no"));
                        if(s21.trim().equals("B"))
                            i = resultset.getInt("formula_ind_compare");
                    }
                    if(s21.trim().equals("B"))
                    {
                        s23 = s18;
                        s18 = Integer.toString(i);
                    }
                    if(i > 0 && s21.trim().equals("B") || i == 0 && s21.trim().equals("I"))
                    {
                    	
                        String s3 = SQLParser.getSqlQuery("selindnumpoint^" + s14 + "^" + s18 + "^" + s16);
                        if(resultset != null)
                        	resultset.close();
                        resultset = DBUtils.executeQuery(s3);
                        if(resultset.next())
                            d = resultset.getDouble("point");
                    }
                    if(s21.trim().equals("B"))
                        s18 = s23;
                }
                if(s9.equals("B"))
                {
                    s14 = "0";
                    HashMap hashtable2 = getBorrowerPosition(hashtable);
                    
                    String s12 = correctNull((String)hashtable2.get("borrowertype"));
                    String s25 = correctNull((String)hashtable2.get("formulaapplyto"));
                    String s20 = correctNull((String)hashtable2.get("borrowres"));                    
                    if(s25.trim().equals("F") && s12.trim().equals("N"))
                    {
                        hashtable1.put("result", s20);
                        hashtable1.put("points", "2");
                        HashMap hashtable3 = hashtable1;
                        return hashtable3;
                    }
                    if(s25.trim().equals("P") && s12.trim().equals("N"))
                    {
                        hashtable1.put("result", s20);
                        hashtable1.put("points", "2");
                        HashMap hashtable4 = hashtable1;
                        return hashtable4;
                    }
                    if(s25.trim().equals("EC") && s12.trim().equals("N"))
                    {
                        hashtable1.put("result", s20);
                        hashtable1.put("points", "2");
                        HashMap hashtable5 = hashtable1;
                        return hashtable5;
                    }
                    if(s25.trim().equals("CP") && s12.trim().equals("N"))
                    {
                        hashtable1.put("result", s20);
                        hashtable1.put("points", "2");
                        HashMap hashtable6 = hashtable1;
                        return hashtable6;
                    }
                    if(s25.trim().equals("ST") && s12.trim().equals("N"))
                    {
                        hashtable1.put("result", s20);
                        hashtable1.put("points", "2");
                        HashMap hashtable7 = hashtable1;
                        return hashtable7;
                    }
                    if(!s20.trim().equals(""))
                    {
                        double d2 = Double.parseDouble(s20);
                        
                        if(d != 0.0D && d2 != 0.0D && i != 0 && s21.trim().equals("B"))
                            d = d2 / d;
                        else
                            d = d2;
                    }
                    hashtable1.put("result", s20);                    
                }
                else
                {
                    hashtable1.put("result", Helper.formatDoubleValue(d));
                }
                String s4 = SQLParser.getSqlQuery("selindratiopoint^" + s14 + "^" + s18 + "^" + nf.format(d) + "^" + s10);
                if(resultset != null)
                	resultset.close();
                resultset = DBUtils.executeQuery(s4);
                if(resultset.next())
                  s7 = resultset.getString("points");
                hashtable1.put("points", s7);
            }
            catch(Exception exception)
            {
                throw new EJBException("Error in getScoreModel =" + exception.toString());
            }
        }
        finally
        {
            try
            {
                if(resultset != null)
                {
                	resultset.close();
                }
            }
            catch(Exception exception2)
            {
                throw new EJBException("Error closing the connection " + exception2.getMessage());
            }
        }
        return hashtable1;
    }

    private HashMap getBorrowerPosition(HashMap hashtable)
        
    {
        ResultSet resultset = null;
        ResultSet resultset1 = null;
        HashMap hashtable1 = new HashMap();
        HashMap hashtable2 = new HashMap();
        HashMap hashtable3 = new HashMap();
        
        String s10 = "0.00";
        String s11 = "";
        String s12 = "";
        String s15 = "";
        String s16 = "";
        String s17 = "";
        String s18 = "";
        String strQuery="";        
        String as[] = new String[6];
        String as1[] = new String[6];
        String as2[] = new String[6];
        String as3[] = new String[6];
        NumberFormat numberformat = NumberFormat.getNumberInstance();
        numberformat.setGroupingUsed(false);
        numberformat.setMaximumFractionDigits(2);
        numberformat.setMinimumFractionDigits(2);
        double d = 0.0D;
        double d1 = 0.0D;
        
        try
        {
            try
            {
                String s1 = correctNull((String)hashtable.get("appno"));
                String s3 = correctNull((String)hashtable.get("formulano"));
                String s5 = SQLParser.getSqlQuery("selratingfinformula^" + s3);
                if(resultset!=null)
                	resultset.close();
              
                resultset = DBUtils.executeQuery(s5);
                if(resultset.next())
                {
                    s15 = correctNull(resultset.getString(2));
                    s16 = correctNull(resultset.getString(3));
                    s17 = correctNull(resultset.getString(4));
                    s18 = correctNull(resultset.getString(5));
                }
                hashtable3 = findBorrowerExistence(s1);
                hashtable3.put("formulaapplyto", s16);
                String s19 = correctNull((String)hashtable3.get("borrowertype"));
                if(!s16.equals(""))
                {                	
                    if(s16.trim().equalsIgnoreCase("F")) //represent Historical
                    {
                    	if(resultset != null)
                    		resultset.close();
                    	strQuery = SQLParser.getSqlQuery("gethistoryyear^" + s1+"^"+"<=");
                     
                    	resultset = DBUtils.executeQuery(strQuery);
                        if(resultset.next())
                        {
                        	s11 = "<=";
                        	s12 = "desc";
                        }
                        else
                        {
                        	s11 = "<";
                            s12 = "desc";
                        }                        
                    }
                    else
                    if(s16.trim().equals("P"))//represent projected
                    {
                        s11 = ">";
                        s12 = "desc";
                    }
                    else
                    {
                        if(s16.trim().equals("EC"))
                        {
                            String s20 = correctNull((String)hashtable3.get("curyear"));                            
                            if(s19.trim().equals("E"))
                            {
                                hashtable2.put("appno", s1);
                                hashtable2.put("formulaid", s17);
                                hashtable2.put("curryear", s20);
                                hashtable2.put("prevyear", "");
                                hashtable2.put("currfinancialtype", "a");
                                hashtable2.put("prevfinancialtype", "");
                                hashtable2.put("isstress", "");
                                hashtable2.put("hshdata", new HashMap());
                                hashtable1 = GetFinValue(hashtable2);                               
                                String s21 = correctNull((String)hashtable1.get("strTotalValue"));
                                s21 = numberformat.format(Double.parseDouble(s21));
                                hashtable2 = new HashMap();
                                hashtable1 = new HashMap();
                                hashtable2.put("appno", s1);
                                hashtable2.put("formulaid", s17);
                                hashtable2.put("curryear", s20);
                                hashtable2.put("prevyear", "");
                                hashtable2.put("currfinancialtype", "e");
                                hashtable2.put("prevfinancialtype", "");
                                hashtable2.put("isstress", "");
                                hashtable2.put("hshdata", new HashMap());
                                hashtable1 = GetFinValue(hashtable2);                                
                                String s22 = correctNull((String)hashtable1.get("strTotalValue"));
                                s22 = numberformat.format(Double.parseDouble(s22));
                                double d8 = 0.0D;
                                double d10 = 0.0D;
                                if(!s21.trim().equals(""))
                                    d8 = Double.parseDouble(s21);
                                if(!s22.trim().equals(""))
                                    d10 = Double.parseDouble(s22);
                                if(d8 > 0.0D && d10 > 0.0D)
                                    s10 = Helper.formatDoubleValue(d8 / d10);                                
                            }
                            else
                            if(s19.trim().equals("N"))
                                s10 = "2";
                            s10 = numberformat.format(Double.parseDouble(Helper.correctDouble(s10)));
                            hashtable3.put("borrowres", s10);
                            HashMap hashtable4 = hashtable3;
                            return hashtable4;
                        }
                        if(s16.trim().equals("CP"))
                        {
                            double d2 = 0.0D;
                            double d5 = 0.0D;
                                                     
                            if(s19.trim().equals("E"))
                            {
                                String s6 = SQLParser.getSqlQuery("selcumulativeprojyrs^" + s1);
                            	if(resultset != null)
                            		resultset.close();
                            	if(resultset!=null)
                                	resultset.close();                            	
                            	resultset = DBUtils.executeQuery(s6);                                
                                while(resultset.next()) 
                                {
                                    String s24 = correctNull(resultset.getString("projyear"));
                                    String s7 = SQLParser.getSqlQuery("selcumulativeprojpreyrs^" + s1 + "^<^" + s24);
                                    String s25 = "";
                                    String s26 = "";
                                    if(resultset1!=null)
                                    	resultset1.close();
                             
                                resultset1 = DBUtils.executeQuery(s7);
                                if(resultset1.next())
                                {
                                    s25 = resultset1.getString("prevyear");
                                }
                                hashtable2.put("appno", s1);
                                hashtable2.put("formulaid", s17);
                                hashtable2.put("curryear", s24);
                                hashtable2.put("prevyear", s25);
                                hashtable2.put("currfinancialtype", "P");
                                hashtable2.put("prevfinancialtype", s26);
                                hashtable2.put("isstress", "");
                                hashtable2.put("hshdata", new HashMap());
                                hashtable1 = GetFinValue(hashtable2);
                                String s29 = correctNull((String)hashtable1.get("strTotalValue"));
                                if(s29.trim().equals(""))
                                    s29 = "0";
                                d2 += Double.parseDouble(s29);
                               
                                if(!s18.trim().equals(""))
                                {
                                    hashtable2.put("appno", s1);
                                    hashtable2.put("formulaid", s18);
                                    hashtable2.put("curryear", s24);
                                    hashtable2.put("prevyear", s25);
                                    hashtable2.put("currfinancialtype", "P");
                                    hashtable2.put("prevfinancialtype", s26);
                                    hashtable2.put("isstress", "");
                                    hashtable2.put("hshdata", new HashMap());
                                    hashtable1 = GetFinValue(hashtable2);
                                    String s32 = correctNull((String)hashtable1.get("strTotalValue"));
                                    if(s32.trim().equals(""))
                                        s32 = "0";
                                    d5 += Double.parseDouble(s32);
                                }
                            }
                            if(d2 != 0.0D && d5 != 0.0D)
                                s10 = Helper.formatDoubleValue(d2 / d5);
                        }
                        else
                        {
                            s10 = "2";
                        }
                        s10 = numberformat.format(Double.parseDouble(Helper.correctDouble(s10)));
                      hashtable3.put("borrowres", s10);
                      HashMap hashtable5 = hashtable3;
                        return hashtable5;
                    }
                   {                       
                    double d9 = 0.0D;
                    double d12 = 0.0D;                   
                    String s30 = "";                                              
                    if(s19.trim().equals("E"))
                    {
                        String s8 = SQLParser.getSqlQuery("selstressprojyrs^" + s1 + "^>=");
                    	if(resultset != null)
                    		resultset.close();
                        
                    	 resultset = DBUtils.executeQuery(s8);
                        
                        while(resultset.next()) 
                        {
                            double d16 = resultset.getDouble("audit");
                            double d18 = resultset.getDouble("unaudit");
                            double d20 = resultset.getDouble("estimated");
                            double d21 = resultset.getDouble("projection");
                            if(d16 > 0.0D)
                                s30 = "A";
                            else
                            if(d18 > 0.0D)
                                s30 = "U";
                            else
                            if(d20 > 0.0D)
                                s30 = "E";
                            else
                            if(d21 > 0.0D)
                                s30 = "P";
                            String s28 = correctNull(resultset.getString("projyear"));
                            String s9 = SQLParser.getSqlQuery("selpreyrs^" + s1 + "^<^" + s28);
                            String s33 = "";
                            String s34 = "";
                          
                            resultset1 = DBUtils.executeQuery(s9);
                            if(resultset1.next())
                            {
                                s33 = resultset1.getString("prevyear");
                                double d22 = resultset1.getDouble("audit");
                                    double d23 = resultset1.getDouble("unaudit");
                                    double d24 = resultset1.getDouble("estimated");
                                    double d25 = resultset1.getDouble("projection");
                                    if(d22 > 0.0D)
                                        s34 = "A";
                                    else
                                    if(d23 > 0.0D)
                                        s34 = "U";
                                    else
                                    if(d24 > 0.0D)
                                        s34 = "E";
                                    else
                                    if(d25 > 0.0D)
                                        s34 = "P";
                                }
                                hashtable2.put("appno", s1);
                                hashtable2.put("formulaid", s17);
                                hashtable2.put("curryear", s28);
                                hashtable2.put("prevyear", s33);
                                hashtable2.put("currfinancialtype", s30);
                                hashtable2.put("prevfinancialtype", s34);
                                hashtable2.put("isstress", "");
                                hashtable2.put("hshdata", new HashMap());
                                hashtable1 = GetFinValue(hashtable2);
                                String s35 = correctNull((String)hashtable1.get("strTotalValue"));
                                double d4 = 0.0D;
                                double d7 = 0.0D;
                                if(s35.trim().equals(""))
                                    s35 = "0";
                                d4 += Double.parseDouble(s35);
                                String s36 = "0";
                                hashtable2.put("appno", s1);
                                hashtable2.put("formulaid", s17);
                                hashtable2.put("curryear", s28);
                                hashtable2.put("prevyear", s33);
                                hashtable2.put("currfinancialtype", s30);
                                hashtable2.put("prevfinancialtype", s34);
                                hashtable2.put("isstress", "Y");
                                hashtable2.put("hshdata", new HashMap());
                                hashtable1 = GetFinValue(hashtable2);
                                s36 = correctNull((String)hashtable1.get("strTotalValue"));
                                if(s36.trim().equals(""))
                                    s36 = "0";
                                d7 += Double.parseDouble(s36);
                                if(d4 != 0.0D && d7 != 0.0D)
                                {
                                    if(d4 < 0.0D)
                                        d4 = -d4;
                                    d9 += d7 / d4;
                                    d12++;
                                }
                            }							
							if(d9 != 0.0D && d12 != 0.0D)
                            d9 /= d12;
                            s10 = numberformat.format(d9);
                        }
                        else
                        if(s19.trim().equals("N"))
                            s10 = "2";
                        hashtable3.put("borrowres", s10);
                            HashMap hashtable6 = hashtable3;
                            return hashtable6;
                        }
                    }
                    if(!s16.equals("EC") && !s16.equals("CP"))
                        hashtable2 = getRatingFormulaYears(s1, s11, s12);
                    
                    if(hashtable2 != null && hashtable2.size() > 0)
                    {
                        ArrayList ArrayList2 = (ArrayList)hashtable2.get("vecYears");
                        ArrayList ArrayList4 = (ArrayList)hashtable2.get("vecFinType");
                        int i = ArrayList2.size();
                        for(int j = 0; j < i; j++)
                        {
                            if(i > 1)
                            {
                                if(j != i - 1)
                                {
                                    as1[j] = (String)ArrayList2.get(j + 1);
                                    as3[j] = (String)ArrayList4.get(j + 1);
                                }
                                else
                                {
                                    as1[j] = " ";
                                    as3[j] = " ";
                                }
                            }
                            else
                            {
                                as1[j] = " ";
                                as3[j] = " ";
                            }
                            as[j] = (String)ArrayList2.get(j);
                            as2[j] = (String)ArrayList4.get(j);
                        }
                        for(int k = 0; k < i; k++)
                        {
                            hashtable1.put("appno", s1);
                            hashtable1.put("formulaid", correctNull(s17));
                            hashtable1.put("curryear", as[k]);
                            hashtable1.put("prevyear", as1[k]);
                            hashtable1.put("currfinancialtype", as2[k]);
                            hashtable1.put("prevfinancialtype", as3[k]);
                            hashtable1.put("hshdata", new HashMap());
                            hashtable1 = GetFinValue(hashtable1);
                            d += Double.parseDouble((String)hashtable1.get("strTotalValue"));
                            if(k == 0)
                                d1 = Double.parseDouble((String)hashtable1.get("strTotalValue"));
                        }
                        if(d != 0.0D)
                            d /= i;
                        if(s15.equals("H"))
                        {
                            if(d1 < d)
                                d1 = d;
                        }
                        else
                        if(s15.equals("L") && d1 > d)
                            d1 = d;
                        s10 = Helper.formatDoubleValue(d1);
                    }
                }
            }
            catch(Exception exception)
            {
                throw new EJBException("Error in getBorrowerPosition =" + exception.toString());
            }
        }
        finally
        {
            try
            {
                if(resultset != null)
                {
                	resultset.close();
                }
                if(resultset1 != null)
                {
                	resultset1.close();
                }             
            }
            catch(Exception exception2)
            {
                throw new EJBException("Error closing the connection " + exception2.getMessage());
            }
        }
        s10 = numberformat.format(Double.parseDouble(Helper.correctDouble(s10)));        
        hashtable3.put("borrowres", s10);
        return hashtable3;
    }

    private HashMap getRatingFormulaYears(String s, String s1, String s2)
        
    {
       
        ResultSet resultset = null;
        HashMap hashtable = new HashMap();
        int i = 0;
        int j = 0;
        ArrayList ArrayList = new ArrayList();
        ArrayList ArrayList1 = new ArrayList();
        try
        {
            try
            {              
                String s4 ="";
                
                if(s1.trim().equals(">"))
                {
                	s4 = SQLParser.getSqlQuery("selratingyearfinprojnew^" + s + "^" + s1 +"^" + s + "^" + s1+"^" + s + "^" + s1+ "^" + s + "^" + s1 + "^" + s2);
                }
                else
                {
                	s4 = SQLParser.getSqlQuery("selratingyearfinotherthanproj^" + s + "^" + s1 + "^" + s + "^" + s1 + "^" + s2);
                } 
                for( resultset = DBUtils.executeQuery(s4); resultset.next();)
                {
                    if(Integer.parseInt(resultset.getString(2)) <= 6)
                        i = Integer.parseInt(resultset.getString(2));
                    else
                        i = 6;
                    if(j < i)
                        ArrayList.add(correctNull(resultset.getString(1)));
                }
                for(i = 0; i < ArrayList.size(); i++)
                {
                    String s5 = SQLParser.getSqlQuery("selfinancialtype^" + s + "^" + (String)ArrayList.get(i));
                    if(resultset != null)
                    	resultset.close();
                  
                    resultset = DBUtils.executeQuery(s5);
                    if(resultset.next())
                    {
                        if(Double.parseDouble(Helper.correctDouble(resultset.getString("audits"))) != 0.0D)
                            ArrayList1.add("A");
                        else
                        if(Double.parseDouble(Helper.correctDouble(resultset.getString("unaudit"))) != 0.0D)
                            ArrayList1.add("U");
                        else
                        if(Double.parseDouble(Helper.correctDouble(resultset.getString("estimated"))) != 0.0D)
                            ArrayList1.add("E");
                        else
                        if(Double.parseDouble(Helper.correctDouble(resultset.getString("projection"))) != 0.0D)
                            ArrayList1.add("P");
                    }
                    else
                    {
                        ArrayList1.add(" ");
                    }
                }
            }
            catch(Exception exception)
            {
                throw new EJBException("Error in getRatingFormulaYears =" + exception.toString());
            }
        }
        finally
        {
            try
            {
                if(resultset != null)
                    resultset.close();               
           }
            catch(Exception exception2)
            {
                throw new EJBException("Error closing the connection " + exception2.getMessage());
            }
        }
        hashtable.put("vecYears", ArrayList);
        hashtable.put("vecFinType", ArrayList1);
        hashtable.put("numofyears", Integer.toString(i));
        return hashtable;
    }

    public HashMap ListFinData(HashMap hashtable)
        
    {
        ResultSet resultset = null;
        HashMap hashtable1 = new HashMap();
        ArrayList arraylist = new ArrayList();
       
        try
        {
            try
            {               
                String s3 = correctNull((String)hashtable.get("cmano"));
                if(!s3.equalsIgnoreCase(""))
                {
	                String s2 = SQLParser.getSqlQuery("selfinrows^" + s3);
	                ArrayList arraylist1;
	                for(resultset = DBUtils.executeQuery(s2); resultset.next(); arraylist.add(arraylist1))
	                {
	                    arraylist1 = new ArrayList();
	                    arraylist1.add(correctNull(resultset.getString(1)));
	                    arraylist1.add(correctNull(resultset.getString(2)));
	                }
	                hashtable1.put("arryRow", arraylist);
                }
            }
            catch(Exception exception)
            {
                throw new EJBException("Error in getScoreModel =" + exception.toString());
            }
        }
        finally
        {
            try
            {
                if(resultset != null)
                {
                	resultset.close();
                }                
            }
            catch(Exception exception2)
            {
                throw new EJBException("Error closing the connection " + exception2.getMessage());
            }
        }
        return hashtable1;
    }

    private String getComapreValues(String s, String s1, String s2, String s3, String s4, String s5, HashMap hashtable, 
            String s6, String s7, String s8,String sno,String strFinID)
        
    {       
        ResultSet rs = null;
        char c = ' ';
        String s17 = "";
        HashMap hashtable3 = new HashMap();
        try
        {
            try
            {               
                String s10 = s1;
                String s12 = s10.replace('<', c).replace('(', c).replace(')', c).replace('>', c);
                s12 = s12.trim();
                StringTokenizer stringtokenizer = new StringTokenizer(s12, "$");
                String s14 = "";
                String s16 = "";
                s14 = stringtokenizer.nextToken();
                s16 = stringtokenizer.nextToken();
                s16 = s16.substring(2, s16.length());
                hashtable3.put("appno", s);
                hashtable3.put("strFinID", strFinID);
                hashtable3.put("formulaid", s14);
                hashtable3.put("curryear", s2);
                hashtable3.put("prevyear", s3);
                hashtable3.put("currfinancialtype", s4);
                hashtable3.put("prevfinancialtype", s5);
                hashtable3.put("isstress", s8);
                hashtable3.put("hshdata", new HashMap());
                HashMap hashtable2 = GetFinValue(hashtable3);
                
                double d1 = Double.parseDouble((String)hashtable2.get("strTotalValue"));
                hashtable3 = new HashMap();
                hashtable3.put("appno", s);
                hashtable3.put("strFinID", strFinID);
                hashtable3.put("formulaid", s16);
                hashtable3.put("curryear", s2);
                hashtable3.put("prevyear", s3);
                hashtable3.put("currfinancialtype", s4);
                hashtable3.put("prevfinancialtype", s5);
                hashtable2.put("isstress", s8);
                hashtable3.put("hshdata", new HashMap());
                hashtable2 = GetFinValue(hashtable3);
               
                double d3 = Double.parseDouble((String)hashtable2.get("strTotalValue"));
                if(s6.equals("H"))
                {
                    if(d1 < d3)
                        d1 = d3;
                }
                else
                if(s6.equals("L") && d1 > d3)
                    d1 = d3;
                s17 = Helper.formatDoubleValue(d1);
            }
            catch(Exception exception)
            {
                throw new EJBException("Error in GetCompare " + exception.getMessage());
            }
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
            catch(Exception exception2)
            {
                throw new EJBException("Error closing the connection " + exception2.getMessage());
            }
        }
        return s17;
    }

    public HashMap GetFinValue(HashMap hashtable)
        
    {  
    	
        ResultSet resultset = null;
        ResultSet resultset1 = null;
        ResultSet resultset2 = null;
        ResultSet resultset3 = null;
        ResultSet resultset4 = null;
        HashMap hashtable1 = new HashMap();
        String s16 = "";
        String s17 = "";
        ArrayList ArrayList = new ArrayList();        
        NumberFormat numberformat = NumberFormat.getNumberInstance();
        numberformat.setGroupingUsed(false);
        numberformat.setMaximumFractionDigits(2);
        numberformat.setMinimumFractionDigits(2);
        try
        {
            try
            {              
              
            	String sel_divID = correctNull((String)hashtable.get("sel_divID"));
                String s5 = correctNull((String)hashtable.get("appno"));
                //Added by Kishan
        		String strFinID = Helper.correctNull((String)hashtable.get("strFinID"));
        		if(s5.equalsIgnoreCase(""))
        		{
        			s5 = strFinID; //Added By Guhan Tamilvanan, Since appno cannot be NULL
        		}
                String s7 = correctNull((String)hashtable.get("formulaid"));
                String s9 = correctNull((String)hashtable.get("curryear"));
                String s11 = correctNull((String)hashtable.get("prevyear"));
                String s13 = correctNull((String)hashtable.get("currfinancialtype"));
                String s15 = correctNull((String)hashtable.get("prevfinancialtype"));
                String s27 = correctNull((String)hashtable.get("isstress"));
                String s29 = correctNull((String)hashtable.get("ratiostress"));
                strColName = correctNull((String)hashtable.get("colname"));
                strFrom = correctNull((String)hashtable.get("datefrom"));
                strTo = correctNull((String)hashtable.get("dateto"));
                strFormulaApply = correctNull((String)hashtable.get("formulaapply"));
                HashMap hashtable3 = (HashMap)hashtable.get("hshdata");
                hashtable3.put("hshFinYearVal", (HashMap)hashtable.get("hshFinYearVal"));
                String sno = correctNull((String)hashtable.get("sno"));
                String frompage = correctNull((String)hashtable.get("frompage")); 
                if(!frompage.equalsIgnoreCase("cgtmse"))
                {	
                String s1 = SQLParser.getSqlQuery("selfinformula^" + s7);
                if(resultset!=null)
                	resultset.close();	               	
              
                resultset = DBUtils.executeQuery(s1);
                if(resultset.next())
                {
                    s7 = correctNull(resultset.getString("formula"));
                    s16 = correctNull(resultset.getString("formula_for"));
                    if(s29.trim().equalsIgnoreCase("Y"))
                        s16 = "CA";
                    s17 = correctNull(resultset.getString("formula_for_type"));
                }
                else
                {
                    s7 = "";
                }
                }
                else
                {
                	s7= s7 ;
                }
                	
                if(strFormulaApply.trim().equalsIgnoreCase("QIS1") || strFormulaApply.trim().equalsIgnoreCase("QIS2"))
                    strIsQisFormula = "Y";
                else
                    strIsQisFormula = "N";
                String s21;
                if(s17.equals("GT") || s17.equals("NFL") || s17.equals("LTS"))
                    s21 = "Y";
                else
                    s21 = "N";
                String s19;
                if(!s7.equals(""))
                {
                    if(s7.indexOf("?") != -1)
                    {
                        String s23 = s17;
                        String s25 = s16;
                        s19 = getComapreValues(s5, s7, s9, s11, s13, s15, hashtable3, s23, s25, s27,sno,strFinID);
                        ArrayList = new ArrayList();
                        for(int i = 0; i < 4; i++)
                            ArrayList.add("0.00");

                        hashtable1.put("vecTemp", ArrayList);
                    }
                    else
                    if(s16.equals("CA") && (s17.equals("I") || s17.equals("D")))
                    {
                        double d7;
                        if(s7.indexOf("~") == -1)
                        {
                            hashtable1 = FormulaParser(s5, s7, s16, s17, s9, s11, s13, s15, s21, hashtable3, s27,sel_divID,sno,strFinID);
                            double d1 = Double.parseDouble((String)hashtable1.get("strTotalValue"));
                            s9 = s11;
                            s13 = s15;
                            hashtable1 = FormulaParser(s5, s7, s16, s17, s9, s11, s13, s15, s21, hashtable3, s27,sel_divID,sno,strFinID);
                            double d4 = Double.parseDouble((String)hashtable1.get("strTotalValue"));
                            d7 = d1 - d4;
                        }
                        else
                        {
                            hashtable1 = FormulaParser(s5, s7, s16, s17, s9, s11, s13, s15, s21, hashtable3, s27,sel_divID,sno,strFinID);
                            d7 = Double.parseDouble((String)hashtable1.get("strTotalValue"));
                        }
                        
                        if(correctNull(s17).equals("I"))
                        {
                            if(d7 < 0.0D)
                            	d7 = 0.0D;
                        }
                        else
                        if(correctNull(s17).equals("D") && d7 != 0.0D)
                            if(d7 > 0.0D)
                            	d7 = 0.0D;
                            else
                            	d7 *= -1D;
                        s19 = Helper.formatDoubleValue(d7);
                    }
                    else
                    if(s16.equals("FU") && (s17.equals("I") || s17.equals("D") || s17.equals("ID")))
                    {
                        double d8;
                        if(s7.indexOf("~") == -1)
                        {
                            hashtable1 = FormulaParser(s5, s7, s16, s17, s9, s11, s13, s15, s21, hashtable3, s27,sel_divID,sno,strFinID);
                            double d2 = Double.parseDouble((String)hashtable1.get("strTotalValue"));
                            s9 = s11;
                            s13 = s15;
                            hashtable1 = FormulaParser(s5, s7, s16, s17, s9, s11, s13, s15, s21, hashtable3, s27,sel_divID,sno,strFinID);
                            double d5 = Double.parseDouble((String)hashtable1.get("strTotalValue"));
                            d8 = d2 - d5;
                        }
                        else
                        {
                            hashtable1 = FormulaParser(s5, s7, s16, s17, s9, s11, s13, s15, s21, hashtable3, s27,sel_divID,sno,strFinID);
                            d8 = Double.parseDouble((String)hashtable1.get("strTotalValue"));
                        }
                        if(correctNull(s17).equals("I"))
                        {
                            if(d8 < 0.0D)
                                d8 = 0.0D;
                        }
                        else
                        if(correctNull(s17).equals("D") && d8 != 0.0D)
                            if(d8 > 0.0D)
                                d8 = 0.0D;
                            else
                                d8 *= -1D;
                        s19 = Helper.formatDoubleValue(d8);
                    }
                    else
                    {                        
                        if(s16.trim().equals("RA"))
                        {
                            String s2 = SQLParser.getSqlQuery("selrayear^" + strFinID + "^<^" + s9); 
                        	
                            if(resultset3!=null)
                            	resultset3.close();	
                        
                            resultset3 = DBUtils.executeQuery(s2);
                            String s30 = "";
                            String s31 = "";
                            if(resultset3.next())
                            {
                                String s33 = correctNull(resultset3.getString(1));
                                double d12 = resultset3.getDouble(2);
                                double d13 = resultset3.getDouble(3);
                                double d14 = resultset3.getDouble(4);
                                double d15 = resultset3.getDouble(5);
                                if(s33 != "" && d12 > 0.0D)
                                {
                                    s30 = s33;
                                    s31 = "a";
                                }
                                else
                                if(s33 != "" && d13 > 0.0D)
                                {
                                    s30 = s33;
                                    s31 = "u";
                                }
                                else
                                if(s33 != "" && d14 > 0.0D)
                                {
                                    s30 = s33;
                                    s31 = "e";
                                }
                                else
                                if(s33 != "" && d15 > 0.0D)
                                {
                                    s30 = s33;
                                    s31 = "p";
                                }
                            }
                            s11 = s30;
                            s15 = s31;
                        }
                        hashtable1 = FormulaParser(s5, s7, s16, s17, s9, s11, s13, s15, s21, hashtable3, s27,sel_divID,sno,strFinID);
                        s19 = (String)hashtable1.get("strTotalValue");
                        if(s16.equals("FU") && s17.equals("NFL"))
                        {
                            double d9 = Double.parseDouble(s19);
                            if(d9 > 0.0D)
                                d9 = 0.0D;
                            s19 = Helper.formatDoubleValue(d9);
                        }
                        else
                        if(s16.equals("FU") && s17.equals("LTS"))
                        {
                            double d10 = Double.parseDouble(s19);
                            if(d10 < 0.0D)
                                d10 = 0.0D;
                            s19 = Helper.formatDoubleValue(d10);
                        }
                    }
                    ArrayList = (ArrayList)hashtable1.get("vecTemp");
                }
                else
                {
                    s19 = "0.00";
                }
                if(s16.trim().equalsIgnoreCase("RHP"))
                {
                    int j = 0;
                    String s3;
                    if(s11.trim().equals(""))
                    {
                        s3 = SQLParser.getSqlQuery("selholdingdays^" + s9 + "^" + strFinID + "^<^" + s9);
                    }
                    else
                    {
                        s3 = SQLParser.getSqlQuery("selyeardate^" + strFinID + "^" + s11);
                      
                        if(resultset1!=null)
                        	resultset1.close();	
                      
                        resultset1 = DBUtils.executeQuery(s3);
                        String s32 = "";
                        if(resultset1.next())
                            s32 = correctNull(resultset1.getString("fin_year"));
                        s3 = SQLParser.getSqlQuery("selyeardate^" + strFinID + "^" + s9);
                    
                        if(resultset2!=null)
                        	resultset2.close();	
                      
                        resultset2 = DBUtils.executeQuery(s3);
                        String s34 = "";
                        if(resultset2.next())
                            s34 = correctNull(resultset2.getString("fin_year"));
                        s3 = SQLParser.getSqlQuery("selholdingdays1^" + s32 + "^" + s34 + "^" + strFinID + "^<^" + s9);
                    }
                    if(resultset4!=null)
                    	resultset4.close();	
                  
                    resultset4 = DBUtils.executeQuery(s3);
                    if(resultset4.next())
                        j = resultset4.getInt(1);
                    else
                        j = 365;
                    double d11 = Double.parseDouble(s19);
                    d11 *= j;
                    s19 = Helper.formatDoubleValue(d11);
                }
                s19 = numberformat.format(Double.parseDouble(Helper.correctDouble(s19)));
                hashtable1 = new HashMap();
                hashtable1.put("strTotalValue", s19);
                hashtable1.put("vecTemp", ArrayList);
                hashtable1.put("strisInternalCalc", s21);
            }
            catch(Exception exception)
            {
                throw new EJBException("Error in GetFinValue =" + exception.toString());
            }
        }
        finally
        {
            try
            {
                if(resultset != null)
                    resultset.close();
                if(resultset1 != null)
                    resultset1.close();
                if(resultset2 != null)
                    resultset2.close();
                if(resultset3 != null)
                    resultset3.close();
                if(resultset4 != null)
                    resultset4.close();
              
            }
            catch(Exception exception2)
            {
                throw new EJBException("Error closing the connection " + exception2.getMessage());
            }
        }
        return hashtable1;
    }

    private HashMap FormulaParser(String s, String s1, String s2, String s3, String s4, String s5, String s6, 
            String s7, String s8, HashMap hashtable, String s9,String sel_divID,String sno,String strFinID)
        
    {
       
		ResultSet rs = null;
        HashMap hashtable1 = new HashMap();
        String s11 = "0.00";
        char c = ' ';
        String s23 = "";
        
        int l1 = 0;
        int i2 = 0;
        
        ArrayList ArrayList = new ArrayList();
        
        NumberFormat numberformat = NumberFormat.getNumberInstance();
        numberformat.setGroupingUsed(false);
        numberformat.setMaximumFractionDigits(2);
        numberformat.setMinimumFractionDigits(2);
        try
        {
            try
            {
                for(int j2 = 0; j2 < 4; j2++)
                    ArrayList.add("0.00");

                StringTokenizer stringtokenizer = new StringTokenizer(s1, "$");
                String s25 = stringtokenizer.nextToken();
                int i = s25.indexOf("*");
                while(s1.indexOf("$") != -1 || s1.indexOf("~") != -1) 
                {
                    String s13 = s1;
                    int j1 = s13.indexOf(">");
                    int l = s13.indexOf("<", l1);
                    i = s13.indexOf("<", l1);
                    while(l < j1) 
                    {
                        l = s13.indexOf("<", l1);
                        if(l < s13.lastIndexOf("<") && l < j1)
                        {
                            i = s13.indexOf("<", l1);
                            l1 = l + 1;
                            continue;
                        }
                        if(l > j1)
                            l = i;
                        break;
                    }

                    l1 = 0;
                    String s17 = s13.substring(l - 1, j1 + 1);
                    String s26 = s17.replace('<', c).replace('(', c).replace(')', c).replace('>', c);
                    s26 = s26.trim();
                    StringTokenizer stringtokenizer3 = new StringTokenizer(s26, "$");
                    String s31 = "";
                    String s34 = "";
                    String s21 = "";
                    while(stringtokenizer3.hasMoreTokens()) 
                    {
                        String s27 = stringtokenizer3.nextToken();
                        if(s27.indexOf("~") != -1)
                        {
                            s27 = s27 + "$";
                            for(StringTokenizer stringtokenizer4 = new StringTokenizer(s27, "~"); stringtokenizer4.hasMoreTokens();)
                            {
                                s27 = stringtokenizer4.nextToken();
                                if(!s27.equals("$"))
                                    if(s27.indexOf("&") != -1)
                                    {
                                        i = s27.indexOf("&");
                                        s21 = s27.substring(i - 1, i);
                                        s31 = s27.substring(0, i);
                                        s34 = s27.substring(i + 1);
                                        if(s34.indexOf("$") != -1)
                                        {
                                            s34 = s34.replace('$', c).trim();
                                            s27 = s27.replace('$', c).trim();
                                            HashMap hashtable3 = getStrIDValue(s27, s31, s34, s23, s21, s, s4, s6, s8, hashtable, ArrayList, s4, s5, s6, s7, s9,sel_divID,sno);
                                            s23 = (String)hashtable3.get("strIdValues");
                                            ArrayList = (ArrayList)hashtable3.get("vecTemp");
                                        }
                                        else
                                        {
                                            HashMap hashtable4 = getStrIDValue(s27, s31, s34, s23, s21, s, s5, s7, s8, hashtable, ArrayList, s4, s5, s6, s7, s9,sel_divID,sno);
                                            s23 = (String)hashtable4.get("strIdValues");
                                            ArrayList = (ArrayList)hashtable4.get("vecTemp");
                                        }
                                        s21 = "";
                                    }
                                    else
                                    {
                                        HashMap hashtable5 = getStrIDValue(s27, s31, s34, s23, s21, s, s5, s7, s8, hashtable, ArrayList, s4, s5, s6, s7, s9,sel_divID,sno);
                                        s23 = (String)hashtable5.get("strIdValues");
                                        ArrayList = (ArrayList)hashtable5.get("vecTemp");
                                        s21 = "";
                                    }
                            }

                        }
                        else
                        {
                            if(s27.indexOf("&") != -1)
                            {
                                i = s27.indexOf("&");
                                s21 = s27.substring(i - 1, i);
                                s31 = s27.substring(0, i);
                                s34 = s27.substring(i + 1);
                            }
                            HashMap hashtable6 = getStrIDValue(s27, s31, s34, s23, s21, s, s4, s6, s8, hashtable, ArrayList, s4, s5, s6, s7, s9,sel_divID,sno);
                            s23 = (String)hashtable6.get("strIdValues");
                            ArrayList = (ArrayList)hashtable6.get("vecTemp");
                        }
                    }

                    s23 = s23 + "#";
                    StringBuffer stringbuffer1 = new StringBuffer(s1);
                    stringbuffer1 = stringbuffer1.replace(l - 1, j1 + 1, s23);
                    s1 = stringbuffer1.toString();
                }

                s11 = s1;
                i = 0;
                l1 = 0;                
                
                double d1 = 0.0D;
                
                if(s1.indexOf("&") != -1)
                    s11 = "0.00";
                while(s1.indexOf("&") != -1) 
                {
                    String s15 = s1;
                    int k1 = s15.indexOf(">");
                    int i1 = s15.indexOf("<", l1);
                    int j = s15.indexOf("<", l1);
                    while(i1 < k1) 
                    {
                        i1 = s15.indexOf("<", l1);
                        if(i1 < s15.lastIndexOf("<") && i1 < k1)
                        {
                            j = s15.indexOf("<", l1);
                            l1 = i1 + 1;
                            continue;
                        }
                        if(i1 > k1)
                            i1 = j;
                        break;
                    }

                    l1 = 0;
                    String s19 = s15.substring(i1 - 1, k1 + 1);
                    String s28 = s19.replace('<', c).replace('(', c).replace(')', c).replace('>', c);
                    s28 = s28.trim();
                    StringTokenizer stringtokenizer2 = new StringTokenizer(s28, "#");
                    
                    while(stringtokenizer2.hasMoreTokens()) 
                    {
                        String s29 = stringtokenizer2.nextToken();
                        i2++;
                        if(s29.indexOf("&") != -1)
                        {
                            int k = s29.indexOf("&");
                            String s22 = s29.substring(k - 1, k);
                            String s36 = s29.substring(k + 1);
                            if(s22.equals("+"))
                                s11 = Helper.formatDoubleValue(Double.parseDouble(s11) + Double.parseDouble(s36));
                            else
                            if(s22.equals("-"))
                                s11 = Helper.formatDoubleValue(Double.parseDouble(s11) - Double.parseDouble(s36));
                            else
                            if(s22.equals("*"))
                            {
                                if(!s36.equals("0"))
                                {
                                    double d4 = Double.parseDouble(s36);
                                    if(d4 != 0.0D)
                                        d1 = Double.parseDouble(s11) * Double.parseDouble(s36);
                                    else
                                        d1 = 0.0D;
                                    if(Double.isNaN(d1) || Double.isInfinite(d1))
                                        s11 = "0.00";
                                    else
                                        s11 = Helper.formatDoubleValue(d1);
                                }
                            }
                            else
                            if(s22.equals("/") && !s36.equals("0"))
                            {
                                double d5 = Double.parseDouble(s36);
                                if(d5 != 0.0D)
                                    d1 = Double.parseDouble(s11) / Double.parseDouble(s36);
                                else
                                    d1 = 0.0D;
                                if(Double.isNaN(d1) || Double.isInfinite(d1))
                                    s11 = "0.00";
                                else
                                    s11 = Helper.formatDoubleValue(d1);
                            }
                        }
                        else
                        {
                            s11 = Helper.formatDoubleValue(Double.parseDouble("0.00") + Double.parseDouble(s29));
                        }
                    }

                    s11 = s11 + "#";
                    StringBuffer stringbuffer = new StringBuffer(s1);
                    stringbuffer = stringbuffer.replace(i1 - 1, k1 + 1, s11);
                    s11 = s11.replace('#', c).trim();
                    s1 = stringbuffer.toString();
                    stringtokenizer2 = new StringTokenizer(s1, "&");
                }

                s11 = s11.replace('#', c).trim();
                d1 = Double.parseDouble(s11);
                s11 = Helper.formatDoubleValue(d1);
                s11 = numberformat.format(Double.parseDouble(Helper.correctDouble(s11)));
            }
            catch(Exception exception)
            {
                throw new EJBException("Error in FormulaParser =" + exception.toString());
            }
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
            catch(Exception exception2)
            {
                throw new EJBException("Error closing the connection " + exception2.getMessage());
            }
        }
        hashtable1.put("strTotalValue", s11);
        hashtable1.put("vecTemp", ArrayList);
        return hashtable1;
    }

    private HashMap getStrIDValue(String s, String s1, String s2, String s3, String s4, String s5, String s6, 
            String s7, String s8, HashMap hashtable, ArrayList ArrayList, String s9, String s10, String s11, 
            String s12, String s13,String sel_divID,String sno)
        
    {
    	
    	
    	HashMap hshFinYearVal	= new HashMap();
    	hshFinYearVal			= (HashMap)hashtable.get("hshFinYearVal");
       
        HashMap hashtable1 = new HashMap();
        HashMap hashtable2 = new HashMap();
        if(!s1.trim().equals("") && s1.indexOf("#") != -1)
        {
            int i = s1.indexOf("#");
            s3 = s.substring(0, i);
        }
        if(!s2.trim().equals("") && s2.indexOf("#") != -1)
        {
            int j = s2.indexOf("#");
            if(s4.length() != 0)
            {
                if(s4.equals("+"))
                    s3 = Helper.formatDoubleValue(Double.parseDouble(s3) + Double.parseDouble(s2.substring(0, j)));
                if(s4.equals("-"))
                    s3 = Helper.formatDoubleValue(Double.parseDouble(s3) - Double.parseDouble(s2.substring(0, j)));
                if(s4.equals("*"))
                {
                    double d6 = Double.parseDouble(s3) * Double.parseDouble(s2.substring(0, j));
                    if(Double.isNaN(d6) || Double.isInfinite(d6))
                        s3 = "0.00";
                    else
                        s3 = Helper.formatDoubleValue(d6);
                }
                if(s4.equals("/"))
                {
                    double d7 = Double.parseDouble(s3) / Double.parseDouble(s2.substring(0, j));
                    if(Double.isNaN(d7) || Double.isInfinite(d7))
                        s3 = "0.00";
                    else
                        s3 = Helper.formatDoubleValue(d7);
                }
            }
            s2 = "0";
        }
        if(s4.length() == 0)
        {
            if(!s8.equals("Y"))
            {
                s3 = getIDData(s5, s6, s, s7, s13,sel_divID,sno,hshFinYearVal);
            }
            else
            {
                s3 = "0.00";
                hashtable2.put("appno", s5);
                hashtable2.put("formulaid", s);
                hashtable2.put("curryear", s9);
                hashtable2.put("prevyear", s10);
                hashtable2.put("currfinancialtype", s11);
                hashtable2.put("prevfinancialtype", s12);
                hashtable2.put("isstress", s13);
                hashtable2.put("hshdata", new HashMap());
                hashtable2.put("hshFinYearVal", hshFinYearVal);
                hashtable2.put("sno", sno);
                hashtable2 = GetFinValue(hashtable2);
                s3 = (String)hashtable2.get("strTotalValue");
            }
        }
        else
        if(s4.equals("+"))
        {
            if(!s8.equals("Y"))
            {
                s3 = Helper.formatDoubleValue(Double.parseDouble(s3) + Double.parseDouble(getIDData(s5, s6, s2, s7, s13,sel_divID,sno,hshFinYearVal)));
            }
            else
            {
                hashtable2.put("appno", s5);
                hashtable2.put("formulaid", s2);
                hashtable2.put("curryear", s9);
                hashtable2.put("prevyear", s10);
                hashtable2.put("currfinancialtype", s11);
                hashtable2.put("prevfinancialtype", s12);
                hashtable2.put("isstress", s13);
                hashtable2.put("hshdata", new HashMap());
                hashtable2.put("hshFinYearVal", hshFinYearVal);
                hashtable2.put("sno", sno);
                hashtable2 = GetFinValue(hashtable2);
                s3 = Helper.formatDoubleValue(Double.parseDouble(s3) + Double.parseDouble((String)hashtable2.get("strTotalValue")));
            }
        }
        else
        if(s4.equals("-"))
        {
            if(!s8.equals("Y"))
            {
                s3 = Helper.formatDoubleValue(Double.parseDouble(s3) - Double.parseDouble(getIDData(s5, s6, s2, s7, s13,sel_divID,sno,hshFinYearVal)));
            }
            else
            {
                hashtable2.put("appno", s5);
                hashtable2.put("formulaid", s2);
                hashtable2.put("curryear", s9);
                hashtable2.put("prevyear", s10);
                hashtable2.put("currfinancialtype", s11);
                hashtable2.put("prevfinancialtype", s12);
                hashtable2.put("isstress", s13);
                hashtable2.put("hshdata", new HashMap());
                hashtable2.put("hshFinYearVal", hshFinYearVal);
                hashtable2 = GetFinValue(hashtable2);
                hashtable2.put("sno", sno);
                s3 = Helper.formatDoubleValue(Double.parseDouble(s3) - Double.parseDouble((String)hashtable2.get("strTotalValue")));
            }
        }
        else
        if(s4.equals("*"))
        {
            if(!s2.equals("0"))
                if(!s8.equals("Y"))
                {
                    double d8 = Double.parseDouble(getIDData(s5, s6, s2, s7, s13,sel_divID,sno,hshFinYearVal));
                    double d1;
                    if(d8 != 0.0D)
                        d1 = Double.parseDouble(s3) * d8;
                    else
                        d1 = 0.0D;
                    if(Double.isNaN(d1) || Double.isInfinite(d1))
                        s3 = "0.00";
                    else
                        s3 = Helper.formatDoubleValue(d1);
                }
                else
                {
                    hashtable2.put("appno", s5);
                    hashtable2.put("formulaid", s2);
                    hashtable2.put("curryear", s9);
                    hashtable2.put("prevyear", s10);
                    hashtable2.put("currfinancialtype", s11);
                    hashtable2.put("prevfinancialtype", s12);
                    hashtable2.put("isstress", s13);
                    hashtable2.put("hshdata", new HashMap());
                    hashtable2.put("hshFinYearVal", hshFinYearVal);
                    hashtable2 = GetFinValue(hashtable2);
                    hashtable2.put("sno", sno);
                    double d9 = Double.parseDouble((String)hashtable2.get("strTotalValue"));
                    double d2;
                    if(d9 != 0.0D)
                        d2 = Double.parseDouble(s3) * d9;
                    else
                        d2 = 0.0D;
                    if(Double.isNaN(d2) || Double.isInfinite(d2))
                        s3 = "0.00";
                    else
                        s3 = Helper.formatDoubleValue(d2);
                }
        }
        else
        if(s4.equals("/") && !s2.equals("0"))
            if(!s8.equals("Y"))
            {
                double d10 = Double.parseDouble(getIDData(s5, s6, s2, s7, s13,sel_divID,sno,hshFinYearVal));
                double d3;
                if(d10 != 0.0D)
                    d3 = Double.parseDouble(s3) / d10;
                else
                    d3 = 0.0D;
                if(Double.isNaN(d3) || Double.isInfinite(d3))
                    s3 = "0.00";
                else
                    s3 = Helper.formatDoubleValue(d3);
            }
            else
            {
                hashtable2.put("appno", s5);
                hashtable2.put("formulaid", s2);
                hashtable2.put("curryear", s9);
                hashtable2.put("prevyear", s10);
                hashtable2.put("currfinancialtype", s11);
                hashtable2.put("prevfinancialtype", s12);
                hashtable2.put("isstress", s13);
                hashtable2.put("hshdata", new HashMap());
                hashtable2.put("hshFinYearVal", hshFinYearVal);
                hashtable2.put("sno", sno);
                hashtable2 = GetFinValue(hashtable2);
                double d11 = Double.parseDouble((String)hashtable2.get("strTotalValue"));
                double d4;
                if(d11 != 0.0D)
                    d4 = Double.parseDouble(s3) / d11;
                else
                    d4 = 0.0D;
                if(Double.isNaN(d4) || Double.isInfinite(d4))
                    s3 = "0.00";
                else
                    s3 = Helper.formatDoubleValue(d4);
            }
        hashtable1.put("strIdValues", s3);
        hashtable1.put("vecTemp", ArrayList);
        return hashtable1;
    }

    private ArrayList calculateInternalCalculation(String s, ArrayList ArrayList, HashMap hashtable)
        
    {
        
        ArrayList ArrayList3 = new ArrayList();
       
        try
        {
            String s4 = s;
            s4 = (String)hashtable.get(s4);
            ArrayList ArrayList2 = (ArrayList)hashtable.get(s4);
            for(int i = 0; i < 4; i++)
                ArrayList3.add(Helper.formatDoubleValue(Double.parseDouble((String)ArrayList.get(i)) + Double.parseDouble((String)ArrayList2.get(i))));

        }
        catch(Exception exception)
        {
            throw new EJBException("Error in calculateInternalCalculation------" + exception.toString());
        }
        return ArrayList3;
    }

    private String getIDData(String s, String s1, String s2, String s3, String s4,String sel_divID,String sno,HashMap hshFinYearVal)
        
    {  
    	
    	
        ResultSet resultset = null;
        String s5 = "";
        String s6 = "";
        String s7 = "";
        String s8 = "Y";
        String s12 = "0.00";
        double d2 = 0.0D;
        if(!s8.equals(""))
            s8 = s4;
        try
        {
            try
            {
               
                if(strIsQisFormula.trim().equals("N"))
                {
                    if(s3.equalsIgnoreCase("A"))
                        s7 = "fin_audit";
                    else
                    if(s3.equalsIgnoreCase("U"))
                        s7 = "fin_unaudit";
                    else
                    if(s3.equalsIgnoreCase("E"))
                        s7 = "fin_estimated";
                    else
                    if(s3.equalsIgnoreCase("P"))
                        s7 = "fin_projection";
                    else
                        if(s3.equalsIgnoreCase("S"))//By venu for sensitive analysis--[projection year only]
                              s7 = "fin_stress_projection"; 
                    
                    if(s8.equals("Y") && (s3.equals("E") || s3.equals("P")))
                    {
                        s5 = SQLParser.getSqlQuery("selstressvalues^" + s2);
                        if(resultset!=null)
                        	resultset.close();
                     
                        resultset = DBUtils.executeQuery(s5);
                        if(resultset.next())
                        {
                            s12 = resultset.getString("fin_stress_percent");
                        }
                        else
                        {
                            s12 = "0.00";
                        }
                    }
                    double d1 = (100D - Double.parseDouble(s12)) / 100D;
                    if(Double.isNaN(d1) || Double.isInfinite(d1))
                        d1 = 1.0D;
                    if(!s7.trim().equals("") && !s.trim().equals("") && !s1.trim().equals("") && !s2.trim().equals(""))
                    {
                    	
                    	if(sel_divID.equalsIgnoreCase(""))
                    	{
                    		sel_divID="0";
                    	}
                    	
//                    	modified by S.SATHYA MOORTHY FOR EXCEPTION OCCURRED IN THE CASH FLOW AND FINANICAL PAGE.
                    	if(s1.length()<=4)
                    	{
                    		if(hshFinYearVal!=null)
                    		{
                    			s6	= Helper.correctDouble((String)((HashMap)hshFinYearVal.get(s1)).get(s2));
                    		}
                    		else
                    		{
                    			s5 = SQLParser.getSqlQuery("selfinformulavalues_cashflow^" + s7 + "^" + s + "^" + s1 + "^" + s2+"^"+sel_divID+"^"+sno);
                    		}
                    	}
                    	else
                    	{
                    		if(hshFinYearVal!=null)
                    		{
                    			s6	= Helper.correctDouble((String)((HashMap)hshFinYearVal.get(s1)).get(s2));
                    		}
                    		else
                    		{
                    			s5 = SQLParser.getSqlQuery("selfinformulavalues^" + s7 + "^" + s + "^" + s1 + "^" + s2+"^"+sel_divID+"^"+sno);
                    		}
                    		
                    	}
                        if(resultset != null)
                            resultset.close();
                        if(hshFinYearVal==null)
                        {
	                        resultset = DBUtils.executeQuery(s5);
	                        if(resultset.next())
	                        	s6 = resultset.getString("columname");
                        }
                    }
                    if(s6.equals(""))
                        s6 = "0.00";
                    s6 = Helper.formatDoubleValue(Double.parseDouble(s6) * d1);
                    d2 = Double.parseDouble(s6);
                }
                else
                if(strIsQisFormula.trim().equals("Y"))
                {
                    if(strFormulaApply.trim().equals("QIS1"))
                        s5 = SQLParser.getSqlQuery("selqisdata^" + strColName + "^" + s + "^" + s2 + "^>^" + strFrom + "^<^" + strTo);
                    else
                    if(strFormulaApply.trim().equals("QIS2"))
                        s5 = SQLParser.getSqlQuery("selqisdata^" + strColName + "^" + s + "^" + s2 + "^>^" + strFrom + "^<^" + strTo);
                    if(resultset != null)
                        resultset.close();
                   
                    resultset = DBUtils.executeQuery(s5);
                    if(resultset.next())
                        s6 = resultset.getString(1);
                    if(s6.equals(""))
                        s6 = "0.00";
                    d2 = Double.parseDouble(s6);
                }
                if(Double.isNaN(d2) || Double.isInfinite(d2))
                    s6 = "0.00";
            }
            catch(Exception exception)
            {
                throw new EJBException("Error in getIDData =" + exception.toString());
            }
        }
        finally
        {
            try
            {
                if(resultset != null)
                    {
                	resultset.close();
                    }
             
            }
            catch(Exception exception2)
            {
                throw new EJBException("Error closing the connection getIDData " + exception2.getMessage());
            }
        }
        return s6;
    }

    public HashMap getYearsData(HashMap hashtable)
        
    {
     
        ResultSet resultset = null;
        ArrayList ArrayList = new ArrayList();
        
        HashMap hashtable1 = new HashMap();
        
        try
        {
            try
            {               
                hashtable1 = new HashMap();
                String s3 = correctNull((String)hashtable.get("appno"));
                String s1 = SQLParser.getSqlQuery("selfinacialyears^" + s3);
                for( resultset = DBUtils.executeQuery(s1); resultset.next(); ArrayList.add(resultset.getString(1)));
                hashtable1.put("vecVal", ArrayList);
            }
            catch(Exception exception)
            {
                throw new EJBException("Error in getYearsData login  " + exception.toString());
            }
        }
        finally
        {
            try
            {
                if(resultset != null)
                    {
                	resultset.close();
                    }
               
            }
            catch(Exception exception2)
            {
                throw new EJBException("Error closing the connection getYearsData " + exception2.getMessage());
            }
        }
        return hashtable1;
    }

    public HashMap GetCashFlowData(HashMap hashtable)
        
    {
        String as[] = new String[4];
        String as1[] = new String[4];
        String as2[] = new String[4];
        String as3[] = new String[4];
        String s5 = "N";
        HashMap hashtable1 = new HashMap();
        HashMap hashtable2 = new HashMap();
        boolean flag2 = false;
        int l1 = 0;
        ResultSet rs=null;
        String strQuery="";
        HashMap hshRecord=new HashMap();
        try
        {
            String s1 = correctNull((String)hashtable.get("appno"));
            String s4 = correctNull((String)hashtable.get("flowtype"));
            String cma=correctNull((String)hashtable.get("cma"));
            if(cma.equals(""))
            {
	           // strQuery=SQLParser.getSqlQuery("finselect8^"+s1);
            	strQuery=SQLParser.getSqlQuery("comfintrendsel1^"+s1);
	    		rs=DBUtils.executeQuery(strQuery);
	    		if(rs.next())
	    		{
	    			cma=correctNull(rs.getString("demo_finstandard"));
	    			//hashtable1.put("cma_index",cma);
	    		}
            }
            //else
            //{
            	hashtable1.put("cma_index",cma);
            //}
    		if(rs != null)
			{
				rs.close();
			}
            int i = Integer.parseInt((String)hashtable.get("yearfrom"));
            HashMap hashtable4 = getCashFlowYears(s1);
            ArrayList ArrayList5 = (ArrayList)hashtable4.get("vecYears");
            ArrayList ArrayList7 = (ArrayList)hashtable4.get("vecFinType");
            int i2 = ArrayList5.size();
            hashtable1.put("yearfrom", Integer.toString(i));
            hashtable1.put("totalnoofyears", Integer.toString(i2));
            int j = i + 4;
            int i1;
            if(j <= i2)
                i1 = j;
            else
                i1 = i2;
            for(int k = i; k < i1; k++)
            {
                as1[l1] = (String)ArrayList5.get(k - 1);
                as3[l1] = (String)ArrayList7.get(k - 1);
                as[l1] = (String)ArrayList5.get(k);
                as2[l1] = (String)ArrayList7.get(k);
                flag2 = true;
                l1++;
            }

            for(int j1 = 0; j1 < l1; j1++)
            {
                hashtable1.put("fincurryear" + Integer.toString(j1 + 1), as[j1]);
                hashtable1.put("finprevyear" + Integer.toString(j1 + 1), as1[j1]);
                hashtable1.put("fincurrtype" + Integer.toString(j1 + 1), as2[j1]);
                hashtable1.put("finprevtype" + Integer.toString(j1 + 1), as3[j1]);
            }

            for(int k1 = l1; k1 < 4; k1++)
            {
                hashtable1.put("fincurryear" + Integer.toString(k1 + 1), "");
                hashtable1.put("finprevyear" + Integer.toString(k1 + 1), "");
                hashtable1.put("fincurrtype" + Integer.toString(k1 + 1), "");
                hashtable1.put("finprevtype" + Integer.toString(k1 + 1), "");
            }

            i2 = l1;
            if(flag2)
            {
                String s2 = correctNull((String)hashtable.get("appno"));
                
                if(s4.equals("SCA"))
                {
                    s4 = "SCA";
                    s5 = "Y";
                }
                if(!s4.equals("TERCA"))
                {
                	hashtable2 = getCMADetails(cma, s4);
                }
                else
                {
                	 hashtable2 = getPERCMADetails(s2, cma);
                }
                for(int l = 1; l <= hashtable2.size(); l++)
                {
                    ArrayList ArrayList1 = new ArrayList();
                    ArrayList1 = (ArrayList)hashtable2.get(Integer.toString(l));
                    if(ArrayList1 != null && ArrayList1.size() > 0)
                    {
                        String s7 = (String)ArrayList1.get(1);
                        hashtable1.put("Label" + Integer.toString(l), s7);
                        hashtable1.put("RowType" + Integer.toString(l), (String)ArrayList1.get(2));
                        hashtable1.put((String)ArrayList1.get(3), "vecData" + Integer.toString(l));
                        ArrayList ArrayList3 = getCashFlowValues(s2, ArrayList1, as1, as, as3, as2, i2, hashtable1, s4, s5);
                        hashtable1.put("vecData" + Integer.toString(l), ArrayList3);
                    }
                }

            }
            hashtable1.put("totvalue", Integer.toString(hashtable2.size()));
            
            if(s4.equals("CA"))
            {
            	strQuery = SQLParser.getSqlQuery("executive_finnotes_sel^"+s1+"^"+"CA"+"^0");
            	if(rs!=null)
            		rs.close();
            	rs=DBUtils.executeQuery(strQuery);
            	if(rs.next())
            	{
            		hashtable1.put("exec_notes",correctNull(Helper.CLOBToString(rs.getClob("notes"))));
            	}
            }
        }
        catch(Exception exception)
        {
            throw new EJBException("Error in getCashFlowValues login  " + exception.toString());
        }
        return hashtable1;
    }

    private HashMap getCashFlowYears(String s)
        
    {
       
        ResultSet resultset = null;
        ArrayList ArrayList = new ArrayList();
        ArrayList ArrayList1 = new ArrayList();
        ArrayList ArrayList2 = new ArrayList();
        ArrayList ArrayList3 = new ArrayList();       
        HashMap hashtable = new HashMap();
       
        String s4 = "";
        
        int k1 = 0;
        try
        {
            try
            {
              
                hashtable = new HashMap();
                String s2 = SQLParser.getSqlQuery("selcashflowyears^" + s);
                for( resultset = DBUtils.executeQuery(s2); resultset.next(); ArrayList.add(correctNull(resultset.getString("fin_year"))));
                s2 = SQLParser.getSqlQuery("selcurrentyear");
                if(resultset!=null)
                	resultset.close();
               
                resultset = DBUtils.executeQuery(s2);
                if(resultset.next())
                    s4 = correctNull(resultset.getString("curryear"));
                if(ArrayList != null && ArrayList.size() > 0)
                {
                    int i = 0;
                    for(int j1 = Integer.parseInt((String)ArrayList.get(i)); j1 <= Integer.parseInt(s4); j1 = Integer.parseInt((String)ArrayList.get(i)))
                    {
                        ArrayList1.add((String)ArrayList.get(i));
                        if(Integer.parseInt((String)ArrayList.get(i)) == Integer.parseInt(s4))
                        {
                            
                            k1 = i;         
                        }
                        if(++i >= ArrayList.size())
                            break;
                    }

                    k1 = i - 1;
                    for(; i < ArrayList.size(); i++)
                        ArrayList1.add((String)ArrayList.get(i));

                }
                int i1;
                if(k1 <= 3)
                    i1 = 0;
                else
                    i1 = k1 - 3;
                int j = k1;
                if(ArrayList != null && ArrayList.size() > 0)
                    for(; i1 <= j; i1++)
                        ArrayList2.add((String)ArrayList1.get(i1));

                for(int k = k1 + 1; k < ArrayList.size(); k++)
                    ArrayList2.add((String)ArrayList1.get(k));

                for(int l = 0; l < ArrayList2.size(); l++)
                {
                    String s3 = SQLParser.getSqlQuery("selfinancialtype^" + s + "^" + (String)ArrayList2.get(l));
                    if(resultset != null)
                        resultset.close();
                 
                    resultset = DBUtils.executeQuery(s3);
                    if(resultset.next())
                    {
                        if(Double.parseDouble(Helper.correctDouble(resultset.getString("audits"))) != 0.0D)
                            ArrayList3.add("A");
                        else
                        if(Double.parseDouble(Helper.correctDouble(resultset.getString("unaudit"))) != 0.0D)
                            ArrayList3.add("U");
                        else
                        if(Double.parseDouble(Helper.correctDouble(resultset.getString("estimated"))) != 0.0D)
                            ArrayList3.add("E");
                        else
                        if(Double.parseDouble(Helper.correctDouble(resultset.getString("projection"))) != 0.0D)
                            ArrayList3.add("P");
                        else
                            ArrayList3.add(" ");
                    }
                    else
                    {
                        ArrayList3.add(" ");
                    }
                }

            }
            catch(Exception exception)
            {
                throw new EJBException("Error in getCMADetails login  " + exception.toString());
            }
        }
        finally
        {
            try
            {
                if(resultset != null)
                    {
                	resultset.close();
                    }
               
            }
            catch(Exception exception2)
            {
                throw new EJBException("Error closing the connection getCMADetails-- " + exception2.getMessage());
            }
        }
        hashtable.put("vecYears", ArrayList2);
        hashtable.put("vecFinType", ArrayList3);
        return hashtable;
    }

    private ArrayList getCashFlowValues(String s, ArrayList ArrayList, String as[], String as1[], String as2[], String as3[], int i, 
            HashMap hashtable, String s1, String s2)
        
    {
        ArrayList ArrayList1 = new ArrayList();
        HashMap hashtable1 = new HashMap();
        String s5 = "";
        String s6 = " ";
        
        try
        {
            for(int j = 1; j <= i; j++)
                if(ArrayList != null && ArrayList.size() > 0)
                {
                    s5 = correctNull((String)ArrayList.get(2));
                    if(s5.equals("HE"))
                        ArrayList1.add(s6);
                    else
                    if(s5.equals("FO"))
                    {
                        hashtable1.put("appno", s);
                        hashtable1.put("formulaid", correctNull((String)ArrayList.get(3)));
                        hashtable1.put("curryear", as1[j - 1]);
                        hashtable1.put("prevyear", as[j - 1]);
                        hashtable1.put("currfinancialtype", as3[j - 1]);
                        hashtable1.put("prevfinancialtype", as2[j - 1]);
                        hashtable1.put("isstress", s2);
                        hashtable1.put("hshdata", hashtable);
                        hashtable1 = GetFinValue(hashtable1);
                        ArrayList1.add(hashtable1.get("strTotalValue"));
                    }
                }

            for(int k = i + 1; k <= 4; k++)
                if(s5.equals("HE"))
                    ArrayList1.add(s6);
                else
                if(s5.equals("FO"))
                    ArrayList1.add("0.00");

        }
        catch(Exception exception)
        {
            throw new EJBException("Error in getCashFlowValues login  " + exception.toString());
        }
        return ArrayList1;
    }

    private HashMap getCMADetails(String s, String s1)
        
    {
        ResultSet resultset = null;
        HashMap hashtable = new HashMap();
       
        int i = 1;
        try
        {
            try
            {
               
                hashtable = new HashMap();
                String s3 = SQLParser.getSqlQuery("selcmalabelscashflow^" + s1 + "^" + s);
                for(resultset = DBUtils.executeQuery(s3); resultset.next();)
                {
                    ArrayList ArrayList1 = new ArrayList();
                    ArrayList1.add(correctNull(resultset.getString("fin_rowid")));
                    ArrayList1.add(correctNull(resultset.getString("fin_rowdesc")));
                    ArrayList1.add(correctNull(resultset.getString("fin_rowtype")));
                    ArrayList1.add(correctNull(resultset.getString("fin_formula")));
                    hashtable.put(Integer.toString(i), ArrayList1);
                    i++;
                }

            }
            catch(Exception exception)
            {
                throw new EJBException("Error in getCMADetails login  " + exception.toString());
            }
        }
        finally
        {
            try
            {
                if(resultset != null)
                    {
                	resultset.close();
                    }
              
            }
            catch(Exception exception2)
            {
                throw new EJBException("Error closing the connection getCMADetails-- " + exception2.getMessage());
            }
        }
        return hashtable;
    }

    
    
    private HashMap getPERCMADetails(String s, String s1)
    
{
    ResultSet resultset = null;
    HashMap hashtable = new HashMap();
   
    int i = 1;
    try
    {
        try
        {
           
            hashtable = new HashMap();
            String s3 = SQLParser.getSqlQuery("selcmalabelspercashflow^" +"FU" + "^" + s1);
            for(resultset = DBUtils.executeQuery(s3); resultset.next();)
            {
                ArrayList ArrayList1 = new ArrayList();
                ArrayList1.add(correctNull(resultset.getString("fin_rowid")));
                ArrayList1.add(correctNull(resultset.getString("fin_rowdesc")));
                ArrayList1.add(correctNull(resultset.getString("fin_rowtype")));
                ArrayList1.add(correctNull(resultset.getString("fin_formula")));
                hashtable.put(Integer.toString(i), ArrayList1);
                i++;
            }

        }
        catch(Exception exception)
        {
            throw new EJBException("Error in getPERCMADetails login  " + exception.toString());
        }
    }
    finally
    {
        try
        {
            if(resultset != null)
                {
            	resultset.close();
                }
          
        }
        catch(Exception exception2)
        {
            throw new EJBException("Error closing the connection getPERCMADetails-- " + exception2.getMessage());
        }
    }
    return hashtable;
}

    
    
    
    
    
    
    
    
    
    public HashMap GetFundFlowData(HashMap hashtable)
        
    {
        return hashtable;
    }

    private HashMap findBorrowerExistence(String s)
        
    {
      
        ResultSet resultset = null;
        HashMap hashtable = new HashMap();
        String s3 = "";
        String s4 = "";
        try
        {
            try
            {
                
                String s2 = SQLParser.getSqlQuery("selborrowerid^" + s);
                if(resultset!=null)
                	resultset.close();
                 resultset = DBUtils.executeQuery(s2);
                if(resultset.next())
                    s3 = correctNull(resultset.getString("demo_apptype"));
                s2 = SQLParser.getSqlQuery("selestimatecomp^" + s + "^<");
                if(resultset != null)
                	resultset.close();
                resultset = DBUtils.executeQuery(s2);                
                String s5 = "";
				
                while(resultset.next()) 
                {
                    double d1 = resultset.getDouble(2);
                    double d3 = resultset.getDouble(3);
					
                    if(d1 > 0.0D && d3 > 0.0D && s5.trim().equals(""))
                    {
                        s5 = correctNull(resultset.getString(1));
                        break;
                    }
					else if(d3>0 && (s5.trim().equals("") ) )
					{
						s5 = correctNull((String)resultset.getString(1));
						break;
					}
                }

                if(s3.trim().equals("N") && s5.trim().equals(""))
                    s4 = "N";
                else
                if(s3.trim().equals("N") && !s5.trim().equals(""))
                    s4 = "E";
                else
                if(s3.trim().equals("R") && !s5.trim().equals(""))
                    s4 = "E";
                else
                if(s3.trim().equals("R") && s5.trim().equals(""))
                    s4 = "E";
                hashtable.put("borrowertype", s4);
                hashtable.put("curyear", s5);
            }
            catch(Exception exception)
            {
                throw new EJBException("Error in getCMADetails login  " + exception.toString());
            }
        }
        finally
        {
            try
            {
                if(resultset != null)
                {
                	resultset.close();
                }              
            }
            catch(Exception exception2)
            {
                throw new EJBException("Error closing the connection getCMADetails-- " + exception2.getMessage());
            }
        }
        return hashtable;
    }
    
    public void updateFincommentsData(HashMap hshValues)  {
		ResultSet rs = null;
		//HashMap hshRecord = null;
		HashMap hshQuery = null;
		HashMap hshQueryValues = null;
		String strQuery = "", strValue = "";
		ArrayList arrValues = new ArrayList();
		String sel_divID = "";
		String notes = "";
		int intUpdatesize = 0;
		String page = "";
		String hidEditMode = correctNull((String) hshValues.get("hidEditMode"));

		try {
			hshQueryValues = new HashMap();
			strValue = correctNull((String) hshValues.get("appno"));
			page = correctNull((String) hshValues.get("flowtype"));
			sel_divID = correctNull((String) hshValues.get("sel_divID"));
			notes = correctNull((String) hshValues.get("exec_notes"));
			if (sel_divID.equalsIgnoreCase("")
					|| sel_divID.equalsIgnoreCase("null")) {
				sel_divID = "0";
			}

			if (hidEditMode.equalsIgnoreCase("U")) {
				rs = null;
				strQuery = SQLParser.getSqlQuery("executive_finnotes_sel^"
						+ strValue + "^" + page + "^" + sel_divID);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(strValue);
					arrValues.add(page);
					arrValues.add(sel_divID);
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "executive_finnotes_del");
					intUpdatesize = intUpdatesize + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),
							hshQuery);
					hshQueryValues.put("size", Integer.toString(intUpdatesize));

					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(strValue);
					arrValues.add(page);
					arrValues.add(sel_divID);
					arrValues.add(notes);
					// arrValues.add(notes.toCharArray());
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "executive_finnotes_ins");
					intUpdatesize = intUpdatesize + 1;
					hshQueryValues.put(Integer.toString(intUpdatesize),
							hshQuery);
					hshQueryValues.put("size", Integer.toString(intUpdatesize));
				} else {
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(strValue);
					arrValues.add(page);
					arrValues.add(sel_divID);
					arrValues.add(notes);
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "executive_finnotes_ins");
					intUpdatesize = intUpdatesize + 1;
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
				}

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			} else if (hidEditMode.equalsIgnoreCase("D")) {
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strValue);
				arrValues.add(page);
				arrValues.add(sel_divID);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "executive_finnotes_del");
				intUpdatesize = intUpdatesize + 1;
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));

				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}

			//hshRecord = new HashMap();
			//hshRecord.putAll(getFinComments(hshValues));
				//(HashMap) EJBInvoker.executeStateLess("executive",hshValues, "getData8");

		} catch (Exception ce) {
			throw new EJBException("Error in getData login  " + ce.toString());
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
		//return hshRecord;
	}
    
    
    public HashMap getDateFincommentsData(HashMap hshValues) 
	{
	    
	    String strQuery="";
	    String strAppno="";
	    ResultSet rs=null;
	    HashMap hshRecord=new HashMap();
	    
	    try
	    {
	        strAppno = correctNull((String)hshValues.get("appno"));
	    	strQuery = SQLParser.getSqlQuery("executive_finnotes_sel^"+strAppno+"^"+"CA"+"^0");
	    	if(rs!=null)
	    		rs.close();
	    	rs=DBUtils.executeQuery(strQuery);
	    	if(rs.next())
	    	{
	    		hshRecord.put("exec_notes",correctNull(Helper.CLOBToString(rs.getClob("notes"))));
	    	}
	    }
	    catch(Exception exception)
	    {
	        throw new EJBException("Error in getDateFincommentsData login  " + exception.toString());
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
	    return hshRecord;
	}
}
