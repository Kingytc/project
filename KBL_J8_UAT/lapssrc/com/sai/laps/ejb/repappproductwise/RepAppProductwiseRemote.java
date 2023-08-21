///////////////////////////////////////////////////////////
// DeJaved by mDeJava v1.0. Copyright 1999 MoleSoftware. //
//       To download last version of this software:      //
//            http://molesoftware.hypermatr.net          //
//               e-mail:molesoftware@mail.ru             //
///////////////////////////////////////////////////////////
//          JAD JavaDecompiler by Pavel Kuznetsov        //
// www.geocities.com/SiliconValley/Bridge/8617/jad.html  //
///////////////////////////////////////////////////////////

package com.sai.laps.ejb.repappproductwise;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.EJBObject;
import javax.ejb.Remote;
@Remote
public interface RepAppProductwiseRemote
    
{
	
    public abstract HashMap getData(HashMap hashtable)
       ;
    public HashMap getMonthlyStatement(HashMap hashtable)
   ;
    public abstract HashMap gettenlacsStatement(HashMap hashtable)
   ;
    public abstract HashMap gettenlacsStatement1(HashMap hashtable)
   ;
}

