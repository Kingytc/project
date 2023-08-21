package com.sai.laps.ejb.agreconomic;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface agrEconomicRemote 
{
	public void updateEconomicData(HashMap hshRequestValues);
	public HashMap getEconomicData(HashMap hshValues);
	public void updatediaryfinData(HashMap hshRequestValues);
	public HashMap getdiaryfinData(HashMap hshValues);
	public void updatecroptermData(HashMap hshRequestValues);
	public HashMap getcroptermData(HashMap hshValues);
	public void updatecroptermassData(HashMap hshRequestValues);
	public void updatecashflowData(HashMap hshRequestValues);
	public HashMap getcashflowData(HashMap hshValues);
	public void updatefarmMechData(HashMap hshRequestValues);
	public HashMap getfarmMechData(HashMap hshValues);
	public void updatefarmMechTechData(HashMap hshRequestValues);
	public HashMap getfarmMechTechData(HashMap hshValues);
	public void updatefarmMechDataEMI(HashMap hshRequestValues);
	public HashMap getfarmMechDataEMI(HashMap hshValues);
	public void  updatefarmMechMinorIrrig(HashMap hshRequestValues);
	public HashMap  getfarmMechMinorIrrig(HashMap hshValues);
	public void  updateVehicleParticulars(HashMap hshRequestValues);
	public HashMap  getVehicleParticulars(HashMap hshValues);
	public void updateVehicleApplicantPart(HashMap hshRequestValues);
	public HashMap getVehicleApplicantPart(HashMap hshValues);
	public HashMap getUpdateQueryData(HashMap hshValues);
	public void updatechangeorgData(HashMap hshRequestValues);
	public HashMap getfarmMechreport(HashMap hsh);
	public HashMap getFisheryParticularsData(HashMap hsh);
	public void updateFisheryParticularsData(HashMap hshRequestValues);
	//Added for ProjectDetails by Venkat Prasad on 07/12/2013
	public void updateSericultreProjectDetails(HashMap hshValues);
	public HashMap getSericultreProjectDetails(HashMap hshValues);
	public void updateSericultureIncomeExp(HashMap hshValues);
	public HashMap getSericultureIncomeExp(HashMap hshValues);
	//Added for ToboccoDetails by Venkat Prasad on 07/12/2013
	public void updateTobaccoDetails(HashMap hshValues);
	public HashMap getTobaccoDetails(HashMap hshValues);
	//GOBAR GAS DETAILS ADDED ON 09-12-2013 BY VENKATA PRASAD CHOWDARY
	public HashMap updategobartechdata(HashMap hshValues);
	public HashMap getgobartechdata(HashMap hshValues);
	//Plantation & Horticulture--> Income & Expenditure DETAILS ADDED ON 10-12-2013 BY VENKATA PRASAD CHOWDARY
	public HashMap getHorticultureIncomeExp(HashMap hshValues);
	public void updateSolarlightData(HashMap hshValues);
	public HashMap getSolarlightData(HashMap hshValues);
	//Added for Sericulture-Income Statement by rajesh on 01/03/2014
	public void updateSericultureIncomeStatement(HashMap hshValues);
	public HashMap getSericultureIncomeStatement(HashMap hshValues);

}