package com.sai.laps.helper;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import com.sai.laps.helper.SAILogger;

import org.apache.log4j.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
public class SQLDuplicateparser {
	
	static Logger log=Logger.getLogger(SQLDuplicateparser.class);
	public static HashMap loadSQLQueries() {
		Document doc = null;
		HashMap hshQuery = new HashMap();
		ArrayList arrylistoriginal = new ArrayList();
		ArrayList arrylistduplicate = new ArrayList();
		String strDuplicatelist="";
		boolean flag=true;
		try {

			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			dbf.setValidating(false);
			dbf.setNamespaceAware(false);
			DocumentBuilder db = dbf.newDocumentBuilder();
			String[] strSqlFile = (String[])ApplicationParams.getSQLQueryFile().split(",");
			for(int k=0;k<strSqlFile.length;k++)
			{
				doc =db.parse(new java.io.FileInputStream(ApplicationParams.getXMLFilePath()+ strSqlFile[k]));
				NodeList queryList = doc.getElementsByTagName("query");
				for(int i=0;i<queryList.getLength();i++)
				{
					Element query= (org.w3c.dom.Element)queryList.item(i);
					String strCode=query.getAttribute("code");
					if(arrylistoriginal!=null && arrylistoriginal.size()>0)
					{
						for(int j=0;j<arrylistoriginal.size();j++)
						{
							if(strCode.equals((String)arrylistoriginal.get(j)))
							{
								flag=false;
								break;
							}
						}
						if(flag)
						{
							arrylistoriginal.add(strCode);
							flag=true;
						}
						else
						{
							arrylistduplicate.add(strCode);
							strDuplicatelist=strDuplicatelist+"\n"+strCode;
							flag=true;
						}
					}
					else
					{
						arrylistoriginal.add(strCode);
						flag=true;
					}
				}	
			}
			hshQuery.put("arrylistduplicate",arrylistduplicate);
			hshQuery.put("arrylistoriginal",arrylistoriginal);
			hshQuery.put("strDuplicatelist",strDuplicatelist);
			
		} catch (Exception e) {
			log.error("SQL Query Mappings COULD NOT BE LOADED..."+e.getMessage());
		}
		return hshQuery;
	}
	
	public static HashMap loadPageAndServiceMappings() {
		Document doc = null;
		HashMap hshQuery = new HashMap();
		ArrayList arrylistoriginal = new ArrayList();
		ArrayList arrylistduplicate = new ArrayList();
		String strDuplicatelist="";
		boolean flag=true;
		try {

			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			dbf.setValidating(false);
			dbf.setNamespaceAware(false);
			DocumentBuilder db = dbf.newDocumentBuilder();
			String[] strJspMAPSFile = (String[])ApplicationParams.getJspMAPSFile().split(",");
			for(int k=0;k<strJspMAPSFile.length;k++)
			{
				doc =db.parse(new java.io.FileInputStream(ApplicationParams.getXMLFilePath()+ strJspMAPSFile[k]));
				NodeList Maplist = doc.getElementsByTagName("MapJsp");
				for(int i=0;i<Maplist.getLength();i++)
				{
					Element pageID = (Element) Maplist.item(i);
					String strPage = pageID.getAttribute("Page");
					if(arrylistoriginal!=null && arrylistoriginal.size()>0)
					{
						for(int j=0;j<arrylistoriginal.size();j++)
						{
							if(strPage.equals((String)arrylistoriginal.get(j)))
							{
								flag=false;
								break;
							}
						}
						if(flag)
						{
							arrylistoriginal.add(strPage);
							flag=true;
						}
						else
						{
							arrylistduplicate.add(strPage);
							strDuplicatelist=strDuplicatelist+"\n"+strPage;
							flag=true;
						}
					}
					else
					{
						arrylistoriginal.add(strPage);
						flag=true;
					}
				}	
			}
			hshQuery.put("arrylistduplicate",arrylistduplicate);
			hshQuery.put("arrylistoriginal",arrylistoriginal);
			hshQuery.put("strDuplicatelist",strDuplicatelist);
			
		} catch (Exception e) {
			log.error("SQL Query Mappings COULD NOT BE LOADED..."+e.getMessage());
		}
		return hshQuery;
	}
	
	
	public static HashMap loadBeanMetaData() {
		Document doc = null;
		HashMap mapPageBean = new HashMap();
		ArrayList arrylistoriginal = new ArrayList();
		ArrayList arrylistduplicate = new ArrayList();
		StringBuffer strFileName = new StringBuffer();
		String strDuplicatelist="";
		boolean flag=true;
		try {

			strFileName.append(
				ApplicationParams.getXMLFilePath()
					+ ApplicationParams.getBeanMAPSFile());

			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			dbf.setValidating(false);
			dbf.setNamespaceAware(false);
			DocumentBuilder db = dbf.newDocumentBuilder();
			
			String[] strJspMAPSFile = (String[])ApplicationParams.getJspMAPSFile().split(",");
			for(int k=0;k<strJspMAPSFile.length;k++)
			{
				doc =db.parse(new java.io.FileInputStream(ApplicationParams.getXMLFilePath()+ strJspMAPSFile[k]));
				NodeList Maplist = doc.getElementsByTagName("MapBean");
			
				for(int i=0;i<Maplist.getLength();i++)
				{
					Element pageID = (Element) Maplist.item(i);
					String strPage = pageID.getAttribute("Page");
					if(arrylistoriginal!=null && arrylistoriginal.size()>0)
					{
						for(int j=0;j<arrylistoriginal.size();j++)
						{
							if(strPage.equals((String)arrylistoriginal.get(j)))
							{
								flag=false;
								break;
							}
						}
						if(flag)
						{
							arrylistoriginal.add(strPage);
							flag=true;
						}
						else
						{
							arrylistduplicate.add(strPage);
							strDuplicatelist=strDuplicatelist+"\n"+strPage;
							flag=true;
						}
					}
					else
					{
						arrylistoriginal.add(strPage);
						flag=true;
					}
				}	
			}
			mapPageBean.put("arrylistduplicate",arrylistduplicate);
			mapPageBean.put("arrylistoriginal",arrylistoriginal);
			mapPageBean.put("strDuplicatelist",strDuplicatelist);
		} catch (IOException ioe) {
			log.error("Bean Mappings COULD NOT BE LOADED..."+ioe.getMessage());			
		} catch (Exception e) {
			log.error("Bean Mappings COULD NOT BE LOADED..."+e.getMessage());			

		}
		return mapPageBean;
	}
	
