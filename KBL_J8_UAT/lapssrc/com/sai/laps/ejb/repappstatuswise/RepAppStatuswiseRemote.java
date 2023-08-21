package com.sai.laps.ejb.repappstatuswise;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface RepAppStatuswiseRemote 
{
	public HashMap getData(HashMap hshRequestValues);
}