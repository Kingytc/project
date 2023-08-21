

<%HashMap hshParams = new HashMap();

			hshParams = (HashMap) hshValues.get("hshParams");
			if (hshParams == null) {
				hshParams = hshValues;
			}

			
			String strCattype1=Helper.correctNull(request.getParameter("hidCategoryType"));
			String strLocation = (String) session.getAttribute("strOrgName");
			String txt_flag = Helper.correctNull((String) hshValues
					.get("txt_flag"));
			String custtmpid = Helper.correctNull((String) hshValues
					.get("custtmpid"));

			boolean bval = false;
			//Raman
			String strperapp_bankacctype, strperapp_bankaccno;
			strperapp_bankacctype = Helper.correctNull((String) hshValues
					.get("perapp_bankacctype"));
			strperapp_bankaccno = Helper.correctNull((String) hshValues
					.get("perapp_bankaccno"));

			String Occupation = Helper.correctNull((String) hshValues
					.get("perapp_spouseoccu"));

			bval = false;
			//Raman

			%>

<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var txt_flag = "<%=txt_flag%>";
var custtmpid = "<%=custtmpid%>";
var locationcode = "<%=strOrgCode%>"
var dob="<%=Helper.correctNull((String)hshValues.get("perapp_dob"))%>";
var id="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>";
var varSex="<%=Helper.correctNull((String)hshValues.get("perapp_sex"))%>";
var varMstatus="<%=Helper.correctNull((String)hshValues.get("perapp_marstat"))%>";
var varEmployed="<%=Helper.correctNull((String)hshValues.get("perapp_employment"))%>";
var vardelete="<%=Helper.correctNull((String)hshValues.get("nodelete"))%>";
var varedu = "<%=Helper.correctNull((String)hshValues.get("perapp_education"))%>";
var varbank = "<%=Helper.correctNull((String)hshValues.get("perapp_bank"))%>";
var varbuss = "<%=Helper.correctNull((String)hshValues.get("perapp_buss"))%>";
var varstatus= "<%=Helper.correctNull((String)hshValues.get("perapp_status"))%>";
var varcat = "<%=Helper.correctNull((String)hshValues.get("perapp_category"))%>";
var yearsinadd = "<%=Helper.correctNull((String)hshValues.get("perapp_yrsinpresadd"))%>";
var typeofprof = "<%=Helper.correctNull((String)hshValues.get("perapp_typeofprof"))%>";
var varperapp_apptitle = "<%=Helper.correctNull((String)hshValues.get("perapp_title"))%>"
var appstatus = "<%=Helper.correctNull((String)hshValues.get("appstatus"))%>";

var branchcode = "<%=Helper.correctNull((String)hshValues.get("perapp_branchcode"))%>";
 var sel_spouse="<%=Helper.correctNull((String)hshValues.get("perapp_spousetitle"))%>";
var varOccuCat="<%=Helper.correctNull((String)hshValues.get("perapp_eduothers"))%>";
var varreligion="<%=Helper.correctNull((String)hshValues.get("perapp_religion"))%>";
var sel_residence ="<%=Helper.correctNull((String)hshValues.get("perapp_residencetype"))%>";
var sel_transferrable ="<%=Helper.correctNull((String)hshValues.get("perapp_transferable"))%>";
var sel_jobloacation = "<%=Helper.correctNull((String)hshValues.get("perapp_joblocation"))%>";
var perapp_salaryrouted = "<%=Helper.correctNull((String)hshValues.get("perapp_salaryrouted"))%>";
var spouse_occupation="<%=Helper.correctNull((String)hshValues.get("perapp_occupation"))%>"
var other_detail="<%=Helper.correctNull((String)hshValues.get("per_other_doc"))%>";
var varadd="<%=Helper.correctNull((String)hshValues.get("perapp_seladd"))%>";
 
var varphysical="<%=Helper.correctNull((String)hshValues.get("perapp_selphysical"))%>";
var varExService="<%=Helper.correctNull((String)hshValues.get("perapp_selexservice"))%>";
var varMinority="<%=Helper.correctNull((String)hshValues.get("perapp_selminority"))%>";
var varistatus="<%=Helper.correctNull((String)hshValues.get("perapp_istatus"))%>";
var varistaff="<%=Helper.correctNull((String)hshValues.get("perapp_istaff"))%>";
var struserid="<%=Helper.correctNull((String)hshValues.get("perapp_staffusrid"))%>";
var strseladd="<%=Helper.correctNull((String)hshValues.get("perapp_seladd"))%>";
var varUserId = "<%=Helper.correctNull((String)session.getAttribute("strUserId"))%>";
var varselminor="<%=Helper.correctNull((String)hshParams.get("sel_minor"))%>";
var vartradefinance="<%=Helper.correctNull((String)hshParams.get("sel_trade"))%>";
var varinlandtrade = "<%=Helper.correctNull((String)hshParams.get("sel_inland"))%>";
var vartitle = "<%=Helper.correctNull((String)hshParams.get("txt_ititle"))%>";
var perapp_constitution="<%=Helper.correctNull((String)hshValues.get("perapp_constitution"))%>";
var varCateType ="<%=strCattype1%>";
//added by s.sathya moorthy for allowing space and alphaphets
function allowSpaceAlpha()
{
	var key = window.event.keyCode;
	if(!((key>64 && key<91) || (key>96 && key<123)||key==32))
	{
		window.event.returnValue = false;
	}
}

//from .js file....

function showstate()
{
	var val1=document.forms[0].hidcity.value;
	var val2=document.forms[0].hidstate.value;
	if(val1!="")
	{
		document.forms[0].hidcity1.value=val1;
	}
	if(val2!="")
	{
		document.forms[0].hidstate1.value=val2;
	}
}

function ShowOccupation()
{
	if(document.forms[0].select_Occupation.options.selectedIndex==1)
	{         
		document.forms[0].select_OccupationSub.length =7;
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
		document.forms[0].select_OccupationSub.options[5].text= "Pvt Company";
		document.forms[0].select_OccupationSub.options[5].value= "1_5";
		document.forms[0].select_OccupationSub.options[6].text= "Others";
		document.forms[0].select_OccupationSub.options[6].value= "1_6";
	}
	if(document.forms[0].select_Occupation.options.selectedIndex==2)
	{        
		document.forms[0].select_OccupationSub.length =1;
		document.forms[0].select_OccupationSub.options[0].text= "---- Select ----";
		document.forms[0].select_OccupationSub.options[0].value= "2_S";
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
		document.forms[0].select_OccupationSub.length =3;
		document.forms[0].select_OccupationSub.options[0].text= "---- Select ----";
		document.forms[0].select_OccupationSub.options[0].value= "6_S";
		document.forms[0].select_OccupationSub.options[1].text= "Traders - Retail";
		document.forms[0].select_OccupationSub.options[1].value= "6_1";
		document.forms[0].select_OccupationSub.options[2].text= "Traders - Whole Sales";
		document.forms[0].select_OccupationSub.options[2].value= "6_2";
	}
	if(document.forms[0].select_Occupation.options.selectedIndex==7)
	{
		document.forms[0].select_OccupationSub.length =5;
		document.forms[0].select_OccupationSub.options[0].text= "---- Select ----";
		document.forms[0].select_OccupationSub.options[0].value= "7_S";
		document.forms[0].select_OccupationSub.options[1].text= "Small Business";
		document.forms[0].select_OccupationSub.options[1].value= "7_1";
		document.forms[0].select_OccupationSub.options[2].text= "Professional and Selfemployed";
		document.forms[0].select_OccupationSub.options[2].value= "7_2";
		document.forms[0].select_OccupationSub.options[3].text= "SWRTO";
		document.forms[0].select_OccupationSub.options[3].value= "7_3";
		document.forms[0].select_OccupationSub.options[4].text= "Others";
		document.forms[0].select_OccupationSub.options[4].value= "7_4";	
	}	
	if(document.forms[0].select_Occupation.options.selectedIndex==8)
	{
	//	document.forms[0].select_OccupationSub.length =5;
		//document.forms[0].select_OccupationSub.options[0].text= "---- Select ----";
		//document.forms[0].select_OccupationSub.options[0].value= "8_S";
		//document.forms[0].select_OccupationSub.options[1].text= "Handicraftsman";
		//document.forms[0].select_OccupationSub.options[1].value= "8_1";
		//document.forms[0].select_OccupationSub.options[2].text= "Village & Cottage industries";
		//document.forms[0].select_OccupationSub.options[2].value= "8_2";
		//document.forms[0].select_OccupationSub.options[3].text= "Tiny Sectors";
		//document.forms[0].select_OccupationSub.options[3].value= "8_3";
		//document.forms[0].select_OccupationSub.options[4].text= "Rural Artisans";
		//document.forms[0].select_OccupationSub.options[4].value= "8_4";

		document.forms[0].select_OccupationSub.length =1;
		document.forms[0].select_OccupationSub.options[0].text= "---- Select ----";
		document.forms[0].select_OccupationSub.options[0].value= "8_S";
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
}

function callDescHelp(page)
{	
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = appURL+"action/comindustrymasterhelp.jsp?page="+page;
		var title = "IndustryHelp";
		var prop = "scrollbars=no,width=650,height=400";	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);	
	}
}

function checkFileDate(obj)
{
	var pagedate = obj.value;
	var currdate = currentDate;
	var crdt = currdate.substring(0,2);
	var crmon = currdate.substring(3,5);
	var cryr = currdate.substring(6,10);
	var curdate = crmon+"/"+crdt+"/"+cryr;	

	if(pagedate>cryr)
	{
		alert("Year should not be greater than current year");
		document.forms[0].txtperapp_since.focus();
		document.forms[0].txtperapp_since.value="";
		return;
	}
}
  
function disablefields(one)
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
		if(document.forms[0].elements[i].type=='checkbox')
		{
			document.forms[0].elements[i].readOnly=one;		  
		}		
	}
	document.forms[0].txtperapp_appid.readOnly=true;
	document.forms[0].txtperapp_city.readOnly=true;
	document.forms[0].txtperapp_permcity.readOnly=true;
	document.forms[0].txtperapp_state.readOnly=true;
	document.forms[0].txtperapp_permstate.readOnly=true;
	document.forms[0].txtperapp_occupation.readOnly=true;
	document.forms[0].txt_perapporg.readOnly=true;
	document.forms[0].txtperapp_branch.readOnly=true;
	document.forms[0].txtperapp_country.readOnly=true; 
	document.forms[0].txtperapp_permcountry.readOnly=true;
	document.forms[0].comapp_companyid.readOnly=true; 
}

