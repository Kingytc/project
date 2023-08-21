package com.sai.laps.ejb.edudetails;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface EdudetailsRemote 
{
	public void updateData(HashMap hshValues);
	public HashMap getData(HashMap hshValues);
}