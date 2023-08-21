/*
 * Created on Jul 20, 2006
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.sai.laps.helper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.fw.data.SQLCachedRowSet;
import com.sai.fw.data.SQLCachedRowSetFactory;

/**
 * @author Ram TODO To change the template for this generated type comment go to Window - Preferences - Java - Code Style - Code Templates
 */
public class DBUtils
{
	static Logger log = Logger.getLogger(DBUtils.class);
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

	/**
	 * Method getResults.
	 * 
	 * @param strQueryId
	 *            String
	 * @return SQLCachedRowSet
	 * @throws Exception
	 */
	public static SQLCachedRowSet executeLAPSQuery(String strQueryAndParam) throws Exception
	{
		SQLCachedRowSet crs;
		Connection conn = null;
		PreparedStatement statement = null;
		ResultSet resultset = null;
		ArrayList arrResult = null;
		String strQueryCode = null;
		try
		{
			crs = SQLCachedRowSetFactory.getCachedRowSet();
			arrResult = DBUtils.parseQuery(strQueryAndParam);
			String strQuery = "";
			ArrayList arrValues = new ArrayList();
			int intSize = arrResult != null ? arrResult.size() : 0;
			if (intSize > 0 && arrResult.get(0) instanceof String)
			{
				strQuery = (String) arrResult.get(0);
			}
			if (intSize > 1 && arrResult.get(1) instanceof ArrayList)
			{
				arrValues = (ArrayList) arrResult.get(1);
			}

			StringBuffer sbfQuery = new StringBuffer(strQuery);
			strQuery = Helper.replaceAll(strQuery, "'?'", "?", true);

			StringTokenizer st = new StringTokenizer(strQueryAndParam, "^");
			if (st.hasMoreElements())
			{
				strQueryCode = (String) st.nextElement();
			}

			conn = ConnectionFactory.getConnection();
			statement = conn.prepareStatement(strQuery);

			for (int i = 0; i < arrValues.size(); i++)
			{
				int intIndex = sbfQuery.toString().indexOf("?");
				if (intIndex != -1)
				{
					if (sbfQuery.charAt(intIndex - 1) == '\'' && sbfQuery.charAt(intIndex + 1) == '\'')
					{
						statement.setString(i + 1, (String) arrValues.get(i));
					} else
					{
						statement.setObject(i + 1, arrValues.get(i));
					}
					sbfQuery.deleteCharAt(intIndex);
				}

			}
			long t1 = System.nanoTime();
			resultset = statement.executeQuery();
			crs.populate(resultset);
			long t2 = System.nanoTime();
			log.info("Query Execution Time for [Query Code = " + strQueryCode + "] is : " + (t2 - t1 + " ns"));
		}
		catch (SQLException e)
		{
			log.error("SQLException in executeLAPSQuery(String strQuery)" + e.getMessage());
			throw e;
		}
		catch (Exception e)
		{
			log.error("Exception in executeLAPSQuery(String strQuery)" + e.getMessage());
			throw e;
		}
		finally
		{
			try
			{
				if (resultset != null)
				{
					resultset.close();
				}
				if (statement != null)
				{
					statement.close();
				}
				if (conn != null)
				{
					conn.close();
				}
			}
			catch (Exception e)
			{
				throw new Exception(e.getMessage());
			}
		}
		return crs;
	}

