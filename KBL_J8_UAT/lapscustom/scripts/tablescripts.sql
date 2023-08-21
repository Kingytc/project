alter table adv_dishonours drop column adv_dishundi;

alter table adv_dishonours drop column adv_distype;

alter table adv_dishonours drop column adv_discomments;

alter table adv_dishonours add (adv_dishonortype varchar2(100));

create table adv_borrowonhundi(
adv_bohappno varchar2(20),
adv_bohundi varchar2(2),
adv_bohtype varchar2(2),
adv_bohcomments varchar2(4000)
);

drop table adv_commentsonstatus;

create table adv_commentsonstatus 
   (	adv_comappno varchar2(50 byte), 
	adv_bowpayment varchar2(20 byte), 
	adv_local varchar2(20 byte), 
	adv_commit varchar2(20 byte), 
	adv_suppliers varchar2(20 byte), 
	adv_customer varchar2(20 byte), 
	adv_extentborrow number(18,2), 
	adv_natureborrow varchar2(4000 byte), 
	adv_commtonstatusrep varchar2(4000 byte)
   ) ;

alter table adv_billpurchase add(bill_type varchar2(100));

ALTER TABLE FACILITIES add (facility_intadjustment number(18,2)) ;

update facilities set facility_intadjustment=facility_margin, facility_margin=facility_application 

CREATE TABLE OPS_SUBSIDY
   (	OPS_APPNO VARCHAR2(50 BYTE), 
	OPS_GOVTSPONSOR VARCHAR2(3 BYTE), 
	OPS_SCHEMETYPE VARCHAR2(3 BYTE), 
	OPS_SUBSIDYAMT NUMBER(18,2), 
	OPS_SPONSORAGENCY VARCHAR2(3 BYTE), 
	OPS_SUBSIDYTYPE VARCHAR2(3 BYTE), 
	OPS_INCOME NUMBER(18,2), 
	OPS_INCOMESRC VARCHAR2(2000 BYTE)
   );

alter table operational_viability add(instalments_termloan number(18,2));

create table govtsponser_parameters(sel_govtscheme varchar2(20),
minage varchar2(40),maxage varchar2(40),maxagescst varchar2(40),
maxageexser varchar2(40),maxagephy varchar2(40),maxagewomen varchar2(40),
northeast varchar2(40),minedu varchar2(40),annualincome varchar2(40),
mobility varchar2(40),termloan varchar2(40),workingcapital varchar2(40),
sector varchar2(50),otherbuss varchar2(50),
margin varchar2(40),subsidy varchar2(50),maxsubamt varchar2(50),minreayment varchar2(40),
maxrepay varchar2(50),sustenance varchar2(50),shgmembers varchar2(50),
shgminmem varchar2(50),shgmaxmem varchar2(50),shgmaxloan varchar2(50));

alter table govtsponser_parameters add(othertl varchar2(200),otherwc varchar2(200));

create table ops_accountdetails(
ops_accountappno varchar2(20),
ops_accountbusinessnature varchar2(200),
ops_accountsectorcategory varchar2(3),
ops_accountassetclassification varchar2(10));

create table ops_inspectionreport
(
ins_appno varchar2(20),
ins_dateofvisit date,
ins_distance varchar2(25),
ins_businessper varchar2(10),
ins_natureofbusiness varchar2(10),
ins_businessaddr varchar2(100),
ins_purpose varchar2(100),
ins_amtreqd number(18,2),
ins_prisecurity varchar2(1000),
ins_collsecurity varchar2(1000),
ins_presentbanker varchar2(500),
ins_ourbranchname varchar2(250),
ins_othrbankname varchar2(250),
ins_ourloantype varchar2(200),
ins_othrloantype varchar2(200),
ins_ouramtsanc number(18,2),
ins_othramtsanc number(18,2),
ins_ourloandate date,
ins_othrloandate date,
ins_ourbalos number(18,2),
ins_othrbalos number(18,2),
ins_ouroverdue number(18,2),
ins_othroverdue number(18,2),
ins_kycpernameaddr varchar2(1000),
ins_kycperrelated varchar2(10),
ins_kycpersincewhen varchar2(75),
ins_appstayinaddr varchar2(50),
ins_opiniongathered varchar2(3000),
ins_proppernameaddr varchar2(1000),
ins_propneighbour varchar2(100),
ins_propinpossession varchar2(1000),
ins_proplocation varchar2(1000),
ins_officercomments varchar2(3000),
ins_landmarknorth varchar2(1500),
ins_landmarksouth varchar2(1500),
ins_landmarkeast varchar2(1500),
ins_landmarkwest varchar2(1500)
);

