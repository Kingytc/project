package com.sai.laps.helper;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.sql.Clob;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.StringTokenizer;

import org.apache.axis.types.Month;
import org.apache.log4j.Logger;

import com.sai.fw.management.utils.FwUtils;

public class Helper {
	//static org.apache.log4j.Logger log=org.apache.log4j.Logger.getLogger(Helper.class);
	static Logger log=Logger.getLogger(Helper.class);
	/** This Method for making null values * */

	public static String correctNull(String strNull) {
		if (strNull == null) {
			strNull = "";
		}
		return strNull.trim();
	}
    
	public static boolean ArrNullCheck(ArrayList strValue)
	{
    	if (strValue == null || strValue.size() <= 0) 
		{
			return false;
		}
    	return true;
	}
	/** This Method for making null values to double values* */

	public static String correctDouble(String strNull) {
		if (strNull == null || strNull.equals("")) {
			strNull = "0.00";
		}
		return strNull;
	}
	
	public static String correctInt(String strNull) {
		if (strNull == null || strNull.equals("")) {
			strNull = "0";
		}
		return strNull;
	}

	public static String roundVal(String str) {
		String rVal = "";
		if (str != null && !str.equals("")) {
			double dVal = Double.parseDouble(str);
			rVal = String.valueOf(Math.round(dVal)) + ".00";

		}
		return rVal;
	}

	/** This Method for making CorrectSingle Quote * */

	public static String correctDoubleQuote(String str) throws Exception {
		String strLStr = "";
		str = correctNull(str);
		try {
			for (int i = 0; i < str.length(); i++) {
				if (str.charAt(i) == '\"') {
					strLStr = strLStr + "\\" + str.charAt(i);
				} else {
					strLStr = strLStr + str.charAt(i);
				}
			}
		} catch (Exception e) {
			throw new Exception("Error in correctDoubleQuote:" + e);
		}
		return strLStr;
	}

	/** ***** This method for getting current date **** */
	public static String getCurrentDateTime() throws Exception {
		Calendar cal = Calendar.getInstance();
		String strSysDate = "";
		try {
			String strSysDay = String.valueOf(cal.get(Calendar.DATE));
			if (Integer.parseInt(strSysDay) < 10) {
				strSysDay = "0" + strSysDay;
			}

			String strSysMonth = String.valueOf(cal.get(Calendar.MONTH) + 1);
			if (Integer.parseInt(strSysMonth) < 10) {
				strSysMonth = "0" + strSysMonth;
			}

			String strSysYear = String.valueOf(cal.get(Calendar.YEAR));

			strSysDate = strSysDay + "/" + strSysMonth + "/" + strSysYear;

		} catch (Exception e) {
			throw new Exception("*Exception in getCurrentDateTime **" + e);
		}
		return strSysDate;
	}
	public static String getCurrentDateandTime() throws Exception {
		Calendar cal = Calendar.getInstance();
		String strSysDate = "";
		try {
			String strSysDay = String.valueOf(cal.get(Calendar.DATE));
			if (Integer.parseInt(strSysDay) < 10) {
				strSysDay = "0" + strSysDay;
			}

			String strSysMonth = String.valueOf(cal.get(Calendar.MONTH) + 1);
			if (Integer.parseInt(strSysMonth) < 10) {
				strSysMonth = "0" + strSysMonth;
			}

			String strSysYear = String.valueOf(cal.get(Calendar.YEAR));
			String strSysTime = String.valueOf(cal.get(Calendar.HOUR_OF_DAY));
			if (Integer.parseInt(strSysTime) < 10) {
				strSysTime = "0" + strSysTime;
			}
			String strSysMinute = String.valueOf(cal.get(Calendar.MINUTE));
			if (Integer.parseInt(strSysMinute) < 10) {
				strSysMinute = "0" + strSysMinute;
			}

			strSysDate = strSysDay+strSysMonth+strSysYear+"_"+strSysTime+strSysMinute;

		} catch (Exception e) {
			throw new Exception("*Exception in getCurrentDateTime **" + e);
		}
		return strSysDate;
	}

	public static Object correctObject(Object obj1, Object obj2) {
		if (obj1 == null)
			return obj2;
		return obj1;
	}

	public static String formatComment(String strValue) {
		StringBuffer sbfValue = new StringBuffer();
		int intIndex = 0;
		if (strValue != null || !strValue.equals("")) {
			sbfValue.append(strValue);
			for (int i = 1; i < strValue.length(); i++) {
				intIndex = sbfValue.toString().indexOf("~");
				if (intIndex != -1) {
					sbfValue.deleteCharAt(intIndex);
					sbfValue.insert(intIndex, "\n");
				}
			}
		}

		return sbfValue.toString();
	}

	public static String correctDate(String strNull) {
		try {
			if (strNull == null) {
				strNull = getCurrentDateTime();
				strNull = strNull.substring(8, 10) + "/"
						+ strNull.substring(5, 7) + "/"
						+ strNull.substring(0, 4);
			}

		} catch (Exception e) {
			log.info("Error in correctDate:" + e);
		}
		return strNull.trim();
	}
	public static String calculateAGE(String strdate) {
		String strAge="";
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		try {
			 if(!strdate.equals(""))
			 {
				 int years = 0;
			      int months = 0;
			      int days = 0;
			 
			      //create calendar object for birth day
			      Calendar birthDay = Calendar.getInstance();
			      birthDay.setTimeInMillis(sdf.parse(strdate).getTime());
			 
			      //create calendar object for current day
			      long currentTime = System.currentTimeMillis();
			      Calendar now = Calendar.getInstance();
			      now.setTimeInMillis(currentTime);
			 
			      //Get difference between years
			      years = now.get(Calendar.YEAR) - birthDay.get(Calendar.YEAR);
			      int currMonth = now.get(Calendar.MONTH) + 1;
			      int birthMonth = birthDay.get(Calendar.MONTH) + 1;
			 
			      //Get difference between months
			      months = currMonth - birthMonth;
			 
			      //if month difference is in negative then reduce years by one 
			      //and calculate the number of months.
			      if (months < 0)
			      {
			         years--;
			      } else if (months == 0 && now.get(Calendar.DATE) < birthDay.get(Calendar.DATE))
			      {
			         years--;
			      }
			      
			      strAge=String.valueOf(years);
			 
			 }
		} catch (Exception e) {
			log.info("Error in calculateAGE:" + e);
		}
		return strAge.trim();
	}
	
	public static String correctDoubleQuotesHtml(String str) {

		if (str == null) {
			return "";
		} else {
			StringBuffer sbf = new StringBuffer(str);
			for (int i = 0; i < sbf.length(); i++) {
				if (sbf.charAt(i) == '"') {
					sbf.replace(i, i + 1, "&quot;");
				}
				if (sbf.charAt(i) == '\'') {
					sbf.replace(i, i + 1, "&#39;");
				}
			}
			return sbf.toString();
		}
	}

	public static String correctDoubleQuotesScript(String str) {
		
		if (str == null) {
			return "";
		} else {
			StringBuffer sbf = new StringBuffer(str);
			for (int i = 0; i < sbf.length(); i++) {
				if (sbf.charAt(i) == '"') {
					sbf.replace(i, i + 1, "'" );
				}
			}
			return sbf.toString();
		}
	}
	
	public static String checkDecimal(String strDec) {
		String str = strDec;
		int intLocal = 0;
		if (str.indexOf(".") != -1) {
			int i = str.indexOf(".");
			for (int k = i; k < str.length(); k++) {
				intLocal++;

			}
			switch (intLocal) {
			case 2:
				str = str.concat("0");
				break;
			case 1:
				str = str.concat("00");
				break;
			}
			if (intLocal >= 3) {
				str = str.substring(0, str.indexOf(".") + 3);

			}
		} else if(!str.equalsIgnoreCase("")){
			str = str.concat(".00");
		}
		return str;

	}

	public static String breakText(String sent, int param) {
		String let = new String();
		int nowords = 0;
		int len = 0;
		int strlen = 0;
		String outstring = new String();
		String totalstring = new String();
		outstring = "";
		StringTokenizer st = new StringTokenizer(sent);
		while (st.hasMoreTokens()) {
			let = st.nextToken();
			let = let + " ";
			nowords = nowords + 1;
			len = let.length();
			strlen = outstring.length();
			if (strlen + len <= param) {
				outstring = outstring + let;
				strlen = 0;
			} else {
				totalstring = totalstring + outstring + "\n";
				outstring = let;
			}
		}
		totalstring = totalstring + outstring;
		return totalstring;
	}

