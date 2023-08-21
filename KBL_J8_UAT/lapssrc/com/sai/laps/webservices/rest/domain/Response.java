package com.sai.laps.webservices.rest.domain;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class Response implements Serializable {
	private static final long serialVersionUID = 1L;
	private Map<String,Object> data;
	private String resp_code;
	private String resp_msg;
	public Response(){
		super();
	}
	public Response(HashMap<String,Object> data,String resp_code,String resp_msg){
		this.data = data;
		this.resp_code = resp_code;
		this.resp_msg = resp_msg;
	}
	public Map<String, Object> getData() {
		return data;
	}
	public void setData(Map<String, Object> data) {
		this.data = data;
	}
	public String getResp_code() {
		return resp_code;
	}
	public void setResp_code(String resp_code) {
		this.resp_code = resp_code;
	}
	public String getResp_msg() {
		return resp_msg;
	}
	public void setResp_msg(String resp_msg) {
		this.resp_msg = resp_msg;
	}
	//@Override
	public String toString() {
		return super.toString();
	}
}
