package com.sai.laps.webservices.rest.domain;

public class UserCreation {
	
	private String userid;
	private String usergroupcode;
	private String user_solid;
	private String firstname;	
	private String lastname;
	private String password;
	private String classcode;
	private String designationcode;
	private String emailid;
	private String departmentcode;
	public UserCreation() {
		super();
		// TODO Auto-generated constructor stub
	}
	public UserCreation(String userid, String usergroupcode, String user_solid, String firstname, String lastname,
			String password, String classcode, String designationcode, String emailid, String departmentcode) {
		super();
		this.userid = userid;
		this.usergroupcode = usergroupcode;
		this.user_solid = user_solid;
		this.firstname = firstname;
		this.lastname = lastname;
		this.password = password;
		this.classcode = classcode;
		this.designationcode = designationcode;
		this.emailid = emailid;
		this.departmentcode = departmentcode;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUsergroupcode() {
		return usergroupcode;
	}
	public void setUsergroupcode(String usergroupcode) {
		this.usergroupcode = usergroupcode;
	}
	public String getUser_solid() {
		return user_solid;
	}
	public void setUser_solid(String user_solid) {
		this.user_solid = user_solid;
	}
	public String getFirstname() {
		return firstname;
	}
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	public String getLastname() {
		return lastname;
	}
	public void setLastname(String lastname) {
		this.lastname = lastname;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getClasscode() {
		return classcode;
	}
	public void setClasscode(String classcode) {
		this.classcode = classcode;
	}
	public String getDesignationcode() {
		return designationcode;
	}
	public void setDesignationcode(String designationcode) {
		this.designationcode = designationcode;
	}
	public String getEmailid() {
		return emailid;
	}
	public void setEmailid(String emailid) {
		this.emailid = emailid;
	}
	public String getDepartmentcode() {
		return departmentcode;
	}
	public void setDepartmentcode(String departmentcode) {
		this.departmentcode = departmentcode;
	}
	

}
