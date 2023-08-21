package com.sai.laps.ejb.setusers;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface SetUsersRemote 
{
	public void updateData(HashMap hshValues);
	public HashMap getData(HashMap hshRequestValues);
	public HashMap getUserList(HashMap hshRequestValues);
	public HashMap getOrgList(HashMap hshRequestValues);
	public HashMap getOrgLocationData(HashMap hshRequestValues);
	//public HashMap getBranchRefListData(HashMap hshRequestValues);
	public HashMap getUploaddata(HashMap hshRequestValues);
	public HashMap getOrgUploaddata(HashMap hshRequestValues);	
	public HashMap getUserSearchData(HashMap hshRequestValues);
	public HashMap getLockedUserSearchData(HashMap hshRequestValues);
	public HashMap UnLockUsers(HashMap hshRequestValues);
	public String doSelfSACMethod(HashMap hshRequestValues);
	public HashMap getUserSearchDataforLopv(HashMap hshRequestValues);
	public HashMap getUserSearchDataforddrbir(HashMap hshRequestValues);
}
