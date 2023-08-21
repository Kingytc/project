@Author: G.Sureshkumar
@Since: 2-Jan-2010

alter table commst_securitydetails add mstsec_facsno varchar2(3);

========================================================================
@Author: V.Prashanthavel
@Since: 4-Jan-2010

alter table applications add(app_processorgscode varchar2(6));
alter table applications add(app_processusrclass varchar2(5));

========================================================================
@Author: G.Sureshkumar
@Since: 7-Jan-2010

create table comadc_facilities (
adcfac_appno varchar2(20),
adcfac_sno NUMBER(4,0),
adcfac_headid number(3),
adcfac_id number(3),
adcfac_group varchar2(5),
adcfac_category varchar2(2),
adcfac_amount number(18,2),
adcfac_interest varchar2(50),
adcfac_margin varchar2(10),
adcfac_os number(18,2),
adcfac_osason date, 
adcfac_months number(3),
adcfac_secvalue number(18,2),
adcfac_remarks varchar2(4000),
adcfac_cbsaccno varchar2(16)
);

create table comadc_applications(
adc_appno varchar2(20),
adc_appusrid varchar2(15),
adc_createdate date,
adc_createorgscode varchar2(8),
adc_delflag varchar2(1) default 'N',
adc_delusrid varchar2(15),
adc_deldate date,
adc_processdate date,
adc_processusrid varchar2(15),
adc_processorgscode varchar2(8),
adc_valuesin varchar2(1),
adc_closedate date,
adc_closedby varchar2(15),
adc_prdcode number(4),
adc_sanccomments varchar2(4000),
adc_comappid varchar2(10)
);

alter table comadc_applications add(adc_holdusrid VARCHAR2(15));
alter table comadc_applications add(adc_staus VARCHAR2(2));


create table comadc_securities(
sec_appno varchar2(20),
sec_id varchar2(5),
sec_desc varchar2(4000),
sec_remarks varchar2(4000),
sec_type varchar2(20),
sec_valuedby varchar2(80),
sec_value number(18,2),
sec_valuedate date,
sec_insamt number(18,2),
sec_insexpdate date,
sec_srlno VARCHAR2(5),
SEC_TENOR VARCHAR2(5)
);

create table comadc_comments(
comments_appno varchar2(20),
comments_valofaccount varchar2(4000),
comments_prereq varchar2(4000),
comments_delauth varchar2(4000)
);

create table comadc_termscond(
terms_appno varchar2(20),
terms_id number(5),
terms_desc varchar2(4000),
terms_delflag varchar2(1) default 'N',
terms_deldesc varchar2(2000),
terms_delusrid varchar2(15),
terms_deldate date
);

create table comadc_mailbox(
mail_appno varchar2(20),
mail_fromflowpoint(3),
mail_fromusrid varchar2(15),
mail_toflowpoint(3),
mail_tousrid varchar2(15),
mail_date date
);

create table comadc_limitcomments(
limitcomm_appno varchar2(20),
limitcomments clob
);

create table comadc_guaranteecomments(
guarantee_appno varchar2(20),
guarntee_comments clob
);

create tabble comadc_fincomments(
fin_appno varchar2(20),
fin_comments clob
);

create table comadc_financials(

);


ALTER TABLE FACILITIES ADD FACILITY_INTREMARKS VARCHAR2(50);

update facilities set facility_intremarks='Usual' where facility_headid='4';

update facilities set facility_intremarks='BPLR' where facility_intadjustment='0' and bplr>0 and facility_intremarks is null;

