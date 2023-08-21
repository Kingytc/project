/*
 * Created on Jun 3, 2004
 *
 * 
 */
package com.sai.laps.helper;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.log4j.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

/**
 * @author rsadasivam
 * @Jun 3, 2004
 * @GlobalXMLLoader.java
 */
public class GlobalXMLLoader
{

	static Logger log = Logger.getLogger(GlobalXMLLoader.class);

	public static HashMap getApplicationProperties(String aPropertiesFilePath, String aPropertiesFileName) throws Exception
	{
		HashMap appProperties = new HashMap();
		try
		{
			StringBuffer strFileName = new StringBuffer();
			strFileName.append(aPropertiesFilePath + aPropertiesFileName);

			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			dbf.setValidating(false);
			dbf.setNamespaceAware(false);
			DocumentBuilder db = dbf.newDocumentBuilder();

			Document doc = db.parse(new FileInputStream(strFileName.toString()));
			NodeList propsList = doc.getElementsByTagName("PARAM");
			for (int i = 0; i < propsList.getLength(); i++)
			{
				Element paramId = (Element) propsList.item(i);
				appProperties.put(paramId.getAttribute("NAME"), paramId.getAttribute("VALUE"));
			}

		}
		catch (Exception e)
		{
			log.error("Exception in GlobalXMLLoader.getApplicationProperties()" + e.getMessage());
		}
		return appProperties;
	}

	public static HashMap loadPageAndServiceMappings() throws Exception
	{
		StringBuffer strFileName = new StringBuffer();
		HashMap mapPageBean = new HashMap();
		int jspcount = 0;
		try
		{

			String[] strSqlFile = (String[]) ApplicationParams.getJspMAPSFile().split(",");
			for (int j = 0; j < strSqlFile.length; j++)
			{
				strFileName = new StringBuffer();
				strFileName.append(ApplicationParams.getXMLFilePath() + strSqlFile[j]);

				DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
				dbf.setValidating(false);
				dbf.setNamespaceAware(false);
				DocumentBuilder db = dbf.newDocumentBuilder();

				Document doc = db.parse(new FileInputStream(strFileName.toString()));
				NodeList Maplist = doc.getElementsByTagName("MapJsp");
				jspcount = Maplist.getLength();
				for (int i = 0; i < jspcount; i++)
				{
					Element pageID = (Element) Maplist.item(i);
					String strPage = pageID.getAttribute("Page");
					String strBean = pageID.getAttribute("BeanId");
					String strPath = pageID.getAttribute("Path");
					String strPageId = pageID.getAttribute("PageId");
					if (strBean == null)
						strBean = " ";
					if (strPageId == null || strPageId.equalsIgnoreCase(""))
						strPageId = "~";
					mapPageBean.put(strPage, strPath + ":" + strPageId + ":" + strBean);
				}
				log.info("PAGE AND SERVICE-MAPPINGS LOADED... FROM  " + strFileName.toString() + " total jsp count === " + jspcount);
			}
		}
		catch (Exception e)
		{
			log.error("EXCEPTION IN LOADING PAGE AND SERVICE MAPPINGS..." + e.getMessage());
		}

		return mapPageBean;

	}

	public static HashMap loadBeanMetaData()
	{
		HashMap mapPageBean = new HashMap();
		StringBuffer strFileName = new StringBuffer();
		try
		{

			strFileName.append(ApplicationParams.getXMLFilePath() + ApplicationParams.getBeanMAPSFile());

			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			dbf.setValidating(false);
			dbf.setNamespaceAware(false);
			DocumentBuilder db = dbf.newDocumentBuilder();

			Document doc = db.parse(new java.io.FileInputStream(strFileName.toString()));
			NodeList Maplist = doc.getElementsByTagName("MapBean");
			for (int i = 0; i < Maplist.getLength(); i++)
			{
				Element pageID = (Element) Maplist.item(i);
				mapPageBean.put(pageID.getAttribute("PageID"), pageID.getAttribute("JNDIName"));
			}
			log.info("BEAN MAPPINGS LOADED...FROM  " + strFileName.toString() + "  FOR  " + Maplist.getLength());
		}
		catch (IOException ioe)
		{
			log.error("Bean Mappings COULD NOT BE LOADED..." + ioe.getMessage());
		}
		catch (Exception e)
		{
			log.error("Bean Mappings COULD NOT BE LOADED..." + e.getMessage());

		}
		return mapPageBean;
	}

	public static HashMap getPDFDetails(String aPropertiesFilePath, String aPropertiesFileName) throws Exception
	{
		HashMap PDFdetails = new HashMap();
		try
		{
			StringBuffer strFileName = new StringBuffer();
			strFileName.append(aPropertiesFilePath + aPropertiesFileName);

			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			dbf.setValidating(false);
			dbf.setNamespaceAware(false);
			DocumentBuilder db = dbf.newDocumentBuilder();

			Document doc = db.parse(new FileInputStream(strFileName.toString()));
			NodeList propsList = doc.getElementsByTagName("PDF");
			int count = 0;
			for (int i = 0; i < propsList.getLength(); i++)
			{
				++count;
				Element paramId = (Element) propsList.item(i);
				PDFdetails.put(paramId.getAttribute("FILENAME"), paramId.getAttribute("BEANID") + ":" + paramId.getAttribute("GETMETHOD"));

			}
			log.info("TOTAL PDF REPORT ENTRIES :" + count);

		}
		catch (Exception e)
		{
			log.error("Exception in GlobalXMLLoader.getPDFDetails()" + e.getMessage());
		}
		return PDFdetails;
	}