	public static ArrayList parseQuery(String strQueryAndParam) throws Exception
	{
		ArrayList arrResult = new ArrayList();
		ArrayList arrValues = new ArrayList();
		ArrayList arrParamValues = new ArrayList();
		StringTokenizer st = new StringTokenizer(strQueryAndParam, "^");
		StringBuffer sbfQuery;
		while (st.hasMoreElements())
		{
			arrValues.add(st.nextElement());
		}
		String strQcode = (String) arrValues.get(0);

		String strQuery = SQLParser.getSqlQueryByCode(strQcode);

		if (strQuery == null)
		{
			throw new Exception("Query not found in xml file for given ID" + strQueryAndParam);
		}
		sbfQuery = new StringBuffer(strQuery);
		for (int i = 1; i < arrValues.size(); i++)
		{
			int intTildeIndex = sbfQuery.toString().indexOf("~");
			int intCartIndex = sbfQuery.toString().indexOf("^");
			if (intCartIndex != -1)
			{
				String strValue = (String) arrValues.get(i);

				sbfQuery.deleteCharAt(intCartIndex);
				sbfQuery.insert(intCartIndex, "?");
				if (sbfQuery.charAt(intCartIndex - 1) == '_')
				{
					strValue = "_" + strValue;
					sbfQuery.deleteCharAt(intCartIndex - 1);
				}

				if (sbfQuery.charAt(intCartIndex + 1) == '%')
				{
					strValue = strValue + "%";
					sbfQuery.deleteCharAt(intCartIndex + 1);

				}
				if (sbfQuery.charAt(intCartIndex - 1) == '%')
				{
					strValue = "%" + strValue;
					sbfQuery.deleteCharAt(intCartIndex - 1);
				}
				arrParamValues.add(strValue);
			} else if (intTildeIndex != -1)
			{
				sbfQuery.deleteCharAt(intTildeIndex);
				sbfQuery.insert(intTildeIndex, (String) arrValues.get(i));
			}
			
			/*int intIndex = sbfQuery.toString().indexOf("?");
			if (intIndex != -1)
			{
				sbfQuery.deleteCharAt(intIndex);
				sbfQuery.insert(intIndex, (String) arrValues.get(i));
			}*/
		}
		
		log.info("QUERY IN SQL PARSER... [Query Code : " + strQueryAndParam + "]\n" + sbfQuery.toString());

		strQuery = sbfQuery.toString();
		arrResult.add(strQuery);
		arrResult.add(arrParamValues);
		return arrResult;
	}

	/**
	 * Method getResults.
	 * 
	 * @param strQueryId
	 *            String
	 * @return SQLCachedRowSet
	 * @throws Exception
	 */
	public static SQLCachedRowSet executeQuery(String strQuery) throws Exception
	{
		SQLCachedRowSet crs;
		Connection conn = null;
		PreparedStatement statement = null;
		ResultSet resultset = null;
		String strQueryCode = null;
		try
		{
			crs = SQLCachedRowSetFactory.getCachedRowSet();
			StringTokenizer st = new StringTokenizer(strQuery, "#");
			if (st.hasMoreElements())
			{
				strQueryCode = st.nextElement().toString().split("\\^")[0];
				strQuery = (String) st.nextElement();
			}
			conn = ConnectionFactory.getConnection();
			statement = conn.prepareStatement(strQuery);
			long t1 = System.currentTimeMillis();
			resultset = statement.executeQuery();
			crs.populate(resultset);
			long t2 = System.currentTimeMillis();
			log.info("Query Execution Time for [Query Code = " + strQueryCode + "] is : " + (t2 - t1 + "ms"));
		}
		catch (SQLException e)
		{
			log.error("SQLException in executeQuery(String strQuery)" + e.getMessage());
			throw e;
		}
		catch (Exception e)
		{
			log.error("Exception in executeQuery(String strQuery)" + e.getMessage());
			throw e;
		}
		finally
		{
			try
			{
				if (resultset != null)
				{
					resultset.close();
				}
				if (statement != null)
				{
					statement.close();
				}
				if (conn != null)
				{
					conn.close();
				}
			}
			catch (Exception se)
			{
				throw new Exception(se.getMessage());
			}
		}
		return crs;
	}

