/******************************************************************************
 * Package:			com.sai.laps.ejb.repappcredit
 * File:			RepAppCreditRemote.java
 * Description:		Remote Class for Credit Activity Report
 * @author			R.Saraswathi 
 ******************************************************************************/
package com.sai.laps.ejb.repappcredit;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface RepAppCreditRemote 
{
	public HashMap getData(HashMap hshRequestValues);
	
	// for cash flow budget
	public HashMap getCashFlowBudget(HashMap hshRequestValues);
	public void updateCashFlowBudget(HashMap hshRequestValues);
	public void deleteCashFlowBudget(HashMap hshRequestValues);
}