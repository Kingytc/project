/**
 * 
 */
package com.sai.laps.webservices.rest.domain;

/**
 * @author vindhya.g
 *
 */
public class UserUpdation {
	private String userid;
	private String sol_id;
	public UserUpdation() {
		super();
		// TODO Auto-generated constructor stub
	}
	public UserUpdation(String userid, String sol_id) {
		super();
		this.userid = userid;
		this.sol_id = sol_id;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getSol_id() {
		return sol_id;
	}
	public void setSol_id(String sol_id) {
		this.sol_id = sol_id;
	}
	
	
	
	
	
}
