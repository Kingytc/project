package com.sai.laps.ejb.dataaccess;

import java.io.ByteArrayInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.transaction.UserTransaction;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "DataAccessBean", mappedName = "DataAccessHome")
@Remote (DataAccessRemote.class)
public class DataAccessBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	


	static Logger log=Logger.getLogger(DataAccessBean.class);	


	/*public void updateData(HashMap hshValues) 
	{
		Connection con = null;
		PreparedStatement pstmt = null;		
		String strQuery="";
		HashMap hshQuery=null;
		String strQueryId=null;
		String strSize=(String)hshValues.get("size");
		int intSize=Integer.parseInt(strSize);
		ArrayList arrValues=null;
		UserTransaction ut=sc.getUserTransaction();

		try
		{
			ut.begin();
			con = getConnection();
			for(int i=1;i<=intSize;i++)
			{	
				hshQuery=(HashMap)hshValues.get(String.valueOf(i));
				strQueryId=(String)hshQuery.get("strQueryId");
				arrValues=(ArrayList)hshQuery.get("arrValues");
				strQuery = SQLParser.getSqlQuery(strQueryId);
				pstmt = con.prepareStatement(strQuery);
				pstmt.clearParameters();
				for(int j=1;j<=arrValues.size();j++)
				{
					pstmt.setString(j,(String)arrValues.get(j-1));
				}
				pstmt.executeUpdate();
				
				if(pstmt != null)
				{
					pstmt.close();
				}
				if(con != null)
				{
					con.close();
				}
			}
				
			ut.commit();
		}
		catch(Exception ce)
		{
			try
			{
				ut.rollback();
			}
			catch(Exception e1)
			{
				throw new EJBException("Error in rollback  "+e1.getMessage());
			}
			throw new EJBException(ce.getMessage());
		}
		finally
		{
			try
			{
				if(pstmt != null)
				{
					pstmt.close();
				}
				if(con != null)
				{
					con.close();
				}

			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing connection "+cf.getMessage());
			}
		}
	}
	public void updateCBSData(HashMap hshValues) 
	{
		Connection con = null;
		PreparedStatement pstmt = null;		
		String strQuery="";
		HashMap hshQuery=null;
		String strQueryId=null;
		String strSize=(String)hshValues.get("size");
		int intSize=Integer.parseInt(strSize);
		ArrayList arrValues=null;
		UserTransaction ut=sc.getUserTransaction();

		try
		{
			ut.begin();
			con = getCBSConnection();
			for(int i=1;i<=intSize;i++)
			{	
				hshQuery=(HashMap)hshValues.get(String.valueOf(i));
				strQueryId=(String)hshQuery.get("strQueryId");
				arrValues=(ArrayList)hshQuery.get("arrValues");
				strQuery = SQLParser.getCBSSqlQuery(strQueryId);
				pstmt = con.prepareStatement(strQuery);
				pstmt.clearParameters();
				for(int j=1;j<=arrValues.size();j++)
				{
					pstmt.setString(j,(String)arrValues.get(j-1));
				}
				pstmt.executeUpdate();
				
				if(pstmt != null)
				{
					pstmt.close();
				}
				if(con != null)
				{
					con.close();
				}
			}
				
			ut.commit();
		}
		catch(Exception ce)
		{
			try
			{
				ut.rollback();
			}
			catch(Exception e1)
			{
				throw new EJBException("Error in rollback  "+e1.getMessage());
			}
			throw new EJBException(ce.getMessage());
		}
		finally
		{
			try
			{
				if(pstmt != null)
				{
					pstmt.close();
				}
				if(con != null)
				{
					con.close();
				}

			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing connection "+cf.getMessage());
			}
		}
	}*/
	
	public void updateData(HashMap hshValues) throws EJBException
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		Boolean booHO_Check = null;
		Statement stmt = null;
		String strQuery="";
		HashMap hshQuery=null;
		String strQueryId=null;
		String strSize=Helper.correctNull((String)hshValues.get("size"));
		int intSize=Integer.parseInt(strSize);
		ArrayList arrValues=null;
		try
		{
			con = getConnection();
			for(int i=1;i<=intSize;i++)
			{	
				hshQuery=(HashMap)hshValues.get(String.valueOf(i));
				strQueryId=(String)hshQuery.get("strQueryId");
				arrValues=(ArrayList)hshQuery.get("arrValues");
				strQuery = SQLParser.getSqlQuery(strQueryId);
				pstmt = con.prepareStatement(strQuery);
				pstmt.clearParameters();
				int intSize1 = arrValues.size();
			//	String intX_Pos = Integer.toString(arrValues.indexOf("X"));
				for(int j=1;j<=arrValues.size();j++)
				{
					if(arrValues.get(j-1)instanceof byte[])
					{
						byte[] bArr=(byte[])arrValues.get(j-1);
						pstmt.setBinaryStream(j,new ByteArrayInputStream(bArr), bArr.length);
						System.out.println(arrValues.get(j-1));
						
					}
					else
					{
						pstmt.setString(j,(String)arrValues.get(j-1));	
						System.out.println("id :: "+j+" value :: "+arrValues.get(j-1));
					}
					
				}
				/*String strAction = FwHelper.correctNull((String) hshValues.get("Action"));
				String strStatusFlag =  FwHelper.correctNull((String) hshValues.get("Status_flag"));
				if(strStatusFlag.equalsIgnoreCase("S"))
				{
					int intPosition = arrValues.size();
					//intPosition++;
					booHO_Check = checkHOConnection();
					if(booHO_Check == true){
					pstmt.setString(intPosition+1,"Y");}
					else if(booHO_Check == false){
					pstmt.setString(intPosition+1,"N");}
					intPosition=intPosition+2;
					pstmt.setString(intPosition,strAction);
				}*/
				pstmt.executeUpdate();
				System.out.println("TO CHECK1");
			}
		}
		catch(Exception ce)
		{
			ce.printStackTrace();
			try
			{
//				ut.rollback();
			}
			catch(Exception e1)
			{
				e1.printStackTrace();
				System.out.println("exception in rollback");
			}
				System.out.println("TO CHECK"+ce);
				throw new EJBException(ce.getMessage());
		}
		finally
		{
			try
			{
				if(pstmt != null)
				{
					pstmt.close();
				}
				if(con != null)
				{
					con.close();
				}

			}
			catch(Exception cf)
			{
				cf.printStackTrace();
			throw new EJBException("Error closing connection "+cf.getMessage());
			}
		}
}
	public void updateCBSData(HashMap hshValues) throws EJBException
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		Boolean booHO_Check = null;
		Statement stmt = null;
		String strQuery="";
		HashMap hshQuery=null;
		String strQueryId=null;
		String strSize=Helper.correctNull((String)hshValues.get("size"));
		int intSize=Integer.parseInt(strSize);
		ArrayList arrValues=null;
		try
		{
			con = getCBSConnection();
			for(int i=1;i<=intSize;i++)
			{	
				hshQuery=(HashMap)hshValues.get(String.valueOf(i));
				strQueryId=(String)hshQuery.get("strQueryId");
				arrValues=(ArrayList)hshQuery.get("arrValues");
				strQuery = SQLParser.getSqlQuery(strQueryId);
				pstmt = con.prepareStatement(strQuery);
				pstmt.clearParameters();
				int intSize1 = arrValues.size();
			//	String intX_Pos = Integer.toString(arrValues.indexOf("X"));
				for(int j=1;j<=arrValues.size();j++)
				{
					if(arrValues.get(j-1)instanceof byte[])
					{
						byte[] bArr=(byte[])arrValues.get(j-1);
						pstmt.setBinaryStream(j,new ByteArrayInputStream(bArr), bArr.length);
						System.out.println(arrValues.get(j-1));
						
					}
					else
					{
						pstmt.setString(j,(String)arrValues.get(j-1));	
						System.out.println("id :: "+j+" value :: "+arrValues.get(j-1));
					}
					
				}
				/*String strAction = FwHelper.correctNull((String) hshValues.get("Action"));
				String strStatusFlag =  FwHelper.correctNull((String) hshValues.get("Status_flag"));
				if(strStatusFlag.equalsIgnoreCase("S"))
				{
					int intPosition = arrValues.size();
					//intPosition++;
					booHO_Check = checkHOConnection();
					if(booHO_Check == true){
					pstmt.setString(intPosition+1,"Y");}
					else if(booHO_Check == false){
					pstmt.setString(intPosition+1,"N");}
					intPosition=intPosition+2;
					pstmt.setString(intPosition,strAction);
				}*/
				pstmt.executeUpdate();
				System.out.println("TO CHECK1");
			}
		}
		catch(Exception ce)
		{
			ce.printStackTrace();
			try
			{
//				ut.rollback();
			}
			catch(Exception e1)
			{
				e1.printStackTrace();
				System.out.println("exception in rollback");
			}
				System.out.println("TO CHECK"+ce);
				throw new EJBException(ce.getMessage());
		}
		finally
		{
			try
			{
				if(pstmt != null)
				{
					pstmt.close();
				}
				if(con != null)
				{
					con.close();
				}

			}
			catch(Exception cf)
			{
				cf.printStackTrace();
			throw new EJBException("Error closing connection "+cf.getMessage());
			}
		}
}
}