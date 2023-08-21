/* function ShowOccupation()
{
	if(document.forms[0].select_Occupation.options.selectedIndex==1)
	{         
		document.forms[0].select_OccupationSub.length =6;
		document.forms[0].select_OccupationSub.options[0].text= "---- Select ----";
		document.forms[0].select_OccupationSub.options[0].value= "1_S";
		document.forms[0].select_OccupationSub.options[1].text= "Educational Institutions";
		document.forms[0].select_OccupationSub.options[1].value= "1_1";
		document.forms[0].select_OccupationSub.options[2].text= "Govt. Local Bodies";
		document.forms[0].select_OccupationSub.options[2].value= "1_2";
		document.forms[0].select_OccupationSub.options[3].text= "State Govt.";
		document.forms[0].select_OccupationSub.options[3].value= "1_3";
		document.forms[0].select_OccupationSub.options[4].text= "Central Govt.";
		document.forms[0].select_OccupationSub.options[4].value= "1_4";
		document.forms[0].select_OccupationSub.options[5].text= "Pvt. Companies";
		document.forms[0].select_OccupationSub.options[5].value= "1_5";
		document.forms[0].select_OccupationSub.options[6].text= "Others";
		document.forms[0].select_OccupationSub.options[6].value= "1_6";
	}
	if(document.forms[0].select_Occupation.options.selectedIndex==2)
	{        
		document.forms[0].select_OccupationSub.length =5;
		document.forms[0].select_OccupationSub.options[0].text= "---- Select ----";
		document.forms[0].select_OccupationSub.options[0].value= "2_S";
		document.forms[0].select_OccupationSub.options[1].text= "Traders - Retail";
		document.forms[0].select_OccupationSub.options[1].value= "2_1";
		document.forms[0].select_OccupationSub.options[2].text= "Traders - Whole Sales";
		document.forms[0].select_OccupationSub.options[2].value= "2_2";
		document.forms[0].select_OccupationSub.options[3].text= "Self Employed";
		document.forms[0].select_OccupationSub.options[3].value= "2_3";
		document.forms[0].select_OccupationSub.options[4].text= "Transport Operator";
		document.forms[0].select_OccupationSub.options[4].value= "2_4";
	}
	if(document.forms[0].select_Occupation.options.selectedIndex==3)
	{        
		document.forms[0].select_OccupationSub.length =6;
		document.forms[0].select_OccupationSub.options[0].text= "---- Select ----";
		document.forms[0].select_OccupationSub.options[0].value= "3_S";
		document.forms[0].select_OccupationSub.options[1].text= "Advocate";
		document.forms[0].select_OccupationSub.options[1].value= "3_1";
		document.forms[0].select_OccupationSub.options[2].text= "Doctor";
		document.forms[0].select_OccupationSub.options[2].value= "3_2";
		document.forms[0].select_OccupationSub.options[3].text= "Architect";
		document.forms[0].select_OccupationSub.options[3].value= "3_3";
		document.forms[0].select_OccupationSub.options[4].text= "C.A.";
		document.forms[0].select_OccupationSub.options[4].value= "3_4";
		document.forms[0].select_OccupationSub.options[5].text= "Others";
		document.forms[0].select_OccupationSub.options[5].value= "3_5";	
	}
	if(document.forms[0].select_Occupation.options.selectedIndex==4)
	{
		document.forms[0].select_OccupationSub.length =11;
		document.forms[0].select_OccupationSub.options[0].text= "---- Select ----";
		document.forms[0].select_OccupationSub.options[0].value= "4_S";
		document.forms[0].select_OccupationSub.options[1].text= "Marginal Farmer";
		document.forms[0].select_OccupationSub.options[1].value= "4_1";
		document.forms[0].select_OccupationSub.options[2].text= "Small Farmer";
		document.forms[0].select_OccupationSub.options[2].value= "4_2";
		document.forms[0].select_OccupationSub.options[3].text= "Other Farmer";
		document.forms[0].select_OccupationSub.options[3].value= "4_3";
		document.forms[0].select_OccupationSub.options[4].text= "Tenant Farmer";
		document.forms[0].select_OccupationSub.options[4].value= "4_4";
		document.forms[0].select_OccupationSub.options[5].text= "Share Cropper";
		document.forms[0].select_OccupationSub.options[5].value= "4_5";
		document.forms[0].select_OccupationSub.options[6].text= "Agriculture Labor";
		document.forms[0].select_OccupationSub.options[6].value= "4_6";
		document.forms[0].select_OccupationSub.options[7].text= "Other Labor";
		document.forms[0].select_OccupationSub.options[7].value= "4_7";
		document.forms[0].select_OccupationSub.options[8].text= "Landless Farmer";
		document.forms[0].select_OccupationSub.options[8].value= "4_8";
		document.forms[0].select_OccupationSub.options[9].text= "Fisher man";
		document.forms[0].select_OccupationSub.options[9].value= "4_9";
		document.forms[0].select_OccupationSub.options[10].text= "veteran";
		document.forms[0].select_OccupationSub.options[10].value= "4_10";
		
		
	}
	if(document.forms[0].select_Occupation.options.selectedIndex==5)
	{
		document.forms[0].select_OccupationSub.length =1;
		document.forms[0].select_OccupationSub.options[0].text= "---- Select ----";
		document.forms[0].select_OccupationSub.options[0].value= "5_S";
		
	}
	if(document.forms[0].select_Occupation.options.selectedIndex==6)
	{
		document.forms[0].select_OccupationSub.length =1;
		document.forms[0].select_OccupationSub.options[0].text= "---- Select ----";
		document.forms[0].select_OccupationSub.options[0].value= "6_S";
	}
	if(document.forms[0].select_Occupation.options.selectedIndex==7)
	{
		document.forms[0].select_OccupationSub.length =1;
		document.forms[0].select_OccupationSub.options[0].text= "---- Select ----";
		document.forms[0].select_OccupationSub.options[0].value= "7_S";
	}	
	if(document.forms[0].select_Occupation.options.selectedIndex==8)
	{
		document.forms[0].select_OccupationSub.length =5;
		document.forms[0].select_OccupationSub.options[0].text= "---- Select ----";
		document.forms[0].select_OccupationSub.options[0].value= "8_S";
		document.forms[0].select_OccupationSub.options[1].text= "Handicraftsman";
		document.forms[0].select_OccupationSub.options[1].value= "8_1";
		document.forms[0].select_OccupationSub.options[2].text= "Village & Cottage industries";
		document.forms[0].select_OccupationSub.options[2].value= "8_2";
		document.forms[0].select_OccupationSub.options[3].text= "Tiny Sectors";
		document.forms[0].select_OccupationSub.options[3].value= "8_3";
		document.forms[0].select_OccupationSub.options[4].text= "Rural Artisans";
		document.forms[0].select_OccupationSub.options[4].value= "8_4";
	}	
	if(document.forms[0].select_Occupation.options.selectedIndex==9)
	{
		document.forms[0].select_OccupationSub.length =1;
		document.forms[0].select_OccupationSub.options[0].text= "---- Select ----";
		document.forms[0].select_OccupationSub.options[0].value= "9_S";
	}	
	if(document.forms[0].select_Occupation.options.selectedIndex==10)
	{
		document.forms[0].select_OccupationSub.length =1;
		document.forms[0].select_OccupationSub.options[0].text= "---- Select ----";
		document.forms[0].select_OccupationSub.options[0].value= "10_S";
	}	
	if(document.forms[0].select_Occupation.options.selectedIndex==11)
	{
		document.forms[0].select_OccupationSub.length =1;
		document.forms[0].select_OccupationSub.options[0].text= "---- Select ----";
		document.forms[0].select_OccupationSub.options[0].value= "11_S";
	}	
		
}*/