	/**
	 * Method getResults.
	 * 
	 * @param strQueryId
	 *            String
	 * @return SQLCachedRowSet
	 * @throws Exception
	 */
	public static SQLCachedRowSet executeQueryLimited(String strQuery) throws Exception
	{
		SQLCachedRowSet crs;
		Connection conn = null;
		PreparedStatement statement = null;
		ResultSet resultset = null;
		try
		{
			crs = SQLCachedRowSetFactory.getCachedRowSet();
			StringTokenizer st = new StringTokenizer(strQuery, "#");
			if (st.hasMoreElements())
			{
				strQuery = (String) st.nextElement();
			}
			conn = ConnectionFactory.getConnection();
			statement = conn.prepareStatement(strQuery);
			statement.setFetchSize(500);
			statement.setMaxRows(500);
			long t1 = System.nanoTime();
			resultset = statement.executeQuery();
			crs.setFetchSize(500);
			crs.setMaxRows(500);
			crs.populate(resultset);
			long t2 = System.nanoTime();
			log.info("Query Execution Time for [Query = " + strQuery + "] is : " + (t2 - t1 + "ms"));
		}
		catch (SQLException e)
		{
			log.info("SQLException in executeQueryLimited(String strQuery)" + e.getMessage());
			throw e;
		}
		catch (Exception e)
		{
			log.error("Exception in executeQueryLimited(String strQuery)" + e.getMessage());
			throw e;
		}
		finally
		{
			try
			{
				if (resultset != null)
				{
					resultset.close();
				}
				if (statement != null)
				{
					statement.close();
				}
				if (conn != null)
				{
					conn.close();
				}
			}
			catch (Exception se)
			{
				throw new Exception(se.getMessage());
			}
		}
		return crs;
	}

	/**
	 * Method getResults.
	 * 
	 * @param strQueryId
	 *            String
	 * @return SQLCachedRowSet
	 * @throws Exception
	 */
	public static SQLCachedRowSet executeQueryFixedCount(String strQuery, int maxRows) throws Exception
	{
		SQLCachedRowSet crs;
		Connection conn = null;
		PreparedStatement statement = null;
		ResultSet resultset = null;
		try
		{
			crs = SQLCachedRowSetFactory.getCachedRowSet();
			StringTokenizer st = new StringTokenizer(strQuery, "#");
			if (st.hasMoreElements())
			{
				strQuery = (String) st.nextElement();
			}
			conn = ConnectionFactory.getConnection();
			statement = conn.prepareStatement(strQuery);
			statement.setFetchSize(maxRows);
			statement.setMaxRows(maxRows);
			resultset = statement.executeQuery();
			crs.setFetchSize(maxRows);
			crs.setMaxRows(maxRows);
			crs.populate(resultset);
		}
		catch (SQLException e)
		{
			log.error("SQLException in executeQueryFixedCount(String strQuery)" + e.getMessage());
			throw e;
		}
		catch (Exception e)
		{
			log.error("Exception in executeQueryFixedCount(String strQuery)" + e.getMessage());
			throw e;
		}
		finally
		{
			try
			{
				if (resultset != null)
				{
					resultset.close();
				}
				if (statement != null)
				{
					statement.close();
				}
				if (conn != null)
				{
					conn.close();
				}
			}
			catch (Exception se)
			{
				throw new Exception(se.getMessage());
			}
		}
		return crs;
	}

