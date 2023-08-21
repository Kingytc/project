package com.sai.laps.ejb.bankgetdata;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface BankGetAppRemote 
{
	public HashMap getTermData(HashMap hshValues);
	public HashMap getBankData(HashMap hshValues);
}