/*function disablefields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
	
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}	
			
	}
	document.forms[0].txtperapp_appid.readOnly=true;
	document.forms[0].txtperapp_city.readOnly=true;
	document.forms[0].txtperapp_permcity.readOnly=true;
	
	document.forms[0].txtperapp_occupation.readOnly=true;
	
}*/

/*
function getes()
{
	
	if(document.forms[0].txtperapp_apptitle.value != "M/S.")
	{
	//document.all.db.style.visibility="visible";
	//document.all.dbs.style.visibility="hidden";
	}
	else
	{
	//document.all.db.style.visibility="hidden";
	//document.all.dbs.style.visibility="visible";
	}
}*/

/*function disableControls(bcmdEdit,bcmdApply,bcmdDelete,bcmdCancel,bcmdClose)
{
	document.forms[0].cmdedit.disabled=bcmdEdit;
	document.forms[0].cmdapply.disabled=bcmdApply;
	document.forms[0].cmddelete.disabled=bcmdDelete;
	document.forms[0].cmdcancel.disabled=bcmdCancel;
	document.forms[0].cmdclose.disabled=bcmdClose;
}*//*
function dateDOBCheck(objname)
	{
		var mycurrdate = new Date(currdate.substring(6,10),currdate.substring(3,5)-1,currdate.substring(0,2));	
  	  	var DOB =  objname.value
      	var mydobdate = new Date(DOB.substring(6,10),DOB.substring(3,5)-1,DOB.substring(0,2));
	  	if (mydobdate >= mycurrdate)
	  	{
			alert("Date should not be greater or equal to current date");
			objname.focus();
			objname.value="";
			return;
	  	}	
	}*//*
function showNumberChildren()
{
	varMstatus = document.forms[0].choperapp_marstat[document.forms[0].choperapp_marstat.options.selectedIndex].value;
	if(varMstatus!="")
	{
		if(varMstatus.toUpperCase()=="2")
		{	document.all.child1.style.visibility="hidden";
			document.all.child2.style.visibility="hidden";
		}
		else
		{
			document.all.child1.style.visibility="visible";
			document.all.child2.style.visibility="visible";
		}
	}
}
*//*
function enableserviceyrs()
	{
	if(document.forms[0].selExService.value=="N")
		{	document.all.exservice1.style.visibility="hidden";
			document.all.exservice2.style.visibility="hidden";
		}
		else
		{
			document.all.exservice1.style.visibility="visible";
			document.all.exservice2.style.visibility="visible";
		}
	}

*//*
function doSave()
{
	if(trim(document.forms[0].txtperapp_fname.value)=="")
	{
		ShowAlert('121','FirstName');
		document.forms[0].txtperapp_fname.focus();
		return;
	}
	if(document.forms[0].txtperapp_dob.value=="")
	{
		ShowAlert('121','Date of Birth');
		document.forms[0].txtperapp_dob.focus();
		return;
	}
	if (document.forms[0].txtperapp_dob.value !="")
	{
	  	var mycurrdate = new Date(currdate.substring(6,10),currdate.substring(3,5)-1,currdate.substring(0,2));	
  	  	var DOB =  document.forms[0].txtperapp_dob.value
      	var mydobdate = new Date(DOB.substring(6,10),DOB.substring(3,5)-1,DOB.substring(0,2));
	  	if (mydobdate >= mycurrdate)
	  	{
			alert("Date of Birth should not be greater or equal to current date");
			document.forms[0].txtperapp_dob.focus();
			return;
	  	}
	 }
	 if(document.forms[0].select_Occupation.value=="1" || document.forms[0].select_Occupation.value=="2" || document.forms[0].select_Occupation.value=="3")
	 {
	 	if(document.forms[0].txt_expyrs.value=="")
	 	{
	 		ShowAlert('111','Experience in Years');
	 		document.forms[0].txt_expyrs.focus();
	 		return;
	 	}
	 }
	if(document.forms[0].choperapp_sex.value=="0")
	{	
		ShowAlert('121','Sex');
		document.forms[0].choperapp_sex.focus();
		return false;		
	}
	if((document.forms[0].choperapp_marstat.value)=="S")
	{	
		ShowAlert('121','Marital Status');
		document.forms[0].choperapp_marstat.focus();
		return false;		
	}
	if(document.forms[0].txtperapp_address1.value == "")
	{
		ShowAlert('121','Present Address');
		document.forms[0].txtperapp_address1.focus();
		return;
	}
	if(document.forms[0].txtperapp_city.value == "")
	{
		ShowAlert('121','Present Address City');
		document.forms[0].txtperapp_city.focus();
		return;
	}
	if(document.forms[0].txtperapp_state.value == "")
	{
		ShowAlert('121','Present Address State');
		document.forms[0].txtperapp_state.focus();
		return;
	}
	if(document.forms[0].txtperapp_zip.value == "")
	{
		ShowAlert('121','Pincode');
		document.forms[0].txtperapp_zip.focus();
		return false;
	}
	if(document.forms[0].txtperapp_yrsinpresadd.value == "0")
	{
		ShowAlert('121','Mobility in Current Address');
		document.forms[0].txtperapp_yrsinpresadd.focus();
		return;
	}
	if(document.forms[0].select_Occupation.value=="S")
	{
		ShowAlert('121','Employment Status');
		document.forms[0].select_Occupation.focus();
		return;
	}
	
	
/*	if(parseInt(document.forms[0].txtperapp_yrsinpresadd.value) > 1)
	{
	
	}* /
	if((document.forms[0].selbank[document.forms[0].selbank.selectedIndex].value)=="1")
	{
		if(document.forms[0].txtperapp_since.value == "")
		{
			ShowAlert('121','Since');
			document.forms[0].txtperapp_since.focus();
			return false;
		}
	}
	if((document.forms[0].selcat.value)=="S")
	{	
		ShowAlert('121','Category');
		document.forms[0].selcat.focus();
		return false;		
	}
	if(document.forms[0].select_loc.value=="")
	{	
		ShowAlert('121','location');
		document.forms[0].selcat.focus();
		return false;		
	}
	if(document.forms[0].selreligion.value=="0")
	{
		ShowAlert('111','Religion');
		document.forms[0].selreligion.focus();
		return false;
	}
	if(document.forms[0].txtperapp_earn.value=="")
	{
		ShowAlert('121','Earning Members in Family');
		document.forms[0].txtperapp_earn.focus();
		return false;
	}
	if(document.forms[0].txtperapp_depend.value == "")
	{
		ShowAlert('121','No. of Dependents');
		document.forms[0].txtperapp_depend.focus();
		return false;
	}
		
	if((document.forms[0].seledu.value)=="0")
	{	
		ShowAlert('121','Edu. Qualification');
		document.forms[0].seledu.focus();
		return false;		
	}
	
	if(document.forms[0].selstatus.value=="2")
	{
		if(document.forms[0].txtperapp_passport.value == ""){
			ShowAlert('121','Passport Number');
			document.forms[0].txtperapp_passport.focus();
			
			return;
		}
		if(document.forms[0].txtperapp_passissue.value == ""){
			ShowAlert('121','Passport Issued By');
			document.forms[0].txtperapp_passissue.focus();
			return false;
		}
		if(document.forms[0].txtperapp_passportissuedate.value == ""){
			ShowAlert('121','Passport Issue Date');
			document.forms[0].txtperapp_passportissuedate.focus();
			return false;
		}
		if(document.forms[0].txtperapp_passportexpirydate.value == ""){
			ShowAlert('121','Passport Expiry Date');
			document.forms[0].txtperapp_passportexpirydate.focus();
			return false;
		}
		if(document.forms[0].txt_confirmationdate.value == ""){
			ShowAlert('121','Passport Expiry Date');
			document.forms[0].txt_confirmationdate.focus();
			return false;
		}

		
	}
	if(document.forms[0].txtperapp_husname.value!=""){
		if(document.forms[0].txtperapp_occupation.value == "0"){
			ShowAlert('111','Spouse Occupation');
			document.forms[0].txtperapp_occupation.focus();
			return;
		}
	}
	
	
	if(document.forms[0].selMinority.value=="")
	{
		ShowAlert('111','Minority');
		document.forms[0].selMinority.focus();
		return false;
	}
	if(document.forms[0].selExService.value=="")
	{
		ShowAlert('111','Ex serviceman');
		document.forms[0].selExService.focus();
		return false;
	}
	if(document.forms[0].selPhyHand.value=="")
	{
		ShowAlert('111','Physically Handicapped');
		document.forms[0].selPhyHand.focus();
		return false;
	}
	
//	document.forms[0].select_loc.disabled = false;
	document.forms[0].applnt.value="P";
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].hidBeanMethod.value="updateDemographics";
	document.forms[0].hidSourceUrl.value="/action/perapplicant.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	disableControls(false,true,true,true,false);
}*/

