package com.sai.laps.ejb.orgdetails;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface OrgDetailsRemote 
{
	public HashMap getData(HashMap hshRequestValues);
}