	public static HashMap loadSQLQueries()
	{
		Document doc = null;
		HashMap hshQuery = new HashMap();
		try
		{

			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			dbf.setValidating(false);
			dbf.setNamespaceAware(false);
			DocumentBuilder db = dbf.newDocumentBuilder();

			String[] strSqlFile = (String[]) ApplicationParams.getSQLQueryFile().split(",");
			for (int j = 0; j < strSqlFile.length; j++)
			{
				doc = db.parse(new java.io.FileInputStream(ApplicationParams.getXMLFilePath() + strSqlFile[j]));
				NodeList queryList = doc.getElementsByTagName("query");
				for (int i = 0; i < queryList.getLength(); i++)
				{
					Element query = (org.w3c.dom.Element) queryList.item(i);
					String strCode = query.getAttribute("code");
					String strQuery = query.getFirstChild().getNodeValue();
					hshQuery.put(strCode, strQuery);
				}

				log.info("SQL QUERIES LOADED FROM  " + strSqlFile[j] + " FILE for " + queryList.getLength());
			}
		}
		catch (Exception e)
		{
			log.error("SQL Query Mappings COULD NOT BE LOADED..." + e.getMessage());
		}
		return hshQuery;
	}

	public static HashMap loadCCPSSQLQueries()
	{
		Document doc = null;
		HashMap hshQuery = new HashMap();
		try
		{
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			dbf.setValidating(false);
			dbf.setNamespaceAware(false);
			DocumentBuilder db = dbf.newDocumentBuilder();

			doc = db.parse(new java.io.FileInputStream(ApplicationParams.getXMLFilePath() + ApplicationParams.getCCPSSQLQueryFile()));
			NodeList queryList = doc.getElementsByTagName("Query");

			for (int i = 0; i < queryList.getLength(); i++)
			{
				Element query = (org.w3c.dom.Element) queryList.item(i);
				String strCode = query.getAttribute("Code");
				String strQuery = query.getFirstChild().getNodeValue();
				hshQuery.put(strCode, strQuery);
			}
			log.info("CCPS SQL QUERIES LOADED FROM XML FILE for " + queryList.getLength());
		}
		catch (Exception e)
		{
			log.error("CCPS SQL Query Mappings COULD NOT BE LOADED... " + e.getMessage());
		}
		return hshQuery;

	}

	public static HashMap loadDBS2Queries()
	{
		Document doc = null;
		HashMap hshQuery = new HashMap();
		try
		{
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			dbf.setValidating(false);
			dbf.setNamespaceAware(false);
			DocumentBuilder db = dbf.newDocumentBuilder();

			String[] strSqlFile = (String[]) ApplicationParams.getStrSQLDBS2QUERYFILE().split(",");
			for (int j = 0; j < strSqlFile.length; j++)
			{
				doc = db.parse(new java.io.FileInputStream(ApplicationParams.getXMLFilePath() + strSqlFile[j]));
				NodeList queryList = doc.getElementsByTagName("query");
				for (int i = 0; i < queryList.getLength(); i++)
				{
					Element query = (org.w3c.dom.Element) queryList.item(i);
					String strCode = query.getAttribute("code");
					String strQuery = query.getFirstChild().getNodeValue();
					hshQuery.put(strCode, strQuery);
				}

				log.info("SQL QUERIES LOADED FROM  " + strSqlFile[j] + " FILE for " + queryList.getLength());
			}

		}
		catch (Exception e)
		{
			log.error("SQL Query Mappings COULD NOT BE LOADED..." + e.getMessage());
		}
		return hshQuery;
	}

	public static HashMap loadUPLSQLQueries()
	{
		Document doc = null;
		HashMap hshQuery = new HashMap();
		try
		{
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			dbf.setValidating(false);
			dbf.setNamespaceAware(false);
			DocumentBuilder db = dbf.newDocumentBuilder();

			String strSqlFile = "sqlcorpupload.xml";
			{
				doc = db.parse(new java.io.FileInputStream(ApplicationParams.getXMLFilePath() + strSqlFile));
				NodeList queryList = doc.getElementsByTagName("query");
				for (int i = 0; i < queryList.getLength(); i++)
				{
					Element query = (org.w3c.dom.Element) queryList.item(i);
					String strCode = query.getAttribute("code");
					String strQuery = query.getFirstChild().getNodeValue();
					hshQuery.put(strCode, strQuery);
				}

				log.info("SQL QUERIES LOADED FROM  " + strSqlFile + " FILE for " + queryList.getLength());
			}
		}
		catch (Exception e)
		{
			log.error("SQL Query Mappings COULD NOT BE LOADED..." + e.getMessage());
		}
		return hshQuery;
	}

	public static HashMap loadCBSSQLQueries()
	{
		Document doc = null;
		HashMap hshQuery = new HashMap();
		try
		{

			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			dbf.setValidating(false);
			dbf.setNamespaceAware(false);
			DocumentBuilder db = dbf.newDocumentBuilder();

			doc = db.parse(new java.io.FileInputStream(ApplicationParams.getXMLFilePath() + ApplicationParams.getCBSSQLQueryFile()));
			NodeList queryList = doc.getElementsByTagName("query");
			for (int i = 0; i < queryList.getLength(); i++)
			{
				Element query = (org.w3c.dom.Element) queryList.item(i);
				String strCode = query.getAttribute("code");
				String strQuery = query.getFirstChild().getNodeValue();
				hshQuery.put(strCode, strQuery);
			}
			log.info("CBS SQL QUERIES LOADED FROM XML FILE for " + queryList.getLength());
		}
		catch (Exception e)
		{
			log.error("CBSSQL Query Mappings COULD NOT BE LOADED... " + e.getMessage());
		}
		return hshQuery;
	}

}
