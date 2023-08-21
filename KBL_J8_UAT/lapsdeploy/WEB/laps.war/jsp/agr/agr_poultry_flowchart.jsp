<%@include file="../share/directives.jsp"%>
<%
ArrayList arryCol = new ArrayList();
ArrayList arryRow = new ArrayList();
arryRow  = (ArrayList) hshValues.get("arryRow");
ArrayList arryCol1 = new ArrayList();
ArrayList arryCol2 = new ArrayList();
ArrayList arryRow1 = new ArrayList();
arryRow1  = (ArrayList) hshValues.get("arryRow1");
ArrayList arryRow2 = new ArrayList();
arryRow2  = (ArrayList) hshValues.get("arryRow2");
ArrayList arryRow4 = new ArrayList();
ArrayList arryCol4 = new ArrayList();
arryRow4  = (ArrayList) hshValues.get("arryRow4");


if (arryRow == null) {
	arryRow  = new ArrayList();
}
if (arryRow1 == null) {
	arryRow1  = new ArrayList();
}
if (arryRow2 == null) {
	arryRow2  = new ArrayList();
}
if (arryRow4 == null) {
	arryRow4  = new ArrayList();
}
//String l14="",d14="";
String a1="",l11="",d11="",l15="",d15="";
//String l12="",d12="",l13="",d13="",mo1="",mo2="",mo3="",mo4="",mo5="";
String a2="",a3="",a6="",a7="",a8="",a9="",a10="";

ArrayList arrPurchase=(ArrayList)hshValues.get("arrPurchase");
ArrayList arrChicksMash=(ArrayList)hshValues.get("arrChicksMash");
ArrayList arrGrowersMash=(ArrayList)hshValues.get("arrGrowersMash");
ArrayList arrLayersMash=(ArrayList)hshValues.get("arrLayersMash");
ArrayList arrVetriAid=(ArrayList)hshValues.get("arrVetriAid");
ArrayList arrInsurance=(ArrayList)hshValues.get("arrInsurance");
ArrayList arrTransporation=(ArrayList)hshValues.get("arrTransporation");
%>
<html>
<head>
<title>LAPS -Assesment Form Details</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var id ="";
var apptype="";

var currentDate = "<%=Helper.getCurrentDateTime()%>";
var  strid="<%=Helper.correctNull((String)hshValues.get("strid"))%>";
var  strAction="<%=Helper.correctNull((String)hshValues.get("strAction"))%>";
var  nodata="<%=Helper.correctNull((String)hshValues.get("nodata"))%>";

