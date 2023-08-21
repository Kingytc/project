package com.sai.laps.helper;

import com.sai.laps.helper.SAILogger;
	
import java.io.Reader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;

import org.apache.log4j.Logger;

import oracle.jdbc.pool.OracleDataSource;
import oracle.sql.CLOB;
/**
 * @AUTHOR: S.SATHYA MOORTHY
 * @SINCE :21/04/2008
 * @PURPOSE :FOR CLOB OPERATIONS.
 */
	public class CLOBInvoker {
		static Logger log=Logger.getLogger(CLOBInvoker.class);
	
		public static CLOB getCLOBInstance(Connection conn)throws Exception
		{  
			log.info("Getting CLOB INSTANCE");
			CLOB newClob = CLOB.createTemporary(conn, true, oracle.sql.CLOB.MODE_READWRITE);
			log.info("CLOB instance Received from Connection mode=read/write");
			return newClob;
             
		}
		
		/**
		 * @author :S.SATHYA MOORTHY
		 * @PURPOSE : FOR GETTING THE ORACLE CONNECTION
		*/
		public static Connection getConnection()throws Exception
		{			
			return ConnectionFactory.getConnection();
		}
		public static Connection getOracleConnection()
		{
			Connection con=null;
			OracleDataSource dataSource;
			try
			{
				dataSource = new OracleDataSource();
				dataSource.setUser(Helper.correctNull(ApplicationParams.getStrORACLEDBURL()).split(",")[1]);
				dataSource.setPassword(Helper.correctNull(ApplicationParams.getStrORACLEDBURL()).split(",")[2]);
				dataSource.setURL(Helper.correctNull(ApplicationParams.getStrORACLEDBURL()).split(",")[0]);
				//dataSource.setConnectionCachingEnabled(true);
				con = dataSource.getConnection();
				
			}
			catch(Exception e)
			{
				log.info("Exception from getOracleConnection Method"+e.toString());
				
			}
			
			return con;
		}
		
		
		public static String CLOBToString(ResultSet rs,String ColumnName)throws Exception
		{
			
			  StringBuffer sb =null;
	            char[] charbuf=null;
	            Reader reader = null;
	            	if(rs.getCharacterStream(ColumnName)!=null)
	            	{
	            	 reader =rs.getCharacterStream(ColumnName);
	            	 
	            	 sb = new StringBuffer();
	                  charbuf = new char[4096];
	                   for (int i = reader.read(charbuf); i > 0; i = reader.read(charbuf))
	                   sb.append(charbuf, 0, i);
	            	
	                   
	            	}
	            	if(sb==null)
	            		return "";
	            	else
	            		return sb.toString();
		}  
		
		public static boolean disposeCLOB(CLOB clob)
		{
			try
			{
				if(clob.isOpen())
				{
					clob.close();
					if(CLOB.isTemporary(clob))
					{
						CLOB.freeTemporary(clob);
					}
				}
				else
				{
					if(CLOB.isTemporary(clob))
					{
						CLOB.freeTemporary(clob);
					}
					
				}
				
			}
			catch(Exception e)
			{
				log.info("Exception Occured while closing Clobinsance"+e.toString());
			}
			return true;
		}
		
		
	    
}//end of class