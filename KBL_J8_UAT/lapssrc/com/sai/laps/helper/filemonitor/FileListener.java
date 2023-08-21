package com.sai.laps.helper.filemonitor;

import java.io.File;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

/**
 * @author S.SATHYA MOORTHY 
 * @SINCE 24/11/2008
 * @PURPOSE : FILE AND FOLDER LISTENER FOR LAPS ARCHITECURE.
 */
public class FileListener extends BaseListener implements IFileListener 
{
	static Logger log=Logger.getLogger(FileListener.class);
   /**
     * Connstructor
     */
    public FileListener() {
        super();
    }

    public void onStart(Object monitoredResource) 
    {
        // On startup
        if (monitoredResource instanceof File) {
            File resource = (File) monitoredResource;
            if (resource.isDirectory()) {

            	log.info("LAPS FILE LISTENER MONITORING  " + resource.getAbsolutePath());

                /*File[] files = resource.listFiles();
                for (int i = 0; i < files.length; i++) {
                    File f = (File) files[i];
                    onAdd(f);
                }*/
            }
        }
    }

    public void onStop(Object notMonitoredResource) 
    {

    }

    public void onAdd(Object newResource) 
    {
    	if (newResource instanceof File) 
    	{
            File file = (File) newResource;
            if (file.isFile()) {
            	log.info(file.getAbsolutePath() + " is added");
            }
        }
    }