	public static SQLCachedRowSet executeInternetQuery(String strQueryAndParam) throws Exception
	{
		SQLCachedRowSet crs;
		Connection conn = null;
		PreparedStatement statement = null;
		ResultSet resultset = null;
		ArrayList arrResult = null;
		String strQueryCode = null;
		try
		{
			crs = SQLCachedRowSetFactory.getCachedRowSet();
			arrResult = DBUtils.parseQuery(strQueryAndParam);
			String strQuery = "";
			ArrayList arrValues = new ArrayList();
			StringBuffer sbfQuery;
			int intSize = arrResult != null ? arrResult.size() : 0;
			if (intSize > 0 && arrResult.get(0) instanceof String)
			{
				strQuery = (String) arrResult.get(0);
			}
			if (intSize > 1 && arrResult.get(1) instanceof ArrayList)
			{
				arrValues = (ArrayList) arrResult.get(1);
			}
			sbfQuery = new StringBuffer(strQuery);
			strQuery = Helper.replaceAll(strQuery, "'?'", "?", true);

			StringTokenizer st = new StringTokenizer(strQueryAndParam, "^");
			if (st.hasMoreElements())
			{
				strQueryCode = (String) st.nextElement();
			}
			if (strQuery != null && strQueryCode != null)
			{
				conn = ConnectionFactory.getInternetConnection();
			} else
			{
				conn = ConnectionFactory.getConnection();
			}

			statement = conn.prepareStatement(strQuery);

			for (int i = 0; i < arrValues.size(); i++)
			{
				int intIndex = sbfQuery.toString().indexOf("?");
				if (intIndex != -1)
				{
					if (sbfQuery.charAt(intIndex - 1) == '\'' && sbfQuery.charAt(intIndex + 1) == '\'')
					{
						statement.setString(i + 1, (String) arrValues.get(i));
					} else
					{
						statement.setObject(i + 1, arrValues.get(i));
					}
					sbfQuery.deleteCharAt(intIndex);
				}

			}
			long t1 = System.nanoTime();
			resultset = statement.executeQuery();
			crs.populate(resultset);
			long t2 = System.nanoTime();
			log.info("Query Execution Time for [Query = " + strQuery + "] is : " + (t2 - t1 + "ms"));

		}
		catch (SQLException e)
		{
			log.error("SQLException in executeLAPSQuery(String strQuery)" + e.getMessage());
			throw e;
		}
		catch (Exception e)
		{
			log.error("Exception in executeLAPSQuery(String strQuery)" + e.getMessage());
			throw e;
		}
		finally
		{
			try
			{
				if (resultset != null)
				{
					resultset.close();
				}
				if (statement != null)
				{
					statement.close();
				}
				if (conn != null)
				{
					conn.close();
				}
			}
			catch (Exception se)
			{
				throw new Exception(se.getMessage());
			}
		}
		return crs;
	}

	/**
	 * Method getResults.
	 * 
	 * @param strQueryId
	 *            String
	 * @return SQLCachedRowSet
	 * @throws Exception
	 */
	public static SQLCachedRowSet executeInternetParserQuery(String strQuery) throws Exception
	{
		SQLCachedRowSet crs;
		Connection conn = null;
		PreparedStatement statement = null;
		ResultSet resultset = null;
		String strQueryCode = null;
		try
		{
			try
			{
				crs = SQLCachedRowSetFactory.getCachedRowSet();
			}
			catch (Exception e)
			{
				crs = SQLCachedRowSetFactory.getCachedRowSet();
			}
			StringTokenizer st = new StringTokenizer(strQuery, "#");
			if (st.hasMoreElements())
			{
				strQueryCode = st.nextElement().toString().split("\\^")[0];
				strQuery = (String) st.nextElement();
			}
			if (strQuery != null && strQueryCode != null)
			{
				conn = ConnectionFactory.getInternetConnection();
			} else
			{
				conn = ConnectionFactory.getConnection();
			}
			statement = conn.prepareStatement(strQuery);
			long t1 = System.nanoTime();
			resultset = statement.executeQuery();
			crs.populate(resultset);
			long t2 = System.nanoTime();
			log.info("Query Execution Time for [Query = " + strQuery + "] is : " + (t2 - t1 + "ms"));

		}
		catch (SQLException e)
		{
			log.error("SQLException in executeQuery(String strQuery)" + e.getMessage());
			throw e;
		}
		catch (Exception e)
		{
			log.error("Exception in executeQuery(String strQuery)" + e.getMessage());
			throw e;
		}
		finally
		{
			try
			{
				if (resultset != null)
				{
					resultset.close();
				}
				if (statement != null)
				{
					statement.close();
				}
				if (conn != null)
				{
					conn.close();
				}
			}
			catch (SQLException se)
			{
				throw new Exception(se.getMessage());
			}
		}
		return crs;
	}

