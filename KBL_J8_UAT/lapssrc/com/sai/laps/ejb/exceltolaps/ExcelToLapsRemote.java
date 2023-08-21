package com.sai.laps.ejb.exceltolaps;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface ExcelToLapsRemote 
{
	public HashMap excelCustomerParser(HashMap hshValues);
	public HashMap exceltoLaps(HashMap hshValues);
	public HashMap exceltoLapsExistCustomer(HashMap hshValues);
	
}

