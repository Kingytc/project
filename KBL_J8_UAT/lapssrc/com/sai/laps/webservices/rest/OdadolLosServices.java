package com.sai.laps.webservices.rest;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.sai.laps.helper.Constants;
import com.sai.laps.webservices.rest.domain.CustomerCreation;
import com.sai.laps.webservices.rest.domain.FinalInPrinciple;
import com.sai.laps.webservices.rest.domain.GetGoldRate;
import com.sai.laps.webservices.rest.domain.GoldReappraiser;
import com.sai.laps.webservices.rest.domain.InwardDetails;
import com.sai.laps.webservices.rest.domain.OrganisationDetails;
import com.sai.laps.webservices.rest.domain.ProposalCreation;
import com.sai.laps.webservices.rest.domain.StatusCheck;
import com.sai.laps.webservices.rest.services.InwardDetailService;
import com.sai.laps.webservices.rest.services.InwardDetailServiceImpl;

@Path("/LosServicesODAD")
public class OdadolLosServices {

	static Logger log = Logger.getLogger(OdadolLosServices.class);
	
	/*@POST
	@Path("ODADLarNoGeneration")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response saveInwarDetails(InwardDetails inwardDetail)
 	{
		try
		{	System.out.println("######### SaveInwardDetails SERVICE........");
			log.info("######### SaveInwardDetails SERVICE........");
			
			
			if(inwardDetail!=null){
				InwardDetailService restWebService = new InwardDetailServiceImpl();
				return Response.ok(restWebService.saveInwardDetails(inwardDetail)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}
		}
		catch (Exception e)
		{	
			System.out.println("######### SaveInwardDetails EXCEPTION........"+e.getMessage());
			log.info("######### SaveInwardDetails EXCEPTION........"+e.getMessage());
			return Response.status(Response.Status.FORBIDDEN).build();
		}
	}*/
	
	
	@POST
	@Path("ODADLarNoGeneration")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response saveInwarDetails(InputStream inputStream) throws Exception {
		BufferedReader httpReqReader = new BufferedReader(
				new InputStreamReader(inputStream));
		String lineRead1;
		StringBuffer sb1 = new StringBuffer();
		HashMap hashValResponse = new HashMap();
		String responseVal ="",strEsbStatus="";
		
		while ((lineRead1 = httpReqReader.readLine()) != null) {
			sb1.append(lineRead1);
		}
		String strServerResponse = sb1.toString();		
		Gson g = new Gson(); 
		com.sai.laps.pojo.JsonData response = new com.sai.laps.pojo.JsonData();
		GsonBuilder gsonBuilder1 = new GsonBuilder();
		Gson jsonObject1 = gsonBuilder1.create();
		try
		{
			hashValResponse.put("strServerResponse", strServerResponse);
			Gson g2 									= new Gson(); 
			InwardDetails inwardDetail = g2.fromJson(strServerResponse, InwardDetails.class);
			if(inwardDetail!=null){
				InwardDetailService restWebService = new InwardDetailServiceImpl();
				return Response.ok(restWebService.saveInwardDetails(inwardDetail)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}
		}
		catch (Exception e)
		{	
			System.out.println("######### SaveInwardDetails EXCEPTION........"+e.getMessage());
			log.info("######### SaveInwardDetails EXCEPTION........"+e.getMessage());
			return Response.status(Response.Status.FORBIDDEN).build();
		}
	}
	
	@POST
	@Path("/ODADProposalCreation")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response proposalCreation(InputStream inputStream) throws Exception {
		BufferedReader httpReqReader = new BufferedReader(
				new InputStreamReader(inputStream));
		String lineRead1;
		StringBuffer sb1 = new StringBuffer();
		HashMap hashValResponse = new HashMap();
		String responseVal ="",strEsbStatus="";
		
		while ((lineRead1 = httpReqReader.readLine()) != null) {
			sb1.append(lineRead1);
		}
		String strServerResponse = sb1.toString();		
		Gson g = new Gson(); 
		com.sai.laps.pojo.JsonData response = new com.sai.laps.pojo.JsonData();
		GsonBuilder gsonBuilder1 = new GsonBuilder();
		Gson jsonObject1 = gsonBuilder1.create();
		try
		{
			hashValResponse.put("strServerResponse", strServerResponse);
			Gson g2 									= new Gson(); 
			ProposalCreation ProposalCreation = g2.fromJson(strServerResponse, ProposalCreation.class);//(ProposalCreation ProposalCreation)
			System.out.println("######### Propoal Creation SERVICE........");
			log.info("######### Propoal Creation SERVICE........");
			if(ProposalCreation!=null){
				InwardDetailService restWebService = new InwardDetailServiceImpl();
				return Response.ok(restWebService.proposalCreation(ProposalCreation)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}
		}
		catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println("######### Propoal Creation EXCEPTION........"+e.getMessage());
			log.info("######### Propoal Creation SERVICE EXCEPTION........"+e.getMessage());
			return Response.status(Response.Status.FORBIDDEN).build();
		}
	}
	
	
	@POST
	@Path("/OdadCustomerCreation")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response customerCreation(InputStream inputStream) throws Exception {
		BufferedReader httpReqReader = new BufferedReader(
				new InputStreamReader(inputStream));
		String lineRead1;
		StringBuffer sb1 = new StringBuffer();
		HashMap hashValResponse = new HashMap();
		String responseVal ="",strEsbStatus="";
		
		while ((lineRead1 = httpReqReader.readLine()) != null) {
			sb1.append(lineRead1);
		}
		String strServerResponse = sb1.toString();		
		Gson g = new Gson(); 
		com.sai.laps.pojo.JsonData response = new com.sai.laps.pojo.JsonData();
		GsonBuilder gsonBuilder1 = new GsonBuilder();
		Gson jsonObject1 = gsonBuilder1.create();
		try
		{
			hashValResponse.put("strServerResponse", strServerResponse);
			Gson g2 									= new Gson(); 
			CustomerCreation CustomerCreation = g2.fromJson(strServerResponse, CustomerCreation.class);//(CustomerCreation CustomerCreation)		
			System.out.println("######### Customer Creation SERVICE........");
			log.info("######### Customer Creation SERVICE........");
			if(CustomerCreation!=null){
				InwardDetailService restWebService = new InwardDetailServiceImpl();
				return Response.ok(restWebService.perappid(CustomerCreation)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}
			
		}
		catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("######### Customer Creation EXCEPTION........"+e.getMessage());
			log.info("######### Customer Creation EXCEPTION........"+e.getMessage());
			return Response.status(Response.Status.FORBIDDEN).build();
		}
	}
	
	@POST
	@Path("/odadaccOpeningTriggerService")
	@Consumes({ MediaType.APPLICATION_JSON })
	@Produces({ MediaType.APPLICATION_JSON })
	public Response accountOpeningTriggerService(InputStream inputStream) throws Exception {
		BufferedReader httpReqReader = new BufferedReader(
				new InputStreamReader(inputStream));
		String lineRead1;
		StringBuffer sb1 = new StringBuffer();
		HashMap hashValResponse = new HashMap();
		String responseVal ="",strEsbStatus="";
		
		while ((lineRead1 = httpReqReader.readLine()) != null) {
			sb1.append(lineRead1);
		}
		String strServerResponse = sb1.toString();		
		Gson g = new Gson(); 
		com.sai.laps.pojo.JsonData response = new com.sai.laps.pojo.JsonData();
		GsonBuilder gsonBuilder1 = new GsonBuilder();
		Gson jsonObject1 = gsonBuilder1.create();
		try
		{
			hashValResponse.put("strServerResponse", strServerResponse);
			Gson g2 									= new Gson(); 
			StatusCheck statusCheck = g2.fromJson(strServerResponse, StatusCheck.class);//(StatusCheck statusCheck) {
		
			
			System.out.println("######### Account Opening Trigger Service called........");
			log.info("######### Account Opening Trigger Service called........");
			if (statusCheck != null) {
				InwardDetailService restWebService = new InwardDetailServiceImpl();
				return Response.ok(
						restWebService.accountOpeningTriggerService(statusCheck)).build();
						
			} else {
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("######### Account Opening Trigger Service EXCEPTION........"+e.getMessage());
			log.info("######### Account Opening Trigger Service EXCEPTION........"+e.getMessage());

			return Response.status(Response.Status.FORBIDDEN).build();
		}
}
	
	
	@POST
	@Path("/goldreappraiserdet")
	@Consumes({ MediaType.APPLICATION_JSON })
	@Produces({ MediaType.APPLICATION_JSON })
	public Response goldreappraiser(InputStream inputStream) throws Exception {
		BufferedReader httpReqReader = new BufferedReader(
				new InputStreamReader(inputStream));
		String lineRead1;
		StringBuffer sb1 = new StringBuffer();
		HashMap hashValResponse = new HashMap();
		String responseVal ="",strEsbStatus="";
		
		while ((lineRead1 = httpReqReader.readLine()) != null) {
			sb1.append(lineRead1);
		}
		String strServerResponse = sb1.toString();		
		Gson g = new Gson(); 
		com.sai.laps.pojo.JsonData response = new com.sai.laps.pojo.JsonData();
		GsonBuilder gsonBuilder1 = new GsonBuilder();
		Gson jsonObject1 = gsonBuilder1.create();
		try
		{
			hashValResponse.put("strServerResponse", strServerResponse);
			Gson g2 									= new Gson(); 
			GoldReappraiser goldReappraiser = g2.fromJson(strServerResponse, GoldReappraiser.class);//(StatusCheck statusCheck) {
		
			
			System.out.println("######### GOLD REAPPRAISER........");
			log.info("######### GOLD REAPPRAISER.........");
			if (goldReappraiser != null) {
				InwardDetailService restWebService = new InwardDetailServiceImpl();
				return Response.ok(
						restWebService.dogoldreappraiser(goldReappraiser)).build();
						
			} else {
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("######### GOLD REAPPRAISER........"+e.getMessage());
			log.info("######### GOLD REAPPRAISER......."+e.getMessage());

			return Response.status(Response.Status.FORBIDDEN).build();
		}
}
	
	
	@POST
	@Path("/getgoldratedet")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response goldrate(InputStream inputStream) throws Exception
 	{
		BufferedReader httpReqReader = new BufferedReader(
				new InputStreamReader(inputStream));
		String lineRead1;
		StringBuffer sb1 = new StringBuffer();
		HashMap hashValResponse = new HashMap();
		String responseVal ="",strEsbStatus="";
		
		while ((lineRead1 = httpReqReader.readLine()) != null) {
			sb1.append(lineRead1);
		}
		String strServerResponse = sb1.toString();		
		Gson g = new Gson(); 
		com.sai.laps.pojo.JsonData response = new com.sai.laps.pojo.JsonData();
		GsonBuilder gsonBuilder1 = new GsonBuilder();
		Gson jsonObject1 = gsonBuilder1.create();
		try
		{
			hashValResponse.put("strServerResponse", strServerResponse);
			Gson g2 									= new Gson(); 
			GetGoldRate getGoldRate = g2.fromJson(strServerResponse, GetGoldRate.class);//(StatusCheck statusCheck) {
		
			
			System.out.println("######### GOLD RATE DETAILS........");
			log.info("######### GOLD RATE DETAILS.........");
			if (getGoldRate != null) {
				InwardDetailService restWebService = new InwardDetailServiceImpl();
				return Response.ok(
						restWebService.getgoldrate(getGoldRate)).build();
						
			} else {
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("######### GOLD RATE DETAILS........");
			log.info("######### GOLD RATE DETAILS.........");

			return Response.status(Response.Status.FORBIDDEN).build();
		}
}
	
	@POST
	@Path("/getjewelappraiserlistdet")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response getjewelappraiserlistmethod(InputStream inputStream) throws Exception
 	{
		BufferedReader httpReqReader = new BufferedReader(
				new InputStreamReader(inputStream));
		String lineRead1;
		StringBuffer sb1 = new StringBuffer();
		HashMap hashValResponse = new HashMap();
		String responseVal ="",strEsbStatus="";
		
		while ((lineRead1 = httpReqReader.readLine()) != null) {
			sb1.append(lineRead1);
		}
		String strServerResponse = sb1.toString();		
		Gson g = new Gson(); 
		com.sai.laps.pojo.JsonData response = new com.sai.laps.pojo.JsonData();
		GsonBuilder gsonBuilder1 = new GsonBuilder();
		Gson jsonObject1 = gsonBuilder1.create();
		try
		{
			hashValResponse.put("strServerResponse", strServerResponse);
			Gson g2 									= new Gson(); 
			OrganisationDetails organisationDetails = g2.fromJson(strServerResponse, OrganisationDetails.class);//(StatusCheck statusCheck) {
		
			
			System.out.println("######### Appraiser LIST........");
			log.info("######### Appraiser LIST.........");
			if (organisationDetails != null) {
				InwardDetailService restWebService = new InwardDetailServiceImpl();
				return Response.ok(
						restWebService.getjewelappraiserslist(organisationDetails)).build();
						
			} else {
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("######### Appraiser LIST........");
			log.info("######### Appraiser LIST.........");

			return Response.status(Response.Status.FORBIDDEN).build();
		}
}
	
	
	@POST
	@Path("/dosanction")
	@Consumes({ MediaType.APPLICATION_JSON })
	@Produces({ MediaType.APPLICATION_JSON })
	public Response doSanction(InputStream inputStream) throws Exception {
		BufferedReader httpReqReader = new BufferedReader(
				new InputStreamReader(inputStream));
		String lineRead1;
		StringBuffer sb1 = new StringBuffer();
		HashMap hashValResponse = new HashMap();
		String responseVal ="",strEsbStatus="";
		
		while ((lineRead1 = httpReqReader.readLine()) != null) {
			sb1.append(lineRead1);
		}
		String strServerResponse = sb1.toString();		
		Gson g = new Gson(); 
		com.sai.laps.pojo.JsonData response = new com.sai.laps.pojo.JsonData();
		GsonBuilder gsonBuilder1 = new GsonBuilder();
		Gson jsonObject1 = gsonBuilder1.create();
		try
		{
			hashValResponse.put("strServerResponse", strServerResponse);
			Gson g2 									= new Gson(); 
			StatusCheck statusCheck = g2.fromJson(strServerResponse, StatusCheck.class);//(StatusCheck statusCheck){
			log.info("######### dosanction SERVICE called........");
			InwardDetailService restWebService = new InwardDetailServiceImpl();
			return Response.ok(
					restWebService.dosanction(statusCheck)).build();
		}catch (Exception e) {
			e.printStackTrace();
			System.out.println("######### doSanction Service EXCEPTION........"+e.getMessage());
			log.info("######### doSanction Service EXCEPTION........"+e.getMessage());
			return Response.status(Response.Status.FORBIDDEN).build();
		}
}

	@POST
	@Path("FinalInPrinciple")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response serverStatus(InputStream inputStream) throws Exception {
		BufferedReader httpReqReader = new BufferedReader(new InputStreamReader(inputStream));
		String lineRead1;
		StringBuffer sb1 = new StringBuffer();
		HashMap hashValResponse = new HashMap();
		String responseVal ="",strEsbStatus="";
		
		while ((lineRead1 = httpReqReader.readLine()) != null) {
			sb1.append(lineRead1);
		}
		String strServerResponse = sb1.toString();		
		Gson g = new Gson(); 
		com.sai.laps.pojo.JsonData response = new com.sai.laps.pojo.JsonData();
		GsonBuilder gsonBuilder1 = new GsonBuilder();
		Gson jsonObject1 = gsonBuilder1.create();
		try
		{
			hashValResponse.put("strServerResponse", strServerResponse);
			Gson g2 									= new Gson(); 
			FinalInPrinciple finalinprinciple = g2.fromJson(strServerResponse, FinalInPrinciple.class);//(FinalInPrinciple finalinprinciple)
			System.out.println("######### FinalInPrinciple........");
			log.info("######### FinalInPrinciple.........");
			if(finalinprinciple!=null){
				InwardDetailServiceImpl restWebService = new InwardDetailServiceImpl();
				return Response.ok(restWebService.FinalinPrinciple(finalinprinciple)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}				
		}
		catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("######### FinalInPrinciple........"+e.getMessage());
			log.info("######### FinalInPrinciple......."+e.getMessage());
			
			return Response.status(Response.Status.FORBIDDEN).build();
		}
		
	}
	
	
}
