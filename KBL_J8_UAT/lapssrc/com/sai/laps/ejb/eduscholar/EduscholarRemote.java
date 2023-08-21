package com.sai.laps.ejb.eduscholar;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface EduscholarRemote 
{
	public void updateData(HashMap hshValues);
	public HashMap getData(HashMap hshValues);
	//karthikeyan for collage expences.
	public void updateDataExp(HashMap hshRequestValues);
	public  HashMap getDataExp(HashMap hshValues);
}