create table ops_inspectionfacility(
ins_appno varchar2(20),
ins_sno  varchar2(10),
ins_purpose varchar2(100),
ins_type varchar2(100),
ins_loanamount number(18,2)
);

alter table ADV_Liabilities add(liab_liabtype varchar2(20));

 drop table advnotes;
  
  create table advnotes
   (	appno varchar2(30 byte), 
	page_type varchar2(6 byte), 
	division_id varchar2(10 byte), 
	notes clob, 
	notes2 clob
   );

 alter table PER_STOCKS ADD (stoc_receiptint NUMBER(5,2), stoc_loanint NUMBER(5,2));

 ALTER TABLE AGR_COFFEETERM_TECH 
ADD ("AGR_TEAUNIT" VARCHAR2(5 CHAR))
;

ALTER TABLE AGR_COFFEETERM_TECH 
ADD ("AGR_RUBBERUNIT" VARCHAR2(5 CHAR))
;


create table agr_livestockrepchart(
agr_appno varchar2(20), lsr_year varchar2(5), openstock_male number(7,0),
openstock_female number(7,0), openstock_malekid number(7,0), openstock_femalekid number(7,0),
lambing_male number(7,0), lambing_female number(7,0), lambing_malekid number(7,0),
lambing_femalekid number(7,0), mortality_male number(7,0), mortality_female number(7,0),
mortality_malekid number(7,0), mortality_femalekid number(7,0), cullsale_male number(7,0),
cullsale_female number(7,0), cullsale_malekid number(7,0), cullsale_femalekid number(7,0),
purchase_male number(7,0), purchase_female number(7,0), purchase_malekid number(7,0),
purchase_femalekid number(7,0), closingstock_male number(7,0), closingstock_female number(7,0),
closingstock_malekid number(7,0), closingstock_femalekid number(7,0));

create table agr_stockparticulars
   (	agr_appno varchar2(20 byte), 
	agr_milchcattle number(18,0), 
	agr_avg_milk number(18,0), 
	agr_noanimals number(18,0), 
	agr_costanimals number(18,0), 
	agr_totalcost number(18,0), 
	agr_batch varchar2(3 char)
   );

alter table agr_livestock drop column (agr_milchcattle,
	agr_avg_milk, agr_noanimals, agr_costanimals,
	agr_totalcost, agr_batch);

alter table link add(lnk_logincount number(2,0));


//------------------------------Added by suresh as a begining script ----------------------//

//-- Sureshkumar Ganapathy on 02122008

alter table npa_statuspage1_part1 add(sta_regaddr varchar2(1000), 
sta_facaddr varchar2(1000), sta_facpremises varchar2(5));

//------------------------------Added by suresh as a begining script ----------------------//


//S.SATHYA MOORTHY
//@SINCE:02/12/2008

    alter table agr_fodder_livestock add(ls_breed4 varchar2(50),ls_breed5 varchar2(50),
                ls_breed6 varchar2(50),ls_breed7 varchar2(50),ls_breedno4 varchar2(10),
                ls_breedno5 varchar2(10),ls_breedno6 varchar2(10),ls_breedno7 varchar2(10));
                
              
//S.SATHYA MOORTHY
//@SINCE :03/12/2008

create table agr_com_techdetails
(agr_appno varchar2(20),agr_qualified number(2),agr_var_crop varchar2(4000),agr_avg_prod
varchar2 (50),agr_avg_sale number(20,2));
alter table agr_farmmechMinorIrrig add(agr_expect_addition number(25,2));


