package com.sai.laps.ejb.processNote;
import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface processNoteRemote 
{
	public HashMap getAgriprocessnoteGeneral(HashMap hshvalues);
	
	public HashMap getTertiaryProcessNote(HashMap hshValues);
}