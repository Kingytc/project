package com.sai.laps.helper;

import java.util.HashMap;
import java.util.Timer;
import java.util.TimerTask;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Date;

import javax.resource.spi.ApplicationServerInternalException;

import org.apache.log4j.Logger;

import com.sai.fw.management.utils.FwHelper;



public final class SMSSCHEDULERFORSECURITY extends TimerTask {
	static Logger log=Logger.getLogger(SMSSCHEDULERFORSECURITY.class);
	 private final static long fONCE_PER_DAY =1000*60*60*24;//DELAY TIME
  	 private final static int fONE_DAY =Integer.valueOf(FwHelper.correctNull((String)ApplicationParams.getSCHSECURITYDAYS()));//0;//DELAY IN DAYS 
	 private  static int fFOUR_AM =Integer.valueOf(FwHelper.correctNull((String)ApplicationParams.getSCHSECURITYHOURS()));//8;//HOURS OF EXECUTION
	 private  static int fZERO_MINUTES=Integer.valueOf(FwHelper.correctNull((String)ApplicationParams.getSCHSECURITYMINS()));//00;//MINUTES OF EXECUTION
	 static TimerTask timertask=null;
	 public static void startSMSScheduler() 
	 {
		 try
		 	{
			 	System.out.println("********************************Inside SMS TRIGGER for Security Scheduler*****************************");
			 	log.info("********************************Inside SMS TRIGGER for Security Scheduler*****************************");
				  timertask = new SMSSCHEDULERFORSECURITY();
				 Timer timer = new Timer();
				 timer.scheduleAtFixedRate(timertask,getTime(), fONCE_PER_DAY);
				 //timer.schedule(timertask,getTime(), fONCE_PER_DAY);
				 //scheduleWithFixedDelay 
				 //timer.scheduleAtFixedRate(timertask,fONCE_PER_DAY, fONCE_PER_DAY);
				 
				 System.out.println("***********************************SMS TRIGGER for Security Scheduler started successfully*********************** ");
				 log.info("********************************SMS TRIGGER for Security Scheduler started successfully*****************************");
				 
		 	}
	  catch(Exception e)
	  {
		 System.out.println("Exception occurred while starting the SMS TRIGGER for Security Scheduler"+e.toString());
		 log.info("Exception occurred while starting the SMS TRIGGER for Security Scheduler"+e.toString());
	  }
  
 }

  public void run()
  {
	  try
	  {
		  long starttime=System.currentTimeMillis();
		  
		  System.out.println("***********************SMS TRIGGER for Security Scheduler Task Execution Started********************"+starttime); 
		  log.info("***********************SMS TRIGGER for Security Scheduler Task Execution Started********************"+starttime); 
		  System.out.println("********************Task Execution On:"+new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:SS").format(new Date()));
		  log.info("********************Task Execution On:"+new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:SS").format(new Date()));
		  
			HashMap hsh = new HashMap();
			//HashMap statusMap = (HashMap) EJBInvoker.executeStateLess("commworkflow", hsh, "updsmsforsecurity");
			HashMap statusMap2 =(HashMap) EJBInvoker.executeStateLess("commworkflow", hsh, "updatequerystatus");
		 long endtime=System.currentTimeMillis();
		 System.out.println("Total time taken for current SMS TRIGGER for Security Scheduler task execution:"+endtime);
		 log.info("Total time taken for current SMS TRIGGER for Security Scheduler task execution:"+endtime);
	  }
	  catch(Exception e)
	  {
		  System.out.println("********************SMS TRIGGER Scheduler for Security Terminated....!!!!!!! \n  Exception Details :\n"+e.toString());
		  log.info("********************SMS TRIGGER Scheduler for Security Terminated....!!!!!!! \n  Exception Details :\n"+e.toString());
		  System.out.println("********************SMS TRIGGER Scheduler for Security restarted because of runtime exception***********************");
		  log.info("********************SMS TRIGGER Scheduler for Security restarted because of runtime exception***********************");
		  stopSMSSScheduler();
		  startSMSScheduler();
		  String str="abc";
		  synchronized (str) 
		  {
			  		
		  }
	 }
  }
  
  private static Date getTime()
  {
	Calendar tomorrow = new GregorianCalendar();
    tomorrow.add(Calendar.DATE, fONE_DAY);
    Calendar result = new GregorianCalendar(tomorrow.get(Calendar.YEAR),tomorrow.get(Calendar.MONTH), tomorrow.get(Calendar.DATE),
      fFOUR_AM,
      fZERO_MINUTES
    );
    return result.getTime();
  }
  
  public void stopSMSSScheduler()
  {
	 try
	 {timertask.cancel();}
	 catch(Exception e){
		 System.out.println("*********************Exception occured while stoping the SMS TRIGGER Scheduler ****************************"+e.getMessage());
		 log.info("*********************Exception occured while stoping the SMS TRIGGER Scheduler ****************************"+e.getMessage());
		 }
	 
  }
}
