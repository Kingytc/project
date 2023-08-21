package com.sai.laps.ejb.mailboxcomments;

import javax.ejb.*;
import javax.ejb.Remote;

import java.rmi.*;
import java.util.*;
@Remote
public interface MailboxCommentsRemote 
{
	public HashMap getData(HashMap hshValues);
	public void updateData(HashMap hshValues);
	
	public HashMap getReviewTermLoanData(HashMap hshValues);
	public void updateReviewTermLoanData(HashMap hshValues);
	
	public HashMap getMMRComments(HashMap hshValues);
	public void updateMMRComments(HashMap hshValues);
	public HashMap getRemarksData(HashMap hshValues);
}
