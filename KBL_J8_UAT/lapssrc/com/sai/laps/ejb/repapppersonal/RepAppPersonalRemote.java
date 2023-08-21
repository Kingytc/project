package com.sai.laps.ejb.repapppersonal;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface RepAppPersonalRemote 
{
	public HashMap getData(HashMap hshRequestValues);
}