
package com.sai.laps.webservices.rest;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import javax.ejb.EJBException;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.StreamingOutput;
import javax.xml.stream.XMLOutputFactory;
import javax.xml.stream.XMLStreamWriter;

import org.jfree.util.Log;
import org.apache.log4j.Logger;
import org.json.JSONException;
import org.json.JSONObject;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.sai.fw.management.log.LogWriter;
import com.sai.laps.ejb.DigitalAppInterface.DigitalAppInterfaceBean;
import com.sai.laps.helper.Constants;
import com.sai.laps.webservices.rest.domain.CustomerCreation;
import com.sai.laps.webservices.rest.domain.DedupeCheck;
import com.sai.laps.webservices.rest.domain.FetchProposals;
import com.sai.laps.webservices.rest.domain.FetchUserDetails;
import com.sai.laps.webservices.rest.domain.FinalInPrinciple;
import com.sai.laps.webservices.rest.domain.GenDmsUpd;
import com.sai.laps.webservices.rest.domain.GetGoldRate;
import com.sai.laps.webservices.rest.domain.GoldReappraiser;
import com.sai.laps.webservices.rest.domain.InwardDetails;
import com.sai.laps.webservices.rest.domain.OrganisationDetails;
import com.sai.laps.webservices.rest.domain.PreApprovedOffer;
import com.sai.laps.webservices.rest.domain.ProposalCreation;
import com.sai.laps.webservices.rest.domain.SecurityCreation;
import com.sai.laps.webservices.rest.domain.ServerStatus;
import com.sai.laps.webservices.rest.domain.StatusCheck;
import com.sai.laps.webservices.rest.domain.UserClosure;
import com.sai.laps.webservices.rest.domain.UserCreation;
import com.sai.laps.webservices.rest.domain.ValuerList;

import com.sai.laps.webservices.rest.domain.msme.FacilityProposal;
import com.sai.laps.webservices.rest.domain.msme.FinancialDigiRating;
import com.sai.laps.webservices.rest.domain.msme.MsmeCustomerCreation;
import com.sai.laps.webservices.rest.domain.msme.MsmeDedupeCheck;
import com.sai.laps.webservices.rest.domain.msme.BasicInformationCust;
import com.sai.laps.webservices.rest.domain.msme.MsmeLarService;

import com.sai.laps.webservices.rest.domain.msme.RenewalProposals;
import com.sai.laps.webservices.rest.services.ArrBsadsaMaster;
import com.sai.laps.webservices.rest.services.InwardDetailService;
import com.sai.laps.webservices.rest.services.InwardDetailServiceImpl;
import com.sai.laps.webservices.rest.services.msme.MsmeService;
import com.sai.laps.webservices.rest.services.msme.MsmeServiceImpl;
import com.sai.laps.webservices.rest.domain.Birdata;
import com.sai.laps.webservices.rest.domain.UserUpdation;
import com.sai.laps.webservices.rest.domain.Userdesignation;

import com.sai.laps.webservices.rest.domain.agri.AgriLarService;
import com.sai.laps.webservices.rest.services.agri.AgriServiceImpl;
import com.sai.laps.webservices.rest.domain.agri.AgriFacilityProposal;


@Path("/services")
public class LOSRestServices
{
	static Logger log = Logger.getLogger(LOSRestServices.class);
	
