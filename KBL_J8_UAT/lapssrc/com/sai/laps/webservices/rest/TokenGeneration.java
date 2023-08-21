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

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.sai.laps.ejb.appeditlock.AppEditLockBean;
import com.sai.laps.helper.Constants;
import com.sai.laps.webservices.rest.domain.InwardDetails;
import com.sai.laps.webservices.rest.services.InwardDetailService;
import com.sai.laps.webservices.rest.services.InwardDetailServiceImpl;

@Path("/Token")
public class TokenGeneration {

	@POST
	@Path("Tok")
	@Consumes({MediaType.APPLICATION_JSON})
	@Produces({MediaType.APPLICATION_JSON})
	public String generateQuickInvoice(InputStream inputStream) throws Exception {
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
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
		//String strDate1 = sd.format(new Date());
		//String formattedDate = ESBWebserviceHelper.getEsbDateFormat();

		ArrayList arrValues1=new ArrayList();
		HashMap hshQuery1,hshQuery = new HashMap();
		HashMap hshQueryValues1,hshQueryValues  = new HashMap();
		HashMap hashValResponse1 = new HashMap();
		Gson g = new Gson(); 
		com.sai.laps.pojo.JsonData response = new com.sai.laps.pojo.JsonData();
		GsonBuilder gsonBuilder1 = new GsonBuilder();
		Gson jsonObject1 = gsonBuilder1.create();
		try
		{
			hashValResponse.put("strServerResponse", strServerResponse);
			AppEditLockBean WebserviceMobileAppobj = new AppEditLockBean();
			hashValResponse1=WebserviceMobileAppobj.generateTokenVal(hashValResponse);
			response=(com.sai.laps.pojo.JsonData)hashValResponse1.get("response");	

			
//			GsonBuilder gsonBuilder = new GsonBuilder();
//			Gson jsonobject = gsonBuilder.create();
//			responseVal = jsonobject.toJson(response);	
			
//			response.setStatus("SUCCESS");
//			response.setStatuscode("000");
//			strEsbStatus = "success";
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			 gsonBuilder1 = new GsonBuilder();
			 jsonObject1 = gsonBuilder1.create();
//			arrValues1 = new ArrayList();
//			arrValues1.add("");
//			arrValues1.add(sb1.toString());
//			arrValues1.add(jsonObject1.toJson(response));
//			arrValues1.add("");
//			arrValues1.add(Helper.correctNull("generateQuickInvoice"));
//			arrValues1.add(Helper.correctNull("generateQuickInvoice"));
//			arrValues1.add(Helper.correctNull(strEsbStatus));
//			hshQuery.put("strQueryId", "ins_tab_lpt_interface_status");
//			hshQuery.put("arrValues", arrValues1);
//			hshQueryValues.put("1", hshQuery);
//			hshQueryValues.put("size", "1");
//			 EJBInvoker.executeStateLess("dataaccess",
//			 hshQueryValues,"updateData");
		}
		gsonBuilder1 = new GsonBuilder();
		jsonObject1 = gsonBuilder1.create();
		return jsonObject1.toJson(response);
	}
	
	
	
	
	
	
	/*public Response saveInwarDetails(InwardDetails inwardDetail)
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
}