	public static HashMap loadEJBData() {
		HashMap mapPageBean = new HashMap();
		String strlist="";
		//String strBeans="";
		String strNotBeans="";
		ArrayList arrylistoriginal = new ArrayList();
		ArrayList arrylistduplicate = new ArrayList();
		String strDuplicatelist="";
		boolean flag=true;
		StringBuffer strFileName = new StringBuffer();
		try {

			strFileName.append(ApplicationParams.getFtpPath()+"\\lapssrc\\META-INF\\ejb-jar2.xml");
			HashMap hshBeans=new HashMap();
			hshBeans = GlobalXMLLoader.loadBeanMetaData();
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			dbf.setValidating(false);
			dbf.setNamespaceAware(false);
			DocumentBuilder db = dbf.newDocumentBuilder();

			Document doc =db.parse(new java.io.FileInputStream(strFileName.toString()));
			NodeList Maplist = doc.getElementsByTagName("session");
			for (int i = 0; i < Maplist.getLength(); i++) {
				Element pageID = (Element) Maplist.item(i);
					//arrylistoriginal.add();
					strlist=pageID.getElementsByTagName("ejb-name").item(0).getFirstChild().getNodeValue();
					if(hshBeans.containsValue(strlist))
					{
						if(arrylistoriginal!=null && arrylistoriginal.size()>0)
						{
							for(int j=0;j<arrylistoriginal.size();j++)
							{
								if(strlist.equals((String)arrylistoriginal.get(j)))
								{
									flag=false;
									break;
								}
							}
							if(flag)
							{
								arrylistoriginal.add(strlist);
								flag=true;
							}
							else
							{
								arrylistduplicate.add(strlist);
								strDuplicatelist=strDuplicatelist+"\n"+strlist;
								flag=true;
							}
						}
						else
						{
							arrylistoriginal.add(strlist);
							flag=true;
						}
					}
					else
					{
						strNotBeans=strNotBeans+strlist+"\n";
					}
					
			}
			mapPageBean.put("strDuplicatelist",strDuplicatelist);
		} catch (IOException ioe) {
			log.error("Bean Mappings COULD NOT BE LOADED..."+ioe.getMessage());			
		} catch (Exception e) {
			log.error("Bean Mappings COULD NOT BE LOADED..."+e.getMessage());			

		}
		return mapPageBean;
	}
	
	
}