	@POST
	@Path("/larcreation")
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
			Gson g2 = new Gson(); 
			InwardDetails inwardDetail = g2.fromJson(strServerResponse, InwardDetails.class);//(InwardDetails inwardDetail)
 		System.out.println("######### SaveInwardDetails SERVICE........");
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
	}
	
	
	@POST
	@Path("/dedupeCheck")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response dedupeCheckNew(InputStream inputStream) throws Exception {
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
			DedupeCheck DedupeCheck = g2.fromJson(strServerResponse, DedupeCheck.class);//(DedupeCheck DedupeCheck)
 
			System.out.println("######### DEDUPE SERVICE........");
			log.info("######### DEDUPE SERVICE........");
			if(DedupeCheck!=null){
				InwardDetailService restWebService = new InwardDetailServiceImpl();
				return Response.ok(restWebService.dedupeCheck(DedupeCheck)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}
			
		}
		catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("######### DEDUPE SERVICE EXCEPTION........"+e.getMessage());
			log.info("######### DEDUPE SERVICE EXCEPTION......."+e.getMessage());
			
			return Response.status(Response.Status.FORBIDDEN).build();
		}
	}
	
	@POST
	@Path("/CustomerCreation")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response customerCreationNew(InputStream inputStream)throws Exception {
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
				return Response.ok(restWebService.customerCreation(CustomerCreation)).build();
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
	@Path("/ProposalCreation")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response proposalCreation(InputStream inputStream) throws Exception {
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
			Gson g2 = new Gson(); 
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
	@Path("/preApprovedOfferService")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response preApprovedOfferService(InputStream inputStream) throws Exception {
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
			PreApprovedOffer preApprovedOffer = g2.fromJson(strServerResponse, PreApprovedOffer.class);//(PreApprovedOffer preApprovedOffer)
			System.out.println("######### Pre Approved Offer SERVICE........");
			log.info("######### Pre Approved Offer SERVICE........");
			if(preApprovedOffer!=null){
				InwardDetailService restWebService = new InwardDetailServiceImpl();
				return Response.ok(restWebService.preApprovedOfferService(preApprovedOffer)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}
		}
		catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println("######### Pre Approved Offer SERVICE EXCEPTION........"+e.getMessage());
			log.info("######### Pre Approved Offer SERVICE EXCEPTION........"+e.getMessage());
			return Response.status(Response.Status.FORBIDDEN).build();
		}
	}
	
	@POST
	@Path("/preApprovedOfferServiceApp")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response preApprovedOfferServiceApp(InputStream inputStream) throws Exception {
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
			PreApprovedOffer preApprovedOffer = g2.fromJson(strServerResponse, PreApprovedOffer.class);//(PreApprovedOffer preApprovedOffer)
			System.out.println("######### PreApprovedOfferApp SERVICE........");
			log.info("######### PreApprovedOfferApp SERVICE........");
			if(preApprovedOffer!=null){
				InwardDetailService restWebService = new InwardDetailServiceImpl();
				return Response.ok(restWebService.preApprovedOfferServiceApp(preApprovedOffer)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}
		}
		catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println("######### PreApprovedOfferApp SERVICE EXCEPTION........"+e.getMessage());
			log.info("######### PreApprovedOfferApp SERVICE EXCEPTION........"+e.getMessage());
			return Response.status(Response.Status.FORBIDDEN).build();
		}
	}
	

	@POST
	@Path("autoLoan/securityCreation")
	@Consumes({ MediaType.APPLICATION_JSON })
	@Produces({ MediaType.APPLICATION_JSON })
	public Response saveSecurityDetails(InputStream inputStream) throws Exception {
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
			SecurityCreation securityCreation = g2.fromJson(strServerResponse, SecurityCreation.class);//(SecurityCreation securityCreation) {
			System.out.println("######### Security Creation SERVICE........");
			log.info("######### Security Creation SERVICE........");
			if (securityCreation != null) {
				InwardDetailService restWebService = new InwardDetailServiceImpl();
				return Response.ok(
						restWebService.handleSecurityDetails(securityCreation))
						.build();
			} else {
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("######### Security Creation SERVICE EXCEPTION........"+e.getMessage());
			log.info("######### Security Creation SERVICE EXCEPTION........"+e.getMessage());
			return Response.status(Response.Status.FORBIDDEN).build();
		}
	}
	
	@POST
	@Path("/statusCheck")
	@Consumes({ MediaType.APPLICATION_JSON })
	@Produces({ MediaType.APPLICATION_JSON })
	public Response statusCheck(InputStream inputStream) throws Exception {
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
			System.out.println("######### Status Check SERVICE Called........");
			log.info("######### Status Check SERVICE Called........");
			if (statusCheck != null) {
				InwardDetailService restWebService = new InwardDetailServiceImpl();
				return Response.ok(
						restWebService.handleStatusDetails(statusCheck)).build();
						
			} else {
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("######### Status Check SERVICE EXCEPTION........"+e.getMessage());
			log.info("######### Status Check SERVICE EXCEPTION......."+e.getMessage());
			return Response.status(Response.Status.FORBIDDEN).build();
		}
	}
	
		@POST
		@Path("/accOpeningTriggerService")
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
		@Path("/mclrService")
		@Consumes({ MediaType.APPLICATION_JSON })
		@Produces({ MediaType.APPLICATION_JSON })
		public Response mclrService(InputStream inputStream) throws Exception {
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
				System.out.println("######### mclr SERVICE called........");
				log.info("######### mclr SERVICE called........");
				if (statusCheck != null) {
					InwardDetailService restWebService = new InwardDetailServiceImpl();
					return Response.ok(
							restWebService.mclrService(statusCheck)).build();
							
				}
			
				else {
					return Response.ok(Constants.BAD_REQEST_DATA).build();
				}
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("######### mclr Service EXCEPTION........"+e.getMessage());
				log.info("######### mclr Service EXCEPTION........"+e.getMessage());
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
			@Path("msme/larcreation")
			@Consumes({MediaType.APPLICATION_JSON})
			@Produces({MediaType.APPLICATION_JSON})
			public Response msmeLarCreation(InputStream inputStream) throws Exception {
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
					MsmeLarService msmeLarService = g2.fromJson(strServerResponse, MsmeLarService.class);//(MsmeLarService msmeLarService)
                	System.out.println("######### MsmeLar SERVICE........");
					log.info("######### MsmeLar SERVICE........");
					if(msmeLarService!=null){
						MsmeService restWebService = new MsmeServiceImpl();
						return Response.ok(restWebService.msmeLarCreation(msmeLarService)).build();
					}else{
						return Response.ok(Constants.BAD_REQEST_DATA).build();
					}
				}
				catch (Exception e)
				{	
					System.out.println("######### MsmeLar EXCEPTION........"+e.getMessage());
					log.info("######### MsmeLar EXCEPTION........"+e.getMessage());
					return Response.status(Response.Status.FORBIDDEN).build();
				}
			}
			
		
		@POST
		@Path("msme/fetchRenewalProposal")
		@Consumes({MediaType.APPLICATION_JSON})
		@Produces({MediaType.APPLICATION_JSON})
		public Response fetchRenewalProposal(InputStream inputStream) throws Exception {
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
				RenewalProposals RenewalProposals = g2.fromJson(strServerResponse, RenewalProposals.class);//(RenewalProposals RenewalProposals)
				System.out.println("######### RENEWAL PROPOSAL FETCH  SERVICE........");
				log.info("######### RENEWAL PROPOSAL FETCH  SERVICE........");
				if(RenewalProposals!=null){
					MsmeService restWebService = new MsmeServiceImpl();
					return Response.ok(restWebService.msmeRenewalProposals(RenewalProposals)).build();
				}else{
					return Response.ok(Constants.BAD_REQEST_DATA).build();
				}
				
			}
			catch (Exception e)
			{
				e.printStackTrace();
				System.out.println("######### RENEWAL PROPOSAL FETCH SERVICE EXCEPTION........"+e.getMessage());
				log.info("######### RENEWAL PROPOSAL FETCH  SERVICE EXCEPTION......."+e.getMessage());
				return Response.status(Response.Status.FORBIDDEN).build();
			}
		}
		
		@POST
		@Path("msme/customerCreation")
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
				Gson g2	= new Gson(); 
				MsmeCustomerCreation msmeCustomerCreation = g2.fromJson(strServerResponse, MsmeCustomerCreation.class);//(MsmeCustomerCreation msmeCustomerCreation)
				System.out.println("######### MSMECustomerCreation SERVICE........");
				log.info("######### MSMECustomerCreation SERVICE........");
				if(msmeCustomerCreation!=null){
					MsmeService restWebService = new MsmeServiceImpl();
					return Response.ok(restWebService.msmeCustomerCreationService(msmeCustomerCreation)).build();
				}else{
					return Response.ok(Constants.BAD_REQEST_DATA).build();
				}
				
			}
			catch (Exception e)
			{
				e.printStackTrace();
				System.out.println("######### MSMECustomerCreation SERVICE EXCEPTION........"+e.getMessage());
				log.info("######### MSMECustomerCreation SERVICE EXCEPTION......."+e.getMessage());
				
				return Response.status(Response.Status.FORBIDDEN).build();
			}
		}
		
		
		
		@POST
		@Path("msme/dedupeCheck")
		@Consumes({MediaType.APPLICATION_JSON})
		@Produces({MediaType.APPLICATION_JSON})
		public Response dedupeCheck(InputStream inputStream) throws Exception {
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
				MsmeDedupeCheck msmeDedupeCheck = g2.fromJson(strServerResponse, MsmeDedupeCheck.class);//(MsmeDedupeCheck msmeDedupeCheck)
				System.out.println("######### DEDUPE SERVICE........");
				log.info("######### MSME DEDUPE SERVICE........");
				if(msmeDedupeCheck!=null){
					MsmeService restWebService = new MsmeServiceImpl();
					return Response.ok(restWebService.msmeDedupeCheckService(msmeDedupeCheck)).build();
				}else{
					return Response.ok(Constants.BAD_REQEST_DATA).build();
				}
				
			}
			catch (Exception e)
			{
				e.printStackTrace();
				System.out.println("######### MSME DEDUPE SERVICE EXCEPTION........"+e.getMessage());
				log.info("######### MSME DEDUPE SERVICE EXCEPTION......."+e.getMessage());
				
				return Response.status(Response.Status.FORBIDDEN).build();
			}
		}
		
		
		

		@POST
		@Path("msme/custBasicInfo")
		@Consumes({MediaType.APPLICATION_JSON})
		@Produces({MediaType.APPLICATION_JSON})
		public Response custBasicInformation(InputStream inputStream) throws Exception {
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
				BasicInformationCust BasicInformationCust = g2.fromJson(strServerResponse, BasicInformationCust.class);//(BasicInformationCust BasicInformationCust)		
				System.out.println("######### CUSTOMER BASIC INFORMATION SERVICE........");
				log.info("######### CUSTOMER BASIC INFORMATION SERVICE........");
				if(BasicInformationCust!=null){
					MsmeService restWebService = new MsmeServiceImpl();
					return Response.ok(restWebService.basicInformationCust(BasicInformationCust)).build();
				}else{
					return Response.ok(Constants.BAD_REQEST_DATA).build();
				}
				
			}
			catch (Exception e)
			{
				e.printStackTrace();
				System.out.println("######### CUSTOMER BASIC INFORMATION SERVICE EXCEPTION........"+e.getMessage());
				log.info("######### CUSTOMER BASIC INFORMATION SERVICE EXCEPTION......."+e.getMessage());
				
				return Response.status(Response.Status.FORBIDDEN).build();
			}
		}
		
		
		@POST
		@Path("msme/RenewalDedupe")
		@Consumes(MediaType.APPLICATION_JSON)
		@Produces(MediaType.APPLICATION_JSON)
		public Response renewalDedupe(InputStream inputStream) throws Exception {
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
				BasicInformationCust BasicInformationCust = g2.fromJson(strServerResponse, BasicInformationCust.class);//(BasicInformationCust BasicInformationCust)
				System.out.println("######### RENEWAL DEDUPE SERVICE........");
				log.info("######### RENEWAL DEDUPE SERVICE........");
				if(BasicInformationCust!=null){
					MsmeService restWebService = new MsmeServiceImpl();
					return Response.ok(restWebService.msmeRenewalDedupeService(BasicInformationCust)).build();
				}else{
					return Response.ok(Constants.BAD_REQEST_DATA).build();
				}
			}
			catch (Exception e) {
				e.printStackTrace();
				System.out.println("######### RENEWAL DEDUPE SERVICE EXCEPTION........"+e.getMessage());
				log.info("######### RENEWAL DEDUPE SERVICE EXCEPTION......."+e.getMessage());
				
				return Response.status(Response.Status.FORBIDDEN).build();
			}
		}
		
		
		@POST
		@Path("msme/collateralSecurity")
		@Consumes({MediaType.APPLICATION_JSON})
		@Produces({MediaType.APPLICATION_JSON})
		public Response collateralSecurity(InputStream inputStream) throws Exception {
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
				BasicInformationCust basicInformationCust = g2.fromJson(strServerResponse, BasicInformationCust.class);//(BasicInformationCust basicInformationCust)
				System.out.println("######### COLLATERAL SECURITY SERVICE........");
				log.info("######### COLLATERAL SECURITY SERVICE........");
				if(basicInformationCust!=null){
					MsmeService restWebService = new MsmeServiceImpl();
					return Response.ok(restWebService.collateralService(basicInformationCust)).build();
				}else{
					return Response.ok(Constants.BAD_REQEST_DATA).build();
				}
				
			}
			catch (Exception e)
			{
				e.printStackTrace();
				System.out.println("######### COLLATERAL SECURITY SERVICE EXCEPTION........"+e.getMessage());
				log.info("######### COLLATERAL SECURITY SERVICE EXCEPTION......."+e.getMessage());
				
				return Response.status(Response.Status.FORBIDDEN).build();
			}
		}
		
		
		@POST
		@Path("autoLoan/dedupeCheck")
		@Consumes({MediaType.APPLICATION_JSON})
		@Produces({MediaType.APPLICATION_JSON})
		public Response autoLoandedupeCheck(InputStream inputStream) throws Exception {
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
				DedupeCheck dedupeCheck = g2.fromJson(strServerResponse, DedupeCheck.class);//(DedupeCheck dedupeCheck)
				System.out.println("######### autoLoan dedupeCheck Service........");
				log.info("######### autoLoan dedupeCheck Service.........");
				if(dedupeCheck!=null){
					InwardDetailService restWebService = new InwardDetailServiceImpl();
					return Response.ok(restWebService.autoloanDedupeCheck(dedupeCheck)).build();
				}else{
					return Response.ok(Constants.BAD_REQEST_DATA).build();
				}				
			}
			catch (Exception e)
			{
				e.printStackTrace();
				System.out.println("######### AUTOLOAN DEDUPECHECK SERVICE EXCEPTION........"+e.getMessage());
				log.info("#########  AUTOLOAN DEDUPECHECK SERVICE EXCEPTION......."+e.getMessage());
				
				return Response.status(Response.Status.FORBIDDEN).build();
			}
		}
	
		
		@POST
		@Path("autoLoan/proposalCreation")
		@Consumes({MediaType.APPLICATION_JSON})
		@Produces({MediaType.APPLICATION_JSON})
		public Response autoloanProposalCreation(InputStream inputStream) throws Exception {
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
				ProposalCreation proposalCreation = g2.fromJson(strServerResponse, ProposalCreation.class);//(ProposalCreation proposalCreation)
				System.out.println("######### AUTOLOAN PROPOSALCREATION SERVICE........");
				log.info("######### AUTOLOAN PROPOSALCREATION SERVICE........");
				if(proposalCreation!=null){
					InwardDetailService restWebService = new InwardDetailServiceImpl();
					return Response.ok(restWebService.autoLoanproposalCreation(proposalCreation)).build();
				}else{
					return Response.ok(Constants.BAD_REQEST_DATA).build();
				}
				
			}
			catch (Exception e)
			{
				e.printStackTrace();
				System.out.println("######### AUTOLOAN PROPOSALCREATION  SERVICE EXCEPTION........"+e.getMessage());
				log.info("######### AUTOLOAN PROPOSALCREATION SERVICE EXCEPTION......."+e.getMessage());
					
					return Response.status(Response.Status.FORBIDDEN).build();
				}
			}	
			
	@POST
	@Path("userorganisation")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response userorgdetails(InputStream inputStream) throws Exception {
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
			StatusCheck statusCheck = g2.fromJson(strServerResponse, StatusCheck.class);//(StatusCheck statusCheck)
			System.out.println("######### USER ORGANISATION DETAIL Service........");
			log.info("######### USER ORGANISATION DETAIL Service.........");
			if(statusCheck!=null){
				InwardDetailService restWebService = new InwardDetailServiceImpl();
				return Response.ok(restWebService.userOrganisationDetail(statusCheck)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}				
		}
		catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("######### USER ORGANISATION DETAIL SERVICE EXCEPTION........"+e.getMessage());
			log.info("######### USER ORGANISATION DETAIL SERVICE EXCEPTION......."+e.getMessage());
			
			return Response.status(Response.Status.FORBIDDEN).build();
		}
		
	}
	
	

		
	@POST
	@Path("msme/financialCMA")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response msmeFinancialCma(InputStream inputStream) throws Exception {
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
			BasicInformationCust basicInformationCust = g2.fromJson(strServerResponse, BasicInformationCust.class);//(BasicInformationCust basicInformationCust)
			System.out.println("######### MSME FINANCIALCMA  SERVICE........");
			log.info("######### MSME FINANCIALCMA SERVICE........");
			if(basicInformationCust!=null){
				MsmeService restWebService = new MsmeServiceImpl();
				return Response.ok(restWebService.msmeFinancialCMAService(basicInformationCust)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}
			
		}
		catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("######### MSME FINANCIALCMA SERVICE EXCEPTION........"+e.getMessage());
			log.info("######### MSME FINANCIALCMA SERVICE EXCEPTION......."+e.getMessage());
				
				return Response.status(Response.Status.FORBIDDEN).build();
			}
		}

	@POST
	@Path("msme/facilityProposal")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response msmefacilityProposal(InputStream inputStream) throws Exception {
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
			Gson g2 = new Gson(); 
			FacilityProposal facilityProposal = g2.fromJson(strServerResponse, FacilityProposal.class);//(FacilityProposal facilityProposal)
			System.out.println("######### MSME FACILITYPROPOSAL  SERVICE........");
			log.info("######### MSME FACILITYPROPOSAL SERVICE........");
			if(facilityProposal!=null){
				MsmeService restWebService = new MsmeServiceImpl();
				return Response.ok(restWebService.msmeFacilityProposal(facilityProposal)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}
			
		}
		catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("######### MSME FACILITYPROPOSAL SERVICE EXCEPTION........"+e.getMessage());
			log.info("######### MSME FACILITYPROPOSAL SERVICE EXCEPTION......."+e.getMessage());
				
				return Response.status(Response.Status.FORBIDDEN).build();
			}
		}
	
	@POST
	@Path("msme/RenewalFacilityProposal")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response msmeRenewalFacilityProposal(InputStream inputStream) throws Exception {
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
			Gson g2 = new Gson(); 
			FacilityProposal facilityProposal = g2.fromJson(strServerResponse, FacilityProposal.class);//(FacilityProposal facilityProposal)
			System.out.println("######### MSME RENEWAL FACILITY PROPOSAL  SERVICE........");
			log.info("######### MSME RENEWAL FACILITY PROPOSAL  SERVICE........");
			if(facilityProposal!=null){
				MsmeService restWebService = new MsmeServiceImpl();
				return Response.ok(restWebService.msmeRenewalFacilityProposal(facilityProposal)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}
			
		}
		catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("######### MSME RENEWAL FACILITY PROPOSAL SERVICE EXCEPTION........"+e.getMessage());
			log.info("######### MSME RENEWAL FACILITY PROPOSAL SERVICE EXCEPTION......."+e.getMessage());
				
				return Response.status(Response.Status.FORBIDDEN).build();
			}
		}
	
	@POST
	@Path("msme/financialCreation")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response msmefinancialCreation(InputStream inputStream) throws Exception {
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
			FacilityProposal facilityProposal = g2.fromJson(strServerResponse, FacilityProposal.class);//(FacilityProposal facilityProposal)
			System.out.println("######### MSME FINANCIALCREATION  SERVICE........");
			log.info("######### MSME FINANCIALCREATION SERVICE........");
			if(facilityProposal!=null){
				MsmeService restWebService = new MsmeServiceImpl();
				return Response.ok(restWebService.msmeFinacialCreation(facilityProposal)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}
			
		}
		catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("######### MSME FINANCIALCREATION SERVICE EXCEPTION........"+e.getMessage());
			log.info("######### MSME FINANCIALCREATION SERVICE EXCEPTION......."+e.getMessage());
				
				return Response.status(Response.Status.FORBIDDEN).build();
			}
		}
	
	
	

	
	
	@POST
	@Path("valuerList")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response userorgdet(InputStream inputStream) throws Exception {
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
			ValuerList valuerList = g2.fromJson(strServerResponse, ValuerList.class);//(ValuerList valuerList)
			System.out.println("######### VALUERLIST  Service........");
			log.info("######### VALUERLIST  Service.........");
			if(valuerList!=null){
				InwardDetailService restWebService = new InwardDetailServiceImpl();
				return Response.ok(restWebService.valuerListService(valuerList)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}				
		}
		catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("######### VALUERLIST SERVICE EXCEPTION........"+e.getMessage());
			log.info("######### VALUERLIST  SERVICE EXCEPTION......."+e.getMessage());
			
			return Response.status(Response.Status.FORBIDDEN).build();
		}
		
	}
		
	

	@POST
	@Path("larInwardDetails")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response larInward(InputStream inputStream) throws Exception {
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
			ProposalCreation proposalCreation = g2.fromJson(strServerResponse, ProposalCreation.class);//(ProposalCreation proposalCreation)
			System.out.println("######### larInwardreg  Service........");
			log.info("######### larInwardreg  Service.........");
			if(proposalCreation!=null){
				InwardDetailService restWebService = new InwardDetailServiceImpl();
				return Response.ok(restWebService.larInwardreg(proposalCreation)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}				
		}
		catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("######### larInwardreg SERVICE EXCEPTION........"+e.getMessage());
			log.info("######### larInwardreg  SERVICE EXCEPTION......."+e.getMessage());
			
			return Response.status(Response.Status.FORBIDDEN).build();
		}
		
	}
	
	
	@POST
	@Path("fetchRenewalProposalRetails")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response fetchRenewalProposalRetails(InputStream inputStream) throws Exception {
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
			RenewalProposals RenewalProposals = g2.fromJson(strServerResponse, RenewalProposals.class);//(RenewalProposals RenewalProposals)
			System.out.println("######### RENEWAL PROPOSAL FETCH  SERVICE For Retails........");
			log.info("######### RENEWAL PROPOSAL FETCH  SERVICE For Retails........");
			if(RenewalProposals!=null){
				InwardDetailService restWebService = new InwardDetailServiceImpl();;
				return Response.ok(restWebService.renewalProposalsRetails(RenewalProposals)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}
			
		}
		catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("######### RENEWAL PROPOSAL FETCH SERVICE For Retails EXCEPTION........"+e.getMessage());
			log.info("######### RENEWAL PROPOSAL FETCH  SERVICE For Retails EXCEPTION......."+e.getMessage());
			return Response.status(Response.Status.FORBIDDEN).build();
		}
	}
	
	@POST
	@Path("fetchProposals")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response fetchProposals(InputStream inputStream) throws Exception {
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
			FetchProposals fetchProposals = g2.fromJson(strServerResponse, FetchProposals.class);//(FetchProposals fetchProposals)
			System.out.println("######### FETCH PROPOSAL THROUGH PAN NUMBER........");
			log.info("######### FETCH PROPOSAL THROUGH PAN NUMBER........");
			if(fetchProposals!=null){
				InwardDetailService restWebService = new InwardDetailServiceImpl();;
				return Response.ok(restWebService.FetchProposalsService(fetchProposals)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}
			
		}
		catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("######### FETCH PROPOSAL THROUGH PAN NUMBER........"+e.getMessage());
			log.info("######### FETCH PROPOSAL THROUGH PAN NUMBER......."+e.getMessage());
			return Response.status(Response.Status.FORBIDDEN).build();
		}
	}
	
	@POST
	@Path("Organisations")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response fetchUserDetails(InputStream inputStream) throws Exception {
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
			Gson g2 = new Gson(); 
			FetchUserDetails fetchUserDetails = g2.fromJson(strServerResponse, FetchUserDetails.class);//(FetchUserDetails fetchUserDetails)
			System.out.println("######### FETCH USERS THROUGH ORGANISATIONS........");
			log.info("######### FETCH USERS THROUGH ORGANISATIONS........");
			if(fetchUserDetails!=null){
				InwardDetailService restWebService = new InwardDetailServiceImpl();;
				return Response.ok(restWebService.FetchUserDetailsService(fetchUserDetails)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}
			
		}
		catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("######### FETCH PROPOSAL THROUGH ORGANISATIONS........"+e.getMessage());
			log.info("######### FETCH PROPOSAL THROUGH ORGANISATIONS......."+e.getMessage());
			return Response.status(Response.Status.FORBIDDEN).build();
		}
	}
	
	@POST
	@Path("UserOrganisations")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response fetchUserDetailsOrganisationsNew(InputStream inputStream) throws Exception {
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
			Gson g2 = new Gson(); 
			StatusCheck statusCheck = g2.fromJson(strServerResponse, StatusCheck.class);//(StatusCheck statusCheck)
			System.out.println("######### USER ORGANISATION DETAIL Service........");
			log.info("######### USER ORGANISATION DETAIL Service.........");
			if(statusCheck!=null){
				InwardDetailService restWebService = new InwardDetailServiceImpl();
				return Response.ok(restWebService.FetchUserOrganisationsDetailsService(statusCheck)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}				
		}
		catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("######### USER ORGANISATION DETAIL SERVICE EXCEPTION........"+e.getMessage());
			log.info("######### USER ORGANISATION DETAIL SERVICE EXCEPTION......."+e.getMessage());
			
			return Response.status(Response.Status.FORBIDDEN).build();
		}
		
	}
	
	@POST
	@Path("msme/financialDigiRating")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response fetchUserDetailsOrganisations(InputStream inputStream) throws Exception {
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
			FinancialDigiRating financialDigiRating = g2.fromJson(strServerResponse, FinancialDigiRating.class);//(FinancialDigiRating financialDigiRating)
			System.out.println("######### FINANCIALS DIGI RATING........");
			log.info("######### FINANCIALS DIGI RATING.........");
			if(financialDigiRating!=null){
				MsmeService restWebService = new MsmeServiceImpl();
				return Response.ok(restWebService.msmeFinacialDigiRatingCreation(financialDigiRating)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}				
		}
		catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("######### FINANCIALS DIGI RATING........"+e.getMessage());
			log.info("######### FINANCIALS DIGI RATING......."+e.getMessage());
			
			return Response.status(Response.Status.FORBIDDEN).build();
		}
		
	}
	
	@POST
	@Path("serverStatus")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response serverStatusNew(InputStream inputStream) throws Exception {
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
			ServerStatus serverStatus = g2.fromJson(strServerResponse, ServerStatus.class);//(ServerStatus serverStatus)
			System.out.println("######### SERVER STATUS........");
			log.info("######### SERVER STATUS.........");
			if(serverStatus!=null){
				InwardDetailServiceImpl restWebService = new InwardDetailServiceImpl();
				return Response.ok(restWebService.CronServerStatus(serverStatus)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}				
		}
		catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("######### SERVER STATUS........"+e.getMessage());
			log.info("######### SERVER STATUS......."+e.getMessage());
			
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
	
	@POST
	@Path("GenDms")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response gendmsupd(InputStream inputStream) throws Exception {
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
			GenDmsUpd gendmsupd = g2.fromJson(strServerResponse, GenDmsUpd.class);//(GenDmsUpd gendmsupd)
			System.out.println("######### General dms........");
			log.info("######### General dms.........");
			if(gendmsupd!=null){
				InwardDetailServiceImpl restWebService = new InwardDetailServiceImpl();
				return Response.ok(restWebService.GenDmsupd(gendmsupd)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}				
		}
		catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("######### General dms........"+e.getMessage());
			log.info("######### General dms......."+e.getMessage());
			
			return Response.status(Response.Status.FORBIDDEN).build();
		}
		
	}
	
	@POST
	@Path("organisationDetails")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response organisationDetails(InputStream inputStream) throws Exception {
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
			OrganisationDetails organisationDetails = g2.fromJson(strServerResponse, OrganisationDetails.class);//(OrganisationDetails organisationDetails)
			System.out.println("######### ORGANISATION DETAILS........");
			log.info("######### ORGANISATION DETAILS.........");
			if(organisationDetails!=null){
				InwardDetailServiceImpl restWebService = new InwardDetailServiceImpl();
				return Response.ok(restWebService.organisationDetails(organisationDetails)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}				
		}
		catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("######### ORGANISATION DETAILS........"+e.getMessage());
			log.info("######### ORGANISATION DETAILS......."+e.getMessage());
			
			return Response.status(Response.Status.FORBIDDEN).build();
		}
		
	}
	
	@POST
	@Path("bsadsaMasterCreation")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response bsadsaMaster(InputStream inputStream) throws Exception {
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
			Gson g2 = new Gson(); 
			ArrBsadsaMaster arrBsadsaMaster = g2.fromJson(strServerResponse, ArrBsadsaMaster.class);//(ArrBsadsaMaster arrBsadsaMaster)
			System.out.println("######### BSADSAMaster DETAILS........");
			log.info("######### BSADSAMaster DETAILS.........");
			if(arrBsadsaMaster!=null){
				InwardDetailServiceImpl restWebService = new InwardDetailServiceImpl();
				return Response.ok(restWebService.BsaDsaMaster(arrBsadsaMaster)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}				
		}
		catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("######### BSADSAMaster DETAILS........"+e.getMessage());
			log.info("######### BSADSAMaster DETAILS......."+e.getMessage());
			
			return Response.status(Response.Status.FORBIDDEN).build();
		}
		
	}

	
	@POST
	@Path("Birdata")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response Birdata(Birdata Birdata)
 	{
		try
		{
			System.out.println("######### RENEWAL PROPOSAL FETCH  SERVICE For Retails........");
			log.info("######### RENEWAL PROPOSAL FETCH  SERVICE For Retails........");
			if(Birdata!=null){
				InwardDetailService restWebService = new InwardDetailServiceImpl();
				return Response.ok(restWebService.Birdata(Birdata)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}
			
		}
		catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("######### RENEWAL PROPOSAL FETCH SERVICE For Retails EXCEPTION........"+e.getMessage());
			log.info("######### RENEWAL PROPOSAL FETCH  SERVICE For Retails EXCEPTION......."+e.getMessage());
			return Response.status(Response.Status.FORBIDDEN).build();
		}
	}
	@POST
	@Path("/getgoldrate")
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
	@Path("/getjewelappraiserlist")
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
	@Path("/goldreappraiser")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response goldreappraiser(InputStream inputStream) throws Exception
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
	@Path("/perappidcreation")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response perappidcreation(InputStream inputStream) throws Exception
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
			CustomerCreation customerCreation = g2.fromJson(strServerResponse, CustomerCreation.class);//(StatusCheck statusCheck) {
		
			
			System.out.println("######### perappid Creation SERVICE........");
			log.info("######### perappid Creation SERVICE........");
			if (customerCreation != null) {
				InwardDetailService restWebService = new InwardDetailServiceImpl();
				return Response.ok(
						restWebService.perappid(customerCreation)).build();
						
			} else {
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("######### perappid Creation EXCEPTION........"+e.getMessage());
			log.info("######### perappid Creation EXCEPTION........"+e.getMessage());

			return Response.status(Response.Status.FORBIDDEN).build();
		}
 	}
	
	@POST
	@Path("/usertransfer")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response UserTransfer(InputStream inputStream) throws Exception {
		BufferedReader httpReqReader = new BufferedReader(
				new InputStreamReader(inputStream));
		String lineRead1;
		StringBuffer sb1 = new StringBuffer();
		HashMap hashValResponse = new HashMap();
		
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
			UserUpdation usertransfer = g2.fromJson(strServerResponse, UserUpdation.class);
			System.out.println("######### UserTransfer SERVICE........");
			log.info("######### UserTransfer SERVICE........");
			if(usertransfer!=null){
				InwardDetailService restWebService = new InwardDetailServiceImpl();
				return Response.ok(restWebService.usertransfer(usertransfer)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}
		}
		catch (Exception e)
		{	
			System.out.println("######### UserTransfer EXCEPTION........"+e.getMessage());
			log.info("######### UserTransfer EXCEPTION........"+e.getMessage());
			return Response.status(Response.Status.FORBIDDEN).build();
		}
	}
	@POST
	@Path("/userclosure")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response useravailability(InputStream inputStream) throws Exception {
		BufferedReader httpReqReader = new BufferedReader(
				new InputStreamReader(inputStream));
		String lineRead1;
		StringBuffer sb1 = new StringBuffer();
		HashMap hashValResponse = new HashMap();
		
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
			UserClosure userclosure = g2.fromJson(strServerResponse, UserClosure.class);
			System.out.println("######### UserClosure SERVICE........");
			log.info("######### UserClosure SERVICE........");
			if(userclosure!=null){
				InwardDetailService restWebService = new InwardDetailServiceImpl();
				return Response.ok(restWebService.useravailability(userclosure)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}
		}
		catch (Exception e)
		{	
			System.out.println("######### UserClosure EXCEPTION........"+e.getMessage());
			log.info("######### UserClosure EXCEPTION........"+e.getMessage());
			return Response.status(Response.Status.FORBIDDEN).build();
		}
	}
	@POST
	@Path("/userdesignationchange")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response userdesignationchange(InputStream inputStream) throws Exception {
		BufferedReader httpReqReader = new BufferedReader(
				new InputStreamReader(inputStream));
		String lineRead1;
		StringBuffer sb1 = new StringBuffer();
		HashMap hashValResponse = new HashMap();
		
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
			Userdesignation userdesignation = g2.fromJson(strServerResponse, Userdesignation.class);
			System.out.println("######### UserDesignationchange SERVICE........");
			log.info("######### UserDesignationchange SERVICE........");
			if(userdesignation!=null){
				InwardDetailService restWebService = new InwardDetailServiceImpl();
				return Response.ok(restWebService.userDesignationupdate(userdesignation)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}
		}
		catch (Exception e)
		{	
			System.out.println("######### UserDesignationchange EXCEPTION........"+e.getMessage());
			log.info("######### UserDesignationchange EXCEPTION........"+e.getMessage());
			return Response.status(Response.Status.FORBIDDEN).build();
		}
	}

	//AGRICULTURE LAR
	@POST
	@Path("agri/larcreation")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response AgriLarService(AgriLarService AgriLarService)
 	{
		try
		{
			System.out.println("######### Agri Lar SERVICE........");
			log.info("######### Agri Lar SERVICE.........");
			if(AgriLarService!=null){
				AgriServiceImpl restWebService = new AgriServiceImpl();
				return Response.ok(restWebService.AgriLarService(AgriLarService)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}				
		}
		catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("######### Agri Lar EXCEPTION........"+e.getMessage());
			log.info("######### Agri Lar EXCEPTION......."+e.getMessage());
			
			return Response.status(Response.Status.FORBIDDEN).build();
		}
		
	}
	
	
	//AGRICULTURE PROPOSAL CREATION
	@POST
	@Path("agri/AgriFacilityProposal")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response AgriFacilityProposal(AgriFacilityProposal AgriFacilityProposal)
 	{
		try
		{
			System.out.println("######### Agri FACILITY-PROPOSAL SERVICE........");
			log.info("######### Agri FACILITY-PROPOSAL SERVICE.........");
			if(AgriFacilityProposal!=null){
				AgriServiceImpl restWebService = new AgriServiceImpl();
				return Response.ok(restWebService.AgriFacilityProposal(AgriFacilityProposal)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}				
		}
		catch (Exception e)
		{
			e.printStackTrace();
			System.out.println("######### AGRI FACILITYPROPOSAL SERVICE EXCEPTION........"+e.getMessage());
			log.info("######### AGRI FACILITYPROPOSAL SERVICE EXCEPTION......."+e.getMessage());
			
			return Response.status(Response.Status.FORBIDDEN).build();
		}
		
	}


	@POST
	@Path("/usercreation")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public Response usercreation(InputStream inputStream) throws Exception {
		BufferedReader httpReqReader = new BufferedReader(
				new InputStreamReader(inputStream));
		String lineRead1;
		StringBuffer sb1 = new StringBuffer();
		HashMap hashValResponse = new HashMap();
		
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
			UserCreation usercreation = g2.fromJson(strServerResponse, UserCreation.class);
			System.out.println("######### UserCreation SERVICE........");
			log.info("######### UserCreation SERVICE........");
			if(usercreation!=null){
				InwardDetailService restWebService = new InwardDetailServiceImpl();
				return Response.ok(restWebService.usercreation(usercreation)).build();
			}else{
				return Response.ok(Constants.BAD_REQEST_DATA).build();
			}
		}
		catch (Exception e)
		{	
			System.out.println("######### UserCreation EXCEPTION........"+e.getMessage());
			log.info("######### UserCreation EXCEPTION........"+e.getMessage());
			return Response.status(Response.Status.FORBIDDEN).build();
		}
	}
	//vindhya end
}

