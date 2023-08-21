package com.sai.laps.helper;
import java.util.HashMap;

import com.sai.laps.helper.ConnectionFactory;

import org.apache.log4j.Logger;

public class SchedulerTask {

	Logger log=Logger.getLogger(SchedulerTask.class);
	private static final long serialVersionUID = 1L;
    HashMap hshParams=new HashMap();
       
	public void runLAPSTask()
	{
		try {
			if(ApplicationParams.getStrNSDLSchStatus().equals("ON")){
				try {
				try{	
			        log.info("==============NSDL FILE DOWNLOAD TASK  START AT SchedulerTask ==> runLAPSTask ============");
			        
			        hshParams.put("strSchedularFlag", "Y");
			        EJBInvoker.executeStateLess("nsdl",hshParams,"downloadRequestFiles");
			        
					log.info("==============NSDL FILE DOWNLOAD TASK  END AT SchedulerTask ==> runLAPSTask ============");
					
				}catch(Exception e){
					log.error("TASK Failed "+e.toString());
					log.error("TASK Failed "+e.getLocalizedMessage());
					log.error("======Task failed =======");
				}
				
			        log.info("==============NSDL FILE DOWNLOAD Scheduler task Execution completed successfully============");
				} catch (Exception e) {
					log.error("Exception in Scheduled Task Execution===" + e.toString());
				}
			
			}else{
				log.error("LAPS Schedular disabled");
			}
		} catch (Exception e) {
			System.out.println("Exception in Scheduled Task Execution==="
							+ e.toString());
		} finally {
			
			System.out.println("==============Scheduler task execution Ended============");
			/** GARBAGE COLLECTION INVOCATION* */
			Runtime.getRuntime().gc();
			Runtime.getRuntime().runFinalization();
		}
      
	}
	public void runLAPSResUpload()
	{
		try {
			
			if(ApplicationParams.getStrNSDLSchStatus().equals("ON")){
				
				try {
				try{	
			        log.info("==============NSDL Response Upload TASK  START AT SchedulerTask ==> runLAPSTask ============");
			        
			        hshParams.put("strSchedularFlag", "Y");
			        EJBInvoker.executeStateLess("nsdl",hshParams,"generateXMLResponseFiles");
			        
					log.info("==============NSDL Response Upload TASK  END AT SchedulerTask ==> runLAPSTask ============");
					
				}catch(Exception e){
					log.error("TASK Failed "+e.toString());
					log.error("TASK Failed "+e.getLocalizedMessage());
					log.error("======Task failed =======");
				}
				
			        log.info("==============Scheduler task Execution completed successfully============");
				} catch (Exception e) {
					log.error("Exception in Scheduled Task Execution===" + e.toString());
				}
			
			}else{
				log.error("LAPS Schedular disabled");
			}
		} catch (Exception e) {
			System.out.println("Exception in Scheduled Task Execution==="
							+ e.toString());
		} finally {
			
			System.out.println("==============Scheduler task execution Ended============");
			/** GARBAGE COLLECTION INVOCATION* */
			Runtime.getRuntime().gc();
			Runtime.getRuntime().runFinalization();
		}
      
	}
	
}