function callonLoad()
{
    document.forms[0].select_Occupation.length =11;
	document.forms[0].select_Occupation.options[0].text= "---- Select ----";
	document.forms[0].select_Occupation.options[0].value= "0";
	document.forms[0].select_Occupation.options[1].text= "Employee";
	document.forms[0].select_Occupation.options[1].value= "1";
	document.forms[0].select_Occupation.options[2].text= "Business Man";
	document.forms[0].select_Occupation.options[2].value= "2";
	document.forms[0].select_Occupation.options[3].text= "Professionals";
	document.forms[0].select_Occupation.options[3].value= "3";
	document.forms[0].select_Occupation.options[4].text= "Agriculture and allied activities";
	document.forms[0].select_Occupation.options[4].value= "4";
	document.forms[0].select_Occupation.options[5].text= "Retail Trade";
	document.forms[0].select_Occupation.options[5].value= "6";
	document.forms[0].select_Occupation.options[6].text= "SME (Services)";
	document.forms[0].select_Occupation.options[6].value= "7";
	document.forms[0].select_Occupation.options[7].text= "SME (Manufacturing)";
	document.forms[0].select_Occupation.options[7].value= "8";
	document.forms[0].select_Occupation.options[8].text= "Pensioner";
	document.forms[0].select_Occupation.options[8].value= "9";
	document.forms[0].select_Occupation.options[9].text= "Student";
	document.forms[0].select_Occupation.options[9].value= "10";
	document.forms[0].select_Occupation.options[10].text= "Others";
	document.forms[0].select_Occupation.options[10].value= "11";
	
	if(id.toUpperCase()=="NEW" &&(txt_flag != "Y"))
	{	
		disableControls(true,false,true,true,false);
		document.forms[0].cmdreferences.disabled=true;
		document.forms[0].cmdNridetails.disabled=true;	
		if(document.forms[0].txtperapp_apptitle.value =="M/S")
		{
		document.forms[0].cmdpartners.disabled=true;
		}
		document.forms[0].cmdmodify.disabled=true;
		document.forms[0].txtperapp_occupation.readOnly=true;

		document.all.p4.style.visibility="hidden";
		document.all.p4.style.position="absolute";
		document.all.p5.style.visibility="hidden";
		document.all.emp1.style.visibility="hidden";
		document.all.emp2.style.visibility="hidden";	

		disablefields(false);
		ShowOccupation();
		getes();
	}
	else
	{
		document.forms[0].cmdmodify.disabled=true;
		if(perapp_constitution!="")
		{
			document.forms[0].txt_perappconstitution.value=perapp_constitution;
		}	
		else
		{
			document.forms[0].txt_perappconstitution.value="0";
		}		
		if(varselminor!="")
		{
			document.forms[0].sel_minor.value=varselminor;
		}
		else
		{
			document.forms[0].sel_minor.value="2";
		}
	    if(vartradefinance!="")
		{
			document.forms[0].sel_trade.value=vartradefinance;
		}
		else
		{
			document.forms[0].sel_trade.value="2";
		}
		if(varinlandtrade!="")
		{
			document.forms[0].sel_inland.value=varinlandtrade;
		}
		else
		{
			document.forms[0].sel_inland.value="2";
		}
		if(struserid!="")
		{
			document.forms[0].txt_Userid.value=struserid;
		}
		else
		{
			document.forms[0].txt_Userid.value="0";
		}
		if(varSex!="")
		{	
			document.forms[0].choperapp_sex.value =varSex;
		}
		else
		{
			document.forms[0].choperapp_sex.value ="0";
		}	
		if(varMstatus!="")
		{
			document.forms[0].choperapp_marstat.value=varMstatus;
		}
		else
		{
			document.forms[0].choperapp_marstat.value="S";
		}
		if(varadd!="")
		{
			document.forms[0].chk_perm_add.checked=true; 
		}
		else
		{
			document.forms[0].chk_perm_add.checked=false; 
		}
		if(varedu!="")
		{
			document.forms[0].seledu.value=varedu;
		}
		else
		{
			document.forms[0].seledu.value="0";
		}
		if(varistatus!="")
		{
			document.forms[0].sel_istatus.value=varistatus;
		}
		else
		{
			document.forms[0].sel_istatus.value="0";
		}
		if(varistaff!="")
		{
			document.forms[0].sel_istaff.value=varistaff;
		}
		else
		{
			document.forms[0].sel_istaff.value="0";
		}
		if(varcat!="")
		{
			document.forms[0].selcat.value=varcat;
		}
		else
		{
			document.forms[0].selcat.value="S";
		}
		if(yearsinadd!="")
		{
			if(yearsinadd.toUpperCase()=="1")
			{
				document.forms[0].txtperapp_yrsinpresadd.options.selectedIndex=1;
			}
			else if(yearsinadd.toUpperCase()=="2")
			{
				document.forms[0].txtperapp_yrsinpresadd.options.selectedIndex=2;
			}
			else if(yearsinadd.toUpperCase()=="3")
			{
				document.forms[0].txtperapp_yrsinpresadd.options.selectedIndex=3;
			}
			else if(yearsinadd.toUpperCase()=="4")
			{
				document.forms[0].txtperapp_yrsinpresadd.options.selectedIndex=4;
			}
			else 
			{
				document.forms[0].txtperapp_yrsinpresadd.options.selectedIndex=0;
			}
		}
		if(varbank!="")
		{
			if(varbank.toUpperCase()=="1")
			{
				document.forms[0].selbank.value=varbank;
			}
			else if(varbank.toUpperCase()== "2")
			{
				document.forms[0].selbank.value=varbank;
			}
			else
			{
				document.forms[0].selbank.value="2";
			}
		}		
		document.forms[0].selbuss.value = varbuss;
		if(varstatus!="")
		{
			document.forms[0].selstatus.value = varstatus;
		}			
		else 
		{
			document.forms[0].selstatus.value = "0";
		}
		if(varOccuCat!="")
		{
			document.forms[0].select_OccupationSub.value = varOccuCat;
		}			
		else 
		{
			document.forms[0].select_OccupationSub.value = "0";
		}
		if(perapp_salaryrouted!="")
		{
			document.forms[0].sel_salaryrooted.value=perapp_salaryrouted;
		}
		else
		{
			document.forms[0].sel_salaryrooted.value="2";
		}
		if(varreligion!="")
		{
			document.forms[0].selreligion.value = varreligion;
		}			
		else 
		{
			document.forms[0].selreligion.value  = "0";
		}
		if(sel_residence!="")
		{
			document.forms[0].sel_residence.value=sel_residence;
		}
		else
		{
			document.forms[0].sel_residence.value="0";
		}
		if(sel_transferrable!="")
		{
			document.forms[0].sel_transferrable.value=sel_transferrable;
		}
		else
		{
			document.forms[0].sel_transferrable.value="2";
		}
		if(sel_jobloacation!="")
		{
			document.forms[0].sel_jobloacation.value=sel_jobloacation;
		}
		else
		{
			document.forms[0].sel_jobloacation.value="2";
		}
		if(varperapp_apptitle!="")
		{
			document.forms[0].txtperapp_apptitle.value=varperapp_apptitle;
		}
		if(sel_spouse!="")
		{
			document.forms[0].sel_spouse.value=sel_spouse;
		}
		if(varphysical!="")
		{
			document.forms[0].selPhyHand.value=varphysical;
		}
		else
		{
			document.forms[0].selPhyHand.value="2";
		}
		if(varExService!="")
		{
			document.forms[0].selExService.value=varExService;
		}
		else
		{ 
			document.forms[0].selExService.value="2";
		}
		if(spouse_occupation!="")
		{
			document.forms[0].txtperapp_occupation.value=spouse_occupation;
		}
		else
		{
			document.forms[0].txtperapp_occupation.value="0";
		}	
		if(varMinority!="")
		{
			document.forms[0].selMinority.value=varMinority;
		}
		else
		{
			document.forms[0].selMinority.value="2";
		}
		if(trim(document.forms[0].txtperapp_fname.value)=="")
		{
			document.forms[0].txtperapp_appid.value="new";
		}
		if(branchcode!="")
		{
			document.forms[0].select_loc.value=branchcode;
		}
		else
		{
			document.forms[0].select_loc.value ="S";
		}
		if(vardelete!="")
		{
			if(vardelete=="nodelete")
			{
				ShowAlert('135');
			}
			else if(vardelete=="delete")
			{
				ShowAlert('136');
			}
		}	
		if(!document.forms[0].txtperapp_apptitle.disabled)
			document.forms[0].txtperapp_apptitle.focus();
		enableSince();
		ShowOccupation();
		screenCaptured();
		shownri();
		showres();
		showStaffBox();
		showguardian();
		showinland();
		getes();
		if(varEmployed!="")
		{
			document.forms[0].select_Occupation.value=varEmployed;
			ShowOccupation();
		}
		else
		{
			document.forms[0].select_Occupation.value="0";
			ShowOccupation()
		}
		showBusiness();
		if(varOccuCat!="")
		{
			document.forms[0].select_OccupationSub.value=varOccuCat;
		}
		if(document.forms[0].select_Occupation.value=="2")
		{	
			document.forms[0].sel_transferrable.value="2";
			document.forms[0].sel_istaff.value="N";
		}
		getlocationvalues();
		
		if(document.forms[0].chk_perm_add.checked)
		{
			document.forms[0].txtperapp_permadd1.value=document.forms[0].txtperapp_address1.value;
			document.forms[0].txtperapp_permadd2.value=document.forms[0].txtperapp_address2.value;
			document.forms[0].txtperapp_permadd3.value=document.forms[0].txtperapp_address3.value;
			document.forms[0].txtperapp_permcity.value=document.forms[0].txtperapp_city.value;
			document.forms[0].txtperapp_permstate.value=document.forms[0].txtperapp_state.value;
			document.forms[0].txtperapp_permzip.value=document.forms[0].txtperapp_zip.value;
			document.forms[0].txtperapp_permphone.value=document.forms[0].txtperapp_phone.value;
			document.forms[0].txtperapp_permcountry.value=document.forms[0].txtperapp_country.value;
			document.forms[0].hidperapp_permcountry.value=document.forms[0].hidperapp_country.value;
		}
		if(strseladd=="1")
		{
			document.forms[0].chk_perm_add.checked=true;
		}
		else
		{
			document.forms[0].chk_perm_add.checked=false;
		}
	
		document.forms[0].cmdPhoto.disabled=true;
		if(txt_flag == "Y")
		{
			disableControls(true,false,true,true,false);
			callDisable(false);
			alert("Person with same Name exists Please check "+"Applicant Id :" + custtmpid);		
		}
		else
		{
			disableControls(false,true,true,true,false);
			callDisable(true);
		}
		if(appstatus=="true")
		{
			alert("Cannot Change the Applicant Data, It is used in Approved Applications")
			disableControls(true,true,true,true,false);
			if(document.forms[0].readFlag.value.toUpperCase()=="W")
			{
				document.forms[0].cmdmodify.disabled=false;
			}
		}
	}
	showYearsOfService();
	if((document.forms[0].txtperapp_apptitle.value =="M/S") && (document.forms[0].txt_perappconstitution.value=="006" || document.forms[0].txt_perappconstitution.value=="005"))
	{
		for(var i=0;i<2;i++)
		{
			document.all.cons[i].style.visibility="visible";
			document.all.cons[i].style.position="relative";
		}
	}	
	else
	{
		for(var i=0;i<2;i++)
		{
			document.all.cons[i].style.visibility="hidden";
			document.all.cons[i].style.position="absolute";
		}
	}
}

function getes()
{
	if(document.forms[0].txtperapp_apptitle.value == "M/S")
	{
		document.all.busicommaddr.innerHTML='<b>Business Address</b>';
	}
	else
	{
		document.all.busicommaddr.innerHTML='<b>Communication Address</b>';
	}
}

function disableControls(bcmdEdit,bcmdApply,bcmdDelete,bcmdCancel,bcmdClose)
{
	document.forms[0].cmdedit.disabled=bcmdEdit;
	document.forms[0].cmdsave.disabled=bcmdApply;
	document.forms[0].cmddelete.disabled=bcmdDelete;
	document.forms[0].cmdcancel.disabled=bcmdCancel;
	document.forms[0].cmdclose.disabled=bcmdClose;
}

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
}

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

function checkUser()
{
	if(document.forms[0].txt_Userid.value.toUpperCase() == varUserId.toUpperCase())
	{
		alert("User is not allowed to create his own Customer Profile");
		document.forms[0].txt_Userid.value = "";
		return;
	}
}