	public static String figtoWords(String str1) {
		
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		str1=jtn.format(Double.parseDouble(Helper.correctDouble(str1)));
		
		String one[] = { "One ", "Two ", "Three ", "Four ", "Five ", "Six ",
				"Seven ", "Eight ", "Nine " };
		String ele[] = { "Eleven ", "Twelve ", "Thirteen ", "Fourteen ",
				"Fifteen ", "Sixteen ", "Seventeen ", "Eighteen ", "Nineteen " };
		String ten[] = { "Ten ", "Twenty ", "Thirty ", "Forty ", "Fifty ",
				"Sixty ", "Seventy ", "Eighty ", "Ninety " };

		String str = "";
		String strdecimals="";
		int i=0;
		for(;i<str1.length();i++)
		{
			if(str1.charAt(i)=='.')
			{
				str=str1.substring(0,i);
				strdecimals=str1.substring(i+1,str1.length());
				break;
			}
		}
		if(i==str1.length())
		{
			str=str1;
			strdecimals="00";
		}
		
		int len, k;
		len = str.length();
		k = 10 - len;
		if (len < 10) {
			switch ((k)) {
			case 1:
				str = "0" + str;
				break;
			case 2:
				str = "00" + str;
				break;
			case 3:
				str = "000" + str;
				break;
			case 4:
				str = "0000" + str;
				break;
			case 5:
				str = "00000" + str;
				break;
			case 6:
				str = "000000" + str;
				break;
			case 7:
				str = "0000000" + str;
				break;
			case 8:
				str = "00000000" + str;
				break;
			case 9:
				str = "000000000" + str;
				break;
			case 10:
				str = "0000000000" + str;
				break;
			}
		}

		int d, d1, d2;
		String word = new String();
		String chdigit = new String();
		chdigit = str.substring(0, 1);
		d = Integer.parseInt(chdigit);
		chdigit = str.substring(1, 2);
		d1 = Integer.parseInt(chdigit);
		chdigit = str.substring(2, 3);
		d2 = Integer.parseInt(chdigit);
		if (d != 0) {
			word = word.concat(one[d - 1]);
			word = word.concat("Hundred ");
		}
		if (d1 == 0 && d2 != 0) {
			word = word.concat(one[d2 - 1]);
			word = word.concat("Crores ");
		}
		if (d1 == 1 && d2 != 0) {
			word = word.concat(ele[d2 - 1]);
			word = word.concat("Crores ");
		}
		if (d1 != 0 && d2 == 0) {
			word = word.concat(ten[d1 - 1]);
			word = word.concat("Crores ");
		}
		if (d1 > 1 && d2 != 0) {
			word = word.concat(ten[d1 - 1]);
			word = word.concat(one[d2 - 1]);
			word = word.concat("Crores ");
		}
		if (d != 0 && d1 == 0 && d2 == 0) {
			word = word.concat("Crores ");
		}
		chdigit = str.substring(3, 4);
		d = Integer.parseInt(chdigit);
		chdigit = str.substring(4, 5);
		d1 = Integer.parseInt(chdigit);
		if (d == 0 && d1 != 0) {
			word = word.concat(one[d1 - 1]);
			word = word.concat("Lakhs ");
		}
		if (d == 1 && d1 != 0) {
			word = word.concat(ele[d1 - 1]);
			word = word.concat("Lakhs ");
		}

		if (d != 0 && d1 == 0) {
			word = word.concat(ten[d - 1]);
			word = word.concat("Lakhs ");
		}
		if (d > 1 && d1 != 0) {
			word = word.concat(ten[d - 1]);
			word = word.concat(one[d1 - 1]);
			word = word.concat("Lakhs ");
		}

		chdigit = str.substring(5, 6);
		d = Integer.parseInt(chdigit);
		chdigit = str.substring(6, 7);
		d1 = Integer.parseInt(chdigit);
		if (d == 0 && d1 != 0) {
			word = word.concat(one[d1 - 1]);
			word = word.concat("Thousand ");
		}
		if (d == 1 && d1 != 0) {
			word = word.concat(ele[d1 - 1]);
			word = word.concat("Thousand ");
		}
		if (d != 0 && d1 == 0) {
			word = word.concat(ten[d - 1]);
			word = word.concat("Thousand ");
		}
		if (d > 1 && d1 != 0) {
			word = word.concat(ten[d - 1]);
			word = word.concat(one[d1 - 1]);
			word = word.concat("Thousand ");
		}
		chdigit = str.substring(7, 8);
		d = Integer.parseInt(chdigit);
		chdigit = str.substring(8, 9);
		d1 = Integer.parseInt(chdigit);
		chdigit = str.substring(9, 10);
		d2 = Integer.parseInt(chdigit);
		if (d != 0) {
			word = word.concat(one[d - 1]);
			word = word.concat("Hundred ");
		}
		if (d1 == 0 && d2 != 0) {
			word = word.concat(one[d2 - 1]);
		}
		if (d1 == 1 && d2 != 0) {
			word = word.concat(ele[d2 - 1]);
		}
		if (d1 != 0 && d2 == 0) {
			word = word.concat(ten[d1 - 1]);
		}
		if (d1 > 1 && d2 != 0) {
			word = word.concat(ten[d1 - 1]);
			word = word.concat(one[d2 - 1]);
		}
		if (str.equals("0000000000") && strdecimals.equals("00")) {
			word = "Zero Only";
		} else {
			
			if(Integer.parseInt(strdecimals)>0)
			{
				word = word.concat("and ");
				
				chdigit = new String();
				chdigit = strdecimals.substring(0, 1);
				d1 = Integer.parseInt(chdigit);
				chdigit = strdecimals.substring(1, 2);
				d2 = Integer.parseInt(chdigit);
				
				if (d1 == 0 && d2 != 0) {
					word = word.concat(one[d2 - 1]);
				}
				if (d1 == 1 && d2 != 0) {
					word = word.concat(ele[d2 - 1]);
				}
				if (d1 != 0 && d2 == 0) {
					word = word.concat(ten[d1 - 1]);
				}
				if (d1 > 1 && d2 != 0) {
					word = word.concat(ten[d1 - 1]);
					word = word.concat(one[d2 - 1]);
				}
				word = word.concat("Paise only");
			}
			else
			{
				word = word.concat("only");
			}

		}

		return word;
	}
	
	public static String replaceAll(String str, String pattern, String replace, boolean isCaseSensitive) {
        int s = 0;
        int e = 0;
        StringBuffer result = new StringBuffer();    
        if(isCaseSensitive){
            while ((e = str.indexOf(pattern, s)) >= 0) {
                result.append(str.substring(s, e));
                result.append(replace);
                s = e+pattern.length();
            }
        }else{
            while ((e = str.toUpperCase().indexOf(pattern.toUpperCase(), s)) >= 0) {
                result.append(str.substring(s, e));
                result.append(replace);
                s = e+pattern.length();
            }
        }
       
        result.append(str.substring(s));
        return result.toString();
    }

	
	public static String formatDoubleValue(double dblvalue) 
	{
		return new java.text.DecimalFormat("##0.00").format(dblvalue);
	}	

	public static String getMonths(int intMonth)
	{
		String strMonths[]={"","January","February","March","April","May","June","July","August","September","October","November","December"};
		return strMonths[intMonth];
	}
	
	public static String convertDatetowords(String datevalue)
	{
		 String datewords="";
		 if(!datevalue.equalsIgnoreCase(""))
		 {
			 boolean bflag=true;
			 String strDay="";
			 String[] strSTArr={"01","21","31"};
			 String[] strRDArr={"03","23"};
			 String[] strNDArr={"02","22"};
			 
			 for(int a=0;a<strSTArr.length;a++)
			 {
				 if(strSTArr[a]==datevalue.substring(0, 2))
				 {
					 strDay= datevalue.substring(0, 2)+"st ";
					 bflag=false;
				 }
			 }
			 if(bflag)
			 {
				 for(int a=0;a<strRDArr.length;a++)
				 {
					 if(strRDArr[a]==datevalue.substring(0, 2))
					 {
						 strDay= datevalue.substring(0, 2)+"rd ";
						 bflag=false;
					 }
				 } 
			 }
			 if(bflag)
			 {
				 for(int a=0;a<strNDArr.length;a++)
				 {
					 if(strNDArr[a]==datevalue.substring(0, 2))
					 {
						 strDay= datevalue.substring(0, 2)+"nd ";
						 bflag=false;
					 }
				 } 
			 }
			 if(bflag)
			 {
				 strDay= datevalue.substring(0, 2)+"th "; 
			 }
			  int month=Integer.parseInt(datevalue.substring(3, 5));
			  datewords=strDay+ " "+ Helper.getMonths(month) +" "+ datevalue.substring(6,10);
		 }
		 return datewords;
	}
	
