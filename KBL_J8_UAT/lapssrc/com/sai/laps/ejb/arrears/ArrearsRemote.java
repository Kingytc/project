package com.sai.laps.ejb.arrears;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface ArrearsRemote 
{
	public HashMap UpdateArrearsData(HashMap hshRequestValues);
	public HashMap getData(HashMap hshRequestValues);
	public HashMap updateSSIAB10Data(HashMap hshRequestValues);
	public void removeLocationalData(HashMap hshValues);
	public void updateAnticipatedTurnover(HashMap hshValues);
	public HashMap getAnticipatedTurnover(HashMap hshValues);
	public HashMap getSSIpastData (HashMap hshValues);
	public void updateSSIpastData (HashMap hshValues);
}