function doSave()
{
	var txtval=document.forms[0].txtperapp_fname.value;

	var txtlen=txtval.length;
	if(document.forms[0].txt_perappconstitution.value=="0")
	{
	 	ShowAlert('111','Constitution');
		document.forms[0].txt_perappconstitution.focus();
		return;
	}
	if(trim(document.forms[0].txtperapp_fname.value)=="")
	{
		ShowAlert('121','FullName');
		document.forms[0].txtperapp_fname.focus();
		return;
	}
	else if(txtlen<=2)
	{
		alert("Enter atleast 3 charcters");
     	document.forms[0].txtperapp_fname.focus();
     	return;
    }
	if(document.forms[0].txtperapp_apptitle.value =="M/S")
	{
		if(document.forms[0].txtperapp_dob.value=="")
		{
			ShowAlert('121','Date of Establishment/Incorporation');
			document.forms[0].txtperapp_dob.focus();
			return;
		}
		if(trim(document.forms[0].txtperapp_address1.value) == "")
		{
			ShowAlert('121','Business Address');
			document.forms[0].txtperapp_address1.focus();
			return;
		}
		else if((trim(document.forms[0].txtperapp_address1.value)).length<15)
		{
			alert('Enter minimum 15 characters in address field');
			document.forms[0].txtperapp_address1.focus();
			return;
		}
		if(trim(document.forms[0].txtperapp_address2.value) == "")
		{
			ShowAlert('121','Business Address2');
			document.forms[0].txtperapp_address2.focus();
			return;
		}
		else if((trim(document.forms[0].txtperapp_address2.value)).length<15)
		{
			alert('Enter minimum 15 characters in address field');
			document.forms[0].txtperapp_address2.focus();
			return;
		}
		
		if(document.forms[0].txtperapp_city.value == "")
		{
			ShowAlert('121','Business Address City');
			document.forms[0].txtperapp_city.focus();
			return;
		}
		if(document.forms[0].txtperapp_country.value == "")
		{
			ShowAlert('121','Business Country');
			return;
		}
	}
	if(document.forms[0].txtperapp_apptitle.value !="M/S")
	{
    
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
	}
	if(document.forms[0].choperapp_sex.value=="0")
	{	
		ShowAlert('121','Gender');
		document.forms[0].choperapp_sex.focus();
		return false;		
	}
	if((document.forms[0].sel_istatus.value)=="0")
	{	
		ShowAlert('121','Customer Status');
		document.forms[0].sel_istatus.focus();
		return false;		
	}	
	if(document.forms[0].txt_perappconstitution.value=="001" || document.forms[0].txt_perappconstitution.value=="002")
	{ 
		if((document.forms[0].choperapp_marstat.value)=="S")
		{	
			ShowAlert('121','Marital Status');
			document.forms[0].choperapp_marstat.focus();
			return false;		
		}
	}
	if(document.forms[0].txt_perapporg.value=="")
	{	
		ShowAlert('111','branch where application recieved from ');
		document.forms[0].txt_perapporg.focus();
		return false;		
	}
	else if(document.forms[0].select_loc.value=="")
	{
		ShowAlert('111','branch where application recieved from ');
		document.forms[0].txt_perapporg.value="";
		return false;
	}

	if(trim(document.forms[0].txtperapp_address1.value) == "")
	{
		ShowAlert('121','Present Address1');
		document.forms[0].txtperapp_address1.focus();
		return;
	}
	else if((trim(document.forms[0].txtperapp_address1.value)).length<15)
	{
		alert('Enter minimum 15 characters in address field');
		document.forms[0].txtperapp_address1.focus();
		return;
	}
	
	if(trim(document.forms[0].txtperapp_address2.value) == "")
	{
		ShowAlert('121','Present Address2');
		document.forms[0].txtperapp_address2.focus();
		return;
	}
	else if((trim(document.forms[0].txtperapp_address2.value)).length<15)
	{
		alert('Enter minimum 15 characters in address field');
		document.forms[0].txtperapp_address2.focus();
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
	if(document.forms[0].txtperapp_country.value == "")
	{
		ShowAlert('121','Present Country');
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
	if(document.forms[0].sel_residence.value=="0")
	{
		ShowAlert('111','Residence  Type');
		document.forms[0].sel_residence.focus();
		return false;
	}
	if(document.forms[0].select_Occupation.value=="0")
	{
		ShowAlert('121','Employment Status');
		document.forms[0].select_Occupation.focus();
		return;
	}
	if(document.forms[0].select_Occupation.value=="1" || document.forms[0].select_Occupation.value=="2" || document.forms[0].select_Occupation.value=="3")
	{
	 	if(document.forms[0].txt_expyrs.value=="")
	 	{
	 		ShowAlert('121','Experience in Years');
	 		document.forms[0].txt_expyrs.focus();
	 		return;
	 	}
	}
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
		ShowAlert('111','Category');
		document.forms[0].selcat.focus();
		return false;		
	}
	if((document.forms[0].seledu.value)=="0")
	{	
		ShowAlert('121','Edu. Qualification');
		document.forms[0].seledu.focus();
		return false;		
	}
	if(document.forms[0].selreligion.value=="0")
	{
		ShowAlert('111','Religion');
		document.forms[0].selreligion.focus();
		return false;
	}
	if(document.forms[0].txtperapp_panno.value=="")
	{
		ShowAlert('121','PAN Number or type NOPAN');
		document.forms[0].txtperapp_panno.focus();
		return false;
	}
	if(document.forms[0].txt_perappconstitution.value=="001" || document.forms[0].txt_perappconstitution.value=="002")
	{
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
		}
	}	
	if(trim(document.forms[0].txtperapp_husname.value)!=""){
		if(document.forms[0].txtperapp_occupation.value == "0"){
			ShowAlert('111','Spouse Occupation');
			document.forms[0].txtperapp_occupation.focus();
			return;
		}
	}
	if(document.forms[0].txt_perappconstitution.value=="001" || document.forms[0].txt_perappconstitution.value=="002")
	{
		if(document.forms[0].txtperapp_earn.value=="")
		{
			ShowAlert('121','Earning Member in Family');
			document.forms[0].txtperapp_earn.focus();
			return false;
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
		ShowAlert('111','Physically Challenged');
		document.forms[0].selPhyHand.focus();
		return false;
	}
	if(document.forms[0].chk_perm_add.checked==true)
	{
	 	document.forms[0].chk_perm_add.value="1";
	}
	if(document.forms[0].chk_perm_add.checked==false)
	{
	 	document.forms[0].chk_perm_add.value="0";
	}
	if(document.forms[0].txt_perappconstitution.value=="001" || document.forms[0].txt_perappconstitution.value=="002")
	{
		if(document.forms[0].select_Occupation.value!="2")
		{	
			if(document.forms[0].sel_istaff.value=="Y")
			{
				if(document.forms[0].txt_dateofjoining.value=="")
				{
					ShowAlert('121','Date of Joining');
					document.forms[0].txt_dateofjoining.focus();
					return false;
				}
				if(document.forms[0].txt_Userid.value=="")
				{
					ShowAlert('121','PF No');
					document.forms[0].txt_Userid.focus();
					return false;
				}
				
			 if(document.forms[0].txt_confirmationdate.value=="")
				{
					ShowAlert('111','Confirmation Date');
					document.forms[0].txt_confirmationdate.focus();
					return false;
				}
				if(document.forms[0].txt_servicerecord.value=="")
				{
					ShowAlert('121','Service Record');
					document.forms[0].txt_servicerecord.focus();
					return false;
				}
			}
		}
	}
	
		
	if(document.forms[0].txt_perappconstitution.value=="001" || document.forms[0].txt_perappconstitution.value=="002")
	{
		if(document.forms[0].selExService.value=="Y")
		{
			 if(document.forms[0].txt_yrs_service.value=="")
			{
				ShowAlert('121','Years Of Service');
				document.forms[0].txt_yrs_service.focus();
				return false;
			}
			
		}
		
	
		if(document.forms[0].select_Occupation.value=="9")
		{
			 if(document.forms[0].txtperapp_pension.value=="")
			{
				alert("Enter Pensioner Payment Order");
				document.forms[0].txtperapp_pension.focus();
				return false;
			}
		}
	}
	
	
	if(document.forms[0].sel_minor.value=="1")	
	{
		 if(document.forms[0].txt_guardianame.value=="")
			{
				alert("Enter Guardian Name");
				document.forms[0].txt_guardianame.focus();
				return false;
			}
		if(document.forms[0].txt_guardian.value=="")
			{
				alert("Enter Guardian Relationship");
				document.forms[0].txt_guardian.focus();
				return false;
			}
		if(document.forms[0].txt_relation.value=="")
			{
				alert("Enter Guardian Address");
				document.forms[0].txt_relation.focus();
				return false;
			}
		
			 			 
	}
	
	document.forms[0].cmdsave.disabled = true;
	if(document.forms[0].hidModuleName.value=="P")
	{
	document.forms[0].applnt.value="P";
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].hidBeanMethod.value="updateDemographics";
	document.forms[0].hidSourceUrl.value="/action/perapplicant.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	}
	else
	{
	document.forms[0].applnt.value="T";
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].hidBeanMethod.value="updateDemographics";
	document.forms[0].hidSourceUrl.value="/action/ops_applicant.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	}
	disableControls(false,true,true,true,false);
	
}
function check_val()
	{
		var dobjoindate=document.forms[0].txt_dateofjoining.value;
		var confirmdate=document.forms[0].txt_confirmationdate.value;
		var dobjoindate = new Date(dobjoindate.substring(6,10),dobjoindate.substring(3,5),dobjoindate.substring(0,2));	
  	  	
      	var confirmdate = new Date(confirmdate.substring(6,10),confirmdate.substring(3,5),confirmdate.substring(0,2));
if (document.forms[0].txt_dateofjoining.value !="" && document.forms[0].txt_confirmationdate.value !="")

	{
	  	
	  	if (dobjoindate > confirmdate)
	  	{
			ShowAlert('111','Confirmation Date should be Greater than Date of Joining');
				
			document.forms[0].txt_confirmationdate.value="";
			return;
	  	}
	  	
	 }

else if(document.forms[0].txt_dateofjoining.value =="")
{
	ShowAlert('121','Date of Joining');
	document.forms[0].txt_confirmationdate.value="";
	
	 return false;	
	
}
			
	}
function check_val2()
	{
		var dobjoindate=document.forms[0].txt_dateofjoining.value;
		var confirmdate=document.forms[0].txt_confirmationdate.value;
		var dobjoindate = new Date(dobjoindate.substring(6,10),dobjoindate.substring(3,5),dobjoindate.substring(0,2));	
    	var confirmdate = new Date(confirmdate.substring(6,10),confirmdate.substring(3,5),confirmdate.substring(0,2));
	if(document.forms[0].txt_confirmationdate.value !="")
		{
		if (dobjoindate > confirmdate)
		  	{
				ShowAlert('111','Confirmation Date should be Greater than Date of Joining');
				
				document.forms[0].txt_confirmationdate.value="";
				
				return;
		  	}
		}
	}	
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
		if(document.forms[0].elements[i].type=="checkbox")


		document.forms[0].elements[i].disabled=one;
	}

	document.forms[0].txtperapp_city.readOnly = true;
	document.forms[0].txtperapp_state.readOnly = true;
	document.forms[0].txtperapp_permcity.readOnly = true;
	document.forms[0].txtperapp_permstate.readOnly = true;
	document.forms[0].txt_perapporg.readOnly = true;
	document.forms[0].txtperapp_branch.readOnly = true;
	document.forms[0].txtperapp_country.readOnly=true; 
	document.forms[0].txtperapp_permcountry.readOnly=true;
	document.forms[0].comapp_companyid.readOnly=true; 
}

function doEdit()
{
	callDisable(false);
	disableControls(true,false,false,false,true);
	document.forms[0].hideditflag.value="Y";
	document.forms[0].txtperapp_apptitle.focus();
	document.forms[0].txtperapp_occupation.readOnly=true;
	document.forms[0].cmdPhoto.disabled=false;
}

function callLink(page,bean,method)
{	
	if (document.forms[0].cmdsave.disabled)
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
function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		if(document.forms[0].hidModuleName.value=="P")
		{
			document.forms[0].hidAppType.value="";
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getDemographics";
			document.forms[0].hidSourceUrl.value="/action/perapplicant.jsp";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();
		}
		else
		{
			document.forms[0].hidAppType.value="";
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getDemographics";
			document.forms[0].hidSourceUrl.value="/action/ops_applicant.jsp";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();
		}
	}
}

function doDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{	
		document.forms[0].method="post";
		document.forms[0].hidAppType.value="";
		document.forms[0].hidBeanGetMethod.value="deleteDemographics";
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].action=appURL+"action/mastersearchper.jsp";
		document.forms[0].submit();
	}
}

function doModify()
{
	document.forms[0].method="post";
	document.forms[0].hidAppType.value="";
	document.forms[0].hidBeanMethod.value="renewApplicantData";
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/perapplicant.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDemographics";
	document.forms[0].submit();
}

function showPhoto()
{
	var varperapp_id = document.forms[0].txtperapp_appid.value;
}

function callCalender(name)
	{
	if(document.forms[0].cmdsave.disabled==false)
		{
		showCal(appURL,name);
		}
	}
	function callCalender1(name)
	{
	if(document.forms[0].cmdsave.disabled==false)
		{
		showCal(appURL,name);
		}
	}

function enableSince()
{
	if(document.forms[0].selbank.value == "1")
	{
		document.all.s1.style.visibility="visible";
		document.all.s1.style.position="relative";
		document.all.s2.style.visibility="visible";
		document.all.s2.style.position="relative";
		
		if(document.forms[0].txt_perappconstitution.value=="001" || document.forms[0].txt_perappconstitution.value=="002")
		{
			document.all.b1.style.visibility="visible";
			document.all.b1.style.position="relative";
			document.all.b2.style.visibility="visible";
			document.all.b2.style.position="relative";
			
			
		}
		else
		{
			document.all.b1.style.visibility="hidden";
			document.all.b1.style.position="absolute";
			document.all.b2.style.visibility="hidden";
			document.all.b2.style.position="absolute";
		}
	}
	else
	{
		document.all.s1.style.visibility="hidden";
		document.all.s1.style.position="absolute";
		document.all.s2.style.visibility="hidden";
		document.all.s2.style.position="absolute";
		
		document.all.b1.style.visibility="hidden";
		document.all.b1.style.position="absolute";
		document.all.b2.style.visibility="hidden";
		document.all.b2.style.position="absolute";
	}
}

function enablereg()
{
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

function doNRIDetails()
{
	var hid_comappid1= document.forms[0].hid_comappid1.value;
	var purl = appURL+"action/nridetails.jsp?hidBeanGetMethod=getnriData&hidBeanId=refdetails&hid_comappid1="+hid_comappid1;
	var prop = 'scrollbars=yes,width=800,height=500';	
	var xpos = (screen.width - 800) / 2;
	var ypos = (screen.height - 800) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);
}

function doReferences()
{
	var hid_comappid1= document.forms[0].hid_comappid1.value;
	//alert(hid_comappid1);
	var purl = appURL+"action/perreferences.jsp?hidBeanGetMethod= getrefData&hidBeanId=refdetails&hid_comappid1="+hid_comappid1+"&hidapp_name="+document.forms[0].txtperapp_fname.value;
	var prop = 'scrollbars=no,width=800,height=400,menubar=yes';	
	var xpos = (screen.width - 800) / 2;
	var ypos = (screen.height - 800) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);
}

function getdirectordetails()
{
	if(document.forms[0].txtperapp_apptitle.value=="M/S")
	{
		document.all.m1.style.visibility="visible";
		document.all.m1.style.position="relative";
	}
	else
	{
		document.all.m1.style.visibility="hidden";
		document.all.m1.style.position="absolute";
	}
}

function callsupnam1()
{	if(document.forms[0].cmdsave.disabled==false)
	{
	var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
	var url=appURL+"action/occupationlist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getOccupationMasterList&strfrom=Customer";
	window.open(url,"",prop);
	}
}


