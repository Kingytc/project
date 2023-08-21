package com.sai.laps.webservices.rest.domain.msme;

public class DigiRating {

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

	
	public  DigiRating() {
		super();
		// TODO Auto-generated constructor stub
	
	}
	
	public DigiRating(String commercialBureauScore,String consumerIndScore, String consumerPartyScore,String odAccountScore,
			String currentAccountScore,String fsaScore,	String bandRating,String bandPath,String kbRating,String findigitype,String findigiyear)
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
	
	
	
	
}
