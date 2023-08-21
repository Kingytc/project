package com.sai.laps.ejb.perlifestyle;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "LifeStyleBean", mappedName = "LifeStyleHome")
@Remote (LifeStyleRemote.class)
public class LifeStyleBean extends BeanAdapter
{	
	private static final long serialVersionUID = 1L;

	public HashMap getData(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery="";
		String strAppno="";
		String strEditlockflag = null;
		String strLock="";
		try
		{	
			strEditlockflag = (String)hshRequestValues.get("hideditflag");
			hshRecord = new HashMap();
			strAppno=correctNull((String)hshRequestValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("sellifestyle^"+strAppno);
			rs =DBUtils.executeQuery(strQuery);

			String recordflag="N";
			if(rs.next())
			{  	
				hshRecord.put("lifestyle_car",correctNull(rs.getString(1)));
				hshRecord.put("lifestyle_scooter",correctNull(rs.getString(2)));
				hshRecord.put("lifestyle_fridge",correctNull(rs.getString(3)));
				hshRecord.put("lifestyle_telephone",correctNull(rs.getString(4)));
				hshRecord.put("lifestyle_computer",correctNull(rs.getString(5)));
				hshRecord.put("lifestyle_mobile",correctNull(rs.getString(6)));
				hshRecord.put("lifestyle_washing_machine",correctNull(rs.getString(7)));
				hshRecord.put("lifestyle_television",correctNull(rs.getString(8)));
				
				hshRecord.put("LIFESTYLE_CAR_DATE",correctNull(rs.getString(9)));
				hshRecord.put("LIFESTYLE_SCOOTER_DATE",correctNull(rs.getString(10)));
				hshRecord.put("LIFESTYLE_FRIDGE_DATE",correctNull(rs.getString(11)));
				hshRecord.put("LIFESTYLE_TELEPHONE_DATE",correctNull(rs.getString(12)));
				hshRecord.put("LIFESTYLE_COMPUTER_DATE",correctNull(rs.getString(13)));
				hshRecord.put("LIFESTYLE_MOBILE_DATE",correctNull(rs.getString(14)));
				hshRecord.put("LIFESTYLE_WASHING_MACHINE_DATE",correctNull(rs.getString(15)));
				hshRecord.put("LIFESTYLE_TELEVISION_DATE",correctNull(rs.getString(16)));
				
				hshRecord.put("LIFESTYLE_CAR_MARKET",correctNull(rs.getString(17)));
				hshRecord.put("LIFESTYLE_SCOOTER_MARKET",correctNull(rs.getString(18)));
				hshRecord.put("LIFESTYLE_FRIDGE_MARKET",correctNull(rs.getString(19)));
				hshRecord.put("LIFESTYLE_TELEPHONE_MARKET",correctNull(rs.getString(20)));
				hshRecord.put("LIFESTYLE_COMPUTER_MARKET",correctNull(rs.getString(21)));
				hshRecord.put("LIFESTYLE_MOBILE_MARKET",correctNull(rs.getString(22)));
				hshRecord.put("LIFESTYLE_WASHING_MARKET",correctNull(rs.getString(23)));
				hshRecord.put("LIFESTYLE_TELEVISION_MARKET",correctNull(rs.getString(24)));
				
				hshRecord.put("LIFESTYLE_CAR_LOANAMT",correctNull(rs.getString(25)));
				hshRecord.put("LIFESTYLE_SCOOTER_LOANAMT",correctNull(rs.getString(26)));
				hshRecord.put("LIFESTYLE_FRIDGE_LOANAMT",correctNull(rs.getString(27)));
				hshRecord.put("LIFESTYLE_TELEPHONE_LOANAMT",correctNull(rs.getString(28)));
				hshRecord.put("LIFESTYLE_COMPUTER_LOANAMT",correctNull(rs.getString(29)));
				hshRecord.put("LIFESTYLE_MOBILE_LOANAMT",correctNull(rs.getString(30)));
				hshRecord.put("LIFESTYLE_WASHING_LOANAMT",correctNull(rs.getString(31)));
				hshRecord.put("LIFESTYLE_TELEVISION_LOANAMT",correctNull(rs.getString(32)));
				recordflag="Y";
			}
			hshRecord.put("recordflag",recordflag);
			if(strEditlockflag!=null && strEditlockflag.equalsIgnoreCase("yes"))
			{
				//strLock = (String)EJBInvoker.executeStateLess("appeditlock",hshRequestValues,"lockApplication");
			}
			if(strEditlockflag!=null && strEditlockflag.equalsIgnoreCase("no"))
			{
				//EJBInvoker.executeStateLess("appeditlock",hshRequestValues,"unLockApplication");
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login lifestyle "+ce.toString());
		}
		finally
		{
			try
			{	
				if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		hshRecord.put("editlock",strLock);
		return hshRecord;
	}
	
	public void updateData(HashMap hshValues) 
	{	
		ArrayList arrValues = new ArrayList();
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		String strAppno=correctNull((String)hshValues.get("appno"));
		try
		{				
			hshQueryValues.put("size","2");
			hshQuery.put("strQueryId","dellifestyle");
			arrValues.add(strAppno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQuery = new HashMap();
			hshQuery.put("strQueryId","inslifestyle");
			arrValues = new ArrayList();
			arrValues.add(strAppno);
			arrValues.add(correctNull((String)(hshValues.get("hidselect1"))));
			arrValues.add(correctNull((String)(hshValues.get("hidselect2"))));
			arrValues.add(correctNull((String)(hshValues.get("hidselect3"))));
			arrValues.add(correctNull((String)(hshValues.get("hidselect4"))));
			arrValues.add(correctNull((String)(hshValues.get("hidselect5"))));
			arrValues.add(correctNull((String)(hshValues.get("hidselect6"))));
			arrValues.add(correctNull((String)(hshValues.get("hidselect7"))));
			arrValues.add(correctNull((String)(hshValues.get("hidselect8"))));
			arrValues.add(correctNull((String)(hshValues.get("txt_date1"))));
			arrValues.add(correctNull((String)(hshValues.get("txt_date2"))));
			arrValues.add(correctNull((String)(hshValues.get("txt_date3"))));
			arrValues.add(correctNull((String)(hshValues.get("txt_date4"))));
			arrValues.add(correctNull((String)(hshValues.get("txt_date5"))));
			arrValues.add(correctNull((String)(hshValues.get("txt_date6"))));
			arrValues.add(correctNull((String)(hshValues.get("txt_date7"))));
			arrValues.add(correctNull((String)(hshValues.get("txt_date8"))));
			arrValues.add(correctNull((String)(hshValues.get("txt_market1"))));
			arrValues.add(correctNull((String)(hshValues.get("txt_market2"))));
			arrValues.add(correctNull((String)(hshValues.get("txt_market3"))));
			arrValues.add(correctNull((String)(hshValues.get("txt_market4"))));
			arrValues.add(correctNull((String)(hshValues.get("txt_market5"))));
			arrValues.add(correctNull((String)(hshValues.get("txt_market6"))));
			arrValues.add(correctNull((String)(hshValues.get("txt_market7"))));
			arrValues.add(correctNull((String)(hshValues.get("txt_market8"))));
			arrValues.add(correctNull((String)(hshValues.get("txt_loanamt1"))));
			arrValues.add(correctNull((String)(hshValues.get("txt_loanamt2"))));
			arrValues.add(correctNull((String)(hshValues.get("txt_loanamt3"))));
			arrValues.add(correctNull((String)(hshValues.get("txt_loanamt4"))));
			arrValues.add(correctNull((String)(hshValues.get("txt_loanamt5"))));
			arrValues.add(correctNull((String)(hshValues.get("txt_loanamt6"))));
			arrValues.add(correctNull((String)(hshValues.get("txt_loanamt7"))));
			arrValues.add(correctNull((String)(hshValues.get("txt_loanamt8"))));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("2",hshQuery);	
			//Start of Audit Trial
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			StringBuilder sbAt = new StringBuilder();
			sbAt.append("Owning a Vehicle/FourWheeler ::").append("");
			sbAt.append(" ~Available =").append(correctNull((String)(hshValues.get("select1"))).equalsIgnoreCase("1")?"Yes":"No");
			sbAt.append(" ~Purchase Date =").append(correctNull((String)(hshValues.get("txt_date1"))));
			sbAt.append(" ~Market Value =").append(correctNull((String)(hshValues.get("txt_market1"))));
			sbAt.append(" ~Loan Amount if Any=").append(correctNull((String)(hshValues.get("txt_loanamt1"))));
			sbAt.append(" ~Owning a Vehicle/TwoWheeler ::").append("");
			sbAt.append(" ~Available =").append(correctNull((String)(hshValues.get("select2"))).equals("1")?"Yes":"No");
			sbAt.append(" ~Purchase Date =").append(correctNull((String)(hshValues.get("txt_date2"))));
			sbAt.append(" ~Market Value =").append(correctNull((String)(hshValues.get("txt_market2"))));
			sbAt.append(" ~Loan Amount if Any=").append(correctNull((String)(hshValues.get("txt_loanamt2"))));
			sbAt.append(" ~Fridge ::").append("");
			sbAt.append(" ~Available =").append(correctNull((String)(hshValues.get("select3"))).equals("1")?"Yes":"No");
			sbAt.append(" ~Purchase Date =").append(correctNull((String)(hshValues.get("txt_date3"))));
			sbAt.append(" ~Market Value =").append(correctNull((String)(hshValues.get("txt_market3"))));
			sbAt.append(" ~Loan Amount if Any=").append(correctNull((String)(hshValues.get("txt_loanamt3"))));
			sbAt.append(" ~ Telephone ::").append("");
			sbAt.append(" ~Available =").append(correctNull((String)(hshValues.get("select4"))).equals("1")?"Yes":"No");
			sbAt.append(" ~Purchase Date =").append(correctNull((String)(hshValues.get("txt_date4"))));
			sbAt.append(" ~Market Value =").append(correctNull((String)(hshValues.get("txt_market4"))));
			sbAt.append(" ~Loan Amount if Any=").append(correctNull((String)(hshValues.get("txt_loanamt4"))));
			sbAt.append(" ~Computer/Laptop ::").append("");
			sbAt.append(" ~Available =").append(correctNull((String)(hshValues.get("select5"))).equals("1")?"Yes":"No");
			sbAt.append(" ~Purchase Date =").append(correctNull((String)(hshValues.get("txt_date5"))));
			sbAt.append(" ~Market Value =").append(correctNull((String)(hshValues.get("txt_market5"))));
			sbAt.append(" ~Loan Amount if Any=").append(correctNull((String)(hshValues.get("txt_loanamt5"))));
			sbAt.append(" ~Cell Phone ::").append("");
			sbAt.append(" ~Available =").append(correctNull((String)(hshValues.get("select6"))).equals("1")?"Yes":"No");
			sbAt.append(" ~Purchase Date =").append(correctNull((String)(hshValues.get("txt_date6"))));
			sbAt.append(" ~Market Value =").append(correctNull((String)(hshValues.get("txt_market6"))));
			sbAt.append(" ~Loan Amount if Any=").append(correctNull((String)(hshValues.get("txt_loanamt6"))));
			sbAt.append(" ~WashingMachine ::").append("");
			sbAt.append(" ~Available =").append(correctNull((String)(hshValues.get("select7"))).equals("1")?"Yes":"No");
			sbAt.append(" ~Purchase Date =").append(correctNull((String)(hshValues.get("txt_date7"))));
			sbAt.append(" ~Market Value =").append(correctNull((String)(hshValues.get("txt_market7"))));
			sbAt.append(" ~Loan Amount if Any=").append(correctNull((String)(hshValues.get("txt_loanamt7"))));
			sbAt.append(" ~ Television ::").append("");
			sbAt.append(" ~Available =").append(correctNull((String)(hshValues.get("select8"))).equals("1")?"Yes":"No");
			sbAt.append(" ~Purchase Date =").append(correctNull((String)(hshValues.get("txt_date8"))));
			sbAt.append(" ~Market Value =").append(correctNull((String)(hshValues.get("txt_market8"))));
			sbAt.append(" ~Loan Amount if Any=").append(correctNull((String)(hshValues.get("txt_loanamt8"))));
			if(correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
			{
				hshValues.put("hidAction","update");
			}
			else
			{
				hshValues.put("hidAction","insert");
			}
			AuditTrial.auditLog(hshValues,"52",strAppno,sbAt.toString());
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateData "+ce.toString());
		}
		finally
		{	
			try
			{
				//EJBInvoker.executeStateLess("appeditlock",hshValues,"unLockApplication");
			}
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
	}
}