function showBranch()
{
	if(document.forms[0].selbuss.value=="0")
	{
		document.all.t5.style.visibility="visible";
		document.all.t6.style.visibility="visible";
		document.all.r1.style.visibility="visible";
		document.all.r2.style.visibility="visible";
		
	}
    if(document.forms[0].selbuss.value=="1") 
	{
		document.all.t5.style.visibility="hidden";		
		document.all.t6.style.visibility="hidden";
		document.all.r1.style.visibility="hidden";
		document.all.r2.style.visibility="hidden";
		document.forms[0].txtrelativedetails.value="";
		document.forms[0].txtperapp_branch.value="";
	}
}
function showcoun()
{
	if(document.forms[0].selstatus.value=="2")
	{
		document.all.cy1.style.visibility="visible";
		document.all.cy1.style.position="relative";				
		document.all.cy2.style.visibility="visible";
		document.all.cy2.style.position="relative";		
		document.all.cy3.style.visibility="visible";
		document.all.cy3.style.position="relative";				
		document.all.cy4.style.visibility="visible";
		document.all.cy4.style.position="relative";		
	}
	else 
	{
		document.all.cy1.style.visibility="hidden";	
		document.all.cy1.style.position="absolute";		
		document.all.cy2.style.visibility="hidden";
		document.all.cy2.style.position="absolute";	
		document.all.cy3.style.visibility="hidden";	
		document.all.cy3.style.position="absolute";		
		document.all.cy4.style.visibility="hidden";
		document.all.cy4.style.position="absolute";	
		document.forms[0].txt_dateofNRI.value="";
		document.forms[0].txt_country.value="";
	}
	
}
function shownri()
{
	
	if(document.forms[0].selstatus.value=="2")
	{
		document.forms[0].cmdNridetails.style.visibility="visible";
		document.forms[0].cmdNridetails.style.position="relative";
		document.all.p1.style.visibility="visible";
		document.all.p2.style.visibility="visible";
		document.all.pID.style.visibility="visible";
		document.all.pED.style.visibility="visible";
	}
	else if(document.forms[0].selstatus.value=="1")
	{
		document.forms[0].cmdNridetails.style.visibility="hidden";
		document.forms[0].cmdNridetails.style.position="absolute";
		document.all.p1.style.visibility="hidden";
		document.all.p1.style.position="absolute";
		document.all.p2.style.visibility="hidden";
		document.all.p2.style.position="absolute";
		document.all.pID.style.visibility="hidden";
		document.all.pID.style.position="absolute";
		document.all.pED.style.visibility="hidden";
		document.all.pED.style.position="absolute";
		
	}
	else 
	{
		document.forms[0].cmdNridetails.style.visibility="hidden";
		document.forms[0].cmdNridetails.style.position="absolute";
		document.all.p1.style.visibility="hidden";
		document.all.p1.style.position="absolute";
		document.all.p2.style.visibility="hidden";
		document.all.p2.style.position="absolute";
		document.all.pID.style.visibility="hidden";
		document.all.pID.style.position="absolute";
		document.all.pED.style.visibility="hidden";
		document.all.pED.style.position="absolute";
		document.forms[0].txtperapp_passportexpirydate.value="";
		document.forms[0].txtperapp_passportissuedate.value="";
		document.forms[0].txtperapp_passissue.value="";
		document.forms[0].txtperapp_passport.value="";
		
	}
} 



function showres()
{

if(document.forms[0].sel_residence.value=="2")
	{
		document.all.d1.style.visibility="visible";		
		document.all.d2.style.visibility="visible";	
		document.all.c1.style.visibility="visible";
		document.all.c2.style.visibility="visible";
	}

	else 
	{
		document.all.d1.style.visibility="hidden";		
		document.all.d2.style.visibility="hidden";
		document.all.c1.style.visibility="hidden";    
		document.all.c2.style.visibility="hidden"; 
		document.forms[0].txt_purchasedate.value="";
		document.forms[0].txt_cost_res.value=""; 
	}
}

function getlocationvalues()
{
	if(document.forms[0].sel_transferrable.value=="1")
	{
		document.all.sel1.style.visibility="visible";
		document.all.sel1.style.position="relative";
	}
	else 
	{
		document.all.sel1.style.visibility="hidden";
		document.all.sel1.style.position="relative";
	}
}



function showBranch1()
{	
	if(document.forms[0].cmdsave.disabled==false)
	{
		var purl = appURL+"action/branchdet.jsp?hidBeanGetMethod=getOrgList&hidBeanId=mastapplicant&strfrom=Branch";
		var prop = 'scrollbars=no,width=470,height=450';	
		var xpos = (screen.width - 450) / 2;
		var ypos = (screen.height - 450) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);
	}
}

function callCard()
{
    var hid_comappid1= document.forms[0].hid_comappid1.value;
    var purl=appURL+"action/perappcreditcards.jsp?hidBeanGetMethod=getcardData&hidBeanId=carddetails&hid_comappid1="+hid_comappid1;
	var prop = 'scrollbars=no,width=770,height=400';	
	var xpos = (screen.width - 770) / 2;
	var ypos = (screen.height - 770) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);
}

function doPartners()
{
	var hid_comappid2= document.forms[0].hid_comappid2.value;
	var purl = appURL+"action/perdirectors.jsp?hidBeanId=refdetails&hidBeanGetMethod=getPartnerDetailsData&hid_comappid2="+hid_comappid2+"&hidapp_name="+document.forms[0].txtperapp_fname.value;
	var prop = 'scrollbars=yes,width=850,height=525';	
	var xpos = (screen.width - 750) / 2;
	var ypos = (screen.height - 1000) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);
}

function checkfiledate(obj)
{
	var pagedate=obj.value;
	var pgdt=pagedate.substring(0,2);
	var pgmon=pagedate.substring(3,5);
	var pgyear=pagedate.substring(6,10);
	var pgdt=pgmon+"/"+pgdt+"/"+pgyear;
	var currentdt=currdate;
	
	var curdt=currentdt.substring(0,2);
	var curmon=currentdt.substring(3,5);
	var curyear=currentdt.substring(6,10);
	var curdt=curmon+"/"+curdt+"/"+curyear;
	if(document.forms[0].txtperapp_passportissuedate.value!=""){
		if(Date.parse(pgdt) > Date.parse(curdt))
		{
			alert("Passport Issue date should be Less than CurrentDate");
			document.forms[0].txtperapp_passportissuedate.value="";
			document.forms[0].txtperapp_passportissuedate.focus();
		}
		else
		{
			document.forms[0].txtperapp_passportexpirydate.focus();
		}
	}
}

function checkfiledate1(obj)
{
	var pagedate=obj.value;
	var pgdt=pagedate.substring(0,2);
	var pgmon=pagedate.substring(3,5);
	var pgyear=pagedate.substring(6,10);
	var pgdt=pgmon+"/"+pgdt+"/"+pgyear;
	var currentdt=document.forms[0].txtperapp_passportissuedate.value;
	if(document.forms[0].txtperapp_passport.value != ""){
		if(currentdt!="")
		{
			var curdt=currentdt.substring(0,2);
			var curmon=currentdt.substring(3,5);
			var curyear=currentdt.substring(6,10);
			var curdt=curmon+"/"+curdt+"/"+curyear;
			if(document.forms[0].txtperapp_passportissuedate.value!="" && document.forms[0].txtperapp_passportexpirydate.value!=""){
				if(Date.parse(pgdt) < Date.parse(curdt))
				{
					alert("Passport Expiry date should not be Less than Passport Issue Date");
					document.forms[0].txtperapp_passportexpirydate.value="";
					document.forms[0].txtperapp_passportexpirydate.focus();
				} 
			}
		}
	 	else
		{
			alert("Enter the Passport Issue Date");
			document.forms[0].txtperapp_passportissuedate.focus();
		}
	}
}

function getpmadd()
{
    if(document.forms[0].chk_perm_add.checked)
	{ 
     	document.forms[0].txtperapp_permadd1.value=document.forms[0].txtperapp_address1.value; 
	  	document.forms[0].txtperapp_permadd2.value=document.forms[0].txtperapp_address2.value;
      	document.forms[0].txtperapp_permadd3.value=document.forms[0].txtperapp_address3.value;
      	document.forms[0].txtperapp_permcity.value=document.forms[0].txtperapp_city.value;
      	document.forms[0].txtperapp_permstate.value=document.forms[0].txtperapp_state.value;
       	document.forms[0].hidcity1.value=document.forms[0].hidcity.value;
      	document.forms[0].hidstate1.value=document.forms[0].hidstate.value;
      	document.forms[0].txtperapp_permzip.value=document.forms[0].txtperapp_zip.value;
      	document.forms[0].txtperapp_permcountry.value=document.forms[0].txtperapp_country.value;
 	  	document.forms[0].txtperapp_permphone.value=document.forms[0].txtperapp_phone.value;  
 	  	document.forms[0].hidPermCity.value=document.forms[0].hidcity.value;
      	document.forms[0].txtperapp_permadd1.readOnly=true;
      	document.forms[0].txtperapp_permadd2.readOnly=true;
      	document.forms[0].txtperapp_permadd3.readOnly=true;
      	document.forms[0].txtperapp_permcity.readOnly=true;
      	document.forms[0].txtperapp_permstate.readOnly=true;
      	document.forms[0].txtperapp_permzip.readOnly=true;
      	document.forms[0].txtperapp_permcountry.readOnly=true;
      	document.forms[0].txtperapp_permphone.readOnly=true;
   	}
   	else
   	{
      	document.forms[0].txtperapp_permadd1.value="";
      	document.forms[0].txtperapp_permadd2.value="";
      	document.forms[0].txtperapp_permadd3.value="";
      	document.forms[0].txtperapp_permcity.value="";
      	document.forms[0].txtperapp_permstate.value="";
      	document.forms[0].txtperapp_permzip.value="";
      	document.forms[0].txtperapp_permcountry.value="";
      	document.forms[0].txtperapp_permphone.value="";
      	document.forms[0].hidcity1.value="";
      	document.forms[0].hidstate1.value="";
      	document.forms[0].txtperapp_permadd1.readOnly=false;
      	document.forms[0].txtperapp_permadd2.readOnly=false;
      	document.forms[0].txtperapp_permadd3.readOnly=false;
      	document.forms[0].txtperapp_permcity.readOnly=true;
      	document.forms[0].txtperapp_permstate.readOnly=true;
      	document.forms[0].txtperapp_permzip.readOnly=false;
      	document.forms[0].txtperapp_permcountry.readOnly=false;
      	document.forms[0].txtperapp_permphone.readOnly=false;
    }
}

function callCustomer()
{
	document.forms[0].hidBeanId.value="FinacleBean";
	document.forms[0].hidBeanGetMethod.value="CustomerProfile";
	document.forms[0].action=appURL+"action/perapplicant.jsp";
	document.forms[0].submit();
}

function ShowAdditionalParameter(page)
{					
	var appid=document.forms[0].hidDemoId.value;
	var cbsid=document.forms[0].hidCBSId.value;
	var purl ="<%=ApplicationParams.getAppUrl()%>action/additionalParameter.jsp?hidBeanGetMethod=getadditionalParameter&hidBeanId=additionalParameter&hidAppType=R&hidDemoId="+appid+"&hidCBSId="+cbsid;		
	var prop = 'scrollbars=yes,menubar=no,width=575,height=350';	
	var xpos = (screen.width - 775) / 2;
	var ypos = (screen.height - 520) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);		
}

function showCitySearch(varTextControl,varTextControl1,varHidControl,varHidControl1,varTextControl2,varHidControl2)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = "<%=ApplicationParams.getAppUrl()%>action/searchCity.jsp?hidcitycontrol="+varTextControl+"&hidstatecontrol="+varTextControl1+"&hidcitycodecontrol="+varHidControl+"&hidstatecodecontrol="+varHidControl1+"&hidzipcontrol="+varTextControl2+"&hidzipvaildatorcontrol="+varHidControl2;
		var title = "City";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}	
}
function showStaffBox()
{
	if(document.forms[0].sel_istaff.value=="Y")
	{
		document.all.staff.style.visibility="visible";
		document.all.staff.style.position="relative";
		document.all.staff1.style.visibility="visible";
		document.all.staff1.style.position="relative";
		document.all.staff2.style.visibility="visible";
		document.all.staff2.style.position="relative";
	}
	else 
	{
		document.all.staff.style.visibility="hidden";
		document.all.staff.style.position="absolute";
		document.all.staff1.style.visibility="hidden";
		document.all.staff1.style.position="absolute";
		document.all.staff2.style.visibility="hidden";
		document.all.staff2.style.position="absolute";
		document.forms[0].txt_dateofjoining.value="";
		document.forms[0].txt_confirmationdate.value="";
		document.forms[0].txt_Userid.value="";
		document.forms[0].txt_nomineepf.value="";
		document.forms[0].txt_pfrelation.value="";
		document.forms[0].txt_nomineegratuity.value="";
		document.forms[0].txt_gratuityrelation.value="";
		document.forms[0].txt_servicerecord.value="";
	}
}

