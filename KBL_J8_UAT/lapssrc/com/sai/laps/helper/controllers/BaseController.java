package com.sai.laps.helper.controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sai.laps.helper.ControllerServlet;
/**
 *@author : S.SATHYA MOORTHY
 *@date   :Mar 13, 2009 :12:16:11 PM
 *@description :This module act as a primary controller of all service controllers.
 *@todo :LOADING OF ALL RESOURCES OF LAPS.
 */
public class BaseController extends ControllerServlet{
	
	private static final long serialVersionUID = 1L;

	public BaseController() {
		super();
		// TODO Auto-generated constructor stub
    }
   public void init() throws ServletException {
	// TODO Auto-generated method stub
	//super.init();//BASE CONTROLLER SUPER.INIT() SHOULD BE COMMENTED TO AVOID THE RELOADING OF INIT METHOD WHEN PARITICULAR
	   //SERVICECONTROLLER IS INVOKED.@SATHYA.
   }
   public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	// TODO Auto-generated method stub
	super.service(request, response);
   }
   public void destroy() {
	// TODO Auto-generated method stub
	super.destroy();
   }
   
}