select 'update facilities set facility_intremarks=''BPLR  '|| facility_intadjustment||''' where facility_sno='''|| facility_sno ||''' and facility_appno='''||facility_appno||''';' from facilities where
facility_intadjustment<0 and bplr>0 and  facility_headid!='4' and facility_intremarks is null;

select 'update facilities set facility_intremarks='''|| facility_intadjustment||''' where facility_sno='''|| facility_sno ||''' and facility_appno='''||facility_appno||''';' from facilities where
facility_intadjustment>0 and bplr=0 and  facility_headid!='4' and facility_intremarks is null;

select 'update facilities set facility_intremarks='''|| facility_intadjustment||''' where facility_sno='''|| facility_sno ||''' and facility_appno='''||facility_appno||''';' from facilities where
facility_intadjustment<0 and bplr=0 and  facility_headid!='4' and facility_intremarks is null;

select 'update facilities set facility_intremarks='''|| facility_intadjustment||''' where facility_sno='''|| facility_sno 
||''' and facility_appno='''||facility_appno||''';' from facilities where
facility_intadjustment > 0 and bplr=0 and facility_headid !='4';

select 'update facilities set facility_intremarks='''|| facility_intadjustment||''' where facility_sno='''|| facility_sno 
||''' and facility_appno='''||facility_appno||''';' from facilities where
facility_intadjustment < 0 and bplr=0 and facility_headid !='4';

select 'update facilities set facility_intremarks='''|| facility_intadjustment||''' where facility_sno='''|| facility_sno 
||''' and facility_appno='''||facility_appno||''';' from facilities where
facility_intadjustment = 0 and bplr=0 and facility_headid !='4';

select 'update facilities set facility_intremarks='''|| facility_intadjustment ||''' where facility_sno='''|| facility_sno 
||''' and facility_appno='''||facility_appno||''';' from facilities where
facility_intadjustment = 0 and bplr is null and facility_headid !='4';


select 'update facilities set facility_intremarks='''|| facility_intadjustment||''' where facility_sno='''|| facility_sno 
||''' and facility_appno='''||facility_appno||''';' from facilities where
facility_intadjustment != 0 and bplr is null and facility_headid !='4';

=================================================================================================================================================
@Author: V.Prashanthavel
@Since: 20-Jan-2010

alter table npadelgatepower add(NPA_STATUSNOTE NUMBER(18,2));

=================================================================================================================================================

@Author: V.Prashanthavel
@Since: 27-Jan-2010

create table comsre_comments
(
comsre_appno varchar2(20),
comsre_COMMENTS  CLOB
)

======================================================================================================
@Author: Sureshkumar
@Since: 27/01/10
alter table fac_security_details add(sec_margin number(5,2));

create table com_finassesvalues(
finassess_appno varchar2(20),
FINASSESS_DIVID VARCHAR2(10),
finassess_srno number(3),
finassess_rowid number(10),
finassess_rowdesc varchar2(500),
finassess_rowtype varchar2(10), 
finassess_year1 varchar2(25),
finassess_year2 varchar2(25),
finassess_year3 varchar2(25),
finassess_year4 varchar2(25),
finassess_year5 varchar2(25),
);
========================================================================================

@Author: V.Prashanthavel
@Since: 27-Jan-2010

create table com_execfinancials 
(
fin_appno varchar2(20),
finslno number(4),
fin_rowtype varchar2(5),
fin_rowid number(3),
fin_rowdesc varchar2(100),
fin_year1 varchar2(25),
fin_year2 varchar2(25),
fin_year3 varchar2(25),
fin_year4 varchar2(25),
fin_year5 varchar2(25),
fin_year6 varchar2(25)
);

alter table ramtolaps105 add(remarks varchar2(4000));
alter table ramtolaps105 add (extrating_remarks varchar2(4000));

========================================================================================
@Author: Sureshkumar
@Since: 01-Feb-2010
alter table adv_auditobservations add(adv_auditsno number(3));
update adv_auditobservations set adv_auditsno='1' ;

insert into adv_auditobservations (adv_accno, adv_auditorsobservations, adv_auditsno, adv_audittype , adv_branchcomments, adv_dateaudited) 
select com_propcomappno, com_propcomdesc,'1', com_seltype,com_officer, com_propcomdate from com_proposalcomments where com_proposalcomments.com_propcomtype='AuditorObservation'

ALTER TABLE ADV_AUDITOBSERVATIONS 
ADD CONSTRAINT ADV_AUDITOBSERVATIONS_UK1 UNIQUE 
(
ADV_ACCNO,
ADV_AUDITTYPE,
ADV_AUDITSNO
) ENABLE
;
========================================================================================
@Author: Sureshkumar
@Since: 03-Feb-2010
alter table com_companydetails modify COM_COMPDEXP varchar2(100);

create table com_capitalstructure
(
com_appno varchar2(20),
com_ason date,
com_authcapital number(18,2),
com_subisscapital number(18,2),
com_paidshares number(18,2),
com_bookvalue varchar2(80),
com_marketvalue varchar2(100)
);

MERGE INTO COM_COMPANYDETAILS I USING (SELECT BACKGROUND_PROMOTERS, EXEC_SUM_APPNO FROM  EXEC_SUMMARY_EXTRA) S ON 
(S.EXEC_SUM_APPNO=I.COM_COMPDTAPPNO AND S.BACKGROUND_PROMOTERS=I.COM_COMPDTFNAME)
WHEN MATCHED THEN UPDATE SET I.COM_BACKGROUND='11111111111' 
WHEN NOT MATCHED THEN  INSERT (I.COM_COMPDTAPPNO,I.COM_COMPDTID,I.COM_COMPDTTYPE, I.COM_COMPDTFNAME,I.COM_BACKGROUND )
VALUES(S.EXEC_SUM_APPNO, '1','A@' ,'gen',S.BACKGROUND_PROMOTERS);
/
========================================================================================
03-02-2010

alter table FACILITIES add(FACILITY_EXISTBANKTYPE varchar2(1));
alter table FACILITIES add(FACILITY_PROPBANKTYPE varchar2(1));

ALTER TABLE COM_BANKING MODIFY (COMBK_EXCESS VARCHAR2(500 BYTE));

alter table exec_sanctionterms_summmary add(exec_present VARCHAR2(4000))
alter table exec_portfolio add(exec_presentreq VARCHAR2(4000))

alter table com_compproposal add (com_bankingremarks clob)

alter table combst_facilities modify BSTFACILITIES_PURPOSE varchar2(200);

alter table com_costofproject modify COM_COSTTOBE number(20,2);



========================================================================================================================================
@Author: V.Prashanth
@Since: 06-Feb-2010

ALTER TABLE MMR_FACILITIESANNEX RENAME COLUMN FAC_SANCAMT TO FAC_SANCAMT_OLD ;
ALTER TABLE MMR_FACILITIESANNEX RENAME COLUMN FAC_OS TO FAC_OS_OLD ;
ALTER TABLE MMR_FACILITIESANNEX RENAME COLUMN FAC_OVERDUE TO FAC_OVERDUE_OLD ;
ALTER TABLE MMR_FACILITIESANNEX RENAME COLUMN FAC_DP TO FAC_DP_OLD ;


ALTER TABLE MMR_FACILITIESANNEX ADD (FAC_SANCAMT NUMBER(20, 4));
ALTER TABLE MMR_FACILITIESANNEX ADD (FAC_OS NUMBER(20, 4));
ALTER TABLE MMR_FACILITIESANNEX ADD (FAC_OVERDUE NUMBER(20, 4));
ALTER TABLE MMR_FACILITIESANNEX ADD (FAC_DP NUMBER(20, 4));


update mmr_facilitiesannex set FAC_SANCAMT=FAC_SANCAMT_old;
commit;
update mmr_facilitiesannex set FAC_OVERDUE=FAC_OVERDUE_old;
commit;
update mmr_facilitiesannex set fac_os_old=0 where fac_os_old='NaN.00';
update mmr_facilitiesannex set FAC_OS=FAC_OS_old;
commit;
update mmr_facilitiesannex set FAC_DP_old=0 where FAC_DP_old='NaN.00';
update mmr_facilitiesannex set FAC_DP=FAC_DP_old;
commit;

alter table combst_financials add(broadtermsfinrowdesc  VARCHAR2(100))

=========================================================================================================

@Author: Sureshkumar
@Since: 08-Feb-2010

MERGE INTO exec_portfolio USING (
SELECT PRESENT_REQ, EXEC_SUM_APPNO FROM exec_summary_extra) ON (EXEC_SUM_APPNO=exec_appno)
WHEN MATCHED THEN UPDATE SET exec_presentreq=PRESENT_REQ
WHEN NOT MATCHED THEN INSERT (exec_appno) VALUES ('1111');
DELETE FROM exec_portfolio WHERE exec_appno='1111';

insert into com_capitalstructure (com_bookvalue, com_marketvalue, com_appno)
 (select book_value, market_value, exec_sum_appno from exec_summary_extra);
 
 MERGE INTO com_capitalstructure I using (select demo_appno,auth_captial, comapp_subcapital, comapp_totalshares
from comapplicant, com_demographics where com_demographics.demo_comappid=comapp_id
and com_demographics.demo_apptype='N') S on (s.demo_appno=I.com_appno)
when matched then update set I.com_authcapital=S.auth_captial , I.com_subisscapital=S.comapp_subcapital, I.com_paidshares=S.comapp_totalshares
when not matched then insert (I.com_appno, I.com_authcapital, I.com_subisscapital, I.com_paidshares) values(
s.demo_appno,auth_captial, comapp_subcapital, comapp_totalshares);
=========================================================================================================

@Author: Sureshkumar
@Since: 09-Feb-2010

UPDATE STATIC_DATA SET stat_data_delflag='Y';
ALTER TABLE STATIC_DATA RENAME COLUMN STAT_DATA_DELFLAG TO STAT_DATA_ACTIVE;
alter table applications modify APP_DELUSRID varchar2(15);
alter table applications modify APP_APPROVEDBY varchar2(15);
alter table applications modify APP_DEVIATEDUSERID varchar2(15);
alter table com_execfinancials add fin_divid varchar2(10);

ALTER TABLE COMAPP_COMPANY_DIVISIONS RENAME COLUMN COMAPP_DIV_ID TO COMAPP_DIV_ID_OLD ;

ALTER TABLE COMAPP_COMPANY_DIVISIONS ADD (COMAPP_DIV_ID NUMBER(10));
update comapp_company_divisions set COMAPP_DIV_ID=COMAPP_DIV_ID_old;
ALTER TABLE MON_PERSONALINFO ADD PERSONAL_CLASSIFICATION VARCHAR2(5);
UPDATE MON_PERSONALINFO SET personal_classification='001';

=========================================================================================================

@Author: V.Prashanth
@Since: 13-02-2010

 update com_execfinancials set fin_divid='0' where fin_divid is null;
 
=========================================================================================================
@Author: V.Prashanth
@Since: 15-02-2010

 ALTER TABLE COMADC_BANKINGDETAILS MODIFY (ADCBANK_SHARE NUMBER(18, 2));
 
 update com_execfinancials set fin_divid='0' where fin_divid is null;
 alter table com_compproposal rename column COM_PROPNPASINCE to COM_PROPNPASINCE_old;
 alter table com_compproposal add COM_PROPNPASINCE date;
 update com_compproposal set com_propnpasince=to_date(com_propnpasince_old,'dd/mm/yyyy');
 ALTER TABLE FACILITIES ADD FACILITY_PURPOSE VARCHAR2(4000);

alter table com_banking add combk_consortium varchar2(2);

alter table com_banking drop column COMBK_SHAREFUNDEXIST;
alter table com_banking drop column COMBK_SHAREFUNDPROP;
alter table com_banking drop column COMBK_SHARENONFUNDEXIST;
alter table com_banking drop column COMBK_SHARENONFUNDPROP;

alter table com_banking drop column COMBK_OSFUNDEXIST;
alter table com_banking drop column COMBK_OSFUNDPROP;
alter table com_banking drop column COMBK_OSNONFUNDEXIST;
alter table com_banking drop column COMBK_OSNONFUNDPROP;
 
 =============================================================================================================================
CREATE TABLE COMSTL_COMMENTS 
   (	COMSTL_APPNO VARCHAR2(20 BYTE), 
	COMSTL_TYPE VARCHAR2(50 BYTE), 
	COMSTL_COMMENTS CLOB
   )



CREATE TABLE COMADC_BANKINGDETAILS 
   (	ADCBANK_APPNO VARCHAR2(20 BYTE) NOT NULL ENABLE, 
	ADCBANK_TYPE VARCHAR2(3 BYTE), 
	ADCBANK_LEADBANK VARCHAR2(70 BYTE), 
	ADCBANK_SHARE NUMBER(18,2), 
	ADCBANK_ASSET VARCHAR2(3 BYTE), 
	ADCBANK_INTERNALRATING VARCHAR2(70 BYTE), 
	ADCBANK_REVIEWDUEDATE DATE, 
	ADCBANK_EXTERNALRATING_ST VARCHAR2(70 BYTE), 
	ADCBANK_EXTERNALRATING_LT VARCHAR2(70 BYTE), 
	ADCBANK_ACCOUNTSTATUS VARCHAR2(3 BYTE)
   )


CREATE TABLE COMADC_COMMENT 
   (	ADCCOM_APPNO VARCHAR2(50 BYTE), 
	ADCCOM_SANCTAUTH VARCHAR2(3 BYTE), 
	ADCCOM_VALUEACCOUNT CLOB, 
	ADCCOM_PRESENTREQ VARCHAR2(4000 BYTE), 
	ADCCOM_DELEGATEDAUTH VARCHAR2(4000 BYTE)
   )



CREATE TABLE COMADC_LIMITCOMMENTS 
   (	LIMITCOMM_APPNO VARCHAR2(20 BYTE), 
	LIMITCOMMENTS CLOB
   )

CREATE TABLE COMADC_GUARANTEECOMMENTS 
   (	GUARANTEE_APPNO VARCHAR2(20 BYTE), 
	GUARNTEE_COMMENTS CLOB
   )

=============================================================================================================================

INSERT INTO STATIC_DATA_MASTER (STAT_MAST_ID, STAT_MAST_DESC) VALUES ('53', 'KCY - Annual Income');
INSERT INTO STATIC_DATA_MASTER (STAT_MAST_ID, STAT_MAST_DESC) VALUES ('54', 'KCY - ID Proof Type');
INSERT INTO STATIC_DATA_MASTER (STAT_MAST_ID, STAT_MAST_DESC) VALUES ('55', 'KCY - Residence Proof Type');
INSERT INTO STATIC_DATA_MASTER (STAT_MAST_ID, STAT_MAST_DESC) VALUES ('56', 'KCY - Source of Income');
INSERT INTO STATIC_DATA_MASTER (STAT_MAST_ID, STAT_MAST_DESC) VALUES ('57', 'KCY - Networth');
INSERT INTO STATIC_DATA_MASTER (STAT_MAST_ID, STAT_MAST_DESC) VALUES ('58', 'KCY - Annual Turnover');
INSERT INTO STATIC_DATA_MASTER (STAT_MAST_ID, STAT_MAST_DESC) VALUES ('59', 'KCY - Annual Turnover (Estimated)');
INSERT INTO STATIC_DATA_MASTER (STAT_MAST_ID, STAT_MAST_DESC) VALUES ('60', 'KCY - Nature of Activity');
INSERT INTO STATIC_DATA_MASTER (STAT_MAST_ID, STAT_MAST_DESC) VALUES ('61', 'KCY - Risk Categorization');

CREATE TABLE APPLICANT_KYCNORMS 
(
KYC_CUSTID NUMBER(10,0), 
KYC_CUSTTYPE VARCHAR2(1 BYTE), 
KYC_OCCUPATION VARCHAR2(20 BYTE), 
KYC_ANNUALINCOME VARCHAR2(5 BYTE), 
KYC_COUNTRYRESI VARCHAR2(5 BYTE), 
KYC_FORM VARCHAR2(2 BYTE), 
KYC_FORMREFNO VARCHAR2(25 BYTE), 
KYC_IDPROOFTYPE VARCHAR2(5 BYTE), 
KYC_IDPROOFREF VARCHAR2(25 BYTE), 
KYC_RESIPROOFTYPE VARCHAR2(5 BYTE), 
KYC_RESIIDREFNO VARCHAR2(25 BYTE), 
KYC_SOURCEINCOME VARCHAR2(5 BYTE), 
KYC_NETWORTH VARCHAR2(5 BYTE), 
KYC_TURNOVER VARCHAR2(5 BYTE), 
KYC_ESTITURNOVER VARCHAR2(5 BYTE), 
KYC_ACCOUNT VARCHAR2(1 BYTE), 
KYC_ACTIVITY VARCHAR2(1 BYTE), 
KYC_OFAC VARCHAR2(1 BYTE), 
KYC_REMITTANCE VARCHAR2(1 BYTE), 
KYC_REMITCOUNTRY VARCHAR2(5 BYTE), 
KYC_CLIENTNAME_1 VARCHAR2(80 BYTE), 
KYC_CLIENTLOCATION_1 VARCHAR2(45 BYTE), 
KYC_CLIENTCITYCODE_1 VARCHAR2(5 BYTE), 
KYC_CLIENTCNTRYCODE_1 VARCHAR2(5 BYTE), 
KYC_CLIENTNAME_2 VARCHAR2(80 BYTE), 
KYC_CLIENTLOCATION_2 VARCHAR2(45 BYTE), 
KYC_CLIENTCITYCODE_2 VARCHAR2(5 BYTE), 
KYC_CLIENTCNTRYCODE_2 VARCHAR2(5 BYTE), 
KYC_CLIENTNAME_3 VARCHAR2(80 BYTE), 
KYC_CLIENTLOCATION_3 VARCHAR2(45 BYTE), 
KYC_CLIENTCITYCODE_3 VARCHAR2(5 BYTE), 
KYC_CLIENTCNTRYCODE_3 VARCHAR2(5 BYTE), 
KYC_RISK VARCHAR2(10 BYTE), 
KYC_CLIENTSTATECODE_1 VARCHAR2(5 BYTE), 
KYC_CLIENTSTATECODE_2 VARCHAR2(5 BYTE), 
KYC_CLIENTSTATECODE_3 VARCHAR2(5 BYTE)
) ;
=============================================================================================
alter table com_execfinancials add(fin_pagetype varchar2(10));
update com_execfinancials  set fin_pagetype='FI';
alter table com_capitalstructure add com_reservecapital number(18,2);
MERGE INTO executivefin_notes I USING (
SELECT appno, notes, page_type, division_id  FROM advnotes) S ON (S.appno=I.appno)
WHEN MATCHED THEN UPDATE SET I.division_id='50'
WHEN NOT MATCHED THEN INSERT (I.APPNO, I.PAGE_TYPE, I.DIVISION_ID,  I.NOTES) VALUES 
(S.APPNO, S.PAGE_TYPE, S.DIVISION_ID,  S.NOTES);

create table npa_banking(
npabk_appno varchar2(25),
npabk_sno number(4),
npabk_bankname varchar2(100),
npabk_sharepatern varchar2(100),
npabk_limit number(18,2),
npabk_os number(18,2),
npabk_status varchar2(5),
npabk_security varchar2(2500),
npabk_secvalue number(18,2),
npabk_banktype varchar2(5));



   create table postinspectionreport add 
(
postins_cBSID       VARCHAR2(20),          
postins_VISITDATE DATE,
postins_previsitdate date,
postins_inspectofficial1   VARCHAR2(50),          
postins_inspectofficial2    VARCHAR2(50),          
postins_inspectofficial3    VARCHAR2(50) ,         
postins_insofficialdesn1  VARCHAR2(50),          
postins_insofficialdesn2  VARCHAR2(50),          
postins_insofficialdesn3  VARCHAR2(50),          
postins_NORTH    VARCHAR2(4000) ,       
postins_EAST     VARCHAR2(4000),        
postins_WEST     VARCHAR2(4000),        
postins_SOUTH    VARCHAR2(4000),        
postins_PRISECURITY      VARCHAR2(4000) ,       
postins_COLLSECURITY         VARCHAR2(4000)     ,   
postins_PRESENTSTATUS        VARCHAR2(4000) ,       
postins_COMMENTS VARCHAR2(4000)  ,      
postins_DOCUMENT VARCHAR2(4000)  ,      
postins_FEATURES VARCHAR2(4000)  ,      
postins_BANKNAMEBOARD        VARCHAR2(5)           
postins_BORROWERNAMEBORD     VARCHAR2(5)           
postins_bookMAINTANANCE          VARCHAR2(5),           
postins_documentvalidity    VARCHAR2(15) ,         
postins_SHORFALLDEFICIENCY      VARCHAR2(4000)  ,        
postins_DEVELOPMENTPURPOSE VARCHAR2(4000),
postins_SINKINGloan VARCHAR2(4000), 
postins_MACHINERYpurchase VARCHAR2(4000), 
postins_SEASONALOPERATION VARCHAR2(4000), 
postins_MEDIUMTERMLOAN  VARCHAR2(4000) ),
postins_PLACEVARCHAR2(50),  
postins_DATE DATE,    
postins_NAME VARCHAR2(50),
postins_DESIGNATION VARCHAR2(50));
   
alter table  applicant_kycnorms add(KYC_CLIENTSTATECODE_1 VARCHAR2(5));
alter table  applicant_kycnorms add(KYC_CLIENTSTATECODE_2 VARCHAR2(5));
alter table  applicant_kycnorms add(KYC_CLIENTSTATECODE_3 VARCHAR2(5));   
=============================================================================================================================

@Author: V.Prashanth
@Since: 25-02-2010

INSERT INTO STATIC_DATA_MASTER (STAT_MAST_ID, STAT_MAST_DESC) VALUES ('62', 'Label - Housing Loan');
INSERT INTO STATIC_DATA_MASTER (STAT_MAST_ID, STAT_MAST_DESC) VALUES ('63', 'Label - Vechicle Loan');
INSERT INTO STATIC_DATA_MASTER (STAT_MAST_ID, STAT_MAST_DESC) VALUES ('64', 'Label - Education Loan');
INSERT INTO STATIC_DATA_MASTER (STAT_MAST_ID, STAT_MAST_DESC) VALUES ('65', 'Label - Comfort Loan');
INSERT INTO STATIC_DATA_MASTER (STAT_MAST_ID, STAT_MAST_DESC) VALUES ('66', 'Label - CBS');

=============================================================================================================================


alter table additional_parameternew add(additional_parameternew VARCHAR2(8))



create table npa_sisbanking(
npasisbk_appno varchar2(25),
npasisbk_sno number(4),
npasisbk_concern varchar2(100),
npasisbk_partners varchar2(100),
npasisbk_bankname varchar2(100),
npasisbk_limit number(18,2),
npasisbk_os number(18,2),
npasisbk_status varchar2(5))
















































 =============================================================================================================================
   
DROP TABLE CAD_BUSRISKS;
DROP TABLE CAD_EXPOSURE;
DROP TABLE CAD_KEYFINANCIALS;
DROP TABLE CAD_NEWPROJECT;
DROP TABLE CAD_OTHERDETAILS;
DROP TABLE CAD_PEERCOMPARE;
DROP TABLE CBS_LAPSINFO;
DROP TABLE COM_CRDFACILITIES;
Drop index COM_CRDFACILITIES_IDX;
DROP TABLE COM_CRDHISTORY;
drop index COM_CRDHISTORY_IDX;
DROP TABLE COM_CRDMAIN;
drop index COM_CRDMAIN_IDX;
DROP TABLE COM_CRDPROMOTERS;
drop table COM_CRDPROMOTERS_IDX;
DROP TABLE FIN_YEARS;
DROP TABLE FIN_FINVALUES;
DROP TABLE COM_FINANCIALS;
DROP TABLE COM_PRINCIPALS;
DROP TABLE COM_FACTRULES;
DROP TABLE COM_INFERENCERULES;
DROP TABLE COM_POSTDISBCOMTS;
DROP TABLE COM_POSTDISBMAIN; 
DROP TABLE DCB;
DROP TABLE DOCUMENTS_REGISTER;
DROP TABLE DOCVIEW;
DROP TABLE FUND_PC;  
drop table COM_YIELD;
drop table TOOLBAR_USERS;
drop table MONITORING_SETALERTS;
drop table MON_INSTALLMENT;
drop table MON_INSTALLMENTREGISTER;
drop table MON_GUARANTOR_REGISTER;
drop table MON_RENEWALREGISTER;
drop table MON_INTEREST;
drop table MON_INTERESTREGISTER;
drop table STRESS_BRULES;
DROP TABLE STEPUPRULES;
DROP TABLE STATUSPAGE;
DROP TABLE LAPSCODES;
DROP TABLE LAPS_MODULE;
drop table MON_SECURITYDETAILS;
drop table MON_SECURITYMASTER;
drop table MONDOCUMENTREGISTER;
drop table MONTHLY_FACILITIES;
drop table MONTHLY_LIMIT_FACILITIES;
drop table MONTHLY_MONITOR_INFO;
drop table MONTHLY_MONITOR_MASTER;
drop table MONTHLYMONITORPARAM;
drop table MSGMAILBOX;
drop table MULTIPLICATION_FACTOR;
drop table NOTE_COMPANY;
drop table OCCUPATIONMASTER;
drop table OLDINTERESTINDEX;
drop table PER_CONF_INFO;
drop table PER_CONF_INFORMANTS;
drop table PER_DEMOGRAPHICSOLD;
drop table PER_FIN;
drop table PER_FIN_PROFIT;
drop table PER_FIN_STAT;
drop table PER_LEGALHEIRS;
drop table PER_OVERDRAFT;
drop table PER_PRESANCTION;
drop table PER_RENEW;
drop table PER_RISK_EDU;
drop table PER_STEP_UPDOWN;
drop table PERGLOBALOPTIONS;
drop table PERRISKBRULES
drop table PRD_DISBURSEMENT;
drop table PRD_EDUSTATUS;
drop table PRD_FINSTANDARDS;
drop table PREM_ACCOUNTDETAILS;
drop table PRESANLAND;
drop table QIS_ANALYSIS_MASTER;
drop table QIS_ANALYSIS_POINTS;
drop table QIS_DETAILS;
drop table QIS_HALF_YEARLY_DETAILS;
drop table QIS_MASTER;
drop table QRY1;
drop table SEC_DESC_MASTER;
drop table SSI_ANTICIPATEDTURN;
drop table SSI_BANK;
drop table SSI_INSURANCE;
drop table SSI_LIABILITIES;
drop table SSI_OTHERDETAILS;
drop table SSI_PRINASSETLIABILITIES;
drop table SSI_PRINDEMOGRAPHICS;
drop table SSI_PRINEXPERIENCE;
drop table SSI_PROPERTIES;
drop table STATEMASTER;
DROP TABLE COM_GLOBALOPTIONS;
DROP TABLE COM_FAIRRECOMMEND;
DROP TABLE COM_FINTREND;
DROP TABLE AGR_TWOMURRAH;
DROP TABLE AGR_UPTO20HONEYBEEUNIT;
drop table COM_AUDITORREMARKS;
DROP TABLE COM_LEGEND;
DROP TABLE COM_BANKACCOUNTS;
DROP TABLE COM_INSGENERALDETAILS;
drop table cominspectionreport;

COM_FINNETWORTHVALUES
COM_GROUPCOMPANY
COM_IND_OTHER_INFORMATION
COM_INFERENCERULES
COM_INFRASTRUCTURE
COM_INS_FACILITY
COM_INS_POSITIONSECURITY
COM_INSDEBTORS
COM_INSFACILITY
COM_INSMOVINGITEMS
COM_INSPOLICY
COM_INSTERMLOANS
COM_INSVALUE
COM_INVHOLDING
COM_ASSESMENT