function showBusiness()
{	
	if(document.forms[0].txt_perappconstitution.value!="001" && document.forms[0].txt_perappconstitution.value!="002")
	{
		if(document.forms[0].select_Occupation.value=="1" || document.forms[0].select_Occupation.value=="2" 
			|| document.forms[0].select_Occupation.value=="3" || document.forms[0].select_Occupation.value=="9" 
			|| document.forms[0].select_Occupation.value=="10" )
		{
			alert('Selected Option is irrelevant to the constitution');
			document.forms[0].select_Occupation.value="0";
			document.forms[0].select_Occupation.focus();
			return;
		}
		else if(document.forms[0].select_Occupation.value=="11")
		{
			document.all.ser1.style.visibility="hidden";
			document.all.ser1.style.position="absolute";
			document.all.ser2.style.visibility="hidden";
			document.all.ser2.style.position="absolute";
		}
	}
	else
	{
		if((document.forms[0].select_Occupation.value=="2")||(document.forms[0].select_Occupation.value=="11"))
		{
			document.forms[0].sel_transferrable.value="2";
			document.forms[0].sel_istaff.value="N";
			document.all.busi.style.visibility="hidden";
			document.all.busi.style.position="absolute";		
			document.all.sel1.style.visibility="hidden";
			document.all.sel1.style.position="absolute";
			document.all.emp1.style.visibility="hidden";
			document.all.emp1.style.position="absolute";
			document.all.emp2.style.visibility="hidden";
			document.all.emp2.style.position="absolute";
			document.all.p4.style.visibility="hidden";
			document.all.p5.style.visibility="hidden";
			document.all.p4.style.position="absolute";
			if(document.forms[0].select_Occupation.value=="2")
			{
				document.all.ser1.style.visibility="visible";
				document.all.ser1.style.position="relative";
				document.all.ser2.style.visibility="visible";
				document.all.ser2.style.position="relative";
			}
			else
			{
				document.all.ser1.style.visibility="hidden";
				document.all.ser1.style.position="absolute";
				document.all.ser2.style.visibility="hidden";
				document.all.ser2.style.position="absolute";
			}
			document.forms[0].txtperapp_pension.value="";
			showStaffBox();
		}
		else if(document.forms[0].select_Occupation.value=="1")
		{
			document.all.busi.style.visibility="visible";
			document.all.busi.style.position="relative";
			document.all.sel1.style.visibility="visible";
			document.all.sel1.style.position="relative";
			document.all.emp1.style.visibility="visible";
			document.all.emp1.style.position="relative";
			document.all.emp2.style.visibility="visible";
			document.all.emp2.style.position="relative";
			
			document.all.p4.style.visibility="hidden";
			document.all.p5.style.visibility="hidden";
			document.all.p4.style.position="absolute";
			document.forms[0].txtperapp_pension.value="";
			
			document.all.ser1.style.visibility="visible";
			document.all.ser1.style.position="relative";
			document.all.ser2.style.visibility="visible";
			document.all.ser2.style.position="relative";
		}
		else if(document.forms[0].select_Occupation.value=="9")
		{
			document.all.busi.style.visibility="hidden";
			document.all.busi.style.position="absolute";
			document.all.emp1.style.visibility="hidden";
			document.all.emp1.style.position="absolute";
			document.all.emp2.style.visibility="hidden";
			document.all.emp2.style.position="absolute";
			document.forms[0].sel_istaff.value="N";
			document.forms[0].sel_transferrable.value="2";
			document.all.p4.style.visibility="visible";
			document.all.p5.style.visibility="visible";
			document.all.p4.style.position="relative";
			document.forms[0].txt_expyrs.value="";
			document.all.ser1.style.visibility="hidden";
			document.all.ser1.style.position="absolute";
			document.all.ser2.style.visibility="hidden";
			document.all.ser2.style.position="absolute";
			showStaffBox();
		}
		else
		{
			document.all.busi.style.visibility="visible";
			document.all.busi.style.position="relative";
			document.all.sel1.style.visibility="visible";
			document.all.sel1.style.position="relative";
			document.all.emp1.style.visibility="hidden";
			document.all.emp1.style.position="absolute";
			document.all.emp2.style.visibility="hidden";
			document.all.emp2.style.position="absolute";
			document.forms[0].sel_istaff.value="N";
			document.all.p4.style.visibility="hidden";
			document.all.p5.style.visibility="hidden";
			document.all.p4.style.position="absolute";
			document.forms[0].txtperapp_pension.value="";
			
			if(document.forms[0].select_Occupation.value=="3")
			{
				document.all.ser1.style.visibility="visible";
				document.all.ser1.style.position="relative";
				document.all.ser2.style.visibility="visible";
				document.all.ser2.style.position="relative";
			}
			else
			{
				document.forms[0].txt_expyrs.value="";
				document.all.ser1.style.visibility="hidden";
				document.all.ser1.style.position="absolute";
				document.all.ser2.style.visibility="hidden";
				document.all.ser2.style.position="absolute";	
			}
			showStaffBox();
		}
	}
}

function checkvalues(objName1)
{
    var Issuedate=objName1.value;
    var currdate = currentDate;
	var crdt = currdate.substring(0,2);
	var crmon = currdate.substring(3,5);
	var cryr = currdate.substring(6,10);
	var pgdt = Issuedate.substring(0,2);
	var pgmon = Issuedate.substring(3,5);
	var pgyr = Issuedate.substring(6,10);
	var Issue = pgyr+pgmon+pgdt ;	
	var curdate = cryr+crmon+crdt;	
	if(parseInt(Issue)>parseInt(curdate))
	{
		document.forms[0].txt_purchasedate.value="";
		alert("Purchase Date Should be less than Current Date");
		return;
	}
}

function showYearsOfService()
{ 
	if(document.forms[0].selExService.value=="Y" && (document.forms[0].txt_perappconstitution.value=="001" || document.forms[0].txt_perappconstitution.value=="002"))
	{
		document.all.y1.style.visibility="visible";
		document.all.y2.style.visibility="visible";
	}
	else
	{
		document.all.y1.style.visibility="hidden";
		document.all.y2.style.visibility="hidden";
		document.forms[0].txt_yrs_service.value="0";
	}
}

function getPhoto()
{
	if(document.forms[0].readFlag.value.toUpperCase()=="W")
	{
	    var varCustomerId = document.forms[0].hidDemoId.value;
	    var hidType = "photo";
	    if(varCustomerId!="")
	    {
			var hid_comappid1= document.forms[0].hid_comappid1.value;
			var purl = appURL+"action/ifrmapplicantphoto.jsp?&hidApplicantId="+varCustomerId+"&hidType="+hidType;
		    var prop = 'scrollbars=no,width=300,height=250,menubar=no';	
			var xpos = (screen.width - 800) / 2;
			var ypos = (screen.height - 800) / 2;
			prop = prop + ",left="+xpos+",top="+ypos;
			window.open(purl,'AttachPhoto',prop);
		}
		else
		{
			alert("Please Create the customer");
		}
	}	
}

function showPanex(val)
{
	if(val=="y")
	{
		document.all.panexample.style.visibility="visible";
	}
	else if(val =="n")
	{
		document.all.panexample.style.visibility="hidden";
	}	
}
		
function showPanex1(val)
{
	if(val=="y")
	{
		document.all.panexample1.style.visibility="visible";
	}
	else if(val =="n")
	{
		document.all.panexample1.style.visibility="hidden";
	}	
}	


function showinland()
{
	if(document.forms[0].sel_trade.value=='2')
	{
		document.all.trade1.style.visibility="hidden";
		document.all.trade2.style.visibility="hidden";
	}
	else
	{
		document.all.trade1.style.visibility="visible";
		document.all.trade2.style.visibility="visible";
	}
}

function showguardian()
{
	if(document.forms[0].sel_minor.value=='2')
	{
		document.all.g1.style.visibility="hidden";
		document.all.g2.style.visibility="hidden";
		document.all.f1.style.visibility="hidden";
		document.all.f2.style.visibility="hidden";
		document.all.gn1.style.visibility="hidden";
		document.all.gn2.style.visibility="hidden";
		document.all.g1.style.position="absolute";
		document.all.g2.style.position="absolute";
		document.all.f1.style.position="absolute";
		document.all.f2.style.position="absolute";
		document.all.gn1.style.position="absolute";
		document.all.gn2.style.position="absolute";
		document.forms[0].txt_relation.value="";
		document.forms[0].txt_guardian.value="";
		document.forms[0].txt_guardianame.value="";
	}
	else
	{
		document.all.g1.style.visibility="visible";
		document.all.g2.style.visibility="visible";
		document.all.f1.style.visibility="visible";
		document.all.f2.style.visibility="visible";
		document.all.gn1.style.visibility="visible";
		document.all.gn2.style.visibility="visible";
		document.all.g1.style.position="relative";
		document.all.g2.style.position="relative";
		document.all.f1.style.position="relative";
		document.all.f2.style.position="relative";
		document.all.gn1.style.position="relative";
		document.all.gn2.style.position="relative";
	}
}

function screenCaptured()
{
	if(document.forms[0].txt_perappconstitution.value=="001" || document.forms[0].txt_perappconstitution.value=="002")
	{
		if(document.forms[0].txtperapp_apptitle.value!="M/S")
		{
			document.all["fat"].style.visibility="visible";
			document.all["fat"].style.position="relative";
			document.all["txtperapp_fatname"].style.visibility="visible";
			document.all["txtperapp_fatname"].style.position="relative";
			document.all["maritial"].style.visibility="visible";
			document.all["maritial"].style.position="relative";
			document.all["choperapp_marstat"].style.visibility="visible";
			document.all["choperapp_marstat"].style.position="relative";
			document.all["place"].style.visibility="visible";
			document.all["place"].style.position="relative";
			document.all["txt_placeofdomicile"].style.visibility="visible";
			document.all["txt_placeofdomicile"].style.position="relative";
			document.all["resident"].style.visibility="visible";
			document.all["resident"].style.position="relative";
			document.all["relatives"].style.visibility="visible";
			document.all["relatives"].style.position="relative";
			document.all["minor"].style.visibility="visible";
			showguardian();
			document.all["spouse"].style.visibility="visible";
			document.all["spouse"].style.position="relative";
			document.all["depend"].style.visibility="visible";
			document.all["depend"].style.position="relative";
			
			if(document.forms[0].sel_salaryrooted.value=="1")
			{
				document.all.b1.style.visibility="visible";
				document.all.b1.style.position="relative";
				document.all.b2.style.visibility="visible";
				document.all.b2.style.position="relative";
			}		
		
			document.all["area"].style.visibility="visible";
			document.all["area"].style.position="relative";
			document.all["txt_area_spec"].style.visibility="visible";
			document.all["txt_area_spec"].style.position="relative";
			document.all.db.innerHTML='Date of Birth<b><span class="mantatory">*&nbsp;</span</b>';
			showBranch();
		}
		else
		{
			alert('Irrelavant Option for the title selected');
			document.forms[0].txt_perappconstitution.value="0";
			return;
		}
	}
	else if(document.forms[0].txt_perappconstitution.value!=0)
	{
		if(document.forms[0].txtperapp_apptitle.value=="M/S")
		{
			document.all.db.innerHTML='Date of Establishment/ Incorporation<b><span class="mantatory">*</span></b>';
			document.all["fat"].style.visibility="hidden";
			document.all["fat"].style.position="absolute";
			document.all["txtperapp_fatname"].style.visibility="hidden";
			document.all["txtperapp_fatname"].style.position="absolute";
			document.all["maritial"].style.visibility="hidden";
			document.all["maritial"].style.position="absolute";
			document.forms[0].choperapp_marstat.value="S";
			document.all["choperapp_marstat"].style.visibility="hidden";
			document.all["choperapp_marstat"].style.position="absolute";
			document.all["place"].style.visibility="hidden";
			document.all["place"].style.position="absolute";
			document.forms[0].txt_placeofdomicile.value="";
			document.all["txt_placeofdomicile"].style.visibility="hidden";
			document.all["txt_placeofdomicile"].style.position="absolute"; 
			document.forms[0].select_Occupation.value="0";
			document.forms[0].sel_transferrable.value="2";
			document.forms[0].sel_istaff.value="N";
			document.all.busi.style.visibility="hidden";
			document.all.busi.style.position="absolute";		
			document.all.sel1.style.visibility="hidden";
			document.all.sel1.style.position="absolute";
			document.all.emp1.style.visibility="hidden";
			document.all.emp1.style.position="absolute";
			document.all.emp2.style.visibility="hidden";
			document.all.emp2.style.position="absolute";
			document.all.p4.style.visibility="hidden";
			document.all.p5.style.visibility="hidden";
			document.all.p4.style.position="absolute";
			document.forms[0].txtperapp_pension.value="";
			showStaffBox();
			document.all["resident"].style.visibility="hidden";
			document.all["resident"].style.position="absolute";
			document.forms[0].selstatus.value="0";
			showcoun();
			shownri();
			document.all["relatives"].style.visibility="hidden";
			document.all["relatives"].style.position="absolute";
			document.all["minor"].style.visibility="hidden";
			document.forms[0].sel_minor.value="2";
			
			showguardian();
			document.all["spouse"].style.visibility="hidden";
			document.all["spouse"].style.position="absolute";
			document.all["depend"].style.visibility="hidden";
			document.all["depend"].style.position="absolute";
			document.forms[0].txtperapp_spincome.value="";
			document.forms[0].txtperapp_sppan.value="";
			document.forms[0].txtperapp_spemail.value="";
			document.forms[0].txtperapp_occupation.value="0";
			document.forms[0].txtperapp_husname.value="";
		
			document.all.b1.style.visibility="hidden";
			document.all.b1.style.position="absolute";
			document.all.b2.style.visibility="hidden";
			document.all.b2.style.position="absolute";
			document.forms[0].sel_salaryrooted.value="2";
			
			document.all["area"].style.visibility="hidden";
			document.all["area"].style.position="absolute";
			document.all["txt_area_spec"].style.visibility="hidden";
			document.all["txt_area_spec"].style.position="absolute";
			document.forms[0].selbuss.value="1";
			showBranch();
		}
		else
		{
			alert('Irrelavant Option for the title selected');
			document.forms[0].txt_perappconstitution.value="0";
			return;
		}
	
	
	}	
	if((document.forms[0].txtperapp_apptitle.value =="M/S") && (document.forms[0].txt_perappconstitution.value=="006" || document.forms[0].txt_perappconstitution.value=="005"))
	{
		for(var i=0;i<2;i++)
		{
			document.all.cons[i].style.visibility="visible";
			document.all.cons[i].style.position="relative";
		}
	}	
	else
	{
		for(var i=0;i<2;i++)
		{
			document.all.cons[i].style.visibility="hidden";
			document.all.cons[i].style.position="absolute";
		}
	}
}


function callCntrySearch(varTextControl,varHidControl)
{	
	if(document.forms[0].cmdedit.disabled)
	{
		var varQryString = appURL+"action/searchCountry.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getCountrySearchList"+"&hidcntrycontrol="+varTextControl+"&hidcntrycodecontrol="+varHidControl;
		var title = "Country";
		var prop = "scrollbars=no,width=750,height=500";	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);	
	}
}

