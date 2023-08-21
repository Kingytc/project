/******************************************************************************
 * Package:			com.sai.laps.ejb.repappsoar
 * File:			RepAppSoarRemote.java
 * Description:		Remote Class for SOAR Report
 * @author			R.Saraswathi 
 ******************************************************************************/
package com.sai.laps.ejb.repappsoar;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface RepAppSoarRemote 
{
	public HashMap getData(HashMap hshRequestValues);
}