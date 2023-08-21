package com.sai.laps.ejb.combanking;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.ApplicantParams;
import com.sai.laps.helper.AuditTrial;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "combankingBean", mappedName = "combankingHome")
@Remote (combankingRemote.class)
public class combankingBean extends BeanAdapter
{	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(combankingBean.class);
	public HashMap updateData(HashMap hsh) 
	{
		ResultSet rs=null;		
		HashMap hshValues = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();		
		try
		{
			rs=DBUtils.executeLAPSQuery("bankmaster");
			while(rs.next())
			{
				arr.add(correctNull(rs.getString("bankid")));
				arr1.add(correctNull(rs.getString("bankname")));
			}
			hshValues.put("arr",arr);
			hshValues.put("arr1",arr1);
		}
		catch (Exception e)
		{
			throw new EJBException("Error Occured"+e.getMessage());
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
		return hshValues;
	}

	public void updateInfo(HashMap hsh) 
	{		
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQuery ;
		ArrayList arr = new ArrayList();
		ArrayList arrValues ;
		ResultSet rs=null;
		String val="";
		int intValue = 0;
		String appno="";
		
		try
		{
			val=correctNull((String)hsh.get("hidAction"));
			appno=correctNull((String)hsh.get("appno"));			
			String []behalf=null;
			String []guarantee = null;
			String []type=null;
			String []due=null;
			String []amount = null;
			String [] type1=null;
			int intUpdatesize=0;
			behalf= (String [])hsh.get("behalf");
			guarantee= (String [])hsh.get("guarantee");
			type= (String [])hsh.get("type");
			due= (String [])hsh.get("due");
			amount = (String [])hsh.get("amount");
			type1= (String [])hsh.get("type1");
			
			if (val.equals("update"))
			{
				intUpdatesize=1;
				hshquery=new HashMap();
				arr=new ArrayList();
				hshqueryval=new HashMap();
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshquery.put("strQueryId","cominfodel");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);

				hshquery=new HashMap();
				arr=new ArrayList();
				intUpdatesize=	intUpdatesize + 1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshquery.put("strQueryId","cominfodelete");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put(Integer.toString(intUpdatesize),hshquery);
				
				intUpdatesize=	intUpdatesize + 1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshquery=new HashMap();
				arr=new ArrayList();
				hshquery.put("strQueryId","cominfoinsert");
				arr.add(appno);
				arr.add("Details of suit");
				arr.add(hsh.get("suit"));
				hshquery.put("arrValues",arr);
				hshqueryval.put("3",hshquery);
				
				rs=DBUtils.executeLAPSQuery("cominfomax");
				while(rs.next())
				{
					intValue = (rs.getInt(1));					
				}
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				
				int len=behalf.length;
				for(int k=0;k<len;k++)
				{				
					if(!behalf[k].equals(""))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","cominfoins");
						arrValues.add(appno);
						intValue=intValue+1;
						String i=Integer.toString(intValue);
						arrValues.add(i);						
						arrValues.add(correctNull(type[k]));
						arrValues.add(correctNull(behalf[k]));
						arrValues.add(Helper.correctDouble((String)guarantee[k]));						
						hshQuery.put("arrValues",arrValues);						
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
					}
				}
				int len1=due.length;
				for(int x=0;x<len1;x++)
				{				
					if(!due[x].equals(""))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","cominfoins");
						arrValues.add(appno);
						intValue=intValue+1;
						String i=Integer.toString(intValue);
						arrValues.add(i);
						arrValues.add(correctNull(type1[x]));
						arrValues.add(correctNull(due[x]));					
						arrValues.add(Helper.correctDouble((String)amount[x]));						
						hshQuery.put("arrValues",arrValues);						
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
					}
				}
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}	
			if(val.equals("delete"))
			{
				intUpdatesize=1;
				hshquery=new HashMap();
				arr=new ArrayList();
				hshqueryval=new HashMap();
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshquery.put("strQueryId","cominfodel");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);

				hshquery=new HashMap();
				arr=new ArrayList();
				intUpdatesize=	intUpdatesize + 1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshquery.put("strQueryId","cominfodelete");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put(Integer.toString(intUpdatesize),hshquery);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			
			StringBuilder sbAuditTrial=new StringBuilder();
			
			int len=behalf.length;
			if (val.equals("update"))
			{
				sbAuditTrial.append("<b>Details of Corporate Guarantees issued by the applicant </b><br>");
				for(int k=0;k<len;k++)
				{				
					if(!behalf[k].equals(""))
					{	
						if(k==0)
						{	
							sbAuditTrial.append("S.No  =").append(k+1);
						}
						else
						{
							sbAuditTrial.append("~S.No  =").append(k+1);
						}
						sbAuditTrial.append("~on behalf of   =").append(correctNull(behalf[k])).append("~Amt. of Guarantee =").append(correctNull(guarantee[k]));
					}
				}	
				
				sbAuditTrial.append("<br><b>Details of Statutory Dues </b><br>");
				len=due.length;
				for(int k=0;k<len;k++)
				{				
					if(!due[k].equals(""))
					{	
						if(k==0)
						{	
							sbAuditTrial.append("S.No  =").append(k+1);
						}
						else
						{
							sbAuditTrial.append("~S.No  =").append(k+1);
						}
						sbAuditTrial.append("~Nature of Due  =").append(correctNull(due[k])).append("~Amount Due =").append(correctNull(amount[k]));
					}
				}	
			}
			if(correctNull((String)hsh.get("hidRecordflag")).equals("Y"))
				hsh.put("hidAction", "update");
			else if(correctNull((String)hsh.get("hidRecordflag")).equals("N"))
				hsh.put("hidAction", "insert");
			
