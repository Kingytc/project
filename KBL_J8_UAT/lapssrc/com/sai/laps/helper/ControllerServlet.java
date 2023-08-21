package com.sai.laps.helper;

import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import javax.ejb.EJBException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javazoom.upload.MultipartFormDataRequest;

import org.apache.log4j.Logger;
import org.apache.log4j.MDC;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.sai.fw.context.ApplicationContext;
import com.sai.fw.management.log.LogWriter;
import com.sai.fw.management.utils.FwHelper;
import com.sai.laps.ejb.setusers.SetUsersBean;
import com.sai.laps.helper.filemonitor.LAPSDirectoryFileMonitor;
import com.sai.laps.logging.LoggerInit;

public class ControllerServlet extends HttpServlet
{
	static Logger log = Logger.getLogger(ControllerServlet.class);
	public static final long serialVersionUID = 1L;
	public static HashMap mapPageBean = new HashMap();
	public static HashMap mapPDF = new HashMap();
	private ServletContext application;
	public static HashMap mapSessionId = new HashMap();
	private HSSFWorkbook workbook = null;
	private XSSFWorkbook xwb = null;

	public void init(ServletConfig config) throws ServletException
	{
		application = config.getServletContext();

		try
		{
			log.info("ControllerServlet.init(ServletConfig) >>>");
			String propsFileName = application.getInitParameter("PROPERTIESFILENAME");
			String appHome = getEnvironment("APPHOME");
			String lapsHome = application.getInitParameter("LAPSHOME");
			String lapsConfigHome = application.getInitParameter("LAPSCONFIG");
			String lapsPDF = application.getInitParameter("PDFFILENAME");
			String lapsHomePath = appHome + File.separatorChar + lapsHome;
			String propsFilePath = lapsHomePath + File.separatorChar + lapsConfigHome + File.separatorChar;

			LoggerInit loggerBootstrap = new LoggerInit();
			loggerBootstrap.initlize(propsFilePath + "log4j.xml"); // Initiate log4j properties - Jenesh

			HashMap appProperties = GlobalXMLLoader.getApplicationProperties(propsFilePath, propsFileName);
			ApplicationParams.initializeProperties(appProperties, appHome, lapsHome, lapsHomePath, propsFilePath, File.separatorChar);
			ApplicationContext.setHomeLogoRealPath(application.getRealPath("/img/ubibilinguallogo.jpg"));

			mapPageBean = GlobalXMLLoader.loadPageAndServiceMappings();
			mapPDF = GlobalXMLLoader.getPDFDetails(propsFilePath, lapsPDF);
			EJBMapper.initLookUp();
			SQLParser.buildDocument();

			if (Helper.correctNull(ApplicationParams.getFileListener()).equalsIgnoreCase("ON"))
			{
				new LAPSDirectoryFileMonitor().startMonitor(propsFilePath, 5);
			}
			DataAccess.buildDBS2QueriesDocument();// this line is called to store the second database server table queries in the dataaccess class
			DBUtils.buildDBS2QueriesDocument();// this line is called to store the second database server table queries in the dbutils class
			RefTableManager.initializeRefTableManager();
			log.info("ControllerServlet.init(ServletConfig) <<<");
			SCHEDULER s1=new SCHEDULER();
			//s1.startLAPSScheduler();
			//SCHEDULARNSDLRESPONSE s2=new SCHEDULARNSDLRESPONSE();
			//s2.startLAPSScheduler();
			//SMSSCHEDULER s3=new SMSSCHEDULER();
			//s3.startSMSScheduler();
			if(FwHelper.correctNull((String)ApplicationParams.getSCHSECURITYFLAG()).equalsIgnoreCase("TRUE"))
			{
			SMSSCHEDULERFORSECURITY s4=new SMSSCHEDULERFORSECURITY();
			s4.startSMSScheduler();
			}
						
		}
		catch (Exception e)
		{
			log.error("APPLICATION INITIALIZATION ERROR..." + e.toString());
		}
	}