	public static String CLOBToString(Clob cl)
	{

		String strClob ="";
		try
		{
			if (cl == null) 
				return "";
			StringBuffer strOut = new StringBuffer();
			String aux;
			//	 We access to stream, as this way we don't have to use the CLOB.length() which is slower...
			BufferedReader br = new BufferedReader(cl.getCharacterStream());
			while ((aux=br.readLine())!=null)
				strOut.append(aux).append("\n");
			strClob = strOut.toString();
		}
		catch(SQLException ie)
		{
			log.info(ie);
		}
		catch (IOException e) 
		{
			log.info(e);
		}
		return strClob;
	} 
	
	/**
     * Method correctSingleQuote.
     * 
     * @param str
     *            String
     * @return String
     * @throws Exception
     */
    public static String correctSingleQuote(String str) throws Exception {
        StringBuffer strLStr = new StringBuffer();
        str = correctNull(str);
        try {
            for (int i = 0; i < str.length(); i++) {
                if (str.charAt(i) == '\'') {
                    strLStr.append(str.charAt(i));
                    strLStr.append("'");
                } else {
                    strLStr.append(str.charAt(i));

                }
            }
        } catch (Exception e) {
            throw new Exception("Error in FwHelper: correctSingleQuote" + e);
        }
        return strLStr.toString();
    }

    /**
     * Method correctSingleQuote.
     * 
     * @param str
     *            String
     * @return String
     * @throws Exception
     */
    public static String correctDot(String str) {
        
        return str.replaceAll("\\."," ");
    }

    
    /*
     * @author R.PAULRAJ
     * 
     *@param  this function is mainly written to remove double quotes in string 
     * and  add single quotes and enter marks in java script
     * return string
     */
 	
	 public static String replaceForJavaScriptString(String str)
	 {
		 String strVal=correctNull(str).replaceAll("\"","\\\\\"").replaceAll("\r\n","\\\\n").replaceAll("'","\\\\'").replaceAll("\n","\\\\n");;
		 strVal=correctDoubleQuotesHtml(strVal);
		 return strVal;
	 }
	 
	 public static String replcaeNewLine(String str)
	 {
			str=Helper.correctNull(str).replaceAll("\"","\\\\\"").replaceAll("\r\n","\\\\n").replaceAll("'","\\\\'").replaceAll("\n","\\\\n");
			return str;
	 }
	 /*
	  * @Author R.Paulraj
	  */
	 	
	 public static String converToLakhs(String str)
	 {
		 double lakhs = Double.parseDouble(Helper.correctDouble(str));
		 
		 lakhs = lakhs/100000;
		 
		 return new java.text.DecimalFormat("##0.00").format(lakhs);
	 }
 
	 
	 public static String converToCores(String str)
	 {
		 double cores = Double.parseDouble(Helper.correctDouble(str));
		 
		 cores = cores/10000000;
		 
		 return new java.text.DecimalFormat("##0.00").format(cores);
	 }
	 
