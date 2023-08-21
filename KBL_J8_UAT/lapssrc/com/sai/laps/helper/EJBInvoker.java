package com.sai.laps.helper;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Properties;
import java.util.StringTokenizer;

import javax.ejb.CreateException;
import javax.ejb.HomeHandle;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.dataaccess.DataAccessBean;

public class EJBInvoker
{
	static Logger log = Logger.getLogger(EJBInvoker.class);
	private static HashMap homeCache = new HashMap(); 
	//private static HashMap remoteCache = new HashMap();

	public static Object executeStateLess(String strPageId) throws NamingException, Exception {
		Method homeObjMethod;
		Object retObj = null;
		javax.ejb.EJBObject beanHandle = null;
		try {
			Object homeObj = getHome(strPageId);
			Class homeClass = homeObj.getClass();
			Class[] homeObjParmTypes = {};
			Class[] homeObjArgList = {};
			homeObjMethod = homeClass.getMethod("create", homeObjParmTypes);
			beanHandle = (javax.ejb.EJBObject) homeObjMethod.invoke(homeObj,homeObjArgList);
			retObj = (Object) beanHandle;
			System.out.println("retObj ::::" + retObj);
		} catch (InvocationTargetException ite) {
			String strTG = ite.getTargetException().getMessage();
			//LogWriter.log(LAPSLogLevel.DEBUG,"ite... " + strTG);
			ite.printStackTrace();
			throw new Exception(strTG);
		} catch (Exception e) {
			//LogWriter.log(LAPSLogLevel.ERROR,"execption... " + e);
			e.printStackTrace();
			throw e;
			
		}
		return retObj;
	}

	/**
	 * *** Result Object that was returned by the Business Method that was
	 * invoked ****
	 */
	public static Object executeStateLess(String strPageId,HashMap hshParams, String strMethName) throws NamingException,Exception  {
		Method homeObjMethod;
		Object localBeanHandle = null;
		Object objRes = null;
		System.out.println("executeStateLess" + strPageId + "hshParams"+ hshParams + "strMethName" + strMethName);
		try {
			
			if (strPageId.trim().equalsIgnoreCase("dataaccess"))
			{
				DataAccess dataAccess = new DataAccess();
				if (strMethName.trim().equalsIgnoreCase("updateData"))
				{
					dataAccess.updateData(hshParams);
				} else if (strMethName.trim().equalsIgnoreCase("updateBatchData"))
				{ 
					dataAccess.updateBatchData(hshParams);
				} else if (strMethName.trim().equalsIgnoreCase("updateInternetData"))
				{
					dataAccess.updateInternetData(hshParams);
				} else if (strMethName.trim().equalsIgnoreCase("updateCBSData"))
				{
					dataAccess.updateCBSData(hshParams);
				} else if (strMethName.trim().equalsIgnoreCase("updateKalyptoData"))
				{
					dataAccess.updateKalyptoData(hshParams);
				}
				 else if (strMethName.trim().equalsIgnoreCase("updateMonitoringData"))
					{
						dataAccess.updateMonitoringData(hshParams);
					}
			
			}
			else{
			Object homeObj = getHome(strPageId);
			System.out.println("homeObj to print"+homeObj);
			Class homeClass = homeObj.getClass();
			Class[] homeObjParmTypes = {};
			Class[] homeObjArgList = {};
			//homeObjMethod = homeClass.getMethod("create", homeObjParmTypes);
			//localBeanHandle = (Object) homeObjMethod.invoke(homeObj, homeObjArgList);
			//Class beanClass = localBeanHandle.getClass();
			Class busObjParmTypes = java.util.HashMap.class ;
			HashMap busObjArgList =  hshParams ;
			Method busMethod = homeClass.getMethod(strMethName, busObjParmTypes);
		//	busMethod.invoke(homeObj, busObjArgList);
			objRes = (Object) busMethod.invoke(homeObj, busObjArgList);
			}

		} catch (NoSuchMethodException nsme) {
			nsme.printStackTrace();
			throw new Exception(nsme.getMessage());
		} catch (InvocationTargetException ite) {
			ite.printStackTrace();
			String strTG = ite.getMessage();
			throw new Exception(strTG);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Exception occured in LAPS executeStateLess executeStateLess "+ e.getMessage());
			throw e;
		}
		return objRes;
	}