function callDisable(one)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=one;
		  	if(document.forms[0].elements[i].name.indexOf("txtperapp_appid")!=-1)
			{
				document.forms[0].elements[i].readOnly=true;
			}
		}
		if(document.forms[0].elements[i].type=="select-one" || document.forms[0].elements[i].type=="radio")
		document.forms[0].elements[i].disabled=one;
	}

//	document.forms[0].select_loc.disabled = true;
	document.forms[0].txtperapp_city.readOnly = true;
	document.forms[0].txtperapp_state.readOnly = true;
	document.forms[0].txtperapp_permcity.readOnly = true;
	document.forms[0].txtperapp_permstate.readOnly = true;
}

function callEdit()
{
	callDisable(false);
	disableControls(true,false,false,false,true);
	document.forms[0].hideditflag.value="Y";//trap edit
	document.forms[0].txtperapp_apptitle.focus();
}

function callLink(page,bean,method)
{	
	if (document.forms[0].cmdApply.disabled)
	{
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
	   	document.forms[0].action=appURL+"action/retailpge.jsp";
		document.forms[0].submit();
	}
}

function callCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanGetMethod.value="getDemographics";
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].action=appURL+"action/perapplicant.jsp?applnt=P&scode=yyy";
		document.forms[0].submit();
	}
}

function callDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{	
		document.forms[0].method="post";
		document.forms[0].hidBeanGetMethod.value="deleteDemographics";
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].action=appURL+"action/mastersearchper.jsp";
		document.forms[0].submit();
	}
}

function callModify()
{
	document.forms[0].method="post";
	document.forms[0].hidBeanMethod.value="renewApplicantData";
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/perapplicant.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getData";
	document.forms[0].submit();
}


function showPhoto()
{
	var varperapp_id = document.forms[0].txtperapp_appid.value;
	//document.all.idfrm1.src = appURL+"action/createfile.jsp?txtperapp_id="+varperapp_id+"&hidBeanGetMethod=getCreateFile";
}

function callCalender(controlname)
{
	if(document.forms[0].cmdEdit.disabled)
	{
		showCal(appURL,controlname);
	}
}
function callCalender5()
{
	if(document.forms[0].cmdEdit.disabled)
	{
		showCal(appURL,'txt_confirmationdate');
	}
}

function callCalender2()
{
	if(document.forms[0].cmdEdit.disabled)
	{
		showCal(appURL,'txtperapp_passportissuedate');
	}
}

function callCalender1()
{
	if(document.forms[0].cmdEdit.disabled)
	{	
		showCal(appURL,'txtperapp_passportexpirydate');
	}
}

