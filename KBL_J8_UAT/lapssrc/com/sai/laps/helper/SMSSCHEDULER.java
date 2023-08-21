package com.sai.laps.helper;

import java.util.HashMap;
import java.util.Timer;
import java.util.TimerTask;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Date;
import org.apache.log4j.Logger;



public final class SMSSCHEDULER extends TimerTask {
	static Logger log=Logger.getLogger(SMSSCHEDULER.class);
	 private final static long fONCE_PER_DAY =1000*60*60*24;//DELAY TIME
  	 private final static int fONE_DAY =1;//DELAY IN DAYS 
	 private  static int fFOUR_AM =8;//HOURS OF EXECUTION
	 private  static int fZERO_MINUTES=00;//MINUTES OF EXECUTION
	 static TimerTask timertask=null;
	 public static void startSMSScheduler() 
	 {
		 try
		 	{
			 	System.out.println("********************************Inside SMS TRIGGER Scheduler*****************************");	  
				  timertask = new SMSSCHEDULER();
				 Timer timer = new Timer();
				 timer.scheduleAtFixedRate(timertask,getTime(), fONCE_PER_DAY);
				 //timer.schedule(timertask,getTime(), fONCE_PER_DAY);
				 //scheduleWithFixedDelay 
				 //timer.scheduleAtFixedRate(timertask,fONCE_PER_DAY, fONCE_PER_DAY);
				 
				 System.out.println("***********************************SMS TRIGGER Scheduler started successfully*********************** ");
		 	}
	  catch(Exception e)
	  {
		 System.out.println("Exception occurred while starting the SMS TRIGGER Scheduler"+e.toString());
	  }
  
 }

  public void run()
  {
	  try
	  {
		  long starttime=System.currentTimeMillis();
		  
		  System.out.println("***********************SMS TRIGGER Scheduler Task Execution Started********************"+starttime); 
		  System.out.println("********************Task Execution On:"+new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:SS").format(new Date()));
			HashMap hsh = new HashMap();
			HashMap statusMap = (HashMap) EJBInvoker.executeStateLess("commworkflow", hsh, "updsmsTrigger");
			//HashMap statusMap = (HashMap) EJBInvoker.executeStateLess("commworkflow", hsh, "updsmsTriggerScheduler");//updsmsTriggerScheduler
		 long endtime=System.currentTimeMillis();
		 System.out.println("Total time taken for current SMS TRIGGER Scheduler task execution:"+endtime);
	  }
	  catch(Exception e)
	  {
		  System.out.println("********************SMS TRIGGER Scheduler Terminated....!!!!!!! \n  Exception Details :\n"+e.toString());
		  System.out.println("********************SMS TRIGGER Scheduler restarted because of runtime exception***********************");
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
		 }
	 
  }
}