			AuditTrial.auditLog(hsh,"155",appno,sbAuditTrial.toString());
		}
		catch (Exception e)
		{
			throw new EJBException("Error Occured"+e.getMessage());
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

	public void updateSegment(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();		
		HashMap hshQuery =new HashMap();
		ArrayList arr = new ArrayList();		
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
		String val="";
		int intValue = 0,int_Count=0;
		String appno="";

		try
		{
			val=(String)hsh.get("hidAction");
			appno=(String)hsh.get("appno");					
			String []products=null;
			String []locations = null;
			String []endwise = null;
			String []customer = null;
			String []use= null;
			rs=DBUtils.executeLAPSQuery("comproductsel^"+appno);
			while(rs.next())
			{
				int_Count = int_Count+1;					
			}
			/*rs1=DBUtils.executeLAPSQuery("comsegmentselection^"+appno+"^"+appno);
			arrValues=new ArrayList();
			while(rs1.next())
				{
				hshqueryval= new HashMap();						
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize_audit=1;
				hshQuery.put("strQueryId","audittrial");
				arrValues.add("59");
				arrValues.add(correctNull((String)hsh.get("strUserId")));
				arrValues.add(correctNull((String)hsh.get("strClientIP")));
				arrValues.add(appno);
			//	strActionData="Products="+correctNull(rs1.getString(1))+"~Customers in Numbers="+correctNull(rs1.getString(3))+"~Location="+correctNull(rs1.getString(4))+
					//	"~End wise Customers="+correctNull(rs1.getString(5))+"~End wise Usage="+correctNull(rs1.getString(6));
				strActionData="Products="+correctNull(rs1.getString(1))+"~Customers in Numbers="+correctNull(rs1.getString(3))+"~Location="+correctNull(rs1.getString(4))+
				"~End wise Customers="+correctNull(rs1.getString(5))+"~End wise Usage="+correctNull(rs1.getString(6));
				
				arrValues.add(strActionData);
				if(val.equalsIgnoreCase("delete"))
				{
					arrValues.add("delete");
				}
				else
				{
					arrValues.add("insert");
				}	
				hshQuery.put("arrValues",arrValues);				
				hshqueryval.put("size",Integer.toString(intUpdatesize_audit));
				hshqueryval.put(Integer.toString(intUpdatesize_audit),hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");	
			}*/

					
			if (val.equals("update"))
			{
				hshqueryval= new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				int intUpdatesize=0;
				intUpdatesize=1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshquery.put("strQueryId","comsegmentdel");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);		
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				if(rs != null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("comsegmentmax^"+appno);
				while(rs.next())
				{
					intValue = (rs.getInt(1));					
				}

				if(hsh.get("products") instanceof String)
				{
					products = new String[1];
					locations = new String[1];
					endwise = new String[1];
					customer = new String[1]; 
					use = new String[1];
					products[0]= (String)hsh.get("products");
					locations[0]= (String)hsh.get("locations");
					endwise[0]= (String)hsh.get("endwise");
					customer[0]= (String)hsh.get("customer");
					use[0]= (String)hsh.get("use");
				}
				else
				{
					products= (String [])hsh.get("products");
					locations= (String [])hsh.get("locations");
					endwise=(String [])hsh.get("endwise");
					customer=(String [])hsh.get("customer");
					use=(String [])hsh.get("use");
				}

				
				if((intValue < 1) &&(int_Count < 2))
				{	
				/*products= (String [])hsh.get("products");
				locations= (String [])hsh.get("locations");
				endwise=(String [])hsh.get("endwise");
				customer=(String [])hsh.get("customer");
				use=(String [])hsh.get("use");*/
				

				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("strQueryId","comsegmentins");
				arrValues.add(appno);
				intValue=intValue+1;
				String i=Integer.toString(intValue);						
				arrValues.add(i);						
				arrValues.add(correctNull((String)hsh.get("products")));						
				arrValues.add(correctNull((String)hsh.get("locations")));						
				arrValues.add(correctNull((String)hsh.get("endwise")));
				arrValues.add(correctNull((String)hsh.get("customer")));
				arrValues.add(correctNull((String)hsh.get("use")));													
				hshQuery.put("arrValues",arrValues);						
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
				}
				
				else
				{
					products= (String [])hsh.get("products");
					locations= (String [])hsh.get("locations");
					endwise=(String [])hsh.get("endwise");
					customer=(String [])hsh.get("customer");
					use=(String [])hsh.get("use");
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				
				int len=products.length;
				for(int k=0;k<len;k++)
				{				
					if(!products[k].equals(""))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","comsegmentins");
						arrValues.add(appno);
						intValue=intValue+1;
						String i=Integer.toString(intValue);						
						arrValues.add(i);						
						arrValues.add(correctNull(products[k]));						
						arrValues.add(correctNull(locations[k]));						
						arrValues.add(correctNull(endwise[k]));
						arrValues.add(correctNull(customer[k]));
						arrValues.add(correctNull(use[k]));															
						hshQuery.put("arrValues",arrValues);						
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
					}

				}
					/*if(!products[k].equals(""))
					{
						intUpdatesize_audit=0;
						HashMap hshqueryval_audit= new HashMap();
						HashMap	hshQuery_audit = new HashMap();
						ArrayList	arrValues_audit=new ArrayList();															
						intUpdatesize_audit=1;
							intValue=intValue+1;
						String i=Integer.toString(intValue);
						hshQuery_audit.put("strQueryId","audittrial");
						arrValues_audit.add("59");
						arrValues_audit.add(correctNull((String)hsh.get("strUserId")));
						arrValues_audit.add(correctNull((String)hsh.get("strClientIP")));
						arrValues_audit.add(appno);
						strActionData="id="+i+"~Products="+correctNull(products[k])+"~Customers in Numbers="+correctNull(customer[k])+"~Location="+correctNull(locations[k])+
												"~End wise Customers="+correctNull(endwise[k])+"~End wise Usage="+correctNull(use[k]);
						arrValues_audit.add(strActionData);
						if(val.equalsIgnoreCase("delete"))
						{
							arrValues_audit.add("delete");
						}
						else
						{
							arrValues_audit.add("insert");
						}
						hshQuery_audit.put("arrValues",arrValues_audit);						
						hshqueryval_audit.put("size",Integer.toString(intUpdatesize_audit));
						hshqueryval_audit.put(Integer.toString(intUpdatesize_audit),hshQuery_audit);	
					}*/

				}	
				
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");	
			}else if(val.equals("delete")){
				hshqueryval= new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshqueryval.put("size","1");
				hshquery.put("strQueryId","comsegmentdel");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				hshqueryval.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				
			}
					
		}
		catch (Exception e)
		{
			throw new EJBException("Error Occured"+e.getMessage());
		}
		finally
		{
			try
			{
				if(rs1 != null)
				{
					rs1.close();
				}
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
	
	
	public void updateDist(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQuery  = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arrValues = new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
		int intUpdatesize_audit=0;
		String strActionData="";
		String val="";
		int intValue = 0;
		String appno="";
		
		try
		{	
			StringBuilder sbAt = new StringBuilder();
			val=correctNull((String)hsh.get("hidAction"));
			appno=correctNull((String)hsh.get("appno"));					
			String []name=null;
			String []product = null;
			String []total = null;
			String []type = null;
			String []country=null;

			hshqueryval=new HashMap();	
			int intUpdatesize=0;
			

			if (val.equals("update"))
			{
				intUpdatesize=1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));

				hshquery.put("strQueryId","comdistdel");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				
				rs=DBUtils.executeLAPSQuery("comdistmax");
				while(rs.next())
				{
					intValue = (rs.getInt(1));					
				}
				name= (String [])hsh.get("name");
				product= (String [])hsh.get("product");
				total = (String [])hsh.get("total");
				type = (String [])hsh.get("type");		
				country = (String [])hsh.get("country");		
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				int len=name.length;
				for(int k=0;k<len;k++)
				{				
					if(!name[k].equals(""))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","comdistins");
						arrValues.add(appno);
						intValue=intValue+1;
						String i=Integer.toString(intValue);
						arrValues.add(i);
						arrValues.add(correctNull(type[k]));
						arrValues.add(correctNull(name[k]));
						arrValues.add(correctNull(product[k]));
						arrValues.add(Helper.correctDouble((String)total[k]));	
						arrValues.add(correctNull(country[k]));
						hshQuery.put("arrValues",arrValues);
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
						
						}
				}
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");		
			}
			if(val.equals("delete"))
			{
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshqueryval.put("size","1");
				hshquery.put("strQueryId","comdistdel");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");		
			}
			if(!val.equals("delete"))
			{
				name= (String [])hsh.get("name");
				product= (String [])hsh.get("product");
				total = (String [])hsh.get("total");
				type = (String [])hsh.get("type");		
				country = (String [])hsh.get("country");
				int len=name.length;
				for(int k=0;k<len;k++)
				{	
					if(!name[k].equals(""))
					{
						if(k==0)
						{
							sbAt.append("Customers Name=");
						}
						else
						{
							sbAt.append("~Customers Name=");
						}
						sbAt.append(correctNull(name[k])).append(
						"~Name of the country =").append(correctNull(country[k])).append(
						"~Product=").append(correctNull(product[k])).append(
						"~% of total turnover=").append(correctNull(total[k]));
					}
				}
	    	}	
			
			if(correctNull((String)hsh.get("hidRecordflag")).equals("Y"))
				hsh.put("hidAction", "update");
			else if(correctNull((String)hsh.get("hidRecordflag")).equals("N"))
				hsh.put("hidAction", "insert");
			
			
			AuditTrial.auditLog(hsh,"151",appno,sbAt.toString());
		}
		catch (Exception e)
		{
			throw new EJBException("Error Occured  "+e.getMessage());
		}		
		finally
		{
			try
			{
				if(rs1 != null)
				{
					rs1.close();
				}
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

	public void updateRaw(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQuery ;
		ArrayList arr = new ArrayList();
		ArrayList arrValues ;
		ResultSet rs=null;
		String val="";
		int intValue = 0,intValue1=0;
		String appno="";	
		
		try
		{
			val=correctNull((String)hsh.get("hidAction"));
			appno=correctNull((String)hsh.get("appno"));					
			String []rawmaterial=null;
			String []unit = null;
			String []costperunit = null;
			String []purity = null;
			String []percost = null;
			String []perrawcost = null;
			String []rawtype = null;
			String []location = null;
			String []from = null;		
			String []totalquantity=null;
			rawmaterial= (String [])hsh.get("rawmaterial");
			unit= (String [])hsh.get("unit");
			costperunit = (String [])hsh.get("costperunit");
			purity = (String [])hsh.get("purity");
			percost=(String [])hsh.get("percost");
			perrawcost=(String [])hsh.get("perrawcost");
			rawtype=(String [])hsh.get("rawtype");
			location=(String [])hsh.get("location");
			from=(String [])hsh.get("from");
			totalquantity=(String [])hsh.get("totalquantity");
			
			int intUpdatesize=0;
			if (val.equals("update"))
			{
				rs=DBUtils.executeLAPSQuery("comrawmax");
				while(rs.next())
				{
					intValue = (rs.getInt(1));	
				}
				intUpdatesize=1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshquery.put("strQueryId","comrawdel");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);	
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				int len=rawmaterial.length;
				for(int k=0;k<len;k++)
				{				
					if(!rawmaterial[k].equals(""))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","comrawins");
						arrValues.add(appno);
						intValue=intValue+1;
						String i=Integer.toString(intValue);
						arrValues.add(i);
						arrValues.add(correctNull(rawmaterial[k]));
						arrValues.add(correctNull(unit[k]));
						arrValues.add(Helper.correctDouble((String)costperunit[k]));
						arrValues.add(Helper.correctDouble((String)purity[k]));
						arrValues.add(Helper.correctDouble((String)percost[k]));
						arrValues.add(Helper.correctDouble((String)perrawcost[k]));
						arrValues.add(correctNull(rawtype[k]));
						arrValues.add(correctNull(location[k]));
						arrValues.add(correctNull(from[k]));	
						arrValues.add(correctNull(totalquantity[k]));
						hshQuery.put("arrValues",arrValues);						
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
					}
				}
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			
			if (val.equals("update"))
			{
				hshqueryval = new HashMap();
				intUpdatesize=0;
				
				if(rs!=null)
				{
					rs=null;
				}
				rs=DBUtils.executeLAPSQuery("comsuppmax^"+appno);
				while(rs.next())
				{
					intValue = (rs.getInt(1));
					intValue1 = (rs.getInt(1));	
				}
				if(intValue1==0)
				{							
					String mattype="";
					int len=rawmaterial.length;
					for(int k=0;k<len;k++)
					{				
						if(!rawmaterial[k].equals(""))
						{
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							mattype="";
							intUpdatesize=intUpdatesize+1;
							hshQuery.put("strQueryId","comsupins");
							arrValues.add(appno);
							if(correctNull(from[k]).equalsIgnoreCase("imp"))
							{
								mattype="imported";
							}
							else if(correctNull(from[k]).equalsIgnoreCase("ind"))
							{
								mattype="indigenous";
							}	
								
							arrValues.add(mattype);	
							intValue=intValue+1;
							String i=Integer.toString(intValue);
							arrValues.add(i);
							arrValues.add("0");					
							arrValues.add("");
							arrValues.add(correctNull(rawmaterial[k]));					
							arrValues.add("");
							hshQuery.put("arrValues",arrValues);						
							hshqueryval.put("size",Integer.toString(intUpdatesize));
							hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
						}
					}
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				}
				else
				{
					String mattype="";
					if(rs!=null)
					{
						rs=null;
					}
					int len=rawmaterial.length;
					for(int k=0;k<len;k++)
					{
						rs=DBUtils.executeLAPSQuery("comsup_allsel^"+appno+"^"+Integer.toString(k+1));
						if(rs.next())
						{
							if(rawmaterial[k].equalsIgnoreCase((String)rs.getString(2)))
							{
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								mattype="";
								intUpdatesize=intUpdatesize+1;
								hshQuery.put("strQueryId","comsup_update");
								
								if(correctNull(from[k]).equalsIgnoreCase("imp"))
								{
									mattype="imported";
								}
								else if(correctNull(from[k]).equalsIgnoreCase("ind"))
								{
									mattype="indigenous";
								}	
								arrValues.add(mattype);						
								arrValues.add(correctNull(rawmaterial[k]));
								arrValues.add(appno);
								arrValues.add(Integer.toString(k+1));
								hshQuery.put("arrValues",arrValues);						
								hshqueryval.put("size",Integer.toString(intUpdatesize));
								hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
							}//end if
							else
							{
								arr = new ArrayList();
								hshquery = new HashMap();
								intUpdatesize=intUpdatesize+1;
								hshqueryval.put("size",Integer.toString(intUpdatesize));
								hshquery.put("strQueryId","comsupdel_onerow");
								arr.add(appno);
								arr.add(Integer.toString(k+1));
								hshquery.put("arrValues",arr);
								hshqueryval.put(Integer.toString(intUpdatesize),hshquery);
								
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								mattype="";
								intUpdatesize=intUpdatesize+1;
								hshQuery.put("strQueryId","comsupins");
								arrValues.add(appno);
								if(correctNull(from[k]).equalsIgnoreCase("imp"))
								{
									mattype="imported";
								}
								else if(correctNull(from[k]).equalsIgnoreCase("ind"))
								{
									mattype="indigenous";
								}	
									
								arrValues.add(mattype);																	
								arrValues.add(Integer.toString(k+1));
								arrValues.add("0");					
								arrValues.add("");
								arrValues.add(correctNull(rawmaterial[k]));					
								arrValues.add("");
								hshQuery.put("arrValues",arrValues);						
								hshqueryval.put("size",Integer.toString(intUpdatesize));
								hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
							}//end else
						}//end if
						else
						{					
							if(!rawmaterial[k].equals(""))
							{
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								mattype="";
								intUpdatesize=intUpdatesize+1;
								hshQuery.put("strQueryId","comsupins");
								arrValues.add(appno);
								if(correctNull(from[k]).equalsIgnoreCase("imp"))
								{
									mattype="imported";
								}
								else if(correctNull(from[k]).equalsIgnoreCase("ind"))
								{
									mattype="indigenous";
								}	
								arrValues.add(mattype);	
								arrValues.add(Integer.toString(k+1));
								arrValues.add("0");					
								arrValues.add("");
								arrValues.add(correctNull(rawmaterial[k]));					
								arrValues.add("");
								hshQuery.put("arrValues",arrValues);						
								hshqueryval.put("size",Integer.toString(intUpdatesize));
								hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
							}
				       }//end else					
					}//end for
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				}//end else
			}//end if
						
			if(val.equalsIgnoreCase("delete"))
			{			
				arr = new ArrayList();
				hshquery = new HashMap();
				hshqueryval=new HashMap();
				intUpdatesize=1;
				hshqueryval.put("size","1");
				hshquery.put("strQueryId","comsupdel_all");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				
				arr = new ArrayList();
				hshquery = new HashMap();
				hshqueryval.put("size","2");
				hshquery.put("strQueryId","comrawdel");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put("2",hshquery);	
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}

			StringBuilder sbAuditTrial=new StringBuilder();
			
			int len=rawmaterial.length;
			if (val.equals("update"))
			{
				for(int k=0;k<len;k++)
				{				
					if(!rawmaterial[k].equals(""))
					{	
						if(k==0) 
						{	
							sbAuditTrial.append("~S.No  =");
						}
						else
						{
							sbAuditTrial.append("~S.No  =");
						}
						sbAuditTrial.append(k+1)
						.append("~List of Raw materials and Stores required   =").append(correctNull(rawmaterial[k]))
						.append("~Imported / Indigenous   =").append(ApplicantParams.getApplicantParams("RawMaterials",from[k]))
						.append("~Approximate cost per unit : Unit =").append(correctNull((String )unit[k]))
						.append("~Approximate cost per unit : Total Quantity of units =").append(correctNull(totalquantity[k]))
						.append("~Approximate cost per unit : Cost per unit =").append(correctNull(costperunit[k]))
						.append("~Approximate cost per unit : Purity Level % =").append(correctNull(purity[k]))
						.append("~% to cost of production  =").append(correctNull(percost[k]))
						.append("~% to raw material cost =").append(correctNull(perrawcost[k]))
						.append("~Availability along with location  =").append(correctNull(location[k]));
					}
				}	
			}
			if(correctNull((String)hsh.get("hidRecordflag")).equals("Y"))
				hsh.put("hidAction", "update");
			else if(correctNull((String)hsh.get("hidRecordflag")).equals("N"))
				hsh.put("hidAction", "insert");
			
			AuditTrial.auditLog(hsh,"149",appno,sbAuditTrial.toString());
		}
		catch (Exception e)
		{
			throw new EJBException("Error Occured"+e.getMessage());
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
	
	public void updateSupply(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQuery ;
		ArrayList arr = new ArrayList();
		ArrayList arrValues ;
		ResultSet rs=null;
		String val="";
		int intValue = 0;
		String appno="";
		
		try
		{
			val=(String)hsh.get("hidAction");
			appno=(String)hsh.get("appno");					
			String []supplier=null;
			String []location=null;
			String []material = null;
			String []credit = null;
			String []type = null;	
			String []sno = null;
			supplier= (String [])hsh.get("supplier");
			location= (String [])hsh.get("location");
			material= (String [])hsh.get("material");
			credit = (String [])hsh.get("credit");
			type = (String [])hsh.get("type");	
			sno = (String [])hsh.get("sno");	
			int intUpdatesize=0;
			intUpdatesize=1;
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery.put("strQueryId","comsupdel");
			arr.add(appno);
			hshquery.put("arrValues",arr);
			hshqueryval.put(Integer.toString(intUpdatesize),hshquery);

			if (val.equals("update"))
			{				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				
				int len=supplier.length;
				for(int k=0;k<len;k++)
				{					
					if(!material[k].equals(""))
					{	
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","comsupins");
						arrValues.add(appno);
						arrValues.add(correctNull(type[k]));						
						intValue=Integer.parseInt(sno[k]);
						arrValues.add(Integer.toString(intValue));
						if(supplier[k].equals(""))
						{
							arrValues.add("0");
						}
						else
						{
							arrValues.add(correctNull(supplier[k]));
						}
						arrValues.add(correctNull(location[k]));
						arrValues.add(correctNull(material[k]));
						arrValues.add(Helper.correctDouble((String)credit[k]));									
						hshQuery.put("arrValues",arrValues);										
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
					}
					
				}
			}//end if
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			// audit trial 
			/*hshqueryval= new HashMap();
			String strActionData = "";
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			int len_audit=supplier.length;
			for(int at=0;at<len_audit;at++)
			{								
				if(!supplier[at].equals(""))
				{
					hshqueryval= new HashMap();
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","audittrial");
					arrValues.add("51");
					arrValues.add(correctNull((String)hsh.get("strUserId")));
					arrValues.add(correctNull((String)hsh.get("strClientIP")));
					arrValues.add(appno);
					strActionData="supplier="+correctNull(supplier[at])+"~location="+
						correctNull(location[at])+"~material="+correctNull(material[at])+
						"~credit="+correctNull(credit[at]);
					arrValues.add(strActionData);
					if(val.equalsIgnoreCase("delete"))
					{
						arrValues.add("delete");
					}
					else
					{
						arrValues.add("insert");
					}				
					hshQuery.put("arrValues",arrValues);
					hshqueryval.put("size","1");
					hshqueryval.put("1",hshQuery);	
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");	
				}	
			}*/
			
			
		}
		catch (Exception e)
		{
			throw new EJBException("Error Occured"+e.getMessage());
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
	
	public HashMap getDistData(HashMap hsh) 
	{
		ResultSet rs=null;		
		HashMap hshValues = new HashMap();
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec= new ArrayList();
		String appno="";

		String recordflag="N";

		try
		{
			appno=(String)hsh.get("appno");
			rs=DBUtils.executeLAPSQuery("comdistsel^"+appno);
			while(rs.next())
			{
				vecRec = new ArrayList();
				vecRec.add(correctNull(rs.getString(1)));
				vecRec.add(correctNull(rs.getString(2)));
				vecRec.add(correctNull(rs.getString(3)));
				vecRec.add(correctNull(rs.getString(4)));
				vecRec.add(correctNull(rs.getString(5)));
				vecRec.add(correctNull(rs.getString(6)));	
				vecRec.add(correctNull(rs.getString(7)));
				vecVal.add(vecRec);	
				recordflag="Y";
			}
			hshValues.put("vecVal",vecVal);
			hshValues.put("recordflag",recordflag);
		}
		catch (Exception e)
		{
			throw new EJBException("Error Occured"+e.getMessage());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				throw new EJBException("Error Occured  "+e1.getMessage());
			}
		}
		return hshValues;
	}
	
	public HashMap getLoanData(HashMap hsh) 
	{
		ResultSet rs=null;		
		HashMap hshValues = new HashMap();
		ArrayList vecVal = new ArrayList();
		ArrayList vecVal1 = new ArrayList();
		ArrayList vecRec= new ArrayList();
		ArrayList vecRec1= new ArrayList();
		String appno="";
		try
		{
			appno=(String)hsh.get("appno");
			rs=DBUtils.executeLAPSQuery("combankingselection^"+appno);
			while(rs.next())
			{
				vecRec = new ArrayList();
				vecRec1 = new ArrayList();
				if (rs.getString(10).trim().equalsIgnoreCase("W"))
				{
					vecRec.add(correctNull(rs.getString(1)));
					vecRec.add(correctNull(rs.getString(2)));
					vecRec.add(correctNull(rs.getString(3)));
					vecRec.add(correctNull(rs.getString(4)));
					vecRec.add(correctNull(rs.getString(5)));
					vecRec.add(correctNull(rs.getString(6)));
					vecRec.add(correctNull(rs.getString(7)));
					vecRec.add(correctNull(rs.getString(8)));
					vecRec.add(correctNull(rs.getString(9)));
					vecRec.add(correctNull(rs.getString(10)));
					vecVal.add(vecRec);
				}			
				if (rs.getString(10).trim().equalsIgnoreCase("T"))
				{
					vecRec1.add(correctNull(rs.getString(1)));
					vecRec1.add(correctNull(rs.getString(2)));
					vecRec1.add(correctNull(rs.getString(3)));
					vecRec1.add(correctNull(rs.getString(4)));
					vecRec1.add(correctNull(rs.getString(5)));
					vecRec1.add(correctNull(rs.getString(6)));
					vecRec1.add(correctNull(rs.getString(7)));
					vecRec1.add(correctNull(rs.getString(8)));
					vecRec1.add(correctNull(rs.getString(9)));
					vecRec1.add(correctNull(rs.getString(10)));
					vecVal1.add(vecRec1);
				}	
			}
			hshValues.put("vecVal",vecVal);
			hshValues.put("vecVal1",vecVal1);
		}		
		catch (Exception e)
		{
			throw new EJBException("Error Occured"+e.getMessage());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				throw new EJBException("Error Occured  "+e1.getMessage());
			}
		}
		return hshValues;
	}
	
	public HashMap getInfoData(HashMap hsh) 
	{
		ResultSet rs=null;
		HashMap hshValues = new HashMap();
		ArrayList vecVal = new ArrayList();
		ArrayList vecVal1 = new ArrayList();
		ArrayList vecRec= new ArrayList();
		ArrayList vecRec1= new ArrayList();
		String appno="";
		String recordflag="N";
		try
		{
			appno=(String)hsh.get("appno");
			rs=DBUtils.executeLAPSQuery("cominfosel^"+appno);
			while(rs.next())
			{
				vecRec = new ArrayList();
				vecRec1 = new ArrayList();
				if (correctNull(rs.getString(3)).trim().equalsIgnoreCase("guarantee"))
				{
					vecRec.add(correctNull(rs.getString(1)));
					vecRec.add(correctNull(rs.getString(2)));
					vecRec.add(correctNull(rs.getString(3)));
					vecRec.add(correctNull(rs.getString(4)));
					vecRec.add(correctNull(rs.getString(5)));
					vecVal.add(vecRec);
				}					
				else
				{
					vecRec1.add(correctNull(rs.getString(1)));
					vecRec1.add(correctNull(rs.getString(2)));
					vecRec1.add(correctNull(rs.getString(3)));
					vecRec1.add(correctNull(rs.getString(4)));
					vecRec1.add(correctNull(rs.getString(5)));					
					vecVal1.add(vecRec1);
					
				}
				recordflag="Y";
			}
			if(rs != null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("cominfoselection^"+appno);
			while(rs.next())
			{
				hshValues.put("Details of suit",correctNull(rs.getString(3)).trim());
			}
			hshValues.put("recordflag",recordflag);
			hshValues.put("vecVal",vecVal);
			hshValues.put("vecVal1",vecVal1);				
		}		
		catch (Exception e)
		{
			throw new EJBException("Error Occured"+e.getMessage());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				throw new EJBException("Error Occured"+e1.getMessage());
			}
		}
		return hshValues;
	}

	public HashMap getSegmentData(HashMap hsh) 
	{
		ResultSet rs=null;		
		HashMap hshValues = new HashMap();
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec= new ArrayList();
		String appno="";
		try
		{
			appno=correctNull((String)hsh.get("appno"));
			rs=DBUtils.executeLAPSQuery("comsegmentselection^"+appno+"^"+appno);
			while(rs.next())
			{
				vecRec = new ArrayList();				
				vecRec.add(correctNull(rs.getString(1)));
				vecRec.add(correctNull(rs.getString(2)));
				vecRec.add(correctNull(rs.getString(3)));
				vecRec.add(correctNull(rs.getString(4)));
				vecRec.add(correctNull(rs.getString(5)));
				vecRec.add(correctNull(rs.getString(6)));				
				vecVal.add(vecRec);
			}
			hshValues.put("vecVal",vecVal);
		}
		
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}

		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				throw new EJBException("Error Occured"+e1.getMessage());
			}
		}
		return hshValues;
	}
	
	public HashMap getRawData(HashMap hsh) 
	{
		ResultSet rs=null;		
		HashMap hshValues = new HashMap();
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec= new ArrayList();
		String appno="";
		String recflag="N";
		try
		{
			appno=correctNull((String)hsh.get("appno"));
			rs=DBUtils.executeLAPSQuery("comrawsel^"+appno);
			while(rs.next())
			{
				vecRec = new ArrayList();				
				vecRec.add(correctNull(rs.getString(1)));
				vecRec.add(correctNull(rs.getString(2)));
				vecRec.add(correctNull(rs.getString(3)));
				vecRec.add(correctNull(rs.getString(4)));
				vecRec.add(correctNull(rs.getString(5)));
				vecRec.add(correctNull(rs.getString(6)));
				vecRec.add(correctNull(rs.getString(7)));
				vecRec.add(correctNull(rs.getString(8)));
				vecRec.add(correctNull(rs.getString(9)));
				vecRec.add(correctNull(rs.getString(10)));
				vecRec.add(correctNull(rs.getString(11)));
				vecRec.add(correctNull(rs.getString(12)));
				vecVal.add(vecRec);
				recflag="Y";
			}
			hshValues.put("vecVal",vecVal);
			hshValues.put("recflag",recflag);
		}		
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				throw new EJBException("Error Occured"+e1.getMessage());
			}
		}
		return hshValues;
	}

	public HashMap getSupplyData(HashMap hsh) 
	{
		String strQuery="";
		ResultSet rs=null;		
		HashMap hshValues = new HashMap();
		ArrayList vecVal = new ArrayList();		
		ArrayList vecRec= new ArrayList();		
		String appno="";
		try
		{
			appno=(String)hsh.get("appno");
			strQuery = SQLParser.getSqlQuery("comsupselection_new^"+appno);

			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecRec = new ArrayList();
				vecRec.add(correctNull(rs.getString(1)));
				vecRec.add(correctNull(rs.getString(2)));
				if(rs.getString(3).equalsIgnoreCase("0"))
				{
					vecRec.add("");
				}
				else
				{
					vecRec.add(correctNull(rs.getString(3)));
				}
				vecRec.add(correctNull(rs.getString(4)));
				vecRec.add(correctNull(rs.getString(5)));				
				if( (Helper.correctNull((String)rs.getString(6)).equalsIgnoreCase("0.00")) || (Helper.correctNull((String)rs.getString(6)).equalsIgnoreCase("")))
				{
					vecRec.add("");
				}
				else
				{
					vecRec.add(correctNull(rs.getString(6)));
				}
				vecRec.add(correctNull(rs.getString(7)));
				vecVal.add(vecRec);
			}
			hshValues.put("vecVal",vecVal);				
		}
		catch (Exception e)
		{
			throw new EJBException("Error Occured"+e.getMessage());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				throw new EJBException("Error Occured"+e1.getMessage());
			}
		}
		return hshValues;
	}



	public HashMap getRepayData(HashMap hsh) 
	{
		String strQuery="";
		ResultSet rs=null;		
		HashMap hshValues = new HashMap();
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec= new ArrayList();
		String appno="";
		try
		{
			appno=(String)hsh.get("appno");
			strQuery = SQLParser.getSqlQuery("comrepaymentselection1^"+appno+"^"+appno+"^"+appno);

			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecRec = new ArrayList();
				vecRec.add(correctNull(rs.getString(1)));
				vecRec.add(correctNull(rs.getString(2)));
				vecRec.add(correctNull(rs.getString(3)));
				vecRec.add(correctNull(rs.getString(4)));
				vecRec.add(correctNull(rs.getString(5)));
				vecRec.add(correctNull(rs.getString(6)));
				vecRec.add(correctNull(rs.getString(7)));
				vecRec.add(correctNull(rs.getString(8)));
				vecVal.add(vecRec);
			}	
			hshValues.put("vecVal",vecVal);			
		}	
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				throw new EJBException("Error Occured"+e1.getMessage());
			}
		}
		return hshValues;
	}
	
	public HashMap getOrgData(HashMap hsh) 
	{
		ResultSet rs=null;
		HashMap hshValues = new HashMap();
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol= new ArrayList();
		String appno="";
		String strQuery="";
		boolean recordflag=false;
		try
		{
			appno=correctNull((String)hsh.get("appno"));
			strQuery=SQLParser.getSqlQuery("comorgsel^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("com_emdid")));
				arrCol.add(correctNull(rs.getString("com_empdesc")));
				arrCol.add(correctNull(rs.getString("com_empresp")));
				arrCol.add(correctNull(rs.getString("com_empworking")));
				arrCol.add(correctNull(rs.getString("com_empexperience")));
				arrCol.add(correctNull(rs.getString("com_empreport")));
				arrRow.add(arrCol);	
				recordflag=true;
			}
			hshValues.put("arrRow",arrRow);
			if(recordflag)
				 hshValues.put("recordflag","Y");
			else
				hshValues.put("recordflag","N");
		}		
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				throw new EJBException("Error Occured"+e1.getMessage());
			}
		}
		return hshValues;
	}
	
	public HashMap getCompData(HashMap hsh) 
	{
		ResultSet rs=null;		
		HashMap hshValues = new HashMap();
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec= new ArrayList();
		String appno="";
		boolean recordflag=false;
		try
		{
			appno=correctNull((String)hsh.get("appno"));
			rs=DBUtils.executeLAPSQuery("comcompsel^"+appno);
			while(rs.next())
			{
				vecRec = new ArrayList();
				vecRec.add(correctNull(rs.getString(1)));
				vecRec.add(correctNull(rs.getString(2)));
				vecRec.add(correctNull(rs.getString(3)));
				vecRec.add(correctNull(rs.getString(4)));
				vecRec.add(correctNull(rs.getString(5)));
				vecRec.add(correctNull(rs.getString(6)));
				vecRec.add(correctNull(rs.getString(7)));				
				vecVal.add(vecRec);
				recordflag=true;
			}
			hshValues.put("vecVal",vecVal);		
			if(recordflag)
				hshValues.put("recordflag","Y");
			else
				hshValues.put("recordflag","N");
			
		}		
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				throw new EJBException("Error Occured"+e1.getMessage());
			}
		}
		return hshValues;
	}

	public void updateOtherDetails(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQry = new HashMap();		
		ArrayList arr = new ArrayList();
		ArrayList arrVal=new ArrayList();
		String val="";
		String appno="";
		
		try
		{
			val=(String)hsh.get("hidAction");
			appno=(String)hsh.get("appno");
			int intUpdatesize=0;
			intUpdatesize=1;
			if (val.equals("delete"))
			{
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery.put("strQueryId","comimportdel");
			arr.add(appno);
			hshquery.put("arrValues",arr);
			hshqueryval.put(Integer.toString(intUpdatesize),hshquery);
			}
			hshqueryval.put("size","1");
			hshQry.put("strQueryId","comimportdel");
			arrVal.add(appno);
			hshQry.put("arrValues",arrVal);
			hshqueryval.put("1",hshQry);
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			hshQry=new HashMap();
			arrVal=new ArrayList();
			if (val.equals("update"))
			{
				//intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry.put("strQueryId","comimporttins");
				arrVal.add(appno);
				arrVal.add("Availability of Imported Raw Material");
				String val1=correctNull((String) hsh.get("availability"));
				if(val1.equalsIgnoreCase(""))
				{
					val1="";
					arrVal.add(val1);
					
				}
				else
				{
				arrVal.add(hsh.get("availability"));
				}
				hshQry.put("arrValues",arrVal);
				hshqueryval.put(Integer.toString(intUpdatesize),hshQry);

				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","comimporttins");
				arrVal.add(appno);
				arrVal.add("Reasons for Importing");
				String val2=correctNull((String) hsh.get("reasons"));
				if(val2.equalsIgnoreCase(""))
				{
					val2="";
					arrVal.add(val2);
				}
				else
				{
					arrVal.add(hsh.get("reasons"));
					
				}
				hshQry.put("arrValues",arrVal);
				hshqueryval.put(Integer.toString(intUpdatesize),hshQry);

				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","comimporttins");
				arrVal.add(appno);
				arrVal.add("Inventory");
				String val3=correctNull((String) hsh.get("inventory"));
				if(val3.equalsIgnoreCase(""))
				{
					val3="";
					arrVal.add(val3);
				}
				else
				{
					arrVal.add(hsh.get("inventory"));
					
				}
				
				hshQry.put("arrValues",arrVal);
				hshqueryval.put(Integer.toString(intUpdatesize),hshQry);

				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","comimporttins");
				arrVal.add(appno);
				arrVal.add("Long Term Supply");
				String val4=Helper.correctNull((String)hsh.get("contracts"));
				val4=val4.trim();
				if((val4).equalsIgnoreCase(""))
				{
					val4="";
					arrVal.add(val4);
					
				}
				else
				{
					arrVal.add(hsh.get("contracts"));
					
				}
				
				hshQry.put("arrValues",arrVal);
				hshqueryval.put(Integer.toString(intUpdatesize),hshQry);	
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				
			}	
			arr=new ArrayList();
			hshquery=new HashMap();
			hshqueryval=new HashMap();
			hshqueryval.put("size","1");
			hshquery.put("strQueryId","audittrial");
			arr.add("53");
			arr.add(correctNull((String)hsh.get("strUserId")));
			arr.add(correctNull((String)hsh.get("strClientIP")));
			arr.add(appno);
			String strData="Availability of Imported Raw Material="+hsh.get("availability")+"~Reasons for Importing="+hsh.get("reasons")+"~Inventory="+hsh.get("inventory")+"Long Term Supply="+hsh.get("contracts");
			arr.add(strData);
			if (val.equals("update"))
			{
				arr.add("insert");
			}
			else
			{
				arr.add("delete");
			}
			hshquery.put("arrValues",arr);
			hshqueryval.put("1",hshquery);
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
		}
		finally
		{
			try
			{
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	}

	public void updateDesc(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();		
		HashMap hshQry = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arrVal = new ArrayList();
		String val="";
		String appno="";
		
		try
		{
			val=(String)hsh.get("hidAction");
			appno=(String)hsh.get("appno");
			
			int intUpdatesize=0;
			intUpdatesize=1;				
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery.put("strQueryId","comdescdel");
			arr.add(appno);
			hshquery.put("arrValues",arr);
			hshqueryval.put("1",hshquery);
			
			if (val.equals("update"))
			{
				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry.put("strQueryId","comdescins");
				arrVal.add(appno);
				arrVal.add("Description Production");
				arrVal.add(hsh.get("Description"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("2",hshQry);

				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","comdescins");
				arrVal.add(appno);
				arrVal.add("Production Schedule");
				arrVal.add(hsh.get("Schedule"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("3",hshQry);

				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","comdescins");
				arrVal.add(appno);
				arrVal.add("Output to Input Ratio");
				arrVal.add(hsh.get("Output"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("4",hshQry);

				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","comdescins");
				arrVal.add(appno);
				arrVal.add("Technology used");
				arrVal.add(hsh.get("Technology"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("5",hshQry);
			}	
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			arr=new ArrayList();
			hshquery=new HashMap();
			hshqueryval=new HashMap();
			hshqueryval.put("size","1");
			hshquery.put("strQueryId","audittrial");
			arr.add("55");
			arr.add(correctNull((String)hsh.get("strUserId")));
			arr.add(correctNull((String)hsh.get("strClientIP")));
			arr.add(appno);
			String strData="Description Production="+hsh.get("Description")+"~Production Schedule="+hsh.get("Schedule")+"~Output to Input Ratio="+hsh.get("Output")+"~Technology used"+hsh.get("Technology");
			arr.add(strData);
			if (val.equals("update"))
			{
				arr.add("insert");
			}
			else
			{
				arr.add("delete");
			}
			hshquery.put("arrValues",arr);
			hshqueryval.put("1",hshquery);
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
		}
		catch (Exception e)
		{
			throw new EJBException("Error Occured"+e.getMessage());
		}
		finally
		{
			try
			{

			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	}

	public void updateMarket(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQry = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arrVal = new ArrayList();
		String val="";
		String appno="";
		
		try
		{
			val=(String)hsh.get("hidAction");
			appno=(String)hsh.get("appno");
			int intUpdatesize=0;
			intUpdatesize=1;			
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery.put("strQueryId","commarketdel");
			arr.add(appno);
			hshquery.put("arrValues",arr);
			hshqueryval.put("1",hshquery);			
			if (val.equals("update"))
			{
				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry.put("strQueryId","commarketins");
				arrVal.add(appno);
				arrVal.add("Distribution setup");
				arrVal.add(hsh.get("distribution"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("2",hshQry);

				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","commarketins");
				arrVal.add(appno);
				arrVal.add("Credit terms");
				arrVal.add(hsh.get("credit"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("3",hshQry);

				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","commarketins");
				arrVal.add(appno);
				arrVal.add("Details of new initiatives");
				arrVal.add(hsh.get("initiatives"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("4",hshQry);
			}	
				
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");

			arr=new ArrayList();
			hshquery=new HashMap();
			hshqueryval=new HashMap();
			hshqueryval.put("size","1");
			hshquery.put("strQueryId","audittrial");
			arr.add("60");
			arr.add(correctNull((String)hsh.get("strUserId")));
			arr.add(correctNull((String)hsh.get("strClientIP")));
			arr.add(appno);
			String strData="Distribution setup="+hsh.get("distribution")+"~Credit terms="+hsh.get("credit")+"~Details of new initiatives="+hsh.get("initiatives");
			arr.add(strData);
			if (val.equals("update"))
			{
				arr.add("insert");
			}
			else
			{
				arr.add("delete");
			}
			hshquery.put("arrValues",arr);
			hshqueryval.put("1",hshquery);;
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
		}	
		finally
		{
			try
			{
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}		
	}

	public void updateGovt(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();		
		HashMap hshQry = new HashMap();	
		ArrayList arr = new ArrayList();
		ArrayList arrVal = new ArrayList();
		String val="";
		String appno="";
		
		try
		{				
			val=(String)hsh.get("hidAction");
			appno=(String)hsh.get("appno");
			int intUpdatesize=0;
			intUpdatesize=1;			
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery.put("strQueryId","comgovtdel");
			arr.add(appno);
			hshquery.put("arrValues",arr);
			hshqueryval.put("1",hshquery);
			
			if (val.equals("update"))
			{
				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry.put("strQueryId","comgovtins");
				arrVal.add(appno);
				arrVal.add("Government Policy");
				arrVal.add(hsh.get("policy"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("2",hshQry);

				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","comgovtins");
				arrVal.add(appno);
				arrVal.add("Applicable Regulation");
				arrVal.add(hsh.get("regulation"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("3",hshQry);
			}	
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			arr=new ArrayList();
			hshquery=new HashMap();
			hshqueryval=new HashMap();
			hshqueryval.put("size","1");
			hshquery.put("strQueryId","audittrial");
			arr.add("57");
			arr.add(correctNull((String)hsh.get("strUserId")));
			arr.add(correctNull((String)hsh.get("strClientIP")));
			arr.add(appno);
			String strData="Government Policy="+hsh.get("policy")+"~Applicable Regulation="+hsh.get("regulation");
			arr.add(strData);
			if (val.equals("update"))
			{
				arr.add("insert");
			}
			else
			{
				arr.add("delete");
			}
			hshquery.put("arrValues",arr);
			hshqueryval.put("1",hshquery);
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");			
		}
		catch (Exception e)
		{
			throw new EJBException("Error Occured"+e.getMessage());
		}
		finally
		{
			try
			{
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}		
	}

	public void updateStd(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQry = new HashMap();		
		ArrayList arr = new ArrayList();
		ArrayList arrVal = new ArrayList();
		String val="";
		String appno="";
		
		try
		{	
			val=(String)hsh.get("hidAction");
			appno=(String)hsh.get("appno");
			int intUpdatesize=0;
			intUpdatesize=1;
			
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery.put("strQueryId","comstddel");
			arr.add(appno);
			hshquery.put("arrValues",arr);
			hshqueryval.put("1",hshquery);
			
			if (val.equals("update"))
			{
				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry.put("strQueryId","comstdins");
				arrVal.add(appno);
				arrVal.add("Source of Technology");
				arrVal.add(hsh.get("source"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("2",hshQry);

				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","comstdins");
				arrVal.add(appno);
				arrVal.add("Technical Collaborations");
				arrVal.add(hsh.get("collaborations"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("3",hshQry);

				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","comstdins");
				arrVal.add(appno);
				arrVal.add("Advanced Technology");
				arrVal.add(hsh.get("advanced"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("4",hshQry);

				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","comstdins");
				arrVal.add(appno);
				arrVal.add("Inhouse Research");
				arrVal.add(hsh.get("inhouse"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("5",hshQry);
			
				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","comstdins");
				arrVal.add(appno);
				arrVal.add("International Standards");
				arrVal.add(hsh.get("standards"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("6",hshQry);

				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","comstdins");
				arrVal.add(appno);
				arrVal.add("Details of Awards");
				arrVal.add(hsh.get("awards"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("7",hshQry);
			}	
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			arr=new ArrayList();
			hshquery=new HashMap();
			hshqueryval=new HashMap();
			hshqueryval.put("size","1");
			hshquery.put("strQueryId","audittrial");
			arr.add("56");
			arr.add(correctNull((String)hsh.get("strUserId")));
			arr.add(correctNull((String)hsh.get("strClientIP")));
			arr.add(appno);
			String strData="Source of Technology="+hsh.get("source")+"~Technical Collaborations="+hsh.get("collaborations")+"~Advanced Technology="+hsh.get("advanced")+"~Inhouse Research="+hsh.get("inhouse")+"~International Standards="+hsh.get("standards")+"~Details of Awards="+hsh.get("awards");
			arr.add(strData);
			if (val.equals("update"))
			{
				arr.add("insert");
			}
			else
			{
				arr.add("delete");
			}
			hshquery.put("arrValues",arr);
			hshqueryval.put("1",hshquery);
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");			
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
		}		
		finally
		{
			try
			{

			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	}

	public void updateEmp(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQry = new HashMap();		
		ArrayList arr = new ArrayList();
		ArrayList arrVal = new ArrayList();
		String val="";
		String appno="";
		
		try
		{
			val=(String)hsh.get("hidAction");
			appno=(String)hsh.get("appno");
			int intUpdatesize=0;
			intUpdatesize=1;
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery.put("strQueryId","comempdel");
			arr.add(appno);
			hshquery.put("arrValues",arr);
			hshqueryval.put("1",hshquery);				
			if (val.equals("update"))
			{
				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry.put("strQueryId","comempins");
				arrVal.add(appno);
				arrVal.add("Succession plan");
				arrVal.add(hsh.get("succession"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("2",hshQry);

				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","comempins");
				arrVal.add(appno);
				arrVal.add("Strategic initiatives");
				arrVal.add(hsh.get("strategic"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("3",hshQry);

				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","comempins");
				arrVal.add(appno);
				arrVal.add("Skilled");
				arrVal.add(hsh.get("skilled"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("4",hshQry);

				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","comempins");
				arrVal.add(appno);
				arrVal.add("Unskilled");
				arrVal.add(hsh.get("unskilled"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("5",hshQry);
			
				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","comempins");
				arrVal.add(appno);
				arrVal.add("Employee welfare");
				arrVal.add(hsh.get("welfare"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("6",hshQry);

				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","comempins");
				arrVal.add(appno);
				arrVal.add("Any strike");
				arrVal.add(hsh.get("strike"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("7",hshQry);

				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","comempins");
				arrVal.add(appno);
				arrVal.add("Comments");
				arrVal.add(hsh.get("turnover"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("8",hshQry);
			}	
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			intUpdatesize=1;
			arr=new ArrayList();
			hshquery=new HashMap();
			hshqueryval=new HashMap();
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery.put("strQueryId","audittrial");
			arr.add("65");
			arr.add(correctNull((String)hsh.get("strUserId")));
			arr.add(correctNull((String)hsh.get("strClientIP")));
			arr.add(appno);
			String strData="Succession plan="+hsh.get("succession")+"~Strategic initiatives="+hsh.get("strategic")+"~Skilled="+hsh.get("skilled")+"~Unskilled="+hsh.get("unskilled")+"~Employee welfare="+hsh.get("welfare")+"~Any strike="+hsh.get("strike")+"~Comments="+hsh.get("turnover");
			arr.add(strData);
			if (val.equals("update"))
			{
				arr.add("insert");
			}
			else
			{
				arr.add("delete");
			}
			hshquery.put("arrValues",arr);
			hshqueryval.put("1",hshquery);
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");			
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
		}		
		finally
		{
			try
			{

			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	}

	public void updateMis(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQry = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arrVal = new ArrayList();
		String val="";
		String appno="";
		
		try
		{				
			val=(String)hsh.get("hidAction");
			appno=(String)hsh.get("appno");
			int intUpdatesize=0;
			intUpdatesize=1;
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery.put("strQueryId","commisdel");
			arr.add(appno);
			hshquery.put("arrValues",arr);
			hshqueryval.put("1",hshquery);
			
			if (val.equals("update"))
			{
				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry.put("strQueryId","commisins");
				arrVal.add(appno);
				arrVal.add("Initiative of the Mgmt on QC");
				arrVal.add(hsh.get("quality"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("2",hshQry);

				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","commisins");
				arrVal.add(appno);
				arrVal.add("Reporting Control");
				arrVal.add(hsh.get("report"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("3",hshQry);

				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","commisins");
				arrVal.add(appno);
				arrVal.add("Project Implementation");
				arrVal.add(hsh.get("project"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("4",hshQry);
			}	
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");

			arr=new ArrayList();
			hshquery=new HashMap();
			hshqueryval=new HashMap();
			hshqueryval.put("size","1");
			hshquery.put("strQueryId","audittrial");
			arr.add("66");
			arr.add(correctNull((String)hsh.get("strUserId")));
			arr.add(correctNull((String)hsh.get("strClientIP")));
			arr.add(appno);
			String strData="Initiative of the Mgmt on QC="+hsh.get("quality")+"~Reporting Control="+hsh.get("report")+"~Project Implementation="+hsh.get("project");
			arr.add(strData);
			if (val.equals("update"))
			{
				arr.add("insert");
			}
			else
			{
				arr.add("delete");
			}
			hshquery.put("arrValues",arr);
			hshqueryval.put("1",hshquery);
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");			
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
		}		
		finally
		{
			try
			{
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	}

	public void updateTrans(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQry = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arrVal = new ArrayList();
		String val="";
		String appno="";
		
		try
		{				
			val=(String)hsh.get("hidAction");
			appno=(String)hsh.get("appno");
			int intUpdatesize=0;
			intUpdatesize=1;			
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery.put("strQueryId","comtransdel");
			arr.add(appno);
			hshquery.put("arrValues",arr);
			hshqueryval.put("1",hshquery);			
			if (val.equals("update"))
			{
				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry.put("strQueryId","comtransins");
				arrVal.add(appno);
				arrVal.add("Transportation modes");
				arrVal.add(hsh.get("mode"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("2",hshQry);
				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","comtransins");
				arrVal.add(appno);
				arrVal.add("Ancillary facilities");
				arrVal.add(hsh.get("ancillary"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("3",hshQry);

				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","comtransins");
				arrVal.add(appno);
				arrVal.add("Fleet strength");
				arrVal.add(hsh.get("rawfleet"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("4",hshQry);

				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","comtransins");
				arrVal.add(appno);
				arrVal.add("Longterm transport");
				arrVal.add(hsh.get("rawlong"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("5",hshQry);
			
				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","comtransins");
				arrVal.add(appno);
				arrVal.add("Finished Goods Fleet Strength");
				arrVal.add(hsh.get("finishedfleet"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("6",hshQry);

				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry=new HashMap();
				arrVal=new ArrayList();
				hshQry.put("strQueryId","comtransins");
				arrVal.add(appno);
				arrVal.add("Finished Goods Longterm transport");
				arrVal.add(hsh.get("finishedlong"));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put("7",hshQry);
			}					
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			arr=new ArrayList();
			hshquery=new HashMap();
			hshqueryval=new HashMap();
			hshqueryval.put("size","1");
			hshquery.put("strQueryId","audittrial");
			arr.add("58");
			arr.add(correctNull((String)hsh.get("strUserId")));
			arr.add(correctNull((String)hsh.get("strClientIP")));
			arr.add(appno);
			String strData="Transportation modes="+hsh.get("mode")+"~Ancillary facilities="+hsh.get("ancillary")+"~Fleet strength="+hsh.get("rawfleet")+"~Longterm transport="+hsh.get("rawlong")+"~Finished Goods Fleet Strength="+hsh.get("finishedfleet")+"~Finished Goods Longterm transport="+hsh.get("finishedlong");
			arr.add(strData);
			if (val.equals("update"))
			{
				arr.add("insert");
			}
			else
			{
				arr.add("delete");
			}
			hshquery.put("arrValues",arr);
			hshqueryval.put("1",hshquery);
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
		}
		finally
		{
			try
			{
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	}

	public HashMap getOtherData(HashMap hsh) 
	{
		ResultSet rs=null;		
		HashMap hshValues = new HashMap();		
		String appno="";
		String recflag="";
		try
		{
			appno=(String)hsh.get("appno");
			rs=DBUtils.executeLAPSQuery("comimportsel^"+appno);
			while(rs.next())
			{												
				if(correctNull(rs.getString(2)).equalsIgnoreCase("Availability of Imported Raw Material"))
				{
					hshValues.put("Availability of Imported Raw Material",correctNull(rs.getString(3)).trim());
				}
				else if (correctNull(rs.getString(2)).equalsIgnoreCase("Reasons for Importing"))
				{
					
					hshValues.put("Reasons for Importing",correctNull(rs.getString(3)).trim());
				}
				else if (correctNull(rs.getString(2)).equalsIgnoreCase("Inventory"))
				{
					
					hshValues.put("Inventory",correctNull(rs.getString(3)).trim());
				}
				else
				{					
					hshValues.put("Long Term Supply",correctNull(rs.getString(3)).trim());
				}	
				recflag="Y";
				
			}
			hshValues.put("recflag",recflag);
		}		
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				log.error("error occured"+e1.toString());
			}
		}
		return hshValues;		
	}

	public HashMap getDescData(HashMap hsh) 
	{
		ResultSet rs=null;
		HashMap hshValues = new HashMap();
		String appno="";
		boolean recordflag=false;
		try
		{
			appno=(String)hsh.get("appno");
			rs=DBUtils.executeLAPSQuery("comdescsel^"+appno);
			while(rs.next())
			{												
				if(correctNull(rs.getString(2)).equalsIgnoreCase("Description Production"))
				{
					hshValues.put("Description Production",correctNull(rs.getString(3)).trim());
				}
				else if (correctNull(rs.getString(2)).equalsIgnoreCase("Production Schedule"))
				{					
					hshValues.put("Production Schedule",correctNull(rs.getString(3)).trim());
				}
				else if (correctNull(rs.getString(2)).equalsIgnoreCase("Output to Input Ratio"))
				{					
					hshValues.put("Output to Input Ratio",correctNull(rs.getString(3)).trim());
				}
				else
				{					
					hshValues.put("Technology used",correctNull(rs.getString(3)).trim());
																	
				}
				recordflag=true;
			}
				if(recordflag)
					hshValues.put("recordflag","Y");
				else
					hshValues.put("recordflag","N");			
		}		
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				log.error("error occured"+e1.toString());
			}
		}
		return hshValues;
	}
	
	public HashMap getMarketData(HashMap hsh) 
	{
		ResultSet rs=null;
		HashMap hshValues = new HashMap();	
		String appno="";
		boolean recordflag=false;
		try
		{
			appno=(String)hsh.get("appno");
			rs=DBUtils.executeLAPSQuery("commarketsel^"+appno);
			while(rs.next())
			{	
				if (rs.getString(2).equalsIgnoreCase("Distribution setup"))
				{					
					hshValues.put("Distribution setup",correctNull(rs.getString(3)).trim());
				}
				else if (rs.getString(2).equalsIgnoreCase("Credit terms"))
				{
					hshValues.put("Credit terms",correctNull(rs.getString(3)).trim());
				}
				else
				{
					hshValues.put("Details of new initiatives",correctNull(rs.getString(3)).trim());
				}
				recordflag=true;
			}
			if(recordflag)
				hshValues.put("recordflag","Y");
			else
				hshValues.put("recordflag","N");
			
		}
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				log.error("error occured"+e1.toString());
			}
		}
		return hshValues;
	}

	public HashMap getGovtData(HashMap hsh) 
	{
		ResultSet rs=null;		
		HashMap hshValues = new HashMap();
		String appno="";
		boolean recordflag=false;
		try
		{
			appno=(String)hsh.get("appno");
			rs=DBUtils.executeLAPSQuery("comgovtsel^"+appno);
			while(rs.next())
			{												
				if(rs.getString(2).equalsIgnoreCase("Government Policy"))
				{
					hshValues.put("Government Policy",correctNull(rs.getString(3)).trim());
				}				
				else
				{					
					hshValues.put("Applicable Regulation",correctNull(rs.getString(3)).trim());
				}
				recordflag=true;
			}		
			if(recordflag)
				hshValues.put("recordflag","Y");
			else
				hshValues.put("recordflag","N");	
		}
		
		
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				log.error("error occured"+e1.toString());
			}
		}
		return hshValues;
	}

	public HashMap getStdData(HashMap hsh) 
	{
		ResultSet rs=null;		
		HashMap hshValues = new HashMap();		
		String appno="";
		try
		{
			appno=(String)hsh.get("appno");
			rs=DBUtils.executeLAPSQuery("comstdsel^"+appno);
			while(rs.next())
			{								
				if(rs.getString(2).equalsIgnoreCase("Source of Technology"))
				{
					hshValues.put("Source of Technology",correctNull(rs.getString(3)).trim());
				}
				else if (rs.getString(2).equalsIgnoreCase("Technical Collaborations"))
				{
					hshValues.put("Technical Collaborations",correctNull(rs.getString(3)).trim());
				}
				else if (rs.getString(2).equalsIgnoreCase("Advanced Technology"))
				{
					hshValues.put("Advanced Technology",correctNull(rs.getString(3)).trim());
				}
				else if (rs.getString(2).equalsIgnoreCase("Inhouse Research"))
				{					
					hshValues.put("Inhouse Research",correctNull(rs.getString(3)).trim());
				}
				else if (rs.getString(2).equalsIgnoreCase("International Standards"))
				{					
					hshValues.put("International Standards",correctNull(rs.getString(3)).trim());
				}
				else
				{
					hshValues.put("Details of Awards",correctNull(rs.getString(3)).trim());
				}					
			}				
		}		
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				log.error("error occured"+e1.toString());
			}
		}
		return hshValues;
	}

	public HashMap getEmpData(HashMap hsh) 
	{
		ResultSet rs=null;		
		HashMap hshValues = new HashMap();		
		String appno="";
		boolean recordflag=false;
		try
		{
			appno=(String)hsh.get("appno");
			rs=DBUtils.executeLAPSQuery("comempsel^"+appno);
			while(rs.next())
			{												
				if(correctNull(rs.getString(2)).trim().equalsIgnoreCase("Succession plan"))
				{
					hshValues.put("Succession plan",correctNull(rs.getString(3)).trim());
				}
				else if (correctNull(rs.getString(2)).trim().equalsIgnoreCase("Strategic initiatives"))
				{					
					hshValues.put("Strategic initiatives",correctNull(rs.getString(3)).trim());
				}
				else if (correctNull(rs.getString(2)).trim().equalsIgnoreCase("Skilled"))
				{					
					hshValues.put("Skilled",correctNull(rs.getString(3)).trim());
				}
				else if (correctNull(rs.getString(2)).trim().equalsIgnoreCase("Unskilled"))
				{					
					hshValues.put("Unskilled",correctNull(rs.getString(3)).trim());
				}
				else if (correctNull(rs.getString(2)).trim().equalsIgnoreCase("Employee welfare"))
				{					
					hshValues.put("Employee welfare",correctNull(rs.getString(3)).trim());
				}
				else if (correctNull(rs.getString(2)).trim().equalsIgnoreCase("Any strike"))
				{					
					hshValues.put("Any strike",correctNull(rs.getString(3)).trim());
				}
				else
				{					
					hshValues.put("Comments",correctNull(rs.getString(3)).trim());
				}	
				recordflag=true;
			}
			if(recordflag)
				hshValues.put("recordflag","Y");
			else
				hshValues.put("recordflag","N");
			
		}		
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				log.error("error occured"+e1.toString());
			}
		}
		return hshValues;
	}

	public HashMap getMisData(HashMap hsh) 
	{
		ResultSet rs=null;
		HashMap hshValues = new HashMap();	
		String appno="";
		boolean recordflag=false;
		String strQuery="";
		try
		{
			appno=(String)hsh.get("appno");
			strQuery=SQLParser.getSqlQuery("commissel^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{												
				if(correctNull(rs.getString(2)).trim().equalsIgnoreCase("Initiative of the Mgmt on QC"))
				{
					hshValues.put("Initiative of the Mgmt on QC",correctNull(rs.getString(3)).trim());
				}
				else if (correctNull(rs.getString(2)).trim().equalsIgnoreCase("Reporting Control"))
				{					
					hshValues.put("Reporting Control",correctNull(rs.getString(3)).trim());
				}			
				else
				{		
					hshValues.put("Project Implementation",correctNull(rs.getString(3)).trim());
				}					
				recordflag=true;
			}
			if(recordflag)
				hshValues.put("recordflag","Y");
			else
				hshValues.put("recordflag","N");
							
		}		
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				log.error("error occured"+e1.toString());
			}
		}
		return hshValues;
	}

	public HashMap getTransData(HashMap hsh) 
	{
		ResultSet rs=null;		
		HashMap hshValues = new HashMap();	
		String appno="";
		boolean recordflag=false;
		try
		{
			appno=(String)hsh.get("appno");
			rs=DBUtils.executeLAPSQuery("comtranssel^"+appno);
			while(rs.next())
			{								
				if(correctNull(rs.getString(2)).trim().equalsIgnoreCase("Transportation modes"))
				{
					hshValues.put("Transportation modes",correctNull(rs.getString(3)).trim());
				}
				else if (correctNull(rs.getString(2)).trim().equalsIgnoreCase("Ancillary facilities"))
				{
					hshValues.put("Ancillary facilities",correctNull(rs.getString(3)).trim());
				}
				else if (correctNull(rs.getString(2)).trim().equalsIgnoreCase("Fleet strength"))
				{
					hshValues.put("Fleet strength",correctNull(rs.getString(3)).trim());
				}
				else if (correctNull(rs.getString(2)).trim().equalsIgnoreCase("Longterm transport"))
				{
					hshValues.put("Longterm transport",correctNull(rs.getString(3)).trim());
				}
				else if (correctNull(rs.getString(2)).trim().equalsIgnoreCase("Finished Goods Fleet Strength"))
				{
					hshValues.put("Finished Goods Fleet Strength",correctNull(rs.getString(3)).trim());
				}
				else
				{
					hshValues.put("Finished Goods Longterm transport",correctNull(rs.getString(3)).trim());
				}	
				recordflag=true;
			}
			if(recordflag)
				hshValues.put("recordflag","Y");
			else
				hshValues.put("recordflag","N");
			
		}		
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				log.error("error occured"+e1.toString());
			}
		}
		return hshValues;
	}
	
	public HashMap getProductData(HashMap hsh) 
	{
		ResultSet rs=null;		
		HashMap hshValues = new HashMap();
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec= new ArrayList();
		String appno="";
		boolean recordflag=false;
		
		try
		{
			appno=correctNull((String)hsh.get("appno"));
			rs=DBUtils.executeLAPSQuery("comproductsel^"+appno);
			while(rs.next())
			{
				vecRec = new ArrayList();						
				vecRec.add(correctNull(rs.getString(1)));
				vecRec.add(correctNull(rs.getString(2)));
				vecRec.add(correctNull(rs.getString("com_prddesc")));
				vecRec.add(correctNull(rs.getString("com_prdunits")));
				vecRec.add(correctNull(rs.getString("com_prdlicencedcapacity")));
				vecRec.add(correctNull(rs.getString("com_prdactualcapacity")));
				vecRec.add(correctNull(rs.getString("com_prdinstalledcapacity")));
				vecRec.add(correctNull(rs.getString("com_prduses")));
			 	vecRec.add(correctNull(rs.getString("com_prdprevlicencedcap")));
				vecRec.add(correctNull(rs.getString("com_prdinstalledcap")));
				vecRec.add(correctNull(rs.getString("com_prdprevactualcap")));
				vecVal.add(vecRec);	
				hshValues.put("com_remarks",Helper.correctNull(rs.getString("com_remarks")));
				recordflag=true;
			}
			hshValues.put("vecVal",vecVal);
			if(recordflag)
				hshValues.put("recordflag","Y");
			else
				hshValues.put("recordflag","N");
		}		
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				log.error("error occured"+e1.toString());
			}
		}
		return hshValues;
	}

	public HashMap getProcessData(HashMap hsh) 
	{
		ResultSet rs=null;		
		HashMap hshValues = new HashMap();
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec= new ArrayList();
		String appno="";
		try
		{
			appno=(String)hsh.get("appno");
			rs=DBUtils.executeLAPSQuery("comprocesssel^"+appno);
			while(rs.next())
			{
				vecRec = new ArrayList();				
				vecRec.add(correctNull(rs.getString(1)));
				vecRec.add(correctNull(rs.getString(2)));
				vecRec.add(correctNull(rs.getString(3)));
				vecRec.add(correctNull(rs.getString(4)));
				vecRec.add(correctNull(rs.getString(5)));
				vecRec.add(correctNull(rs.getString(6)));
				vecRec.add(correctNull(rs.getString(7)));
				vecRec.add(correctNull(rs.getString(8)));
				vecRec.add(correctNull(rs.getString(9)));
				vecRec.add(correctNull(rs.getString(10)));
				vecVal.add(vecRec);
			}
			hshValues.put("vecVal",vecVal);
		}
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				log.error("error occured"+e1.toString());
			}
		}
		return hshValues;
	}

	public void updateinsData(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshQuery ;	
		ArrayList arr = new ArrayList();
		ArrayList arrValues ;
		String val="";
		String appno="";
		
		try
		{
			val=(String)hsh.get("hidAction");
			appno=(String)hsh.get("appno");				
			String []loan=null;
			String []repay = null;
			String []from = null;
			String []to = null;
			String []details = null;
			String []schedule = null;
			int intUpdatesize=0;
			intUpdatesize=1;
			hshQuery = new HashMap();
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshQuery.put("strQueryId","comrepaymentdel");
			arr.add(appno);
			hshQuery.put("arrValues",arr);
			hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
			if (val.equals("update"))
			{
				loan= (String [])hsh.get("loan");
				repay= (String [])hsh.get("repay");
				from = (String [])hsh.get("from");
				to = (String [])hsh.get("to");
				schedule = (String [])hsh.get("sel_reschedule");
				details=(String [])hsh.get("details");
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				
				int len=loan.length;
                 for(int k=0;k<len;k++)
	       {				
					if(!loan[k].trim().equals(""))
					{
						hshQuery = new HashMap();
				    	arrValues=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","comrepaymentins");
						arrValues.add(appno);
						arrValues.add(correctNull(loan[k]));
						arrValues.add(correctNull(repay[k]));
						arrValues.add(correctNull(from[k]));
						arrValues.add(correctNull(to[k]));
						arrValues.add(correctNull(schedule[k]));
						arrValues.add(correctNull(details[k]));
						hshQuery.put("arrValues",arrValues);
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
						log.info("hshQuery =========>"+hshQuery);
					}
				}
				
			}
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
		}
		finally
		{
			try
			{
			
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	}


	public void updateOrg(HashMap hsh) 
	{
		HashMap hshQueryVal = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();		
		ResultSet rs=null;
		String strValue = "";
		String strAppno="";
		String strAction="";
		String strQuery="";
		StringBuilder sbolddata=new StringBuilder();
		try
		{
			StringBuilder sbAt = new StringBuilder();
			strAction=correctNull((String)hsh.get("hidAction"));
			strAppno=correctNull((String)hsh.get("appno"));					
			int intUpdatesize=0;
			
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				strValue=correctNull((String)hsh.get("hidsno"));
				strQuery=SQLParser.getSqlQuery("comorgsel1^"+strAppno+"^"+strValue);
				rs=DBUtils.executeQuery(strQuery);	
				if(rs.next())
				{
					sbolddata.append("~Management Personal Name=").append(correctNull(rs.getString("com_empdesc"))).append(
					"~Functions, responsibilities =").append(correctNull(rs.getString("com_empresp"))).append(
					"~Working Since=").append(correctNull(rs.getString("com_empworking"))).append(
				    "~Experience in Years=").append(correctNull(rs.getString("com_empexperience"))).append(
				    "~Reporting to=").append(correctNull(rs.getString("com_empreport")));	
				}
			}
			if(strAction.equalsIgnoreCase("insert"))
			{
				intUpdatesize++;
				hshQueryVal = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","comorgins");
				
				strQuery=SQLParser.getSqlQuery("comorgmax^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strValue = correctNull(rs.getString(1));				
				}
				arrValues.add(strAppno);
				arrValues.add(strValue);
				arrValues.add(correctNull((String)hsh.get("technical")));
				arrValues.add(correctNull((String)hsh.get("functions")));
				arrValues.add(correctNull((String)hsh.get("working")));
				arrValues.add(correctNull((String)hsh.get("experience")));
				arrValues.add(correctNull((String)hsh.get("reporting")));
				
				hshQuery.put("arrValues",arrValues);						
				hshQueryVal.put("size",Integer.toString(intUpdatesize));
				hshQueryVal.put(Integer.toString(intUpdatesize),hshQuery);	
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				intUpdatesize++;
				hshQueryVal = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","comorgupd");
				strValue=correctNull((String)hsh.get("hidsno"));
				
				arrValues.add(correctNull((String)hsh.get("technical")));
				arrValues.add(correctNull((String)hsh.get("functions")));
				arrValues.add(correctNull((String)hsh.get("working")));
				arrValues.add(correctNull((String)hsh.get("experience")));
				arrValues.add(correctNull((String)hsh.get("reporting")));
				arrValues.add(strValue);
				arrValues.add(strAppno);
				
				hshQuery.put("arrValues",arrValues);						
				hshQueryVal.put("size",Integer.toString(intUpdatesize));
				hshQueryVal.put(Integer.toString(intUpdatesize),hshQuery);
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				intUpdatesize++;
				hshQueryVal = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","comorgdel");
				strValue=correctNull((String)hsh.get("hidsno"));
				
				arrValues.add(strValue);
				arrValues.add(strAppno);
				
				hshQuery.put("arrValues",arrValues);						
				hshQueryVal.put("size",Integer.toString(intUpdatesize));
				hshQueryVal.put(Integer.toString(intUpdatesize),hshQuery);
			}
			if(!strAction.equalsIgnoreCase("delete")){
			//----------------------------AuditTrial-----------------------------
			sbAt.append("~Management Personal Name=").append(correctNull((String)hsh.get("technical"))).append(
				"~Functions, responsibilities =").append(correctNull((String)hsh.get("functions"))).append(
				"~Working Since=").append(correctNull((String)hsh.get("working"))).append(
			    "~Experience in Years=").append(correctNull((String)hsh.get("experience"))).append(
			    "~Reporting to=").append(correctNull((String)hsh.get("reporting")));
			}
			//--------------------------------End--------------------------------
			EJBInvoker.executeStateLess("dataaccess",hshQueryVal,"updateData");
			AuditTrial.auditNewLog(hsh,"154",strAppno,sbAt.toString(),sbolddata.toString());

		}
		catch (Exception e)
		{
			log.error("in bean"+e);
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

	public void updateComp(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQuery ;		
		ArrayList arr = new ArrayList();
		ArrayList arrValues ;
		ResultSet rs=null;
		ResultSet rs1=null;
		String val="",strActionData="";
		int intValue = 0,intUpdatesize_audit=0;
		String appno="";		
		try
		{				
			val=(String)hsh.get("hidAction");
			appno=(String)hsh.get("appno");				
			String []name=null;
			String []product = null;
			String []turnover = null;
			String []player = null;
			String []marketshare = null;
			int intUpdatesize=0;
			if (val.equals("delete"))
			{
				hshqueryval=new HashMap();	
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshqueryval.put("size","1");
				hshquery.put("strQueryId","comcompdel");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");	
			}
			
			name= (String [])hsh.get("name");
			product= (String [])hsh.get("product");
			turnover = (String [])hsh.get("turnover");
			player = (String [])hsh.get("player");
			marketshare=(String [])hsh.get("marketshare");	
			
			if (val.equals("update"))
			{
				hshqueryval=new HashMap();	
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshquery.put("strQueryId","comcompdel");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				
				rs=DBUtils.executeLAPSQuery("comcompmax");
				while(rs.next())
				{
					intValue = (rs.getInt(1));				
				}
			
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				int len=name.length;
				for(int k=0;k<len;k++)
				{				
					if(!name[k].equals(""))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","comcompins");
						arrValues.add(appno);
						intValue=intValue+1;
						String i=Integer.toString(intValue);
						arrValues.add(i);
						arrValues.add(correctNull(name[k]));
						arrValues.add(correctNull(product[k]));
						arrValues.add(Helper.correctDouble((String)turnover[k]));
						arrValues.add(correctNull(player[k]));
						arrValues.add(Helper.correctDouble((String)marketshare[k]));
						hshQuery.put("arrValues",arrValues);						
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
					}
				}
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");	
			}
			
			StringBuilder sbAuditTrial=new StringBuilder();
			int len=name.length;
			if(val.equals("update"))
			{
				for(int k=0;k<len;k++)
				{				
					if(!name[k].equals(""))
					{	
						if(k==0)
						{	
							sbAuditTrial.append("S.No  =").append(k+1);
						}
						else
						{
							sbAuditTrial.append("~S.No  =").append(k+1);
						}
						sbAuditTrial.append("~Name of Competitor /s  =").append(correctNull(name[k])).append("~Product =").append(correctNull(product[k]))
						.append("~Turnover =").append(correctNull((String )turnover[k])).append("~Player =").append(correctNull(player[k]))
						.append("~Marketshare (%) =").append(correctNull(marketshare[k]));
					}
				}
			}
			if(correctNull((String)hsh.get("hidRecordflag")).equals("Y"))
				hsh.put("hidAction", "update");
			else if(correctNull((String)hsh.get("hidRecordflag")).equals("N"))
				hsh.put("hidAction", "insert");
			
			AuditTrial.auditLog(hsh,"153",appno,sbAuditTrial.toString());
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
		}
		finally
		{
			try
			{				
				if(rs != null)
				{
					rs.close();
				}
				if(rs1 != null)
				{
					rs1.close();
				}
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	}

	public void updateProcess(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQuery ;		
		ArrayList arr = new ArrayList();
		ArrayList arrValues ;
		ResultSet rs=null;
		String val="";
		int intValue = 0;
		String appno="";
		
		try
		{
			val=(String)hsh.get("hidAction");
			appno=(String)hsh.get("appno");
				
			String []production=null;
			String []unit = null;
			String []insyear1 = null;
			String []insyear2 = null;
			String []insyear3 = null;
			String []utiyear1 = null;
			String []utiyear2 = null;
			String []utiyear3 = null;
			
			int intUpdatesize=0;
			intUpdatesize=1;
			
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery.put("strQueryId","comprocessdel");
			arr.add(appno);
			hshquery.put("arrValues",arr);
			hshqueryval.put("1",hshquery);

			if (val.equals("update"))
			{
				rs=DBUtils.executeLAPSQuery("comprocessmax");
				while(rs.next())
				{
					intValue = (rs.getInt(1));
				}
				production= (String [])hsh.get("production");
				unit= (String [])hsh.get("unit");
				insyear1 = (String [])hsh.get("insyear1");
				insyear2 = (String [])hsh.get("insyear2");
				insyear3=(String [])hsh.get("insyear3");
				utiyear1 = (String [])hsh.get("utiyear1");
				utiyear2 = (String [])hsh.get("utiyear2");
				utiyear3=(String [])hsh.get("utiyear3");					
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				int len=production.length;
				for(int k=0;k<len;k++)
				{				
					if(!production[k].equals(""))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","comprocessins");
						arrValues.add(appno);
						intValue=intValue+1;
						String i=Integer.toString(intValue);
						arrValues.add(i);
						arrValues.add(correctNull(production[k]));
						arrValues.add(correctNull(unit[k]));
						arrValues.add(Helper.correctDouble((String)insyear1[k]));
						arrValues.add(Helper.correctDouble((String)insyear2[k]));
						arrValues.add(Helper.correctDouble((String)insyear3[k]));
						arrValues.add(Helper.correctDouble((String)utiyear1[k]));
						arrValues.add(Helper.correctDouble((String)utiyear2[k]));
						arrValues.add(Helper.correctDouble((String)utiyear3[k]));
						hshQuery.put("arrValues",arrValues);						
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
					}
				}
			}	
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
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

	public void updateProduct(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQuery ;
		ArrayList arr = new ArrayList();
		ArrayList arrValues ;
		ResultSet rs=null;
		String val="";
		int intValue = 0;
		String appno="";
		try
		{
			val=correctNull((String)hsh.get("hidAction"));
			appno=correctNull((String)hsh.get("appno"));

			String []units=null;	
			String []products=null;
			String []licenced=null;
			String []actual=null;
			String []installed=null;
			String []uses = null;
			String []prevlicenced = null;
			String []prevactual = null;
			String []previnstalled = null;	
			units= (String [])hsh.get("units");
			products= (String [])hsh.get("products");
			licenced= (String [])hsh.get("licenced");
			actual= (String [])hsh.get("actual");
			installed= (String [])hsh.get("installed");
			uses= (String [])hsh.get("uses");
			prevlicenced = (String [])hsh.get("prevlicenced");
			prevactual = (String [])hsh.get("previnstalled");
			previnstalled = (String [])hsh.get("prevactual");
			int intUpdatesize=0;
			
			if (val.equals("update"))
			{
				rs=DBUtils.executeLAPSQuery("comproductmax^"+appno);
				while(rs.next())
				{
					intValue = (rs.getInt(1));
				}
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				int len=products.length;
			
				intUpdatesize=1;			
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshquery.put("strQueryId","comproductdel");
				arr.add(appno);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				
				for(int k=0;k<len;k++)
				{				
					if(!products[k].equals(""))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","comproductins");
						arrValues.add(appno);
						intValue=intValue+1;
						String i=Integer.toString(intValue);
						arrValues.add(i);
						arrValues.add(correctNull(products[k]));
						arrValues.add(correctNull(units[k]));
						arrValues.add(Helper.correctDouble((String)licenced[k]));
						arrValues.add(Helper.correctDouble((String)actual[k]));
						arrValues.add(Helper.correctDouble((String)installed[k]));
						arrValues.add(correctNull(uses[k]));
						arrValues.add(Helper.correctDouble((String)prevlicenced[k]));
						arrValues.add(Helper.correctDouble((String)prevactual[k]));
						arrValues.add(Helper.correctDouble((String)previnstalled[k]));
						arrValues.add(correctNull((String)hsh.get("txt_remarks")));
						hshQuery.put("arrValues",arrValues);						
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
					}
				}				
			}
			else if(val.equals("delete"))
			{
				intUpdatesize=0;			
				hshQuery = new HashMap();
				hshqueryval = new HashMap();
				arr=new ArrayList();
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("strQueryId","comproductdel");
				arr.add(appno);
				hshQuery.put("arrValues",arr);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				arr=new ArrayList();
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("strQueryId","comsegmentdel");
				arr.add(appno);
				hshQuery.put("arrValues",arr);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
			}
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			
			hshqueryval= new HashMap();
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			
			int len=products.length;
			StringBuilder sbAt = new StringBuilder();
			if (val.equalsIgnoreCase("update")) {
				for(int k=0;k<len;k++)
				{				
					if(!products[k].equals(""))
					{
						if(k==0)
						{	
							sbAt.append(" Description of the Product/s=");
						}
						else
						{
							sbAt.append("~Description of the Product/s=");
						}
						sbAt.append(correctNull(products[k]));
						sbAt.append("~ Units=").append(correctNull(units[k]));
						sbAt.append("~ Licensed Capacity Current Year =").append(Helper.correctDouble((String)licenced[k]));
						sbAt.append("~ Licensed Capacity Prev year=").append(Helper.correctDouble((String)prevlicenced[k]));
						sbAt.append("~ Installed Capacity Current Year =").append(Helper.correctDouble((String)installed[k]));
						sbAt.append("~ Installed Capacity Prev year=").append(Helper.correctDouble((String)prevactual[k]));
						sbAt.append("~ Actual Capacity Current Year =").append(Helper.correctDouble((String)actual[k]));
						sbAt.append("~ Actual Capacity Prev year=").append(Helper.correctDouble((String)previnstalled[k]));
					}
				}
			}
			if(correctNull((String)hsh.get("hidRecordflag")).equalsIgnoreCase("Y"))
			{
				hsh.put("hidAction", "update");
			}
			if(correctNull((String)hsh.get("hidRecordflag")).equalsIgnoreCase("N"))
			{
				hsh.put("hidAction", "insert");
			}
			AuditTrial.auditLog(hsh,"148",appno,sbAt.toString());			
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
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

	public void updateLoan(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQry = new HashMap();		
		ArrayList arr = new ArrayList();
		ArrayList arrVal=new ArrayList();
		String val="";
		String appno="";
		try
		{				
			val=(String)hsh.get("hidAction");
			appno=(String)hsh.get("appno");				
			int intUpdatesize=0;
			intUpdatesize=1;
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery.put("strQueryId","comtotaldel");
			arr.add(appno);
			hshquery.put("arrValues",arr);
			hshqueryval.put(Integer.toString(intUpdatesize),hshquery);

			if (val.equals("update"))
			{
				intUpdatesize=intUpdatesize+1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQry.put("strQueryId","comtotalins");
				arrVal.add(appno);
				arrVal.add(Helper.correctDouble((String)hsh.get("wc_fundexist")));
				arrVal.add(Helper.correctDouble((String)hsh.get("wc_fundprop")));
				arrVal.add(Helper.correctDouble((String)hsh.get("wc_nonfundexist")));
				arrVal.add(Helper.correctDouble((String)hsh.get("wc_nonfundprop")));
				hshQry.put("arrValues",arrVal);
				hshqueryval.put(Integer.toString(intUpdatesize),hshQry);
			}
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
		}
		finally
		{
			try
			{
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	}
	
	public HashMap getTotalLoan(HashMap hsh) 
	{
		ResultSet rs=null;		
		HashMap hshValues = new HashMap();
		String appno="";
		try
		{
			appno=(String)hsh.get("appno");
			
			rs=DBUtils.executeLAPSQuery("comtotalsel^"+appno);
			if(rs.next())
			{
									
				hshValues.put("com_totwcfundexist",Helper.correctDouble(rs.getString("com_totwcfundexist")));
				hshValues.put("com_totwcfundprop",Helper.correctDouble(rs.getString("com_totwcfundprop")));
				hshValues.put("com_totwcnonfundexist",Helper.correctDouble(rs.getString("com_totwcnonfundexist")));
				hshValues.put("com_totwcnonfundprop",Helper.correctDouble(rs.getString("com_totwcnonfundprop")));
			}			
		}
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}

		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				log.error("error occured"+e1.toString());
			}
		}
		return hshValues;		
	}
	public HashMap getrangedeviation(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs = null;		
		ResultSet rs1 = null;		
		HashMap hshRecord = new HashMap();
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec= new ArrayList();
		String strFacilityCode="";
		strFacilityCode=Helper.correctNull((String)hshValues.get("fac_id1"));
		if(strFacilityCode.equalsIgnoreCase(""))
		{
			strFacilityCode=Helper.correctNull((String)hshValues.get("facdesc"));
		}
		if(strFacilityCode.equalsIgnoreCase(""))
		{
			strFacilityCode=Helper.correctNull((String)hshValues.get("fac_id"));
		}
		try
		{
				strQuery=SQLParser.getSqlQuery("select_rangedeviation^"+strFacilityCode);
		    	rs = DBUtils.executeQuery(strQuery);
			    while(rs.next())
			    {
					vecRec = new ArrayList();
					
					vecRec.add(correctNull(rs.getString(1)));
					vecRec.add(correctNull(rs.getString(2)));
					vecRec.add(correctNull(rs.getString(3)));
					vecRec.add(correctNull(rs.getString(4)));
					vecRec.add(correctNull(rs.getString(5)));
					vecRec.add(correctNull(rs.getString(6)));
					vecRec.add(correctNull(rs.getString(7)));
					vecRec.add(correctNull(rs.getString(8)));
					vecVal.add(vecRec);
			    }	
				hshRecord.put("vecVal",vecVal);
				if(rs != null){rs.close();}
				strQuery=SQLParser.getSqlQuery("sel_facilitycorp^"+strFacilityCode);
		    	rs = DBUtils.executeQuery(strQuery);
		    	if(rs.next())
			    {
		    		if(correctNull(rs.getString("COM_FACNATURE")).equalsIgnoreCase("1")&&correctNull(rs.getString("COM_FACTYPE")).equalsIgnoreCase("NF"))
		    		{	hshRecord.put("strWCNF","WCNF");		}
			    }
				
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getrangedeviation" + ce.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
				if(rs1 != null)
				{
					rs1.close();
				}
				
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
		return hshRecord;	
	}
	public void updaterangedeviation(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshRecord =new HashMap();
		ArrayList arrValues=new ArrayList();		
		ResultSet rs=null;
		String strQuery="";
		String strfacid=null;
		String 	strorglevel="";
		StringBuilder sbAuditTrial=new StringBuilder();
		StringBuilder sbOldAudit = new StringBuilder();
		String strValue="";
		try
		{
			String [] txt_borec = null;
			String [] txt_borec2 = null;
			String [] txt_dorec = null;
			String [] txt_dorec2 = null;
			String []txt_corec = null;
			String [] txt_corec2 = null;
			String [] usr_class = null;
			String strFacilityCode=Helper.correctNull((String)hshValues.get("fac_id1"));
			String appno=(String)hshValues.get("appno");
			String facname=(String)hshValues.get("facilityname");
			String strOrgCode=(String)hshValues.get("strOrgCode");
			String strAction = correctNull((String)hshValues.get("hidAction"));
			
			
			txt_borec=(String [])hshValues.get("txt_borec");
			txt_borec2=(String [])hshValues.get("txt_borec2");
			txt_dorec=(String [])hshValues.get("txt_dorec");
			txt_dorec2=(String [])hshValues.get("txt_dorec2");
			txt_corec=(String [])hshValues.get("txt_corec");
			txt_corec2=(String [])hshValues.get("txt_corec2");
			usr_class=(String [])hshValues.get("usr_class");
			/***
			 * For Audit Trial Old Data - By Karthikeyan.S on 15/10/2013
			 */
			if(!strFacilityCode.equalsIgnoreCase(""))
			{
				strValue="";
				strQuery=SQLParser.getSqlQuery("select_rangedeviation^"+strFacilityCode);
		    	rs = DBUtils.executeQuery(strQuery);
			    while(rs.next())
			    {
					if(Helper.correctNull((String)rs.getString("set_id")).equalsIgnoreCase("1"))
					{
				    	strValue="~Repayment Period ";
					}
					else if(Helper.correctNull((String)rs.getString("set_id")).equalsIgnoreCase("2"))
					{
						strValue="~Rate of Interest ";
					}
					else if(Helper.correctNull((String)rs.getString("set_id")).equalsIgnoreCase("3"))
					{
						strValue="~Holiday Period ";
					}
					if(Helper.correctNull((String)rs.getString("set_id")).equalsIgnoreCase("4"))
					{
						strValue="~Processing Charges % ";
					}
					else if(Helper.correctNull((String)rs.getString("set_id")).equalsIgnoreCase("5"))
					{
						strValue="~Documentation Charges % ";
					}
					sbOldAudit.append(strValue+"Branch From=").append(Helper.correctInt((String)rs.getString("set_branchfrom")))
					.append(strValue+"Branch To=").append(Helper.correctInt((String)rs.getString("set_branchto")))
					.append(strValue+"Hub From=").append(Helper.correctInt((String)rs.getString("set_dofrom")))
					.append(strValue+"Hub To=").append(Helper.correctInt((String)rs.getString("set_doto")))
					.append(strValue+"RO/HO From=").append(Helper.correctInt((String)rs.getString("set_cofrom")))
					.append(strValue+"RO/HO To=").append(Helper.correctInt((String)rs.getString("set_coto")))
					.append(strValue+"Class Value=").append(Helper.correctNull((String)rs.getString("set_class")));
			    }
			}
			/***
			 * End - Audit Trial New Data
			 */
			if(strAction.equals("update"))
			{

			int intUpdatesize=0;
 			arrValues=new ArrayList();
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();					
			hshQueryValues.put("size","1");	
			arrValues.add(strFacilityCode);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			
			hshQuery.put("strQueryId","delete_rangedeviation");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			hshQueryValues=new HashMap();
			//int len = usr_class.length;
			for(int k=0;k<txt_borec.length;k++)
				{				
					if((!usr_class[k].equalsIgnoreCase("0")) && (!txt_borec[k].equals(""))||(!txt_dorec[k].equals(""))||
							(!txt_corec[k].equals(""))||(!txt_borec2[k].equals(""))||
							(!txt_dorec2[k].equals(""))||(!txt_corec2[k].equals("")))
						{
							String strIteration=String.valueOf((k+1));
							arrValues=new ArrayList();
							hshQuery = new HashMap();
							intUpdatesize=intUpdatesize+1;
							hshQuery.put("strQueryId","insert_rangedeviation");
							arrValues.add(strFacilityCode);
							arrValues.add(String.valueOf((k+1)));
							arrValues.add(Helper.correctInt((String)txt_borec[k]));
							arrValues.add(Helper.correctInt((String)txt_borec2[k]));
							arrValues.add(Helper.correctInt((String)txt_dorec[k]));
							arrValues.add(Helper.correctInt((String)txt_dorec2[k]));
							arrValues.add(Helper.correctInt((String)txt_corec[k]));
							arrValues.add(Helper.correctInt((String)txt_corec2[k]));
							arrValues.add(Helper.correctNull((String)usr_class[k]));
							
							
							hshQuery.put("arrValues",arrValues);
							
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							/***
							 * For Audit Trial New Data - By Karthikeyan.S on 15/10/2013
							 */
							strValue="";
							if(strIteration.equalsIgnoreCase("1"))
							{
						    	strValue="~Repayment Period ";
							}
							else if(strIteration.equalsIgnoreCase("2"))
							{
								strValue="~Rate of Interest ";
							}
							else if(strIteration.equalsIgnoreCase("3"))
							{
								strValue="~Holiday Period ";
							}
							if(strIteration.equalsIgnoreCase("4"))
							{
								strValue="~Processing Charges % ";
							}
							else if(strIteration.equalsIgnoreCase("5"))
							{
								strValue="~Documentation Charges % ";
							}
							sbAuditTrial.append(strValue+"Branch From=").append(Helper.correctInt((String)txt_borec[k]))
							.append(strValue+"Branch To=").append(Helper.correctInt((String)txt_borec2[k]))
							.append(strValue+"Hub From=").append(Helper.correctInt((String)txt_dorec[k]))
							.append(strValue+"Hub To=").append(Helper.correctInt((String)txt_dorec2[k]))
							.append(strValue+"RO/HO From=").append(Helper.correctInt((String)txt_corec[k]))
							.append(strValue+"RO/HO To=").append(Helper.correctInt((String)txt_corec2[k]))
							.append(strValue+"Class Value=").append(Helper.correctInt((String)usr_class[k]));
							/***
							 * End - Audit Trial New Data
							 */
						}
					else
					{
						String strIteration=String.valueOf((k+1));
						arrValues=new ArrayList();
						hshQuery = new HashMap();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","insert_rangedeviation");
						arrValues.add(strFacilityCode);
						arrValues.add(String.valueOf((k+1)));
						arrValues.add("0");
						arrValues.add("0");
						arrValues.add("0");
						arrValues.add("0");
						arrValues.add("0");
						arrValues.add("0");
						arrValues.add("0");
						
						
						hshQuery.put("arrValues",arrValues);
						
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						/***
						 * For Audit Trial New Data - By Karthikeyan.S on 15/10/2013
						 */
						strValue="";
						if(strIteration.equalsIgnoreCase("1"))
						{
					    	strValue="~Repayment Period ";
						}
						else if(strIteration.equalsIgnoreCase("2"))
						{
							strValue="~Rate of Interest ";
						}
						else if(strIteration.equalsIgnoreCase("3"))
						{
							strValue="~Holiday Period ";
						}
						if(strIteration.equalsIgnoreCase("4"))
						{
							strValue="~Processing Charges % ";
						}
						else if(strIteration.equalsIgnoreCase("5"))
						{
							strValue="~Documentation Charges % ";
						}
						sbAuditTrial.append(strValue+"Branch From=").append("0")
						.append(strValue+"Branch To=").append("0")
						.append(strValue+"Hub From=").append("0")
						.append(strValue+"Hub To=").append("0")
						.append(strValue+"RO/HO From=").append("0")
						.append(strValue+"RO/HO To=").append("0")
						.append(strValue+"Class Value=").append("0");
						/***
						 * End - Audit Trial New Data
						 */	
					}
			 	}
			}   
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			AuditTrial.auditNewLog(hshValues,"106",strFacilityCode,sbAuditTrial.toString(),sbOldAudit.toString());
		}
		catch(Exception ce)
		{
			throw new EJBException("inside updaterangedeviation"+ce.toString());
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
			catch(Exception e1)
			{
				throw new EJBException("Error in updaterangedeviation" + e1.toString());
			}
		}
		}
	
	public HashMap getWCFacilitiesData(HashMap hshValues) 
	{	
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arrCol	=new ArrayList();
		ArrayList arrRow	=new ArrayList();
		String strsel_ModType="";
		String strQuery="";
		try
		{
			String strModType	=correctNull((String)hshValues.get("strModType"));
			String strFacType	=correctNull((String)hshValues.get("strFacType")); 
			
			//To get the All Retail Products
			if(strModType.equalsIgnoreCase("r"))
			{
				strQuery=SQLParser.getSqlQuery("sel_allretailproducts"+"^<=");
				rs=DBUtils.executeQuery(strQuery);	
				while(rs.next())
				{
					arrCol=new ArrayList();
					String strProductDesc="";
					strProductDesc	=correctNull((String)rs.getString("category"))+"-"+correctNull((String)rs.getString("subcategory"))+"-"+correctNull((String)rs.getString("prd_desc"));
					String strPrdLoanType=Helper.correctNull((String)rs.getString("prd_loantype"));
					if(strPrdLoanType.equalsIgnoreCase("TL")||strPrdLoanType.equalsIgnoreCase("DL"))
					{
						strPrdLoanType="2";
					}
					else if(strPrdLoanType.equalsIgnoreCase("OD"))
					{
						strPrdLoanType="1";
					}
					arrCol.add(correctNull((String)rs.getString("prdcode")));//0
					arrCol.add(strProductDesc);//1
					arrCol.add(strPrdLoanType);//2
					arrRow.add(arrCol);
				}
				
			}
			else
			{
				//To get the All Corporate Products strModType=C; For WC strFacType=1; For TL strFacType=2 ;
			rs = DBUtils.executeLAPSQuery("sel_Facilities_GC"+"^"+strModType+"^c");
			hshRecord = new HashMap();
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString(1)));
				arrCol.add(correctNull(rs.getString(2)));
				arrCol.add(correctNull(rs.getString(3)));
				arrRow.add(arrCol);	
			}
			
			}
			if(rs!=null)
			{
				rs.close();
				
			}
			hshRecord.put("arrRow",arrRow);				
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getWCFacilitiesData "+ce.toString());
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




