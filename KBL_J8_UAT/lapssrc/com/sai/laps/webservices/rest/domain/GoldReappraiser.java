/**
 * 
 */
package com.sai.laps.webservices.rest.domain;

import java.util.List;

/**
 * @author madhusudhan.vr
 *
 */
public class GoldReappraiser {

	/**
	 * 
	 */
	private String cbsId;
	private String appno;
	private String reappraisedon; 
	private List<GoldDetails> golddetails;
	public String token;
	private String restime;
	public GoldReappraiser() {
		// TODO Auto-generated constructor stub
		 super();
	}
	public GoldReappraiser(String cbsId,String appno,String reappraisedon,List<GoldDetails> golddetails,String token,String restime) {
		// TODO Auto-generated constructor stub
		 super();
		 this.cbsId=cbsId;
		 this.appno=appno;
		 this.reappraisedon=reappraisedon;
		 this.setGolddetails(golddetails);
		 this.golddetails=golddetails;
		 this.restime=restime;
	}
	public List<GoldDetails> getGolddetails() {
		return golddetails;
	}
	public void setGolddetails(List<GoldDetails> golddetails) {
		this.golddetails = golddetails;
	}
	public String getCbsId() {
		return cbsId;
	}
	public void setCbsId(String cbsId) {
		this.cbsId = cbsId;
	}
	public String getAppno() {
		return appno;
	}
	public void setAppno(String appno) {
		this.appno = appno;
	}
	public String getReappraisedon() {
		return reappraisedon;
	}
	public void setReappraisedon(String reappraisedon) {
		this.reappraisedon = reappraisedon;
	}
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public String getRestime() {
		return restime;
	}
	public void setRestime(String restime) {
		this.restime = restime;
	}

}
