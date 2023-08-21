package com.sai.laps.ejb.duplicatequeries;

import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.dscr.DscrBean;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLDuplicateparser;


@Stateless(name = "DuplicateQueriesBean", mappedName = "DuplicateQueriesHome")
@Remote (DuplicateQueriesRemote.class)
public class DuplicateQueriesBean extends BeanAdapter
{	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(DuplicateQueriesBean.class);

	public HashMap getData(HashMap hshRequestValues) 
	{
		
		HashMap hshRecord = new HashMap();
		HashMap hash1 = new HashMap();
		
		try
		{	
			hash1 = SQLDuplicateparser.loadSQLQueries();
			//hash1 = SQLDuplicateparser.loadSQLQueries();
			hshRecord.put("FinacleFileValues",Helper.correctNull((String)hash1.get("strDuplicatelist")));
			//hash1 = SQLDuplicateparser.loadBeanMetaData();
			//hshRecord.put("FinacleFileValues",Helper.correctNull((String)hash1.get("strDuplicatelist")));
			//hash1 = SQLDuplicateparser.loadPageAndServiceMappings();
			//hash1 = SQLDuplicateparser.loadEJBData();
			//hshRecord.put("FinacleFileValues",Helper.correctNull((String)hash1.get("strDuplicatelist")));	
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData"+ce.toString());
		}
	return hshRecord;
	}

	

}
