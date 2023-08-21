/**
 * 
 */
package com.sai.laps.webservices.rest.domain;

/**
 * @author vindhya.g
 *
 */
public class Userdesignation {
	private String userid;
	private String designationcode;
	private String usergroupcode;
	
	public Userdesignation() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Userdesignation(String userid, String designationcode, String usergroupcode) {
		super();
		this.userid = userid;
		this.designationcode = designationcode;
		this.usergroupcode = usergroupcode;
		
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getDesignationcode() {
		return designationcode;
	}
	public void setDesignationcode(String designationcode) {
		this.designationcode = designationcode;
	}
	public String getUsergroupcode() {
		return usergroupcode;
	}
	public void setUsergroupcode(String usergroupcode) {
		this.usergroupcode = usergroupcode;
	}
		
}
