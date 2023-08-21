package com.sai.laps.ejb.ExcelReader;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface ExcelReaderRemote 
{
	public HashMap excelParser(HashMap hshValues); 
}

