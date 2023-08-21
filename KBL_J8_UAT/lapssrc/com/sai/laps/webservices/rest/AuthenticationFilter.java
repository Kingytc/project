package com.sai.laps.webservices.rest;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sai.laps.helper.ApplicationParams;
import com.sun.jersey.core.util.Base64;

import java.util.*;

public class AuthenticationFilter implements javax.servlet.Filter { 
	
	public static final String AUTHENTICATION_HEADER = "Authorization";

	//@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain filter) throws IOException, ServletException {
		if (request instanceof HttpServletRequest) {
			HttpServletRequest httpServletRequest = (HttpServletRequest) request;
			String authCredentials = httpServletRequest
					.getHeader(AUTHENTICATION_HEADER);

			boolean authenticationStatus = authenticate(authCredentials);

			if (authenticationStatus) {
				filter.doFilter(request, response);
			} else {
				if (response instanceof HttpServletResponse) {
					HttpServletResponse httpServletResponse = (HttpServletResponse) response;
					httpServletResponse
							.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
				}
			}
		}
	}

	//@Override
	public void destroy() {
	}

	//@Override
	public void init(FilterConfig arg0) throws ServletException {
	}
	
	
	public boolean authenticate(String authCredentials) {

		if (null == authCredentials)
			return false;
		final String encodedUserPassword = authCredentials.replaceFirst("Basic"+ " ", "");
		String usernameAndPassword = null;
		try
		{
			byte[] decodedBytes = Base64.decode(encodedUserPassword);
			usernameAndPassword = new String(decodedBytes, "UTF-8");
		}
		catch (IOException e) {
			e.printStackTrace();
		}
		final StringTokenizer tokenizer = new StringTokenizer(usernameAndPassword, ":");
		final String username = tokenizer.nextToken();
		final String password = tokenizer.nextToken();
		
		String lapsparamCredentials=ApplicationParams.getStrapicredential();
		
		final StringTokenizer lapsparamtokenizer = new StringTokenizer(lapsparamCredentials, ":");
		final String lapsparamUsername = lapsparamtokenizer.nextToken();
		final String lapsparamPassword = lapsparamtokenizer.nextToken();

		boolean authenticationStatus = lapsparamUsername.equals(username) && lapsparamPassword.equals(password);
		return authenticationStatus;
	}
	
}
 