//A.V.Suresh Babu
//@SINCE 04/12/2008
CREATE TABLE PER_loanagainstdeposit
(
   loan_APPNO VARCHAR2(50),
   loan_SLNO NUMBER(18),
   loan_depno VARCHAR2(50),
   loan_issuebranch VARCHAR2(100),
   loan_STANDNAME VARCHAR2(500),
   loan_accno VARCHAR2(50),
   laon_dateofissue date,
   loan_faceval NUMBER(18,5),
   loan_rateofint NUMBER(18,2),
   loan_presentos NUMBER(18,2),
   loan_maturityval NUMBER(18,2),
   loan_tenure VARCHAR2(100),
 loan_matdate date,
 loan_rateincharges NUMBER(18,2),
loan_margin NUMBER(18,2)

);

//R.paulraj
//04/12/2008
alter table COM_COSTOFPROJECT modify(COM_OTHERS Varchar2(500));

//D.Thadeuse
//04/12/2008
CREATE TABLE followup_inspection_report
(
	MMR_CBSID VARCHAR2(20),
	MMR_CBSACCOUNTNO VARCHAR(20),
	ADDRESS VARCHAR(100),
	PRESENT_INS_DATE DATE,
	PRESENT_NAME VARCHAR2(50),
	PREVIOUS_INS_DATE DATE, 
	PREVIOUS_NAME VARCHAR2(50),
	DEVIATION VARCHAR2(4000), 
	DEVELOPMENT_PURPOSE VARCHAR2(4000),
	LOAN_FOR_SINKING VARCHAR2(4000),
	PURCHASE_OF_MACHINERY VARCHAR2(4000),
	SEASONAL_OPERATION VARCHAR2(4000),
	MEDIUM_TERM_LOAN VARCHAR2(4000),
	COMMENTS VARCHAR2(4000),
	PLACE VARCHAR2(50),
	DATE_VALUE DATE,
	NAME_VALUE VARCHAR2(50),
	DESIGNATION VARCHAR2(50)
);

alter table followup_inspection_report add(MMR_MONTH varchar2(20),MMR_YEAR varchar2(20));

CREATE TABLE STANDINGCROPS
(
	MMR_CBSID VARCHAR2(20),
	MMR_MONTH varchar2(20),
	MMR_YEAR varchar2(20),
	MMR_SLNO NUMBER(5),
	CROP VARCHAR2(50),
	ACERAGE VARCHAR2(50),
	CONDITION VARCHAR2(50)
);
//@S.SATHYA MOORTHY
//@SINCE ;06/12/2008
alter table agr_sheep_ecodata add(sheep_feedadult1 number(10,2),sheep_feedlamp1 number(10,2));


//@Sureshkumar Ganapathy
//@since 10/12/2008
update perapplicant set perapp_oldid=perapp_id where perapp_oldid is null;


//@S.SATHYA MOORTHY
//@SINCE 17/12/2008

create table per_renewal_details (per_appno varchar2(25),per_compliance varchar2(4000),
per_documents varchar2(4000),per_fdc varchar2(4000),per_audit varchar2(4000));



//@ R.PAUL RAJ
//@since 18/12/2008

alter table AGR_COFFEETERM_TECH modify(AGR_IRRIGATION varchar2(100));



//@S.SATHYA MOORTHY
//@SINCE 18/12/2008
                
 ALTER TABLE AGR_FISHERIES_OTHER_PARAM MODIFY(               
TANK_LENGTH                             VARCHAR2(35) ,                                                                                                                                                                                 
TANK_BREATH                             VARCHAR2(35) ,                                                                                                                                                                                 
TANK_DEBTH                              VARCHAR2(35) ,                                                                                                                                                                                 
NORMAL_WATER_LEVEL                      VARCHAR2(35) ,                                                                                                                                                                                 
SUMMAR_WATER_LEVEL                      VARCHAR2(35) ,                                                                                                                                                                                 
BOAT_LENGTH                             VARCHAR2(35)  ,                                                                                                                                                                                
BOAT_BREATH                             VARCHAR2(35) ,                                                                                                                                                                                 
BOAT_CATCH_CAPACITY                     VARCHAR2(35) 

);
);


//@S.SATHYA MOORTHY
//@SINCE 18/12/2008
ALTER TABLE AGR_SHEEP_TECHDATA MODIFY(
SHEEP_MALECOST                          VARCHAR2(20) ,
SHEEP_MALEAMOUNT                        VARCHAR2(22), 
SHEEP_FEMALECOST                        VARCHAR2(20),
SHEEP_TOTALANIMALCOST                   VARCHAR2(20) 
);

