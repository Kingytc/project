package com.sai.laps.ejb.perrepappstatus;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;


@Remote
public interface PerRepAppStatusRemote 
{
	public HashMap getData(HashMap hshValues);
	//====================added for new Data Valuation Report========================//
	public HashMap getXLDataValuationReport(HashMap hshValues);
	public HashMap getDataValuationReport(HashMap hshValues);
	//==================================end==========================================//
	//=====================added for msme  report====================================//
	public HashMap getMsmeReport(HashMap hshValues);
	//=============================end==============================================//
	public HashMap getsolvencyReport(HashMap hshValues);
	//public HashMap getXLCreditSaleReport(HashMap hshValues); 
	//public HashMap getCreditSaleReport(HashMap hshValues);


}