package com.sai.laps.webservices.rest.domain.msme;

public class FinancialDigiRating {


	private String commercialBureauScore;
	private String consumerIndScore;
	private String consumerPartyScore;
	private String odAccountScore;
	private String currentAccountScore;
	private String fsaScore;
	private String bandRating;
	private String bandPath;
	private String kbRating;
	private String findigitype;
	private String findigiyear;
	private String lapsProposalNumber;
	private String lapsCBSid;
	private String lapsFinanceId;
	private String lapsUserId;
	private String lapsCMAmastId;
	private String finComments;
	private String finAppHOlder;
	private String finAppName;
	private String orgScode;
	private String finPartyFile;
	private String finProcessedBy;
	private String finProcessedOn;
	private String finStatus;

	
	public  FinancialDigiRating() {
		super();
		// TODO Auto-generated constructor stub
	
	}
	
	public FinancialDigiRating(String commercialBureauScore,String consumerIndScore, String consumerPartyScore,String odAccountScore,
			String currentAccountScore,String fsaScore,	String bandRating,String bandPath,String kbRating,String findigitype,
			String findigiyear,String lapsProposalNumber,String lapsCBSid,String lapsFinanceId,String lapsUserId,String lapsCMAmastId,
			String finComments,String finAppHOlder,String finAppName,String orgScode,String finPartyFile,String finProcessedBy,String finProcessedOn,String finStatus)
	{
		this.commercialBureauScore=commercialBureauScore;
		this.consumerIndScore=consumerIndScore;
		this.consumerPartyScore=consumerPartyScore;
		this.odAccountScore=odAccountScore;
		this.currentAccountScore=currentAccountScore;
		this.fsaScore=fsaScore;
		this.bandRating=bandRating;
		this.bandPath=bandPath;
		this.kbRating=kbRating;
		this.findigitype=findigitype;
		this.findigiyear=findigiyear;
		this.setLapsProposalNumber(lapsProposalNumber);
		this.setLapsCBSid(lapsCBSid);
		this.setLapsFinanceId(lapsFinanceId);
		this.setLapsUserId(lapsUserId);
		this.setLapsCMAmastId(lapsCMAmastId);
		this.setFinComments(finComments);
		this.setFinAppHOlder(finAppHOlder);
		this.setFinAppName(finAppName);
		this.setOrgScode(orgScode);
		this.setFinPartyFile(finPartyFile);
		this.setFinProcessedBy(finProcessedBy);
		this.setFinProcessedOn(finProcessedOn);
		this.setFinStatus(finStatus);
		
	}

	public String getCommercialBureauScore() {
		return commercialBureauScore;
	}

	public void setCommercialBureauScore(String commercialBureauScore) {
		this.commercialBureauScore = commercialBureauScore;
	}

	public String getConsumerIndScore() {
		return consumerIndScore;
	}

	public void setConsumerIndScore(String consumerIndScore) {
		this.consumerIndScore = consumerIndScore;
	}

	public String getConsumerPartyScore() {
		return consumerPartyScore;
	}

	public void setConsumerPartyScore(String consumerPartyScore) {
		this.consumerPartyScore = consumerPartyScore;
	}

	public String getOdAccountScore() {
		return odAccountScore;
	}

	public void setOdAccountScore(String odAccountScore) {
		this.odAccountScore = odAccountScore;
	}

	public String getCurrentAccountScore() {
		return currentAccountScore;
	}

	public void setCurrentAccountScore(String currentAccountScore) {
		this.currentAccountScore = currentAccountScore;
	}

	public String getFsaScore() {
		return fsaScore;
	}

	public void setFsaScore(String fsaScore) {
		this.fsaScore = fsaScore;
	}

	public String getBandRating() {
		return bandRating;
	}

	public void setBandRating(String bandRating) {
		this.bandRating = bandRating;
	}

	public String getBandPath() {
		return bandPath;
	}

	public void setBandPath(String bandPath) {
		this.bandPath = bandPath;
	}

	public String getKbRating() {
		return kbRating;
	}

	public void setKbRating(String kbRating) {
		this.kbRating = kbRating;
	}

	public void setFindigitype(String findigitype) {
		this.findigitype = findigitype;
	}

	public String getFindigitype() {
		return findigitype;
	}

	public void setFindigiyear(String findigiyear) {
		this.findigiyear = findigiyear;
	}

	public String getFindigiyear() {
		return findigiyear;
	}

	public void setLapsProposalNumber(String lapsProposalNumber) {
		this.lapsProposalNumber = lapsProposalNumber;
	}

	public String getLapsProposalNumber() {
		return lapsProposalNumber;
	}

	public void setLapsCBSid(String lapsCBSid) {
		this.lapsCBSid = lapsCBSid;
	}

	public String getLapsCBSid() {
		return lapsCBSid;
	}

	public void setLapsFinanceId(String lapsFinanceId) {
		this.lapsFinanceId = lapsFinanceId;
	}

	public String getLapsFinanceId() {
		return lapsFinanceId;
	}

	public void setLapsUserId(String lapsUserId) {
		this.lapsUserId = lapsUserId;
	}

	public String getLapsUserId() {
		return lapsUserId;
	}

	public void setLapsCMAmastId(String lapsCMAmastId) {
		this.lapsCMAmastId = lapsCMAmastId;
	}

	public String getLapsCMAmastId() {
		return lapsCMAmastId;
	}

	public void setFinComments(String finComments) {
		this.finComments = finComments;
	}

	public String getFinComments() {
		return finComments;
	}

	public void setFinAppHOlder(String finAppHOlder) {
		this.finAppHOlder = finAppHOlder;
	}

	public String getFinAppHOlder() {
		return finAppHOlder;
	}

	public void setFinAppName(String finAppName) {
		this.finAppName = finAppName;
	}

	public String getFinAppName() {
		return finAppName;
	}

	public void setOrgScode(String orgScode) {
		this.orgScode = orgScode;
	}

	public String getOrgScode() {
		return orgScode;
	}

	public void setFinPartyFile(String finPartyFile) {
		this.finPartyFile = finPartyFile;
	}

	public String getFinPartyFile() {
		return finPartyFile;
	}

	public void setFinProcessedBy(String finProcessedBy) {
		this.finProcessedBy = finProcessedBy;
	}

	public String getFinProcessedBy() {
		return finProcessedBy;
	}

	public void setFinProcessedOn(String finProcessedOn) {
		this.finProcessedOn = finProcessedOn;
	}

	public String getFinProcessedOn() {
		return finProcessedOn;
	}

	public void setFinStatus(String finStatus) {
		this.finStatus = finStatus;
	}

	public String getFinStatus() {
		return finStatus;
	}
	
	
	
	


}
