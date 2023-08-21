package com.sai.laps.helper;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Timer;
import java.util.TimerTask;

import org.apache.log4j.Logger;

public class SCHEDULARNSDLRESPONSE extends TimerTask  {
	static Logger log=Logger.getLogger(SCHEDULARNSDLRESPONSE.class);
	 private final static long fONCE_PER_DAY =1000*60*30;//DELAY TIME
 	 private final static int fONE_DAY =0;//DELAY IN DAYS 
	 private  static int fFOUR_AM =10;//HOURS OF EXECUTION
	 private  static int fZERO_MINUTES=0;//MINUTES OF EXECUTION
	 static TimerTask timertask=null;
	 public static void startLAPSScheduler() 
	 {
		 try
		 	{
			 	System.out.println("================Inside LAPS Scheduler========================");	  
				  timertask = new SCHEDULARNSDLRESPONSE();
				 Timer timer = new Timer();
				 timer.scheduleAtFixedRate(timertask,getTime(), fONCE_PER_DAY);
				 System.out.println("=============== LAPS Scheduler started successfully====================== ");
		 	}
	  catch(Exception e)
	  {
		 System.out.println("Exception occurred while starting the LAPS Scheduler"+e.toString());
	  }
 
}

 public void run()
 {
	  try
	  {
		  long starttime=System.currentTimeMillis();
		  
		  System.out.println("==============LAPS Scheduler Task Execution Started======="+starttime); 
		  System.out.println("Task Execution On:"+new java.text.SimpleDateFormat("DD/MM/yyyy HH:mm:SS").format(new Date()));
			new SchedulerTask().runLAPSResUpload();
		
		 long endtime=System.currentTimeMillis();
		 System.out.println("Total time taken for current LAPS Scheduler task execution:"+endtime);
	  }
	  catch(Exception e)
	  {
		  System.out.println("LAPS Scheduler Terminated....!!!!!!! \n  Exception Details :\n"+e.toString());
		  System.out.println("LAPS Scheduler restarted because of runtime exception..");
		  stopLAPSScheduler();
		  startLAPSScheduler();
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
 
 public void stopLAPSScheduler()
 {
	 try
	 {timertask.cancel();}
	 catch(Exception e){System.out.println("Exception occured while stoping the LAPS Scheduler "+e.getMessage());}
	 
 }
}
