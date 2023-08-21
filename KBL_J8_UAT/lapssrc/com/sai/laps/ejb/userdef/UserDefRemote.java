package com.sai.laps.ejb.userdef;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface UserDefRemote 
{
	public HashMap getData(HashMap hshRequestValues);
}