//@Thadeuse
//@since 19/12/2008
alter table npa_statusSuitfield add(suit_noreason varchar2(4000));

//@G.Sureshkumar 
//@Since 22/12/2008

alter table agr_poultry_expenses add
(poultry_sno varchar2(3));

//@ Thadeuse
//@since 22/12/2008
alter table FILINGS_LOCATION add(security_type varchar2(20));

//@sureshkumar
//@ 26/12/2008

create table com_proposalin(
prop_appno varchar2(20),
prop_valuesin varchar2(5)
);


//@Thadeuse
//@30/12/2008

create table com_pre_sanction_report(
appno 			varchar2(30),
visitdate 		date,
visitname1 		varchar2(50),
visitdes1		varchar2(50),
visitname2 		varchar2(50),
visitdes2 		varchar2(50),
visitname3 		varchar2(50),
visitdes3 		varchar2(50),
north 			varchar2(4000),
east 			varchar2(4000),
west 			varchar2(4000),
south 			varchar2(4000),
suitability 	varchar2(4000),
primary_security varchar2(4000),
coll_security 	varchar2(4000),
present_status 	varchar2(4000),
availability 	varchar2(4000),
licenses 		varchar2(4000),
operation 		varchar2(4000),
borrower_name 	varchar2(10),
proper_main 	varchar2(10),
credit_limit 	varchar2(4000),
confirmation 	varchar2(4000),
other_features 	varchar2(4000)
);


//@sureshkumar
//@31/12/2008

alter table mon_personalinfo add(
personal_contactname varchar2(75),
personal_contperdesign varchar2(100),
personal_contperphone varchar2(35),
personal_contpermobile varchar2(15)
);


create table mon_generalinfo(
gen_custid varchar2(15),
gen_month varchar2(2),
gen_year varchar2(4),
gen_acc_clasification varchar2(5),
gen_accStressY varchar2(2),
gen_accstress_reason varchar2(4000),
gen_accrestructY varchar2(2),
gen_accrestructreasons varchar2(4000),
gen_termscompiledY varchar2(2),
gen_termscompiledreasons varchar2(4000),
gen_presentyearrating varchar2(15),
gen_prevyearrating varchar2(15),
gen_downgradereason varchar2(4000),
gen_docobtained varchar2(2),
gen_creditauditdate date,
gen_docvetted varchar2(2),
gen_docvettedreasons varchar2(4000),
gen_docdeficiencies varchar2(4000)
);

//Ended by sureshkumar

//@NAME :S.SATHYA MOORTHY
//@DATE :31/12/2008

ALTER TABLE agr_poultry_broifindata MODIFY(
POULTRY_COSTCHICKS                      VARCHAR2(25),                                                                                                                                                                                   
POULTRY_TOTALCOSTCHICKS                 VARCHAR2(25),                                                                                                                                                                                   
POULTRY_COSTCHICKMASH                   VARCHAR2(25),                                                                                                                                                                                   
POULTRY_CONCHICKMASH                    VARCHAR2(25),                                                                                                                                                                                   
POULTRY_TOTALCHICKMASH                  VARCHAR2(25),                                                                                                                                                                                   
POULTRY_COSTGROWERMASH                  VARCHAR2(25),                                                                                                                                                                                   
POULTRY_CONGROWERMASH                   VARCHAR2(25),                                                                                                                                                                                   
POULTRY_TOTALGROWERMASH                 VARCHAR2(25),                                                                                                                                                                                   
POULTRY_TOTALFEEDCON                    VARCHAR2(25) ,                                                                                                                                                                                  
POULTRY_TOTALFEEDCOST                   VARCHAR2(25),                                                                                                                                                                                   
POULTRY_BROODINGMOR                     VARCHAR2(25) ,                                                                                                                                                                                  
POULTRY_BROODINGCHICKS                  VARCHAR2(25),
POULTRY_ELECTRICITYCHARGE               VARCHAR2(25),                                                                                                                                                                                   
POULTRY_WATERCHARGE                     VARCHAR2(25),                                                                                                                                                                                   
POULTRY_VTAID                           VARCHAR2(25),                                                                                                                                                                                   
POULTRY_INSPREMIUM                      VARCHAR2(25),                                                                                                                                                                                   
POULTRY_YIELDEGG                        VARCHAR2(25),                                                                                                                                                                                   
POULTRY_TOTSALEEGG                      VARCHAR2(25),                                                                                                                                                                                   
POULTRY_YIELDMANURE                     VARCHAR2(25),                                                                                                                                                                                   
POULTRY_SALEMANURE                      VARCHAR2(25),                                                                                                                                                                                   
POULTRY_SALEGUNNY                       VARCHAR2(25),                                                                                                                                                                                   
POULTRY_EMPTYBAG                        VARCHAR2(25),                                                                                                                                                                                   
POULTRY_TRANSPORTCHARGE                 VARCHAR2(25),                                                                                                                                                                                   
POULTRY_TOTALVTAID                      VARCHAR2(25),                                                                                                                                                                                   
POULTRY_TOTALINSPREMIUM                 VARCHAR2(25),                                                                                                                                                                                   
POULTRY_TOTSALEMANURE                   VARCHAR2(25),                                                                                                                                                                                   
POULTRY_TOTSALEBAG                      VARCHAR2(25));








