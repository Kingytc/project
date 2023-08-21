package com.sai.laps.helper;
import java.io.Serializable;
import java.sql.Connection;

import javax.ejb.SessionContext;
public abstract class BeanAdapter implements Serializable {
	
	/** Method For Correct Null Values **/
	public String correctNull(String strNull) {
		if (strNull == null) {
			strNull = "";
		}
		return strNull;
	}
	public String correctSingleQuote(String str) throws Exception {
		String strLStr = "";
		str = correctNull(str);
		try {
			for (int i = 0; i < str.length(); i++) {
				if (str.charAt(i) == '\'') {
					strLStr = strLStr + str.charAt(i) + "'";
				} else {
					strLStr = strLStr + str.charAt(i);
				}
			}
		} catch (Exception e) {
			throw new Exception("Error in UtilFunctions: correctSingleQuote" + e);
		}
		return strLStr;
	}
	public Connection getConnection() throws Exception {		
		try {
			return ConnectionFactory.getConnection();
			
		} catch (Exception e) {
			throw new Exception("Error in Getting DB Connection" + e);
		}		
	}
	
	public Connection getCBSConnection() throws Exception {
		try {
			return ConnectionFactory.getCBSConnectionMain();

		} catch (Exception e) {
			throw new Exception("Error in Getting DB Connection" + e);
		}
	}
	
	public String makeNull(Object strObj) throws Exception {
		String str = (String) strObj;
		if (str != null && str.trim().equals("")) {
			return null;
		} else {
			return str;
		}
	}
	
	 /*** Rollsback the transaction in context****/
    /*public void rollBack(){
        try{
            sc.setRollbackOnly();
        }catch(Exception e){
            ;
        }
    }*/
}