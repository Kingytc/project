package com.sai.laps.ejb.netownedfunds;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface NetOwnedFundsRemote 
{
		
		public HashMap UpdateNetOwnedFundsData(HashMap hshRequestValues);
		public HashMap getData(HashMap hshRequestValues);

}