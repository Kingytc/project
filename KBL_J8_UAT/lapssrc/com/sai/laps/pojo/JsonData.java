package com.sai.laps.pojo;

public class JsonData {

	public String token;
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public String getRequest() {
		return Request;
	}
	public void setRequest(String request) {
		Request = request;
	}
	public String getResponse() {
		return Response;
	}
	public void setResponse(String response) {
		Response = response;
	}
	public String Request;
	public String Response;
	
	public String errorcode;
	public String getErrorcode() {
		return errorcode;
	}
	public void setErrorcode(String errorcode) {
		this.errorcode = errorcode;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String status;
	
	public String ErrorDescription;
	public String getErrorDescription() {
		return ErrorDescription;
	}
	public void setErrorDescription(String errorDescription) {
		ErrorDescription = errorDescription;
	}
	
	public String getScope() {
		return scope;
	}
	public void setScope(String scope) {
		this.scope = scope;
	}
	public String getReqTime() {
		return ReqTime;
	}
	public void setReqTime(String reqTime) {
		ReqTime = reqTime;
	}
	public String getServiceName() {
		return ServiceName;
	}
	public void setServiceName(String serviceName) {
		ServiceName = serviceName;
	}
	public String getResTime() {
		return ResTime;
	}
	public void setResTime(String resTime) {
		ResTime = resTime;
	}
	private String scope;
	private String ReqTime;
	private String ServiceName;
	private String ResTime;
	//grant_type=client_credentials&client_id=92c2d9b9793695f7bd9aaa411d7657e0&client_secret=7a1980519b524854cfdf25cef98a95e9&scope=CCFM
	
	private String grant_type;
	public String getGrant_type() {
		return grant_type;
	}
	public void setGrant_type(String grant_type) {
		this.grant_type = grant_type;
	}
	public String getClient_id() {
		return client_id;
	}
	public void setClient_id(String client_id) {
		this.client_id = client_id;
	}
	public String getClient_secret() {
		return client_secret;
	}
	public void setClient_secret(String client_secret) {
		this.client_secret = client_secret;
	}
	private String client_id;
	private String client_secret;
	
	
	
	
}
