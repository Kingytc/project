package com.sai.laps.webservices.rest.domain;

public class GoldOrnaments {

	private String articleType;
	private String grossWeight;
	private String netWeight;
	private String purity;
	private String lastMarkertRate;
	private String closingGoldRate;
	private String estimatedValue;
	private String quantity;
	private String netValue;
	private String articleTypeGO;
	
	
	public  GoldOrnaments() {
		super();
		// TODO Auto-generated constructor stub
	
	}
	
	public GoldOrnaments(String articleType,String grossWeight, String netWeight,String purity,
			String lastMarkertRate,String closingGoldRate,	String estimatedValue,String quantity,String netValue,String articleTypeGO)
	{
		this.setArticleType(articleType);
		this.setGrossWeight(grossWeight);
		this.setPurity(purity);
		this.setLastMarkertRate(lastMarkertRate);
		this.setClosingGoldRate(closingGoldRate);
		this.setEstimatedValue(estimatedValue);
		this.setQuantity(quantity);
		this.setNetValue(netValue);
		this.setArticleTypeGO(articleTypeGO);
		
	}

	public void setArticleType(String articleType) {
		this.articleType = articleType;
	}

	public String getArticleType() {
		return articleType;
	}

	public void setGrossWeight(String grossWeight) {
		this.grossWeight = grossWeight;
	}

	public String getGrossWeight() {
		return grossWeight;
	}

	public void setNetWeight(String netWeight) {
		this.netWeight = netWeight;
	}

	public String getNetWeight() {
		return netWeight;
	}

	public void setPurity(String purity) {
		this.purity = purity;
	}

	public String getPurity() {
		return purity;
	}

	public void setLastMarkertRate(String lastMarkertRate) {
		this.lastMarkertRate = lastMarkertRate;
	}

	public String getLastMarkertRate() {
		return lastMarkertRate;
	}

	public void setClosingGoldRate(String closingGoldRate) {
		this.closingGoldRate = closingGoldRate;
	}

	public String getClosingGoldRate() {
		return closingGoldRate;
	}

	public void setEstimatedValue(String estimatedValue) {
		this.estimatedValue = estimatedValue;
	}

	public String getEstimatedValue() {
		return estimatedValue;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	public String getQuantity() {
		return quantity;
	}

	public void setNetValue(String netValue) {
		this.netValue = netValue;
	}

	public String getNetValue() {
		return netValue;
	}

	public String getArticleTypeGO() {
		return articleTypeGO;
	}

	public void setArticleTypeGO(String articleTypeGO) {
		this.articleTypeGO = articleTypeGO;
	}
	
	
}
