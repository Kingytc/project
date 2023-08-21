/**
 * 
 */
package com.sai.laps.webservices.rest.domain;

/**
 * @author vindhya.g
 *
 */
public class GoldDetails {
	

	/**
	 * 
	 */
	private String article_no;
	private String description_of_articles;
	private String quantity;
	private String gross;
	private String net;
	private String purity;
	private String last_market_rate;
	private String average_rate;
	private String estimated_val;
	
	public GoldDetails() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	public GoldDetails(String article_no,String description_of_articles, String quantity, String gross, String net, String purity,
			String last_market_rate, String average_rate, String estimated_val) {
		super();
		this.article_no=article_no;
		this.description_of_articles = description_of_articles;
		this.quantity = quantity;
		this.gross = gross;
		this.net = net;
		this.purity = purity;
		this.last_market_rate = last_market_rate;
		this.average_rate = average_rate;
		this.estimated_val = estimated_val;
	}

	
	public String getDescription_of_articles() {
		return description_of_articles;
	}

	public void setDescription_of_articles(String description_of_articles) {
		this.description_of_articles = description_of_articles;
	}

	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	public String getGross() {
		return gross;
	}

	public void setGross(String gross) {
		this.gross = gross;
	}

	public String getNet() {
		return net;
	}

	public void setNet(String net) {
		this.net = net;
	}

	public String getPurity() {
		return purity;
	}

	public void setPurity(String purity) {
		this.purity = purity;
	}

	public String getLast_market_rate() {
		return last_market_rate;
	}

	public void setLast_market_rate(String last_market_rate) {
		this.last_market_rate = last_market_rate;
	}

	public String getAverage_rate() {
		return average_rate;
	}

	public void setAverage_rate(String average_rate) {
		this.average_rate = average_rate;
	}

	public String getEstimated_val() {
		return estimated_val;
	}

	public void setEstimated_val(String estimated_val) {
		this.estimated_val = estimated_val;
	}


	public String getArticle_no() {
		return article_no;
	}


	public void setArticle_no(String article_no) {
		this.article_no = article_no;
	}

	
}