	 public static String correctEditor(String strData) 
	 {
		 strData=correctNull(strData);
		 log.info("\n\n\n\n\n\n"+strData);
		 //strData=strData.replaceAll("class=MsoBodyText","");
		 //strData=strData.replaceAll("class=MsoNormal","");
		 //strData=strData.replaceAll("</span>","");
		 //strData=strData.replaceAll("</SPAN>","");
		 //strData=strData.replaceAll("</FONT>","");
		 //strData=strData.replaceAll("</font>","");
		 strData=strData.replaceAll("</TABLE>","</TABLE><a href=\"#\" class=\"highlight_pagebreak\"><span title=\"pagebreak\"  onPaste=\"window.event.returnValue=false\"  onKeyPress=\"allowEnterOnly()\"></span></a></div>");
		 strData=strData.replaceAll("</table>","</table><a href=\"#\" class=\"highlight_pagebreak\"><span title=\"pagebreak\"  onPaste=\"window.event.returnValue=false\"  onKeyPress=\"allowEnterOnly()\"></span></a></div>");
		 //strData=strData.replaceAll("<o:p>","");
		 //strData=strData.replaceAll("</o:p>","");
		 //strData=strData.replaceAll("<H6>","<B>");
		 //strData=strData.replaceAll("</H6>","</B>");
		 //strData=strData.replaceAll("MARGIN: 0in 0in 0pt;","");
		 //strData=strData.replaceAll("<P>&nbsp;</P>","");
		 //strData=strData.replaceAll("<p>&nbsp;</p>","");
		 //strData=strData.replaceAll("TEXT-ALIGN: center","");
		 //strData=strData.replaceAll("class=BodySingle","");
		 //strData=strData.replaceAll("class=TableText","");
		 //strData=strData.replaceAll("TEXT-ALIGN","text-align");
		 //strData=strData.replaceAll("</DIV>","</P>");
		for(int i=0; i<strData.length();i++)
		{
			//log.info(i);
			int k=i+5;
			/*if(strData.charAt(i)=='<')
			{
				log.info("------------------------------------------------------");
				log.info(""+strData.charAt(i) +""+ strData.charAt(i+1));
			}*/
			
			/****
			 * For Removing Span tag from the Data
			 */
			/*if(strData.charAt(i)=='<' && k<strData.length() && strData.charAt(i+1)=='S' && strData.charAt(i+2)=='P')
			{
				int j=0;
				for(;strData.charAt(i+j)!='>';j++);
				String strtemp=strData.substring(i,(i+j+1));
				strData=strData.replaceAll(strtemp,"");
			}*/
			/****
			 * For Removing Span end tag from the Data
			 */	
			/*if(strData.charAt(i)=='<' && k<strData.length() && strData.charAt(i+1)=='S' && strData.charAt(i+2)=='P')
			{
				int j=0;
				for(;strData.charAt(i+j)!='>';j++);
				String strtemp=strData.substring(i,(i+j+1));
				strData=strData.replaceAll(strtemp,"");
				//i=i+4;
			}*/
			/****
			 * For Neutralising TR start tag from the Data
			 */	
			if(strData.charAt(i)=='<' && k<strData.length() && strData.charAt(i+1)=='T' && strData.charAt(i+2)=='R')
			{
				int j=0;
				for(;strData.charAt(i+j)!='>';j++);
				String strtemp=strData.substring(i,(i+j+1));
				if(!strtemp.equalsIgnoreCase("<TR>"))
				{
					strData=strData.replaceAll(strtemp,"<TR>");
				}
				//i=i+3;
			}
			/****
			 * For Neutralising TABLE start tag from the Data and adding div tag to show borders in output
			 */	
			if(strData.charAt(i)=='<' && k<strData.length() && strData.charAt(i+1)=='T' && strData.charAt(i+2)=='A' && strData.charAt(i+3)=='B')
			{
				int j=0;
				for(;strData.charAt(i+j)!='>';j++);
				String strtemp=strData.substring(i,(i+j+1));
				if(!strtemp.equalsIgnoreCase("<TABLE border=0 cellspacing=0 cellpadding=2>"))
				{
					strData=strData.replaceAll(strtemp,"<div id=top><TABLE border=0 cellspacing=0 cellpadding=2>");
				}
				//i=i+56;
			}
			/****
			 * For Neutralising TD start tag from the Data
			 */	
			if(strData.charAt(i)=='<' && k<strData.length() && strData.charAt(i+1)=='T' && strData.charAt(i+2)=='D')
			{
				int j=0;
				for(;strData.charAt(i+j)!='>';j++);
				String strtemp=strData.substring(i,(i+j+1));
				if(!strtemp.equalsIgnoreCase("<TD valign=top>"))
				{
					String strcolSpandata="";
					String strrowSpandata="";
					if(strtemp.contains("colSpan"))
					{
						for(j=0; j<strtemp.length();j++)
						{
							if((j+10)<strtemp.length() && strtemp.substring(j,j+7).equalsIgnoreCase("colSpan"))
							{
								strcolSpandata=strtemp.substring(j,j+10);
							}
						}
					}
					if(strtemp.contains("rowSpan"))
					{
						for(j=0;j<strtemp.length();j++)
						{
							if((j+9)<strtemp.length() && strtemp.substring(j,j+7).equalsIgnoreCase("rowSpan"))
							{
								strrowSpandata= strtemp.substring(j,j+10);
							}
						}
					}
					if(strcolSpandata.equals("") && strrowSpandata.equals(""))
					{
						if(!strtemp.equalsIgnoreCase("<TD valign=top>"))
						{
							strData=strData.replaceAll(strtemp,"<TD valign=top>");
						}
					}
					if(strcolSpandata.equals("") && !strrowSpandata.equals(""))
					{
						
						if(strrowSpandata.charAt(strrowSpandata.length()-1)=='>')
							strrowSpandata=strrowSpandata.substring(0,(strrowSpandata.length()-1));
						strData=strData.replaceAll(strtemp,"<TD valign=top "+ strcolSpandata+" "+strrowSpandata+">");
					}
					if(!strcolSpandata.equals("") && strrowSpandata.equals(""))
					{
						if(strcolSpandata.charAt(strcolSpandata.length()-1)=='>')
							strcolSpandata=strcolSpandata.substring(0,(strcolSpandata.length()-1));
						
						strData=strData.replaceAll(strtemp,"<TD valign=top "+ strcolSpandata+" "+strrowSpandata+">");
					}
					if(!strcolSpandata.equals("") && !strrowSpandata.equals(""))
					{
						if(strrowSpandata.charAt(strrowSpandata.length()-1)=='>')
							strrowSpandata=strrowSpandata.substring(0,(strrowSpandata.length()-1));
						if(strcolSpandata.charAt(strcolSpandata.length()-1)=='>')
							strcolSpandata=strcolSpandata.substring(0,(strcolSpandata.length()-1));
						strData=strData.replaceAll(strtemp,"<TD valign=top "+ strcolSpandata+" "+strrowSpandata+">");
					}
					
					
					
					
				}
				//i=i+15;
			}
			/****
			 * For Removing Font Start tag from the Data
			 */	
			/*if(strData.charAt(i)=='<' && k<strData.length() && strData.charAt(i+1)=='F' && strData.charAt(i+2)=='O' && strData.charAt(i+3)=='N')
			{
				int j=0;
				for(;strData.charAt(i+j)!='>';j++);
				String strtemp=strData.substring(i,(i+j+1));
				strData=strData.replaceAll(strtemp,"");
			}*/
			
			/****
			 * For Removing Single space pragraph or single space bold paragraph from the Data
			 */
			/*if(strData.charAt(i)=='<' && k<strData.length() && strData.charAt(i+1)=='/' && strData.charAt(i+2)=='P' && strData.charAt(i+3)=='>')
			{
				int j=0;
				for(;strData.charAt(i+j)!='>';j--);
				String strtemp=strData.substring((i+j),i+1);
				if(strtemp.equalsIgnoreCase(">&nbsp;<") || strtemp.equalsIgnoreCase("><B>&nbsp;</B><"))
				{
					int l=i+j;
					for(;strData.charAt(l)!='<';l--);
					strtemp=strData.substring(l,i+4);
					strData=strData.replaceAll(strtemp,"");
					i=(i-strtemp.length())<0?0:(i-strtemp.length());
				}
			}*/
			
			/****
			 * For Neutralising Bold start tag from the Data
			 */	
			/*if(strData.charAt(i)=='<' && k<strData.length() && strData.charAt(i+1)=='B')
			{
				int j=0;
				for(;strData.charAt(i+j)!='>';j++);
				String strtemp=strData.substring(i,(i+j+1));
				if(!strtemp.equalsIgnoreCase("<B>"))
				{
					strData=strData.replaceAll(strtemp,"<B>");
				}
				//i=i+4;
			}*/
			
			/****
			 * For Neutralising Unorder List (UL) start tag from the Data
			 */	
			/*if(strData.charAt(i)=='<' && k<strData.length() && strData.charAt(i+1)=='U' && strData.charAt(i+2)=='L')
			{
				int j=0;
				for(;strData.charAt(i+j)!='>';j++);
				String strtemp=strData.substring(i,(i+j+1));
				if(!strtemp.equalsIgnoreCase("<UL>"))
				{
					strData=strData.replaceAll(strtemp,"<UL>");
				}
				//i=i+4;
			}*/
			
			/****
			 * For Neutralising List (LI) start tag from the Data
			 */	
			/*if(strData.charAt(i)=='<' && k<strData.length() && strData.charAt(i+1)=='L')
			{
				int j=0;
				for(;strData.charAt(i+j)!='>';j++);
				String strtemp=strData.substring(i,(i+j+1));
				if(!strtemp.equalsIgnoreCase("<LI>"))
				{
					strData=strData.replaceAll(strtemp,"<LI>");
				}
				//i=i+4;
			}*/
			
			
			/****
			 * For Neutralising Paragraph start tag from the Data
			 */	
			/*if(strData.charAt(i)=='<' && k<strData.length() && strData.charAt(i+1)=='P')
			{
				int j=0;
				for(;strData.charAt(i+j)!='>';j++);
				String strtemp=strData.substring(i,(i+j+1));
				if(!strtemp.equalsIgnoreCase("<P>") && !strtemp.contains("align=center") )
				{
					if(strtemp.contains("TEXT-ALIGN: right") && !strtemp.equalsIgnoreCase("<P style=\"text-align:right\">"))
					{
						strData=strData.replaceAll(strtemp,"<P style=\"text-align:right\">");
					}
					else if(!strtemp.equalsIgnoreCase("<P style=\"text-align:justify\">") && !strtemp.equalsIgnoreCase("<P style=\"text-align:right\">") && !strtemp.equalsIgnoreCase("<P style=\"text-align:left\">"))
					{
						strData=strData.replaceAll(strtemp,"<P style=\"text-align:justify\">");
					}
					else if(!strtemp.equalsIgnoreCase("<P style=\"text-align:left\">") &&  strtemp.contains("TEXT-ALIGN: left"))
					{
						strData=strData.replaceAll(strtemp,"<P style=\"text-align:left\">");
					}
						
				}
				//i=i+4;
			}*/
			
			/****
			 * For Changing DIV tag to Paragraph tag in the Data
			 */	
			/*if(strData.charAt(i)=='<' && k<strData.length() && strData.charAt(i+1)=='D')
			{
				int j=0;
				for(;strData.charAt(i+j)!='>';j++);
				String strtemp=strData.substring(i,(i+j+1));
				if(strtemp.contains("<DIV ") && strtemp.contains("text-align: right"))
				{
					strData=strData.replaceAll(strtemp,"<P style=\"text-align:right\">");
				}
				if(strtemp.contains("<DIV ") && strtemp.contains("text-align: justify"))
				{
					strData=strData.replaceAll(strtemp,"<P style=\"text-align:justify\">");
				}
				if(strtemp.contains("<DIV ") && strtemp.contains("text-align: left"))
				{
					strData=strData.replaceAll(strtemp,"<P style=\"text-align:left\">");
				}
				if(strtemp.contains("<DIV ") && strtemp.contains("text-align: center"))
				{
					strData=strData.replaceAll(strtemp,"<P style=\"text-align:center\">");
				}
				//i=i+4;
			}*/
			

			/****
			 * For Changing Header start tag to Bold start tag in the Data
			 */	
			/*if(strData.charAt(i)=='<' && k<strData.length() && strData.charAt(i+1)=='H')
			{
				int j=0;
				for(;strData.charAt(i+j)!='>';j++);
				String strtemp=strData.substring(i,(i+j+1));
					strData=strData.replaceAll(strtemp,"<P style=\"text-align:justify\"><B>");
			}*/
			
			/****
			 * For Changing Header end tag to Bold end tag in the Data
			 */	
			/*if(strData.charAt(i)=='<' && k<strData.length() && strData.charAt(i+1)=='/' && strData.charAt(i+2)=='H')
			{
				int j=0;
				for(;strData.charAt(i+j)!='>';j++);
				String strtemp=strData.substring(i,(i+j+1));
					strData=strData.replaceAll(strtemp,"</B></P>");
			}*/
			
			/*if(strData.charAt(i)=='%')
			{
				int j=0;
				for(;strData.charAt(i)!='<';i++);
				for(;strData.charAt(i+j)!='>';j++);
				String strtemp=strData.substring(i,(i+j+1));
				if(strtemp.equalsIgnoreCase("</P>") || strtemp.equalsIgnoreCase("</SPAN>")  || strtemp.equalsIgnoreCase("</DIV>"))
				{
					StringBuffer sbf = new StringBuffer(strData);
					sbf=sbf.replace(i,(i+j+1),"</P>");
					strData=sbf.toString();
				}
					
				j=0;
				for(;strData.charAt(i+j)!='>';j--);
				int l=i+j;
				log.info(strData.substring(l,i));
				if(i-l<10)
				{
					for(;strData.charAt(l)!='<';l--);
					strtemp=strData.substring(l,(i+j+1));
					if(strtemp.startsWith("<P") || strtemp.startsWith("<p") || strtemp.startsWith("<SP") || strtemp.startsWith("<sp"))
					{
						StringBuffer sbf = new StringBuffer(strData);
						sbf=sbf.replace(l,(i+j+1),"<P>");
						strData=sbf.toString();
					}
				}
				//i=(i-strtemp.length())<0?0:(i-strtemp.length());
			}*/
			
		}
		//strData=strData.replaceAll("mso-hyphenate: auto","");
		//strData=strData.replaceAll("<B></B>","");
		//strData=strData.replaceAll("style=\"\"","");
		//strData=strData.replaceAll("style=\" \"","");
		//strData=strData.replaceAll("<P  >","<P>");
		//strData=strData.replaceAll("class=Head","");
		//strData=strData.replaceAll("<STRONG>","<B>");
		//strData=strData.replaceAll("</STRONG>","</B>");
		//strData=strData.replaceAll("<U></U>","");
		//strData=strData.replaceAll("<B></B>","");
		//strData=strData.replaceAll("<I></I>","");
		//strData=strData.replaceAll("<P>","<P style=\"text-align:justify\">");
		//strData=strData.replaceAll("<P style=\"text-align:justify\"></P>","");
		//strData=strData.replaceAll("<P style=\"text-align:justify\"><B>&nbsp;</B></P>","");
		//strData=strData.replaceAll("<TD valign=top></TD>","<TD valign=top>&nbsp;</TD>");
		//strData=strData.replaceAll("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","");
		//strData=strData.replaceAll("&nbsp;"," ");
		strData=strData.replaceAll("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;","&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ");
		log.info("\n\n\n\n\n\n"+strData);
		return strData;
	}
	 
	 
	 public static String formatTextAreaData(String str) {

			if (str == null) {
				return "";
			} else {
				StringBuffer sbf = new StringBuffer(str);
				for (int i = 0; i < sbf.length(); i++) {
					if (sbf.charAt(i) == '\n') {
						sbf.replace(i, i + 1, "<br>");
					}
					if (sbf.charAt(i) == ' ' && (i+1)<sbf.length() && sbf.charAt(i+1) == ' ') {
						sbf.replace(i, i + 1, "&nbsp;&nbsp;");
					}
					
				}
				return sbf.toString();
			}
		}
	 
	 
	/* public static String correctEditorData(String strData) 
	 {
		 strData=correctNull(strData);
		 strData=strData.replaceAll("class=MsoBodyText","").replaceAll("class=MsoNormal","");
		 strData=strData.replaceAll("</span>","").replaceAll("</SPAN>","");
		 strData=strData.replaceAll("</FONT>","").replaceAll("</font>","");
		 strData=strData.replaceAll("</TABLE>","</TABLE></div>").replaceAll("</table>","</table></div>");
		 strData=strData.replaceAll("<o:p>","").replaceAll("</o:p>","");
		 strData=strData.replaceAll("<H6>","<B>").replaceAll("</H6>","</B>");
		 strData=strData.replaceAll("MARGIN: 0in 0in 0pt;","");
		 strData=strData.replaceAll("<P>&nbsp;</P>","").replaceAll("<p>&nbsp;</p>","");
		 strData=strData.replaceAll("TEXT-ALIGN: center","").replaceAll("class=BodySingle","").replaceAll("class=TableText","");
		for(int i=0; i<strData.length();i++)
		{
			int k=i+5;
			if(strData.charAt(i)=='<' && k<strData.length() && strData.charAt(i+1)=='S' && strData.charAt(i+2)=='P')
			{
				int j=0;
				for(;strData.charAt(i+j)!='>';j++);
				String strtemp=strData.substring(i,(i+j+1));
				strData=strData.replaceAll(strtemp,"");
			}
				
			if(strData.charAt(i)=='<' && k<strData.length() && strData.charAt(i+1)=='T' && strData.charAt(i+2)=='R')
			{
				int j=0;
				for(;strData.charAt(i+j)!='>';j++);
				String strtemp=strData.substring(i,(i+j+1));
				if(!strtemp.equalsIgnoreCase("<TR>"))
				{
					strData=strData.replaceAll(strtemp,"<TR>");
				}
			}
			if(strData.charAt(i)=='<' && k<strData.length() && strData.charAt(i+1)=='T' && strData.charAt(i+2)=='A' && strData.charAt(i+3)=='B')
			{
				int j=0;
				for(;strData.charAt(i+j)!='>';j++);
				String strtemp=strData.substring(i,(i+j+1));
				if(!strtemp.equalsIgnoreCase("<TABLE border=1 cellspacing=0 cellpadding=2>"))
				{
					strData=strData.replaceAll(strtemp,"<div id=top><TABLE border=1 cellspacing=0 cellpadding=2>");
				}
				//i=i+56;
			}
			if(strData.charAt(i)=='<' && k<strData.length() && strData.charAt(i+1)=='F' && strData.charAt(i+2)=='O' && strData.charAt(i+3)=='N')
			{
				int j=0;
				for(;strData.charAt(i+j)!='>';j++);
				String strtemp=strData.substring(i,(i+j+1));
				strData=strData.replaceAll(strtemp,"");
			}
			if(strData.charAt(i)=='<' && k<strData.length() && strData.charAt(i+1)=='/' && strData.charAt(i+2)=='P' && strData.charAt(i+3)=='>')
			{
				int j=0;
				for(;strData.charAt(i+j)!='>';j--);
				String strtemp=strData.substring((i+j),i+1);
				if(strtemp.equalsIgnoreCase(">&nbsp;<") || strtemp.equalsIgnoreCase("><B>&nbsp;</B><"))
				{
					int l=i+j;
					for(;strData.charAt(l)!='<';l--);
					strtemp=strData.substring(l,i+4);
					strData=strData.replaceAll(strtemp,"");
					i=(i-strtemp.length())<0?0:(i-strtemp.length());
				}
			}
			if(strData.charAt(i)=='<' && k<strData.length() && strData.charAt(i+1)=='B')
			{
				int j=0;
				for(;strData.charAt(i+j)!='>';j++);
				String strtemp=strData.substring(i,(i+j+1));
				if(!strtemp.equalsIgnoreCase("<B>"))
				{
					strData=strData.replaceAll(strtemp,"<B>");
				}
			}
			if(strData.charAt(i)=='<' && k<strData.length() && strData.charAt(i+1)=='P')
			{
				int j=0;
				for(;strData.charAt(i+j)!='>';j++);
				String strtemp=strData.substring(i,(i+j+1));
				if(!strtemp.equalsIgnoreCase("<P>") && !strtemp.contains("align=center") )
				{
					if(strtemp.contains("TEXT-ALIGN: right") && !strtemp.equalsIgnoreCase("<P style=\"text-align:right\">"))
					{
						strData=strData.replaceAll(strtemp,"<P style=\"text-align:right\">");
					}
					else if(!strtemp.equalsIgnoreCase("<P style=\"text-align:justify\">") && !strtemp.equalsIgnoreCase("<P style=\"text-align:right\">") && !strtemp.equalsIgnoreCase("<P style=\"text-align:left\">"))
					{
						strData=strData.replaceAll(strtemp,"<P style=\"text-align:justify\">");
					}
					else if(!strtemp.equalsIgnoreCase("<P style=\"text-align:left\">") &&  strtemp.contains("TEXT-ALIGN: left"))
					{
						strData=strData.replaceAll(strtemp,"<P style=\"text-align:left\">");
					}
						
				}
			}
			
			
		}
		strData=strData.replaceAll("mso-hyphenate: auto","").replaceAll("<B></B>","")
				.replaceAll("style=\"\"","").replaceAll("style=\" \"","").replaceAll("<P  >","<P>")
				.replaceAll("class=Head","").replaceAll("<STRONG>","<B>").replaceAll("</STRONG>","</B>");
		return strData;
	}*/
	
