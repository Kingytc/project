function CallPostSancRestriction()
{
	var factype=document.forms[0].factype.value;
	disableFields(true);
	
	if(factype == "facility")
	{
		if(document.forms[0].sel_fac_desc.value=="4")
		{
			document.getElementById("duedate").style.display = "none";
			document.getElementById("leaderbank").style.display = "none";
			//document.getElementById("duedate").style.position = "absolute";
			document.getElementById("prod_sel_icon").style.visibility = "hidden";
			document.getElementById("prod_sel_icon").style.position = "absolute";
		}
		else
		{
			document.getElementById("duedate").style.display = "inline";
			document.getElementById("leaderbank").style.display = "inline";
			//document.getElementById("duedate").style.position = "relative";
			document.getElementById("prod_sel_icon").style.visibility = "visible";
			document.getElementById("prod_sel_icon").style.position = "relative";
			
		}
		var varPSterms = document.forms[0].hidPStermsSelected.value.split("@");
		for(var i=0;i<varPSterms.length;i++)
		{
			if(varPSterms[i] == "DLA")
			{
				document.forms[0].txt_proposed_limit.readOnly = false;
			}
			if(varPSterms[i] == "DATEEX")
			{
				document.getElementById("duedate").style.display = "inline";
				//document.getElementById("duedate").style.position = "relative";
			}
			if(varPSterms[i] == "DLP")
			{
				document.forms[0].txt_facmonths.readOnly = false;
			}
			if(varPSterms[i] == "MRI")
			{
				//document.forms[0].sel_inttype.disabled = false;
			}
			if(varPSterms[i] == "CHDCCO")
			{
				document.forms[0].txt_installments.readOnly = false;
			}
			if(varPSterms[i] == "BRTOMCLR")
			{
				document.forms[0].sel_intsutype.disabled = false;
				document.forms[0].sel_interesttype.disabled = false;
			}
			if(varPSterms[i] == "MODGSS")
			{
				document.forms[0].selectgovtmain.disabled = false;
				document.forms[0].schemetypemain.disabled=false;
	         	document.forms[0].submainamnt.readOnly=false;
	         	document.forms[0].sel_sponser_agencymain.disabled=false;
	         	document.forms[0].sel_subsidytypemain.disabled=false;
	         	document.forms[0].txt_agency.readOnly=false;
			}
			if(varPSterms[i] == "MODBA")
			{
				document.forms[0].sel_propbanktype.disabled = false;
				document.getElementById("leaderbank").style.display = "inline";
			}
			if(varPSterms[i] == "MRS")
			{
				document.forms[0].sel_peridicityfac.disabled = false;
			}
		}
		if(document.forms[0].sel_fac_desc.value!="4")
		{
			disableFields(false);
		}
	}
	else if(factype == "sublimit")
	{
		if(document.forms[0].sel_subfac_desc.value=="4")
		{
			document.getElementById("subduedate").style.display = "none";
			document.getElementById("leaderbankSub").style.display = "none";
			//document.getElementById("subduedate").style.position = "absolute";
			document.getElementById("prod_sel_icon_sub").style.visibility = "hidden";
			document.getElementById("prod_sel_icon_sub").style.position = "absolute";
		}
		else
		{
			document.getElementById("subduedate").style.display = "inline";
			document.getElementById("leaderbankSub").style.display = "inline";
			//document.getElementById("subduedate").style.position = "relative";
			document.getElementById("prod_sel_icon_sub").style.visibility = "visible";
			document.getElementById("prod_sel_icon_sub").style.position = "relative";
		}
		var varPStermsSub = document.forms[0].hidSubPStermsSelected.value.split("@");
		for(var i=0;i<varPStermsSub.length;i++)
		{
			if(varPStermsSub[i] == "DLA" || varPStermsSub[i] == "INLIM")
			{
				document.forms[0].txt_subproposed_limit.readOnly = false;
			}
			if(varPStermsSub[i] == "DATEEX")
			{
				document.getElementById("subduedate").style.display = "inline";
				//document.getElementById("subduedate").style.position = "relative";
			}
			if(varPStermsSub[i] == "DLP")
			{
				document.forms[0].txt_subfacmonths.readOnly = false;
			}
			if(varPStermsSub[i] == "MRI")
			{
				//document.forms[0].sel_sub_inttype.disabled = false;
			}
			if(varPStermsSub[i] == "CHDCCO")
			{
				document.forms[0].txt_installments_sub.readOnly = false;
			}
			if(varPStermsSub[i] == "BRTOMCLR")
			{
				document.forms[0].sel_intsufacsubtype.disabled = false;
				document.forms[0].sel_sub_interesttype.disabled = false;
			}
			if(varPStermsSub[i] == "MODGSS")
			{
				document.forms[0].selectgovt.disabled = false;
				document.forms[0].schemetype.disabled=false;
	        	document.forms[0].subamt.readOnly=false;
	        	document.forms[0].sel_sponser_agency.disabled=false;
	        	document.forms[0].sel_subsidytype.disabled=false;
	        	document.forms[0].txt_subagency.readOnly=false; 
			}
			if(varPStermsSub[i] == "MODBA")
			{
				document.forms[0].sel_sub_propbanktype.disabled = false;
				document.getElementById("leaderbankSub").style.display = "inline";
			}
			if(varPStermsSub[i] == "MRS")
			{
				document.forms[0].sel_peridicityfacsub.disabled = false;
			}
		}
		if(document.forms[0].sel_subfac_desc.value!="4")
		{
			disableFields(false);
			if(document.forms[0].checkbox.checked==true)
			{
				document.forms[0].facility_head.disabled=true;	
				document.forms[0].facility.disabled=true;	
				document.forms[0].txt_exist_limit.readOnly=true;
				document.forms[0].txt_proposed_limit.readOnly=true;			
				document.forms[0].sel_propbanktype.disabled=true;
				document.forms[0].sel_inttype.disabled=true;
				document.forms[0].sel_peridicityfac.disabled=true;
				document.forms[0].sel_repaytype.disabled=true;
				document.forms[0].selectgovtmain.disabled=true;	
				document.forms[0].facilitydesc.disabled=true;	
				document.forms[0].sel_intsutype.disabled=true;					

				document.forms[0].txt_desc.readOnly=true;			
				document.forms[0].txt_purpose.readOnly=true;		
				document.forms[0].txt_facmonths.readOnly=true;

				if(document.forms[0].selectgovtmain.value=="1")
				{
					document.forms[0].schemetypemain.disabled=true;
					document.forms[0].sel_sponser_agencymain.disabled=true;
					document.forms[0].sel_subsidytypemain.disabled=true;
					document.forms[0].submainamnt.readOnly=true;

				}	

				document.forms[0].txt_installments.readOnly=true;
				if(document.forms[0].txt_installments.value!="0" && document.forms[0].txt_installments.value!="")
				{
					document.forms[0].interestservised.disabled=true;
					document.forms[0].sel_interestcharge.disabled=true;
				}
				document.forms[0].txt_margin.readOnly=true;
				
				document.forms[0].selfac_restr_acc.disabled=true;	
				document.forms[0].selfac_fitl_acc.disabled=true;	
				document.forms[0].sel_restr_conversionfac.disabled=true;	
				document.forms[0].sel_restr_addfunding.disabled=true;
			}
		}
	}
}

function LoadSharePage()
{
	var appno=document.forms[0].appno.value;
	if(document.forms[0].cmdsave.disabled == true)
	{
		var varQryString = appURL+"action/fac_shg_membershare.jsp?hidBeanId=facilities&hidBeanGetMethod=getSHGmembershare&appno="+appno+"&btnenable="+document.forms[0].btnenable.value;
		var title = "SHG_Member_wise_Share";
		var prop = "scrollbars=yes,menubar=yes,status=yes,width=1200,height=500";
		prop = prop + ",left=50,top=150";
	    window.open(varQryString,title,prop);
	}
}

function totalInt()
 {
	var baserate = parseFloat(document.forms[0].prd_intrate.value);
	var adjrate  = parseFloat(document.forms[0].txt_margin.value);

	if(baserate == null || isNaN(baserate))
	{
		baserate = 0.00;
	}
	if(adjrate == null || isNaN(adjrate))
	{
		adjrate = 0.00;
	}

	document.forms[0].txt_interest.value = roundVal(baserate + adjrate);
}

function sub_totalInt()
 {
	var baserate1 = parseFloat(document.forms[0].prd_subintrate.value);
	var adjrate1  = parseFloat(document.forms[0].txt_submargin.value);

	if(baserate1 == null || isNaN(baserate1))
	{
		baserate1 = 0.00;
	}
	if(adjrate1 == null || isNaN(adjrate1))
	{
		adjrate1 = 0.00;
	}

	document.forms[0].txt_subinterest.value = roundVal(baserate1 + adjrate1);
}

function getFacility(strtype)
{	
    if(document.forms[0].sel_proposalvaluesin.value=="S")
    {
     alert("Select All Values are in");
     document.forms[0].sel_proposalvaluesin.focus();
     document.forms[0].facility_head.value="-";
     return;    

    }
	if(strtype=="facility")
	{
         document.forms[0].facility.value="-";
         document.forms[0].facilitydesc.value="";
         document.forms[0].txt_proposed_limit.value="";
		document.forms[0].hidGrpList.value="";
		arr1=document.forms[0].facility_head.value.split("~");		
		var facilityhead = document.forms[0].elements["facility_head"].value;
		arr = facilityhead.split("-");
		var parentparam =arr[0];
		if(parentparam)
		{	document.all.ifrm1.src=appUrl+"action/iframefacility.jsp?hidBeanId=facilitymaster&parent="+parentparam+"&value=subsel&hidMethod=getFacility&strtype=facility";
		}
	}
	else if(strtype=="sublimit")
	{		
		    document.forms[0].subfacility.value="-";
	         document.forms[0].facilitydescsub.value="";
	         document.forms[0].txt_subproposed_limit.value="";
		var subfacilityhead = document.forms[0].elements["subfacility_head"].value;
		arr = subfacilityhead.split("-");
		var parentparam =arr[0];			
		if(parentparam)
		{
		document.all.ifrm1.src=appUrl+"action/iframefacility.jsp?hidBeanId=facilitymaster&parent="+parentparam+"&value=subsel&hidMethod=getFacility&strtype=sublimit";
		}
		else
		{			
			document.forms[0].subfacility.length=1;
			document.forms[0].subfacility.selectedIndex=1;
		}
	} 
 }



function findtype()
{
	var hidAction = document.forms[0].hidAction.value;
	var subno=0;
	var factype =document.forms[0].factype.value;
	if(!isNaN(document.forms[0].selsubsno.value))
	{
	   subno = parseInt(document.forms[0].selsubsno.value);
	}
	if(!subno)
	{
		subno=0;
	}
	if(document.forms[0].cmdnew.disabled==true && document.forms[0].cmdedit.disabled==true)
	{
		if(document.forms[0].checkbox.checked==true)
		{
			document.forms[0].checkbox.checked=false;
			alert("Can't check in edit mode or add mode");			
			return;
		}
	}
	if((document.forms[0].cmdedit.disabled==true) && (hidAction=="update") && (factype=="sublimit"))
	{
		alert("Can't uncheck");
		document.forms[0].checkbox.checked=true;
		return;
	}
	 else if((subno>0) && (document.forms[0].factype.value=="sublimit") && (hidAction=="update"))
	 {
		alert("Can't uncheck,because sub-limit exists");
		document.forms[0].checkbox.checked=true;
		return;
	 }

	if(document.forms[0].checkbox.checked==true)
	{
		document.forms[0].cmdnew.disabled=false;
	}
	else
	{
		 if((subno>0) && (document.forms[0].factype.value=="sublimit") && ("<%=strAction%>"=="update"))
		 {	
			alert("Can't uncheck");
		 	document.forms[0].checkbox.checked=true
			 return;
		 }
		else
		{
		document.forms[0].factype.value="facility"
		}
	}
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmddelete.disabled=true;
	document.forms[0].cmdcancel.disabled=false;
}

 function disableFields(val)
  {
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  if(document.forms[0].elements[i].type=='text'  )
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
		  if(document.forms[0].elements[i].type=='textarea'  )
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
		  if(document.forms[0].elements[i].type=='select-one' )
		  {
 				document.forms[0].elements[i].disabled=val;
		  }
		  if(document.forms[0].elements[i].type=='select-multiple' )
		  {
 				document.forms[0].elements[i].disabled=val;
		  }
		  //if(document.forms[0].elements[i].type=='radio' ) //Issue Fixing enable radio button when i click New button by ashok
		  //{
			//  {
 				//document.forms[0].elements[i].disabled=(!val);
			  //}
		  //}
	  }
	  document.forms[0].prd_intrate.readOnly=true;
	  document.forms[0].prd_subintrate.readOnly=true;
	  document.forms[0].txt_appinwardno.readOnly=true;	 
	  //document.forms[0].txt_subinterest.readOnly=true;
	 // document.forms[0].category[0].disabled=false;
	 // document.forms[0].category[1].disabled=false;
	  document.forms[0].facilitydescsubnew.readOnly=true;
	  document.forms[0].facilitydescnew.readOnly=true;
	  document.forms[0].sel_fac_desc.disabled=true;
	  document.forms[0].sel_subfac_desc.disabled=true;
	  document.forms[0].txt_exist_limit.readOnly=true;
	  document.forms[0].txt_subexist_limit.readOnly=true;
	  document.forms[0].txt_LeadBank.readOnly=true;
	  document.forms[0].txt_sub_LeadBank.readOnly=true;
	  
	  document.forms[0].txt_schemecode.readOnly=true;
	  document.forms[0].txt_subschemecode.readOnly=true;

	  document.forms[0].txt_restructdate.readOnly=true;
		
	//  document.forms[0].txt_cg_int_rate.readOnly=true;
	  
	}