function checkpanno(field)
{
	var panvaluetemp=field.value;
	var panvalue=panvaluetemp.toUpperCase();
	field.value=panvalue;
	var regExp = /^[A-Z]$/;	
	var regExpnum = /^[0-9]$/;	

	if(panvalue!="")
	{
		if(panvalue.length==5 && panvalue=="NOPAN")
		{
			return;
		}
		else if(panvalue.length!=10)
		{
			alert('Enter NOPAN, if PANNO not available or else enter correct PANNO');
			field.value="";
			field.focus();
			return;
		}
		
		else
		{
			for(var si=0;si<5;si++)
			{
				if (!panvalue.charAt(si).match(regExp))
				{
					alert('FIRST FIVE Characters should be ALPHABETS');
					field.value="";
					field.focus();
					break;
				}
				
			}
			for(var si=5;si<9;si++)
			{
				if (!panvalue.charAt(si).match(regExpnum))
				{
					alert('SIXTH TO NINTH CHARACTER MUST BE NUMBER');
					field.value="";
					field.focus();
					break;
				}
			}
			
			if(panvalue.length==10 && !(panvalue.charAt(9).match(regExp)))
			{
				alert('LAST character must be ALPHABET');
				field.value="";
				field.focus();
				return;
			}
	    	if(panvalue.length >= 5 && panvalue.substring(0,5)=='NOPAN')
			{
			  alert('Enter NOPAN only');
			  field.value="";
			  field.focus();
			  return;
			}
		}
	}
}
function fnSearchinwardno()
{	
	var varCustprofile="CUSPROFILE";
	if(document.forms[0].cmdsave.disabled==false)
	{
		if(varCateType=="RET")
		{
			varcategory="p";
		} 
		else if(varCateType=="AGR")
		{
			varcategory="a";
		}
		else if(varCateType=="LAD")
		{
			varcategory="LAD";
		}
		var varQryString = appURL+"action/searchAppinwradno.jsp?hidBeanId=inwardRegister&hidBeanGetMethod=getInwardnoSearchList&Category="+varcategory+"&Cusprofile="+varCustprofile;
		var title = "Acknowledgement";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
}
</SCRIPT>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>

<table width="100%" border="1" cellspacing="0" cellpadding="3"
	align="center" class="outertable">
	<tr >
		<td>
		<table width="100%" align="center" cellpadding="0" cellspacing="0" class="outertable">
		<tr>
		<td width="30%"><b>To copy the data from INWARD REGISTER</b></td>
		<td width="70%"><a href="#"
									onClick="fnSearchinwardno()"
									style="cursor:hand" tabindex="15"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0" tabindex="81"></a></td>
		</tr> 
		</table>
		</td>
	</tr>
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr class="dataheader">
				<td width="11%" align="center">Applicant ID</td>
				<td width="16%" align="center">CBS Customer ID</td>
				<td align="center" width="13%">Title</td>
				<td width="24%" align="center">Full Name <b><span class="mantatory">*&nbsp;</span></b></td>
				<td width="18%" align="center">Short Name</td>
				<td width="18%" align="center" id="fat">Father/Husband Name</td>
			</tr>
			<tr  align="center">
				<td width="11%"><input type="text" name="txtperapp_appid" size="12"
					maxlength="9" tabindex="1" readOnly
					value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>"
					onKeyPress="allowInteger()"></td>
				<td width="16%"><input type="text" name="txtcbs_id" size="17"
					maxlength="9" tabindex="2"
					value="<%=Helper.correctNull((String)hshValues.get("perapp_cbsid"))%>"
					onKeyPress="allowInteger()"></td>
				<td valign="top" width="13%"><select name="txtperapp_apptitle"
					tabindex="3" onchange="getes();">
					<option value="MR" selected>MR.</option>
					<option value="MS">MS.</option>
					<option value="MRS">MRS.</option>
					<option value="M/S">M/S.</option>
				</select> </td>
				<td width="24%"><input type="text" name="txtperapp_fname" size="35"
					maxlength="80" tabindex="4"
					value="<%=Helper.correctNull((String)hshValues.get("perapp_fname"))%>"
					onKeyPress="notAllowSplChar()"></td>
				<td width="18%"><input type="text" name="txtperapp_lname" size="17"
					maxlength="9" tabindex="5"
					value="<%=Helper.correctNull((String)hshValues.get("perapp_lname"))%>"
					onKeyPress="notAllowSplChar()"></td>
				<td width="18%"><input type="text" name="txtperapp_fatname"
					size="30" maxlength="50" tabindex="6"
					value="<%=Helper.correctNull((String)hshValues.get("perapp_fatname"))%>"
					onKeyPress="notAllowSplChar()"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="1" cellspacing="0" cellpadding="3"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
			<tr>
				<td valign="top" width="25%">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td valign="top" width="37%">
						<table width="96%" border="0" cellspacing="0" cellpadding="5" class="outertable">
							<tr>
								<td colspan="3"><b>Personal Details</b></td>
							</tr>
							<tr>
								<td width="40%">Constitution <b><span class="mantatory">*&nbsp;</span></b></td>
								<td colspan="2"><select name="txt_perappconstitution"
									tabindex="7" onChange="screenCaptured()">
									<option value="0">---Select-----</option>
									<%String apptypecon = "14";

			%>
									<lapschoice:StaticDataNewTag apptype='<%=apptypecon%>' />
								</select></td>
							</tr>
							<tr>
								<td width="40%">PAN /TAN/ GIR No.<span class="mantatory">*&nbsp;</span></td>
								<td colspan="2"><input type="text" name="txtperapp_panno"
									size="14" maxlength="10" tabindex="8"
									value="<%=Helper.correctNull((String)hshValues.get("perapp_panno"))%>"
									onBlur="checkpanno(this)"></td>
							</tr>
							<tr>
								<td id="db"> Date of Birth <b><span class="mantatory">*&nbsp;</span></b> </td>
								<td valign="top" width="0">
								<table border="0" cellspacing="0" cellpadding="3" width="40%" class="outertable">
									<tr>
										<td><input type="text" name="txtperapp_dob" size="12"
											maxlength="10" tabindex="9"
											value="<%=Helper.correctNull((String)hshValues.get("perapp_dob"))%>"
											onBlur="checkDate(this);checkmaxdate(this,currentDate);"></td>
										<td id="dbdate1"><a href="#"
											onClick="callCalender('txtperapp_dob')"
											title="Click to view calender" border=0><img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											width="0" border="0" tabindex="10"></a></td>
										<td id="dbdate2">&nbsp;(dd/mm/yyyy)</td>
									</tr>
								</table>
							</tr>
							<tr>
								<td id="sex">Sex<b><span class="mantatory">*&nbsp;</span></b></td>
								<td colspan="2"><select name="choperapp_sex" tabindex="11">
									<option value="0">--Select--</option>
									<option value="M">Male</option>
									<option value="F">Female</option>
									<option value="O">Others</option>
								</select></td>
							</tr>
							<tr>
								<td id="maritial">Marital Status <b><span class="mantatory">*&nbsp;</span></b></td>
								<td colspan="2"><select name="choperapp_marstat" tabindex="12">
									<option value="S">----Select----</option>
									<option value="1">Married</option>
									<option value="2">Single</option>
									<option value="3">Divorced</option>
									<option value="4">Widower</option>
									<option value="5">Other</option>
								</select></td>
							</tr>
							<tr>
								<td>Status<b><span class="mantatory">*&nbsp;</span></b></td>
								<td colspan="2"><select name="sel_istatus" tabindex="13"
									style="width:200px">
									<option value="0">&lt;--Select--&gt;</option>
									<%String apptype = "26";%>
									<lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
								</select></td>
							</tr>
							<tr>
								<td>E-mail</td>
								<td colspan="2"><input type="text" name="txtperapp_email"
									size="25" maxlength="50" tabindex="14"
									value="<%=Helper.correctNull((String)hshValues.get("perapp_email"))%>"
									onBlur="isEmailAddr(document.forms[0].txtperapp_email.value,document.forms[0].txtperapp_email)">
								</td>
							</tr>
							<tr>
								<td nowrap>Application Recd. From <b><span class="mantatory">*&nbsp;</span></b>
								</td>
								<td colspan="2"><INPUT type="hidden" name="select_loc"
									tabindex="13" style="width:200"> <input type="text"
									name="txt_perapporg" size="25"
									value="<%=Helper.correctNull((String)hshValues.get("perapp_orgname"))%>">
								<b><a href="#"
									onClick="showOrgSearch('<%=ApplicationParams.getAppUrl()%>','select_loc','txt_perapporg')"
									style="cursor:hand" tabindex="15"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0" tabindex="81"></a></b></td>
							</tr>
							<tr>
								<td id="reg1">Reg.No&nbsp;</td>
								<td id="reg" width="0"><input name="txt_regno" type="text"
									size="15" maxlength="20" tabindex="17"
									value="<%=Helper.correctNull((String)hshValues.get("perapp_regno"))%>">
								</td>
							</tr>
						<tr>
								<td id="cons">Company Identification Number(CIN)&nbsp;</td>
								<td id="cons" width="0"><input name="txt_cin" type="text"
									size="11" maxlength="10" tabindex="17"
									value="<%=Helper.correctNull((String)hshValues.get("perapp_cin"))%>">
								</td>
							</tr>
						</table>
						</td>
						<td width="63%">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
									<tr>
										<td>
										<table cellpadding="3" cellspacing="0" width="100%" border="0" class="outertable">
											<tr>
												<td colspan="2" id="busicommaddr"><b>Communication
												Address</b></td>
												<td colspan="4">
												<table width="90%" border="0" cellspacing="0"
													cellpadding="0" class="outertable">
													<tr>
														<td width="38%" nowrap><b>Permanent Address</b></td>
														<td width="62%"><input type="checkbox" name="chk_perm_add"
															value="checkbox" tabindex="27" style="border-style:none"
															onClick="getpmadd()"> Copy Communication
														Address</td>
													</tr>
												</table>
												</td>
												<td width="1%">&nbsp;</td>
											</tr>
											<tr>
												<td width="9%">Address<b><span class="mantatory">*&nbsp;</span></b></td>
												<td width="28%"><input type="text" name="txtperapp_address1"
													size="35" maxlength="50" tabindex="18"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_address1"))%>"
													onKeyPress="notAllowedDouble()"></td>
												<td valign="top" width="1%">&nbsp;</td>
												<td valign="top" colspan="2"><input type="text"
													name="txtperapp_permadd1" size="35" maxlength="50"
													tabindex="28" onKeyPress="notAllowedDouble()"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_permadd1"))%>">
												</td>
											</tr>
											<tr>
												<td align="center" width="9%">&nbsp;</td>
												<td width="28%"><input type="text" name="txtperapp_address2"
													size="35" maxlength="50" tabindex="19"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_address2"))%>"
													onKeyPress="notAllowedDouble()"></td>
												<td valign="top" width="1%">&nbsp;</td>
												<td valign="top" colspan="2"><input type="text"
													name="txtperapp_permadd2" size="35" maxlength="50"
													tabindex="29" onKeyPress="notAllowedDouble()"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_permadd2"))%>">
												</td>
											</tr>
											<tr>
												<td align="center" width="9%">Village/Taluk/Town</td>
												<td width="28%"><input type="text" name="txtperapp_address3"
													size="35" maxlength="50" tabindex="20"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_address3"))%>"
													onKeyPress="notAllowedDouble()"></td>
												<td valign="top" width="1%">&nbsp;</td>
												<td valign="top" colspan="2"><input type="text"
													name="txtperapp_permadd3" size="35" maxlength="50"
													tabindex="30" onKeyPress="notAllowedDouble()"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_permadd3"))%>">
												</td>
											</tr>
											<tr>
												<td width="9%">
												<div align="left">City <b><span class="mantatory">*&nbsp;</span></b></div>
												</td>
												<td width="28%"><input type="text" name="txtperapp_city"
													size="21" maxlength="20"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_city"))%>"
													onKeyPress="notAllowSplChar()"> <b><a href="#"
													onClick="showCitySearch('txtperapp_city','txtperapp_state','hidcity','hidstate','hidzip1','hidres1');showstate()"
													style="cursor:hand" tabindex="22"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="21"></a></b></td>
												<td width="1%">&nbsp;</td>
												<td width="30%"><input type="text" name="txtperapp_permcity"
													size="21" maxlength="20"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_permcity"))%>"
													onKeyPress="notAllowSplChar()"> <b><a href="#"
													onClick="showCitySearch('txtperapp_permcity','txtperapp_permstate','hidcity1','hidstate1','hidzip2','hidres2')"
													style="cursor:hand" tabindex="32"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="31"></a></b> 
												</td>
												<td rowspan="6" width="32%" valign="top" align="left"><iframe
													src="<%=ApplicationParams.getAppUrl()%>action/setphoto.jsp?hidBeanGetMethod=getdemographicsphoto&hidBeanId=mastapplicant&hidDemoId=<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>"
													id="idfrm1" leftmargin="0" topmargin="0" border="0"
													marginwidth="0" marginheight="0" width="140" height="160"
													scrolling="no" frameborder=no valign="top"></iframe></td>
											</tr>
											<tr>
												<td width="9%">State <b><span class="mantatory">*&nbsp;</span></b></td>
												<td width="28%"><input type="text" name="txtperapp_state"
													size="21" maxlength="25" tabindex="22"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_state"))%>"
													onKeyPress="notAllowSplChar()"
													onBlur="changecase(document.forms[0].txtperapp_state)"></td>
												<td width="1%">&nbsp;</td>
												<td width="30%"><input type="text"
													name="txtperapp_permstate" size="21" maxlength="20"
													tabindex="32"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_permstate"))%>"
													onKeyPress="notAllowSplChar()"
													onBlur="changecase(document.forms[0].txtperapp_permstate)">
												</td>
											<tr>
												<td width="9%">
												<div align="left"><%=ApplicationParams.getZipName()%><b><span class="mantatory">*&nbsp;</span></b></div>
												</td>
												<td width="28%"><input type="text" name="txtperapp_zip"
													size="12" maxlength="<%=ApplicationParams.getZipValue()%>"
													tabindex="23" style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_zip"))%>"
													onKeyPress="allowInteger()"
													onBlur="zipvalidate(this,'<%=ApplicationParams.getZipValue()%>')">
												</td>
												<td width="1%">&nbsp;</td>
												<td width="30%"><input type="text" name="txtperapp_permzip"
													size="12" maxlength="<%=ApplicationParams.getZipValue()%>"
													tabindex="33" style="text-align:left"
													"  value="<%=Helper.correctNull((String)hshValues.get("perapp_permzip"))%>"
													onKeyPress="allowInteger()"
													onBlur="zipvalidate(this,'<%=ApplicationParams.getZipValue()%>')">
												</td>
											</tr>
											<tr>
												<td nowrap width="9%">Country<span class="mantatory">*&nbsp;</span></td>
												<td width="28%"><input type="text" name="txtperapp_country"
													size="15" maxlength="15" tabindex="24"
													style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_countrydesc"))%>"
													onKeyPress="allowAlphabets()"> <input type="hidden"
													name="hidperapp_country"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_country"))%>">
												<b> <a href="#"
													onClick="callCntrySearch('txtperapp_country','hidperapp_country')"
													style="cursor:hand" tabindex="8"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="21"></a></b></td>
												<td width="1%">&nbsp;</td>
												<td width="30%"><input type="text"
													name="txtperapp_permcountry" size="15" maxlength="15"
													tabindex="34" style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_permcountrydesc"))%>"
													onKeyPress="allowAlphabets()"> <input type="hidden"
													name="hidperapp_permcountry"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_permcountry"))%>">
												<b> <a href="#"
													onClick="callCntrySearch('txtperapp_permcountry','hidperapp_permcountry')"
													style="cursor:hand" tabindex="8"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="21"></a></b></td>
											</tr>
											<tr>
												<td nowrap width="9%">Phone No.</td>
												<td width="28%"><input type="text" name="txtperapp_phone"
													size="20" maxlength="15" tabindex="25"
													style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_phone"))%>"
													onKeyPress="allowPhone()"></td>
												<td width="1%">&nbsp;</td>
												<td width="30%"><input type="text"
													name="txtperapp_permphone" size="20" maxlength="16"
													tabindex="35" style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_permphone"))%>"
													onKeyPress="allowInteger()"></td>
												<!-- <td></td>-->
											</tr>
											<tr>
												<td nowrap width="9%">Mobile No.</td>
												<td width="28%"><input type="text" name="txtperapp_mobile"
													size="15" maxlength="12" tabindex="26"
													style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_mobile"))%>"
													onKeyPress="allowPhone();"
													onChange="min_nos(document.forms[0].txtperapp_mobile,10)">
												</td>
												<td width="1%">&nbsp;</td>
												<td width="30%">&nbsp;</td>
												<!-- <td></td>-->
											</tr>
											<tr>
												<td nowrap width="9%">&nbsp;</td>
												<td width="28%">&nbsp;</td>
												<td width="1%">&nbsp;</td>
												<td width="30%">&nbsp;</td>
												<td width="21%" align="center"><input type="button"
													name="cmdPhoto" value="Get Photo"
													style="background-color:#8F8369;font-weight:bold;color:white;font-size:10px;font-family:mssansserif;width:80px;"
													onClick="getPhoto()" tabindex="22" /></td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
				<tr>
					<td nowrap width="20%">Mobility<b><span class="mantatory">*&nbsp;</span></b></td>
					<td nowrap colspan="4"><select
						name="txtperapp_yrsinpresadd" tabindex="36"style="WIDTH:300PX">
							<option value="0">---- Select ----</option>
							<option value="1">Staying at Current Location for More
										than 5 years</option>
							<option value="2">Staying at Current Location for 2 to 5
											years</option>
							<option value="3">Staying at Current Location for Less
										than 2 years</option>
							</select></td>
				</tr>
				<tr>
				<td nowrap width="20%" id="residen">Is
				the Residence <b><span class="mantatory">*&nbsp;</span></b></td>
				<td width="16%"><select name="sel_residence" tabindex="37"
					onChange="showres()">
					<option value="0" selected>--Select--</option>
					<option value="1">Rented</option>
					<option value="2">Owned</option>
					<option value="3">Leased</option>
					<option value="4">Family</option>
					<option value="5">Employer</option>
				</select></td>
				<td nowrap width="15%" id="place">Place
				of Domicile</td>
				<td nowrap width="49%" colspan="2"><input type="text"
					name="txt_placeofdomicile" size="20" maxlength="60"
					tabindex="38"
					value="<%=Helper.correctNull((String)hshValues.get("perapp_placeofdomicile"))%>"
					onKeyPress="notAllowSplChar()"></td>
			</tr>
					<tr>
				<td id="c1" nowrap width="20%">Value
				of the Residence </td>
				<td id="c2" width="16%"><input type="text" 
					name="txt_cost_res" size="15" maxlength="10" style="text-align:right" 
					value="<%=Helper.correctNull((String)hshValues.get("per_cost_res")) %>"
					tabindex="39" onBlur="roundtxt(this)" onKeyPress="allowWholeNumber(this)" /></td>
				<td id="d1" nowrap width="15%">Date
				of Purchase</td>
				<td valign="top" id="d2" width="24%">
				<table border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td><input type="text" name="txt_purchasedate" size="12"
							maxlength="10" tabindex="40"
							value="<%=Helper.correctNull((String)hshValues.get("per_date_pruchase"))%>"
							onBlur="checkDate(this);dateDOBCheck(this);checkvalues(this)">
						</td>
						<td><a href="#"
							onClick="callCalender('txt_purchasedate')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0" tabindex="41"></a></td>
					</tr>
				</table>
				</td>
				<td valign="top" width="25%">&nbsp;</td>
			</tr>
			</table>
		</td>
	</tr>
	<tr id="resident">
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td width="16%">Resident Status</td>
				<td width="27%"><select name="selstatus" tabindex="45"
					onChange="showcoun();shownri()">
					<option value="0">----Select-----</option>
					<option value="1">Resident</option>
					<option value="2">NRI</option>
				</select></td>
				<td id="cy1" width="9%">Country</td>
				<td id="cy2" width="17%"><input type="text" name="txt_country"
					size="15" maxlength="30" tabindex="46"
					value="<%=Helper.correctNull((String)hshValues.get("per_country"))%>"
					onKeyPress="notallowInteger()"></td>
				<td id="cy3" width="17%">Date becoming of NRI</td>
				<td id="cy4" width="14%">
				<table border="0" cellspacing="0" cellpadding="3" width="40%" class="outertable">
					<tr>
						<td><input type="text" name="txt_dateofNRI" size="15"
							maxlength="30" tabindex="47"
							onBlur="checkDate(this);checkmaxdate(this,currentDate);"
							value="<%=Helper.correctNull((String)hshValues.get("per_dateofNRI"))%>">
						</td>
						<td><a href="#" onClick="callCalender('txt_dateofNRI')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							height="22" border="0" tabindex="45"></a></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td id="child1">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td width="79%" nowrap>Passport Number<span class="mantatory" id="p1">&nbsp;*</span></td>
<!--						<td width="21%" id="p1">&nbsp;<span class="mantatory">*&nbsp;</span></td>-->
					</tr>
				</table>
				</td>
				<td id="child2"><input type="text" name="txtperapp_passport"
					size="25"
					value="<%=Helper.correctNull((String)hshValues.get("perapp_passport"))%>"
					maxlength="20" tabindex="48"></td>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td width="61%" >Passport Issued by<span class="mantatory" id="p2">&nbsp;*</span></td>
<!--						<td width="40%" id="p2">&nbsp;<span class="mantatory">*&nbsp;</span></td>-->
					</tr>
				</table>
				</td>
				<td><input type="text" name="txtperapp_passissue" size="25"
					maxlength="50" tabindex="49"
					value="<%=Helper.correctNull((String)hshValues.get("perapp_passissue"))%>"
					onKeyPress="notAllowedDouble();notAllowSplChar()"></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td id="child1">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td width="85%" nowrap>Passport Issue Date<span class="mantatory" id="pID">&nbsp;*</span></td>
<!--						<td width="15%" id="pID"><b><span class="mantatory">*&nbsp;</span></b></td>-->
					</tr>
				</table>
				</td>
				<td id="child2" width="15%">
				<table width="50%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td><input type="text" name="txtperapp_passportissuedate"
							size="11"
							value="<%=Helper.correctNull((String)hshValues.get("perapp_passissuedt"))%>"
							maxlength="10" tabindex="50"
							onBlur="checkDate(this);checkfiledate(this)"></td>
						<td width="11%"><a href="#"
							onClick="callCalender('txtperapp_passportissuedate')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							height="22" border="0" tabindex="48"></a></td>
					</tr>
				</table>
				</td>
				<td nowrap>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td width="74%">Passport Expiry Date <span class="mantatory" id="pED">*</span></td>
<!--						<td width="26%" id="pED"><span class="mantatory">*&nbsp;</span></td>-->
					</tr>
				</table>
				</td>
				<td>
				<table border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td width="78%"><input type="text"
							name="txtperapp_passportexpirydate" size="11"
							value="<%=Helper.correctNull((String)hshValues.get("perapp_passexpiry"))%>"
							maxlength="10" tabindex=""
							onBlur="checkDate(this);checkfiledate1(this)"></td>
						<td width="22%"><a href="#"
							onClick="callCalender1('txtperapp_passportexpirydate')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							height="22" border="0" tabindex="51"></a></td>
					</tr>
				</table>
				</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td width="30%">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td width="11%">Employment Status <b><span class="mantatory">*&nbsp;</span></b></td>
						<td colspan="2"><select name="select_Occupation"
							onChange="ShowOccupation();showBusiness();getlocationvalues()"
							tabindex="52" style="width:200">
						</select></td>
						<td width="5%">Line of Activity</td>
						<td nowrap width="20%"><select name="select_OccupationSub"
							tabindex="53" style="width:150">
						</select></td>
						<td nowrap id="p4" width="18%">Pension Payment Order Number<b><span class="mantatory">*&nbsp;</span></b></td>
						<td nowrap id="p5" width="15%"><input type="text"
							name="txtperapp_pension" size="10" maxlength="10" tabindex="54"
							style="text:align:left"
							value="<%=Helper.correctNull((String)hshValues.get("perapp_pension"))%>"
							onKeyPress="notAllowSingleQuote();allowInteger()"></td>
					</tr>
					<tr id="bsr">
						<td width="11%">Industry BSR Code:</td>
						<td colspan="2"><input type="hidden" name="comapp_indcode"
							size="20" maxlength="23"
							style=text-align:left;border-style=groove
							value="<%=Helper.correctNull((String)hshValues.get("perapp_indcode"))%>">
						<input type="text" name="comapp_companyid" size="30"
							maxlength="15" style=text-align:left;border-style=groove
							onKeyPress="notAllowedDouble();notAllowSpace()" tabindex="7"
							value="<%=Helper.correctNull((String)hshValues.get("perapp_companyname"))%>"
							readOnly> <b><span onClick="callDescHelp('applicantmaster')"
							style="cursor:hand"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0" tabindex="7"></span></b></td>
						<td width="5%" id="ser1">&nbsp;Experience in Years<span class="mantatory">*&nbsp;</span></td>
						<td nowrap width="20%" id="ser2"><input type="text" name="txt_expyrs" size="5" maxlength="2"
						 value="<%=Helper.correctNull((String)hshValues.get("perapp_yrsexp"))%>" onkeypress="allowInteger()"></td>
						<td nowrap width="18%">&nbsp;</td>
						<td nowrap width="15%">&nbsp;</td>
					</tr>
					<tr id="busi">
						<td width="11%" nowrap>Is the job transferrable</td>
						<td width="7%"><select name="sel_transferrable"
							onChange="getlocationvalues()" tabindex="55">
							<option value="1">Yes</option>
							<option value="2" selected>No</option>
						</select></td>
						<td id="sel1" width="24%"><select name="sel_jobloacation"
							tabindex="56">
							<option value="1">All India</option>
							<option value="2">WithinState</option>
							<option value="3">OutsideIndia</option>
						</select></td>
						<td nowrap width="5%" id="emp1">Whether Staff</td>
						<td width="20%" id="emp2"><select name="sel_istaff"
							onChange="showStaffBox()" tabindex="57">
							<option value="Y">Yes</option>
							<option value="N" selected>No</option>
						</select></td>
						<td width="18%">&nbsp;</td>
						<td width="15%">&nbsp;</td>
					</tr>
					<tr id="staff">
						<td width="11%">Date of Joining<b><span class="mantatory">*&nbsp;</span></b></td>
						<td width="7%"><input type="text" name="txt_dateofjoining"
							size="12" maxlength="10" tabindex="58"
							value="<%=Helper.correctNull((String)hshValues.get("perapp_staffdoj"))%>"
							onBlur="checkDate(this);checkmaxdate(this,currentDate);check_val2()">
						</td>
						<td width="24%"><a href="#"
							onClick="callCalender('txt_dateofjoining')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							height="22" border="0" tabindex="59"></a></td>
						<td width="5%">PF No.<b><span class="mantatory">*&nbsp;</span></b></td>
						<td width="20%"><input type="text" name="txt_Userid"
							style="width:80" maxlength="10" tabindex="60"></td>
						<td width="18%">Confirmation Date<b><span class="mantatory">*&nbsp;</span></b></td>
						<td width="15%"><input type="text" name="txt_confirmationdate"
							size="12" maxlength="10" tabindex="61"
							value="<%=Helper.correctNull((String)hshValues.get("perapp_confirmdate"))%>"
							onBlur="checkDate(this);checkmaxdate(this,currentDate);check_val()">
						&nbsp;<a href="#" onClick="callCalender('txt_confirmationdate')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							height="22" border="0" tabindex="62"></a></td>
					</tr>
					<tr id="staff1">
						<td width="11%">Name of the Nominee - P.F</td>
						<td colspan="2"><input type="text" name="txt_nomineepf" size="35"
							maxlength="60" tabindex="63"
							value="<%=Helper.correctNull((String)hshValues.get("perapp_nomineepfname"))%>"
							onKeyPress="notAllowSplChar()"></td>
						<td width="5%">Relationship</td>
						<td width="20%"><input type="text" name="txt_pfrelation" size="35"
							maxlength="61" tabindex="64"
							value="<%=Helper.correctNull((String)hshValues.get("perapp_pfrelation"))%>"
							onKeyPress="notAllowSplChar()"></td>
						<td width="18%">Service Record<b><span class="mantatory">*&nbsp;</span></b></td>
						<td width="15%"><textarea cols="20" tabindex="65" rows="2"
							name="txt_servicerecord"><%=Helper.correctNull((String) hshValues
							.get("perapp_servicerecord"))%></textarea></td>
					</tr>
					<tr id="staff2">
						<td width="11%">Name of Nominee - Gratuity</td>
						<td colspan="2"><input type="text" name="txt_nomineegratuity"
							size="35" maxlength="40" tabindex="66"
							value="<%=Helper.correctNull((String)hshValues.get("perapp_nomineegratuityname"))%>"
							onKeyPress="notAllowSplChar()"></td>
						<td width="5%">Relationship</td>
						<td width="20%"><input type="text" name="txt_gratuityrelation"
							size="35" maxlength="40" tabindex="67"
							value="<%=Helper.correctNull((String)hshValues.get("perapp_gratuityrelation"))%>"
							onKeyPress="notAllowSplChar()"></td>
						<td width="18%">&nbsp;</td>
					</tr>
				</table>
				</td>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td width="16%">Banking with us</td>
						<td width="15%"><select name="selbank" onChange="enableSince()"
							tabindex="68">
							<option value="2" selected>No</option>
							<option value="1">Yes</option>
						</select></td>
						<td width="16%" id="s1">Since&nbsp;(Year)&nbsp;<b><span class="mantatory">*&nbsp;</span></b></td>
						<td width="14%" id="s2"><input type="text" name="txtperapp_since"
							size="5" maxlength="4" tabindex="69" style="text-align:left"
							value="<%=Helper.correctNull((String)hshValues.get("perapp_banksince"))%>"
							onKeyPress="allowInteger()"
							onBlur="min_nos(document.forms[0].txtperapp_since,4);onBlur=checkFileDate(this)">
						</td>
						<td id="b1" width="15%">Is salary routed through our bank</td>
						<td id="b2" width="24%"><select name="sel_salaryrooted"
							tabindex="72">
							<option value="2" selected>No</option>
							<option value="1">Yes</option>
						</select></td>
					</tr>
					
					<tr>
						<td width="16%">Category&nbsp;<b><span class="mantatory">*&nbsp;</span></b></td>
						<td width="15%"><select name="selcat" tabindex="73">
							<option value="S" selected>----Select----</option>
							<option value="001">General</option>
							<option value="002">OBC</option>
							<option value="003">SC</option>
							<option value="004">ST</option>
							<option value="999">Others</option>
						</select></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						
						<td width="17%">Religion<b><span class="mantatory">*&nbsp;</span></b></td>
						<td width="22%"><select name="selreligion" tabindex="73">
							<option value="0">----Select-----</option>
							<option value="001">Hindu</option>
							<option value="002">Muslim</option>
							<option value="003">Christian</option>
							<option value="004">Sikhs</option>
							<option value="005">Neo-Budhist</option>
							<option value="006">Jain</option>
							<option value="007">Parsi</option>
							<option value="999">Others</option>
						</select></td>
					</tr>
					<tr id="depend">
						<td id="child1" width="16%">No. of Dependents<b></b></td>
						<td id="child2" width="15%">
						<table border="0" cellspacing="0" cellpadding="0" width="82" class="outertable">
							<tr>
								<td width="25%">Children</td>
								<td width="25%"><input type="text" name="txtperapp_childnum"
									size="4" maxlength="2" tabindex="74" style="text-align:left"
									value="<%=Helper.correctNull((String)hshValues.get("perapp_childnum"))%>"
									onKeyPress="allowInteger()"></td>
								<td width="30%">&nbsp;&nbsp;Others</td>
								<td width="20%"><input type="text" name="txtperapp_depend"
									size="5" maxlength="2" tabindex="75" style="text-align:left"
									value="<%=Helper.correctNull((String)hshValues.get("perapp_depend"))%>"
									onKeyPress="allowInteger()"></td>
							</tr>
						</table>
						</td>
						<td width="16%">Earning Member in family&nbsp;<b><span class="mantatory">*&nbsp;</span></b></td>
						<td id="child2" width="14%"><input type="text"
							name="txtperapp_earn" size="3" maxlength="2" tabindex="76"
							style="text:align:left"
							value="<%=Helper.correctNull((String)hshValues.get("perapp_earn"))%>"
							onKeyPress="notAllowSingleQuote();allowInteger()"></td>
						<td width="15%">Others Earning Member in family</td>
						<td id="child2" width="24%">
						<table width="100%" border="0" cellspacing="1" cellpadding="1">
							<tr>
								<td><textarea cols="30" tabindex="77" rows="3"
									name="txtperapp_otherearn"><%=Helper.correctNull((String) hshValues
							.get("perapp_otherearn"))%></textarea></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td width="16%">Educational Qualification<b><span class="mantatory">*&nbsp;</span></b></td>
						<td width="15%"><select name="seledu" tabindex="78">
							<option value="0" selected>----Select----</option>
							<option value="1">M.B.B.S/MD/MS</option>
							<option value="2">C.A</option>
							<option value="3">M.B.A</option>
							<option value="4">A.C.S</option>
							<option value="13">LLB/LLM</option>
							<option value="5">Professional</option>
							<option value="6">Post Graduate</option>
							<option value="7">Graduate</option>
							<option value="8">Diploma</option>
							<option value="9">PUC / Plus 2</option>
							<option value="10">SSLC</option>
							<option value="11">VIII Pass</option>
							<option value="12">Illiterate</option>
							<!--<option value="14">Others</option>
						-->
						</select></td>
						<td width="16%" id="area">Area Specialized</td>
						<td width="14%"><input type="text" name="txt_area_spec" size="25"
							maxlength="50" tabindex="79"
							value="<%=Helper.correctNull((String)hshValues.get("per_area_specify"))%>">
						</td>
						<td width="15%">&nbsp;</td>
						<td width="24%">&nbsp;</td>
					</tr>
					<tr>
						<td width="16%">Physically Challenged</td>
						<td width="15%"><select name="selPhyHand" tabindex="80">
							<option value="Y">Yes</option>
							<option value="N" selected>No</option>
						</select></td>
						<td width="16%">Minority</td>
						<td width="14%"><select name="selMinority" tabindex="81">
							<option value="Y">Yes</option>
							<option value="N" selected>No</option>
						</select></td>
						<td width="15%">Ex-Serviceman</td>
						<td width="24%">
						<table width="95%" border="0" cellspacing="0" cellpadding="0" class="outertable">
							<tr>
								<td width="31%"><select name="selExService" tabindex="82"
									onChange="showYearsOfService()">
									<option value="Y">Yes</option>
									<option value="N" selected>No</option>
								</select></td>
								<td align="right" id="y1" width="51%">Years of
								Service<b><span class="mantatory">*&nbsp;</span></b></td>
								<td id="y2" width="18%">&nbsp; <input type="text"
									name="txt_yrs_service" size="3" maxlength="2" tabindex="83"
									style="text:align:left"
									value="<%=Helper.correctNull((String)hshValues.get("perapp_yrs_service"))%>"
									onKeyPress="notAllowSingleQuote();allowInteger()" /></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr id="relatives">
						<td width="16%">Any relative is working in the bank?</td>
						<td width="15%"><select name="selbuss" tabindex="84"
							onChange="showBranch()">
							<option value="1" selected>No</option>
							<option value="0">Yes</option>
						</select></td>
						<td id="t5" width="16%">Which Branch</td>
						<td id="t6" width="14%"><input type="text" name="txtperapp_branch"
							size="15" maxlength="15" tabindex="85"
							value="<%=Helper.correctNull((String)hshValues.get("perapp_brdet"))%>"
							onKeyPress="notAllowSingleQuote()"> <input type="hidden"
							name="txtperapp_branchcode" size="15" maxlength="15"
							tabindex="52" value="" onKeyPress="notAllowSingleQuote()"> <b>
							<span onClick="showBranch1()" style="cursor:hand"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="86"></span>
							</b></td>
						<td id="r1" width="15%">Relative Name &amp; Designation</td>
						<td id="r2" width="24%"><input type="text"
							name="txtrelativedetails" size="20" maxlength="50" tabindex="87"
							value="<%=Helper.correctNull((String)hshValues.get("perapp_relativedet"))%>">
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td><b>CBS Data</b>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr id="minor">
						<td width="16%">Whether Minor</td>
						<td width="20%"><select name="sel_minor" onChange="showguardian()"
							tabindex="88">
							<option value="1">Yes</option>
							<option value="2" selected>No</option>
						</select></td>
						<td width="16%" id="gn1" colspan="2">Guardian Name
						<b><span class="mantatory">*&nbsp;</span></b></td>
						<td width="15%" id="gn2"><input type="text" name="txt_guardianame"
							tabindex="89"
							value="<%=Helper.correctNull((String)hshParams.get("gua_name"))%>">
						</td>
					</tr>
					<tr>
						<td width="18%" id="g1">Guardian Relationship<b><span class="mantatory">*&nbsp;</span></b><br>
						<td width="30%" id="g2"><input type="text" tabindex="90"
							name="txt_guardian"
							value="<%=Helper.correctNull((String)hshParams.get("txt_guardian"))%>">
						</td>
						<td width="17%" id="f1" colspan="2">Guardian
						Address<b><span class="mantatory">*&nbsp;</span></b></td>
						<td width="35%" id="f2"><textarea name="txt_relation"
							tabindex="91"><%=Helper.correctNull((String) hshParams
									.get("txt_relation"))%></textarea></td>
					</tr>
					<tr>
						<td width="18%">Trade Finance</td>
						<td width="30%"><select name="sel_trade" onchange="showinland()"
							tabindex="91">
							<option value="1">Yes</option>
							<option value="2" selected>No</option>
						</select></td>
						<td width="18%" id="trade1" colspan="2">Inland
						Trade Allowed</td>
						<td width="30%" id="trade2"><select name="sel_inland"
							tabindex="92">
							<option value="1">Yes</option>
							<option value="2" selected>No</option>
						</select></td>
					</tr>
				
				</table>
			</tr>
		</table>
		</td>
	</tr>
	<tr id="spouse">
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable"> 
			<tr>
				<td><b>Spouse Details</b>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td width="16%">Title</td>
						<td width="20%"><select name="sel_spouse" tabindex="95">
							<option value="MR">MR.</option>
							<option value="MS">MS.</option>
							<option value="MRS" selected>MRS.</option>
						</select></td>
						<td width="16%">&nbsp;</td>
						<td width="15%"></td>
						<td width="5%">&nbsp;</td>
						<td width="28%">&nbsp;</td>
					</tr>
					<tr>
						<td>Name</td>
						<td><input type="text" name="txtperapp_husname" size="20"
							maxlength="50" tabindex="96"
							value="<%=Helper.correctNull((String)hshValues.get("perapp_husname"))%>"
							onKeyPress="notAllowedDouble();notAllowSplChar()"></td>
						<td>Occupation</td>
						<td><select name="txtperapp_occupation" tabindex="97">
							<%String apptype1 = "27";

			%>
							<option value="0" selected>--select--</option>
							<lapschoice:StaticDataNewTag apptype='<%=apptype1%>' />
						</select></td>
						<td>Email</td>
						<td><input type="text" name="txtperapp_spemail" size="40"
							maxlength="50"
							value="<%=Helper.correctNull((String)hshValues.get("perapp_spouseemail"))%>"
							onBlur="isEmailAddr(document.forms[0].txtperapp_spemail.value,document.forms[0].txtperapp_spemail)"
							tabindex="98"></td>
					</tr>
					<tr>
						<td>PAN No. / GIR</td>
						<td><input type="text" name="txtperapp_sppan" size="15"
							maxlength="10"
							value="<%=Helper.correctNull((String)hshValues.get("perapp_spousepan"))%>"
							tabindex="99" onBlur="checkpanno(this)"></td>
						<td nowrap>Net Monthly Income</td>
						<td><lapschoice:CurrencyTag name="txtperapp_spincome" size="15"
							maxlength="12"
							value='<%=Helper.correctNull((String)hshValues.get("perapp_spouseincome"))%>'
							tabindex="100" /></td>
						<td>&nbsp;</td>
						<td nowrap>&nbsp;</td>
					</tr>
				</table>
			</tr>
		</table>
		</td>
	</tr>
</table>