	/**
	 * *** Result Object that was returned by the Business Method that was
	 * invoked ****
	 */
	// Used only for data modification calls// Created & modified BY Ram
	public static Object executeStateLess(HashMap hshPresMap,
			String strPageId, HashMap hshParams, String strMethName)
			throws NamingException, Exception {
		Object objRes = null;
		//DataPersister dataP = null;
		Method homeObjMethod;
		Object localBeanHandle = null;

		try {
			System.out.println("******************************************************");
			System.out.println("INVOKING THE DATA PERSISTER FROM EJBINVOKER");
			System.out.println("******************************************************");
			if (hshPresMap != null) {
				hshParams.put("PRESENTATION_DATA_MAP", hshPresMap);
			}
			//dataP = new DataPersister();
			//dataP.persistData(hshParams);
			Object homeObj = getHome(strPageId);
			Class homeClass = homeObj.getClass();
			Class[] homeObjParmTypes = {};
			Class[] homeObjArgList = {};
			homeObjMethod = homeClass.getMethod("create", homeObjParmTypes);
			localBeanHandle = (javax.ejb.EJBObject) homeObjMethod.invoke(
					homeObj, homeObjArgList);
			Class beanClass = localBeanHandle.getClass();
			Class[] busObjParmTypes = { java.util.HashMap.class };
			HashMap[] busObjArgList = { hshParams };
			Method busMethod = beanClass
					.getMethod(strMethName, busObjParmTypes);
			objRes = (Object) busMethod.invoke(localBeanHandle, busObjArgList);
			System.out.println("END OF PROCESS IN THE DATA PERSISTER FROM EJBINVOKER");
			System.out.println("******************************************************");
		} catch (NoSuchMethodException nsme) {
			nsme.printStackTrace();
			throw new Exception(nsme.getMessage());
		} catch (InvocationTargetException ite) {
			ite.printStackTrace();
			String strTG = ite.getTargetException().getMessage();
			throw new Exception(strTG);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return objRes;
	}

	/** **************Execute*********** */
	public static Object executeStateLess(String strPageId, String strMethName)
			throws NamingException, Exception {
		Method homeObjMethod;
		Object localBeanHandle = null;
		Object objRes = null;
		try {
			Object homeObj = getHome(strPageId);
			Class homeClass = homeObj.getClass();
			Class[] homeObjParmTypes = {};
			Class[] homeObjArgList = {};
			homeObjMethod = homeClass.getMethod("create", homeObjParmTypes);
			localBeanHandle = (javax.ejb.EJBObject) homeObjMethod.invoke(
					homeObj, homeObjArgList);
			Class beanClass = localBeanHandle.getClass();
			Class[] busObjParmTypes = {};
			HashMap[] busObjArgList = {};
			Method busMethod = beanClass
					.getMethod(strMethName, busObjParmTypes);
			objRes = (Object) busMethod.invoke(localBeanHandle, busObjArgList);
			System.out.println("objRes ::::" + objRes);
		} catch (NoSuchMethodException nsme) {
			nsme.printStackTrace();
			StringBuffer sbfException = new StringBuffer();
			sbfException.append("$0$Specified Business Method ");
			sbfException.append("Not available in Remote Object$");
			throw new Exception(nsme.getMessage());
		} catch (InvocationTargetException ite) {
			ite.printStackTrace();
			String strTG = ite.getTargetException().getMessage();
			System.out.println("excepiton222... " + strTG);
			throw new Exception(strTG);
		} catch (Exception e) {
			System.out.println("excepion2343... " + e);
			e.printStackTrace();
			throw e;
		}
		return objRes;
	}

	/** * */
	/** *********** Insert Method For Entity bean ************ */
	public static void ExecuteEntity(String strPageId, HashMap hshParams)
			throws NamingException, Exception {
		Method homeobjmethod = null;
		javax.ejb.EJBObject beanHandle = null;
		try {
			Object homeObj = getHome(strPageId);
			Class homeClass = homeObj.getClass();
			Class[] homeObjParmTypes = { java.util.HashMap.class };
			HashMap[] homeObjArgList = { hshParams };
			homeobjmethod = homeClass.getDeclaredMethod("create",
					homeObjParmTypes);
			beanHandle = (javax.ejb.EJBObject) homeobjmethod.invoke(homeObj,
					homeObjArgList);
		} catch (InvocationTargetException ite) {
			ite.printStackTrace();
			String strTG = ite.getTargetException().getMessage();
			throw new Exception(strTG);
		} catch (CreateException ce) {
			ce.printStackTrace();
			throw new Exception(ce.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/** * Getting Home Object**** */
	private static Object getHome(String strPageID) throws Exception {
		HomeHandle homeObj = null;
		try {
			Properties prop = new Properties();
			String strJNDIName = EJBMapper.getLookUp(strPageID);
			if (homeCache.containsKey(strJNDIName)) {
				System.out.println("from home cache..");
				return (Object) homeCache.get(strJNDIName);
			} else {
				prop.put(Context.INITIAL_CONTEXT_FACTORY, ApplicationParams.getInitialContext());
				prop.put(Context.PROVIDER_URL, ApplicationParams.getProviderUrl());
				InitialContext ctx = new InitialContext(prop);
				Object ref = null;
				/*try
				{
				 ref = ctx.lookup("ejb/KBL_jdk/lapsEJB.jar/AuthenticateBean#com.sai.laps.ejb.authenticate.AuthenticateRemote");
				System.out.println("ref====1111111111111111111111111====="+ref);
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
				try
				{
				 ref = ctx.lookup("java:global/KBL_jdk/lapsEJB/AuthenticateBean!com.sai.laps.ejb.authenticate.AuthenticateRemote");
				System.out.println("ref====2222222222222222222222222222222====="+ref);
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}*/
				try
				{
				 ref = ctx.lookup(strJNDIName);
				System.out.println("ref===strJNDIName======"+ref);
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
				 
				//homeObj = ((javax.ejb.EJBHome) ctx.lookup(strJNDIName)).getHomeHandle();
				homeCache.put(strJNDIName, ref);
				
				
				return ref;
			}
		} catch (NamingException ne) {
			ne.printStackTrace();
		//	Logger.log("EJB3==================================== Initilizsation Step Failure"+ne.toString());
			System.out.println("Unable to Get NamingException :" + ne);
			throw new Exception(ne.getMessage());
		} catch (Exception e) {
			//Logger.log("EJB3==================================== Initilizsation Step Failure"+e.toString());
			System.out.println("Unable to Get LookUp Exception:" + e);
			e.printStackTrace();
			throw e;
		}
	}
	
	
} //End of EJBInvoker Class