function disableCommandButtons(val)
{
	if(val=="load")
	{
		if(document.forms[0].btnenable.value =='N')
	  	{
			document.forms[0].cmdnew.disabled=true;
		  	document.forms[0].cmdedit.disabled=true;
		  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
	 	}
	 	else
	 	{
	 		document.forms[0].cmdedit.disabled=false;
	 	  	document.forms[0].cmddelete.disabled=false;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=false;
		  	document.forms[0].cmdclose.disabled=false;
	 	}
	}
	if(val=="edit" || varhidpge =='newpge' ||  varhidRen == 'renewal')
	{
		if(document.forms[0].btnenable.value =='N')
	  	{
			document.forms[0].cmdnew.disabled=true;
		  	document.forms[0].cmdedit.disabled=true;
		  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
	 	}
	 	else
	 	{
			document.forms[0].cmdedit.disabled=true;
			document.forms[0].cmddelete.disabled=true;
			document.forms[0].cmdsave.disabled=false;
			document.forms[0].cmdcancel.disabled=false;
			if(document.forms[0].appno.value != "new")
			{
				document.forms[0].cmdclose.disabled=true;
			}
			else
			{
				document.forms[0].cmdclose.disabled=false;
				document.forms[0].cmddelete.disabled=true;
				document.forms[0].cmdcancel.disabled=true;
			}
		}
		disableFields(false);
	}
}
  

function doClose()
{
	var cattype=document.forms[0].cattype.value;
 	if(ConfirmMsg(100))
 	{
		document.forms[0].action=appUrl+"action/corppge.jsp";
	 	document.forms[0].submit();
	}
}

function selectvalues1()
{
	arr1=document.forms[0].facility_head.value.split("~");
}

function showval()
{
 	arr1=document.forms[0].facility_head.value.split("~");
}
  

function callApplicanthelp()
{
	  if(document.forms[0].cmdedit.disabled && editflag==1)
	  {
		var prop = "scrollbars=no,width=450,height=300,,top=100,left=250";
		var url=appUrl+"action/comapplicantlist.jsp";
		window.open(url,"",prop);
	  }
}

function opendisfixed(field)
{
	if (document.forms[0].cmdsave.disabled == false)
	{
	var num="-";
	
	  var purl = appUrl+"action/fixedselect.jsp?val=fixedselect&num="+num+"&baserate="+field+"&identity=floating";
	  var prop = "scrollbars=no,width=450,height=360";	
	  var title = "InterestRate";
	  var xpos = (screen.width - 350) / 2;
	  var ypos = (screen.height - 320) / 2;
	  prop = prop + ",left="+xpos+",top="+ypos;
    window.open(purl,title,prop);
	}
}

function callBankmasterNew(id)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
			var varQryString = appURL+"action/ops_sanctionhelp.jsp?hidBeanGetMethod=getSearch&hidBeanId=additionalParameter&pagename=CusBanking&id="+id+"&LeadBank=Y";
			var title = "Bank_Master";
			var prop = "scrollbars=no,width=650,height=400";
			var xpos = "50";
			var ypos = "50";
			prop = prop+","+xpos+","+ypos+",left=200,top=200";
			window.open(varQryString,title,prop);
	}
}
function callBankmasterNew1(id)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
			var varQryString = appURL+"action/ops_sanctionhelp.jsp?hidBeanGetMethod=getSearch&hidBeanId=additionalParameter&pagename=CusBanking_sub&id="+id+"&LeadBank=Y";
			var title = "Bank_Master";
			var prop = "scrollbars=no,width=650,height=400";
			var xpos = "50";
			var ypos = "50";
			prop = prop+","+xpos+","+ypos+",left=200,top=200";
			window.open(varQryString,title,prop);
	}
}

function callApplicantTab(page)
{
	
 var cattype=document.forms[0].cattype.value;

 	if(document.forms[0].cmdsave.disabled)
	{
     
	  if(page=="company")
	  { 
	   if((cattype!="ASSI")||(cattype!="ASBI"))
      {
		  document.forms[0].hidBeanGetMethod.value="getcompanyData";
		  document.forms[0].action=appUrl+"action/comcompany.jsp";
		  }
		  if((cattype=="ASSI")||(cattype=="ASBI"))
        {
		  document.forms[0].hidBeanGetMethod.value="getcompanyData";
		  document.forms[0].action=appUrl+"action/agrcompany.jsp";
		  }
	  }
	  if(page=="proposal")
	  {
		  document.forms[0].hidBeanGetMethod.value="getProposal";
		  document.forms[0].action=appUrl+"action/comproposal.jsp";
	  }
	  if(page=="securities")
	  {
		  document.forms[0].hidBeanGetMethod.value="getProposal";
		  document.forms[0].action=appUrl+"action/com_securities.jsp";
	  }
	  document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}


function assignData()
{
try
{
document.forms[0].hid_facility_head.value=document.forms[0].facility_head.options[document.forms[0].facility_head.selectedIndex].text;
document.forms[0].hid_facility.value=document.forms[0].facility.options[document.forms[0].facility.selectedIndex].text;
document.forms[0].hid_subfacility_head.value=document.forms[0].facility_head.options[document.forms[0].subfacility_head.selectedIndex].text;
document.forms[0].hid_subfacility.value=document.forms[0].subfacility.options[document.forms[0].subfacility.selectedIndex].text;
}
catch(rr)
{
}
}

function callCalender(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		 showCal(appUrl,val);
	}
}

function doShowmessage()
{
	if(document.forms[0].sel_proposalvaluesin.value=="R")
	{
		alert('Please ensure to enter all values in Rupees');
	}
	 document.forms[0].facility.value="-";
     document.forms[0].facility_head.value="-";
}

function optionsenable()
{
	if(document.forms[0].checkbox.checked==true)
	{
		document.getElementById('hidesublimit').style.display="table";
	}
	else
	{
		document.getElementById('hidesublimit').style.display="none";
	}
}
function optionsdisable()
{
	document.getElementById('hidesublimit').style.display="none";
}


function chkaccount(obj)
{
	if(document.forms[0].hidDefermentDetails.value!="")
	{
		var varFacDet=document.forms[0].hidDefermentDetails.value.split("@");
		for(var i=0;i<varFacDet.length;i++)
		{
			var varFacDet1=varFacDet[i].split("~");
			if((varFacDet1[0]!=document.forms[0].selsno.value || varFacDet1[0]!=document.forms[0].selsubsno.value) && varFacDet1[1]==obj.value)
			{
				alert("Account No already attached with facility"+varFacDet1[0]);
				obj.value="";
				return;
			}
		}
	}
}


function checkReviewDate(obj,Flag)
{
	{
		var varDate=currentDate;
		if(Flag=="Y")
		{
			if(document.forms[0].txt_duedate.value!="")
			{
				//varDate=document.forms[0].txt_duedate.value;
			}
		}
		else
		{
			if(document.forms[0].txt_subduedate.value!="")
			{
				//varDate=document.forms[0].txt_subduedate.value;
			}
		}
		var d = new Date(varDate.substring(6,currentDate.length), varDate.substring(3,5), varDate.substring(0,2)); // January 1, 2000
		d.setMonth(d.getMonth()-1 + parseInt(6));
		
		var varMon=parseInt(d.getMonth())+1;
		var vardate=d.getDate()+"/"+varMon+"/"+d.getFullYear();
		var day = "";
		var mon = "";
		var year = "";
		
		day = vardate.substring(0,2);
		if(day.substring(1,2) == "/")
		{
			day = "0"+day.substring(0,1);
			mon = vardate.substring(2,4);
			
			if(mon.substring(1,2) == "/")
			{	mon = "0"+mon;
				vardate = day+"/"+mon+vardate.substring(vardate.length-4,vardate.length);
			}
			else
			{
				vardate = day+"/"+mon+"/"+vardate.substring(vardate.length-4,vardate.length);
			}			
		}
		else 
		{
			mon = vardate.substring(3,5);			
			if(mon.substring(1,2) == "/")
			{
				mon = "0"+mon;
				vardate = day+"/"+mon+vardate.substring(vardate.length-4,vardate.length);
			}
			else
			{
				vardate = day+"/"+mon+"/"+vardate.substring(vardate.length-4,vardate.length);
  			}
		}
	
		checkmonthEnd(obj,vardate);
	}
}
function justification(flag)
{
	var varProposed;
	var varExistlimit;
	//if()
	{
		  if(flag=="N" && document.forms[0].sel_fac_desc.value=="2")
		  {
			  varProposed=document.forms[0].txt_proposed_limit.value;	
		      varExistlimit=document.forms[0].txt_exist_limit.value;
		  
		      if(eval(varProposed)!=eval(varExistlimit))
		      
		      {
			        document.forms[0].hid_jusflag.value="Y";
		    		document.all.renewal_justif.style.display="table-row"; 
		    		document.forms[0].txt_renewaljustif.focus();
		      }
		      else
		      {
		    	  document.forms[0].hid_jusflag.value="N";
		    	  document.forms[0].txt_renewaljustif.value="";
		    	  document.all.renewal_justif.style.display="none"; 
		      }
		      
		  }
		  
		  else if(flag=="Y" && document.forms[0].sel_subfac_desc.value=="2")
		  {
			  varProposed=NanNumber(document.forms[0].txt_subproposed_limit.value);	 
			  varExistlimit=NanNumber(document.forms[0].txt_subexist_limit.value);
		
			  if(eval(varProposed)!=eval(varExistlimit))
		      {
			       document.forms[0].hid_jusflag.value="Y";
		    		document.all.renewal_justif_sub.style.display="table-row"; 
		    		document.forms[0].txt_renewaljustif_sub.focus();
		      }
		      else
		      {
			      document.forms[0].hid_jusflag.value="N";
			      document.forms[0].txt_renewaljustif_sub.value="";
		    	  document.all.renewal_justif_sub.style.display="none"; 
		      }
		  }
	}

}
function callintrate(){

	document.forms[0].sel_intsutype.value="";
	alert("selec sub interest type");
}
function callintrate1(){

	document.forms[0].sel_intsufacsubtype.value="";
	alert("selec sub interest type");
}

function checkdateval(){
	if(varAppType=="S")
	{ 
		if(document.forms[0].sel_restr_scheme.value =="27"||document.forms[0].sel_restr_scheme.value =="28"||document.forms[0].sel_restr_scheme.value =="29"){
		document.all.idrestrinvoc.style.display="table-row";
		document.all.idrestrinvoc.style.display="table-row";
		
		}else{
			document.all.idrestrinvoc.style.display="none";
			document.all.idrestrinvoc.style.display="none";
		}
	}
	
}


