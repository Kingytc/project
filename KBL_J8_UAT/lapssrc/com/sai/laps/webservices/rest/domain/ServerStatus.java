package com.sai.laps.webservices.rest.domain;

import java.util.List;

public class ServerStatus {

	private List<servers> servers;

	
	public ServerStatus() {
		super();
	}

	public ServerStatus(List<servers> servers) {
		super();
		
		this.setServers(servers);
	}

	public void setServers(List<servers> servers) {
		this.servers = servers;
	}

	public List<servers> getServers() {
		return servers;
	}
	
}
