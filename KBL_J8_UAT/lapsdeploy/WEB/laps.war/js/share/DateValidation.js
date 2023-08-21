function checkDate(objName)
{
	var state = true;
	var day = "";
	var mon = "";
	var year = "";
	var index1;
	var index2;
	var index3;
	var delimiter = "";
	var datevalue = objName.value;
	var len = 0;
	if(datevalue != "")
	{
		len = datevalue.length;
		day = datevalue.substring(0,2);
		if(day.substring(1,2) == "/")
		{
			day = "0"+day.substring(0,1);
			mon = datevalue.substring(2,4);
			
			if(mon.substring(1,2) == "/")
			{	mon = "0"+mon;
				datevalue = day+"/"+mon+datevalue.substring(datevalue.length-4,datevalue.length);
			}
			else
			{
				datevalue = day+"/"+mon+"/"+datevalue.substring(datevalue.length-4,datevalue.length);
			}			
		}
		else 
		{
			mon = datevalue.substring(3,5);			
			if(mon.substring(1,2) == "/")
			{
				mon = "0"+mon;
				datevalue = day+"/"+mon+datevalue.substring(datevalue.length-4,datevalue.length);
			}
			else
			{
				datevalue = day+"/"+mon+"/"+datevalue.substring(datevalue.length-4,datevalue.length);
			}			
		}		
		index1 = datevalue.substring(2,3);
		index2 = datevalue.substring(5,6);		
		if( (index1 != "/") && (index2 != "/"))
		{
			state = false;
		}
		else
		{
			day = datevalue.substring(0,2);

			if(day.length < 2)
			{
				day = "0"+day;
			}
			mon = datevalue.substring(3,5);

			if(mon.length < 2)
			{
				mon = "0"+mon;
			}
			year = datevalue.substring(6,datevalue.length);
			if(!isCharacter(day) || !isCharacter(mon) || !isCharacter(year))
			{
				state = false;
			}
			else
			{
			
				if(parseInt(day) > 31 || parseInt(mon) > 12)
					state = false;
				else if(year.length == 3 || year.length > 4)
					state = false;
				else if(year.length == 4 && parseInt(year) == 0)
					state = false;
				else if(!validateDate(day,mon,year,objName))
					state = false;
			}
		}
	}
	if(!state)
	{
		alert("Not a valid date");
		objName.value = "";
		objName.focus();
		return false;
	}
	return true;
}

function changeDateformat(old_date)
{
	var saperator="/";
	var temp;
	var flag;
	flag = false;
	temp = old_date;
	var my_array = temp.split("/");
	var size_array = my_array.length;
	var maxsize = size_array;

	if (maxsize == 3)
	{
		if ( my_array[0].length == 1 )
		{
			my_array[0] = "0" + my_array[0]
		}
		if ( my_array[1].length == 1 )
		{
			my_array[1] = "0" + my_array[1]
		}		
		if ( my_array[2].length == 2 )
		{
			my_array[2] = "20" + my_array[2]
		}	
		New_date = my_array[1] + saperator + my_array[0] + saperator + my_array[2];
		flag = true;
	}
	if (flag == false)
	{
		New_date = old_date;
	}
	return(New_date);
}

function isCharacter(param)
{
	var state = true;
	for(i=0;i<param.length;i++)
	{
		if(param.charAt(i) < '0' || param.charAt(i) > '9')
		{
			state = false;
			break;
		}
		else
			state = true;
	}
	return state;
}	

function validateDate(day,mon,year,objName)
{
	var state = true;
	var lDate = parseInt(day,10);
	var	delimiter = "/";
	var lMonth = parseInt(mon,10);
	var lYear = parseInt(year,10);
	var febMonth;
	var finalDate;
	if(lDate == 0 || lMonth==0)
		state = false;
	else
	{
		if(lYear%4 == 0)
		{
			febMonth = 29;
			if(lYear%3000 == 0)
				febMonth = 30;
		}
		else 
			febMonth = 28;
		
		if((lMonth==1 && lDate>31) || (lMonth==2 && lDate>febMonth) || (lMonth==3 && lDate>31) || 
			(lMonth==4 && lDate>30) || (lMonth==5 && lDate>31) || (lMonth==6 && lDate>30) ||
			(lMonth==7 && lDate>31) || (lMonth==8 && lDate>31) || (lMonth==9 && lDate>30) ||
			(lMonth==10 && lDate>31) || (lMonth==11 && lDate>30) || (lMonth==12 && lDate>31))
		{
			state = false;
		}
		else
		{
			if(lDate < 9)
				day = "0" + lDate;
			if(lMonth < 9)
				mon = "0" + lMonth;
			if(lYear > 0 && lYear < 10)
				year = "200" + lYear;
			else if(lYear >= 10 && lYear <= 20)
				year = "20" + lYear;
			else if(lYear > 20 && lYear < 100)
				year = "19" + lYear;
			else if(lYear == 0)
				year = "2000";
			if(parseInt(year) > 1900)
			{
				finalDate = day + delimiter + mon  + delimiter + year;
				objName.value = finalDate;
			}
			else
				state = false;
		}
	}
	return state;
}

function checkmonthEnd(obj,val)
{
	var pagedate=obj.value;
	var pgdt=changeDateformat(pagedate);
	var vartoday=new Date(val.substring(6,currentDate.length), val.substring(3,5), val.substring(0,2));
	var varlastdayofMonth=new Date(vartoday.getFullYear(),vartoday.getMonth(),0);
	var varday=varlastdayofMonth.getDate();
	if(varday<10)varday='0'+varday;
	var varmonth=varlastdayofMonth.getMonth()+1;
	if(varmonth<10)varmonth='0'+varmonth;
	var varyear=varlastdayofMonth.getFullYear();
	var maxdate=varday+"/"+varmonth+"/"+varyear;
	var maxdt=changeDateformat(maxdate);
	//alert(pgdt+"==="+maxdt);
	if(obj.value!="")
	{
		if(Date.parse(pgdt) > Date.parse(maxdt))
		{
			alert("Date should not be greater than " +maxdate );
			obj.value="";
			return false;
		}
	}
	return true;
}
