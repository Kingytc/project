package com.sai.laps.helper;

import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;

import org.apache.log4j.Logger;

public class SQLParser
{
	static Logger log = Logger.getLogger(SQLParser.class);
	private static HashMap hshQuery = new HashMap();
	private static HashMap hshCBSQuery = new HashMap();

	public static void buildDocument()
	{
		hshQuery = GlobalXMLLoader.loadSQLQueries();
		hshCBSQuery = GlobalXMLLoader.loadCBSSQLQueries();
	}

	public static String getSqlQuery(String strCode) throws Exception
	{
		String strQuery = "";

		ArrayList vecValues = new ArrayList();
		StringTokenizer st = new StringTokenizer(strCode, "^");
		StringBuffer sbfQuery;
		while (st.hasMoreElements())
		{
			vecValues.add(st.nextElement());
		}
		String strQcode = (String) vecValues.get(0);
		strQuery = (String) hshQuery.get(strQcode);
		if (strQuery == null)
		{
			throw new Exception("Query not found in xml file for given ID" + strCode);
		}

		sbfQuery = new StringBuffer(strQuery);
		for (int i = 1; i < vecValues.size(); i++)
		{
			int intIndex = sbfQuery.toString().indexOf("^");
			if (intIndex != -1)
			{
				sbfQuery.deleteCharAt(intIndex);
				sbfQuery.insert(intIndex, (String) vecValues.get(i));
			}
		}
		log.info("QUERY IN SQL PARSER... [Query Code : " + strCode + "]\n" + sbfQuery.toString());
		return strCode+"#"+sbfQuery.toString();
	}
	
	public static String getSqlLSRRQuery(String strCode) throws Exception
	{
		String strQuery = "";

		ArrayList vecValues = new ArrayList();
		StringTokenizer st = new StringTokenizer(strCode, "~");
		StringBuffer sbfQuery;
		while (st.hasMoreElements())
		{
			vecValues.add(st.nextElement());
		}
		String strQcode = (String) vecValues.get(0);
		strQuery = (String) hshQuery.get(strQcode);
		if (strQuery == null)
		{
			throw new Exception("Query not found in xml file for given ID" + strCode);
		}

		sbfQuery = new StringBuffer(strQuery);
		for (int i = 1; i < vecValues.size(); i++)
		{
			int intIndex = sbfQuery.toString().indexOf("~");
			if (intIndex != -1)
			{
				sbfQuery.deleteCharAt(intIndex);
				sbfQuery.insert(intIndex, (String) vecValues.get(i));
			}
		}
		log.info("QUERY IN SQL PARSER... [Query Code : " + strCode + "]\n" + sbfQuery.toString());
		return strCode+"#"+sbfQuery.toString();
	}

	public static String getSqlQueryByCode(String strCode) throws Exception
	{
		String strQuery = "";
		strQuery = (String) hshQuery.get(strCode);
		return strQuery;

	}

	public static String getCBSSqlQuery(String strCode) throws Exception
	{
		String strQuery = "";

		ArrayList vecValues = new ArrayList();
		StringTokenizer st = new StringTokenizer(strCode, "^");
		StringBuffer sbfQuery;
		while (st.hasMoreElements())
		{
			vecValues.add(st.nextElement());
		}
		String strQcode = (String) vecValues.get(0);
		strQuery = (String) hshCBSQuery.get(strQcode);
		if (strQuery == null)
		{
			throw new Exception("Query not found in cbs xml file for given ID" + strCode);
		}

		sbfQuery = new StringBuffer(strQuery);
		for (int i = 1; i < vecValues.size(); i++)
		{
			int intIndex = sbfQuery.toString().indexOf("^");
			if (intIndex != -1)
			{
				sbfQuery.deleteCharAt(intIndex);
				sbfQuery.insert(intIndex, (String) vecValues.get(i));
			}
		}
		log.info("CBS QUERY IN SQL PARSER... [Query Code : " + strCode + "]\n" + sbfQuery.toString());
		return sbfQuery.toString();

	}
	public static String getSqlQueryWithoutCode(String strCode) throws Exception
	{
		String strQuery = "";

		ArrayList vecValues = new ArrayList();
		StringTokenizer st = new StringTokenizer(strCode, "^");
		StringBuffer sbfQuery;
		while (st.hasMoreElements())
		{
			vecValues.add(st.nextElement());
		}
		String strQcode = (String) vecValues.get(0);
		strQuery = (String) hshQuery.get(strQcode);
		if (strQuery == null)
		{
			throw new Exception("Query not found in xml file for given ID" + strCode);
		}

		sbfQuery = new StringBuffer(strQuery);
		for (int i = 1; i < vecValues.size(); i++)
		{
			int intIndex = sbfQuery.toString().indexOf("^");
			if (intIndex != -1)
			{
				sbfQuery.deleteCharAt(intIndex);
				sbfQuery.insert(intIndex, (String) vecValues.get(i));
			}
		}
		log.info("QUERY IN SQL PARSER... [Query Code : " + strCode + "]\n" + sbfQuery.toString());
		return sbfQuery.toString();
	}

}