function openNCGTC()
{
	appno=document.forms[0].appno.value;
	var varQryString = appURL+"action/corpNcgtcCoverage.jsp?hidBeanId=supuser&hidBeanGetMethod=getCorpNcgtc&appno="+ appno;
	var prop = "scrollbars=yes,width=1000,height=600, menubar=no";	
	prop = prop + ",left=100,top=50";
	window.open(varQryString,"ncgtc",prop);
}

function clearRadioButton()
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if((document.forms[0].elements[i].name.indexOf("category"))!=0 && (document.forms[0].elements[i].type=="radio"))
		{
			document.forms[0].elements[i].checked=false;
		}
	}
}

function agriTabDeleteDataMessage(){
	if(document.forms[0].hidAction.value=="update"){	
		alert('ON CHANGING THE SCHEME TYPE ALL AGRICULTURE TAB DETAILS OF THIS SCHEME WILL GET DELETED');
	}
}
function callcbsaccountno()
{
	var factype=document.forms[0].factype.value;
	var facility_nature=document.forms[0].sel_fac_desc.value;
	if(factype=="facility")
	{
		if(facility_nature=="1")
		{
			document.all.idexisaccnolab.style.visibility="hidden";
			document.all.idexisaccnolab.style.position="absolute";	
			document.all.idexisaccnoval.style.visibility="hidden";
			document.all.idexisaccnoval.style.position="absolute";	
			
		}
		else
		{
			document.all.idexisaccnolab.style.visibility="visible";
			document.all.idexisaccnolab.style.position="relative";	
			document.all.idexisaccnoval.style.visibility="visible";
			document.all.idexisaccnoval.style.position="relative";
			document.all.efl.innerHTML="Existing Facility CBS Account No.&nbsp;<span class='mantatory'>*</span>";	
		}
	}
}

function callduedate(val)
{
	var factype=document.forms[0].factype.value;
	if(factype=="facility")
	{
		if(val =="OD" || (document.forms[0].facility_head_id_code.value=="5" && document.forms[0].facility_id_code.value=="98"))
		{
/*			document.all.idduedate.style.visibility="visible";
			document.all.idduedate.style.position="relative";	
			document.all.idduedatetxt.style.visibility="visible";
			document.all.idduedatetxt.style.position="relative";
*/
			document.all.idduedate.style.display="table-cell";
			document.all.idduedatetxt.style.display="table-cell";
		}	
		else
		{
/*			document.all.idduedate.style.visibility="hidden";
			document.all.idduedate.style.position="absolute";	
			document.all.idduedatetxt.style.visibility="hidden";
			document.all.idduedatetxt.style.position="absolute";
*/
			document.all.idduedate.style.display="none";
			document.all.idduedatetxt.style.display="none";
		}

		if(document.forms[0].facility_head_id_code.value=="5" && document.forms[0].facility_id_code.value=="98")
		{
			document.all.idfacdeferment.style.display="table-row";
		}
		else
		{
			document.all.idfacdeferment.style.display="none";
		}
	}
}

function callsubduedate(val)
{
	
	var factype=document.forms[0].factype.value;
	if(factype=="sublimit")
	{
		if(val == "OD" || (document.forms[0].facilitysub_head_id_code.value=="5" && document.forms[0].facilitysub_id_code.value=="98"))
		{
			document.all.idsubduedate.style.visibility="visible";
			document.all.idsubduedate.style.position="relative";	
			document.all.idsubduedatetxt.style.visibility="visible";
			document.all.idsubduedatetxt.style.position="relative";
		}	
		else
		{
			document.all.idsubduedate.style.visibility="hidden";
			document.all.idsubduedate.style.position="absolute";	
			document.all.idsubduedatetxt.style.visibility="hidden";
			document.all.idsubduedatetxt.style.position="absolute";
		}

		if(document.forms[0].facilitysub_head_id_code.value=="5" && document.forms[0].facilitysub_id_code.value=="98")
		{
			document.all.idfacdefermentsub.style.display="table-row";
		}
		else
		{
			document.all.idfacdefermentsub.style.display="none";
		}
	}
}

function checkamt(varsubFlag)
{
	if(varsubFlag=="N")
	{
	    var varloansub=document.forms[0].submainamnt.value;
	}
	else
	{
		var varloansub=document.forms[0].subamt.value;
	}
	if(varsubFlag=="N")
	{
	    var amtreqd=document.forms[0].txt_proposed_limit.value;
	}
	else
	{
		var amtreqd=document.forms[0].txt_subproposed_limit.value;
	}
	;
	if(varloansub=="")
	{
		varloansub=0;
	}
	if(eval(amtreqd)<eval(varloansub))
	{
		alert("Subsidy Amount cannot be greater than Proposed Limit");
		if(varsubFlag=="N")
		{
		 document.forms[0].submainamnt.value="";
		 document.forms[0].submainamnt.focus();
		}
		else
		{
		document.forms[0].subamt.value="";	
		document.forms[0].subamt.focus();	
		}
		
		return;
	}
}

function hideCBSaccountno()
{
	if((document.forms[0].facility_nature.value=="2") && (varstrSessionModuleType=="CORP"))
	{
		document.all.id_Tuflab.style.visibility="visible";
		document.all.id_Tuflab.style.position="relative";
		document.all.id_Tufval.style.visibility="visible";
		document.all.id_Tufval.style.position="relative";
	}
	else if(varstrSessionModuleType=="CORP"){
		document.all.id_Tuflab.style.visibility="hidden";
		document.all.id_Tuflab.style.position="absolute";
		document.all.id_Tufval.style.visibility="hidden";
		document.all.id_Tufval.style.position="absolute";
	}
	if(document.forms[0].sel_fac_desc.value=="1" || document.forms[0].sel_fac_desc.value=="3")
	 {
		 document.all.Existing_limit.style.visibility="hidden";
		 document.all.Existing_limit1.style.visibility="hidden";
		 document.all.idexisaccnolab.style.visibility="hidden";
		 document.all.idexisaccnoval.style.visibility="hidden";
	 }else
	 {
		 document.all.Existing_limit.style.visibility="visible";
		 document.all.Existing_limit1.style.visibility="visible";
		 document.all.idexisaccnolab.style.visibility="visible";
		 document.all.idexisaccnoval.style.visibility="visible";
	 } 
	if(document.forms[0].sel_subfac_desc.value=="1" || document.forms[0].sel_subfac_desc.value=="3")
	{
	 	document.all.sublimitexisting.style.visibility="hidden";
	 	document.all.sublimitexisting1.style.visibility="hidden";
	 	document.all.idexissubfacaccnolab.style.visibility="hidden";
	 	document.all.idexissubfacaccnoval.style.visibility="hidden";
	 	
	}else
	{
	 	document.all.sublimitexisting.style.visibility="visible";
	 	document.all.sublimitexisting1.style.visibility="visible";
	 	document.all.idexissubfacaccnolab.style.visibility="visible";
	 	document.all.idexissubfacaccnoval.style.visibility="visible";
	}
}
function showAgency()
{
	if(trim(document.forms[0].sel_sponser_agencymain.value)=="OTHERS")
	{
		document.all.s4m.style.display="table-row";
	}
	else
	{
		document.all.s4m.style.display="none";
	}
}
function showsubAgency()
{
	if(trim(document.forms[0].sel_sponser_agency.value)=="OTHERS")
	{
	document.all.s4s.style.visibility="visible";
	document.all.s4s.style.position="relative";
	}
	else
	{
		document.all.s4s.style.visibility="hidden";
		document.all.s4s.style.position="absolute";
	}
}
function loadcallduedate()
{
/*	document.all.idduedate.style.visibility="hidden";
	document.all.idduedate.style.position="absolute";	
	document.all.idduedatetxt.style.visibility="hidden";
	document.all.idduedatetxt.style.position="absolute";*/

	document.all.idduedate.style.display="none";
	document.all.idduedatetxt.style.display="none";
	
	document.all.idfacdeferment.style.display="none";
	
}
function loadsubcallduedate()
{
	document.all.idsubduedate.style.visibility="hidden";
	document.all.idsubduedate.style.position="absolute";	
	document.all.idsubduedatetxt.style.visibility="hidden";
	document.all.idsubduedatetxt.style.position="absolute";
	document.all.idfacdefermentsub.style.display="none";
	
	
}
function repaymentsel()
{
	var varEmi= document.forms[0].sel_repaytype.value;
	if( varEmi=="E")
	{
		document.forms[0].sel_peridicityfac.value="m";
		document.forms[0].sel_peridicityfac.disabled=true;
		
    }
	else if (varEmi=="OD")
	{
		document.forms[0].sel_peridicityfac.value="n";
		document.forms[0].sel_peridicityfac.disabled=true;
	}
	else 
	{
		document.forms[0].sel_peridicityfac.value="s";
		document.forms[0].sel_peridicityfac.disabled=false;
	}
}
function repaymentselsub()
{
	var varEmi= document.forms[0].sel_sub_repaytype.value;
	if( varEmi=="E")
	{
		document.forms[0].sel_peridicityfacsub.value="m";
		document.forms[0].sel_peridicityfacsub.disabled=true;
		
    }
	else if (varEmi=="OD")
	{
		document.forms[0].sel_peridicityfacsub.value="n";
		document.forms[0].sel_peridicityfacsub.disabled=true;
	}
	else 
	{
		document.forms[0].sel_peridicityfacsub.value="s";
		document.forms[0].sel_peridicityfacsub.disabled=false;
	}
}
function callRenewFacility()
{
	if(varapp_freeze_flag == "Y")
	{
		alert("Coapplicant/guarantor is freezed. You cannot add a new facility");
		return;
	}
	
	if(document.forms[0].cmdsave.disabled==false)
	{
		var hidrenewFac = "Y";
		if(document.forms[0].selfacilitytype.value=="S")
		{
			hidrenewFac = "S";
		}
		else if(document.forms[0].selfacilitytype.value=="P")
		{
			hidrenewFac = "P";
		}
		var comapp_newid=document.forms[0].comapp_newid.value;
		strAppid=document.forms[0].hidapplicantid.value; 
		var appno=document.forms[0].appno.value;
		var varQryString = appURL+"action/facilityrenewlisthelp.jsp?hidBeanId=facilities&hidBeanGetMethod=getRenewedFacility&hidrenewFac="+hidrenewFac+"&hidapplicantoldid="+strAppid+"&com_newid="+comapp_newid+"&appno="+appno;
		var title = "Facility_Renewal";
		var prop = "scrollbars=yes,width=700,height=430,status=yes";	
		prop = prop + ",left=50,top=50";		
		window.open(varQryString,title,prop);
	}
}

function AccSelect()
{
	var appno=document.forms[0].appno.value;
	if(document.forms[0].selfac_fitl_acc.value=="Y" && document.forms[0].facility_nature.value == "1")
	{
		var count = 0;
		for(var i=0;i<document.forms[0].sel_restr_acc.options.length;i++)
		{
			if(document.forms[0].sel_restr_acc.options[i].selected == true)
			{			
				count = count + 1;
			}	
			if(count > 1)
			{
				document.forms[0].sel_restr_acc.options[i].selected = false;
			}
		}
		document.all.ifrmexistinglimit.src=appURL+"action/ifrmexistinglimit.jsp?hidBeanGetMethod=getRepaymentTypeData&hidBeanId=setproducts&cbsAccNo="+document.forms[0].sel_restr_acc.value+"&strModType="+varstrSessionModuleType+"&type=E&Limit=M&appno="+appno;
	}
}

function AccSelect_Sub()
{
	var appno=document.forms[0].appno.value;
	if(document.forms[0].selsubfac_fitl_acc.value=="Y" && document.forms[0].facilitysub_nature.value == "1")
	{
		var count = 0;
		for(var i=0;i<document.forms[0].sel_restr_acc_sub.options.length;i++)
		{
			if(document.forms[0].sel_restr_acc_sub.options[i].selected == true)
			{			
				count = count + 1;
			}	
			if(count > 1)
			{
				document.forms[0].sel_restr_acc_sub.options[i].selected = false;
			}
		}
		document.all.ifrmexistinglimit.src=appURL+"action/ifrmexistinglimit.jsp?hidBeanGetMethod=getRepaymentTypeData&hidBeanId=setproducts&cbsAccNo="+document.forms[0].sel_restr_acc_sub.value+"&strModType="+varstrSessionModuleType+"&type=E&Limit=S&appno="+appno;
	}
}