	public static SQLCachedRowSet executeQueryCBSConnection(String strQuery) throws Exception
	{
		SQLCachedRowSet crs;
		Connection conn = null;
		PreparedStatement statement = null;
		ResultSet resultset = null;
		try
		{
			crs = SQLCachedRowSetFactory.getCachedRowSet();
			conn = ConnectionFactory.getCBSConnectionMain();
			statement = conn.prepareStatement(strQuery);
			long t1 = System.currentTimeMillis();
			resultset = statement.executeQuery();
			crs.populate(resultset);
			long t2 = System.currentTimeMillis();
			log.info("Query Execution Time for [CBSQuery = " + strQuery + "] is : " + (t2 - t1 + "ms"));
		}
		catch (SQLException e)
		{
			log.error("SQLException in executeQuery(String strQuery)" + e.getMessage());
			throw e;
		}
		catch (Exception e)
		{
			log.error("Exception in executeQuery(String strQuery)" + e.getMessage());
			throw e;
		}
		finally
		{
			try
			{
				if (resultset != null)
				{
					resultset.close();
				}
				if (statement != null)
				{
					statement.close();
				}
				if (conn != null)
				{
					conn.close();
				}
			}
			catch (Exception se)
			{
				throw new Exception(se.getMessage());
			}
		}
		return crs;
	}

	public static SQLCachedRowSet executeQueryKalyptoConnection(String strQuery) throws Exception
	{
		SQLCachedRowSet crs;
		Connection conn = null;
		PreparedStatement statement = null;
		ResultSet resultset = null;
		try
		{
			try
			{
				crs = SQLCachedRowSetFactory.getCachedRowSet();
			}
			catch (Exception e)
			{
				crs = SQLCachedRowSetFactory.getCachedRowSet();
			}
			conn = ConnectionFactory.getKalyptoConnectionMain();
			long t1 = System.nanoTime();
			statement = conn.prepareStatement(strQuery);
			resultset = statement.executeQuery();
			crs.populate(resultset);
			long t2 = System.nanoTime();
			log.info("Query Execution Time for [Query = " + strQuery + "] is : " + (t2 - t1 + "ms"));
		}
		catch (SQLException e)
		{
			log.error("SQLException in executeQuery(String strQuery)" + e.getMessage());
			throw e;
		}
		catch (Exception e)
		{
			log.error("Exception in executeQuery(String strQuery)" + e.getMessage());
			throw e;
		}
		finally
		{
			try
			{
				if (resultset != null)
				{
					resultset.close();
				}
				if (statement != null)
				{
					statement.close();
				}
				if (conn != null)
				{
					conn.close();

				}
			}
			catch (Exception se)
			{
				throw new Exception(se.getMessage());
			}
		}
		return crs;
	}
	