//@ Name : R.Paulraj
//@ Date : 2/1/2009

alter table mon_generalinfo add(gen_borrowerdate date);

CREATE TABLE MON_EXCESS_REASON (gen_custid varchar2(15),gen_reasons varchar2(4000),gen_commencements varchar2(4000));


alter table MON_EXCESS_REASON add(gen_month varchar2(2), gen_year varchar2(4));


//@ Name : R.Paulraj
//@ Date : 3/1/2009


alter table adv_commentsonstatus add(adv_status_days varchar2(20));


update ADV_Liabilities set liab_limit=null;

alter table ADV_Liabilities modify(liab_limit varchar2(22));


//@ Name : V.Prashanth
//@ Date : 3/1/2009

ALTER TABLE ADV_DISHONOURS MODIFY ("ADV_DISRANGEAMT" VARCHAR2(100));

update ADV_DISHONOURS set ADV_DISRANGEAMT=''

//@ Name : R.Paulraj
//@ Date : 5/1/2009
alter table MON_EXCESS_REASON add(renewalcompiled varchar2(2), ren_submitted date, ren_submitted_reasons varchar2(4000), roc_reasons varchar2(4000));



//@ Name : R.Paulraj
//@ Date : 6/1/2009
alter table mon_generalinfo add(roc_reasons varchar2(4000));


update mmr_consortium set MMR_ASSETCLASIFICATION = null;

alter table mmr_consortium modify (MMR_ASSETCLASIFICATION varchar2(10));

//@ Name : R.Paulraj
//@ Date : 7/1/2009
alter table npa_statusSuitfield modify(SUIT_ADDRESS varchar2(4000));


//@ Name : M.Dinesh Kumar
//@ Date : 7/1/2009

ALTER TABLE SSI_ANTICIPATEDTURNOVER 
ADD ("AT_STOCKVALUE" NUMBER(12, 2));



ALTER TABLE SSI_ANTICIPATEDTURNOVER 
ADD ("AT_OUTSTANDINGVALUE" NUMBER(12, 2));



//@ Name : R.Paulraj
//@ Date : 8/1/2009

alter table adv_meanscapital add(rating varchar2(10), rating_grade varchar2(10));

alter table OPS_VEHICLEDETAILS add(VEH_ID VARCHAR2(25 BYTE));

//@ Name : M.DINESH KUMAR
//@ Date : 8/1/2009

ALTER TABLE SSI_COMPDETAILS 
ADD ("COMP_OTHERNEW" VARCHAR2(4000));

ALTER TABLE SSI_COMPDETAILS 
DROP COLUMN "COMP_NOOFEMP";

ALTER TABLE SSI_COMPDETAILS 
DROP COLUMN "COMP_NOOFPROPEMP";


//@ Name : R.Paulraj
//@ Date : 22/1/2009

to be done in live take care when u r doing
===========================================================================
update creditreport set  CR_OFFTELNO = null;							   |	
alter table creditreport modify (CR_OFFTELNO varchar2(22));                |
=========================================================================== 
//@ author: Sureshkumar
//@since 23.01.2009