function costchicks()
{
	 var  txt_totalcostchicks="<%=Helper.correctNull((String)hshValues.get("txt_totalcostchicks"))%>";
	
	/*if(txt_totalcostchicks=="")
	{
		txt_totalcostchicks="0";
	}
	for(var m=0;m<=7;m++)
	{
		var ibatch=document.forms[0].txt_ibatch[m].value
		if(ibatch=="")
		{
			ibatch="0";
			document.forms[0].txt_ibatch[m].value="0";
		}
		var iyear=eval(txt_totalcostchicks)*eval(ibatch);
		if(iyear=="")
		{
			iyear="0";
		}
		document.forms[0].txt_ibatchiyear[m].value=NanNumber(eval(iyear));
		roundtxt(document.forms[0].txt_ibatchiyear[m]); */
}
/*var val1=document.forms[0].txt_ibatchiyear[0].value;
//var val2=document.forms[0].txt_iibatchiyear[0].value;
if(document.forms[0].txt_ibatchiyear[0].value=="")
{
val1="0";
document.forms[0].txt_ibatchiyear[0].value="0";
}
if(document.forms[0].txt_iibatchiyear[0].value=="")
{
val2="0";
document.forms[0].txt_iibatchiyear[0].value="0";

}
if(document.forms[0].txt_ibatchiyear[0].value=="NaN")
{
document.forms[0].txt_ibatchiyear[0].value="0";
val1="0";
}
if(document.forms[0].txt_iibatchiyear[0].value=="NaN")
{
document.forms[0].txt_iibatchiyear[0].value="0";
val2="0";
}
if(eval(val1)==eval(val2))
{
//document.forms[0].txt_iibatchiyear[0].value=eval(val2);
//roundtxt(document.forms[0].txt_iibatchiyear[0]);
document.forms[0].txt_ibatchiyear[0].value="0.00";
document.forms[0].txt_iibatchiiyear[0].value="0.00";

}
if(eval(val1)<eval(val2))
{
//document.forms[0].txt_iibatchiyear[0].value=eval(val1);
//roundtxt(document.forms[0].txt_iibatchiyear[0]);
document.forms[0].txt_ibatchiyear[0].value="0.00";
document.forms[0].txt_iibatchiiyear[0].value=eval(val2)-eval(val1);
roundtxt(document.forms[0].txt_iibatchiiyear[0]);
var val3=document.forms[0].txt_ibatchiyear[1].value;
var val4=document.forms[0].txt_ibatchiyear[1].value;
document.forms[0].txt_ibatchiyear[1].value=NanNumber(eval(val4)-eval(document.forms[0].txt_iibatchiiyear[0].value));
roundtxt(document.forms[0].txt_ibatchiyear[1]);

if(document.forms[0].txt_ibatchiyear[1].value=="NaN")
{
document.forms[0].txt_ibatchiyear[1].value="0.00";
}
}
if(eval(val1)>eval(val2))
{
//document.forms[0].txt_iibatchiyear[0].value=eval(val2);
//roundtxt(document.forms[0].txt_iibatchiyear[0]);
document.forms[0].txt_ibatchiyear[0].value=eval(val1)-eval(val2);
roundtxt(document.forms[0].txt_ibatchiyear[0]);
document.forms[0].txt_iibatchiiyear[0].value="0.00";

}

}*/
function costfeed()
{
var  txt_totalchickmash="<%=Helper.correctNull((String)hshValues.get("txt_totalchickmash"))%>";
/*if(txt_totalchickmash=="")
{
txt_totalchickmash="0";
}
for(var m=0;m<=7;m++)
{
var ibatchfeed=document.forms[0].txt_ibatchfeed[m].value
var iiyear=eval(txt_totalchickmash)*eval(ibatchfeed);
document.forms[0].txt_ibatchiiyear[m].value=NanNumber(eval(iiyear));
roundtxt(document.forms[0].txt_ibatchiiyear[m]);
if(document.forms[0].txt_ibatchiiyear[m].value=="NaN")
{
document.forms[0].txt_ibatchiiyear[m].value="0.00";
}*/
//}
/*var val1=document.forms[0].txt_ibatchiiyear[0].value;
//var val2=document.forms[0].txt_iibatchiyear[1].value;
if(val2=="")
{
val2="0";
//document.forms[0].txt_iibatchiyear[1].value="0.00";
}
if(eval(val1)<eval(val2))
{
//document.forms[0].txt_iibatchiyear[1].value=eval(val1);
//roundtxt(document.forms[0].txt_iibatchiyear[1]);
document.forms[0].txt_ibatchiiyear[0].value="0.00";
document.forms[0].txt_iibatchiiyear[1].value=NanNumber(eval(val2)-eval(val1));
roundtxt(document.forms[0].txt_iibatchiiyear[1]);
if(document.forms[0].txt_iibatchiiyear[1].value=="NaN")
{
document.forms[0].txt_iibatchiiyear[1].value="0.00";
}
}
if(eval(val1)>eval(val2))
{
//document.forms[0].txt_iibatchiyear[1].value=NanNumber(eval(val2));
//roundtxt(document.forms[0].txt_iibatchiyear[1]);
document.forms[0].txt_ibatchiiyear[0].value=NanNumber(eval(val1)-eval(val2));
roundtxt(document.forms[0].txt_ibatchiiyear[0]);
document.forms[0].txt_iibatchiiyear[1].value="0.00";

}
if(eval(val1)==eval(val2))
{
//document.forms[0].txt_iibatchiyear[1].value=NanNumber(eval(val2));
//roundtxt(document.forms[0].txt_iibatchiyear[1]);
document.forms[0].txt_ibatchiiyear[0].value="0.00";
document.forms[0].txt_iibatchiiyear[1].value="0.00";

}*/

}
function costgrower()
{
var  txt_totalgrowermash="<%=Helper.correctNull((String)hshValues.get("txt_totalgrowermash"))%>";
/*if(txt_totalgrowermash=="")
{
txt_totalgrowermash="0";
}
for(var m=0;m<=7;m++)
{
var ibatchgrow=document.forms[0].txt_ibatchgrow[m].value
var iiiyear=eval(txt_totalgrowermash)*eval(ibatchgrow);
document.forms[0].txt_ibatchiiiyear[m].value=NanNumber(eval(iiiyear));
roundtxt(document.forms[0].txt_ibatchiiiyear[m]);*/
//}
/*var val1=document.forms[0].txt_ibatchiiiyear[0].value;
//var val2=document.forms[0].txt_iibatchiyear[2].value;
if(val2=="")
{
val2="0";
//document.forms[0].txt_iibatchiyear[2].value="0.00";
}
if(eval(val1)<eval(val2))
{
//document.forms[0].txt_iibatchiyear[2].value=eval(val1);
//roundtxt(document.forms[0].txt_iibatchiyear[2]);
document.forms[0].txt_ibatchiiiyear[0].value="0.00";
document.forms[0].txt_iibatchiiyear[2].value=NanNumber(eval(val2)-eval(val1));
roundtxt(document.forms[0].txt_iibatchiiyear[2]);
if(document.forms[0].txt_iibatchiiyear[2].value=="NaN")
{
document.forms[0].txt_iibatchiiyear[2].value="0.00";
}
}
if(eval(val1)>eval(val2))
{
//document.forms[0].txt_iibatchiyear[2].value=eval(val2);
//roundtxt(document.forms[0].txt_iibatchiyear[2]);
document.forms[0].txt_ibatchiiiyear[0].value=NanNumber(eval(val1)-eval(val2));
roundtxt(document.forms[0].txt_ibatchiiiyear[0]);
document.forms[0].txt_iibatchiiyear[2].value="0.00";

}
if(eval(val1)==eval(val2))
{
//document.forms[0].txt_iibatchiyear[2].value=NanNumber(eval(val2));
//roundtxt(document.forms[0].txt_iibatchiyear[2]);
document.forms[0].txt_ibatchiiiyear[0].value="0.00";
document.forms[0].txt_iibatchiiyear[2].value="0.00";

}*/
}
function costlayer()
{
	var  txt_totallayermash="<%=Helper.correctNull((String)hshValues.get("txt_totallayermash"))%>";
	/*if(txt_totallayermash=="")
		{
			txt_totallayermash="0";
		}
	for(var m=0;m<=7;m++)
		{
			var ibatchlayer=document.forms[0].txt_ibatchlayer[m].value;
			var ivyear=eval(txt_totallayermash)*eval(ibatchlayer);
			document.forms[0].txt_ibatchivyear[m].value=NanNumber(eval(ivyear));
			roundtxt(document.forms[0].txt_ibatchivyear[m]);
		}*/
}
function costvtaid()
{
	var  txt_totalvtaid="<%=Helper.correctNull((String)hshValues.get("txt_totalvtaid"))%>";
	/*for(var m=0;m<=7;m++)
		{
			var ibatchvt=document.forms[0].txt_ibatchvt[m].value;
			var vtyear=eval((txt_totalvtaid)*eval(ibatchvt));
			document.forms[0].txt_ibatchviiiyear[m].value=NanNumber(eval(vtyear));
			roundtxt(document.forms[0].txt_ibatchviiiyear[m]);
		}*/
/*	var val1=document.forms[0].txt_ibatchviiiyear[0].value;

//	var val2=document.forms[0].txt_iibatchiyear[7].value;

	if(eval(val1)<eval(val2))
		{
//			document.forms[0].txt_iibatchiyear[7].value=eval(val1);
	//		roundtxt(document.forms[0].txt_iibatchiyear[7]);
			document.forms[0].txt_ibatchviiiyear[0].value="0.00";
			document.forms[0].txt_iibatchiiyear[7].value=NanNumber(eval(val2)-eval(val1));
			roundtxt(document.forms[0].txt_iibatchiiyear[7]);
		if(document.forms[0].txt_iibatchiiyear[7].value=="NaN")
			{
			document.forms[0].txt_iibatchiiyear[7].value="0.00";
			}

		}
	if(eval(val1)>eval(val2))
		{
//			document.forms[0].txt_iibatchiyear[7].value=eval(val2);
//			roundtxt(document.forms[0].txt_iibatchiyear[7]);
			document.forms[0].txt_ibatchviiiyear[0].value=NanNumber(eval(val1)-eval(val2));
			roundtxt(document.forms[0].txt_ibatchviiiyear[0]);
			document.forms[0].txt_iibatchiiyear[7].value="0.00";

		}
	if(eval(val1)==eval(val2))
		{
//			document.forms[0].txt_iibatchiyear[7].value=eval(val2);
//			roundtxt(document.forms[0].txt_iibatchiyear[7]);
			document.forms[0].txt_ibatchviiiyear[0].value="0.00";
			document.forms[0].txt_iibatchiiyear[7].value="0.00";

		}*/

}
function costins()
{
var  txt_totalinspremium="<%=Helper.correctNull((String)hshValues.get("txt_totalinspremium"))%>";
/*for(var m=0;m<=7;m++)
{
var ibatchin=document.forms[0].txt_ibatchin[m].value
var inyear=eval((txt_totalinspremium)*eval(ibatchin));
document.forms[0].txt_ibatchixyear[m].value=NanNumber(eval(inyear));
roundtxt(document.forms[0].txt_ibatchixyear[m]);
}*/
/*var val1=document.forms[0].txt_ibatchixyear[0].value;

//var val2=document.forms[0].txt_iibatchiyear[8].value;

if(eval(val1)<eval(val2))
{
//document.forms[0].txt_iibatchiyear[8].value=eval(val1);
//roundtxt(document.forms[0].txt_iibatchiyear[8]);
document.forms[0].txt_ibatchixyear[0].value="0.00";
document.forms[0].txt_iibatchiiyear[8].value=NanNumber(eval(val2)-eval(val1));
roundtxt(document.forms[0].txt_iibatchiiyear[8]);
if(document.forms[0].txt_iibatchiiyear[8].value=="NaN")
{
document.forms[0].txt_iibatchiiyear[8].value="0.00";
}

}
if(eval(val1)>eval(val2))
{
//document.forms[0].txt_iibatchiyear[8].value=eval(val2);
//roundtxt(document.forms[0].txt_iibatchiyear[8]);
document.forms[0].txt_ibatchixyear[0].value=NanNumber(eval(val1)-eval(val2));
roundtxt(document.forms[0].txt_ibatchixyear[0]);
document.forms[0].txt_iibatchiiyear[8].value="0.00";

}
if(eval(val1)==eval(val2))
{
//document.forms[0].txt_iibatchiyear[8].value=eval(val2);
//roundtxt(document.forms[0].txt_iibatchiyear[8]);
document.forms[0].txt_ibatchixyear[0].value="0.00";
document.forms[0].txt_iibatchiiyear[8].value="0.00";

}*/


}
function costtransport()
{
var  txt_transportcharge="<%=Helper.correctNull((String)hshValues.get("txt_transportcharge"))%>";
/*for(var m=0;m<=7;m++)
{
var ibatchtc=document.forms[0].txt_ibatchtc[m].value
var tryear=eval(txt_transportcharge)*eval(ibatchtc);
document.forms[0].txt_ibatchxyear[m].value=NanNumber(eval(tryear));
roundtxt(document.forms[0].txt_ibatchxyear[m]);
}*/
/*var val1=document.forms[0].txt_ibatchxyear[0].value;

//var val2=document.forms[0].txt_iibatchiyear[9].value;

if(eval(val1)<eval(val2))
{
//document.forms[0].txt_iibatchiyear[9].value=eval(val1);
//roundtxt(document.forms[0].txt_iibatchiyear[9]);
document.forms[0].txt_ibatchxyear[0].value="0.00";
document.forms[0].txt_iibatchiiyear[9].value=NanNumber(eval(val2)-eval(val1));
roundtxt(document.forms[0].txt_iibatchiiyear[9]);
if(document.forms[0].txt_iibatchiiyear[9].value=="NaN")
{
document.forms[0].txt_iibatchiiyear[9].value="0.00";
}
}
if(eval(val1)>eval(val2))
{
//document.forms[0].txt_iibatchiyear[9].value=eval(val2);
//roundtxt(document.forms[0].txt_iibatchiyear[9]);
document.forms[0].txt_ibatchxyear[0].value=NanNumber(eval(val1)-eval(val2));
roundtxt(document.forms[0].txt_ibatchxyear[0].value);
document.forms[0].txt_iibatchiiyear[9].value="0.00";

}
if(eval(val1)==eval(val2))
{
//document.forms[0].txt_iibatchiyear[9].value=eval(val2);
//roundtxt(document.forms[0].txt_iibatchiyear[9]);
document.forms[0].txt_ibatchxyear[0].value="0.00";
document.forms[0].txt_iibatchiiyear[9].value="0.00";

}*/


}
function labour()
{
/*var val1=document.forms[0].txt_ibatchvyear[0].value;
//var val2=document.forms[0].txt_iibatchiyear[4].value;
if(eval(val1)=="")
{
val1="0";
}
if(eval(val2)=="")
{
val2="0";
}
if(eval(val1)<eval(val2))
{
//document.forms[0].txt_iibatchiyear[4].value=eval(val1);
//roundtxt(document.forms[0].txt_iibatchiyear[4]);
document.forms[0].txt_ibatchvyear[0].value="0.00";
document.forms[0].txt_iibatchiiyear[4].value=NanNumber(eval(val2)-eval(val1));
roundtxt(document.forms[0].txt_iibatchiiyear[4]);

}
if(eval(val1)>eval(val2))
{
//document.forms[0].txt_iibatchiyear[4].value=eval(val2);
//roundtxt(document.forms[0].txt_iibatchiyear[4]);
document.forms[0].txt_ibatchvyear[0].value=NanNumber(eval(val1)-eval(val2));
roundtxt(document.forms[0].txt_ibatchvyear[0]);
document.forms[0].txt_iibatchiiyear[4].value="0.00";

}
if(eval(val1)==eval(val2))
{
//document.forms[0].txt_iibatchiyear[4].value=eval(val2);
//roundtxt(document.forms[0].txt_iibatchiyear[4]);
document.forms[0].txt_ibatchvyear[0].value="0.00";
document.forms[0].txt_iibatchiiyear[4].value="0.00";

}*/
}
function water()
{
/*var val1=document.forms[0].txt_ibatchviyear[0].value;
//var val2=document.forms[0].txt_iibatchiyear[5].value;
if(eval(val1)<eval(val2))
{
//document.forms[0].txt_iibatchiyear[5].value=eval(val1);
//document.forms[0].txt_ibatchviyear[0].value="0.00";
document.forms[0].txt_iibatchiiyear[5].value=NanNumber(eval(val2)-eval(val1));
roundtxt(document.forms[0].txt_iibatchiiyear[5]);
if(document.forms[0].txt_iibatchiiyear[5].value=="NaN")
{
document.forms[0].txt_iibatchiiyear[5].value="0.00";
}
}
if(eval(val1)>eval(val2))
{
//document.forms[0].txt_iibatchiyear[5].value=eval(val2);
//roundtxt(document.forms[0].txt_iibatchiyear[5]);
document.forms[0].txt_ibatchviyear[0].value=NanNumber(eval(val1)-eval(val2));
roundtxt(document.forms[0].txt_ibatchviyear[0]);
document.forms[0].txt_iibatchiiyear[5].value="0.00";

}
if(eval(val1)==eval(val2))
{
//document.forms[0].txt_iibatchiyear[5].value=eval(val2);
//roundtxt(document.forms[0].txt_iibatchiyear[5]);
document.forms[0].txt_ibatchviyear[0].value="0.00";
document.forms[0].txt_iibatchiiyear[5].value="0.00";

}*/
}
function electricity()
{
/*var val1=document.forms[0].txt_ibatchviiyear[0].value;
//var val2=document.forms[0].txt_iibatchiyear[6].value;
if(eval(val1)=="")
{
val1="0";
}
if(eval(val1)<eval(val2))
{
document.forms[0].txt_iibatchiyear[6].value=eval(val1);
roundtxt(document.forms[0].txt_iibatchiyear[6]);
document.forms[0].txt_ibatchviiyear[0].value="0.00";
document.forms[0].txt_iibatchiiyear[6].value=NanNumber(eval(val2)-eval(val1));
roundtxt(document.forms[0].txt_iibatchiiyear[6]);
if(document.forms[0].txt_iibatchiiyear[6].value=="NaN")
{
document.forms[0].txt_iibatchiiyear[6].value="0.00";
}
}
if(eval(val1)>eval(val2))
{
document.forms[0].txt_iibatchiyear[6].value=eval(val2);
roundtxt(document.forms[0].txt_iibatchiyear[6]);
document.forms[0].txt_ibatchviiyear[0].value=NanNumber(eval(val1)-eval(val2));
roundtxt(document.forms[0].txt_ibatchviiyear[0]);
document.forms[0].txt_iibatchiiyear[6].value="0.00";

}
if(eval(val1)==eval(val2))
{
document.forms[0].txt_iibatchiyear[6].value=eval(val2);
roundtxt(document.forms[0].txt_iibatchiyear[6]);
document.forms[0].txt_ibatchviiyear[0].value="0.00";
document.forms[0].txt_iibatchiiyear[6].value="0.00";

}*/
}
function costexpenses0()
{

/*var val1=document.forms[0].txt_exp[0].value;
var val2=document.forms[0].txt_bank[0].value;
if(eval(val1)=="")
{
val1="0";
}
if(eval(val2)=="")
{
val2="0";
}
if(eval(val1)<eval(val2))
{
document.forms[0].txt_iibatchiyearexp[0].value=eval(val1);
roundtxt(document.forms[0].txt_iibatchiyearexp[0]);
document.forms[0].txt_ibatchexpiyear[0].value="0.00";
document.forms[0].txt_iibatchiiyearexp[0].value=NanNumber(eval(val2)-eval(val1));
roundtxt(document.forms[0].txt_iibatchiiyearexp[0]);
var val4=document.forms[0].txt_iibatchiyearexp[0].value;
document.forms[0].txt_ibatchexpiyear[1].value=NanNumber(eval(val4)-eval(document.forms[0].txt_iibatchiiyearexp[0].value));
roundtxt(document.forms[0].txt_ibatchexpiyear[1]);
if(document.forms[0].txt_ibatchexpiyear[1].value=="NaN")
{
document.forms[0].txt_ibatchexpiyear[1].value="0.00";
}
}
if(eval(val1)>eval(val2))
{
document.forms[0].txt_iibatchiyearexp[0].value=eval(val2);
roundtxt(document.forms[0].txt_iibatchiyearexp[0]);
document.forms[0].txt_ibatchexpiyear[0].value=NanNumber(eval(val1)-eval(val2));
roundtxt(document.forms[0].txt_ibatchexpiyear[0]);
document.forms[0].txt_iibatchiiyearexp[0].value="0.00";
document.forms[0].txt_ibatchexpiyear[1].value=eval(val1);
roundtxt(document.forms[0].txt_ibatchexpiyear[1]);
}
if(eval(val1)==eval(val2))
{
document.forms[0].txt_ibatchexpiyear[0].value="0.00";
document.forms[0].txt_iibatchiyearexp[0].value=eval(val2);
roundtxt(document.forms[0].txt_iibatchiyearexp[0]);
document.forms[0].txt_iibatchiiyearexp[0].value=eval(val2);
roundtxt(document.forms[0].txt_iibatchiiyearexp[0]);
document.forms[0].txt_ibatchexpiyear[1].value="0.00";
}*/
}