	public void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response)
			throws javax.servlet.ServletException, java.io.IOException
	{

	}

	/**
	 * Process incoming HTTP POST requests
	 * 
	 * @param request
	 *            Object that encapsulates the request to the servlet
	 * @param response
	 *            Object that encapsulates the response from the servlet
	 */
	public void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response)
			throws javax.servlet.ServletException, java.io.IOException
	{

	}

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		/**
		 * This section is used for logging patters in log4j.xml - Jenesh 21-08-2014
		 */
		{
			MDC.put("RemoteAddress", request.getRemoteAddr());
			MDC.put("ActiveSessions", String.valueOf(mapSessionId.size()));
		}

		String strUrl = request.getRequestURI();
		String strClientIP = request.getRemoteAddr();
		String strServerIP = request.getLocalAddr();
		int intServerPort = request.getLocalPort();
		String strPage = strUrl.substring(strUrl.lastIndexOf("/") + 1, strUrl.length());
		String strType = Helper.correctNull((String) request.getParameter("hidFileType"));
		String strBeanId = Helper.correctNull((String) request.getParameter("hidBeanId"));
		String strPath = null;
		String strBeanMethod = Helper.correctNull((String) request.getParameter("hidBeanMethod"));
		String strBeanGetMethod = Helper.correctNull((String) request.getParameter("hidBeanGetMethod"));
		String strSourceUrl = Helper.correctNull((String) request.getParameter("hidSourceUrl"));
		String loggedUser = (String) (null != request.getSession() ? request.getSession().getAttribute("strUserId") : "No User Login");
		String strPageId = null;
		HashMap hshValues = new HashMap();
		HashMap filehash = new HashMap();
		Object objValues = new Object();

		log.warn(" RequestParms [ Requested Url : " + strUrl + ", BeanId : " + strBeanId + ", sourceUrl : " + strSourceUrl + ", BeanMethod : "
				+ strBeanMethod + ", BeanGetMethod : " + strBeanGetMethod + ", Remote Host : " + request.getRemoteHost() + ", Remote User : "
				+ loggedUser + " ]");
		try
		{
//			HttpSession session = request.getSession(false);
//			response.addHeader("P3P","CP=\"IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT\"");
//			response.setHeader("Cache-Control", "no-cache, no-store"); // HTTP 1.1.
//		    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
//		    response.setHeader("Expires", "0");
		    
//			response.setHeader("Set-Cookie","JSESSIONID="+session.getId()+";HttpOnly;Path=/laps;SameSite=Strict;Secure;");
		    
//			request.setAttribute("_cache_refresh", "true");
			/*response.addHeader("X-Frame-Options", "SAMEORIGIN");
		    response.addHeader("Content-Security-Policy", "frame-ancestors 'self';");
		    response.setHeader("Strict-Transport-Security","max-age=31536000;includeSubdomains"); 
		    response.setHeader("X-XSS-Protection", "1; mode=block");
		    response.addHeader("X-Content-Type-Option", "nosniff");
		    response.addHeader("X-UA-Compatible","IE=EmulateIE8");*/
		    
		    
		    
		    response.setHeader("Expires", "0");
			response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
			response.setHeader("Cache-Control", "cache");  
			response.setHeader("Pragma", "cache");  
			//Added keerthi
			response.setHeader("Strict-Transport-Security","max-age=31536000;includeSubdomains");
			response.addHeader("X-XSS-Protection", "1; mode=block");
			response.addHeader("X-Content-Type-Option", "nosniff");
			
		    
			String strSelfSAC=Helper.correctNull((String)request.getParameter("strSelfSAC"));
			
			if(strSelfSAC.equalsIgnoreCase("Y"))
			{
				request.removeAttribute("strSelfSAC");
				SetUsersBean setUserClass = new SetUsersBean();
				
				HashMap hshVal=new HashMap();
				hshVal.put("strUserID",Helper.correctNull((String)request.getParameter("USERID")));
				hshVal.put("hidAction","Invoke");
				hshVal.put("strServerIP",strServerIP);
				
				String strResponse = setUserClass.doSelfSACMethod(hshVal);
				strUrl = strPage = "/jsp/share/login.jsp";
				request.getRequestDispatcher(strUrl).forward(request, response);
				return;
			}
			else if(Helper.correctNull((String)request.getParameter("SACMETHOD")).equalsIgnoreCase("UnLockUsers"))
			{
				SetUsersBean setUserClass = new SetUsersBean();
				
				HashMap hshVal=new HashMap();
				hshVal.put("strUserID",Helper.correctNull((String)request.getParameter("UserID")));
				hshVal.put("hidAction","Purge");
				
				String strResponse = setUserClass.doSelfSACMethod(hshVal);
				
				byte[] strbyte=strResponse.getBytes();
				ByteArrayOutputStream bytstream=new ByteArrayOutputStream();
				bytstream.write(strbyte);
				ServletOutputStream str=  response.getOutputStream();
				bytstream.writeTo(str);
				str.flush();
				return;
			}
			
			
			System.out.println("strPage======================="+strPage);
			if (strPage.endsWith(".gif") || strPage.endsWith(".css") || strPage.endsWith(".jpg"))
			{
				return;
			}
			HashMap hshRequestValues = getRequestValues(request);
			hshRequestValues.put("strClientIP", strClientIP);
			hshRequestValues.put("strServerIP", strServerIP);
			hshRequestValues.put("strServerPort", String.valueOf(intServerPort));

			if (strPage.equals("hidlogin.jsp"))
			{
				try
				{
					String userId = Helper.correctNull((String) request.getParameter("txtusr_id")).toUpperCase();
					if (mapSessionId.get(userId) != null && mapSessionId.get(userId) instanceof HttpSession)
					{
						HttpSession session = (HttpSession) mapSessionId.get(userId);
						String temp1 = session.getId();

						HttpSession session1 = request.getSession(false);
						String temp2 = session1.getId();

						if (temp2 != null && !temp1.equals(temp2))
						{
							if (userId.equals(Helper.correctNull((String) session.getAttribute("strUserId")).toUpperCase()))
							{
								mapSessionId.remove(userId);
								session.invalidate();
							}
						}
					}
				}
				catch (Exception e)
				{
					log.error(e.getMessage());
				}
			}
			else if(strPage.equals("frame.jsp"))
			{
				HttpSession session = request.getSession(false);
				System.out.println("session===1===>"+session.getAttributeNames().toString());
				String strUserID=Helper.correctNull((String)session.getAttribute("strUserId"));
				System.out.println("strUserID===1===>"+Helper.correctNull((String)session.getAttribute("strUserId")));
				if (mapSessionId.containsKey(strUserID))
				{
					System.out.println("mapSessionId===if===>"+Helper.correctNull((String)session.getAttribute("strUserId")));
					mapSessionId.remove(strUserID);
					session.invalidate();
					System.out.println("mapSessionId===down===>"+Helper.correctNull((String)session.getAttribute("strUserId")));
					
				}
				else
				{
					mapSessionId.put(strUserID, session);
					System.out.println("mapSessionId=else==strUserID===>"+strUserID);
					System.out.println("session===else===>"+session.getAttributeNames().toString());
				}
			}

			if (!(strPage.equals("login.jsp") || strPage.equals("hidlogin.jsp") || strPage.equals("purgeuser.jsp")
					|| strPage.equals("changepassword.jsp") || strPage.equals("commonlogin.jsp") || strPage.equals("singlelogin.jsp")))
			{
				HttpSession session = request.getSession(false);

				HttpSession session1 = (HttpSession) mapSessionId.get(loggedUser);
				if (session1==null) {
					//To Remove entry from available_users table.
					System.out.println("====session1=======:"+session1);
					mapSessionId.remove(Helper.correctNull((String)hshRequestValues.get("hidusr_id")));
					
					System.out.println("====Helper.correctNull((String)hshRequestValues.get(hidusr_id))=======:"+Helper.correctNull((String)hshRequestValues.get("hidusr_id")));
					
					HashMap hsh=new HashMap();
					
					hsh.put("hidPage", "Navigation");
					hsh.put("val", "exit");
					hsh.put("hidusr_id", Helper.correctNull((String)hshRequestValues.get("hidusr_id")));
					
					System.out.println("====hsh=======:"+hsh);
					
					
					objValues = EJBInvoker.executeStateLess("authenticate", hsh, "getData");
					
					strUrl = strPage = "/jsp/share/rdLogin.jsp";
					request.getRequestDispatcher(strUrl).forward(request, response);
					return;
				}
				System.out.println("====session=======:"+session);
				System.out.println("====session.getAttribute(strUserId)=======:"+session.getAttribute("strUserId"));
				if (session == null || session.getAttribute("strUserId") == null)
				{
					System.out.println("====session== if=====:"+session);
					System.out.println("====session.getAttribute(strUserId)====if===:"+session.getAttribute("strUserId"));
					
					strUrl = strPage = "/jsp/share/rdLogin.jsp";
					request.getRequestDispatcher(strUrl).forward(request, response);
					return;
				} else
				{
					
				/*	System.out.println("====session== else=====:"+session);
					System.out.println("====session.getAttribute(strUserId)====else===:"+session.getAttribute("strUserId"));
					
					
					session = request.getSession(false);
					mapSessionId.put(Helper.correctNull((String) session.getAttribute("strUserId")).toUpperCase(), session);*/
				}
			}
			if (strPage.endsWith(".jsp") && strType.length()==0)
			{
				StringTokenizer st = new StringTokenizer((String) mapPageBean.get(strPage), ":");
				strPath = (String) st.nextElement();
				strPageId = Helper.correctNull((String) st.nextElement());
				if (strPageId.equals("~"))
				{
					strPageId = "";
				}
				if (st.hasMoreElements())
				{
					strBeanId = (String) st.nextElement();
				} else if (strBeanId == null)
				{
					strBeanId = "";
				}
				if (strBeanGetMethod == null || strBeanGetMethod.trim().equals(""))
				{
					strBeanGetMethod = "getData";
				}
				strUrl = strPath + strPage;
				if (strBeanId != null && (strBeanId.length()>0))
				{
					//hshRequestValues.put("mapSessionId", mapSessionId);
					hshValues = (HashMap) EJBInvoker.executeStateLess(strBeanId, hshRequestValues, strBeanGetMethod);
				}
			}
			// For RBI Defaulter list
			else if (strType != null && strType.equalsIgnoreCase("MULTIPART") && (strPage.toLowerCase().endsWith(".jsp")))
			{
				log.info("Processing Multipart File ...");
				if (MultipartFormDataRequest.isMultipartFormData(request))
				{
					MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
					if (RemoteFileReader.readClientFile(mrequest, hshRequestValues))
					{
						StringTokenizer st = new StringTokenizer((String) mapPageBean.get(strPage), ":");
						strPath = (String) st.nextElement();
						strPageId = Helper.correctNull((String) st.nextElement());
						if (strPageId.equals("~"))
						{
							strPageId = "";
						}
						if (st.hasMoreElements())
						{
							strBeanId = (String) st.nextElement();
						} else if (strBeanId == null)
						{
							strBeanId = "";
						}
						if (strBeanGetMethod == null || strBeanGetMethod.trim().equals(""))
						{
							strBeanGetMethod = "getData";
						}
						strUrl = strPath + strPage;
						if (strBeanId != null && (!strBeanId.trim().equals("")))
						{
							hshValues = (HashMap) EJBInvoker.executeStateLess(strBeanId, hshRequestValues, strBeanGetMethod);
						}
					} else
					{
						throw new Exception("$Problem in executing Multipart File:");
					}
				}
			} else if (strPage.toLowerCase().endsWith(".xls")||strPage.toLowerCase().endsWith(".xlsx"))
			{
				log.info("Processing Excel File ...");
				if (strBeanGetMethod == null || strBeanGetMethod.trim().equals("")) 
				{
					strBeanGetMethod = "getData";
				}
				try
				{
					hshValues = (HashMap) EJBInvoker.executeStateLess(strBeanId, hshRequestValues, strBeanGetMethod);
					String strFinancialDn=Helper.correctNull((String)hshValues.get("strFinancialDn"));
					log.info("======  Service Method==================");
					if(strFinancialDn.equalsIgnoreCase("Y")||strFinancialDn.equalsIgnoreCase("N"))
					{
						log.info("======  Service Started==================");
						String FileDownLoad = Helper.correctNull((String)hshValues.get("FileDownload"));
						if(strPage.toLowerCase().endsWith(".xlsx"))
						{
							FileInputStream fis = new FileInputStream(FileDownLoad.trim());
							this.xwb = new XSSFWorkbook(fis);	
							String fileName=Helper.correctNull((String)hshValues.get("FileName"));
							
							response.setHeader("Expires", "0");
							response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
							response.setHeader("Cache-Control", "cache");  
						    response.setHeader("Pragma", "cache");  
						    if(!fileName.equalsIgnoreCase(""))
						    	response.setHeader("Content-disposition","attachment; filename=\"" + fileName +"\""); 
						    else
						    	response.setHeader("Content-disposition","attachment;");
							response.setContentType("application/force-download");					
							ServletOutputStream servltout = response.getOutputStream(); 
							xwb.write(servltout);
							if(strFinancialDn.equalsIgnoreCase("Y"))
							{
								File f=new File(FileDownLoad);
								f.delete();
							}
							servltout.flush();
						}
						else
						{
							FileInputStream fin=new FileInputStream(FileDownLoad.trim());
							POIFSFileSystem fs = new POIFSFileSystem(fin);
							this.workbook = new HSSFWorkbook(fs);	
							String fileName=Helper.correctNull((String)hshValues.get("FileName"));
							
							response.setHeader("Expires", "0");
							response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
							response.setHeader("Cache-Control", "cache");  
						    response.setHeader("Pragma", "cache");  
						    if(!fileName.equalsIgnoreCase(""))
						    	response.setHeader("Content-disposition","attachment; filename=\"" + fileName +"\""); 
						    else
						    	response.setHeader("Content-disposition","attachment;");
							response.setContentType("application/force-download");					
							ServletOutputStream servltout = response.getOutputStream(); 
							workbook.write(servltout);
							if(strFinancialDn.equalsIgnoreCase("Y"))
							{
								File f=new File(FileDownLoad);
								f.delete();
							}
							servltout.flush();
						}
						
						log.info("======  Service End==================");
					}
					else if(strFinancialDn.equalsIgnoreCase("emandate"))
					{
						String FileDownLoad = Helper.correctNull((String)hshValues.get("FileDownLoad"));
						POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream(FileDownLoad.trim()));
						this.workbook = new HSSFWorkbook(fs);
						response.setHeader("Expires", "0");
						response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
						response.setHeader("Cache-Control", "cache"); // to make IE work! 
					    response.setHeader("Pragma", "cache"); // to make IE work! 
						response.setHeader("Content-disposition","attachment;"); 
						response.setContentType("application/force-download");					
						ServletOutputStream sout = response.getOutputStream();//GETTING THE OUTPUTSTREAM					
						workbook.write(sout);
						File f=new File(FileDownLoad);
						String Path=ApplicationParams.getStrdoclocation()+"/e-Mandate";
						if(!FileDownLoad.contains(Path))
							f.delete();
						sout.flush();
						
					}
					else
					{
						log.info("Excel File ... ELSE BLOCK====");
						
						HSSFWorkbook wb = (HSSFWorkbook) hshValues.get("workbook");
						ByteArrayOutputStream baos = new ByteArrayOutputStream();
						BufferedOutputStream bfs = new BufferedOutputStream(baos);// Added by Krithika.M for downloading DSCR
						wb.write(baos);
						bfs.flush();
						response.setHeader("Expires", "0");
						response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
						response.setHeader("Cache-Control", "cache");
						response.setHeader("Pragma", "cache");
						response.setHeader("Content-disposition", "attachment;");
						response.setContentType("application/vnd.ms-excel");
						response.setContentLength(baos.size());
						ServletOutputStream sout = response.getOutputStream();
						baos.writeTo(sout);
						sout.flush();
					}
				}
				catch (FileNotFoundException ffe)
				{
					log.error("FileNotFoundException Processing Excel File ..."+ffe.getMessage());
					throw new FileNotFoundException("Exception While Processing Excel File ..."+ffe.getMessage());
				}
				catch (Exception e)
				{
					log.error("Exception While Processing Excel File ..."+e.getMessage());
					throw new Exception("Exception While Processing Excel File ..."+e.getMessage());
				}
				return;
			}
			else if (strPage.toLowerCase().endsWith(".zip"))
			{
				log.info("Processing Excel File ...");
				try
				{
					hshValues = (HashMap) EJBInvoker.executeStateLess(strBeanId, hshRequestValues, strBeanGetMethod);
					
					log.info("======  Service Started==================");
					String FileDownLoad = Helper.correctNull((String)hshValues.get("FileDownload"));
					
					if(!FileDownLoad.equalsIgnoreCase(""))
					{
						FileInputStream fin=new FileInputStream(FileDownLoad.trim());
						String fileName=Helper.correctNull((String)hshValues.get("FileName"));
						
						response.setHeader("Expires", "0");
						response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
						response.setHeader("Cache-Control", "cache");  
					    response.setHeader("Pragma", "cache");  
					    if(!fileName.equalsIgnoreCase(""))
					    	response.setHeader("Content-disposition","attachment; filename=\"" + fileName +"\""); 
					    else
					    	response.setHeader("Content-disposition","attachment;");
						response.setContentType("application/force-download");					
						ServletOutputStream servltout = response.getOutputStream(); 
						
						int i=0;
						while((i=(fin.read()))!=-1)
						{
							servltout.write(i);
						}
						fin.close();
						
						File f=new File(FileDownLoad);
						f.delete();
						servltout.flush();
					}
					
					log.info("======  Service End==================");
				}
				catch (FileNotFoundException ffe)
				{
					log.error("FileNotFoundException Processing Excel File ..."+ffe.getMessage());
					throw new FileNotFoundException("Exception While Processing Excel File ..."+ffe.getMessage());
				}
				catch (Exception e)
				{
					log.error("Exception While Processing Excel File ..."+e.getMessage());
					throw new Exception("Exception While Processing Excel File ..."+e.getMessage());
				}
				return;
			}
			else if (strPage.toLowerCase().endsWith(".html"))
			{
				log.info("Processing File ...");
				try
				{
					hshValues = (HashMap) EJBInvoker.executeStateLess(strBeanId, hshRequestValues, strBeanGetMethod);
					ServletOutputStream sout = response.getOutputStream();
					log.info("======  Service Started==================");
					
					response.setHeader("Expires", "0");
					response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
					response.setHeader("Cache-Control", "cache");  
				    response.setHeader("Pragma", "cache");  
				    response.setHeader("Content-disposition","attachment;");
					response.setContentType("application/force-download");					
					Object streamedObj = hshValues.get("FILE_STREAM");
					byte[] barr = (byte[]) streamedObj;
					ByteArrayOutputStream bas = new ByteArrayOutputStream();
					bas.write(barr);
					response.setContentLength(bas.size());
					bas.writeTo(sout);
					sout.flush();
					
					log.info("======  Service End==================");
				}
				catch (FileNotFoundException ffe)
				{
					log.error("FileNotFoundException Processing  File ..."+ffe.getMessage());
					throw new FileNotFoundException("Exception While Processing  File ..."+ffe.getMessage());
				}
				catch (Exception e)
				{
					log.error("Exception While Processing  File ..."+e.getMessage());
					throw new Exception("Exception While Processing  File ..."+e.getMessage());
				}
				return;
			}
			else if (!strPage.endsWith(".txt") && (!strPage.endsWith(".gif") || !strPage.endsWith(".css")))
			{
				strUrl = strSourceUrl;
				objValues = EJBInvoker.executeStateLess(strBeanId, hshRequestValues, strBeanMethod);
				filehash = hshRequestValues;// To Avoid Null Pointer Exception
				if (objValues == null)
				{
					objValues = new Object();
				}
				request.setAttribute("objValues", objValues);
				request.setAttribute("PageCode", strPageId);
			}

			// For FINACLE INTERFACE to save Customer Profile & Sanction Details Files in client local disk File Format : .txt Modified by: Muralidharan
			else if (strPage.endsWith(".txt") || strPage.endsWith(".TXT"))
			{
				try
				{
					hshValues = (HashMap) EJBInvoker.executeStateLess(strBeanId, hshRequestValues, strBeanGetMethod);
					String FinacleFileValues = Helper.correctNull((String) hshValues.get("FinacleFileValues"));

					if (!FinacleFileValues.equals(""))
					{
						byte[] bytearray = (byte[]) FinacleFileValues.getBytes();
						ByteArrayOutputStream baos = new ByteArrayOutputStream();
						baos.write(bytearray);

						response.setHeader("Expires", "0");
						response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
						response.setHeader("Cache-Control", "cache"); 
						response.setHeader("Pragma", "cache"); 
						response.setHeader("Content-disposition", "attachment;");
						response.setContentType("application/force-download");
						response.setContentLength(baos.size());
						ServletOutputStream sout = response.getOutputStream();
						baos.writeTo(sout);
						baos.close();
						sout.flush();
						sout.close();
					} else
					{
						log.info(" ** DATA NOT AVAILABLE ** ");
					}
				}
				catch (FileNotFoundException ffe)
				{
					log.error("FileNotFoundException While Processing TXT File ..." + ffe.getMessage());
				}
				catch (Exception e)
				{
					log.error("Exception While Processing TXT File ..." + e.getMessage());
				}

				return;
			} // Added BY Zahoorunnisa.S for excel export
			hshValues.put("PageId", strPageId);
			
			if(Helper.correctNull((String)hshRequestValues.get("val")).equalsIgnoreCase("exit") && (strPage.equalsIgnoreCase("iframeMultiLogins.jsp")||strPage.equalsIgnoreCase("hidlogin.jsp")||strPage.equalsIgnoreCase("singlelogin.jsp"))
					&& !Helper.correctNull((String) hshRequestValues.get("strUserId")).equalsIgnoreCase(""))
			{
				mapSessionId.remove(Helper.correctNull((String) hshRequestValues.get("strUserId")));
			}
		}
		catch (Exception e)
		{
			log.error("Exception in Controllerservlet - Service().. " + e.getMessage());
			
			request.setAttribute("Exception", e.getMessage());
			
		}
		request.setAttribute("hshValues", hshValues);
		request.setAttribute("PageId", strPageId);

		if ((filehash != null || hshValues != null))
		if (Helper.correctNull((String) hshValues.get("FILE_STREAM_NAME")).length()>0)
		{
			try
			{
				if(processStreamedObjects(hshValues, response))
				{
					return;
				}
			}
			catch (Exception e)
			{
				log.error("Exception in Controller while handling Stream" + e);
			}

		}
		request.getRequestDispatcher(strUrl).forward(request, response);
		return;
	}

	private HashMap getRequestValues(HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		HashMap hshValues = new HashMap();
		Enumeration enumRequest = request.getParameterNames();
		Enumeration enumSession = session.getAttributeNames();
		while (enumRequest.hasMoreElements())
		{
			String strName = (String) enumRequest.nextElement();
			String[] strValue = request.getParameterValues(strName);
			if (strValue.length == 1)
			{
				hshValues.put(strName, strValue[0]);
				//System.out.println("====in getRequestValues==if===strValue[0]====="+strValue[0]);
			} else
			{
				hshValues.put(strName, strValue);
				//System.out.println("====in getRequestValues==else===strValue====="+strValue);
			}
		}
		while (enumSession.hasMoreElements())
		{
			String strName = (String) enumSession.nextElement();
			//System.out.println("====in session =====strName====="+strName);
			//System.out.println("====in session =====session.getAttribute(strName)====="+session.getAttribute(strName));
			hshValues.put(strName, session.getAttribute(strName));
		}
		return hshValues;
	}

	private String getEnvironment(String strParam) throws Exception
	{
		String Property = "";
		if ("APPHOME".equals(strParam))
		{
			if (!Helper.correctNull(System.getProperty(application.getInitParameter("APPHOME"))).equals(""))
			{
				Property = Helper.correctNull(System.getProperty(application.getInitParameter("APPHOME")));
				log.info("JBOSS Environment Found.. " + Property);
			} else if (!Helper.correctNull(System.getProperty(application.getInitParameter("WASAPPHOME"))).equals(""))
			{
				Property = Helper.correctNull(System.getProperty(application.getInitParameter("WASAPPHOME")));
				log.info("IBM Websphere Environment Found.. " + Property);
			} else if (!Helper.correctNull(System.getProperty(application.getInitParameter("OC4JAPPHOME"))).equals(""))
			{
				Property = Helper.correctNull(System.getProperty(application.getInitParameter("OC4JAPPHOME")));
				log.info("OC4J Environment Found.. " + Property);
			} else
			{
				throw new Exception("LAPS APPLICATION HOME ENTRY NOT FOUND!PLEASE CHECK THE web.xml");
			}
		}
		return Property;
	}

	protected boolean processStreamedObjects(Map requestInfo, HttpServletResponse response) throws Exception
	{
		String streamFileName = "file" + (String) requestInfo.get("FILE_STREAM_NAME");
		if (streamFileName != null && !streamFileName.trim().equals(""))
		{
			String streamContentType = (String) requestInfo.get("FILE_STREAM_TYPE");
			Object streamedObj = requestInfo.get("FILE_STREAM");
			if (streamContentType == null)
			{
				throw new Exception("Exception while streaming. Content Type not available " + streamFileName);
			} else if (streamedObj == null)
			{
				throw new Exception("Exception while streaming. Content stream not available or is null " + streamFileName);
			}
			response.setContentType(streamContentType);
			String dispoType = FwHelper.correctNull((String) requestInfo.get("FILE_STREAM_DISPOSITION_TYPE"));
			if (dispoType.trim().equals(""))
			{
				dispoType = "inline";
			}
			String head = dispoType + ";filename=\"" + streamFileName + "\"";
			response.setHeader("Content-Disposition", head);
			ServletOutputStream sout = response.getOutputStream();
			if (streamedObj instanceof ByteArrayOutputStream)
			{
				ByteArrayOutputStream bas = (ByteArrayOutputStream) streamedObj;
				response.setContentLength(bas.size());
				bas.writeTo(sout);
				sout.flush();
				return true;
			} else if (streamedObj instanceof byte[])
			{
				byte[] barr = (byte[]) streamedObj;
				ByteArrayOutputStream bas = new ByteArrayOutputStream();
				bas.write(barr);
				response.setContentLength(bas.size());
				bas.writeTo(sout);
				sout.flush();
				return true;
			}
		}
		return false;
	}

}
