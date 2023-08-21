package com.sai.laps.ejb.percollateral;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface PerCollateralRemote 
{
	public HashMap getData(HashMap hshValues);
	public void updatehome(HashMap hshValues);
	public HashMap getBoatAuto(HashMap hshValues);
	public HashMap getCollVehicleData(HashMap hshValues);
	public void updateCollVehicle(HashMap hshValues);
	//for due to deligenece salaired

	public HashMap updateBoatAutoprim(HashMap hshValues);
	public HashMap getUsers(HashMap hshValues);
	//public HashMap getVehicleData(HashMap hshValues);
	//public void updateDataVehicleinfo(HashMap hshValues);
	//public HashMap getDataVechicleinfo(HashMap hshValues);
	
	public void updateVerification(HashMap hshValues);
	public HashMap getVerification(HashMap hshValues);
	public HashMap getStaffvechicle(HashMap hshValues);
	



}