function costexpenses1()
{

/*var val1=document.forms[0].txt_exp[1].value;
var val2=document.forms[0].txt_bank[1].value;
if(eval(val1)=="")
{
val1="0";
}
if(eval(val2)=="")
{
val2="0";
}
if(eval(val1)<eval(val2))
{
document.forms[0].txt_iibatchiyearexp[1].value=eval(val1);
roundtxt(document.forms[0].txt_iibatchiyearexp[1]);
document.forms[0].txt_ibatchexpiiyear[0].value="0.00";
document.forms[0].txt_iibatchiiyearexp[1].value=NanNumber(eval(val2)-eval(val1));
roundtxt(document.forms[0].txt_iibatchiiyearexp[1]);
var val4=document.forms[0].txt_iibatchiyearexp[1].value;
document.forms[0].txt_ibatchexpiiyear[1].value=NanNumber(eval(val4)-eval(document.forms[0].txt_iibatchiiyearexp[1].value));
roundtxt(document.forms[0].txt_ibatchexpiiyear[1]);
if(document.forms[0].txt_ibatchexpiiyear[1].value=="NaN")
{
document.forms[0].txt_ibatchexpiiyear[1].value="0.00";
}
}
if(eval(val1)>eval(val2))
{
document.forms[0].txt_iibatchiyearexp[1].value=eval(val2);
roundtxt(document.forms[0].txt_iibatchiyearexp[1]);
document.forms[0].txt_ibatchexpiiyear[0].value=NanNumber(eval(val1)-eval(val2));
document.forms[0].txt_iibatchiiyearexp[1].value="0.00";
document.forms[0].txt_ibatchexpiiyear[1].value=eval(val1);
roundtxt(document.forms[0].txt_ibatchexpiiyear[1]);
if(document.forms[0].txt_ibatchexpiiyear[1].value=="NaN")
{
document.forms[0].txt_ibatchexpiiyear[1].value="0.00";
}
}
if(eval(val1)==eval(val2))
{
document.forms[0].txt_ibatchexpiiyear[0].value="0.00";
document.forms[0].txt_iibatchiyearexp[1].value=eval(val2);
roundtxt(document.forms[0].txt_iibatchiyearexp[1]);
document.forms[0].txt_iibatchiiyearexp[1].value=eval(val2);
roundtxt(document.forms[0].txt_iibatchiiyearexp[1]);
document.forms[0].txt_ibatchexpiiyear[1].value="0.00";
}*/
}
function costexpenses2()
{

/*var val1=document.forms[0].txt_exp[2].value;


var val2=document.forms[0].txt_bank[2].value;
if(eval(val1)<eval(val2))
{
document.forms[0].txt_iibatchiyearexp[2].value=eval(val1);
roundtxt(document.forms[0].txt_iibatchiyearexp[2]);
document.forms[0].txt_ibatchexpiiiyear[0].value="0";
document.forms[0].txt_iibatchiiyearexp[2].value=NanNumber(eval(val2)-eval(val1));
roundtxt(document.forms[0].txt_iibatchiiyearexp[2]);
var val4=document.forms[0].txt_iibatchiyearexp[2].value;
document.forms[0].txt_ibatchexpiiiyear[1].value=NanNumber(eval(val4)-eval(document.forms[0].txt_iibatchiiyearexp[2].value));
}
if(eval(val1)>eval(val2))
{
document.forms[0].txt_iibatchiyearexp[2].value=eval(val2);
roundtxt(document.forms[0].txt_iibatchiyearexp[2]);
document.forms[0].txt_ibatchexpiiiyear[0].value=NanNumber(eval(val1)-eval(val2));
document.forms[0].txt_iibatchiiyearexp[2].value="0.00";
document.forms[0].txt_ibatchexpiiiyear[1].value=eval(val1);
}
if(eval(val1)==eval(val2))
{
document.forms[0].txt_ibatchexpiiiyear[0].value="0.00";
document.forms[0].txt_iibatchiyearexp[2].value=eval(val2);
roundtxt(document.forms[0].txt_iibatchiyearexp[2]);
document.forms[0].txt_iibatchiiyearexp[2].value=eval(val2);
roundtxt(document.forms[0].txt_iibatchiiyearexp[2]);
document.forms[0].txt_ibatchexpiiiyear[1].value="0.00";
}*/
}
function costexpenses3()
{

/*var val1=document.forms[0].txt_exp[3].value;
var val2=document.forms[0].txt_bank[3].value;
if(eval(val1)<eval(val2))
{
document.forms[0].txt_iibatchiyearexp[3].value=eval(val1);
roundtxt(document.forms[0].txt_iibatchiyearexp[3]);
document.forms[0].txt_ibatchexpivyear[0].value="0.00";
document.forms[0].txt_iibatchiiyearexp[3].value=NanNumber(eval(val2)-eval(val1));
roundtxt(document.forms[0].txt_iibatchiiyearexp[3]);
var val4=document.forms[0].txt_iibatchiyearexp[3].value;
document.forms[0].txt_ibatchexpivyear[1].value=NanNumber(eval(val4)-eval(document.forms[0].txt_iibatchiiyearexp[3].value));
if(document.forms[0].txt_ibatchexpivyear[1].value=="NaN")
{
document.forms[0].txt_ibatchexpivyear[1].value="0.00";
}
}
if(eval(val1)>eval(val2))
{
document.forms[0].txt_iibatchiyearexp[3].value=eval(val2);
roundtxt(document.forms[0].txt_iibatchiyearexp[3]);
document.forms[0].txt_ibatchexpivyear[0].value=NanNumber(eval(val1)-eval(val2));
roundtxt(document.forms[0].txt_ibatchexpivyear[0]);
document.forms[0].txt_iibatchiiyearexp[3].value="0.00";
document.forms[0].txt_ibatchexpivyear[1].value=eval(val1);
if(document.forms[0].txt_ibatchexpivyear[1].value=="NaN")
{
document.forms[0].txt_ibatchexpivyear[1].value="0.00";
}
if(document.forms[0].txt_ibatchexpivyear[1].value=="NaN")
{
document.forms[0].txt_ibatchexpivyear[1].value="0.00";
}
}
if(eval(val1)==eval(val2))
{
document.forms[0].txt_ibatchexpivyear[0].value="0.00";
document.forms[0].txt_iibatchiyearexp[3].value=eval(val2);
roundtxt(document.forms[0].txt_iibatchiyearexp[3]);
document.forms[0].txt_iibatchiiyearexp[3].value=eval(val2);
roundtxt(document.forms[0].txt_iibatchiiyearexp[3]);
document.forms[0].txt_ibatchexpivyear[1].value="0.00";
}*/
}
function costexpenses4()
{

/*var val1=document.forms[0].txt_exp[4].value;
var val2=document.forms[0].txt_bank[4].value;
if(eval(val1)<eval(val2))
{
document.forms[0].txt_iibatchiyearexp[4].value=eval(val1);
roundtxt(document.forms[0].txt_iibatchiyearexp[4]);
document.forms[0].txt_ibatchexpvyear[0].value="0.00";
document.forms[0].txt_iibatchiiyearexp[4].value=NanNumber(eval(val2)-eval(val1));
roundtxt(document.forms[0].txt_iibatchiiyearexp[4]);
var val4=document.forms[0].txt_iibatchiyearexp[4].value;
document.forms[0].txt_ibatchexpvyear[1].value=NanNumber(eval(val4)-eval(document.forms[0].txt_iibatchiiyearexp[4].value));
if(document.forms[0].txt_ibatchexpvyear[1].value=="NaN")
{
document.forms[0].txt_ibatchexpvyear[1].value="0.00";
}
}
if(eval(val1)>eval(val2))
{
document.forms[0].txt_iibatchiyearexp[4].value=eval(val2);
roundtxt(document.forms[0].txt_iibatchiyearexp[4]);
document.forms[0].txt_ibatchexpvyear[0].value=NanNumber(eval(val1)-eval(val2));
document.forms[0].txt_iibatchiiyearexp[4].value="0.00";
document.forms[0].txt_ibatchexpvyear[1].value=eval(val1);
if(document.forms[0].txt_ibatchexpvyear[1].value=="NaN")
{
document.forms[0].txt_ibatchexpvyear[1].value="0.00";
}
}
if(eval(val1)==eval(val2))
{
document.forms[0].txt_ibatchexpvyear[0].value="0.00";
document.forms[0].txt_iibatchiyearexp[4].value=eval(val2);
roundtxt(document.forms[0].txt_iibatchiyearexp[4]);
document.forms[0].txt_iibatchiiyearexp[4].value=eval(val2);
roundtxt(document.forms[0].txt_iibatchiiyearexp[4]);
document.forms[0].txt_ibatchexpvyear[1].value="0.00";
}*/
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/retailpge.jsp";	
		document.forms[0].submit();
	}
}

