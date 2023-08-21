package com.sai.laps.ejb.Instructions;
import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;

@Remote
public interface InstructionsRemote 
{	
	public void updateInstructions(HashMap hshValues);
	public HashMap getInstructionsData(HashMap hshRequestValues);
}