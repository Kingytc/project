package com.sai.laps.helper.controllers;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.sai.fw.management.utils.FwHelper;
import com.sai.laps.helper.Constants;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.SAILogger;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.report.ReportHelper;

/**
 * 
 *@author : S.SATHYA MOORTHY
 *@date   :Mar 13, 2009 :12:19:51 PM
 *@todo :This Controller dispatches all the PDF events.
 *@purpose : FOR ALL LAPS PDF REPORT DOCUMENTS. 
 */
public class ServiceController_5 extends BaseController{


	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(ServiceController_5.class);
	
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		//super.init(config);
	}
	public void destroy() {
		// TODO Auto-generated method stub
		super.destroy();
	}
	
	public ServiceController_5() {
		// TODO Auto-generated constructor stub
	}
	
	public void service(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		String strUrl = request.getRequestURI();
				log.info("strUrl..." + strUrl);
		String strPage = strUrl.substring(strUrl.lastIndexOf("/") + 1, strUrl
				.length());
		if (strPage.endsWith(".gif") || strPage.endsWith(".css")) {
			return;
		}
		
		Calendar cal = Calendar.getInstance();
		String strBeanId = request.getParameter("hidBeanId");
		String strBeanMethod = request.getParameter("hidBeanMethod");
		String strBeanGetMethod = request.getParameter("hidBeanGetMethod");
		String strSourceUrl = request.getParameter("hidSourceUrl");
		log.info("Printing BeanId=" + strBeanId
				+ " :Printing strBeanGetMethod=" + strBeanGetMethod
				+ " : Printing strBeanMethod=" + strBeanMethod
				+ " :Printing strPage=" + strPage + "Printing Date Time"
				+ cal.get(Calendar.DATE) + "/" + cal.get(Calendar.MONTH) + "/"
				+ cal.get(Calendar.YEAR) + ":" + cal.get(Calendar.HOUR_OF_DAY)
				+ ":" + cal.get(Calendar.MINUTE) + ":"
				+ cal.get(Calendar.MILLISECOND));
		
		HashMap hshValues = new HashMap();
		Object objValues = new Object();
		try {
			if(strPage.equals("hidlogin.jsp"))
			{
					String temp1=null,temp2=null;
					HttpSession session = null;
					if(mapSessionId.get(FwHelper.correctNull((String)request.getParameter("txtusr_id")).toUpperCase()) instanceof HttpSession && mapSessionId.get(FwHelper.correctNull((String)request.getParameter("txtusr_id")).toUpperCase()) != null)
					{
						session =(HttpSession) mapSessionId.get(FwHelper.correctNull((String)request.getParameter("txtusr_id")).toUpperCase());
						temp1 = session.getId();
						
						HttpSession session1 = request.getSession(false);
						temp2 = session1.getId();
						 
						if(!temp1.equals(temp2))
						{	
							mapSessionId.remove(FwHelper.correctNull((String)request.getParameter("txtusr_id")).toUpperCase());
							try
							{
								if(FwHelper.correctNull((String)request.getParameter("txtusr_id")).toUpperCase().equals(FwHelper.correctNull((String)session.getAttribute("strUserId")).toUpperCase()))
								{		
								    session.invalidate();
								}    
							}		
							catch(Exception e)
							{
								log.error("Session already invalidated");
							}
						}	
					}
					
				}

	if (!(strPage.equals("login.jsp") || strPage.equals("hidlogin.jsp")
			|| strPage.equals("purgeuser.jsp") || strPage
			.equals("changepassword.jsp"))) {
		HttpSession session = request.getSession(false);

		if (session == null
				|| session.getAttribute("strUserId") == null) {
			strUrl = strPage = "/jsp/share/rdLogin.jsp";
			request.getRequestDispatcher(strUrl).forward(request,
					response);
			return;
		}
		else
		{
			 session = request.getSession(false);
			mapSessionId.put(FwHelper.correctNull((String)session.getAttribute("strUserId")),session);
		}
	}
	
	
	if (strPage.endsWith(".pdf")) {
		//Logger.log("CALLING PDF MODULE.....");
		HashMap hshRequestValues = getRequestValues(request);
		String tempString[] = null;
		if (FwHelper.correctNull(strBeanId).equals("")
				&& FwHelper.correctNull(strBeanGetMethod).equals("")) {
			if (!mapPDF.containsKey(strPage))
				if(mapPDF.get(strPage)==null){throw new Exception("Sorry! Resource not Found(404) OR No Mappings in pdf.xml");}
			tempString = (FwHelper.correctNull((String) mapPDF
					.get(strPage))).split(":");
			strBeanId = tempString[0];
			strBeanGetMethod = tempString[1];
		}
		if(strBeanId==null || strBeanGetMethod==null){throw new Exception("Sorry! Requested URI Header does not contains beanId or Method Name:");}
		hshValues = (HashMap) EJBInvoker.executeStateLess(strBeanId,
				hshRequestValues, strBeanGetMethod);

		Object byteobject = hshValues.get("PDF_OBJECT");
		if (!(byteobject instanceof byte[]))
			throw new Exception("CANNOT GENERATE PDF !BYTE ARRAY IS NEEDED !FOUND ANOTHER DATA TYPE TYPE=:"+ byteobject.getClass());
		byte[] bytearray = (byte[]) byteobject;
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		baos.write(bytearray);
		//Logger.log("OBJECT RECEIVED FOR PDF GENERATION....");
		response.setHeader("Expires", "0");
		response.setHeader("Cache-Control","must-revalidate, post-check=0, pre-check=0");
		response.setHeader("Pragma", "public");
		response.setContentType(Constants.CONTENT_TYPE_PDF);
		log.info("CONTENT TYPE==" + response.getContentType());
		response.setContentLength(baos.size());
		//Logger.log("SIZE OF PDF STREAM (CONTENT LENGTH)::==="+ ((double) ((double) (double) ((double) baos.size()) / (int) 1024) / 1024)+ " MEGA BYTES");
		ServletOutputStream sout = response.getOutputStream();// GETTING THE OUTPUTSTREAM
		baos.writeTo(sout);
		baos.close();
		sout.flush();
		sout.close();
		log.info(" ** PDF GENERATED SUCCESSFULLY ** ");
		return;

	}
			else if (!strPage.endsWith(".gif") || !strPage.endsWith(".css")) {
			HashMap hshRequestValues = getRequestValues(request);
			strUrl = strSourceUrl;
			objValues = EJBInvoker.executeStateLess(strBeanId,
			hshRequestValues, strBeanMethod);
			if (objValues == null) {
				objValues = new Object();
			}
				request.setAttribute("objValues", objValues);
			}
		
		} catch (Exception e) {
			log.error("################################################################");
			log.error("EXCEPTION OCCURRED IN LAPS APPLICATION \n");
			log.error("EXCEPTION MESSAGE : "+e.getMessage());
			log.error("STACK TRACE :");
			e.printStackTrace();
			log.error("#################################################################");
			request.setAttribute("Exception", e.getMessage());
			try{ReportHelper.showPDFException(e,response,strBeanId,strBeanGetMethod);}catch(Exception ps) {ps.printStackTrace();}
		}
		request.setAttribute("hshValues", hshValues);
		    
		request.getRequestDispatcher(strUrl).forward(request, response);
		return;
		}
		
		private HashMap getRequestValues(HttpServletRequest request) {
		HttpSession session = request.getSession();
		HashMap hshValues = new HashMap();
		Enumeration enumRequest = request.getParameterNames();
		Enumeration enumSession = session.getAttributeNames();
		while (enumRequest.hasMoreElements()) {
			String strName = (String) enumRequest.nextElement();
			String[] strValue = request.getParameterValues(strName);
			if (strValue.length == 1) {
				hshValues.put(strName, strValue[0]);
			} else {
				hshValues.put(strName, strValue);
			}
		}
		while (enumSession.hasMoreElements()) {
			String strName = (String) enumSession.nextElement();
			hshValues.put(strName, session.getAttribute(strName));
		}
		return hshValues;
		}
		
		

	
	
	
}