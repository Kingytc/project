package com.sai.laps.ejb.agrcoffee;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface agrcoffeeRemote 
{
	public void updateCoffeeEstateData(HashMap hshValues);
	public HashMap getCoffeeEstateData(HashMap hshValues);
	public HashMap updatecoffeeplantdata(HashMap hshValues);
	public HashMap getcoffeeplantdata(HashMap hshValues);
	public HashMap updatecoffeepreviousdata(HashMap hshValues);
	public HashMap getcoffeepreviousdata(HashMap hshValues);
	public HashMap updatecoffeeinterdata(HashMap hshValues);
	public HashMap getcoffeeinterdata(HashMap hshValues);
	public void updatecoffeesourcesdata(HashMap hshValues);
	public HashMap getcoffeesourcesdata(HashMap hshValues);
	public HashMap getcoffeeassesment(HashMap hshValues);
	public HashMap updateinterassesment(HashMap hshValues);
	public HashMap getinterassesment(HashMap hshValues);
	public void updatecoffeeassesment(HashMap hshValues);
	public void updatecoffeetermtechdata(HashMap hshValues);
	public HashMap getcoffeetermtechdata(HashMap hshValues);
	public HashMap getcoffeeeconomicsdata(HashMap hshValues);
	public HashMap updatecoffeeeconomicsdata(HashMap hshValues);
	public HashMap getcoffeetermcashflow(HashMap hshValues);
	public HashMap updatecoffeetermcashflow(HashMap hshValues);
	public HashMap getcoffeetermeligibility(HashMap hshValues);
	public void updatecoffeetermeligibility(HashMap hshValues);
	public HashMap updatecoffeetermrepayment(HashMap hshValues);
	public HashMap getcoffeetermrepayment(HashMap hshValues);
	public void updateseritechdata(HashMap hshValues);
	public HashMap getseritechdata(HashMap hshValues);
	public HashMap updateseriloanreq(HashMap hshValues);
	public HashMap getseriloanreq(HashMap hshValues);
	public void updateserieconomics(HashMap hshValues);
	public HashMap getserieconomics(HashMap hshValues);
	public void updatesericashflow(HashMap hshValues);
	public HashMap getsericashflow(HashMap hshValues);
	public void updateplantationtechdata(HashMap hshValues);
	public HashMap getplantationtechdata(HashMap hshValues);
}