package com.sai.laps.ejb.formula;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface FormulaRemote 
{
	public HashMap getFormulaData(HashMap hsh);
	public HashMap updateData(HashMap hshValues);
	public HashMap getDataHelp(HashMap hsh);
	public HashMap updateCMA(HashMap hshValues);
	public HashMap getIndData(HashMap hsh);
	public HashMap getCMA(HashMap hshValues);
	public HashMap updateCMAData(HashMap hshValues);	
}
