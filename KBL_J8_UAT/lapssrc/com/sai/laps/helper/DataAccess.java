package com.sai.laps.helper;

import java.io.ByteArrayInputStream;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;

import javax.ejb.EJBException;

import org.apache.log4j.Logger;

/**
 * Date: 16-OCT-2007
 * 
 * @Modified by Muralidharan Notes: Modified to insert/update data into oracle BLOB/CLOB datatype
 * @Modified by Sureshkumar For commenting updateCBSData since it is not required in Union Bank LAPS
 */

public class DataAccess
{
	static Logger log = Logger.getLogger(DataAccess.class);
	/***
	 * HashMap to hold the second database server query codes
	 */
	private static HashMap hshDBS2Query = new HashMap();

	/***
	 * This method has been added to hold the second database server queries.
	 */
	public static void buildDBS2QueriesDocument()
	{
		hshDBS2Query = GlobalXMLLoader.loadDBS2Queries();
	}

	public void updateData(HashMap hshValues) throws Exception
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String strQuery = "";
		HashMap hshQuery = null;
		String strQueryId = null;
		String strSize = (String) hshValues.get("size");
		int intSize = Integer.parseInt(strSize);
		ArrayList arrValues = null;
		String strAddParam="";

		try
		{
			for (int i = 1; i <= intSize; i++)
			{
				hshQuery = (HashMap) hshValues.get(String.valueOf(i));
				strQueryId = (String) hshQuery.get("strQueryId");
				strAddParam=Helper.correctNull((String)hshQuery.get("strAppendString"));
				if (hshDBS2Query.containsKey(strQueryId))
				{
					con = ConnectionFactory.getDBS2Connection();
				} else
				{
					con = ConnectionFactory.getConnection();
				}
				arrValues = (ArrayList) hshQuery.get("arrValues");

				strQuery = SQLParser.getSqlQuery(strQueryId);
				
				//To Construct the query dynamically
				if(!strAddParam.equalsIgnoreCase(""))
				{
					strQuery	=	strQuery +" "+strAddParam;
					log.info("Query===="+strQuery);
				}
				
				log.info("arrValues===="+arrValues);
				
				StringTokenizer st = new StringTokenizer(strQuery, "#");
				if (st.hasMoreElements())
				{
					st.nextElement();
					strQuery = st.nextElement().toString().trim();
				}
				pstmt = con.prepareStatement(strQuery);
				pstmt.clearParameters();
				for (int j = 1; j <= arrValues.size(); j++)
				{
					if (arrValues.get(j - 1) instanceof byte[])
					{
						byte[] bArr = (byte[]) arrValues.get(j - 1);
						pstmt.setBinaryStream(j, new ByteArrayInputStream(bArr), bArr.length);
					} else
					{
						pstmt.setString(j, (String) arrValues.get(j - 1));
					}
				}
				long t1 = System.currentTimeMillis();
				pstmt.executeUpdate();
				long t2 = System.currentTimeMillis();
				log.info("Query Execution Time for KBL For Updation :: " + (t2 - t1) + "ms for Query Code = " + strQueryId);
				//log.info("arrValues===="+arrValues);
				if (pstmt != null)
				{
					pstmt.close();
				}
				if (con != null)
				{
					con.close();
				}
				
			}
		}
		catch (Exception e)
		{
			throw new Exception("Exception in updateData(HashMap hshValues) :  " + e.getMessage());
		}
		finally
		{
			try
			{
				if (pstmt != null)
				{
					pstmt.close();
				}
				if (con != null)
				{
					con.close();
				}
				if (hshValues != null)
					hshValues = null;
			}
			catch (Exception cf)
			{
				throw new EJBException("Error closing connection " + cf.getMessage());
			}
		}
	}

	public void setBlobIntoStatement(byte[] bArr, PreparedStatement pstmt, int idx) throws Exception
	{
		try
		{
			if (FwConstants.DATABASE_TYPE_ORACLE.equals(ApplicationParams.getDatabaseType().toUpperCase()))
			{
				// First get the oracle blob class

				Class oracleBlobClass = Class.forName(FwConstants.ORACLE_BLOB_CLASS);
				DatabaseMetaData dbMetaData = pstmt.getConnection().getMetaData();

				// Get the oracle connection class for checking

				Class oracleConnectionClass = Class.forName(FwConstants.ORACLE_CONNECTION_CLASS);

				// now get the static factory method
				Class partypes[] = new Class[3];
				partypes[0] = Connection.class;
				partypes[1] = Boolean.TYPE;
				partypes[2] = Integer.TYPE;
				Method createTemporaryMethod = oracleBlobClass.getDeclaredMethod(FwConstants.ORACLE_BLOB_TEMP_METHOD, partypes);

				// now get ready to call the factory method

				Field durationSessionField = oracleBlobClass.getField(FwConstants.ORACLE_BLOB_DURATION);
				Object arglist[] = new Object[3];
				Connection conn = dbMetaData.getConnection();

				// Make sure connection object is right type

				if (!oracleConnectionClass.isAssignableFrom(conn.getClass()))
				{
					throw new Exception("JDBC connection object must be a " + FwConstants.ORACLE_CONNECTION_CLASS + " Current Connection class is "
							+ conn.getClass().getName());
				}

				arglist[0] = conn;
				arglist[1] = Boolean.TRUE;
				arglist[2] = durationSessionField.get(null); // null is valid

				// because of
				// static field
				// Create our BLOB

				Object tempBlob = createTemporaryMethod.invoke(null, arglist); // null

				// is
				// valid
				// because
				// of
				// static
				// method
				// get the open method

				partypes = new Class[1];
				partypes[0] = Integer.TYPE;
				Method openMethod = oracleBlobClass.getDeclaredMethod(FwConstants.ORACLE_BLOB_OPEN_METHOD, partypes);

				// prepare to call the method

				Field modeReadWriteField = oracleBlobClass.getField(FwConstants.ORACLE_BLOB_MODE);
				arglist = new Object[1];
				arglist[0] = modeReadWriteField.get(null); // null is valid

				// because of static
				// field
				// call open(BLOB.MODE_READWRITE);

				openMethod.invoke(tempBlob, arglist);
				Method getBinaryOutputStream = oracleBlobClass.getDeclaredMethod(FwConstants.ORACLE_BLOB_BINARYOUTPUTSTREAM_METHOD, null);

				OutputStream tempBlobOutputStream = (OutputStream) getBinaryOutputStream.invoke(tempBlob, null);
				tempBlobOutputStream.write(bArr);
				tempBlobOutputStream.flush();
				tempBlobOutputStream.close();
				Method closeMethod = oracleBlobClass.getDeclaredMethod(FwConstants.ORACLE_BLOB_CLOSE_METHOD, null);
				closeMethod.invoke(tempBlob, null);
				pstmt.setBlob(idx, (Blob) tempBlob);

			} else if (FwConstants.DATABASE_TYPE_DB2.equals(ApplicationParams.getDatabaseType().toUpperCase()))
			{
				ByteArrayInputStream bais = new ByteArrayInputStream(bArr);
				pstmt.setBinaryStream(idx, bais, bArr.length);
			} else
			{
				pstmt.setBytes(idx, bArr);
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Exception occurred in BlobDataAccess setBlobImageIntoStatement()" + e.getMessage());
		}
		finally
		{
			try
			{
				if (pstmt != null)
				{
					pstmt.close();
				}

			}
			catch (Exception cf)
			{
				throw new Exception("Error closing connection " + cf.getMessage());
			}
		}
	}

	public void updateInternetData(HashMap hshValues) throws Exception
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String strQuery = "";
		HashMap hshQuery = null;
		String strQueryId = null;
		String strSize = (String) hshValues.get("size");
		int intSize = Integer.parseInt(strSize);
		ArrayList arrValues = null;

		try
		{
			for (int i = 1; i <= intSize; i++)
			{
				hshQuery = (HashMap) hshValues.get(String.valueOf(i));
				strQueryId = (String) hshQuery.get("strQueryId");
				con = ConnectionFactory.getInternetConnection();
				arrValues = (ArrayList) hshQuery.get("arrValues");
				strQuery = SQLParser.getSqlQuery(strQueryId);
				StringTokenizer st = new StringTokenizer(strQuery, "#");
				if (st.hasMoreElements())
				{
					st.nextElement();
					strQuery = st.nextElement().toString().trim();
				}
				pstmt = con.prepareStatement(strQuery);
				pstmt.clearParameters();
				for (int j = 1; j <= arrValues.size(); j++)
				{
					if (arrValues.get(j - 1) instanceof byte[])
					{
						byte[] bArr = (byte[]) arrValues.get(j - 1);
						pstmt.setBinaryStream(j, new ByteArrayInputStream(bArr), bArr.length);
					} else
					{
						pstmt.setString(j, (String) arrValues.get(j - 1));
					}
				}
				long t1 = System.currentTimeMillis();
				pstmt.executeUpdate();
				long t2 = System.currentTimeMillis();
				log.info("Query Execution Time for KBL For Updation :: " + (t2 - t1) + "ms for Query Code = " + strQueryId);
				//log.info("arrValues===="+arrValues);
				
				if(pstmt != null)
				{
					pstmt.close();					
				}	
				if(con != null)
				{
					con.close();
				}
			}
		}
		catch (Exception ce)
		{
			throw new EJBException(ce.getMessage());
		}
		finally
		{
			try
			{
				if (pstmt != null)
				{
					pstmt.close();
				}
				if (con != null)
				{
					con.close();
				}

				if (hshValues != null)
					hshValues = null;
			}
			catch (Exception cf)
			{
				throw new EJBException("Error closing connection " + cf.getMessage());
			}
		}
	}

	/**
	 * @purpose : TO INSERT OR UPDATE THE DATA AS BATCH INSTEAD OF INSERTING IN LOOP
	 * @description :
	 * @todo : USING THIS METHOD WE CAN PERFORM ONLY BATCH INSERT / UPDATE / DELETE. NOT IN COMBINATION. THAT SHOULD BE IMPLEMENTED
	 */
	public void updateBatchData(HashMap hshValues) throws Exception
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String strQuery = null;
		HashMap hshQuery = null;
		String strQueryId = null;
		String strSize = null;
		int intSize = 0;
		ArrayList arrValues = null;

		try
		{
			con = ConnectionFactory.getConnection();
			strSize = (String) hshValues.get("size");
			intSize = Integer.parseInt(strSize);
			for (int i = 1; i <= intSize; i++)
			{
				hshQuery = (HashMap) hshValues.get(String.valueOf(i));
				strQueryId = Helper.correctNull((String) hshQuery.get("strQueryId"));
				arrValues = (ArrayList) hshQuery.get("arrValues");
				strQuery = SQLParser.getSqlQuery(strQueryId);
				if (pstmt != null)
					pstmt.close();
				pstmt = con.prepareStatement(strQuery);
				for (int j = 1; j <= arrValues.size(); j++)
				{
					pstmt.setString(j, Helper.correctNull((String) arrValues.get(j - 1)));
				}
				pstmt.addBatch();

			}
			long t1 = System.currentTimeMillis();
			int[] rowCount = pstmt.executeBatch();
			long t2 = System.currentTimeMillis();
			log.info("Query Execution Time for KBL For Updation :: " + (t2 - t1) + "ms for Query Code = " + strQueryId);
			if (pstmt != null)
			{
				pstmt.close();
			}
			if (con != null)
			{
				con.close();
			}
		}
		catch (SQLException e)
		{
			log.error("SQL Exception IN SQL BATCH UPDATE ::" + e.getMessage());
			throw new Exception(e.getMessage());
		}
		catch (Exception ce)
		{
			log.error("ERROR IN SQL BATCH UPDATE ::" + ce.getMessage());
			throw new Exception(ce.getMessage());
		}
		finally
		{
			try
			{
				if (pstmt != null)
				{
					pstmt.close();
				}
				if (con != null)
				{
					con.close();
				}

			}
			catch (Exception cf)
			{
				log.error("ERROR IN SQL BATCH UPDATE ::" + cf.getMessage());
				throw new Exception("ERROR IN RESOURCE CLOSING " + cf.getMessage());
			}
		}
	}

	public void updateCBSData(HashMap hshValues) throws Exception
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String strQuery = null;
		HashMap hshQuery = null;
		String strQueryId = null;
		String strSize = null;
		int intSize = 0;
		ArrayList arrValues = null;

		try
		{
			con = ConnectionFactory.getCBSConnectionMain();
			strSize = (String) hshValues.get("size");
			intSize = Integer.parseInt(strSize);
			for (int i = 1; i <= intSize; i++)
			{
				hshQuery = (HashMap) hshValues.get(String.valueOf(i));
				strQueryId = Helper.correctNull((String) hshQuery.get("strQueryId"));
				arrValues = (ArrayList) hshQuery.get("arrValues");
				strQuery = SQLParser.getCBSSqlQuery(strQueryId);
				if (pstmt != null)
					pstmt.close();
				pstmt = con.prepareStatement(strQuery);
				for (int j = 1; j <= arrValues.size(); j++)
				{
					pstmt.setString(j, Helper.correctNull((String) arrValues.get(j - 1)));
				}
				pstmt.addBatch();

			}
			long t1 = System.currentTimeMillis();
			int[] rowCount = pstmt.executeBatch();
			long t2 = System.currentTimeMillis();
			log.info("Query Execution Time for KBL For Updation :: " + (t2 - t1) + "ms for Query Code = " + strQueryId);
			//log.info("arrValues===="+arrValues);
			if (pstmt != null)
			{
				pstmt.close();
			}
			if (con != null)
			{
				con.close();
			}
		}
		catch (SQLException e)
		{
			log.error("SQL Exception IN SQL BATCH UPDATE ::" + e.getMessage());
			throw new Exception(e.getMessage());
		}
		catch (Exception ce)
		{
			log.error("ERROR IN SQL BATCH UPDATE ::" + ce.getMessage());
			throw new Exception(ce.getMessage());
		}
		finally
		{
			try
			{
				if (pstmt != null)
				{
					pstmt.close();
				}
				if (con != null)
				{
					con.close();
				}

			}
			catch (Exception cf)
			{
				log.error("ERROR IN SQL BATCH UPDATE ::" + cf.getMessage());
				throw new Exception("ERROR IN RESOURCE CLOSING " + cf.getMessage());
			}
		}
	}

	public void updateKalyptoData(HashMap hshValues) throws Exception
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String strQuery = null;
		HashMap hshQuery = null;
		String strQueryId = null;
		String strSize = null;
		int intSize = 0;
		ArrayList arrValues = null;

		try
		{
			con = ConnectionFactory.getKalyptoConnectionMain();
			strSize = (String) hshValues.get("size");
			intSize = Integer.parseInt(strSize);
			for (int i = 1; i <= intSize; i++)
			{
				hshQuery = (HashMap) hshValues.get(String.valueOf(i));
				strQueryId = Helper.correctNull((String) hshQuery.get("strQueryId"));
				arrValues = (ArrayList) hshQuery.get("arrValues");
				strQuery = SQLParser.getCBSSqlQuery(strQueryId);
				if (pstmt != null)
					pstmt.close();
				pstmt = con.prepareStatement(strQuery);
				for (int j = 1; j <= arrValues.size(); j++)
				{
					pstmt.setString(j, Helper.correctNull((String) arrValues.get(j - 1)));
				}
				pstmt.addBatch();

			}
			long t1 = System.currentTimeMillis();
			int[] rowCount = pstmt.executeBatch();
			long t2 = System.currentTimeMillis();
			log.info("Query Execution Time for KBL For Updation :: " + (t2 - t1) + "ms for Query Code = " + strQueryId);
			log.info("Kalypto arrValues===="+arrValues);
			if (pstmt != null)
			{
				pstmt.close();
			}
			if (con != null)
			{
				con.close();
			}
			
		}
		catch (SQLException e)
		{
			log.error("SQL Exception IN SQL BATCH UPDATE ::" + e.getMessage());
			throw new Exception(e.getMessage());
		}
		catch (Exception ce)
		{
			log.error("ERROR IN SQL BATCH UPDATE ::" + ce.getMessage());
			throw new Exception(ce.getMessage());
		}
		finally
		{
			try
			{
				if (pstmt != null)
				{
					pstmt.close();
				}
				if (con != null)
				{
					con.close();
				}

			}
			catch (Exception cf)
			{
				log.error("ERROR IN SQL BATCH UPDATE ::" + cf.getMessage());
				throw new Exception("ERROR IN RESOURCE CLOSING " + cf.getMessage());
			}
		}
	}
	public void updateMonitoringData(HashMap hshValues) throws Exception
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String strQuery = "";
		HashMap hshQuery = null;
		String strQueryId = null;
		String strSize = (String) hshValues.get("size");
		int intSize = Integer.parseInt(strSize);
		ArrayList arrValues = null;

		try
		{
			for (int i = 1; i <= intSize; i++)
			{
				hshQuery = (HashMap) hshValues.get(String.valueOf(i));
				strQueryId = (String) hshQuery.get("strQueryId");
				con = ConnectionFactory.getDBS2Connection();
				arrValues = (ArrayList) hshQuery.get("arrValues");
				strQuery = SQLParser.getSqlQuery(strQueryId);
				StringTokenizer st = new StringTokenizer(strQuery, "#");
				if (st.hasMoreElements())
				{
					st.nextElement();
					strQuery = st.nextElement().toString().trim();
				}
				pstmt = con.prepareStatement(strQuery);
				pstmt.clearParameters();
				for (int j = 1; j <= arrValues.size(); j++)
				{
					if (arrValues.get(j - 1) instanceof byte[])
					{
						byte[] bArr = (byte[]) arrValues.get(j - 1);
						pstmt.setBinaryStream(j, new ByteArrayInputStream(bArr), bArr.length);
					} else
					{
						pstmt.setString(j, (String) arrValues.get(j - 1));
					}
				}
				long t1 = System.currentTimeMillis();
				pstmt.executeUpdate();
				long t2 = System.currentTimeMillis();
				log.info("Query Execution Time for KBL For Updation :: " + (t2 - t1) + "ms for Query Code = " + strQueryId);
				//log.info("arrValues===="+arrValues);
				
				if(pstmt != null)
				{
					pstmt.close();					
				}	
				if(con != null)
				{
					con.close();
				}
			}
		}
		catch (Exception ce)
		{
			throw new EJBException(ce.getMessage());
		}
		finally
		{
			try
			{
				if (pstmt != null)
				{
					pstmt.close();
				}
				if (con != null)
				{
					con.close();
				}

				if (hshValues != null)
					hshValues = null;
			}
			catch (Exception cf)
			{
				throw new EJBException("Error closing connection " + cf.getMessage());
			}
		}
	}

}