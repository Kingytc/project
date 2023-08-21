package com.sai.laps.ejb.comtermscondition;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface comtermsconditionRemote 
{
		
		public HashMap UpdateComTermsConData(HashMap hshRequestValues);
		public HashMap getComTermsConData(HashMap hshRequestValues);
		public HashMap getModifyData(HashMap hsh);

}