	 public static String encodeAmpersand(String str) {

			if (str == null) {
				return "";
			} else {
				StringBuffer sbf = new StringBuffer(str);
				for (int i = 0; i < sbf.length(); i++) {
					if (sbf.charAt(i) == '&') {
						sbf.replace(i, i + 1, "AMPERSAND");
					}
				}
				return sbf.toString();
			}
		}
	 public static String decodeAmpersand(String str) {

			if (str == null) {
				return "";
			} else {
				str=str.replaceAll("AMPERSAND","&");
				return str;
			}
		}
	 
	public static boolean isNumeric(String strValue)
	{
		for (int i = 0; i < strValue.length(); i++) {             
			//If we find a non-digit character we return false.            
			if (!Character.isDigit(strValue.charAt(i)) && strValue.charAt(i)!='.')  
			{
				return false;        
			}         
		}
	return true;
	}
	
	
	public static String converAmount(String stramt, String strformat)
	 {
		 double dblamt = Double.parseDouble(Helper.correctDouble(stramt));
		 
		 if(strformat.equalsIgnoreCase("T"))
		 {
			 dblamt = dblamt/1000;
		 }
		 else if(strformat.equalsIgnoreCase("L"))
		 {
			 dblamt = dblamt/100000;
		 }
		 else if(strformat.equalsIgnoreCase("C"))
		 {
			 dblamt = dblamt/10000000;
		 }
		 
		 return new java.text.DecimalFormat("##0.00").format(dblamt);
	 }
	 /**
     * Method parseInt.
     * 
     * @param s
     *            String
     * @return int
     */
    public static int parseInt(String s) {
        return parseInt(s, 0);
    }