function funacctsel()
{
	var varRestrFrom = document.forms[0].hid_str_rsAcc.value.split("@");
	for(var j=0;j<varRestrFrom.length;j++)
	{
		for(var i=0;i<document.forms[0].sel_restr_acc.options.length;i++)
		{
			if(document.forms[0].sel_restr_acc.options[i].value==varRestrFrom[j])
			{		
				document.forms[0].sel_restr_acc.options[i].selected=true;
				//For design issue in IE 8,9&10 by Guhan 
				//document.forms[0].sel_restr_acc.options[i].style.background="#C3C3C3";
				break;
			}		
		}
	}
}

function funacctselsub()
{
	var varRestrFrom = document.forms[0].hid_str_rsAcc_sub.value.split("@");

	for(var j=0;j<varRestrFrom.length;j++)
	{
		for(var i=0;i<document.forms[0].sel_restr_acc_sub.options.length;i++)
		{
			if(document.forms[0].sel_restr_acc_sub.options[i].value==varRestrFrom[j])
			{			
				document.forms[0].sel_restr_acc_sub.options[i].selected=true;

				//For design issue in IE 8,9&10 by Guhan
				//document.forms[0].sel_restr_acc_sub.options[i].style.background="#C3C3C3";
				break;
			}		
		}
	}
}

function funAccFromAlert(page,field)
{
	alert("The Selection of accounts is a one time process. Please ensure that the selected account is correct before saving the facility.");
}

function callLeaderBank()
{
	if(document.forms[0].sel_propbanktype.value == "C")
	{
		document.all.consort.style.display = "table-cell";
		document.all.leaderbank.style.display = "table-cell";
	}
	else
	{
		document.all.consort.style.display = "none";
		document.all.leaderbank.style.display = "none";
		document.forms[0].hid_Bankcode.value="";
		document.forms[0].txt_LeadBank.value="";
	}
	
	if(document.forms[0].factype.value=="sublimit")
	{
		if(document.forms[0].sel_sub_propbanktype.value == "C")
		{
			document.all.consort_sub.style.display = "table-cell";
			document.all.leaderbankSub.style.display = "table-cell";
		}
		else
		{
			document.all.consort_sub.style.display = "none";
			document.all.leaderbankSub.style.display = "none";
			document.forms[0].txt_sub_LeadBank.value="";
			document.forms[0].hid_sub_Bankcode.value="";
		}
	}
}

function changetypevalue()
{
	var factype=document.forms[0].factype.value;
	if(document.forms[0].selfac_fitl_acc.value=="Y" && document.forms[0].facility_nature.value == "1")
	{
		document.forms[0].sel_fac_desc.value="2";
	}
	else if(document.forms[0].selfac_fitl_acc.value=="Y" && document.forms[0].facility_nature.value == "2")
	{
		document.forms[0].sel_fac_desc.value="1";
	}
	else if(document.forms[0].selfac_restr_acc.value=="N" && document.forms[0].selfac_fitl_acc.value=="N")
	{
		document.forms[0].sel_fac_desc.value="1";
	}
	else
	{
		document.forms[0].sel_fac_desc.value="1";
	}

 	if((factype=="sublimit") && (document.forms[0].selsubfac_restr_acc.value=="Y" && document.forms[0].selsubfac_fitl_acc.value=="N"))
	{
		 document.forms[0].sel_subfac_desc.value="3";
	}
	else if(document.forms[0].selsubfac_restr_acc.value=="Y" && document.forms[0].selsubfac_fitl_acc.value=="Y")
	{
		document.forms[0].sel_subfac_desc.value="1";
	}
	else if(document.forms[0].selsubfac_restr_acc.value=="N" && document.forms[0].selsubfac_fitl_acc.value=="N")
	{
		document.forms[0].sel_subfac_desc.value="1";
	}
}

function doCancel()
{
	var subno=0;

	var factype = document.forms[0].factype.value;
	var hidAction = document.forms[0].hidAction.value;
	if(ConfirmMsg(102))
	{
		document.forms[0].hideditflag.value="no";
		 if(!isNaN(document.forms[0].selsubsno.value))
		{
			 subno = parseInt(document.forms[0].selsubsno.value);
		}
		if(!subno)
		{
			subno=0;
		}
		if((subno==0) && (factype="sublimit") && (hidAction =="update"))
		{
			document.forms[0].factype.value = "facility";
		}
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].hidBeanGetMethod.value="getFacilityData";
		document.forms[0].action=appUrl+"action/facilities.jsp";	
		document.forms[0].method="post";
		document.forms[0].submit();
	}
  }

function callDescHelp(varsubfacFlag)
{
	if(document.forms[0].sel_proposalvaluesin.value=="S")
	    {
	     alert("Select All Values are in");
	     document.forms[0].sel_proposalvaluesin.focus();	    
	     return;  
	    }
	   var apptype;

	    if(varsubfacFlag=="N")
	    {
	    	apptype="CFM";
	    }
	    else
	    {
	    	apptype="CFS";
	    }
	    
         strAppid=document.forms[0].hidcomappidnew.value;
         if(strAppid=="")
         {
        	 strAppid=document.forms[0].hidapplicantid.value;  
         }
        
	if(document.forms[0].cmdsave.disabled==false)
	{
			var appno=document.forms[0].appno.value;
			var varQryString = appURL+"action/facilitieslisthelp.jsp?hidBeanId=appeditlock&hidBeanGetMethod=getProductList&strFrom="+apptype+"&strModuleType="+varstrSessionModuleType+"&varStrAppid="+strAppid+"&appno="+appno;
			var title = "ProductsSearch";
			var prop = "scrollbars=no,width=700,height=430,status=yes";	
			prop = prop + ",left=50,top=50";		
			window.open(varQryString,title,prop);
		 
	}

}
function selectSublimit()
{
	if(document.forms[0].checkbox.checked==false)
	{
		alert("Check sublimit option");
		document.forms[0].subfacility_head.selectedIndex=0;
 		return;
	}
}
function doDeleteProposal()
{

	if(varsize!=0)
	{
		alert("Delete all the facilities from the proposal");
		return;
	}
	if(var_rating_pending == "Y")
	{
		alert("Proposal is pending in Kalypto. Cannot proceed for deletion.");
		return;
	}
	if(varQueryStatus=="No")
	{
		alert("Some queries are in pending state,\n Please close all the queries before proceeding proposal deletion");
		return;
	}
 if(document.forms[0].appno.value != "")
   {
	 if(ConfirmMsg(136))
		{
		document.forms[0].hidAction.value ="deleteapplication";
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].hidSourceUrl.value="/action/corppge.jsp";
		document.forms[0].hidBeanMethod.value="updateCompanyData";
		document.forms[0].hidBeanGetMethod.value="getFacilityData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
		}
	}
}
function doRemoveAccounts()
{
	var appno=document.forms[0].appno.value;
	var varQryString = appURL+"action/restr_remove_accts.jsp?appno="+appno;
	var title = "AccountsRemoval";
	var prop = "scrollbars=no,width=700,height=430,status=yes";	
	prop = prop + ",left=50,top=50";		
	window.open(varQryString,title,prop);
}
function showAckSearch()
{		
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varproposeal="",varcategory="";
		if(varstrSessionModuleType=="CORP")
		{
			
			varproposeal="C";
			varcategory="c";
		}
		else
		{
			
			varproposeal="A";
			varcategory="a";
		}
		var varQryString = appUrl+"action/searchAppinwradno.jsp?hidBeanId=inwardRegister&hidBeanGetMethod=getInwardnoSearchList&Category="+varcategory+"&proposal="+varproposaltype+"&CBSid="+varcbsid;
		var title = "Acknowledgement";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}	
}
function callDeviation()
{

	
	var title = "Upload";
	var prop = "scrollbars=yes,width=1050,height=600,top=25,left=180";
	var url=appURL+"action/perlimitofloanagricrop.jsp?hidBeanId=perlimitofloan&hidBeanGetMethod=getDeviationData&appno="+document.forms[0].appno.value;
	
	window.open(url,title,prop);

	
	//appno=document.forms[0].appno.value;
	//var varQryString = appURL+"action/perlimitofloanagricrop.jsp?hidBeanId=perlimitofloan&hidBeanGetMethod=getDeviationforagricorp&appno="+ appno;
	//var prop = "scrollbars=yes,width=1000,height=600, menubar=no";	
	//prop = prop + ",left=100,top=50";
	//window.open(varQryString,"ncgtc",prop);

//	document.forms[0].method="post";
//	document.forms[0].hidBeanGetMethod.value="getDeviationforagricorp";
//	document.forms[0].hidBeanId.value="perlimitofloan";
//	document.forms[0].action=appURL+"action/perlimitofloanagricrop.jsp";	
//	document.forms[0].submit();
	//var title 	= "Deviation";
	
	//appno=document.forms[0].appno.value;
	/*var appid=document.forms[0].hidapplicantid.value;
	var producttype=document.forms[0].prd_type.value;
	var purposeid=document.forms[0].hidpurpose.value;
	appno=document.forms[0].appno.value;
	//alert("producttype+++"+producttype+"+++purposeid++"+purposeid);
	if((producttype=='pH' || producttype=='pS') && (purposeid=='H'))
	{
	hidtxt_vehage=document.forms[0].txt_vehage.value;
	}
	else
	{
	hidtxt_vehage="";
	}*/
	//alert(appno);
	//var purl= appURL+"action/perlimitofloanagricrop.jsp&appno="+ appno;
	//var purl= appURL+"action/perlimitofloanagricrop.jsp";
	//var xpos = (screen.width - 900) / 2;
	//var ypos = (screen.height - 700) / 2;
	//var prop = 'scrollbars=yes,menubar=YES,width=900,height=550,status=yes';
	//prop = prop + ",left="+xpos+",top="+ypos;
	//window.open(purl,'Deviation',prop);
}

function chkactualMargin(flag)
{
	if(flag=="Y")
	{
		if(document.forms[0].sel_relaxedmargin.value!="" && document.forms[0].sel_definedmargin.value=="")
		{
			alert("Select Actual Margin");
			document.forms[0].sel_relaxedmargin.value="";
			return;
		}
	}
	else
	{
		if(document.forms[0].sel_relaxedmarginsub.value!="" && document.forms[0].sel_definedmarginsub.value=="")
		{
			alert("Select Actual Margin");
			document.forms[0].sel_relaxedmarginsub.value="";
			return;
		}
	}
}



function getFacDescription(val,varcode)
{
	document.all.ifrmdispdesc.src=appURL+"action/ifrmmasterval.jsp?hidBeanGetMethod=getStatMasterValues&hidBeanId=facilities&strMastID=180&strObjectName=sel_displaydesc&strFlag=Y&strVal="+val+"&strFacCode="+varcode;
}
function getSubFacDescription(val,varcode)
{
	document.all.ifrmsubdispdesc.src=appURL+"action/ifrmmasterval.jsp?hidBeanGetMethod=getStatMasterValues&hidBeanId=facilities&strMastID=180&strObjectName=sel_subdisplaydesc&strFlag=Y&strVal="+val+"&strFacCode="+varcode;
}
function enablemargin(flag)
{
	if(flag=="M")
	{
		if(document.forms[0].sel_margin.value=="Y")
		{
			document.all.idmargin1.style.display="table-row";
			
		}
		else
		{
			document.all.idmargin1.style.display="none";
			document.forms[0].sel_relaxedmargin.value="";
		}

		if(document.forms[0].facility_head_id_code.value=="5" && document.forms[0].facility_id_code.value=="97")
		{
			document.all.idmargin.style.display="table-row";
			document.all.idmargin1.style.display="table-row";
		}
		else
		{
			document.all.idmargin.style.display="none";
			document.all.idmargin1.style.display="none";
			document.forms[0].sel_margin.value="";
			document.forms[0].sel_relaxedmargin.value="";
			document.forms[0].sel_definedmargin.value="";
		}
	}
	else
	{
		if(document.forms[0].sel_marginsub.value=="Y")
		{
			document.all.idsubmargin1.style.display="table-row";
		}
		else
		{
			document.all.idsubmargin1.style.display="none";
			document.forms[0].sel_relaxedmarginsub.value="";
		}

		if(document.forms[0].facilitysub_head_id_code.value=="5" && document.forms[0].facilitysub_id_code.value=="97")
		{
			document.all.idsubmargin.style.display="table-row";
			document.all.idsubmargin1.style.display="table-row";
		}
		else
		{
			document.all.idsubmargin.style.display="none";
			document.all.idsubmargin1.style.display="none";
			document.forms[0].sel_marginsub.value="";
			document.forms[0].sel_relaxedmarginsub.value="";
			document.forms[0].sel_definedmarginsub.value="";
		}
	}
}