ALTER TABLE PAGE_MASTER 
ADD ("PAGE_NAME" VARCHAR2(150 CHAR))
;

ALTER TABLE MON_GUARANTEE 
ADD ("GUARANTEE_ACCNO" VARCHAR2(16 BYTE))
;

ALTER TABLE AUDIT_TRIAL 
MODIFY ("USR_ID" VARCHAR2(20 CHAR))
;

@AUTHOR : SURESHKUMAR GANAPATHY
@SINCE : 04/02/2009
/**************************************************************************************************************
-- DELETING TOOLBAR_USERS
DELETE FROM TOOLBAR_USERS;
--  DELETING TOOLBAR_SCREENS
DELETE FROM TOOLBAR_SCREENS;
-- INSERTING into TOOLBAR_USERS
Insert into TOOLBAR_USERS (USR_ID,SCREEN_MODULE,SCREEN_ID) values ('admin',2,1);
Insert into TOOLBAR_USERS (USR_ID,SCREEN_MODULE,SCREEN_ID) values ('admin',2,2);
Insert into TOOLBAR_USERS (USR_ID,SCREEN_MODULE,SCREEN_ID) values ('admin',2,3);
Insert into TOOLBAR_USERS (USR_ID,SCREEN_MODULE,SCREEN_ID) values ('admin',3,4);
Insert into TOOLBAR_USERS (USR_ID,SCREEN_MODULE,SCREEN_ID) values ('admin',3,5);
-- INSERTING into TOOLBAR_SCREENS
Insert into TOOLBAR_SCREENS (SCREEN_MODULE,SCREEN_ID,SCREEN_NAME,SCREEN_JSP_PAGE,SCREEN_SEQ_NO,SCREEN_IMAGE) values (2,1,'Facility','facilities.jsp?hidBeanId=facilities&hidBeanMethod=&hidBeanGetMethod=getFacilityData',1,'img/toolbar/facilities.jpg');
Insert into TOOLBAR_SCREENS (SCREEN_MODULE,SCREEN_ID,SCREEN_NAME,SCREEN_JSP_PAGE,SCREEN_SEQ_NO,SCREEN_IMAGE) values (2,2,'Proposal','com_companydet.jsp?hidBeanId=comproposal&hidBeanMethod=&hidBeanGetMethod=getDataData',2,'img/toolbar/bankarange.jpg');
Insert into TOOLBAR_SCREENS (SCREEN_MODULE,SCREEN_ID,SCREEN_NAME,SCREEN_JSP_PAGE,SCREEN_SEQ_NO,SCREEN_IMAGE) values (2,3,'Executive Summary','exec_page1.jsp?hidBeanId=executive&hidBeanMethod=&hidBeanGetMethod=getData',3,'img/toolbar/appraisal.jpg');
Insert into TOOLBAR_SCREENS (SCREEN_MODULE,SCREEN_ID,SCREEN_NAME,SCREEN_JSP_PAGE,SCREEN_SEQ_NO,SCREEN_IMAGE) values (3,4,'Facility','ops_facilities.jsp?hidBeanId=facilities&hidBeanMethod=&hidBeanGetMethod=getOPSFacilityData',1,'img/toolbar/facilities.jpg');
Insert into TOOLBAR_SCREENS (SCREEN_MODULE,SCREEN_ID,SCREEN_NAME,SCREEN_JSP_PAGE,SCREEN_SEQ_NO,SCREEN_IMAGE) values (3,5,'Proposal','adv_meanscapital.jsp?hidBeanId=ADV1151&hidBeanMethod=&hidBeanGetMethod=getMeansCapital',2,'img/toolbar/bankarange.jpg');

***********************************************************************************************************/

@AUTHOR : V.prashanth
@SINCE : 20/04/2009

alter table bank_netfunds add(net_ownedfundsasno date)
alter table bank_netfunds add(net_totbankcreditasno date)
alter table bank_netfunds add(net_totbankcredit number(18,2))
alter table bank_netfunds add(net_singleborrinfra number(18,2))
alter table bank_netfunds add(net_groupborrinfra number(18,2))
alter table bank_netfunds add(net_olicompany number(18,2))