    /**
     * Method parseInt.
     * 
     * @param s
     *            String
     * @param i
     *            int
     * @return int
     */
    public static int parseInt(String s, int i) {
        int j = i;
        try {
            s = correctNull(s);
            if (s.trim().equals("") || s == null) {
                j = i;
            } else {
                j = Integer.parseInt(s);
            }

        } catch (NumberFormatException numberformatexception) {
            return i;
        }
        return j;
    }
    
    /**
     * Method to remove HTML Tags from a String
     * @param strComments
     * @return StringBuffer
     */
    public static StringBuffer removeHTMLTags(String strComments) throws Exception {
    	StringBuffer strWithoutTag=new StringBuffer();
		boolean flag=false;
		for(int i=0;i<strComments.length();i++){
			if((strComments.charAt(i)=='<') || flag==true) {
				flag=true;
				if(strComments.charAt(i)=='>'){
					flag=false;
				}
			}
			if(flag==false){
				if((strComments.charAt(i)!='>') && (strComments.charAt(i)!='<')){
					strWithoutTag.append(strComments.charAt(i));
				}
			}
		}
		return strWithoutTag;
    }
	public static long dateDiff (String date1,String date2) 
 	{
 		Calendar  cdate1	=	Calendar.getInstance();
 		Calendar  cdate2	=	Calendar.getInstance();
 		
 		String appdate=date1.substring(0,2);
 		String appmon=date1.substring(3,5);
 		String appyear=date1.substring(6,10);

 		String retrate_date=date2.substring(0,2);
 		String retrate_mon=date2.substring(3,5);
 		String retrate_year=date2.substring(6,10);
 		
 		cdate1.set(Integer.parseInt(appyear),Integer.parseInt(appmon),Integer.parseInt(appdate)); // App created date
 		cdate2.set(Integer.parseInt(retrate_year),Integer.parseInt(retrate_mon),Integer.parseInt(retrate_date)); // fetch application date from laps properties
 		long mill1=cdate1.getTimeInMillis();
 		long mill2=cdate2.getTimeInMillis();
 		long diff_intime = 0;
 		diff_intime = mill2 - mill1;
 		diff_intime = diff_intime/(24*60*60*1000);
 		return diff_intime;
 	}
	/**
	 * @author:Karthikeyan.S
	 * @date:June 20, 2013-12:00:03 PM
	 * @category adding Months with a date
	 * @return
	 */
	public static String addMonthWithDate(Date date, int intMonths)
	{
		String strDate="";
		try
		{
			Calendar cal=Calendar.getInstance();
			cal.setTime(date);
			cal.add(Calendar.MONTH,intMonths);
			date=cal.getTime();
			SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yyyy");
			strDate=sdf.format(date);
		}
		catch (Exception e)
		{
			log.info("Error in addMonthWithDate:" + e);
		}
		return strDate;
	}
	