function ValidateOpearativeAcc(obj,objname)
{
	var varOperAcc=obj.value;
	if(varOperAcc.length!=16)
	{
		alert("Please Enter Valid Operative Account Number");
		obj.value="";
		return;
	}
	else if(varOperAcc!="")
	{
		if(document.forms[0].cmdsave.disabled==false)
		{
			document.forms[0].cmdsave.disabled=true;
			document.all.ifrmcheckduplicate.src = appURL+"action/ifrmcersaiIDcheckduplicate.jsp?hidBeanGetMethod=getcersaiIDCheckDuplicate&hidBeanId=securitymaster&strPage=Prop&strrowindexname="+objname+"&strAccNo="+obj.value;
		}
	}
}


function chkInsTenor(vartype,valflag)
{
	if(vartype=="M")
	{
			if(valflag=="T")
			{
				if(eval(document.forms[0].txt_premium_tenor.value)>eval(document.forms[0].txt_facmonths.value))
				{
					alert("Premium Tenor should not be more than Tenor");
					document.forms[0].txt_premium_tenor.value="";
					document.forms[0].txt_premium_tenor.focus();
					return;
				}
			}
			else
			{
				if(eval(document.forms[0].txt_premium_loan_amt.value)>eval(document.forms[0].txt_proposed_limit.value))
				{
					alert("Loan amount covered under the scheme should not more than facility proposed Amount");
					document.forms[0].txt_premium_loan_amt.value="";
					document.forms[0].txt_premium_loan_amt.focus();
					return;
				}
			}
	}
	else
	{
		if(valflag=="T")
		{
			if(eval(document.forms[0].txt_premium_tenor_sub.value)>eval(document.forms[0].txt_subfacmonths.value))
			{
				alert("Premium Tenor should not be more than Tenor");
				document.forms[0].txt_premium_tenor_sub.value="";
				document.forms[0].txt_premium_tenor_sub.focus();
				return;
			}
		}
		else
		{
			if(eval(document.forms[0].txt_premium_loan_amt_sub.value)>eval(document.forms[0].txt_subproposed_limit.value))
			{
				alert("Loan amount covered under the scheme should not more than facility proposed Amount");
				document.forms[0].txt_premium_loan_amt_sub.value="";
				document.forms[0].txt_premium_loan_amt_sub.focus();
				return;
			}
		}
	}
}

function processedType(Eflag,Eflag1){
	 /*Main limit */
		if(Eflag=="facility"){ 
			if(document.forms[0].sel_Processed_Type.value=="NC"||document.forms[0].sel_Processed_Type.value=="")
			{
				document.all.id_premium_Account_no1.style.display="none";
				document.all.id_premium_tenor.style.display="none";
				document.forms[0].txt_premium_tenor.value="";
				document.forms[0].txt_premium_loan_amt.value="";
				document.forms[0].txt_premium_Account_no.value="";
				document.forms[0].sel_Funded_Comp_Name.value="";
				document.forms[0].txt_metlifeinsurance.value="0";
				document.forms[0].txt_metlifeinsurance.readOnly=true;
			}
			else if(document.forms[0].sel_Processed_Type.value=="SF")
			{
				document.all.id_premium_Account_no1.style.display="table-row";
				document.all.id_premium_tenor.style.display="table-row";
				if(Eflag1=="Y")
				{
					document.forms[0].txt_metlifeinsurance.readOnly=false;
				}
			}
			else
			{
				document.all.id_premium_tenor.style.display="table-row";
				document.all.id_premium_Account_no1.style.display="none";
				document.forms[0].txt_premium_Account_no.value="";
				document.forms[0].sel_Funded_Comp_Name.value="";
				if(Eflag1=="Y")
				{
					document.forms[0].txt_metlifeinsurance.readOnly=false;
				}
			}
		
		}
			
	    /*  sub limit */
	    else if(Eflag=="sub")
	    {
	    	if(document.forms[0].sel_Processed_Type_sub.value=="NC"||document.forms[0].sel_Processed_Type.value=="")
			{
				document.all.id_premium_tenor_sub.style.display="none";
				document.all.id_premium_Account_no1_sub.style.display="none";
				document.forms[0].txt_premium_tenor_sub.value="";
				document.forms[0].txt_premium_loan_amt_sub.value="";
				document.forms[0].txt_premium_Account_no_sub.value="";
				document.forms[0].sel_Funded_Sub_Comp_Name.value="";
				document.forms[0].txt_submetlifeinsurance.value="0";
				document.forms[0].txt_submetlifeinsurance.readOnly=true;
			}
			else if(document.forms[0].sel_Processed_Type_sub.value=="SF")
			{
				document.all.id_premium_Account_no1_sub.style.display="table-row";
				document.all.id_premium_tenor_sub.style.display="table-row";
				if(Eflag1=="Y")
				{
					document.forms[0].txt_submetlifeinsurance.readOnly=false;
				}
			}
			else
			{
				document.all.id_premium_tenor_sub.style.display="table-row";
				document.all.id_premium_Account_no1_sub.style.display="none";
				document.forms[0].txt_premium_Account_no.value="";
				document.forms[0].sel_Funded_Comp_Name.value="";
				if(Eflag1=="Y")
				{
					document.forms[0].txt_submetlifeinsurance.readOnly=false;
				}
			}

	    }
	}


function loadROIFields(vartype)
{
	if(vartype=="facility")
	{
		if(parseInt(document.forms[0].sel_interesttype.length)>2)
		{
			document.all.idint1.style.display="table-row";
		}
		else
		{
			document.all.idint1.style.display="none";
		}
	}
	else
	{
		if(parseInt(document.forms[0].sel_sub_interesttype.length)>2)
		{
			document.all.idint2.style.display="table-row";
		}
		else
		{
			document.all.idint2.style.display="none";
		}
	}
}

function loadInterestType(varfactype,varInterestType,varprdcode)
{
	if(varfactype=="facility")
	{
		if(document.forms[0].sel_inttype.value=="Flo")
		{
			document.all.ifrminterest.src=appURL+"action/iframeinteresttype.jsp?hidBeanGetMethod=getInterestType&hidBeanId=facilities&strPrdcode="+varprdcode+"&strIntType="+varInterestType+"&strFacType="+varfactype+"&strModType="+varstrSessionModuleType;
		}
		else
		{
			document.all.idint1.style.display="none";
			document.forms[0].sel_interesttype.length =1;
			document.forms[0].sel_interesttype.options[0].text="<----select---->";
			document.forms[0].sel_interesttype.options[0].value="";
		}
	}
	else
	{
		if(document.forms[0].sel_sub_inttype.value=="Flo")
		{
			document.all.ifrminterest.src=appURL+"action/iframeinteresttype.jsp?hidBeanGetMethod=getInterestType&hidBeanId=facilities&strPrdcode="+varprdcode+"&strIntType="+varInterestType+"&strFacType="+varfactype+"&strModType="+varstrSessionModuleType;
		}
		else
		{
			document.all.idint2.style.display="none";
			document.forms[0].sel_sub_interesttype.length =1;
			document.forms[0].sel_sub_interesttype.options[0].text="<----select---->";
			document.forms[0].sel_sub_interesttype.options[0].value="";
		}
	}
}


