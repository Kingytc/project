package com.sai.laps.ejb.loaninterestrate;

import java.util.HashMap;

import javax.ejb.Remote;

@Remote
public interface LoanInterestRateRemote {
	public HashMap checkLoanInterestModify(HashMap hshRequestValues);	
}