	public static String addMonthWithLastDate(Date date, int intMonths)
	{
		String strDate="";
		try
		{
			Calendar cal=Calendar.getInstance();
			cal.setTime(date);
			cal.add(Calendar.MONTH,intMonths);
			cal.set(cal.DAY_OF_MONTH,cal.getActualMaximum(cal.DAY_OF_MONTH));
			date=cal.getTime();
			SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yyyy");
			strDate=sdf.format(date);
		}
		catch (Exception e)
		{
			log.info("Error in addMonthWithDate:" + e);
		}
		return strDate;
	}
	public static String getMQHDate(String frequency)
	{
		String strDate="";
		ResultSet rs=null;
		String strQuery="";
		try
		{
			int year=Calendar.getInstance().get(Calendar.YEAR);
			int period=Calendar.getInstance().get(Calendar.MONTH);
			++period;
			String date="";
			String month="";
			if(frequency.equalsIgnoreCase("m"))
			{
				strQuery=SQLParser.getSqlQuery("sel_enddate");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strDate=Helper.correctNull((String)rs.getString("mon_enddate"));
				}
			}
			if(frequency.equalsIgnoreCase("q"))
			{
				if(period <= 3)
				{
					date="31";
					month="03";
				}
				else if(period <= 6)
				{
					date="30";
					month="06";
				}
				else if(period <= 9)
				{
					date="30";
					month="09";
				}
				else if(period <= 12)
				{
					date="31";
					month="12";
				}
			}
			if(frequency.equalsIgnoreCase("h"))
			{
				if(period <= 6)
				{
					date="30";
					month="06";
				}
				else if(period <= 12)
				{
					date="31";
					month="12";
				}
			}
			if(frequency.equalsIgnoreCase("y"))
			{
					date="31";
					month="12";
			}
			if(!frequency.equalsIgnoreCase("m"))
			{
				strDate=date+"/"+month+"/"+Integer.toString(year);
			}
		}
		catch(Exception e)
		{
			log.info("Error in getting MQHDate:" + e);
		}
		return strDate;
		
	}
	/**
	 * @author:Prakash N
	 * @date:August 1st, 2013-12:00:03 PM
	 * @category getting Financial Year
	 * @return
	 */
	public static String financialYear()
	{
		String strFinancialYear="";
		ResultSet rs=null;
		String strQuery="";
		try
		{
			strQuery=SQLParser.getSqlQuery("selfinancialyear");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strFinancialYear=Helper.correctNull((String)rs.getString("FinancialYear"));
			}
		}
		catch (Exception e)
		{
			log.info("Error in addMonthWithDate:" + e);
		}
		return strFinancialYear;
	}
	
	//added by bhaskar for rupess conversion
	public static String convertSetupToApplicationValues(String strValuesIn ,double convertAmount)
	{
		double dbAmount=0.00;
		String strtest = "";
		if(strValuesIn.equalsIgnoreCase("R"))
		{
			dbAmount=convertAmount;
		}
		else if(strValuesIn.equalsIgnoreCase("L"))
		{
			dbAmount=convertAmount/100000;
		}
		else if(strValuesIn.equalsIgnoreCase("C"))
		{
			dbAmount=convertAmount/10000000;
		}	
		else
		{
			dbAmount=convertAmount;
		}	
		strtest =String.valueOf(dbAmount);		
		return strtest;
	}
	public static String convertApplicationToSetup(String strValuesIn ,double convertAmount)
	{
		double dbAmount=0.00;
		String strAmount="";
		if(strValuesIn.equalsIgnoreCase("R"))
		{
			dbAmount=convertAmount;
		}
		else if(strValuesIn.equalsIgnoreCase("L"))
		{
			dbAmount=convertAmount*100000;
		}
		else if(strValuesIn.equalsIgnoreCase("C"))
		{
			dbAmount=convertAmount*10000000;
		}	
		strAmount=String.valueOf(dbAmount);
		
		return strAmount;
	}
	public static HashMap splitScheme(String strselectscheme)
	{
		HashMap hshResult=new HashMap();
		if(!strselectscheme.equalsIgnoreCase(""))
		{
			if(!strselectscheme.equalsIgnoreCase("0"))
			{
			String strSelectSchemesplit[] = strselectscheme.split("-");
			hshResult.put("facility_sno", strSelectSchemesplit[0]);
			hshResult.put("facility_schemetype", strSelectSchemesplit[1]);
			}
			else
			{
				hshResult.put("facility_sno", "");
				hshResult.put("facility_schemetype", "0");
			}
		}
		else
		{
			hshResult.put("facility_sno", "");
			hshResult.put("facility_schemetype", "");
		}
		
		return hshResult;
	}
	public static String getfacilitySno(String strselectscheme)
	{
		String strFacilitycode="";
		if(!strselectscheme.equalsIgnoreCase(""))
		{
			if(!strselectscheme.equalsIgnoreCase("0"))
			{
			String strSelectSchemesplit[] = strselectscheme.split("-");
			strFacilitycode= strSelectSchemesplit[0];
			}
			else
			{
				strFacilitycode="";
			}
		}
		else
		{
			strFacilitycode="";
		}
		
		return strFacilitycode;
	}
	public static String getfacilitySchemetype(String strselectscheme)
	{
		String strFacilitySchemetype="";
		if(!strselectscheme.equalsIgnoreCase(""))
		{
			if(!strselectscheme.equalsIgnoreCase("0"))
			{
			String strSelectSchemesplit[] = strselectscheme.split("-");
			strFacilitySchemetype= strSelectSchemesplit[1];
			}
			else
			{
				strFacilitySchemetype="0";
			}
		}
		else
		{
			strFacilitySchemetype="";
		}
		
		return strFacilitySchemetype;
	}
	//ended
	public static String checkPercentageDecimalPoint(String strDec) {
		String str = strDec;
		if(!(str==null || str=="null"))
		{
			if (str.indexOf(".") != -1)
			{
				if(FwUtils.parseInt(strDec.substring(str.indexOf(".")+1, strDec.length()))<=0)
				{
					return strDec.substring(0,strDec.indexOf("."));
				}
			} 
			else if(str.trim().equalsIgnoreCase("")||str.trim().equalsIgnoreCase("null") )
			{
				str = str.concat("0");
				return str;
			}
		}
		else
		{
			return "0";
		}
		return str;
	}
	public static double correctLakhstoValues(String strValuesin,double dblamount) 
	{
		if(strValuesin.equalsIgnoreCase("1"))
		{
			dblamount=dblamount/100000;
		}
		else if(strValuesin.equalsIgnoreCase("2"))
		{
			dblamount=dblamount/100;
		}
		else if(strValuesin.equalsIgnoreCase("3"))
		{
			dblamount=dblamount;
		}
		else if(strValuesin.equalsIgnoreCase("4"))
		{
			dblamount=dblamount*100;
		}
		else
		{
			dblamount=0.00;
		}
		return dblamount;
	}
	//for CBS ID check
	public static String correctNullCBS(String strNull) {
		if (strNull == null) {
			strNull = "";
		} 
		return strNull; 
	}
	
	public static double correctRupeestoValues(String strValuesin,double dblamount) 
	{
		if(strValuesin.equalsIgnoreCase("1"))
		{
			dblamount=dblamount;
		}
		else if(strValuesin.equalsIgnoreCase("2"))
		{
			dblamount=dblamount/1000;
		}
		else if(strValuesin.equalsIgnoreCase("3"))
		{
			dblamount=dblamount/100000;
		}
		else if(strValuesin.equalsIgnoreCase("4"))
		{
			dblamount=dblamount/10000000;
		}
		else
		{
			dblamount=0.00;
		}
		return dblamount;
	}

	public static String replaceComma(String str)
	{
	       return correctNull(str).replaceAll(",","");
	}
	public static String getIntDmdDate(String strCurrentDate,String strperiodicity)
	{
		String strIntdmdDate="";
		ResultSet rs=null;
		try{
			String strMonth = strCurrentDate.substring(3, 5);
			if(strperiodicity.equalsIgnoreCase("m"))
			{
				String strQuery=SQLParser.getSqlQuery("sel_enddate");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strIntdmdDate=Helper.correctNull((String)rs.getString("mon_enddate"));
				}
				if(rs!=null)
				{
					rs.close();
				}
			}
			else
			{
				if(strMonth.equalsIgnoreCase("01")||strMonth.equalsIgnoreCase("02")||strMonth.equalsIgnoreCase("03"))
				{
					strIntdmdDate="31/03/"+strCurrentDate.substring(6,10);
				}
				else if(strperiodicity.equalsIgnoreCase("y"))//for yearly
				{
					strIntdmdDate="31/03/"+strCurrentDate.substring(6,10);
				}
				else if(strperiodicity.equalsIgnoreCase("h"))//for half yearly
				{
					if(strMonth.equalsIgnoreCase("04")||strMonth.equalsIgnoreCase("05")||strMonth.equalsIgnoreCase("06")||strMonth.equalsIgnoreCase("07")||strMonth.equalsIgnoreCase("08")||strMonth.equalsIgnoreCase("09"))
					{
						strIntdmdDate="30/09/"+strCurrentDate.substring(6,10);
					}
					else
					{
						strIntdmdDate="31/03/"+strCurrentDate.substring(6,10);
					}
				}
				else if(strperiodicity.equalsIgnoreCase("q"))//for quarterly
				{
					if(strMonth.equalsIgnoreCase("01")||strMonth.equalsIgnoreCase("02")||strMonth.equalsIgnoreCase("03"))
					{
						strIntdmdDate="31/03/"+strCurrentDate.substring(6,10);
					}
					else if(strMonth.equalsIgnoreCase("04")||strMonth.equalsIgnoreCase("05")||strMonth.equalsIgnoreCase("06"))
					{
						strIntdmdDate="31/06/"+strCurrentDate.substring(6,10);
					}
					else if(strMonth.equalsIgnoreCase("07")||strMonth.equalsIgnoreCase("08")||strMonth.equalsIgnoreCase("09"))
					{
						strIntdmdDate="30/09/"+strCurrentDate.substring(6,10);
					}
					else
					{
						strIntdmdDate="31/12/"+strCurrentDate.substring(6,10);
					}
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return strIntdmdDate;
	}
	public static String getNextIntDmdDate(String strCurrentDate,String strperiodicity,String Type)
	{
		String strNextIntdmdDate="";
		ResultSet rs=null;
		try{
			String strMonth = strCurrentDate.substring(3, 5);
			if(strperiodicity.equalsIgnoreCase("y") && Type.equalsIgnoreCase("002"))
			{
				if(strMonth.equalsIgnoreCase("01")||strMonth.equalsIgnoreCase("02")||strMonth.equalsIgnoreCase("03"))
				{
					strNextIntdmdDate="31/03/"+strCurrentDate.substring(6,10);
				}
				else{
					int year=parseInt(strCurrentDate.substring(6,10));
					year=year+1;
					strNextIntdmdDate="31/03/"+year;

				}
			}
			else if(strperiodicity.equalsIgnoreCase("y") && Type.equalsIgnoreCase("001"))
			{
				if(strMonth.equalsIgnoreCase("01")||strMonth.equalsIgnoreCase("02")||strMonth.equalsIgnoreCase("03"))
				{
					strNextIntdmdDate="31/05/"+strCurrentDate.substring(6,10);
				}
				else{
					int year=parseInt(strCurrentDate.substring(6,10));
					year=year+1;
					strNextIntdmdDate="31/05/"+year;

				}
			}
			else if(strperiodicity.equalsIgnoreCase("q"))
			{

				if(strMonth.equalsIgnoreCase("01")||strMonth.equalsIgnoreCase("02")||strMonth.equalsIgnoreCase("03"))
				{
					strNextIntdmdDate="31/03/"+strCurrentDate.substring(6,10);
				}
				else if(strMonth.equalsIgnoreCase("04")||strMonth.equalsIgnoreCase("05")||strMonth.equalsIgnoreCase("06"))
				{
					strNextIntdmdDate="30/06/"+strCurrentDate.substring(6,10);
				}
				else if(strMonth.equalsIgnoreCase("07")||strMonth.equalsIgnoreCase("08")||strMonth.equalsIgnoreCase("09"))
				{
					strNextIntdmdDate="30/09/"+strCurrentDate.substring(6,10);
				}
				else
				{
					strNextIntdmdDate="31/12/"+strCurrentDate.substring(6,10);
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return strNextIntdmdDate;
		
	}
	

	
	/**
	 * @author:ARCHUNAN A
	 * @date:April 10th, 2014-11:00:03 PM
	 * @category To Covert string to title case
	 * @return string
	 */
	public static String changetoTitlecase(String strDec) {
		StringBuilder SB = new StringBuilder();
		String str = strDec;
		if(!((str.equalsIgnoreCase("") || str.equalsIgnoreCase(""))))
		{
			for(String sbr:str.split(" "))
			{
				if(SB.length()>0)
				{
					SB.append(" ");
				}
				if(sbr.length()>1)
				{
					SB.append(sbr.substring(0,1).toUpperCase()).append(sbr.substring(1,sbr.length()).toLowerCase());
				}
				else if(!(sbr.equalsIgnoreCase(" ") || sbr.equalsIgnoreCase("")))
				{
					SB.append(sbr.substring(0,1).toUpperCase());
				}
			}
		}
		else
		{
			return "";
		}
		return SB.toString();
	}
    public static String correctDoubleAndSingleQuates(String str) {        
        return Helper.replaceAll(Helper.correctNull(str),"\"","",false).replaceAll("'","").replaceAll("/","").replaceAll(">","").replaceAll("<","");
    }
    public static String addComma(String strValue)
	{
			strValue=correctNull(strValue);
			if(strValue.equals(""))
			{
				return strValue;
			}
			else
			{
				java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
				nf.setMaximumFractionDigits(2);
				nf.setMinimumFractionDigits(2);
				nf.setGroupingUsed(false);
				strValue=strValue.replaceAll("\\,", "");
				strValue=nf.format(Double.parseDouble(strValue));
			}
			String strValueTemp=strValue;
			String x1=null,x2="00";
			StringBuffer sbf=null;
			if(strValueTemp.indexOf("-")!=-1)strValueTemp=strValueTemp.substring(strValueTemp.indexOf("-")+1, strValueTemp.length());
			if(strValueTemp.indexOf(".")!= -1)
			{
				String x[] = strValueTemp.split("\\.");
				x1 = x[0];
				x2 = x[1].trim();
				if(x2.equals("0"))x2="00";
			}
			else
			{
				x1=strValueTemp;
			}
			int intrupeeslength=x1.length();
			sbf=new StringBuffer(x1);
			 if(intrupeeslength > 3)
			    {
				 sbf.insert(intrupeeslength - 3, ',');
			        for(intrupeeslength -= 3; intrupeeslength > 2; intrupeeslength -= 2)
			        	sbf.insert(intrupeeslength - 2, ',');
			    }
			 sbf.append(".");sbf.append(x2);
			 if(strValue.indexOf("-")!=-1)return "-"+sbf.toString(); 
			return sbf.toString();
	}
	/* End */

    public static String underLine(int length, String strNull) 
    {
		if ((strNull == null) || strNull == "") 
		{
			for(int i=0;i<length;i++)
			{
				strNull=strNull.concat("______");
			}
		}
		return strNull.trim();
	}
    
    public static void sendSMSFromVariousPlace(HashMap hshTemp)
    {
    	log.info("Request came for SMS ==="+hshTemp);
    	String query = null;
		URLConnection conn = null;
		String charset="UTF-8",strFileIds="",strMobileno="",strMessage="",strAppno="";
		strMobileno= Helper.correctNull((String)hshTemp.get("strMobileno"));
		strMessage= Helper.correctNull((String)hshTemp.get("strMessage"));
		strAppno= Helper.correctNull((String)hshTemp.get("strAppno"));
    	try
    	{
    		query = String.format("dcode=%s&userid=%s&pwd=%s&sender=%s&to=%s&msgtype=%s&msgtxt=%s",
    				ApplicationParams.getStrSMSDCode()+"&"+ApplicationParams.getStrSMSDCode1()+"&"+ApplicationParams.getStrSMSDCode2()+"&"+ApplicationParams.getStrSMSDCode3()+"&"+ApplicationParams.getStrSMSDCode4()+"&"+ApplicationParams.getStrSMSDCode5(), URLEncoder.encode(ApplicationParams.getStrSMSUserID(), charset), 
							ApplicationParams.getStrSMSPassword(), URLEncoder.encode(ApplicationParams.getStrSMSSender(), charset), URLEncoder
							.encode(strMobileno, charset), URLEncoder.encode(ApplicationParams.getStrSMSTypeFlag(), charset),
							URLEncoder.encode(strMessage, charset));
			
			log.info("==================Invoking Service in Try Block================\n"+ApplicationParams.getStrSMSURL() + "?" + query);
			conn = new URL(ApplicationParams.getStrSMSURL() + "?" + query).openConnection();
			log.info("================== Service Ended================");
			
		conn.setRequestProperty("Accept-Charset", charset);
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		String output;
		while ((output = br.readLine()) != null) {
			strFileIds = output;
		}
		log.info("================== Response Received ================" + strFileIds);
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues = new ArrayList();
		arrValues.add(strMobileno);
		arrValues.add(strMessage);
		arrValues.add(strFileIds);
		arrValues.add(strAppno);
		hshQuery.put("strQueryId", "ins_smshistroy");
		hshQuery.put("arrValues", arrValues);
		hshQueryValues.put("1", hshQuery);
		hshQueryValues.put("size", "1");
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
    	}catch (Exception e) {
			e.printStackTrace();
		}
    }
    
    
    @SuppressWarnings("unused")
	public static String correctDateFinacle() {
    	String dateformat="",strNull="";
		try {
			//2012-10-02T14:14:27.262
			//01/0-/2-22T13:38:54:529
			//01/0-/2-22T13:54:05:113
			
			
			Calendar cal = Calendar.getInstance();
			//if (strNull == null) {
				strNull = getCurrentDateTime();
//				strNull = strNull.substring(8, 10) + "/"
//						+ strNull.substring(5, 7) + "/"
				//strNull = 	 strNull.substring(0, 4)+"-"+strNull.substring(5, 7)+"-"+strNull.substring(8, 10);
				
				strNull= strNull.substring(6, 10)+"-"+strNull.substring(3, 5)+"-"+strNull.substring(0, 2);
			//}
			
			String strSysTime = String.valueOf(cal.get(Calendar.HOUR_OF_DAY));
			if (Integer.parseInt(strSysTime) < 10) {
				strSysTime = "0" + strSysTime;
			}
			String strSysMinute = String.valueOf(cal.get(Calendar.MINUTE));
			if (Integer.parseInt(strSysMinute) < 10) {
				strSysMinute = "0" + strSysMinute;
			}

			String strSysSecond = String.valueOf(cal.get(Calendar.SECOND));
			if (Integer.parseInt(strSysSecond) < 10) {
				strSysSecond = "0" + strSysSecond;
			}
			String strSysSecond2 = String.valueOf(cal.get(Calendar.MILLISECOND));
			if (Integer.parseInt(strSysSecond2) < 10) {
				strSysSecond2 = "0" + strSysSecond2;
			}
			dateformat = strNull+"T"+strSysTime+":"+strSysMinute+":"+strSysSecond+"."+strSysSecond2;

		} catch (Exception e) {
			log.info("Error in correctDate:" + e);
		}
		return dateformat.trim();
	}
	 
}