function disableFields(one)
{	
	for(var s=0;s<document.forms[0].length;s++)
	{
		if(document.forms[0].elements[s].type=="text")
		{
			document.forms[0].elements[s].readOnly=one;
		}	  
	   if(document.forms[0].elements[s].type=="textarea")
		{
			document.forms[0].elements[s].readOnly=one;		  
		}		
	}	
}

function doSave()
{	
   
	enableButtons( true, true, true, true, false);	
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="agrpoultry";
	document.forms[0].hidSourceUrl.value="/action/agr_poultry_flowchart.jsp";
	document.forms[0].hidBeanMethod.value="updatepoultryflowchartData";
	document.forms[0].hidBeanGetMethod.value="getpoultryflowchartData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doEdit()
{
	disableFields(true);
   	document.forms[0].hidAction.value ="insert";
   	enableButtons(true, false, false, false, true);	
}

function callhelp()
{
	var varQryString = appURL+"/jsp/perhlp/hlp_edueducational.jsp"
	var title = "ApplicantDemographics";
	var prop = "scrollbars=no,width=600,height=450";	
	prop = prop + ",left=200,top=150";
	window.open(varQryString,title,prop);
}
 
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agrpoultry";
		document.forms[0].hidBeanGetMethod.value="getpoultryflowchartData";
		document.forms[0].action=appURL+"action/agr_poultry_flowchart.jsp";
		document.forms[0].submit(); 		
	}

}

function doDelete()
{
	if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appURL+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updatepoultryflowchartData";
	document.forms[0].hidBeanGetMethod.value="getpoultryflowchartData";
	document.forms[0].hidBeanId.value="agrpoultry";
	document.forms[0].hidSourceUrl.value="action/agr_poultry_flowchart.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();
	}		
}