function callCalender3()
{
	if(document.forms[0].cmdEdit.disabled)
	{
		showCal(appURL,'txt_purchasedate');
	}
}
function callCalender22()
{
	if(document.forms[0].cmdEdit.disabled)
	{
		showCal(appURL,'txt_dateofNRI');
	}
}
function menuOptionDivMouseDown (url) 
{		
	if(!document.forms[0].cmdApply.disabled)
	{
		ShowAlert(103);
		return;
	}
	document.currentMenu.style.display='none';
	document.currentMBarOpt.style.border='1px solid lightgrey';
	document.menuIsActive = false;
	document.forms[0].action=url;
	document.forms[0].submit();
}

function enableSince()
{
	if(document.forms[0].selbank.value == "1")
	{
		document.all.s1.style.visibility="visible";
		document.all.s2.style.visibility="visible";
		document.all.actype1.style.visibility="visible";
		document.all.actype2.style.visibility="visible";
		document.all.acno1.style.visibility="visible";
		document.all.acno2.style.visibility="visible";
		document.all.b1.style.visibility="visible";
		document.all.b2.style.visibility="visible";
	}
	else
	{
		document.all.s1.style.visibility="hidden";
		document.all.s2.style.visibility="hidden";
		document.all.actype1.style.visibility="hidden";
		document.all.actype2.style.visibility="hidden";
		document.all.acno1.style.visibility="hidden";
		document.all.acno2.style.visibility="hidden";
		document.all.b1.style.visibility="hidden";
		document.all.b2.style.visibility="hidden";
	}
}

function enablereg()
{
	/*if(document.forms[0].rdoperapp_professional.value == "1") by karthi for user input
	{
		document.all.reg.style.visibility = "visible";
		document.all.reg1.style.visibility = "visible";
	}
	else
	{
		document.all.reg.style.visibility = "hidden";
		document.all.reg1.style.visibility = "hidden";
	}*/
	document.forms[0].txtperapp_appid.readOnly=true;
}

function dohlp()     
{
  	var hlpvar = appURL+"phlp/loan_appretail_custpro_demo.htm";  	
 	var title = "Demographics";
  	var prop = "scrollbars=yes,width=600,height=450";	
  	prop = prop + ",left=50,top=150";
  	window.open(hlpvar,title,prop);
}

function callNRI()
{
	var hid_comappid1= document.forms[0].hid_comappid1.value;
	var purl = appURL+"action/nridetails.jsp?hidBeanGetMethod=getnriData&hidBeanId=refdetails&hid_comappid1="+hid_comappid1;
	var prop = 'scrollbars=no,width=800,height=500';	
	var xpos = (screen.width - 800) / 2;
	var ypos = (screen.height - 800) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);
}

function callKYCNorms()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		if(isNaN(document.forms[0].txtperapp_appid.value))
		{
			ShowAlert('103');
		}
		else
		{
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getKYCNormsdetails";
			document.forms[0].action=appURL+"action/set_KYCNorms.jsp";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert('103');
	}
}

function callEmployer()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		if(isNaN(document.forms[0].txtperapp_appid.value))
		{
			ShowAlert('103');
		}
		else
		{
			document.forms[0].hidBeanGetMethod.value="getEmployer";
			document.forms[0].action=appURL+"action/peremployer.jsp?applnt=P";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert('103');
	}
}

function callLandholding()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		if(isNaN(document.forms[0].txtperapp_appid.value))
		{
			ShowAlert('103');
		}
		else
		{
			document.forms[0].hidBeanGetMethod.value="agrlandholdings";
			document.forms[0].action=appURL+"action/agr_landholding.jsp";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert('103');
	}
}