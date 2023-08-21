package com.sai.laps.ejb.corpupload;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.EJBObject;
import javax.ejb.Remote;
@Remote
public interface corpuploadRemote
    
{

    public abstract HashMap getAppno(HashMap hshmap)
       ;
}