function onloading()
{	  
   	if(nodata=="Y")
	{
		alert("Enter Data in Layer Flock Replacement page");
	}
	disableFields(true);
	//costvtaid();
	//costins();
	//costtransport();
	//labour();water();electricity();
}

function enableButtons( bool2, bool3, bool4, bool5, bool6)
{	
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}
function calculate()
{
	/*var totalvalue1=0.00;var totalvalue2=0.00;
	for(var i=0;i<1;i++)
	{
		var txt_ibatchiyear=document.forms[0].txt_ibatchiyear[i].value;
		var txt_ibatchiiyear=document.forms[0].txt_ibatchiiyear[i].value;
		var txt_ibatchiiiyear=document.forms[0].txt_ibatchiiiyear[i].value;
		var txt_ibatchivyear=document.forms[0].txt_ibatchivyear[i].value;
		var txt_ibatchvyear=document.forms[0].txt_ibatchvyear[i].value;
		var txt_ibatchviyear=document.forms[0].txt_ibatchviyear[i].value;
		var txt_ibatchviiyear=document.forms[0].txt_ibatchviiyear[i].value;
		var txt_ibatchviiiyear=document.forms[0].txt_ibatchviiiyear[i].value;
		var txt_ibatchixyear=document.forms[0].txt_ibatchixyear[i].value;
		var txt_ibatchxyear=document.forms[0].txt_ibatchxyear[i].value;
		
		
		document.forms[0].txt_totiyearu.value=NanNumber(eval(txt_ibatchiyear)+eval(txt_ibatchiiyear)+eval(txt_ibatchiiiyear)+eval(txt_ibatchivyear)+eval(txt_ibatchvyear)+eval(txt_ibatchviyear)+eval(txt_ibatchviiyear)+eval(txt_ibatchviiiyear)+eval(txt_ibatchixyear)
		+eval(txt_ibatchxyear));
		roundtxt(document.forms[0].txt_totiyearu);
	}
	for(var i=1;i<2;i++)
	{
		var txt_ibatchiyear=document.forms[0].txt_ibatchiyear[i].value;
		var txt_ibatchiiyear=document.forms[0].txt_ibatchiiyear[i].value;
		var txt_ibatchiiiyear=document.forms[0].txt_ibatchiiiyear[i].value;
		var txt_ibatchivyear=document.forms[0].txt_ibatchivyear[i].value;
		var txt_ibatchvyear=document.forms[0].txt_ibatchvyear[i].value;
		var txt_ibatchviyear=document.forms[0].txt_ibatchviyear[i].value;
		var txt_ibatchviiyear=document.forms[0].txt_ibatchviiyear[i].value;
		var txt_ibatchviiiyear=document.forms[0].txt_ibatchviiiyear[i].value;
		var txt_ibatchixyear=document.forms[0].txt_ibatchixyear[i].value;
		var txt_ibatchxyear=document.forms[0].txt_ibatchxyear[i].value;
		
		document.forms[0].txt_totaliiyearu.value=NanNumber(eval(txt_ibatchiyear)+eval(txt_ibatchiiyear)+eval(txt_ibatchiiiyear)+eval(txt_ibatchivyear)+eval(txt_ibatchvyear)+eval(txt_ibatchviyear)+eval(txt_ibatchviiyear)+eval(txt_ibatchviiiyear)+eval(txt_ibatchixyear)
		+eval(txt_ibatchxyear));
		roundtxt(document.forms[0].txt_totaliiyearu);
	}
	for(var i=2;i<3;i++)
	{
		var txt_ibatchiyear=document.forms[0].txt_ibatchiyear[i].value;
		var txt_ibatchiiyear=document.forms[0].txt_ibatchiiyear[i].value;
		var txt_ibatchiiiyear=document.forms[0].txt_ibatchiiiyear[i].value;
		var txt_ibatchivyear=document.forms[0].txt_ibatchivyear[i].value;
		var txt_ibatchvyear=document.forms[0].txt_ibatchvyear[i].value;
		var txt_ibatchviyear=document.forms[0].txt_ibatchviyear[i].value;
		var txt_ibatchviiyear=document.forms[0].txt_ibatchviiyear[i].value;
		var txt_ibatchviiiyear=document.forms[0].txt_ibatchviiiyear[i].value;
		var txt_ibatchixyear=document.forms[0].txt_ibatchixyear[i].value;
		var txt_ibatchxyear=document.forms[0].txt_ibatchxyear[i].value;
		
		document.forms[0].txt_totaliiiyearu.value=NanNumber(eval(txt_ibatchiyear)+eval(txt_ibatchiiyear)+eval(txt_ibatchiiiyear)+eval(txt_ibatchivyear)+eval(txt_ibatchvyear)+eval(txt_ibatchviyear)+eval(txt_ibatchviiyear)+eval(txt_ibatchviiiyear)+eval(txt_ibatchixyear)
		+eval(txt_ibatchxyear));
		roundtxt(document.forms[0].txt_totaliiiyearu);
	}
	for(var i=3;i<4;i++)
	{
		var txt_ibatchiyear=document.forms[0].txt_ibatchiyear[i].value;
		var txt_ibatchiiyear=document.forms[0].txt_ibatchiiyear[i].value;
		var txt_ibatchiiiyear=document.forms[0].txt_ibatchiiiyear[i].value;
		var txt_ibatchivyear=document.forms[0].txt_ibatchivyear[i].value;
		var txt_ibatchvyear=document.forms[0].txt_ibatchvyear[i].value;
		var txt_ibatchviyear=document.forms[0].txt_ibatchviyear[i].value;
		var txt_ibatchviiyear=document.forms[0].txt_ibatchviiyear[i].value;
		var txt_ibatchviiiyear=document.forms[0].txt_ibatchviiiyear[i].value;
		var txt_ibatchixyear=document.forms[0].txt_ibatchixyear[i].value;
		var txt_ibatchxyear=document.forms[0].txt_ibatchxyear[i].value;
		
		document.forms[0].txt_totalivyearu.value=NanNumber(eval(txt_ibatchiyear)+eval(txt_ibatchiiyear)+eval(txt_ibatchiiiyear)+eval(txt_ibatchivyear)+eval(txt_ibatchvyear)+eval(txt_ibatchviyear)+eval(txt_ibatchviiyear)+eval(txt_ibatchviiiyear)+eval(txt_ibatchixyear)
		+eval(txt_ibatchxyear));
		roundtxt(document.forms[0].txt_totalivyearu);
		}
		for(var i=4;i<5;i++)
		{
		var txt_ibatchiyear=document.forms[0].txt_ibatchiyear[i].value;
		var txt_ibatchiiyear=document.forms[0].txt_ibatchiiyear[i].value;
		var txt_ibatchiiiyear=document.forms[0].txt_ibatchiiiyear[i].value;
		var txt_ibatchivyear=document.forms[0].txt_ibatchivyear[i].value;
		var txt_ibatchvyear=document.forms[0].txt_ibatchvyear[i].value;
		var txt_ibatchviyear=document.forms[0].txt_ibatchviyear[i].value;
		var txt_ibatchviiyear=document.forms[0].txt_ibatchviiyear[i].value;
		var txt_ibatchviiiyear=document.forms[0].txt_ibatchviiiyear[i].value;
		var txt_ibatchixyear=document.forms[0].txt_ibatchixyear[i].value;
		var txt_ibatchxyear=document.forms[0].txt_ibatchxyear[i].value;
		
		document.forms[0].txt_totalvyearu.value=NanNumber(eval(txt_ibatchiyear)+eval(txt_ibatchiiyear)+eval(txt_ibatchiiiyear)+eval(txt_ibatchivyear)+eval(txt_ibatchvyear)+eval(txt_ibatchviyear)+eval(txt_ibatchviiyear)+eval(txt_ibatchviiiyear)+eval(txt_ibatchixyear)
		+eval(txt_ibatchxyear));
		roundtxt(document.forms[0].txt_totalvyearu);
		}
		for(var i=5;i<6;i++)
		{
		var txt_ibatchiyear=document.forms[0].txt_ibatchiyear[i].value;
		var txt_ibatchiiyear=document.forms[0].txt_ibatchiiyear[i].value;
		var txt_ibatchiiiyear=document.forms[0].txt_ibatchiiiyear[i].value;
		var txt_ibatchivyear=document.forms[0].txt_ibatchivyear[i].value;
		var txt_ibatchvyear=document.forms[0].txt_ibatchvyear[i].value;
		var txt_ibatchviyear=document.forms[0].txt_ibatchviyear[i].value;
		var txt_ibatchviiyear=document.forms[0].txt_ibatchviiyear[i].value;
		var txt_ibatchviiiyear=document.forms[0].txt_ibatchviiiyear[i].value;
		var txt_ibatchixyear=document.forms[0].txt_ibatchixyear[i].value;
		var txt_ibatchxyear=document.forms[0].txt_ibatchxyear[i].value;
		
		document.forms[0].txt_totalviyearu.value=NanNumber(eval(txt_ibatchiyear)+eval(txt_ibatchiiyear)+eval(txt_ibatchiiiyear)+eval(txt_ibatchivyear)+eval(txt_ibatchvyear)+eval(txt_ibatchviyear)+eval(txt_ibatchviiyear)+eval(txt_ibatchviiiyear)+eval(txt_ibatchixyear)
		+eval(txt_ibatchxyear));
		roundtxt(document.forms[0].txt_totalviyearu)
	}
	for(var i=6;i<7;i++)
	{
		var txt_ibatchiyear=document.forms[0].txt_ibatchiyear[i].value;
		var txt_ibatchiiyear=document.forms[0].txt_ibatchiiyear[i].value;
		var txt_ibatchiiiyear=document.forms[0].txt_ibatchiiiyear[i].value;
		var txt_ibatchivyear=document.forms[0].txt_ibatchivyear[i].value;
		var txt_ibatchvyear=document.forms[0].txt_ibatchvyear[i].value;
		var txt_ibatchviyear=document.forms[0].txt_ibatchviyear[i].value;
		var txt_ibatchviiyear=document.forms[0].txt_ibatchviiyear[i].value;
		var txt_ibatchviiiyear=document.forms[0].txt_ibatchviiiyear[i].value;
		var txt_ibatchixyear=document.forms[0].txt_ibatchixyear[i].value;
		var txt_ibatchxyear=document.forms[0].txt_ibatchxyear[i].value;
		
		document.forms[0].txt_totalviiyearu.value=NanNumber(eval(txt_ibatchiyear)+eval(txt_ibatchiiyear)+eval(txt_ibatchiiiyear)+eval(txt_ibatchivyear)+eval(txt_ibatchvyear)+eval(txt_ibatchviyear)+eval(txt_ibatchviiyear)+eval(txt_ibatchviiiyear)+eval(txt_ibatchixyear)
		+eval(txt_ibatchxyear));
		roundtxt(document.forms[0].txt_totalviiyearu);
	}
	for(var i=7;i<8;i++)
	{
		var txt_ibatchiyear=document.forms[0].txt_ibatchiyear[i].value;
		var txt_ibatchiiyear=document.forms[0].txt_ibatchiiyear[i].value;
		var txt_ibatchiiiyear=document.forms[0].txt_ibatchiiiyear[i].value;
		var txt_ibatchivyear=document.forms[0].txt_ibatchivyear[i].value;
		var txt_ibatchvyear=document.forms[0].txt_ibatchvyear[i].value;
		var txt_ibatchviyear=document.forms[0].txt_ibatchviyear[i].value;
		var txt_ibatchviiyear=document.forms[0].txt_ibatchviiyear[i].value;
		var txt_ibatchviiiyear=document.forms[0].txt_ibatchviiiyear[i].value;
		var txt_ibatchixyear=document.forms[0].txt_ibatchixyear[i].value;
		var txt_ibatchxyear=document.forms[0].txt_ibatchxyear[i].value;
		
		document.forms[0].txt_totalviiiyearu.value=NanNumber(eval(txt_ibatchiyear)+eval(txt_ibatchiiyear)+eval(txt_ibatchiiiyear)+eval(txt_ibatchivyear)+eval(txt_ibatchvyear)+eval(txt_ibatchviyear)+eval(txt_ibatchviiyear)+eval(txt_ibatchviiiyear)+eval(txt_ibatchixyear)
		+eval(txt_ibatchxyear));
		roundtxt(document.forms[0].txt_totalviiiyearu);
	}
	
	if(document.forms[0].exp_firsstyear)
	{
		var len = document.forms[0].exp_firsstyear.length;
		
		var total1="0",exp_firsstyear="0";
		var total2="0",exp_secondyear="0";
		var total3="0",exp_thirdyear="0";
		var total4="0",exp_fourthyear="0";
		var total5="0",exp_fifthyear="0";
		var total6="0",exp_sixthyear="0";
		var total7="0",exp_seventhyear="0";
		var total8="0",exp_eigthyear="0";
		
		
		if(len==null)
		{
			if(document.forms[0].exp_firsstyear.value=="")
				{
					document.forms[0].exp_firsstyear.value="0";
				}
				if(document.forms[0].exp_secondyear.value=="")
				{
					document.forms[0].exp_secondyear.value="0";
				}
				if(document.forms[0].exp_thirdyear.value=="")
				{
					document.forms[0].exp_thirdyear.value="0";
				}
				if(document.forms[0].exp_fourthyear.value=="")
				{
					document.forms[0].exp_fourthyear.value="0";
				}
				if(document.forms[0].exp_fifthyear.value=="")
				{
					document.forms[0].exp_fifthyear.value="0";
				}
				if(document.forms[0].exp_sixthyear.value=="")
				{
					document.forms[0].exp_sixthyear.value="0";
				}
				if(document.forms[0].exp_seventhyear.value=="")
				{
					document.forms[0].exp_seventhyear.value="0";
				}
				if(document.forms[0].exp_eigthyear.value=="")
				{
					document.forms[0].exp_eigthyear.value="0";
				}
			
			total1 = document.forms[0].exp_firsstyear.value;
			total2 = document.forms[0].exp_secondyear.value;
			total3 = document.forms[0].exp_thirdyear.value;
			total4 = document.forms[0].exp_fourthyear.value;
			total5 = document.forms[0].exp_fifthyear.value;
			total6 = document.forms[0].exp_sixthyear.value;
			total7 = document.forms[0].exp_seventhyear.value;
			total8 = document.forms[0].exp_eigthyear.value;
			
		}
		else
		{
		 	for(var i =0;i<len;i++)
			{
				exp_firsstyear = document.forms[0].exp_firsstyear[i].value;
				exp_secondyear = document.forms[0].exp_secondyear[i].value;
				exp_thirdyear = document.forms[0].exp_thirdyear[i].value;
				exp_fourthyear = document.forms[0].exp_fourthyear[i].value;
				exp_fifthyear = document.forms[0].exp_fifthyear[i].value;
				exp_sixthyear = document.forms[0].exp_sixthyear[i].value;
				exp_seventhyear = document.forms[0].exp_seventhyear[i].value;
				exp_eigthyear = document.forms[0].exp_eigthyear[i].value;
				
				if(document.forms[0].exp_firsstyear[i].value=="")
				{
					exp_firsstyear="0";
					document.forms[0].exp_firsstyear[i].value="0";
				}
				if(document.forms[0].exp_secondyear[i].value=="")
				{
					exp_secondyear="0";
					document.forms[0].exp_secondyear[i].value="0";
				}
				if(document.forms[0].exp_thirdyear[i].value=="")
				{
					exp_thirdyear="0";
					document.forms[0].exp_thirdyear[i].value="0";
				}
				if(document.forms[0].exp_fourthyear[i].value=="")
				{
					exp_fourthyear="0";
					document.forms[0].exp_fourthyear[i].value="0";
				}
				if(document.forms[0].exp_fifthyear[i].value=="")
				{
					exp_fifthyear="0";
					document.forms[0].exp_fifthyear[i].value="0";
				}
				if(document.forms[0].exp_sixthyear[i].value=="")
				{
					exp_sixthyear="0";
					document.forms[0].exp_sixthyear[i].value="0";
				}
				if(document.forms[0].exp_seventhyear[i].value=="")
				{
					exp_seventhyear="0";
					document.forms[0].exp_seventhyear[i].value="0";
				}
				if(document.forms[0].exp_eigthyear[i].value=="")
				{
					exp_eigthyear="0";
					document.forms[0].exp_eigthyear[i].value="0";
				}
				
				total1 = eval(total1) + eval(exp_firsstyear);
				total2 = eval(total2) + eval(exp_secondyear);
				total3 = eval(total3) + eval(exp_thirdyear);
				total4 = eval(total4) + eval(exp_fourthyear);
				total5 = eval(total5) + eval(exp_fifthyear);
				total6 = eval(total6) + eval(exp_sixthyear);
				total7 = eval(total7) + eval(exp_seventhyear);
				total8 = eval(total8) + eval(exp_eigthyear);
			}
			
			document.forms[0].txt_totiyearu.value=eval(document.forms[0].txt_totiyearu.value)+eval(total1);
			document.forms[0].txt_totaliiyearu.value=eval(document.forms[0].txt_totaliiyearu.value)+eval(total2);
			document.forms[0].txt_totaliiiyearu.value=eval(document.forms[0].txt_totaliiiyearu.value)+eval(total3);
			document.forms[0].txt_totalivyearu.value=eval(document.forms[0].txt_totalivyearu.value)+eval(total4);
			document.forms[0].txt_totalvyearu.value=eval(document.forms[0].txt_totalvyearu.value)+eval(total5);
			document.forms[0].txt_totalviyearu.value=eval(document.forms[0].txt_totalviyearu.value)+eval(total6);
			document.forms[0].txt_totalviiyearu.value=eval(document.forms[0].txt_totalviiyearu.value)+eval(total7);
			document.forms[0].txt_totalviiiyearu.value=eval(document.forms[0].txt_totalviiiyearu.value)+eval(total8);
		}
	}*/
	
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onloading();costchicks();costfeed();costgrower();costlayer();costexpenses0();calculate()">
<form name="frmpri" method="post" class="normal">
<!-- <div class="cellContainer"> -->
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td valign="top">		
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
					<tr>
						
                  <td> 
					<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable border1">
                      <tr> 
                        <td > 
						<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                            <tr class="dataheader"> 
                              <td rowspan="2" nowrap><b>Expenditure 
                                On </b></td>
                              <td colspan="8" align="center"><b>(Amount 
                                in Rs.) </b></td>
                            </tr>
                            <tr class="dataheader"> 
                              <td align="center"><b>I 
                                Year</b></td>
                              <td align="center"><b>II 
                                Year </b></td>
                              <td align="center"><b>III 
                                Year</b></td>
                              <td align="center"><b>IV 
                                Year</b></td>
                              <td align="center"><b>V 
                                Year</b></td>
                              <td align="center"><b>VI 
                                Year</b></td>
                              <td align="center"><b>VII 
                                Year</b></td>
                              <td align="center"><b>VIII 
                                Year</b></td>
                            </tr>
                            <tr> 
                              <td rowspan="2" >Purchase 
                                of chicks 
                               
                                <input type="hidden" name="txt_ibatch"size="3"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              
                              </td>
                              <td width="7%" align="center" ><lapschoice:CurrencyTag name="txt_ibatchiyear" size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrPurchase.get(0))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/> </td>
                              <td width="7%" align="center"><lapschoice:CurrencyTag name="txt_ibatchiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrPurchase.get(1))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/> </td>
                              <td width="7%" rowspan="2" align="center" ><lapschoice:CurrencyTag name="txt_ibatchiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrPurchase.get(2))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td width="7%" rowspan="2" align="center" ><lapschoice:CurrencyTag name="txt_ibatchiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrPurchase.get(3))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td width="7%" rowspan="2" align="center" ><lapschoice:CurrencyTag name="txt_ibatchiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrPurchase.get(4))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td width="7%" rowspan="2" align="center" ><lapschoice:CurrencyTag name="txt_ibatchiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrPurchase.get(5))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td width="7%" rowspan="2" align="center" ><lapschoice:CurrencyTag name="txt_ibatchiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrPurchase.get(6))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td width="7%" rowspan="2" align="center" > <lapschoice:CurrencyTag name="txt_ibatchiyear"  size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrPurchase.get(7))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(1);
				
				if (arryCol.size() != 0) {
					 
					a1 = Helper.correctNull((String) arryCol.get(0));
					
				}
			
			} else if (arryRow.size() == 0) {
				a1 = "";
				
				
			}

			%>
                             </tr>
                            <tr> 
                              <td rowspan="2">Feeding 
                                of chicks 
                              
                                <input type="hidden" name="txt_ibatchfeed"size="3"
									maxlength="15" value="" onKeyPress="allowInteger()" style="text-align:right;">
                                 
                              
                                </td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchiiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrChicksMash.get(0))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchiiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrChicksMash.get(1))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchiiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrChicksMash.get(2))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchiiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrChicksMash.get(3))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchiiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrChicksMash.get(4))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchiiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrChicksMash.get(5))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchiiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrChicksMash.get(6))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchiiyear"  size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrChicksMash.get(7))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(2);
				
				if (arryCol.size() != 0) {
					 
					a2 = Helper.correctNull((String) arryCol.get(0));
					
				}
			
			} else if (arryRow.size() == 0) {
				a2 = "";
				
				
			}

			%>
                              <%--<td align="center" bgcolor="#71694F" ><lapschoice:CurrencyTag name="txt_iibatchiyear"size="15"
									maxlength="15" value='<%=a2%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"  bgcolor="#71694F"><lapschoice:CurrencyTag name="txt_iibatchiiyear"size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>--%>
                            </tr>
                            <tr> 
                              <td rowspan="2">Feeding 
                                of growers 
                              
                               
                                <input type="hidden" name="txt_ibatchgrow"size="3"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                                 
                               
                                </td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchiiiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrGrowersMash.get(0))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchiiiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrGrowersMash.get(1))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchiiiyear"size="15" maxlength="15"
									value='<%=Helper.correctNull((String) arrGrowersMash.get(2))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchiiiyear"size="15" maxlength="15"
									value='<%=Helper.correctNull((String) arrGrowersMash.get(3))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchiiiyear"size="15" maxlength="15"
									value='<%=Helper.correctNull((String) arrGrowersMash.get(4))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchiiiyear"size="15" maxlength="15"
									value='<%=Helper.correctNull((String) arrGrowersMash.get(5))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchiiiyear"size="15" maxlength="15"
									value='<%=Helper.correctNull((String) arrGrowersMash.get(6))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchiiiyear"size="15" maxlength="15"
									value='<%=Helper.correctNull((String) arrGrowersMash.get(7))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(3);
				
				if (arryCol.size() != 0) {
					 
					a3 = Helper.correctNull((String) arryCol.get(0));
					
				}
			
			} else if (arryRow.size() == 0) {
				a3 = "";
				
				
			}

			%>
                             <%-- <td align="center" bgcolor="#71694F" ><lapschoice:CurrencyTag name="txt_iibatchiyear"size="15"
									maxlength="15" value='<%=a3%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"  bgcolor="#71694F"><lapschoice:CurrencyTag name="txt_iibatchiiyear"size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>--%>
                            </tr>
                            <tr> 
                              <td rowspan="2">Feeding 
                                of layers 
                             
                                <input type="hidden" name="txt_ibatchlayer"size="3"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                                 
                                </td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchivyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrLayersMash.get(0))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchivyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrLayersMash.get(1))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchivyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrLayersMash.get(2))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchivyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrLayersMash.get(3))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchivyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrLayersMash.get(4))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchivyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrLayersMash.get(5))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchivyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrLayersMash.get(6))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchivyear"  size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrLayersMash.get(7))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                             <%-- <td align="center" bgcolor="#71694F" ><lapschoice:CurrencyTag name="txt_iibatchiyear"size="15"
									maxlength="15" value='0' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"  bgcolor="#71694F"><lapschoice:CurrencyTag name="txt_iibatchiiyear"size="15"
									maxlength="15" value="0" onKeyPress="allowInteger()"
									style="text-align:right;"/></td>--%>
                            </tr>
                            <tr> 
                              <td rowspan="2">Labour 
                                charges </td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchvyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("salarypy"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchvyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("salarypy"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchvyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("salarypy"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchvyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("salarypy"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchvyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("salarypy"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchvyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("salarypy"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchvyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("salarypy"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchvyear"  size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("salarypy"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(4);
				
				
				
				
			}

			%>
                             <%-- <td align="center" bgcolor="#71694F" ><lapschoice:CurrencyTag name="txt_iibatchiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("labourcharge"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"  bgcolor="#71694F"><lapschoice:CurrencyTag name="txt_iibatchiiyear"size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>--%>
                            </tr>
                            <tr> 
                              <td rowspan="2">Water charges</td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchviyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("txt_watercharge"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchviyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("txt_watercharge"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchviyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("txt_watercharge"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchviyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("txt_watercharge"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchviyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("txt_watercharge"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchviyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("txt_watercharge"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchviyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("txt_watercharge"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchviyear"  size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("txt_watercharge"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(9);
				
				if (arryCol.size() != 0) {
					 
					a6 = Helper.correctNull((String) arryCol.get(0));
					
				}
			
			} else if (arryRow.size() == 0) {
				a6 = "";
				
				
			}

			%>
                              <%--<td align="center" bgcolor="#71694F" ><lapschoice:CurrencyTag name="txt_iibatchiyear"size="15"
									maxlength="15" value='<%=a6%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"  bgcolor="#71694F"><lapschoice:CurrencyTag name="txt_iibatchiiyear"size="15"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;"/></td>--%>
                            </tr>
                            <tr> 
                              <td rowspan="2">Electricity 
                                charges</td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchviiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("txt_electricitycharge"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchviiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("txt_electricitycharge"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchviiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("txt_electricitycharge"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchviiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("txt_electricitycharge"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchviiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("txt_electricitycharge"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchviiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("txt_electricitycharge"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchviiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("txt_electricitycharge"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchviiyear"  size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("txt_electricitycharge"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(10);
				
				if (arryCol.size() != 0) {
					 
					a7= Helper.correctNull((String) arryCol.get(0));
					
				}
			
			} else if (arryRow.size() == 0) {
				a7 = "";
				
				
			}

			%>
                              <%--<td align="center" bgcolor="#71694F" ><lapschoice:CurrencyTag name="txt_iibatchiyear"size="15"
									maxlength="15" value='<%=a7%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"  bgcolor="#71694F"><lapschoice:CurrencyTag name="txt_iibatchiiyear"size="15"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;"/></td>--%>
                            </tr>
                            <tr> 
                              <td rowspan="2">Veterinary 
                            
                             
                              
                                <input type="hidden" name="txt_ibatchvt"size="3"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              
                                </td>
                              <td align="center" height="22"><lapschoice:CurrencyTag name="txt_ibatchviiiyear" size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrVetriAid.get(0))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center" height="22"><lapschoice:CurrencyTag name="txt_ibatchviiiyear" size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrVetriAid.get(1))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchviiiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrVetriAid.get(2))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchviiiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrVetriAid.get(3))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchviiiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrVetriAid.get(4))%>' onKeyPress="allowInteger()"
									  /></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchviiiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrVetriAid.get(5))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchviiiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrVetriAid.get(6))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchviiiyear"  size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrVetriAid.get(7))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(11);
				
				if (arryCol.size() != 0) {
					 
					a8 = Helper.correctNull((String) arryCol.get(0));
					
				}
			

			} else if (arryRow.size() == 0) {
				a8 = "";
				
				
			}

			%>
                              <%--<td align="center" bgcolor="#71694F" ><lapschoice:CurrencyTag name="txt_iibatchiyear"size="15"
									maxlength="15" value='<%=a8%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"  bgcolor="#71694F"><lapschoice:CurrencyTag name="txt_iibatchiiyear"size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>--%>
                            </tr>
                            <tr> 
                              <td rowspan="2">Insurance 
                                of birds 
                          
                                <input type="hidden" name="txt_ibatchin"size="3"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                           
                                </td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchixyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrInsurance.get(0))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchixyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrInsurance.get(1))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchixyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrInsurance.get(2))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchixyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrInsurance.get(3))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchixyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrInsurance.get(4))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchixyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrInsurance.get(5))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchixyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrInsurance.get(6))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchixyear"  size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrInsurance.get(7))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(12);
				
				if (arryCol.size() != 0) {
					 
					a9 = Helper.correctNull((String) arryCol.get(0));
					
				}
			
			} else if (arryRow.size() == 0) {
				a9 = "";
				
				
			}

			%>
                              <%--<td align="center" bgcolor="#71694F" ><lapschoice:CurrencyTag name="txt_iibatchiyear"size="15"
									maxlength="15" value='<%=a9%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"  bgcolor="#71694F"><lapschoice:CurrencyTag name="txt_iibatchiiyear"size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>--%>
                            </tr>
                            <tr> 
                              <td rowspan="2">Transportation 
                                charges 
                             
                                <input type="hidden" name="txt_ibatchtc"size="3"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                                 
                             
                                </td>
                                
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchxyear" size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrTransporation.get(0))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchxyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrTransporation.get(1))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchxyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrTransporation.get(2))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
								<td rowspan="2" align="center">	<lapschoice:CurrencyTag name="txt_ibatchxyear" size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrTransporation.get(3))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchxyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrTransporation.get(4))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchxyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrTransporation.get(5))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchxyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrTransporation.get(6))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td rowspan="2" align="center"><lapschoice:CurrencyTag name="txt_ibatchxyear"  size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrTransporation.get(7))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(13);
				
				if (arryCol.size() != 0) {
					 
					a10 = Helper.correctNull((String) arryCol.get(0));
					
				}
			
			} else if (arryRow.size() == 0) {
				a10 = "";
				
				
			}

			%>
                             <%-- <td align="center" bgcolor="#71694F" ><lapschoice:CurrencyTag name="txt_iibatchiyear"size="15"
									maxlength="15" value='<%=a10%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"  bgcolor="#71694F"><lapschoice:CurrencyTag name="txt_iibatchiiyear"size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>--%>
                            </tr>
                           
     <%
	 	if (arryRow4.size() >0)
			{
			
				for(int i=0;i<arryRow4.size();i++)
				{
					arryCol4 = (ArrayList) arryRow4.get(0);
					
					if(arryCol4!=null)
					{%>
						<input type="hidden" name="txt_bank"size="15"
									maxlength="15" value="<%=Helper.correctNull((String)arryCol4.get(3))%>" onKeyPress="allowInteger()"
									style="text-align:right;">
					<%}
				}
				
         
			}
			if (arryRow1.size() != 0) 
			{
			   for(int i=0;i<arryRow1.size();i++)
			   {
			       arryCol1 = (ArrayList) arryRow1.get(i);
				   
				   %>
				
			
					 <tr> 
                              <td ><%=Helper.correctNull((String) arryCol1.get(0))%>
                                <input type="hidden" name="txt_exp"size="15"
									maxlength="15" value="<%=Helper.correctNull((String) arryCol1.get(1))%>" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                              <td align="center"><lapschoice:CurrencyTag name="exp_firsstyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arryCol1.get(1))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="exp_secondyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arryCol1.get(1))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td  align="center"><lapschoice:CurrencyTag name="exp_thirdyear" size="15" maxlength="15"
									value='<%=Helper.correctNull((String) arryCol1.get(1))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td ><lapschoice:CurrencyTag name="exp_fourthyear" size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arryCol1.get(1))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td  align="center"><lapschoice:CurrencyTag name="exp_fifthyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arryCol1.get(1))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td  align="center"><lapschoice:CurrencyTag name="exp_sixthyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arryCol1.get(1))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td  align="center"><lapschoice:CurrencyTag name="exp_seventhyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arryCol1.get(1))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td  align="center"><lapschoice:CurrencyTag name="exp_eigthyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arryCol1.get(1))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
		<%}
		}

			%>					
							
                            <tr> 
                             <%-- <td align="center" bgcolor="#71694F" ><lapschoice:CurrencyTag name="txt_iibatchiyearexp"size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"  bgcolor="#71694F"><lapschoice:CurrencyTag name="txt_iibatchiiyearexp"size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>--%>
                            </tr>
                           
                            <tr> 
                             <%-- <td align="center" bgcolor="#71694F" ><lapschoice:CurrencyTag name="txt_iibatchiyearexp"size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"  bgcolor="#71694F"><lapschoice:CurrencyTag name="txt_iibatchiiyearexp"size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>--%>
                            </tr>
                            
                              <%
                              ArrayList arrtotalExp = new ArrayList();
                              arrtotalExp  = (ArrayList) hshValues.get("arrTotalExpenses");
                              
                           	 if (arrtotalExp!=null && arrtotalExp.size()> 0) {
                           		
                            %>
                            <tr class="dataheader"> 
                              <td><b>Total(Expenditure)</b></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totiyearu" size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrtotalExp.get(0))%>' onKeyPress="allowInteger()"
									 style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totaliiyearu" size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrtotalExp.get(1))%>' onKeyPress="allowInteger()"
									 style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totaliiiyearu" size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrtotalExp.get(2))%>' onKeyPress="allowInteger()"
									 style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totalivyearu" size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrtotalExp.get(3))%>' onKeyPress="allowInteger()"
									 style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totalvyearu" size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrtotalExp.get(4))%>' onKeyPress="allowInteger()"

									 style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totalviyearu" size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrtotalExp.get(5))%>' onKeyPress="allowInteger()"
									 /></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totalviiyearu" size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrtotalExp.get(6))%>' onKeyPress="allowInteger()"
									 /></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totalviiiyearu" size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrtotalExp.get(7))%>' onKeyPress="allowInteger()"
									/></td>
                            </tr>
                           
                           <%
                           		}
							%>
							
                          </table>
						  
                        </td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
	</td>
</tr>
</table>
</td>
</tr>
</table>
<br/>				
<lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<input type="hidden" name="measurement" value="<%=Helper.correctNull((String)hshValues.get("land_measurement"))%>">
<input type="hidden" name="val" value="<%=Helper.correctNull((String)hshValues.get("salarypy"))%>">
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("auditFlag"))%>">
<lapschoice:agrihiddentag pageid="<%=PageId%>"/>		
  </form>
</body>
</html>