	public static SQLCachedRowSet executeQueryCibil(String strQuery,List parametervalues)
	throws Exception {
		SQLCachedRowSet crs;
		Connection conn = null;
		PreparedStatement statement = null;
		ResultSet resultset = null;
		
		try {
			strQuery = SQLParser.getSqlQuery(strQuery); 
			crs = SQLCachedRowSetFactory.getCachedRowSet();				
			conn = ConnectionFactory.getCibilConnection();
			StringTokenizer st=new StringTokenizer(strQuery,"#");
			if(st.hasMoreElements()){
				String strQueryCode=st.nextElement().toString().split("\\^")[0];
				strQuery=(String)st.nextElement();
			}
			statement = conn.prepareStatement(strQuery);
			statement.clearParameters();
			for(int i=0;i< parametervalues.size();i++){
				statement.setString(i+1, parametervalues.get(i).toString());
			}
			resultset = statement.executeQuery();			
			crs.populate(resultset);				
			
		} catch (SQLException e) {
			log.error("SQLException in executeQueryCibil(String strQuery)"
					+ e.getMessage());
			throw e;
		} catch (Exception e) {
			log.error("Exception in executeQueryCibil(String strQuery)" + e.getMessage());
			throw e;
		} finally {
			if (resultset != null) {
				resultset.close();
			}	
			if (statement != null) {
				statement.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
		return crs;
	}
	
	public static SQLCachedRowSet executeQueryCIBIL(String strQuery)
	throws Exception {
		SQLCachedRowSet crs;
		Connection conn = null;
		PreparedStatement statement = null;
		ResultSet resultset = null;
		String strQueryCode=null;
		try {
			crs = SQLCachedRowSetFactory.getCachedRowSet();
			StringTokenizer st=new StringTokenizer(strQuery,"#");
			if(st.hasMoreElements()){
				strQueryCode=st.nextElement().toString().split("\\^")[0];
				strQuery=(String)st.nextElement();
			}
			if(strQuery!=null && strQueryCode!=null){
				log.info("The Query Code===="+strQueryCode);
				log.info("hshDBS2Query.containsKey(strQueryCode)=="+hshDBS2Query.containsKey(strQueryCode));
				if(hshDBS2Query.containsKey(strQueryCode))
				{
					conn=ConnectionFactory.getDBS2Connection();
					log.info("query found for second server");
				}
				else
				{
					conn = ConnectionFactory.getCibilConnection();
					log.info("query found for first server");
				}
			}
			else {
				conn = ConnectionFactory.getCibilConnection();
				log.info("query found for first server");
			}
			if (statement!=null) 
				statement.close();
			statement = conn.prepareStatement(strQuery);
			resultset = statement.executeQuery();
			
			crs.populate(resultset);
			
			
		} catch (SQLException e) {
			log.error("SQLException in executeQueryCIBIL(String strQuery)"
					+ e.getMessage());
			throw e;
		} catch (Exception e) {
			log.error("Exception in executeQueryCIBIL(String strQuery)"
					+ e.getMessage());
			throw e;
		} finally {
			if (resultset != null) {
				resultset.close();
			}	
			if (statement != null) {
				statement.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
		return crs;
	}
	
	public static SQLCachedRowSet executeMonitoringQuery(String strQueryAndParam) throws Exception
	{
		SQLCachedRowSet crs;
		Connection conn = null;
		PreparedStatement statement = null;
		ResultSet resultset = null;
		ArrayList arrResult = null;
		String strQueryCode = null;
		try
		{
			crs = SQLCachedRowSetFactory.getCachedRowSet();
			arrResult = DBUtils.parseQuery(strQueryAndParam);
			String strQuery = "";
			ArrayList arrValues = new ArrayList();
			int intSize = arrResult != null ? arrResult.size() : 0;
			if (intSize > 0 && arrResult.get(0) instanceof String)
			{
				strQuery = (String) arrResult.get(0);
			}
			if (intSize > 1 && arrResult.get(1) instanceof ArrayList)
			{
				arrValues = (ArrayList) arrResult.get(1);
			}

			StringBuffer sbfQuery = new StringBuffer(strQuery);
			strQuery = Helper.replaceAll(strQuery, "'?'", "?", true);

			StringTokenizer st = new StringTokenizer(strQueryAndParam, "^");
			if (st.hasMoreElements())
			{
				strQueryCode = (String) st.nextElement();
			}

			conn = ConnectionFactory.getDBS2Connection();
			statement = conn.prepareStatement(strQuery);

			for (int i = 0; i < arrValues.size(); i++)
			{
				int intIndex = sbfQuery.toString().indexOf("?");
				if (intIndex != -1)
				{
					if (sbfQuery.charAt(intIndex - 1) == '\'' && sbfQuery.charAt(intIndex + 1) == '\'')
					{
						statement.setString(i + 1, (String) arrValues.get(i));
					} else
					{
						statement.setObject(i + 1, arrValues.get(i));
					}
					sbfQuery.deleteCharAt(intIndex);
				}

			}
			long t1 = System.nanoTime();
			resultset = statement.executeQuery();
			crs.populate(resultset);
			long t2 = System.nanoTime();
			log.info("Query Execution Time for [Query Code = " + strQueryCode + "] is : " + (t2 - t1 + " ns"));
		}
		catch (SQLException e)
		{
			log.error("SQLException in executeMonitoringQuery(String strQuery)" + e.getMessage());
			throw e;
		}
		catch (Exception e)
		{
			log.error("Exception in executeMonitoringQuery(String strQuery)" + e.getMessage());
			throw e;
		}
		finally
		{
			try
			{
				if (resultset != null)
				{
					resultset.close();
				}
				if (statement != null)
				{
					statement.close();
				}
				if (conn != null)
				{
					conn.close();
				}
			}
			catch (Exception e)
			{
				throw new Exception(e.getMessage());
			}
		}
		return crs;
	}
	public static SQLCachedRowSet executeLMSQuery(String strQuery,List parametervalues)
	throws Exception {
		SQLCachedRowSet crs;
		Connection conn = null;
		PreparedStatement statement = null;
		ResultSet resultset = null;
		
		try {
			strQuery = SQLParser.getSqlQuery(strQuery); 
			crs = SQLCachedRowSetFactory.getCachedRowSet();				
			conn = ConnectionFactory.getLMSConnection();
			StringTokenizer st=new StringTokenizer(strQuery,"#");
			if(st.hasMoreElements()){
				String strQueryCode=st.nextElement().toString().split("\\^")[0];
				strQuery=(String)st.nextElement();
			}
			statement = conn.prepareStatement(strQuery);
			statement.clearParameters();
			for(int i=0;i< parametervalues.size();i++){
				statement.setString(i+1, parametervalues.get(i).toString());
			}
			long t1 = System.currentTimeMillis();
			resultset = statement.executeQuery();	
			crs.populate(resultset);	
			long t2 = System.currentTimeMillis();
			log.info("Query Execution Time for [Query Code = " + strQuery + "] is : " + (t2 - t1 + "ms"));
			
		} catch (SQLException e) {
			log.error("SQLException in executeLMSQuery(String strQuery)"
					+ e.getMessage());
			throw e;
		} catch (Exception e) {
			log.error("Exception in executeLMSQuery(String strQuery)" + e.getMessage());
			throw e;
		} finally {
			if (resultset != null) {
				resultset.close();
			}	
			if (statement != null) {
				statement.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
		return crs;
	}
	public static SQLCachedRowSet executeUCICQuery(String strQuery) throws Exception
	{
		SQLCachedRowSet crs;
		Connection conn = null;
		PreparedStatement statement = null;
		ResultSet resultset = null;
		String strQueryCode = null;
		try
		{
			crs = SQLCachedRowSetFactory.getCachedRowSet();
			StringTokenizer st = new StringTokenizer(strQuery, "#");
			if (st.hasMoreElements())
			{
				strQueryCode = st.nextElement().toString().split("\\^")[0];
				strQuery = (String) st.nextElement();
			}
			conn = ConnectionFactory.getUCICConnection();
			statement = conn.prepareStatement(strQuery);
			long t1 = System.currentTimeMillis();
			resultset = statement.executeQuery();
			crs.populate(resultset);
			long t2 = System.currentTimeMillis();
			log.info("Query Execution Time for [Query Code = " + strQueryCode + "] is : " + (t2 - t1 + "ms"));
		}
		catch (SQLException e)
		{
			log.error("SQLException in executeUCICQuery(String strQuery)" + e.getMessage());
			throw e;
		}
		catch (Exception e)
		{
			log.error("Exception in executeUCICQuery(String strQuery)" + e.getMessage());
			throw e;
		}
		finally
		{
			try
			{
				if (resultset != null)
				{
					resultset.close();
				}
				if (statement != null)
				{
					statement.close();
				}
				if (conn != null)
				{
					conn.close();
				}
			}
			catch (Exception se)
			{
				throw new Exception(se.getMessage());
			}
		}
		return crs;
	}	
	
}