function selOperative(flag)
{
	if(flag=="facility"){
	var val=document.forms[0].selmodepayment.value;
	if(val=="E")
	{
		document.forms[0].txt_operativeaccno.disabled=false;
		document.all.opnolabel.style.visibility="visible";
		document.all.opnolabel.style.position="relative";
		
		document.all.opnovalue.style.visibility="visible";
		document.all.opnovalue.style.position="relative";

		document.forms[0].sel_ECSBankName.disabled=true;
		document.forms[0].sel_ECSaccnttype.disabled=true;
		document.forms[0].txt_ECSoperaccno.disabled=true;
		document.forms[0].sel_ECSauthmode.disabled=true;
		document.forms[0].txt_ECSifsccode.disabled=true;
		
		document.all.ECSopnolabel1.style.visibility="hidden";
		document.all.ECSopnolabel1.style.position="absolute";
		
		document.all.ECSopnovalue1.style.visibility="hidden";
		document.all.ECSopnovalue1.style.position="absolute";
		
		document.all.ECSopnolabel2.style.visibility="hidden";
		document.all.ECSopnolabel2.style.position="absolute";
		
		document.all.ECSopnovalue2.style.visibility="hidden";
		document.all.ECSopnovalue2.style.position="absolute";
		
		document.all.ECSopnolabel3.style.visibility="hidden";
		document.all.ECSopnolabel3.style.position="absolute";
		
		document.all.ECSopnovalue3.style.visibility="hidden";
		document.all.ECSopnovalue3.style.position="absolute";
		
		document.all.ECSopnolabel4.style.visibility="hidden";
		document.all.ECSopnolabel4.style.position="absolute";
		
		document.all.ECSopnovalue4.style.visibility="hidden";
		document.all.ECSopnovalue4.style.position="absolute";
		
		document.all.ECSopnolabel5.style.visibility="hidden";
		document.all.ECSopnolabel5.style.position="absolute";
		
		document.all.ECSopnovalue5.style.visibility="hidden";
		document.all.ECSopnovalue5.style.position="absolute";
	}
	else if(val=="C")
	{
		document.forms[0].sel_ECSBankName.disabled=false;
		document.forms[0].sel_ECSaccnttype.disabled=false;
		document.forms[0].txt_ECSoperaccno.disabled=false;
		document.forms[0].sel_ECSauthmode.disabled=false;
		document.forms[0].txt_ECSifsccode.disabled=false;
		
		document.all.ECSopnolabel1.style.visibility="visible";
		document.all.ECSopnolabel1.style.position="relative";
		
		document.all.ECSopnovalue1.style.visibility="visible";
		document.all.ECSopnovalue1.style.position="relative";
		
		document.all.ECSopnolabel2.style.visibility="visible";
		document.all.ECSopnolabel2.style.position="relative";
		
		document.all.ECSopnovalue2.style.visibility="visible";
		document.all.ECSopnovalue2.style.position="relative";
		
		document.all.ECSopnolabel3.style.visibility="visible";
		document.all.ECSopnolabel3.style.position="relative";
		
		document.all.ECSopnovalue3.style.visibility="visible";
		document.all.ECSopnovalue3.style.position="relative";
		
		document.all.ECSopnolabel4.style.visibility="visible";
		document.all.ECSopnolabel4.style.position="relative";
		
		document.all.ECSopnovalue4.style.visibility="visible";
		document.all.ECSopnovalue4.style.position="relative";
		
		document.all.ECSopnolabel5.style.visibility="visible";
		document.all.ECSopnolabel5.style.position="relative";
		
		document.all.ECSopnovalue5.style.visibility="visible";
		document.all.ECSopnovalue5.style.position="relative";
		
		document.forms[0].txt_operativeaccno.disabled=true;
		document.all.opnolabel.style.visibility="hidden";
		document.all.opnolabel.style.position="absolute";
		
		document.all.opnovalue.style.visibility="hidden";
		document.all.opnovalue.style.position="absolute";
	}
	else
	{
		document.forms[0].txt_operativeaccno.disabled=true;
		document.forms[0].txt_operativeaccno.value="";
		document.all.opnolabel.style.visibility="hidden";
		document.all.opnolabel.style.position="absolute";
		
		document.all.opnovalue.style.visibility="hidden";
		document.all.opnovalue.style.position="absolute";
		
	document.forms[0].txt_operativeaccno.disabled=true;
	//document.forms[0].txt_operativeaccno.value="";
	document.all.opnolabel.style.visibility="hidden";
	document.all.opnolabel.style.position="absolute";
	
	document.all.opnovalue.style.visibility="hidden";
	document.all.opnovalue.style.position="absolute";
	
	document.forms[0].sel_ECSBankName.disabled=true;
	document.forms[0].sel_ECSaccnttype.disabled=true;
	document.forms[0].txt_ECSoperaccno.disabled=true;
	document.forms[0].sel_ECSauthmode.disabled=true;
	document.forms[0].txt_ECSifsccode.disabled=true;
	
	document.forms[0].sel_ECSBankName.value="";
	document.forms[0].sel_ECSaccnttype.value="";
	document.forms[0].txt_ECSoperaccno.value="";
	document.forms[0].sel_ECSauthmode.value="";
	document.forms[0].txt_ECSifsccode.value="";
	
	document.all.ECSopnolabel1.style.visibility="hidden";
	document.all.ECSopnolabel1.style.position="absolute";
	
	document.all.ECSopnovalue1.style.visibility="hidden";
	document.all.ECSopnovalue1.style.position="absolute";
	
	document.all.ECSopnolabel2.style.visibility="hidden";
	document.all.ECSopnolabel2.style.position="absolute";
	
	document.all.ECSopnovalue2.style.visibility="hidden";
	document.all.ECSopnovalue2.style.position="absolute";
	
	document.all.ECSopnolabel3.style.visibility="hidden";
	document.all.ECSopnolabel3.style.position="absolute";
	
	document.all.ECSopnovalue3.style.visibility="hidden";
	document.all.ECSopnovalue3.style.position="absolute";
	
	document.all.ECSopnolabel4.style.visibility="hidden";
	document.all.ECSopnolabel4.style.position="absolute";
	
	document.all.ECSopnovalue4.style.visibility="hidden";
	document.all.ECSopnovalue4.style.position="absolute";
	
	document.all.ECSopnolabel5.style.visibility="hidden";
	document.all.ECSopnolabel5.style.position="absolute";
	
	document.all.ECSopnovalue5.style.visibility="hidden";
	document.all.ECSopnovalue5.style.position="absolute";
	}
}
	else if(flag=="sub"){
		var val=document.forms[0].selmodepayment_sub.value;
		if(val=="E")
		{
			document.forms[0].txt_operativeaccno_sub.disabled=false;
			document.all.opnolabel_sub.style.visibility="visible";
			document.all.opnolabel_sub.style.position="relative";
			
			document.all.opnovalue_sub.style.visibility="visible";
			document.all.opnovalue_sub.style.position="relative";
		}
		else
		{
			document.forms[0].txt_operativeaccno_sub.disabled=true;
			document.forms[0].txt_operativeaccno_sub.value="";
			document.all.opnolabel_sub.style.visibility="hidden";
			document.all.opnolabel_sub.style.position="absolute";
			
			document.all.opnovalue_sub.style.visibility="hidden";
			document.all.opnovalue_sub.style.position="absolute";
		}
		
}
}
function validateAccno(val)
{
if(val=="facility"){
	if(document.forms[0].selmodepayment.value=="E" && document.forms[0].txt_operativeaccno.value=="")
	{
		alert("Enter the Operative Account Number");
		document.forms[0].txt_operativeaccno.focus();
		return;	
	}
}
else if(val=="sub"){
	if(document.forms[0].selmodepayment_sub.value=="E" && document.forms[0].txt_operativeaccno_sub.value=="")
	{
		alert("Enter the Operative Account Number");
		document.forms[0].txt_operativeaccno_sub.focus();
		return;
	}
}
}
		
		
		function cgtmsesub()
		{
			if(document.forms[0].cgtmse_appsub.value=="Y")
			{
				if(document.forms[0].hidAppCGStatus.value!="Y")
				{
					alert("Customer Constitution is not eligible to be covered under CGTMSE");
					document.forms[0].cgtmse_appsub.value="";
					return false;
				}
			}
			
		}

		function cgtmsefld()
		{
		    /*document.all.cg3.style.visibility="hidden";	
			document.all.cg3.style.position="absolute";	

		    document.all.subcg3.style.visibility="hidden";	
			document.all.subcg3.style.position="absolute";	*/
			
		}
		
		function checkduedate(flag,obj)
		{
			var varflag1;
			if(varAppType=="P")
			{
				var varpsmodifiedTerms; 
				if(flag=="Y")
			    {
					varpsmodifiedTerms = document.forms[0].hidPStermsSelected.value.split("@");
			    }
				else
				{
					varpsmodifiedTerms = document.forms[0].hidSubPStermsSelected.value.split("@");
				}
				for(var i=0;i<varpsmodifiedTerms.length;i++)
				{
				  	if(varpsmodifiedTerms[i]=="DATEEX")
				  	{
				  		varflag1=checkmindate(obj,currentDate);
				  	}	
				  	if(flag=="N")
			  		{
				  		if(document.forms[0].txt_duedate.value!=""){
				  		varflag1=checkmaxdate(obj,document.forms[0].txt_duedate.value);
				  		}
			  		}
				}

				if(varflag1==false)
				{
					return false;
				}
				return true;
			}
			else
			{
				varflag1=checkmindate(obj,currentDate);
				
				if(varflag1==false)
				{
					return false;
				}

				if(flag=="N")
		  		{
					varflag1=checkmaxdate(obj,document.forms[0].txt_duedate.value);
		  		}

				if(varflag1==false)
				{
					return false;
				}
		  		
				var x;
				if(flag=="Y")
			    {
					x = document.forms[0].txt_facmonths.value;
			    }
				else
				{
					x = document.forms[0].txt_subfacmonths.value;
				}
				var d = new Date(currentDate.substring(6,currentDate.length), currentDate.substring(3,5), currentDate.substring(0,2)); // January 1, 2000
				d.setMonth(d.getMonth()-1 + parseInt(x));
				
				var varMon=parseInt(d.getMonth())+1;
				var vardate=d.getDate()+"/"+varMon+"/"+d.getFullYear();
				var day = "";
				var mon = "";
				var year = "";
				
				day = vardate.substring(0,2);
				if(day.substring(1,2) == "/")
				{
					day = "0"+day.substring(0,1);
					mon = vardate.substring(2,4);
					
					if(mon.substring(1,2) == "/")
					{	mon = "0"+mon;
						vardate = day+"/"+mon+vardate.substring(vardate.length-4,vardate.length);
					}
					else
					{
						vardate = day+"/"+mon+"/"+vardate.substring(vardate.length-4,vardate.length);
					}			
				}
				else 
				{
					mon = vardate.substring(3,5);			
					if(mon.substring(1,2) == "/")
					{
						mon = "0"+mon;
						vardate = day+"/"+mon+vardate.substring(vardate.length-4,vardate.length);
					}
					else
					{
						vardate = day+"/"+mon+"/"+vardate.substring(vardate.length-4,vardate.length);
					}			
				}

				
				varflag1=checkmonthEnd(obj,vardate);

				if(varflag1==false)
				{
					return false;
				}

				if(flag=="Y")
				{
					if(document.forms[0].facility_head_id_code.value=="5" && document.forms[0].facility_id_code.value=="98")
					{
						varflag1=checkmaxdate(obj,"31/03/2021");
						if(varflag1==false)
						{
							return false;
						}
					}
				}
				else
				{
					if(document.forms[0].facilitysub_head_id_code.value=="5" && document.forms[0].facilitysub_id_code.value=="98")
					{
						varflag1=checkmaxdate(obj,"31/03/2021");
						if(varflag1==false)
						{
							return false;
						}
					}
				}

				return true;
				

			}
			
		}

		function checkListDOC()
		{
			var title 	= "Check List Document";
			var url=appURL+"action/com_CheckListDOC.jsp?hidBeanId=facilities&hidBeanGetMethod=getCheckListValue&appno="+document.forms[0].appno.value;
			var prop 	= "scrollbars=yes,width=1000,height=600,menubar=yes";
			window.open(url,"title",prop);
			
		}
		function doFinancialData()
		{
			  var url=appUrl+"action/retailfin.jsp?hidBeanId=financial&hidBeanGetMethod=getRetailData&appno="+document.forms[0].appno.value;	  
			  var title = "FinancialData";
			  var prop = "scrollbars=yes,width=900,height=650,menubar=yes";
			  prop = prop + ",left=50,top=150";
			  window.open(url,title,prop);
		}

		function facilityArrangement(){

			var title 	= "Facility Arrangement";
			var url=appURL+"action/facilitiesArrangement.jsp?hidBeanId=facilities&hidBeanGetMethod=getFacilityArrangement&appno="+document.forms[0].appno.value;
			var prop 	= "scrollbars=yes,width=900,height=450,menubar=yes";
			window.open(url,"title",prop);
		}

		function cggstcal()
		{	
			/*var varcgper = parseFloat(document.forms[0].sel_cg_fee.value);
			var varmodintrate = parseFloat(document.forms[0].prd_intrate.value);
			if(varmodintrate=="" || isNaN(varmodintrate))
			{
				varmodintrate = parseFloat("0.00"); 
			}
			//document.forms[0].txt_cg_int_rate.value=(varcgper+varmodintrate).toFixed(2);	 */
		}


		function cggstcalsub()
		{	
			//var varcgper = parseFloat(document.forms[0].sel_cg_feesub.value);
			var varmodintrate = parseFloat(document.forms[0].prd_subintrate.value);
			if(varmodintrate=="" || isNaN(varmodintrate))
			{
				varmodintrate=parseFloat("0.00");
			}
//			document.forms[0].txt_cg_int_ratesub.value=varmodintrate;
			//document.forms[0].txt_cg_int_ratesub.value=varcgper+varmodintrate;
		}

		function checkcgtmse() 
		{
			//if(document.forms[0].txt_cgtmse.value!='')
			{
				 document.all.cg1.style.visibility="visible";
				 document.all.cg1.style.position="relative";	
			}
			//if(document.forms[0].txt_cgtmsesub.value!='')
			{
				 document.all.subcg1.style.visibility="visible";
				 document.all.subcg1.style.position="relative";	
			}
		}

		function cgtmse()
		{
			if(document.forms[0].cgtmse_app.value=="Y")
			{
				if(document.forms[0].hidAppCGStatus.value!="Y")
				{
					alert("Customer Constitution is not eligible to be covered under CGTMSE");
					document.forms[0].cgtmse_app.value="";
					return false;
				}
			}
			/*if(document.forms[0].cgtmse_app.value=="Y")
			{
			    document.all.cg3.style.visibility="visible";
			    document.all.cg3.style.position="relative";
			}
			else
			{
				/*document.all.cg3.style.visibility="hidden";	
		        document.all.cg3.style.position="absolute";
				document.forms[0].txt_cg_int_rate.value="";
				document.forms[0].sel_cg_fee.value="0";
			}*/
			if(document.forms[0].cgtmse_app.value=="Y" && document.forms[0].sel_facilityrequired.value=="N")
			{
				document.getElementById("cgtmse_financial").style.visibility="visible";
				document.getElementById("cgtmse_financial").style.position="relative";
			}
			else
			{
				document.getElementById("cgtmse_financial").style.visibility="hidden";
				document.getElementById("cgtmse_financial").style.position="absolute";
			}
		}

		function checkExportCredit(type)
		{
			if(type=="0")
			{
				if((document.forms[0].facility_head_id_code.value=="2") || (document.forms[0].facility_head_id_code.value=="7" && document.forms[0].facility_id_code.value=="31")|| (document.forms[0].facility_head_id_code.value=="7" && document.forms[0].facility_id_code.value=="93"))
				{
					if(document.forms[0].sel_intsutype.value!="MCLEC" && document.forms[0].sel_intsutype.value!="EBLEC")
					{
						alert("Option not applicable");
						document.forms[0].sel_intsutype.value="0";
						return;
					}
				}
				else
				{
					if(document.forms[0].sel_intsutype.value=="MCLEC" || document.forms[0].sel_intsutype.value=="EBLEC" )
					{
						alert("Option not applicable");
						document.forms[0].sel_intsutype.value="0";
						return;
					}
				}

				if(document.forms[0].sel_inttype.value=="Fix")
				{
					if(document.forms[0].sel_intsutype.value=="BR" || document.forms[0].sel_intsutype.value=="MCLR"|| document.forms[0].sel_intsutype.value=="BRLEC"
						|| document.forms[0].sel_intsutype.value=="MCLEC"|| document.forms[0].sel_intsutype.value=="EBLEC"|| document.forms[0].sel_intsutype.value=="SMTB"
							|| document.forms[0].sel_intsutype.value=="TYGS" )
					{
						alert("Option not applicable");
						document.forms[0].sel_intsutype.value="0";
						return;
					}
				}
			}
			else if(type=="1")
			{
				if((document.forms[0].facilitysub_head_id_code.value=="2") || (document.forms[0].facilitysub_head_id_code.value=="7" && document.forms[0].facilitysub_id_code.value=="31")|| (document.forms[0].facilitysub_head_id_code.value=="7" && document.forms[0].facilitysub_id_code.value=="93"))
				{
					if(document.forms[0].sel_intsufacsubtype.value!="MCLEC" && document.forms[0].sel_intsufacsubtype.value!="EBLEC")
					{
						alert("Option not applicable");
						document.forms[0].sel_intsufacsubtype.value="0";
						return;
					}
				}
				else
				{
					if(document.forms[0].sel_intsufacsubtype.value=="MCLEC" || document.forms[0].sel_intsufacsubtype.value=="EBLEC")
					{
						alert("Option not applicable");
						document.forms[0].sel_intsufacsubtype.value="0";
						return;
					}
				}

				if(document.forms[0].sel_sub_inttype.value=="Fix")
				{
					if(document.forms[0].sel_intsufacsubtype.value=="BR" || document.forms[0].sel_intsufacsubtype.value=="MCLR"|| document.forms[0].sel_intsufacsubtype.value=="BRLEC"
						|| document.forms[0].sel_intsufacsubtype.value=="MCLEC"|| document.forms[0].sel_intsufacsubtype.value=="EBLEC"|| document.forms[0].sel_intsufacsubtype.value=="SMTB"
							|| document.forms[0].sel_intsufacsubtype.value=="TYGS" )
					{
						alert("Option not applicable");
						document.forms[0].sel_intsufacsubtype.value="0";
						return;
					}
				}
			}
		}
		
		function chkfacilityMCLR(type)
		{
			
			if(type=="0")
			{
				if(parseInt(vardatediff)>=0)
				{
					if(document.forms[0].sel_inttype.value=="Flo"){
						if(document.forms[0].sel_intsutype.value=="BR" ||document.forms[0].sel_intsutype.value=="BRLEC"){
							alert("Option not applicable");
							document.forms[0].sel_intsutype.value="0";
							return;
						}
				    }
				}
			}
			else if(type=="1")
			{
				if(parseInt(vardatediff)>=0)
				{
					   if(document.forms[0].sel_inttype.value=="Flo"){
						if(document.forms[0].sel_intsutype.value=="BR" ||document.forms[0].sel_intsutype.value=="BRLEC" ){
							alert("Option not applicable");
							document.forms[0].sel_intsutype.value="0";
							return;
						}
				       }
			    }
			}

			if(varAppType=="P")
			{
				var varpsmodifiedTerms; 
				if(type=="0")
			    {
					varpsmodifiedTerms = document.forms[0].hidPStermsSelected.value.split("@");
			    }
				else if(type=="1")
				{
					varpsmodifiedTerms = document.forms[0].hidSubPStermsSelected.value.split("@");
				}
				for(var i=0;i<varpsmodifiedTerms.length;i++)
				{
				  	if(varpsmodifiedTerms[i]=="BRTOMCLR")
				  	{
				  		if(type=="0")
					    {
				  			if((document.forms[0].facility_head_id_code.value=="2") || (document.forms[0].facility_head_id_code.value=="7" && document.forms[0].facility_id_code.value=="31")|| (document.forms[0].facility_head_id_code.value=="7" && document.forms[0].facility_id_code.value=="93"))
				  			{
				  				if(document.forms[0].sel_intsutype.value!="MCLEC" && document.forms[0].sel_intsutype.value!="EBLEC")
				  				{
				  					alert("Option not applicable");
				  					document.forms[0].sel_intsutype.value="0";
				  					return;
				  				}
				  			}
				  			else
				  			{
							if(document.forms[0].sel_intsutype.value!="MCLR" && document.forms[0].sel_intsutype.value!="MCLEC"&& document.forms[0].sel_intsutype.value!="SMTB"&& document.forms[0].sel_intsutype.value!="TYGS")
							{
								alert("Interest Sub type should be MCLR / MCLR Linked Export Limit/6 MONTHS TREASURY BILL/10 Years Govt Security");
								document.forms[0].sel_intsutype.value="0";
								document.forms[0].sel_intsutype.focus();
								return;
							}
					    }
					    }
						else if(type=="1")
						{
							if((document.forms[0].facilitysub_head_id_code.value=="2") || (document.forms[0].facilitysub_head_id_code.value=="7" && document.forms[0].facilitysub_id_code.value=="31")|| (document.forms[0].facilitysub_head_id_code.value=="7" && document.forms[0].facilitysub_id_code.value=="93"))
							{
								if(document.forms[0].sel_intsufacsubtype.value!="MCLEC" && document.forms[0].sel_intsufacsubtype.value!="EBLEC")
								{
									alert("Option not applicable");
									document.forms[0].sel_intsufacsubtype.value="0";
									return;
								}
							}
							else
							{
							if(document.forms[0].sel_intsufacsubtype.value!="MCLR" && document.forms[0].sel_intsufacsubtype.value!="MCLEC"&& document.forms[0].sel_intsufacsubtype.value!="SMTB"&& document.forms[0].sel_intsufacsubtype.value!="TYGS")
							{
								alert("Interest Sub type should be MCLR / MCLR Linked Export Limit");
								document.forms[0].sel_intsufacsubtype.value="0";
								document.forms[0].sel_intsufacsubtype.focus();
								return;
							}
						}
			  		}
				}
			}
			}
		}


		function changeCEFAFsub()
		{
			if(document.forms[0].selsubfac_restr_acc.value=="Y" && document.forms[0].selsubfac_fitl_acc.value=="Y" && document.forms[0].facilitysub_nature.value == "1")
			{
				document.forms[0].sel_restr_conversionfac_sub.value="N";
				document.forms[0].sel_restr_addfunding_sub.value="N";
				document.forms[0].sel_restr_conversionfac_sub.disabled=true;
				document.forms[0].sel_restr_addfunding_sub.disabled=true;
				document.all.id_restracc_sub.style.display="table-cell";
				document.all.id_restracc_sub1.style.display="table-cell";
				document.forms[0].sel_subfac_desc.value="2";
			}
			else if(document.forms[0].selsubfac_restr_acc.value=="Y" && document.forms[0].selsubfac_fitl_acc.value=="Y" && document.forms[0].facilitysub_nature.value == "2")
			{
				document.forms[0].sel_restr_conversionfac_sub.value="N";
				document.forms[0].sel_restr_addfunding_sub.value="Y";
				document.forms[0].sel_restr_conversionfac_sub.disabled=true;
				document.forms[0].sel_restr_addfunding_sub.disabled=true;
				document.all.id_restracc_sub.style.display="table-cell";
				document.all.id_restracc_sub1.style.display="table-cell";
				document.forms[0].sel_subfac_desc.value="1";
			}
			else if(document.forms[0].selsubfac_restr_acc.value=="Y" && document.forms[0].selsubfac_fitl_acc.value=="N")
			{
				document.forms[0].sel_restr_conversionfac_sub.disabled=false;
				document.forms[0].sel_restr_addfunding_sub.disabled=false;
				document.all.id_restracc_sub.style.display="none";
				document.all.id_restracc_sub1.style.display="none";
			}
			else if(document.forms[0].selsubfac_restr_acc.value=="N" && document.forms[0].selsubfac_fitl_acc.value=="Y" && document.forms[0].facilitysub_nature.value == "1")
			{
				document.all.id_restracc_sub.style.display="table-cell";
				document.all.id_restracc_sub1.style.display="table-cell";
				document.forms[0].sel_subfac_desc.value="2";
			}
			else
			{
				document.all.id_restracc_sub.style.display="none";
				document.all.id_restracc_sub1.style.display="none";
				document.forms[0].sel_subfac_desc.value="1";
			}

			if(document.forms[0].sel_restr_conversionfac_sub.value=="NA" && document.forms[0].selsubfac_restr_acc.value=="Y" && document.forms[0].selsubfac_fitl_acc.value=="N")
			{
				document.forms[0].sel_restr_addfunding_sub.value="NA";
				document.forms[0].sel_subfac_desc.value="3";
				document.all.id_restracc_sub.style.display="table-cell";
				document.all.id_restracc_sub1.style.display="table-cell";
				document.forms[0].sel_restr_addfunding_sub.disabled=true;
			}
			else if(document.forms[0].sel_restr_conversionfac_sub.value=="Y" && document.forms[0].selsubfac_restr_acc.value=="Y" && document.forms[0].selsubfac_fitl_acc.value=="N")
			{
				document.forms[0].sel_restr_addfunding_sub.value="N";
				document.forms[0].sel_restr_addfunding_sub.disabled=true;
				document.all.id_restracc_sub.style.display="table-cell";
				document.all.id_restracc_sub1.style.display="table-cell";
				document.forms[0].sel_subfac_desc.value="1";
			}
			else if(document.forms[0].sel_restr_conversionfac_sub.value=="N" && document.forms[0].selsubfac_restr_acc.value=="Y" && document.forms[0].selsubfac_fitl_acc.value=="N")
			{
				document.forms[0].sel_restr_addfunding_sub.value="Y";
				document.forms[0].sel_restr_addfunding_sub.disabled=true;
				document.forms[0].sel_subfac_desc.value="1";
			}
		}

		function callrepayfunction(varstrSessionModuleType,varfacType,varfacid,varrepay)
		{
			document.all.ifrmrepayment.src=appURL+"action/iframerepaymenttype.jsp?hidBeanGetMethod=getRepaymentTypeData&hidBeanId=setproducts&strPrdcode="+varfacid+"&strRepayType="+varrepay+"&strModType="+varstrSessionModuleType+"&strFacType="+varfacType;
		}
		function selsubperiodicity()
		{
			if((document.forms[0].facilitysub_nature.value=="2"))
			{
				if(document.forms[0].sel_peridicityfacsub.value=="n")
				{
					alert("Periodicity of installment value should not be Not Applicable");
					document.forms[0].sel_peridicityfacsub.value="s";
					return;
				}
			}
		}
		function selperiodicity()
		{
			if((document.forms[0].facility_nature.value=="2"))
			{
				if(document.forms[0].sel_peridicityfac.value=="n")
				{
					alert("Periodicity of installment value should not be Not Applicable");
					document.forms[0].sel_peridicityfac.value="s";
					return;
				}
			}
		}
		function calladhoc(varchk)
		{
			var varsno=document.forms[0].selsno.value;
			var varsubsno=document.forms[0].selsubsno.value;
			var varheadid=document.forms[0].facility_head_id_code.value;
			var varsubheadid=document.forms[0].facility_id_code.value;
			if(document.forms[0].seladhoclimit.value=="A"||document.forms[0].seladhoclimit.value=="D")
			{
				if(varchk=="Y" && document.forms[0].txt_accountopenflag.value=="N" &&(document.forms[0].facility_head_id_code.value=="3"||document.forms[0].facility_head_id_code.value=="4"||document.forms[0].facility_head_id_code.value=="5"))
				{
					alert("Adhoc/Additional limit cannot be added for Overdraft/Term Loan/DPN Facilities");
					return;
				}
				if(varchk=="Y" && document.forms[0].hidAdhocchk.value=="Y")
				{
					alert("This Limit  is already a base for the following Limit ("+document.forms[0].hidAdhocsno.value+"-"+document.forms[0].hidadhocDesc.value+")");
					document.forms[0].seladhoclimit.value="R";
					return;
				}
				//if(varchk=="Y" && document.forms[0].hidGrpSize.value!="" && document.forms[0].hidGrpSize.value!="0")
				{
					//alert("This Limit contains sub limit,so you cannot change this to Adhoc Limit");
					//document.forms[0].seladhoclimit.value="R";
					//return;
				}
				if(varchk=="N" && document.forms[0].checkbox.checked==true)
				{
					varsno=document.forms[0].selsubsno.value;
					varsubsno="0";
				}

				document.all.idadhoc.style.display="table-cell";
				document.all.idadhoc1.style.display="table-cell";
				document.all.ifrmadhoclimit.src=appURL+"action/ifrmadhoclimit.jsp?hidBeanGetMethod=getLoadAdhocFacilities&hidBeanId=facilities&appid="+document.forms[0].comapp_id.value+"&apptype="+varstrSessionModuleType+"&facGroup=M&sno="+varsno+"&subsno="+varsubsno+"&appno="+document.forms[0].appno.value+"&strHeadId="+varheadid+"&strSubHeadId="+varsubheadid+"&strLimitType="+document.forms[0].seladhoclimit.value;
			}
			else if(document.forms[0].seladhoclimit.value=="R" && varchk=="Y")
			{
				document.all.ifrmadhoclimit.src=appURL+"action/ifrmadhoclimit.jsp?hidBeanGetMethod=getLoadAdhocFacilities&hidBeanId=facilities&appid="+document.forms[0].comapp_id.value+"&apptype="+varstrSessionModuleType+"&facGroup=M&sno="+varsno+"&subsno="+varsubsno+"&appno="+document.forms[0].appno.value+"&strHeadId="+varheadid+"&strSubHeadId="+varsubheadid+"&strLimitType="+document.forms[0].seladhoclimit.value;
			}
			else
			{
				document.forms[0].seladhocof.value="";
				document.all.idadhoc.style.display="none";
				document.all.idadhoc1.style.display="none";
			}
		}
		function callsubadhoc(varchk1)
		{
			var varheadid=document.forms[0].facilitysub_head_id_code.value;
			var varsubheadid=document.forms[0].facilitysub_id_code.value;

			if(document.forms[0].seladhoclimit.value=="O" && (document.forms[0].selsubadhoclimit.value=="A"||document.forms[0].selsubadhoclimit.value=="D"))
			{
				alert("You cannot add any Adhoc Limit/Additional facility for One Time Limit");
				document.forms[0].selsubadhoclimit.value="";
				return;
			}
			if(document.forms[0].selsubadhoclimit.value=="A"||document.forms[0].selsubadhoclimit.value=="D")
			{
				if(varchk1=="Y" && document.forms[0].txt_accountopenflagsub.value=="N" &&(document.forms[0].facilitysub_head_id_code.value=="3"||document.forms[0].facilitysub_head_id_code.value=="4"||document.forms[0].facilitysub_head_id_code.value=="5"))
				{
					alert("Adhoc/Additional limit cannot be added for Overdraft/Term Loan/DPN Facilities");
					return;
				}
				
				if(varchk1=="Y" && document.forms[0].hidAdhocchk.value=="Y")
				{
					alert("This Limit  is already a base for the following Limit ("+document.forms[0].hidAdhocsno.value+"-"+document.forms[0].hidadhocDesc.value+")");
					document.forms[0].selsubadhoclimit.value="R";
					return;
				}


				
				document.all.ifrmadhoclimitsub.src=appURL+"action/ifrmadhoclimitsub.jsp?hidBeanGetMethod=getLoadAdhocFacilities&hidBeanId=facilities&appid="+document.forms[0].hidapplicantid.value+"&apptype="+varstrSessionModuleType+"&facGroup=S&sno="+document.forms[0].selsno.value+"&subsno="+document.forms[0].selsubsno.value+"&appno="+document.forms[0].appno.value+"&strHeadId="+varheadid+"&strSubHeadId="+varsubheadid+"&strLimitType="+document.forms[0].selsubadhoclimit.value;
				document.all.idsubadhoc.style.display="table-cell";
				document.all.idsubadhoc1.style.display="table-cell";
			}
			else if(document.forms[0].selsubadhoclimit.value=="R" && varchk1=="Y")
			{
				document.all.ifrmadhoclimitsub.src=appURL+"action/ifrmadhoclimitsub.jsp?hidBeanGetMethod=getLoadAdhocFacilities&hidBeanId=facilities&appid="+document.forms[0].hidapplicantid.value+"&apptype="+varstrSessionModuleType+"&facGroup=S&sno="+document.forms[0].selsno.value+"&subsno="+document.forms[0].selsubsno.value+"&appno="+document.forms[0].appno.value+"&strHeadId="+varheadid+"&strSubHeadId="+varsubheadid+"&strLimitType="+document.forms[0].selsubadhoclimit.value;
				document.forms[0].selsubadhocof.value="";
				document.all.idsubadhoc.style.display="none";
				document.all.idsubadhoc1.style.display="none";
			}
			else
			{
				document.forms[0].selsubadhocof.value="";
				document.all.idsubadhoc.style.display="none";
				document.all.idsubadhoc1.style.display="none";
			}
		}


		function changeCEFAF()
		{
			if(document.forms[0].selfac_restr_acc.value=="Y" && document.forms[0].selfac_fitl_acc.value=="Y" && document.forms[0].facility_nature.value == "1")
			{
				document.forms[0].sel_restr_conversionfac.value="N";
				document.forms[0].sel_restr_addfunding.value="N";
				document.forms[0].sel_restr_conversionfac.disabled=true;
				document.forms[0].sel_restr_addfunding.disabled=true;
				document.all.id_restracc.style.display="table-cell";
				document.all.id_restracc1.style.display="table-cell";
				document.forms[0].sel_fac_desc.value="2";
			}
			else if(document.forms[0].selfac_restr_acc.value=="Y" && document.forms[0].selfac_fitl_acc.value=="Y" && document.forms[0].facility_nature.value == "2")
			{
				document.forms[0].sel_restr_conversionfac.value="N";
				document.forms[0].sel_restr_addfunding.value="Y";
				document.forms[0].sel_restr_conversionfac.disabled=true;
				document.forms[0].sel_restr_addfunding.disabled=true;
				document.all.id_restracc.style.display="table-cell";
				document.all.id_restracc1.style.display="table-cell";
				document.forms[0].sel_fac_desc.value="1";
			}
			else if(document.forms[0].selfac_restr_acc.value=="Y" && document.forms[0].selfac_fitl_acc.value=="N")
			{
				document.forms[0].sel_restr_conversionfac.disabled=false;
				document.forms[0].sel_restr_addfunding.disabled=false;
				document.all.id_restracc.style.display="none";
				document.all.id_restracc1.style.display="none";
			}
			else if(document.forms[0].selfac_restr_acc.value=="N" && document.forms[0].selfac_fitl_acc.value=="Y" && document.forms[0].facility_nature.value == "1")
			{
				document.all.id_restracc.style.display="table-cell";
				document.all.id_restracc1.style.display="table-cell";
				document.forms[0].sel_fac_desc.value="2";
			}
			else
			{
				document.all.id_restracc.style.display="none";
				document.all.id_restracc1.style.display="none";
				document.forms[0].sel_fac_desc.value="1";
			}

			if(document.forms[0].sel_restr_conversionfac.value=="NA" && document.forms[0].selfac_restr_acc.value=="Y" && document.forms[0].selfac_fitl_acc.value=="N")
			{
				document.forms[0].sel_restr_addfunding.value="NA";
				document.forms[0].sel_fac_desc.value="3";
				document.all.id_restracc.style.display="table-cell";
				document.all.id_restracc1.style.display="table-cell";
				document.forms[0].sel_restr_addfunding.disabled=true;
			}
			else if(document.forms[0].sel_restr_conversionfac.value=="Y" && document.forms[0].selfac_restr_acc.value=="Y" && document.forms[0].selfac_fitl_acc.value=="N")
			{
				document.forms[0].sel_restr_addfunding.value="N";
				document.forms[0].sel_restr_addfunding.disabled=true;
				document.all.id_restracc.style.display="table-cell";
				document.all.id_restracc1.style.display="table-cell";
				document.forms[0].sel_fac_desc.value="1";
			}
			else if(document.forms[0].sel_restr_conversionfac.value=="N" && document.forms[0].selfac_restr_acc.value=="Y" && document.forms[0].selfac_fitl_acc.value=="N")
			{
				document.forms[0].sel_restr_addfunding.value="Y";
				document.forms[0].sel_restr_addfunding.disabled=true;
				document.forms[0].sel_fac_desc.value="1";
			}
		}

		function clearValues(flag)
		{
		 if(flag=="N")
		 {
		  document.forms[0].txt_proposed_limit.value="";
		  document.forms[0].txt_facmonths.value="";  

		 }
		 else if(flag=="Y")
		 {
			 document.forms[0].txt_subproposed_limit.value="";
			  document.forms[0].txt_subfacmonths.value="";
		 }	
		}
		
		function getInterestSetupSub(flag1)
		{
			var varboolflag = false;
			if(varAppType=="P")
			{
				var varPSterms1 =document.forms[0].hidPStermsSelected.value.split("@");
				var varPStermssub =document.forms[0].hidSubPStermsSelected.value;
				for(var i=0;i<varPSterms1.length;i++)
				{
					if((varPSterms1[i] == "LAD" || varPSterms1[i] == "SUBLIMIT") && varPStermssub == "")
					{
						varboolflag=true;
					}
				}
				if(varboolflag)
				{
					//Calculate the interest
				}
				else
				{
					return;
				}
			}

			if(document.forms[0].sel_sub_inttype.value=="Flo" && varAppType!="P")
			{
				if(flag1=="Y")
				{
					document.forms[0].hidBaseRateFacSub.value="";
					document.forms[0].prd_subintrate.value="";
					loadInterestType('subfacility',document.forms[0].sel_sub_interesttype.value,document.forms[0].hidsubfacilityCode.value);
				}
				document.all.iddescsub.style.display="inline";
				return;
			}
			else
			{
				 document.all.iddescsub.style.display="none";
				 if(flag1=="Y")
				 {
					 loadInterestType('subfacility',document.forms[0].sel_sub_interesttype.value,document.forms[0].hidsubfacilityCode.value);
				 }
			}
			var varstrIntType=document.forms[0].sel_sub_inttype.value;
			var varstrProposedLimit=document.forms[0].txt_subproposed_limit.value;
			var varstrTenor=document.forms[0].txt_subfacmonths.value;
			var varvaluesIn=document.forms[0].sel_proposalvaluesin.value;
			var s1=document.forms[0].facilitydescsub.value;
			var s2=s1.split("-");
			var varFacCode=s2[0];
			if(varstrTenor!="" && varstrTenor!="0")
			{
			document.all.ifrmint.src=appUrl+"action/iframeinterestget.jsp?hidBeanId=facilities&hidBeanGetMethod=getFacilityInterest&strIntType="+varstrIntType+"&strProposedLimit="+varstrProposedLimit+"&strTenor="+varstrTenor+"&strFacCode="+varFacCode+"&strSubFlag=Y&strValuesIn="+varvaluesIn;
			}
			
		}
		
		function getInterestSetup(flag)
		{
			if(varAppType=="P")
			{
				return;
			}
			if(document.forms[0].sel_inttype.value=="Flo" && varAppType!="P")
			{
				if(flag=="Y")
				{
					document.forms[0].hidBaseRateFac.value="";
					document.forms[0].prd_intrate.value="";
					loadInterestType('facility',document.forms[0].sel_interesttype.value,document.forms[0].hidfacilityCode.value);
				}
				document.all.iddesc.style.display="inline";
				return;
			}
			else
			{
				 document.all.iddesc.style.display="none";
				 if(flag=="Y")
				 {
					 loadInterestType('facility',document.forms[0].sel_interesttype.value,document.forms[0].hidfacilityCode.value);
				 }
			}
			
			var varstrIntType=document.forms[0].sel_inttype.value;
			var varstrProposedLimit=document.forms[0].txt_proposed_limit.value;
			var varstrTenor=document.forms[0].txt_facmonths.value;
			var varvaluesIn=document.forms[0].sel_proposalvaluesin.value;
			var s1=document.forms[0].facilitydesc.value;
			var s2=s1.split("-");
			var varFacCode=s2[0];
			if(varstrTenor!="" && varstrTenor!="0")
			{
			document.all.ifrmint.src=appUrl+"action/iframeinterestget.jsp?hidBeanId=facilities&hidBeanGetMethod=getFacilityInterest&strIntType="+varstrIntType+"&strProposedLimit="+varstrProposedLimit+"&strTenor="+varstrTenor+"&strFacCode="+varFacCode+"&strSubFlag=N&strValuesIn="+varvaluesIn;
			}
			
		}




