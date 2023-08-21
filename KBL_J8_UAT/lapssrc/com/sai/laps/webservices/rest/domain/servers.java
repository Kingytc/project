package com.sai.laps.webservices.rest.domain;

public class servers {
	private String serverIp;
	private String serverPort;
	private String serverType;
	
	public servers() {
		super();
	}

	public servers(String serverIp,String serverPort,String serverType) {
		super();
		
		this.serverIp=serverIp;
		this.serverPort=serverPort;
		this.serverType=serverType;
	}
	
	public void setServerIp(String serverIp) {
		this.serverIp = serverIp;
	}
	public String getServerIp() {
		return serverIp;
	}
	public void setServerPort(String serverPort) {
		this.serverPort = serverPort;
	}
	public String getServerPort() {
		return serverPort;
	}

	public void setServerType(String serverType) {
		this.serverType = serverType;
	}

	public String getServerType() {
		return serverType;
	}
	
	

}
