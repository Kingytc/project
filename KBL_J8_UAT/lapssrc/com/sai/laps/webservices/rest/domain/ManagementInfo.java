package com.sai.laps.webservices.rest.domain;

public class ManagementInfo {
	
	private String commentsOn;
	private String comments;

	public ManagementInfo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ManagementInfo(String commentsOn, String comments) {
		super();
		this.commentsOn = commentsOn;
		this.comments = comments;
	}
	
	public String getCommentsOn() {
		return commentsOn;
	}
	public void setCommentsOn(String commentsOn) {
		this.commentsOn = commentsOn;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
}
