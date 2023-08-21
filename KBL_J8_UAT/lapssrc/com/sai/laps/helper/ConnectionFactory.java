/*
 * Created on Aug 2, 2004 This is the component that handles connection
 * requests. Created by Ram
 * Modified by Sureshkumar Ganapathy 
 * Since CBS Online interface is not available in Union Bank LAPs
 */
package com.sai.laps.helper;

import java.sql.Connection;
//import java.sql.DriverManager;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

public class ConnectionFactory {
	static Logger log=Logger.getLogger(ConnectionFactory.class);
	private static javax.sql.DataSource lapsds = null;
	private static javax.sql.DataSource lapsds2 = null;
	private static javax.sql.DataSource lapsds3 = null;
	private static javax.sql.DataSource cbsds = null;
	private static javax.sql.DataSource kalyptods = null;
	private static javax.sql.DataSource lapsds4 = null;
	private static javax.sql.DataSource lapsds5 = null;
	private static javax.sql.DataSource lapsdsUCIC = null;

	//private static javax.sql.DataSource cbsds = null;

	/**
	 * Method getDataSource.
	 * 
	 * @param dsName
	 *            String
	 * @return javax.sql.DataSource
	 * @throws Exception
	 */
	private static javax.sql.DataSource getDataSource(String dsName)
			throws Exception {
		javax.sql.DataSource ds = null;
		try {
			Context ctx = null;
			ctx = new InitialContext();
			ds = (javax.sql.DataSource) ctx.lookup(dsName);
			log.info("Database Look for the Data Source"+dsName);
		} catch (NamingException ne) {
			log.error(ne);
			throw ne;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
		return ds;
	}

	public static Connection getConnection() throws Exception {
		log.info("Connection from the getConnection() method.................");
		Connection conn = null;
		try {
           log.info("lapsds connection -->"+lapsds);
			if (lapsds == null) {
				lapsds = getDataSource(ApplicationParams.getDataSource());
			}
			conn = lapsds.getConnection();
			log.info("Connection One Attributes===="+conn.getMetaData().getURL()+"===="+conn.getMetaData().getUserName());

		} catch (Exception e) {
			try {
				conn = null;
				lapsds = getDataSource(ApplicationParams.getDataSource());
				conn = lapsds.getConnection();
			} catch (Exception ee) {
				throw new Exception(
						"ConnectionFactory:getConnection()- Error in Getting DB Connection"
								+ e);
			}

		}
		return conn;
	}

	public static Connection getDBS2Connection() throws Exception {
		log.info("Connection from the getDBS2Connection() method.................");
		Connection conn2 = null;
		try {
			log.info("lapsds2 connection -->"+lapsds2);
			if (lapsds2 == null) {
				lapsds2 = getDBS2DataSource(ApplicationParams.getStrDataSource2());
			}
			conn2 = lapsds2.getConnection();
			log.info("Connection Two Attributes===="+conn2.getMetaData().getURL()+"===="+conn2.getMetaData().getUserName());

		} catch (Exception e) {
			try {
				conn2 = null;
				lapsds2 = getDBS2DataSource(ApplicationParams.getStrDataSource2());
				conn2 = lapsds2.getConnection();
			} catch (Exception ee) {
				throw new Exception(
						"ConnectionFactory:getDBS2Connection()- Error in Getting DB Connection"
								+ e);
			}

		}
		return conn2;
	}
	
	
	private static javax.sql.DataSource getDBS2DataSource(String dsName)
			throws Exception {
		javax.sql.DataSource ds = null;
		try {
			Context ctx = null;
			ctx = new InitialContext();
			ds = (javax.sql.DataSource) ctx.lookup(dsName);
			log.info("Database Look for the Data Source"+dsName);
		} catch (NamingException ne) {
			log.error(ne);
			throw ne;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
		return ds;
		}
	
	
	public static Connection getInternetConnection() throws Exception {
		Connection conn2 = null;
		try {
			log.info("lapsds3 Connection===="+lapsds3);
			
			if (lapsds3 == null) {
				lapsds3 = getInternetDataSource(ApplicationParams.getDataSource3());
			}
			conn2 = lapsds3.getConnection();
			log.info("Connection Two Attributes===="+conn2.getMetaData().getURL()+"===="+conn2.getMetaData().getUserName());

		} catch (Exception e) {
			try {
				conn2 = null;
				lapsds3 = getInternetDataSource(ApplicationParams.getDataSource3());
				conn2 = lapsds3.getConnection();
			} catch (Exception ee) {
				throw new Exception(
						"ConnectionFactory:getDBS2Connection()- Error in Getting DB Connection"
								+ e);
			}

		}
		return conn2;
	}
	
	
	private static javax.sql.DataSource getInternetDataSource(String dsName)
			throws Exception {
		javax.sql.DataSource ds = null;
		try {
			Context ctx = null;
			ctx = new InitialContext();
			ds = (javax.sql.DataSource) ctx.lookup(dsName);
			log.info("Database Look for the Data Source"+dsName);
		} catch (NamingException ne) {
			log.error(ne);
			throw ne;
		} catch (Exception e) {
			log.error(e);
			throw e;
		}
		return ds;
		}
	
	
	/*
	public static Connection getDBS2Connection()
			throws Exception {
		Connection conn = null;
		try {
			if (lapsds2 == null) {
				lapsds2 = getDataSource(ApplicationParams.getStrDataSource2());
			}
			conn = lapsds2.getConnection();
		} catch (Exception e) {
			try {
				conn = null;
				lapsds2 = getDataSource(ApplicationParams.getStrDataSource2());
				conn = lapsds2.getConnection();
			} catch (Exception ee) {
				throw new Exception(
						"ConnectionFactory:getCBSConnectionMain()- Error in Getting DB CBSConnection"
								+ e);
			}

		}
		return conn;
	}

	public static Connection getDBS2DataSource(String CBSSource)
			throws Exception {		
		try {
			if ("FCR".equals(CBSSource)) {
				return getDBS2Connection();
			} else {
					javax.sql.DataSource ds = null;
					Context ctx = null;
					ctx = new InitialContext();
					ds = (javax.sql.DataSource) ctx.lookup(CBSSource);
					return ds.getConnection();
			}

		} catch (Exception e) {
			throw new Exception("ConnectionFactory: Error in Getting CBS "
					+ CBSSource + " DB Connection" + e);
		}

	}*/
			
		/*public static  Connection getOracleConnection()throws Exception
		{
			Connection connection =null;
			
			try
			{
			
			DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
			//DriverManager.setLoginTimeout(3);
			Logger.log("ORACLE CONNECTION URL=="+ApplicationParams.getORACLEURL());
			Logger.log("GETTING THE CONNECTION");
			connection = DriverManager.getConnection(Helper.correctNull(ApplicationParams.getORACLEURL()).split(",")[0],Helper.correctNull(ApplicationParams.getORACLEURL()).split(",")[1],Helper.correctNull(ApplicationParams.getORACLEURL()).split(",")[2]);
			Logger.log("** Connection Succeeded ** ");
			//Logger.log("CURRENT RESULTSETS :"+connection.getHoldability());
			//Logger.log("WARNINGS :\n"+connection.getWarnings());
			}
			catch(Exception e)
			{
				Logger.log("EXCEPTION FROM CONNECTION FACTORY:"+e.getMessage());
			}
			 return connection; 
		}*/
		
		
		
//	#####################################   END OF INTERFACE CONNECTION FACTORY  #######################################
		
		
	public static Connection getCBSConnectionMain()
	throws Exception {
Connection conn = null;
try {
	log.info("cbsds CBS Connection -->"+cbsds);
	if (cbsds == null) {
		cbsds = getDataSource(ApplicationParams.getCBSFCRDataSource());
	}
	conn = cbsds.getConnection();
	log.info("Connection Two Attributes===="+conn.getMetaData().getURL()+"===="+conn.getMetaData().getUserName());
} catch (Exception e) {
	try {
		conn = null;
		cbsds = getDataSource(ApplicationParams.getCBSFCRDataSource());
		conn = cbsds.getConnection();
	} catch (Exception ee) {
		throw new Exception(
				"ConnectionFactory:getCBSConnectionMain()- Error in Getting DB CBSConnection"
						+ e);
	}

}
return conn;
}
public static Connection getCBSConnection(String CBSSource) throws Exception {		
try {
	if ("FCR".equals(CBSSource)) {
		return getCBSConnectionMain();
	} else {
			javax.sql.DataSource ds = null;
			Context ctx = null;
			ctx = new InitialContext();
			ds = (javax.sql.DataSource) ctx.lookup(CBSSource);
			return ds.getConnection();
	}

} catch (Exception e) {
	throw new Exception("ConnectionFactory: Error in Getting CBS "
			+ CBSSource + " DB Connection" + e);
}

}
public static Connection getKalyptoConnectionMain()
throws Exception {
Connection conn = null;
try {
	log.info("kalyptods KALYPTO Connection -->"+kalyptods);
if (kalyptods == null) {
	kalyptods = getDataSource(ApplicationParams.getKalyptoDataSource());
}
conn = kalyptods.getConnection();
log.info("KALYPTO Connection Two Attributes===="+conn.getMetaData().getURL()+"===="+conn.getMetaData().getUserName());
} catch (Exception e) {
try {
	conn = null;
	kalyptods = getDataSource(ApplicationParams.getKalyptoDataSource());
	conn = kalyptods.getConnection();
} catch (Exception ee) {
	throw new Exception(
			"ConnectionFactory:getCBSConnectionMain()- Error in Getting DB CBSConnection"
					+ e);
}

}
return conn;
}

public static Connection getCibilConnection() throws Exception {
	Connection conn = null;
	try {
      	log.info("lapsds4 connection -->"+lapsds4);
		if (lapsds4 == null) {
			lapsds4 = getDataSource(ApplicationParams.getDataSource4());
		}
		conn = lapsds4.getConnection();
		log.info("CIBIL Connection Two Attributes===="+conn.getMetaData().getURL()+"===="+conn.getMetaData().getUserName());

	} catch (Exception e) {
		try {
			conn = null;
			lapsds4 = getDataSource(ApplicationParams.getDataSource4());
			conn = lapsds4.getConnection();
		} catch (Exception ee) {
			throw new Exception(
					"ConnectionFactory:getCibilConnection()- Error in Getting DB Connection"
							+ e);
		}
	}
	return conn;
}
public static Connection getLMSConnection() throws Exception {
	Connection conn = null;
	try {
		log.info("lapsds5  Connection -->"+lapsds5);
		if (lapsds5 == null) {
			lapsds5 = getDataSource(ApplicationParams.getStrLMSDatasource());
		}
		conn = lapsds5.getConnection();
		log.info("LMS Connection Two Attributes===="+conn.getMetaData().getURL()+"===="+conn.getMetaData().getUserName());
	} catch (Exception e) {
		try {
			conn = null;
			lapsds5 = getDataSource(ApplicationParams.getStrLMSDatasource());
			conn = lapsds5.getConnection();
		} catch (Exception ee) {
			throw new Exception(
					"ConnectionFactory:getLMSConnection()- Error in Getting DB Connection"
					+ e);
		}
	}
	return conn;
}
public static Connection getUCICConnection() throws Exception {
	log.info("Connection from the getConnection() method.................");
	Connection conn = null;
	try {
		
		
		if (lapsdsUCIC == null) {
			lapsdsUCIC = getDataSource(ApplicationParams.getStrUCICdatasource());
			
		}
		log.info("lapsdsUCIC connection -->"+lapsdsUCIC);
		conn = lapsdsUCIC.getConnection();
       log.info("lapsdsUCIC connection -->"+lapsdsUCIC);
		log.info("Connection One Attributes===="+conn.getMetaData().getURL()+"===="+conn.getMetaData().getUserName());

	} catch (Exception e) {
		try {
			conn = null;
			lapsdsUCIC = getDataSource(ApplicationParams.getStrUCICdatasource());
			conn = lapsdsUCIC.getConnection();
		} catch (Exception ee) {
			throw new Exception(
					"ConnectionFactory:getConnection()- Error in Getting UCIC DB Connection"
							+ e);
		}

	}
	return conn;
}

}