    /**
     * @author: S.SATHYA MOORTHY
     * @DESCRIPTION: THIS FUNCTION WILL INVOKE WHENEVER CHANGES DONE ON THE FILE SYSTEM OF SPECIFIED FOLDER IN THE ARCHITECTURE.
     * @SINCE : 25/11/2008
     */
    public void onChange(Object changedResource) 
    {
        if (changedResource instanceof File) 
        {
            File file = (File) changedResource;
            if (file.isFile()) 
            {
            	log.info(file.getAbsolutePath() + " HAS BEEN CHANGED");
            	
            	String strFilePath=file.getAbsolutePath();
            	String strDirectory=file.getParent();
            	String strfileName=file.getName();
            	log.info("Changed file Path::"+strFilePath);
            	log.info("Changed Directory for the file::"+strDirectory);
            	log.info("Changed File Name ::"+strfileName);
            	
            	if(strFilePath.endsWith("sql.xml"))
            	{
            		LAPSDirectoryFileMonitor.reloadLAPSSettings("1",strFilePath,strDirectory,strfileName);
            	}
            	if(strFilePath.endsWith("sqlnsdl.xml"))
            	{
            		LAPSDirectoryFileMonitor.reloadLAPSSettings("1",strFilePath,strDirectory,strfileName);
            	}
            	if(strFilePath.endsWith("sqlcorpupload.xml"))
            	{
            		LAPSDirectoryFileMonitor.reloadLAPSSettings("1",strFilePath,strDirectory,strfileName);
            	}
            	
            	if(strFilePath.endsWith("sqlagr.xml"))
            	{
            		LAPSDirectoryFileMonitor.reloadLAPSSettings("1",strFilePath,strDirectory,strfileName);
            	}
            	
            	if(strFilePath.endsWith("sqlmon.xml"))
            	{
            		LAPSDirectoryFileMonitor.reloadLAPSSettings("1",strFilePath,strDirectory,strfileName);
            	}
            	
            	if(strFilePath.endsWith("sqlnpa.xml"))
            	{
            		LAPSDirectoryFileMonitor.reloadLAPSSettings("1",strFilePath,strDirectory,strfileName);
            	}
            	
            	if(strFilePath.endsWith("sqlnpa.xml"))
            	{
            		LAPSDirectoryFileMonitor.reloadLAPSSettings("1",strFilePath,strDirectory,strfileName);
            	}
            	
            	if(strFilePath.endsWith("sqlreports.xml"))
            	{
            		LAPSDirectoryFileMonitor.reloadLAPSSettings("1",strFilePath,strDirectory,strfileName);
            	}
            	if(strFilePath.endsWith("sqlcorp.xml"))
            	{
            		LAPSDirectoryFileMonitor.reloadLAPSSettings("1",strFilePath,strDirectory,strfileName);
            	}
            	if(strFilePath.endsWith("sqlIRB.xml"))
            	{
            		LAPSDirectoryFileMonitor.reloadLAPSSettings("1",strFilePath,strDirectory,strfileName);
            	}
            	if(strFilePath.endsWith("sqlCBS.xml"))
            	{
            		LAPSDirectoryFileMonitor.reloadLAPSSettings("1",strFilePath,strDirectory,strfileName);
            	}
            	if(strFilePath.endsWith("sqlops.xml"))
            	{
            		LAPSDirectoryFileMonitor.reloadLAPSSettings("1",strFilePath,strDirectory,strfileName);
            	}
            	if(strFilePath.endsWith("sqlper.xml"))
            	{
            		LAPSDirectoryFileMonitor.reloadLAPSSettings("1",strFilePath,strDirectory,strfileName);
            	}
            	if(strFilePath.endsWith("sqlmst.xml"))
            	{
            		LAPSDirectoryFileMonitor.reloadLAPSSettings("1",strFilePath,strDirectory,strfileName);
            	}
            	if(strFilePath.endsWith("sqlbst.xml"))
            	{
            		LAPSDirectoryFileMonitor.reloadLAPSSettings("1",strFilePath,strDirectory,strfileName);
            	}
            	if(strFilePath.endsWith("sqladc.xml"))
            	{
            		LAPSDirectoryFileMonitor.reloadLAPSSettings("1",strFilePath,strDirectory,strfileName);
            	}
            	if(strFilePath.endsWith("sqlexcel.xml"))
            	{
            		LAPSDirectoryFileMonitor.reloadLAPSSettings("1",strFilePath,strDirectory,strfileName);
            	}
            	if(strFilePath.endsWith("sqlCMM.xml"))
            	{
            		LAPSDirectoryFileMonitor.reloadLAPSSettings("1",strFilePath,strDirectory,strfileName);
            	}
            	if(strFilePath.endsWith("sqlCibil.xml"))
            	{
            		LAPSDirectoryFileMonitor.reloadLAPSSettings("1",strFilePath,strDirectory,strfileName);
            	}
            	if(strFilePath.endsWith("sqlonline.xml"))
            	{
            		LAPSDirectoryFileMonitor.reloadLAPSSettings("1",strFilePath,strDirectory,strfileName);
            	}
            	if(strFilePath.endsWith("sqlMIS.xml"))
            	{
            		LAPSDirectoryFileMonitor.reloadLAPSSettings("1",strFilePath,strDirectory,strfileName);
            	}
            	if(strFilePath.endsWith("sqlagrikbl.xml"))
            	{
            		LAPSDirectoryFileMonitor.reloadLAPSSettings("1",strFilePath,strDirectory,strfileName);
            	}
            	if(strFilePath.endsWith("partition.xml"))
            	{
            		LAPSDirectoryFileMonitor.reloadLAPSSettings("2",strFilePath,strDirectory,strfileName);
            	}
            	if(strFilePath.endsWith("jspmaps.xml")||strFilePath.endsWith("jspmapmis.xml")||strFilePath.endsWith("jspmapsadc.xml")
            			||strFilePath.endsWith("jspmapsagr.xml")||strFilePath.endsWith("jspmapsbst.xml")||strFilePath.endsWith("jspmapset.xml")
            			||strFilePath.endsWith("jspmapsmst.xml")||strFilePath.endsWith("jspmapsnpa.xml")||strFilePath.endsWith("jspmapsops.xml")
            			||strFilePath.endsWith("jspmapsretail.xml")||strFilePath.endsWith("jspmapstlr.xml"))
            	{
            		 LAPSDirectoryFileMonitor.reloadLAPSSettings("3",strFilePath,strDirectory,strfileName);
            	}
            	if(strFilePath.endsWith("pdf.xml"))
            	{
            		LAPSDirectoryFileMonitor.reloadLAPSSettings("4",strFilePath,strDirectory,strfileName);
            	}
            	if(strFilePath.endsWith("BeanID.xml"))
            	{
            		 LAPSDirectoryFileMonitor.reloadLAPSSettings("5",strFilePath,strDirectory,strfileName);
            	}
            	if(strFilePath.endsWith("LAPSProperties.xml"))
            	{
            		 LAPSDirectoryFileMonitor.reloadLAPSSettings("6",strFilePath,strDirectory,strfileName);
            	}
            	
               	}
            	
            	
            }

        }
   
    public void onDelete(Object deletedResource) {
        if (deletedResource instanceof String) {
            String deletedFile = (String) deletedResource;
            log.info(deletedFile + " LAPS FILE HAS BEEN DELETED FROM THE HIERARCHY");
        }
    }
}

