package com.sai.laps.ejb.agriculture;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.EJBObject;
import javax.ejb.Remote;
@Remote
public interface AgriMechanisedBoatRemote  {
	public HashMap getFinancialList(HashMap hshValues);
	public void updateFinancialList(HashMap hshValues);
	
	public HashMap getCatchesSurplusList(HashMap hshValues);
	public void updateCatchesSurplusList(HashMap hshValues);
	
	public HashMap getOperatingExpenses(HashMap hshValues);
	public void updateOperatingExpenses(HashMap hshValues);
	
	public HashMap getAnnexure(HashMap hshValues);
	public void updateAnnexure(HashMap hshValues);
	
//	public HashMap getAnnexureIII(HashMap hshValues);
//	public void updateAnnexureIII(HashMap hshValues);
	
//	public HashMap getIncomeExp1223(HashMap hshValues);
//	public void updateIncomeExp1223(HashMap hshValues);
	
//	public HashMap getQuestion(HashMap hshValues);
	
	
    public void updatebullockdata(HashMap hshValues);
	public HashMap getbullockdata(HashMap hshValues);
	
	public void updateBullockFinancial(HashMap hshValues);
	public HashMap getBullockFinancial(HashMap hshValues);
	
	public void updateLDdata(HashMap hshValues);
	public HashMap getLDdata(HashMap hshValues);
	
	public HashMap updatecapldata(HashMap hshValues);
	public HashMap getcapldata(HashMap hshValues);
	
	public HashMap getBullockEconomic(HashMap hshValues);
//	public HashMap updatecalydata(HashMap hshValues);
//	public HashMap getcalydata(HashMap hshValues);
	public HashMap updategobartechdata(HashMap hshValues);
	public HashMap getgobartechdata(HashMap hshValues);
	public void updategobarseligibilitydata(HashMap hshValues);
	
	public void updateBullockParticulars(HashMap hshValues);
	public HashMap getBullockParticulars(HashMap hshValues);
	//Added by Arsath on 05/03/2014 for New Page - Net Income
	public HashMap getNetincome(HashMap hshValues) ;
	
	public void updatecaplGoodsdata(HashMap hshValues);
	public HashMap getcaplGoodsdata(HashMap hshValues);
}
