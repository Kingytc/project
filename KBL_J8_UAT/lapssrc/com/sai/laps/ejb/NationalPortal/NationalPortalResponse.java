
package com.sai.laps.ejb.NationalPortal;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name="Response")
@XmlAccessorType(XmlAccessType.FIELD)
public class NationalPortalResponse {

	@XmlElement(name="message")
	private String message;
	@XmlElement(name="data")
	private String data;
	@XmlElement(name="status")
	private String status;
	@XmlElement(name="success")
	private String success;
	@XmlElement(name="npStatus")
	private String npStatus;
	@XmlElement(name="body")
	private String body;
	@XmlElement(name="npMessage")
	private String npMessage;
	
	
	
	public String getNpMessage() {
		return npMessage;
	}
	public void setNpMessage(String npMessage) {
		this.npMessage = npMessage;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getSuccess() {
		return success;
	}
	public void setSuccess(String success) {
		this.success = success;
	}
	public String getNpStatus() {
		return npStatus;
	}
	public void setNpStatus(String npStatus) {
		this.npStatus = npStatus;
	}
	
	
	
}
