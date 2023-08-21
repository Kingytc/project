package com.sai.laps.webservices.rest;

import java.util.HashSet;
import java.util.Set;

import javax.ws.rs.core.Application;

import com.sai.laps.webservices.rest.LOSRestServices;

public class RestApplicationScanner extends Application {
	private Set<Object> singletons = new HashSet<Object>();

	public RestApplicationScanner() {
		System.out.println("===========RestApplicationScanner Initiated=============");
		singletons.add(new LOSRestServices());
		//singletons.add(new TokenGeneration());
	}

	@Override
	public Set<Object> getSingletons() {
		return singletons;
	}
}
