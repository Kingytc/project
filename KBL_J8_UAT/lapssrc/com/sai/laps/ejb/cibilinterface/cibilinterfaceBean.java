package com.sai.laps.ejb.cibilinterface;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.RandomAccessFile;
import java.lang.reflect.Array;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.Date;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import com.jamonapi.utils.Logger;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "cibilinterfaceBean", mappedName = "cibilinterfaceHome")
@Remote (cibilinterfaceRemote.class)
public class cibilinterfaceBean extends BeanAdapter{
	public HashMap getCibilResponse(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		HashMap hshRecord1=new HashMap();
		try {
			String strInwardNumber=correctNull((String)hshValues.get("inwardno"));
			String strpath=ApplicationParams.getRESPONSEFOLDER();
			String strfolder="RESPONSE";
			String strPath1=strpath+strfolder;
			String strMaxId="";
			String strUsrid=correctNull((String)hshValues.get("strUserId"));
			File selectfile = new File(strPath1);
			if (!selectfile.exists())
				selectfile.mkdirs();
			String[] FILELIST = selectfile.list();
			String filenames = "";
			FileReader fr = null;
			BufferedReader br = null;
			String strfilePath="";
			String strfileinwardNumber="";
			ResultSet rs=null;
			for (int i = 0; i < FILELIST.length; i++) {
				filenames = FILELIST[i];
				strfilePath=strPath1+File.separator+filenames;
				if (!new File(strPath1+ File.separator + filenames).isFile())
					continue;
				fr = new FileReader(strfilePath);
				br = new BufferedReader(fr);
				strfileinwardNumber="";
				StringTokenizer tokenizer1 = new StringTokenizer(filenames, "_");
				if(tokenizer1.hasMoreTokens()) 
				{
					strfileinwardNumber=correctNull((String)tokenizer1.nextToken()).trim();
				}
				if(strfileinwardNumber.equalsIgnoreCase(strInwardNumber))
				{
					String strreadData="";
					while (true)
					{
						String read = br.readLine();
						if (read == null || read.equals("null"))
							break;
						if (!read.equals(""))
						{
							strreadData=strreadData+read;
						}
					}
					ArrayList arrValues = new ArrayList();
					HashMap hshQuery = new HashMap();
					HashMap hshQueryValues = new HashMap();
					String strQuery=SQLParser.getSqlQuery("selmaxresponsetable^"+strInwardNumber);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strMaxId=correctNull((String)rs.getString("maxid"));
					}
					hshQuery.put("strQueryId","inscibilresponsedate");
					arrValues.add(strMaxId);
					arrValues.add(strInwardNumber);
					arrValues.add(strreadData);
					arrValues.add(strUsrid);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					hshRecord.put("responsemaxId", strMaxId);
					hshRecord.put("strInwardNumber",strInwardNumber);
					hshRecord1=getResponseFile(hshRecord);
				}
			}
			
		}
		catch(Exception e)
		{
			throw new EJBException("Aneeeeeeees "+e);
		}
		finally{
			
		}
		return hshRecord1;
	}
	public HashMap getResponseFile(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		String strresSno="",strInwardNo="",strresponsedata="";
		String strTUEFdata="";
		String strmemcode="";
		int intPNlength=0;
		int intPAlength=0;
		int intSClength=0;int intTLlength=0;String strQuery="";
		try{
			strresSno=correctNull((String)hshValues.get("responsemaxId"));
			strInwardNo=correctNull((String)hshValues.get("strInwardNumber"));
			hshRecord.put("responsemaxId", strresSno);
			hshRecord.put("strInwardNumber",strInwardNo);
			strQuery=SQLParser.getSqlQuery("selectresponsedata^"+strInwardNo+"^"+strresSno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strresponsedata=Helper.CLOBToString(rs.getClob("cibil_responsedata"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("selstatdatabyiddesc^73^MEMCODE");
			if(rs.next())
			{
				strmemcode=Helper.correctNull((String)rs.getString("stat_data_desc1"));
			}
			hshRecord.put("strmemcode",strmemcode);
			if(!strresponsedata.equalsIgnoreCase(""))
			{
				hshRecord.put("strresponsedata", strresponsedata);
				strTUEFdata=strresponsedata.substring(0, 4);
				if(strTUEFdata.equalsIgnoreCase("TUEF"))
				{
					hshRecord=updatecibilTUEFrecord(hshRecord);
					for(int i=71;i<strresponsedata.length();i++)
					{
						if(strresponsedata.charAt(i)=='P' && strresponsedata.charAt(i+1)=='N')
						{
							hshRecord.put("intPNlength",Integer.toString(i));
							intPNlength=updatecibilPNrecord(hshRecord);
							i=i+intPNlength;
							hshRecord.put("intPNlength",Integer.toString(i));
						}
						if(strresponsedata.charAt(i)=='S' && strresponsedata.charAt(i+1)=='C')
						{
							intPNlength=updatecibilSCrecord(hshRecord);
							i=i+intPNlength;
							hshRecord.put("intPNlength",Integer.toString(i));
						}
						if(strresponsedata.charAt(i)=='P' && strresponsedata.charAt(i+1)=='A')
						{
							intPNlength=updatecibilPArecord(hshRecord);
							i=i+intPNlength;
							hshRecord.put("intPNlength",Integer.toString(i));
						}
						if(strresponsedata.charAt(i)=='T' && strresponsedata.charAt(i+1)=='L')
						{
							intPNlength=updatecibilTLrecord(hshRecord);
							i=i+intPNlength;
							hshRecord.put("intPNlength",Integer.toString(i));
						}
						if(strresponsedata.charAt(i)=='I' && strresponsedata.charAt(i+1)=='Q')
						{
							intPNlength=updatecibilIQrecord(hshRecord);
							i=i+intPNlength;
							hshRecord.put("intPNlength",Integer.toString(i));
						}
					}
				}
				else if(strTUEFdata.equalsIgnoreCase("ERRR"))
				{
					hshRecord=updatecibilERRRrecord(hshRecord);
					hshRecord=updatecibilUSRREFrecord(hshRecord);
				}
			}
		}
		catch(Exception e){
			throw new EJBException (e);
		}
		finally{
			
		}
		return hshRecord;
	}
	private HashMap updatecibilTUEFrecord(HashMap hshValues) 
	{
		ResultSet rs=null;
		String strresSno="",strInwardNo="",strresponsedata="";
		String strTUEFdata="";
		String strSegmentTag="",strVersion="",strMemberrefnum="",strfutureuse1="",strFutureuse2="";
		String strMembercode="",strSubjectReturnCode="",strEnqcntrlnumber="",strDateprocessed="";
		String strTimeProcessed="";
		String strMsg="$";
		String strMemcode="";
		String strTUEFMaxid="";
		try{
			strresSno=correctNull((String)hshValues.get("responsemaxId"));
			strInwardNo=correctNull((String)hshValues.get("strInwardNumber"));
			strresponsedata=correctNull((String)hshValues.get("strresponsedata"));
			strMemcode=correctNull(((String)hshValues.get("strmemcode")));
			strTUEFdata=strresponsedata.substring(0, 71);
			strSegmentTag=strTUEFdata.substring(0, 4);
			strVersion=strTUEFdata.substring(4,6);
			strMemberrefnum=strTUEFdata.substring(6,31);
			strMemberrefnum=strMemberrefnum.trim();
			strfutureuse1=strTUEFdata.substring(31,33);
			strFutureuse2=strTUEFdata.substring(33,37);
			strMembercode=strTUEFdata.substring(37,47);
			strSubjectReturnCode=strTUEFdata.substring(47,48);
			strEnqcntrlnumber=strTUEFdata.substring(48,57);
			strDateprocessed=strTUEFdata.substring(57,65);
			strTimeProcessed=strTUEFdata.substring(65);
			if(!Helper.isNumeric(strVersion))
			{
				strMsg = strMsg + " Error in the record in TUEF segment at Version ";
				throw new Exception(strMsg);
			}
			if(!strMemberrefnum.equalsIgnoreCase(strInwardNo))
			{
				strMsg = strMsg + " Error in the record in TUEF segment Member reference number is incorrect";
				throw new Exception(strMsg);
			}
			if(!strMembercode.equalsIgnoreCase(strMemcode))
			{
				strMsg = strMsg + " Error in the record in TUEF segment Enquiry Member code is incorrect";
				throw new Exception(strMsg);
			}
			String newDate=DateConversion(strDateprocessed,strTimeProcessed);
			rs=DBUtils.executeLAPSQuery("selmaxtuefresponse^"+strInwardNo+"^"+strresSno);
			if(rs.next())
			{
				strTUEFMaxid=correctNull((String)rs.getString("maxid"));
			}
			ArrayList arrValues = new ArrayList();
			HashMap hshQuery = new HashMap();
			HashMap hshQueryValues = new HashMap();
			hshQuery.put("strQueryId","instuefrecord");
			arrValues.add(strTUEFMaxid);
			arrValues.add(strresSno);
			arrValues.add(strInwardNo);
			arrValues.add(strSegmentTag);
			arrValues.add(strVersion);
			arrValues.add(strMemberrefnum);
			arrValues.add(strfutureuse1);
			arrValues.add(strFutureuse2);
			arrValues.add(strMembercode);
			arrValues.add(strSubjectReturnCode);
			arrValues.add(strEnqcntrlnumber);
			arrValues.add(newDate);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		catch(Exception e){
			throw new EJBException(e.toString());
		}
		finally{
			
		}
		return hshValues;
	}
	/***
	 * 
	 * @param strDateFormat
	 * @see comes in ddmmyyyy to dd/mm/yyyy
	 * @return
	 * @
	 */
	private String DateConversion(String strDateFormat, String strTimeFormat) 
	{
		String strNewDateFormat=new String();
		try{
			if(strDateFormat.length()!=8)
			{
				throw new Exception("Not a Valid format");
			}
			else
			{
				if(strTimeFormat==null || strTimeFormat.length()!=6)
				{
					strNewDateFormat=strDateFormat.substring(0,2)+"/"+strDateFormat.substring(2,4)+"/"+strDateFormat.substring(4);
				}
				else
				{
					strNewDateFormat=strDateFormat.substring(0,2)+"/"+strDateFormat.substring(2,4)+"/"+strDateFormat.substring(4)+" "+strTimeFormat.substring(0,2)+":"+strTimeFormat.substring(2,4)+":"+strTimeFormat.substring(4);
				}
			}
		}catch(Exception Ex)
		{
			throw new EJBException("Error in Converting the date format :: "+Ex);
		}
		return strNewDateFormat;
		
	}
	
	private int updatecibilPNrecord(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		String strresSno="",strInwardNo="",strresponsedata="";
		String strPNdata="";
		String strSegmentTag="";
		String strMsg="$";
		String strPNMaxid="",strDob="";
		String strMemcode="",strLength="",selPNMaxId="",strPNLength="";
		int intlength=0,intdataLength=0,intPNLength=0;
		try{
			strresSno=correctNull((String)hshValues.get("responsemaxId"));
			strInwardNo=correctNull((String)hshValues.get("strInwardNumber"));
			strresponsedata=correctNull((String)hshValues.get("strresponsedata"));
			strMemcode=correctNull(((String)hshValues.get("strmemcode")));
			strPNLength=correctNull(((String)hshValues.get("intPNLength")));
			if(!strPNLength.equalsIgnoreCase(""))
			{
			intPNLength=Integer.parseInt(strPNLength);
			}
			if(intPNLength==0)
			{
				intPNLength=71;
			}
			strPNdata=strresponsedata.substring(intPNLength);
			String[] strArray=new String[14];
			if(!strPNdata.equalsIgnoreCase(""))
			{
				strSegmentTag=strPNdata.substring(0, 4);
				if(!strSegmentTag.equalsIgnoreCase("PN03"))
				{
					strMsg = strMsg + " Error in the record in PN segment, Segment Tag is incorrect";
					throw new Exception(strMsg);
				}
				String strnumtemp="";
				for(int i=0,j=1;i<strPNdata.length();)
				{
					strnumtemp="";
					strLength="";
					intlength=0;
					if(i==0)
					{
						String strtempdata=strPNdata.substring(0,7);
						strArray[0]=strtempdata.substring(4);
						i=7;
					}
					strnumtemp=strPNdata.substring(i,i+2);
					if(Helper.isNumeric(strnumtemp))
					{
						j=Integer.parseInt(strnumtemp);
						strLength=strPNdata.substring(i+2,i+4);
						intlength=Integer.parseInt(strLength);
						strArray[j]=strPNdata.substring(i+4,(i+4+intlength));
						i=i+intlength+4;
					}
					else
					{
						break;
					}
					intdataLength=i;
				}
				if(strArray[1].equalsIgnoreCase(""))
				{
					strMsg = strMsg + " Error in the record in PN segment, Consumer Name is missing";
					throw new Exception(strMsg);
				}
				if(strArray[7].equalsIgnoreCase(""))
				{
					strMsg = strMsg + " Error in the record in PN segment, Date of Birth is missing";
					throw new Exception(strMsg);
				}
				else
				{
					//strDob=sd.format(strArray[7]);
					strDob=DateConversion(strArray[7],null);
					strArray[7]=strDob;
				}
				if(strArray[8].equalsIgnoreCase(""))
				{
					strMsg = strMsg + " Error in the record in PN segment, Gender is missing";
					throw new Exception(strMsg);
				}
				if(strArray[9].equalsIgnoreCase(""))
				{
					if(strArray[10].equalsIgnoreCase(""))
					{
						if(strArray[11].equalsIgnoreCase(""))
						{
							if(strArray[12].equalsIgnoreCase(""))
							{
								strMsg = strMsg + " Error in the record in PN segment, Reference ID is missing";
								throw new Exception(strMsg);
							}
						}
					}
				}
				rs=DBUtils.executeLAPSQuery("selmaxpnrecord^"+strInwardNo+"^"+strresSno);
				if(rs.next())
				{
					selPNMaxId=correctNull((String)rs.getString("maxid"));
				}
				ArrayList arrValues = new ArrayList();
				HashMap hshQuery = new HashMap();
				HashMap hshQueryValues = new HashMap();
				hshQuery.put("strQueryId","insPNData");
				arrValues.add(selPNMaxId);
				arrValues.add(strresSno);
				arrValues.add(strInwardNo);
				for(int l=0;l<strArray.length;l++)
				{
					if(l!=6)
					{
					arrValues.add(strArray[l]);
					}
				}
				System.out.println("\n<--------------------->"+arrValues.size());
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			
			
		}
		catch(Exception e){
			throw new EJBException(e.toString());
		}
		finally{
			
		}
		return intdataLength;
	}
	//SC record
	private int updatecibilSCrecord(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		String strresSno="",strInwardNo="",strresponsedata="";
		String strSCdata="";
		String strSegmentTag="";
		String strMsg="$";
		String strSCMaxid="",strScoreDate="";
		String strMemcode="",strLength="",selSCMaxId="";
		int intlength=0,intdataLength=0,intPNLength=0;
		String strPNLength="";
		String strnumtemp="";
		try{
			strresSno=correctNull((String)hshValues.get("responsemaxId"));
			strInwardNo=correctNull((String)hshValues.get("strInwardNumber"));
			strresponsedata=correctNull((String)hshValues.get("strresponsedata"));
			strMemcode=correctNull(((String)hshValues.get("strmemcode")));
			strPNLength=correctNull((String)hshValues.get("intPNlength"));
			if(!strPNLength.equalsIgnoreCase(""))
			{
			intPNLength=Integer.parseInt(strPNLength);
			}
			strSCdata=strresponsedata.substring(intPNLength);
			strSegmentTag=strSCdata.substring(0,2);
			String strSegmentLength="";
			int intSegmentLength=0;
			if(!strSegmentTag.equalsIgnoreCase("SC"))
			{
				strMsg = strMsg + " Error in the record in SC segment,Data is incorrect";
				throw new Exception(strMsg);
			}
			String[] strArray=new String[91];
			if(!strSCdata.equalsIgnoreCase(""))
			{
				for(int i=0,j=1;i<strSCdata.length();)
				{
					strnumtemp="";
					strLength="";
					intlength=0;
					if(i==0)
					{
						String strtempdata=strSCdata.substring(0,4);
						strSegmentLength=strtempdata.substring(2);
						if(Helper.isNumeric(strSegmentLength))
						{
							intSegmentLength=Integer.parseInt(strSegmentLength);
							strArray[0]=strSCdata.substring(4,(4+intSegmentLength));
							i=intSegmentLength+4;
						}
					}
					strnumtemp=strSCdata.substring(i,i+2);
					if(Helper.isNumeric(strnumtemp))
					{
						j=Integer.parseInt(strnumtemp);
						strLength=strSCdata.substring(i+2,i+4);
						intlength=Integer.parseInt(strLength);
						strArray[j]=strSCdata.substring(i+4,(i+4+intlength));
						i=i+intlength+4;
					}
					else
					{
						break;
					}
					intdataLength=i;
				}
				if(Helper.correctNull((String)strArray[0]).equalsIgnoreCase(""))
				{
					strMsg = strMsg + " Error in the record in SC segment,Score Name is missing";
					throw new Exception(strMsg);
				}
				if(Helper.correctNull((String)strArray[1]).equalsIgnoreCase(""))
				{
					strMsg = strMsg + " Error in the record in SC segment,Score Card Name is missing";
					throw new Exception(strMsg);
				}
				if(Helper.correctNull((String)strArray[2]).equalsIgnoreCase(""))
				{
					strMsg = strMsg + " Error in the record in SC segment,Score Card Version is missing";
					throw new Exception(strMsg);
				}
				if(Helper.correctNull((String)strArray[3]).equalsIgnoreCase(""))
				{
					strMsg = strMsg + " Error in the record in SC segment,Score Date is missing";
					throw new Exception(strMsg);
				}
				else
				{
					strScoreDate=DateConversion(strArray[3],null);
					strArray[3]=strScoreDate;
				}
			}
			rs=DBUtils.executeLAPSQuery("selmaxscrecord^"+strInwardNo+"^"+strresSno);
				if(rs.next())
				{
					selSCMaxId=correctNull((String)rs.getString("maxid"));
				}
				ArrayList arrValues = new ArrayList();
				HashMap hshQuery = new HashMap();
				HashMap hshQueryValues = new HashMap();
				hshQuery.put("strQueryId","insSCRecord");
				arrValues.add(selSCMaxId);
				arrValues.add(strresSno);
				arrValues.add(strInwardNo);
				for(int l=0;l<strArray.length;l++)
				{
					if(!(((l>14)&&(l<25))||(((l>29)&&(l<75)))||(((l>75)&&(l<90)))))
					{
					arrValues.add(strArray[l]);
					}
				}
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			
		}
		catch(Exception e){
			throw new EJBException(e.toString());
		}
		finally{
			
		}
		return intdataLength;
	}
	private int updatecibilPArecord(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		String strresSno="",strInwardNo="",strresponsedata="";
		String strPAdata="";
		String strSegmentTag="";
		String strMsg="$";
		String strPAMaxid="",strDateReported="";
		String strMemcode="",strLength="",selPNMaxId="";
		int intlength=0,intdataLength=0,intSCLength=0,intPNLength=0;
		String strSCLength="",strPNLength="",strnumtemp="",strSegmentLength="";
		int intSegmentLength=0;
		try{
			strresSno=correctNull((String)hshValues.get("responsemaxId"));
			strInwardNo=correctNull((String)hshValues.get("strInwardNumber"));
			strresponsedata=correctNull((String)hshValues.get("strresponsedata"));
			strMemcode=correctNull(((String)hshValues.get("strmemcode")));
			strSCLength=correctNull((String)hshValues.get("intSClength"));
			strPNLength=correctNull((String)hshValues.get("intPNlength"));
			if(!strSCLength.equalsIgnoreCase(""))
			{
				intSCLength=Integer.parseInt(strSCLength);
			}
			if(!strPNLength.equalsIgnoreCase(""))
			{
				intPNLength=Integer.parseInt(strPNLength);
			}
			strPAdata=strresponsedata.substring(intPNLength);
			String[] strArray=new String[10];
			strSegmentTag=strPAdata.substring(0, 2);
			if(!strSegmentTag.equalsIgnoreCase("PA"))
			{
				strMsg = strMsg + " Error in the record in PA segment,Data is incorrect";
				throw new Exception(strMsg);
			}
			if(!strPAdata.equalsIgnoreCase(""))
			{
				for(int i=0,j=1;i<strPAdata.length();)
				{
					strnumtemp="";
					strLength="";
					intlength=0;
					if(i==0)
					{
						String strtempdata=strPAdata.substring(0,4);
						strSegmentLength=strtempdata.substring(2);
						if(Helper.isNumeric(strSegmentLength))
						{
							intSegmentLength=Integer.parseInt(strSegmentLength);
							strArray[0]=strPAdata.substring(4,(4+intSegmentLength));
							i=intSegmentLength+4;
						}
					}
					strnumtemp=strPAdata.substring(i,i+2);
					if(Helper.isNumeric(strnumtemp))
					{
						j=Integer.parseInt(strnumtemp);
						strLength=strPAdata.substring(i+2,i+4);
						intlength=Integer.parseInt(strLength);
						strArray[j]=strPAdata.substring(i+4,(i+4+intlength));
						i=i+intlength+4;
					}
					else
					{
						break;
					}
					intdataLength=i;
				}
				if(!(Helper.correctNull((String)strArray[8])).equalsIgnoreCase(""))
				{
					strDateReported=DateConversion(strArray[8],null);
					strArray[8]=strDateReported;
				}
				rs=DBUtils.executeLAPSQuery("selmaxPARecord^"+strInwardNo+"^"+strresSno);
				if(rs.next())
				{
					strPAMaxid=correctNull((String)rs.getString("maxid"));
				}
				ArrayList arrValues = new ArrayList();
				HashMap hshQuery = new HashMap();
				HashMap hshQueryValues = new HashMap();
				hshQuery.put("strQueryId","insPARecord");
				arrValues.add(strPAMaxid);
				arrValues.add(strresSno);
				arrValues.add(strInwardNo);
				for(int l=0;l<strArray.length;l++)
				{
					arrValues.add(strArray[l]);
				}
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				//intdataLength=intdataLength+intPNLength;
			}
		}
		catch(Exception e){
			throw new EJBException(e.toString());
		}
		finally{
			
		}
		return intdataLength;
	}
	private int updatecibilTLrecord(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		String strresSno="",strInwardNo="",strresponsedata="";
		String strTLdata="";
		String strSegmentTag="";
		String strMsg="$";
		String strTLMaxid="",strDateReported="";
		String strMemcode="",strLength="",strTLData="";
		int intlength=0,intdataLength=0,intSCLength=0,intPNLength=0,intPALength=0;
		String strSCLength="",strPNLength="",strPALength="",strnumtemp="",strSegmentLength="";
		int intSegmentLength=0;
		try{
			strresSno=correctNull((String)hshValues.get("responsemaxId"));
			strInwardNo=correctNull((String)hshValues.get("strInwardNumber"));
			strresponsedata=correctNull((String)hshValues.get("strresponsedata"));
			strMemcode=correctNull(((String)hshValues.get("strmemcode")));
			strSCLength=correctNull((String)hshValues.get("intSClength"));
			strPNLength=correctNull((String)hshValues.get("intPNlength"));
			strPALength=correctNull((String)hshValues.get("intPAlength"));
			if(!strSCLength.equalsIgnoreCase(""))
			{
				intSCLength=Integer.parseInt(strSCLength);
			}
			if(!strPNLength.equalsIgnoreCase(""))
			{
				intPNLength=Integer.parseInt(strPNLength);
			}
			if(!strPALength.equalsIgnoreCase(""))
			{
				intPALength=Integer.parseInt(strPALength);
			}
			strTLdata=strresponsedata.substring(intPNLength);
			String[] strArray=new String[33];
			strSegmentTag=strTLdata.substring(0, 2);
			if(!strSegmentTag.equalsIgnoreCase("TL"))
			{
				strMsg = strMsg + " Error in the record in TL segment,Data is incorrect";
				throw new Exception(strMsg);
			}
			if(!strTLdata.equalsIgnoreCase(""))
			{
				for(int i=0,j=1;i<strTLdata.length();)
				{
					strnumtemp="";
					strLength="";
					intlength=0;
					if(i==0)
					{
						String strtempdata=strTLdata.substring(0,4);
						strSegmentLength=strtempdata.substring(2);
						if(Helper.isNumeric(strSegmentLength))
						{
							intSegmentLength=Integer.parseInt(strSegmentLength);
							strArray[0]=strTLdata.substring(4,(4+intSegmentLength));
							i=intSegmentLength+4;
						}
					}
					strnumtemp=strTLdata.substring(i,i+2);
					if(Helper.isNumeric(strnumtemp))
					{
						j=Integer.parseInt(strnumtemp);
						strLength=strTLdata.substring(i+2,i+4);
						intlength=Integer.parseInt(strLength);
						strArray[j]=strTLdata.substring(i+4,(i+4+intlength));
						i=i+intlength+4;
					}
					else
					{
						break;
					}
					intdataLength=i;
				}
				if(!(Helper.correctNull((String)strArray[6])).equalsIgnoreCase(""))
				{
					//strDateReported=sd.format(strArray[8]);
					strDateReported=DateConversion(strArray[6],null);
					strArray[6]=strDateReported;
				}
				if(!(Helper.correctNull((String)strArray[9])).equalsIgnoreCase(""))
				{
					//strDateReported=sd.format(strArray[8]);
					strDateReported=DateConversion(strArray[9],null);
					strArray[9]=strDateReported;
				}
				if(!(Helper.correctNull((String)strArray[10])).equalsIgnoreCase(""))
				{
					//strDateReported=sd.format(strArray[8]);
					strDateReported=DateConversion(strArray[10],null);
					strArray[10]=strDateReported;
				}
				if(!(Helper.correctNull((String)strArray[11])).equalsIgnoreCase(""))
				{
					//strDateReported=sd.format(strArray[8]);
					strDateReported=DateConversion(strArray[11],null);
					strArray[11]=strDateReported;
				}
				if(!(Helper.correctNull((String)strArray[30])).equalsIgnoreCase(""))
				{
					//strDateReported=sd.format(strArray[8]);
					strDateReported=DateConversion(strArray[30],null);
					strArray[30]=strDateReported;
				}
				if(!(Helper.correctNull((String)strArray[31])).equalsIgnoreCase(""))
				{
					//strDateReported=sd.format(strArray[8]);
					strDateReported=DateConversion(strArray[31],null);
					strArray[31]=strDateReported;
				}
				rs=DBUtils.executeLAPSQuery("selMaxTlrecord^"+strInwardNo+"^"+strresSno);
				if(rs.next())
				{
					strTLMaxid=correctNull((String)rs.getString("maxid"));
				}
				ArrayList arrValues = new ArrayList();
				HashMap hshQuery = new HashMap();
				HashMap hshQueryValues = new HashMap();
				hshQuery.put("strQueryId","insTLrecord");
				arrValues.add(strTLMaxid);
				arrValues.add(strresSno);
				arrValues.add(strInwardNo);
				for(int l=0;l<strArray.length;l++)
				{
					if(!((l==1)||(l==7)||(l==8)||((l>14)&&(l<28))))
					{
						arrValues.add(strArray[l]);
					}
				}
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch(Exception e){
			throw new EJBException(e.toString());
		}
		finally{
			
		}
		return intdataLength;
	
	}
	private int updatecibilIQrecord(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		String strresSno="",strInwardNo="",strresponsedata="";
		String strTLdata="";
		String strSegmentTag="";
		String strMsg="$";
		String strTLMaxid="",strDateReported="";
		String strMemcode="",strLength="",strTLLength="",strIQData="";
		int intlength=0,intdataLength=0,intSCLength=0,intPNLength=0,intPALength=0,intIQLength=0;
		String strSCLength="",strPNLength="",strPALength="",strnumtemp="",strSegmentLength="";
		int intSegmentLength=0;
		try{
			strresSno=correctNull((String)hshValues.get("responsemaxId"));
			strInwardNo=correctNull((String)hshValues.get("strInwardNumber"));
			strresponsedata=correctNull((String)hshValues.get("strresponsedata"));
			strMemcode=correctNull(((String)hshValues.get("strmemcode")));
			strPNLength=correctNull((String)hshValues.get("intPNlength"));
			if(!strPNLength.equalsIgnoreCase(""))
			{
				intPNLength=Integer.parseInt(strPNLength);
			}
			strIQData=strresponsedata.substring(intPNLength);
			String[] strArray=new String[7];
			strSegmentTag=strIQData.substring(0, 2);
			if(!strSegmentTag.equalsIgnoreCase("IQ"))
			{
				strMsg = strMsg + " Error in the record in IQ segment,Data is incorrect";
				throw new Exception(strMsg);
			}
			if(!strIQData.equalsIgnoreCase(""))
			{
				for(int i=0,j=1;i<strIQData.length();)
				{
					strnumtemp="";
					strLength="";
					intlength=0;
					if(i==0)
					{
						String strtempdata=strIQData.substring(0,4);
						strSegmentLength=strtempdata.substring(2);
						if(Helper.isNumeric(strSegmentLength))
						{
							intSegmentLength=Integer.parseInt(strSegmentLength);
							strArray[0]=strIQData.substring(4,(4+intSegmentLength));
							i=intSegmentLength+4;
						}
					}
					strnumtemp=strIQData.substring(i,i+2);
					if(Helper.isNumeric(strnumtemp))
					{
						j=Integer.parseInt(strnumtemp);
						strLength=strIQData.substring(i+2,i+4);
						intlength=Integer.parseInt(strLength);
						strArray[j]=strIQData.substring(i+4,(i+4+intlength));
						i=i+intlength+4;
					}
					else
					{
						break;
					}
					intdataLength=i;
				}
				if(!(Helper.correctNull((String)strArray[1])).equalsIgnoreCase(""))
				{
					//strDateReported=sd.format(strArray[1]);
					strDateReported=DateConversion(strArray[1],null);
					strArray[1]=strDateReported;
				}
				rs=DBUtils.executeLAPSQuery("selMaxIQrecord^"+strInwardNo+"^"+strresSno);
				if(rs.next())
				{
					strTLMaxid=correctNull((String)rs.getString("maxid"));
				}
				ArrayList arrValues = new ArrayList();
				HashMap hshQuery = new HashMap();
				HashMap hshQueryValues = new HashMap();
				hshQuery.put("strQueryId","insIQrecord");
				arrValues.add(strTLMaxid);
				arrValues.add(strresSno);
				arrValues.add(strInwardNo);
				for(int l=0;l<strArray.length;l++)
				{
					if((l!=2)&&(l!=3))
					{
					arrValues.add(strArray[l]);
					}
				}
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch(Exception e){
			throw new EJBException(e.toString());
		}
		finally{
			
		}
		return intdataLength;
	
	}
	//Error Record
	private HashMap updatecibilERRRrecord(HashMap hshValues) 
	{
		ResultSet rs=null;
		String strInwardNo="",strresponsedata="";
		String strERRRdata="";
		String strSegmentTag="",strDateprocessed="";
		String strTimeProcessed="";
		String strMsg="$";
		String strMemcode="";
		String strERRRMaxid="";
		String[] strArray=new String[15];
		try{
			strInwardNo=correctNull((String)hshValues.get("strInwardNumber"));
			strresponsedata=correctNull((String)hshValues.get("strresponsedata"));
			strMemcode=correctNull(((String)hshValues.get("strmemcode")));
			strERRRdata=strresponsedata.substring(0, 18);
			strSegmentTag=strERRRdata.substring(0,4);
			strDateprocessed=strERRRdata.substring(4,12);
			strTimeProcessed=strERRRdata.substring(12);
			String strDate=DateConversion(strDateprocessed,strTimeProcessed);
			rs=DBUtils.executeLAPSQuery("selMaxErrrecord^"+strInwardNo);
			if(rs.next())
			{
				strERRRMaxid=correctNull((String)rs.getString("maxid"));
			}
			ArrayList arrValues = new ArrayList();
			HashMap hshQuery = new HashMap();
			HashMap hshQueryValues = new HashMap();
			hshQuery.put("strQueryId","insERRRrecord");
			arrValues.add(strERRRMaxid);
			arrValues.add(strInwardNo);
			arrValues.add(strSegmentTag);
			arrValues.add(strDate);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			hshValues.put("strERRRMaxid", strERRRMaxid);
		}
		catch(Exception e){
			throw new EJBException(e.toString());
		}
		finally{
			
		}
		return hshValues;
	}
	//User reference error segment
	private HashMap updatecibilUSRREFrecord(HashMap hshValues) 
	{
		ResultSet rs=null;
		String strInwardNo="",strresponsedata="";
		String strUSRREFdata="";
		String strSegmentTag="",strDateprocessed="",strSegmentTagValue="";
		String strTimeProcessed="";
		String strMsg="$";
		String strMemcode="";
		String strUSRREFMaxid="",strerrrMaxid="",strSegmentLength="";
		String strCode01="",strCode01Length="",strdata01="";
		String strnumtemp="",strLength="";
		int intlength=0,intdataLength=0;
		int intCode01length=0;
		int intSegmentLength=0;
		String[] strArray=new String[18];
		try{
			strInwardNo=correctNull((String)hshValues.get("strInwardNumber"));
			strresponsedata=correctNull((String)hshValues.get("strresponsedata"));
			strMemcode=correctNull(((String)hshValues.get("strmemcode")));
			strerrrMaxid=correctNull(((String)hshValues.get("strERRRMaxid")));
			strUSRREFdata=strresponsedata.substring(18);
			strSegmentTag=strUSRREFdata.substring(0,2);
			if(!strSegmentTag.equalsIgnoreCase("UR"))
			{
				strMsg = strMsg + " Error in the record in Error segment,Data is incorrect ";
				throw new Exception(strMsg);
			}
//			strSegmentLength=strUSRREFdata.substring(2,4);
//			if(!Helper.isNumeric(strSegmentLength))
//			{
//				strMsg = strMsg + " Error in the record in Error segment,Data is incorrect ";
//				throw new Exception(strMsg);
//			}
//			intSegmentLength=Integer.parseInt(strSegmentLength);
//			strSegmentTagValue=strUSRREFdata.substring(4,4+intSegmentLength);
//			strCode01=strUSRREFdata.substring((4+intSegmentLength),(4+intSegmentLength+2));
//			if(!Helper.isNumeric(strCode01))
//			{
//				strMsg = strMsg + " Error in the record in Error segment,Data is incorrect ";
//				throw new Exception(strMsg);
//			}
//			if(strCode01.equalsIgnoreCase("01"))
//			{
//				strCode01Length=strUSRREFdata.substring((4+intSegmentLength+2),(4+intSegmentLength+4));
//				if(!Helper.isNumeric(strCode01Length))
//				{
//					strMsg = strMsg + " Error in the record in Error segment,Data is incorrect ";
//					throw new Exception(strMsg);
//				}
//				intCode01length=Integer.parseInt(strCode01Length);
//				strdata01=strUSRREFdata.substring((4+intSegmentLength+4),(4+intSegmentLength+4+intCode01length));
//			}
			for(int i=0,j=1;i<strUSRREFdata.length();)
			{
				if(i==0)
				{
					String strtempdata=strUSRREFdata.substring(0,4);
					String strLength1=strtempdata.substring(2);
					int intlength1=Integer.parseInt(strLength1);
					strArray[0]=strUSRREFdata.substring(4,(4+intlength1));
					i=4+intlength1;
				}
				strnumtemp="";
				strLength="";
				intlength=0;
				strnumtemp=strUSRREFdata.substring(i,i+2);
				if(Helper.isNumeric(strnumtemp))
				{
					strLength=strUSRREFdata.substring(i+2,i+4);
					intlength=Integer.parseInt(strLength);
					j=Integer.parseInt(strnumtemp);
					strArray[j]=strUSRREFdata.substring(i+4,(i+4+intlength));
					i=i+intlength+4;
				}
				else
				{
					break;
				}
				intdataLength=i;
			}
			rs=DBUtils.executeLAPSQuery("selMaxUSRREFRecord^"+strInwardNo+"^"+strerrrMaxid);
			if(rs.next())
			{
				strUSRREFMaxid=correctNull((String)rs.getString("maxid"));
			}
			ArrayList arrValues = new ArrayList();
			HashMap hshQuery = new HashMap();
			HashMap hshQueryValues = new HashMap();
			hshQuery.put("strQueryId","insUSRREFRecord");
			arrValues.add(strUSRREFMaxid);
			arrValues.add(strerrrMaxid);
			arrValues.add(strInwardNo);
			for(int k=0;k<strArray.length;k++)
			{
				if(k!=2)
				{
					arrValues.add(strArray[k]);
				}
			}
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		catch(Exception e){
			throw new EJBException(e.toString());
		}
		finally{
			
		}
		return hshValues;
	}
	public HashMap getCibilRequest(HashMap hshValues) 
	{
		File Directory = null;
		
		ResultSet rs = null;
		String strIRBPath1=ApplicationParams.getRequestPath();
		String rootPath="";
		String Path =strIRBPath1+"REQUEST";
		StringBuffer s=new StringBuffer();
		String strmempass="";
		BufferedWriter bWriter=null;
		int intinwardlength=0;FileWriter fout = null;				
		String strmemcode="",strEnquiryPurpose="",strEnquiryAmount="";
		String FlatFileName="";
		String strDate="";
		String strPhone="";
		String strPincode="";
		String strState="";
		String strConsName1="",strinward_pantan="",strINWARD_PASSPORTNUMBER="";
		String strINWARD_VOTERID="",strinward_add1="",strinward_add2="",strGender="",strReqsno="";
		SimpleDateFormat sd = null;
		SimpleDateFormat sdt=null;
		String strUsrid=correctNull((String)hshValues.get("strUserId"));
		try 
		{
	            Directory = new File(Path);
	            if(!Directory.exists())
	            {
	                Directory.mkdirs();
	            }
			String strInwardNumber = "";
			strInwardNumber= correctNull((String)hshValues.get("inwardno"));
		if(strInwardNumber.equals(""))
		{
			strInwardNumber = correctNull((String)hshValues.get("InwardNumber"));
		}
        System.out.println("InwardNumber::::----->" + strInwardNumber);
		rs=DBUtils.executeLAPSQuery("Inward_reg^"+strInwardNumber);
            if (rs.next())
            {
            	strConsName1=correctNull((String)rs.getString("inward_custname"));
            	strinward_pantan=correctNull((String)rs.getString("inward_pantan"));
            	strINWARD_PASSPORTNUMBER=correctNull((String)rs.getString("INWARD_PASSPORTNUMBER"));
            	strINWARD_VOTERID=correctNull((String)rs.getString("INWARD_VOTERID"));
            	strinward_add1=correctNull((String)rs.getString("inward_add1"));
            	strinward_add2=correctNull((String)rs.getString("inward_add2"));
            	strEnquiryPurpose=correctNull((String)rs.getString("inward_enquirypurpose"));
            	strEnquiryAmount=correctNull((String)rs.getString("inward_termloanamt"));
    			strDate=correctNull((String)rs.getString("inward_dob"));
    			strPhone=correctNull((String)rs.getString("inward_phone"));
    			strPincode=correctNull((String)rs.getString("inward_zipcode"));
    			strGender=correctNull((String)rs.getString("inward_gender"));
    			strState=correctNull((String)rs.getString("inward_state"));
            }
            StringTokenizer st=new StringTokenizer(strDate,"/");
            strDate="";
            while(st.hasMoreElements())
			{
            	strDate=strDate+((String)st.nextToken());
			}
            s=new StringBuffer();  
            s.append("TUEF");
            s.append("11");
            intinwardlength=strInwardNumber.length();
            s.append(strInwardNumber);
            for(int i=0;i<(25-intinwardlength);i++)
            {
            	s.append(" ");
            }
   		    s.append("  ");
            rs=DBUtils.executeLAPSQuery("selstatdatabyiddesc^73^MEMCODE");
			if(rs.next())
			{
				strmemcode=Helper.correctNull((String)rs.getString("stat_data_desc1"));
			}
			s.append(strmemcode);
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("selstatdatabyiddesc^73^MEMPASS");
			if(rs.next())
			{
				strmempass=Helper.correctNull((String)rs.getString("stat_data_desc1"));
			}
			s.append(strmempass);
			s.append(strEnquiryPurpose);
			int intamtlength=strEnquiryAmount.length();
			if(intamtlength==9)
			{
				s.append(strEnquiryAmount);
			}
			else
			{
				for(int i=0;i<(9-intamtlength);i++)
	            {
	            	s.append("0");
	            }
				s.append(strEnquiryAmount);
			}
			 s.append("   ");
			 s.append("03");
			 s.append("01");
			 s.append("1");
			 s.append("CC");
			 //PN segment
			 s.append("PN");
			 s.append("03");
			 s.append("N01");
			 s.append("01");
			 int intnameLength=0;
			 intnameLength=strConsName1.length();
			 if(intnameLength<=26)
			 {
				 if(strConsName1.length()<10)
				 {
					 s.append("0");
				 }
				 s.append(strConsName1.length());
				 s.append(strConsName1);
			 }
			 else
			 {
				 String strconsnamesub1=strConsName1.substring(0, 25);
				 s.append(strconsnamesub1.length());
				 s.append(strconsnamesub1);
				 s.append("02");
				 if(intnameLength<=52)
				 {
					 String strconsnamesub2=strConsName1.substring(25);
					 if(strconsnamesub2.length()<10)
					 {
						 s.append("0");
					 }
					 s.append(strconsnamesub2.length());
					 s.append(strconsnamesub2);
				 }
				 else
				 {
					 String strconssub3=strConsName1.substring(25,51);
					 s.append(strconssub3.length());
					 s.append(strconssub3);
					 s.append("03");
					 if(intnameLength<=78)
					 {
						 String strconsnamesub4=strConsName1.substring(51);
						 if(strconsnamesub4.length()<10)
						 {
							 s.append("0");
						 }
						 s.append(strconsnamesub4.length());
						 s.append(strconsnamesub4);
					 }
					 else
					 {
						 String strsubcons5=strConsName1.substring(51,77);
						 s.append(strsubcons5.length());
						 s.append(strsubcons5);
						 s.append("04");
						 if(intnameLength<=104)
						 {
							 String strsubcons6=strConsName1.substring(77);
							 if(strsubcons6.length()<10)
							 {
								 s.append("0");
							 }
							 s.append(strsubcons6.length());
							 s.append(strsubcons6);
						 }
					 }
				 }
			 }
			s.append("07");
			s.append("0");
			s.append(strDate.length());
			s.append(strDate);
			s.append("08");
			s.append("01");
			if(strGender.equalsIgnoreCase("F"))
			{
				s.append("1");
			}
			else
			{
				s.append("2");
			}
			if(!strinward_pantan.equalsIgnoreCase(""))
			{
				s.append("09");
				if(strinward_pantan.length()<10)
				{
					s.append("0");
				}
				s.append(strinward_pantan.length());
				s.append(strinward_pantan);
			}
			if(!strINWARD_PASSPORTNUMBER.equalsIgnoreCase(""))
			{
				s.append("10");
				if(strINWARD_PASSPORTNUMBER.length()<10)
				{
					s.append("0");
				}
				s.append(strINWARD_PASSPORTNUMBER.length());
				s.append(strINWARD_PASSPORTNUMBER);
			}
			if(!strINWARD_VOTERID.equalsIgnoreCase(""))
			{
				s.append("11");
				if(strINWARD_VOTERID.length()<10)
				{
					s.append("0");
				}
				s.append(strINWARD_VOTERID.length());
				s.append(strINWARD_VOTERID);
			}
			if(!strPhone.equalsIgnoreCase(""))
			{
				s.append("12");
				if(strPhone.length()<10)
				{
					s.append("0");
				}
				s.append(strPhone.length());
				s.append(strPhone);
				
			}
			//PA segment
			s.append("PA");
			s.append("03");
			s.append("A01");
			s.append("01");
			if(strinward_add1.length()<10)
			{
				s.append("0");
			}
			s.append(strinward_add1.length());
			s.append(strinward_add1);
			if(!strinward_add2.equalsIgnoreCase(""))
			{
			s.append("02");
			if(strinward_add2.length()<10)
			{
				s.append("0");
			}
			s.append(strinward_add2.length());
			s.append(strinward_add2);
			}
			rs=DBUtils.executeLAPSQuery("state_code^"+strState);
			if(rs.next())
			{
				strState=Helper.correctNull((String)rs.getString("state_cibilcode"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			s.append("06");
			if(strState.length()<10)
			{
				s.append("0");
			}
			s.append(strState.length());
			s.append(strState);
			s.append("07");
			if(strPincode.length()<10)
			{
				s.append("0");
			}
			s.append(strPincode.length());
			s.append(strPincode);
			//PI segment
			boolean bstate=false;
			rs=DBUtils.executeLAPSQuery("cibil_account^"+strInwardNumber);
			bstate=rs.next();
			ArrayList arrAccount=new ArrayList();
			if(bstate)
			{
				rs.previous();
				s.append("PI");
				s.append("I01");
//				s.append("01");
				while(rs.next())
				{
				arrAccount.add(Helper.correctNull((String)rs.getString("ca_acc_creditcard_no")));
				}
				int intarrlength=0;
				String strtemp="";
				for(int i=0;i<arrAccount.size();i++)
				{
					intarrlength=0;strtemp="";
					if(i<9)
					{
					s.append("0");
					}
					s.append(i+1);
					strtemp=Helper.correctNull((String)arrAccount.get(i));
					intarrlength=strtemp.length();
					if(intarrlength<10)
					{
						s.append("0");
					}
					s.append(intarrlength);
					s.append(strtemp);
					for(int j=0;j<(25-intarrlength);j++)
		            {
		            	s.append(" ");
		            }
				}
			}
			int inttotallength=0;
			inttotallength=s.length()+16;
			s.append("ES05");
			if(inttotallength<10)
			{
				s.append("0000");
			}
			else if((inttotallength>10) && (inttotallength<100))
			{
				s.append("000");
			}
			else if((inttotallength>100) && (inttotallength<1000))
			{
				s.append("00");
			}
			else
			{
				s.append("0");
			}
			s.append(inttotallength);
			s.append("0102**");
			//Inserting data into response table
			//selMaxrequestdata
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("selMaxrequestdata^"+strInwardNumber);
			if(rs.next())
			{
				strReqsno=correctNull((String)rs.getString("maxid"));
			}
			String strDate1="",strTime="";
			sd = new SimpleDateFormat("ddMMyyyy");
			sdt = new SimpleDateFormat("HHmmss");
			strDate1=sd.format(new Date());
			strTime=sdt.format(new Date());
			String strfilenamestr=strInwardNumber+"-"+strDate1+"-"+strTime+".TUEF";
			FlatFileName=Path+File.separator+strInwardNumber+"-"+strDate1+"-"+strTime+".TUEF";
			String strdate2="";
			strdate2=DateConversion(strDate1, strTime);
			HashMap hshQuery=new HashMap();
			HashMap hshQueryValues=new HashMap();
			ArrayList arrValues=new ArrayList();
			hshQuery.put("strQueryId","inscibilreqdata");
			arrValues.add(strReqsno);
			arrValues.add(strInwardNumber);
			arrValues.add(strfilenamestr);
			arrValues.add(strUsrid);
			arrValues.add(strdate2);
			arrValues.add(s.toString());
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			//end 
			 /*File file = new File(FlatFileName);
		    	RandomAccessFile raf = new RandomAccessFile(file, "rw");
				raf.seek(file.length());
				raf.writeBytes(s.toString());
				raf.writeBytes("\n");
				raf.close();*/
			fout=new FileWriter(FlatFileName);
			bWriter=new BufferedWriter(fout);
			bWriter.write(s.toString());
			bWriter.newLine(); 
			bWriter.close();
	       
		}
		catch (Exception e) 
		{
			Logger.log(e.getMessage());
		} 
		finally 
		{
			try
			{
				if(rs!=null)
				{
					rs.close();	
					
				}
		    }
			catch (Exception e) 
			{
				Logger.log(e.getMessage());
			}
		}
      return hshValues;
}
}
