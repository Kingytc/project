/******************************************************************************
 * Package:			com.sai.laps.ejb.repappexception
 * File:			RepAppExceptionRemote.java
 * Description:		Remote Class for Application Exception Report
 * @author			R.Saraswathi 
 ******************************************************************************/
package com.sai.laps.ejb.repappexception;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface RepAppExceptionRemote 
{
	public HashMap getData(HashMap hshRequestValues);
}