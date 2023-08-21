
@AUTHOR : R.PAULRAJ
@SINCE : 18/02/2009
alter table npa_statusSuitfield add (suit_process varchar2(4000));

alter table FILINGS_ELAB6 add
(business_cont varchar2(2), present_act varchar2(4000), fil_assets varchar2(4000), fil_claim varchar2(4000));


@AUTHOR : R.PAULRAJ
@SINCE : 19/02/2009

alter table FILINGS_ELAB6 add(fil_branch_rec varchar2(4000));

alter table npa_suit_history add(DATE_NPASINCE date,fil_provision_amount varchar(20),DATE_NPAREVIEW date);

alter table FILINGS_LOCATION add (present_security varchar2(4000));

=======================================================================================

@Author: G.Sureshkumar
@Since : 02-March-2009

ALTER TABLE AGR_GOLDLOAN ADD ("AGR_QUANTITY" VARCHAR2(10 BYTE));
---------------------------------------------------------------------------------------
@Author: G.Sureshkumar
@Since : 04-March-2009


ALTER TABLE link ADD ("lnk_logindate"date);
-------------------------------------------------------------------------------------------
@Author: G.Sureshkumar
@Since : 05-March-2009

ALTER TABLE COMAPPLICANT 
MODIFY ("COMAPP_ID" NUMBER(15, 0))
;
--------------------------------------------------------------------------------------------
@Author: G.Sureshkumar
@Since : 05-March-2009


ALTER TABLE COMAPPLICANT 
ADD ("COMAPP_OLDID" NUMBER(15, 0))
;
----------------------------------------------------------------------------------------------
@Author: G.Sureshkumar
@Since : 06-March-2009

alter table comapplicant add(comapp_renew varchar2(2));

take the insert script before doing this
ALTER TABLE COMAPPFACTORYDETAILS MODIFY ("COMAPP_ADD" VARCHAR2(4000 CHAR));

ALTER TABLE COMAPPLICANT MODIFY ("COMAPP_RENEW" DEFAULT 'N');

update comapplicant set COMAPP_OLDID=comapp_id;
update comapplicant set COMAPP_RENEW='N';
--------------------------------------------------------------------------------------------------
@Author: G.Sureshkumar
@Since : 09-March-2009

alter table link add (LNK_DATETIME date);

INSERT INTO "UBILAS1"."STATIC_DATA_MASTER" (STAT_MAST_ID, STAT_MAST_DESC) VALUES ('6', 'Free Text 7');


--------------------------------------------------------------------------------------------------
@Author: G.Sureshkumar
@Since : 11-March-2009

ALTER TABLE ADV_AUDITOBSERVATIONS 
ADD ("ADV_DATEAUDITED" DATE)
;
--------------------------------------------------------------------------------------------------

@Author : R. Paulraj
@since  : 11-March-2009


alter table mon_generalinfo add(presentrateinterest varchar2(15), previousrateinterest varchar2(15));

alter table mon_recovered add(mon_seviceMonth varchar2(5),mon_recoverarrears varchar2(4000));

alter table mon_limitregister add(mon_reviewof varchar2(5));
------------------------------------------------------------------------------------------------------------

@Author : R. Paulraj
@since  : 12-March-2009

alter table mmr_consortium add(mmr_nonfundsharepercent Number(5));

alter table mon_personalinfo add(personal_leadbankvetted varchar2(5));

alter table mon_personalinfo add(personal_stipdocuments varchar2(5));
-------------------------------------------------------------------------------------------------------------

@Author: G.Sureshkumar
@Since : 12-March-2009

ALTER TABLE GOVTSPONSER_PARAMETERS 
ADD ("ANNUALINCOMEOTHERS" NUMBER(18, 4));

ALTER TABLE GOVTSPONSER_PARAMETERS 
ADD ("ANNUALINCOMERURAL" NUMBER(18, 4));

ALTER TABLE GOVTSPONSER_PARAMETERS 
DROP COLUMN "ANNUALINCOME";
------------------------------------------------------------------------------------------------------------
@Author: G.Sureshkumar
@Since : 13-March-2009

ALTER TABLE OPS_SUBSIDY 
ADD ("OPS_RESIDENCEIN" VARCHAR2(2 CHAR))
;

ALTER TABLE OPS_SUBSIDY 
ADD ("OPS_MOBILITY" VARCHAR2(5))
;
----------------------------------------------------------------------------------------------------------------

@Author : R. Paulraj
@since  : 14-March-2009

alter table mmr_consortium add(mmr_fundsharepercent varchar2(5));

alter table npa_suit_history modify(FIL_NATUREBUSINES varchar2(60);

---------------------------------------------------------------------------------------------------------
@Author: G.Sureshkumar
@Since : 14-March-2009

ALTER TABLE AGR_BULLOCK_REPAY 
MODIFY ("AGR_SECURITYVAL1" VARCHAR2(250 CHAR));

ALTER TABLE AGR_BULLOCK_REPAY 
MODIFY ("AGR_SECURITYVAL2" VARCHAR2(250 CHAR));

ALTER TABLE AGR_BULLOCK_REPAY 
MODIFY ("AGR_SECURITYVAL3" VARCHAR2(250 CHAR));
------------------------------------------------------------------------------------------------------------

@Author : R. Paulraj
@since  : 16-March-2009

create table reviewtermloanfinancial(sno number(22),reviwyear varchar2(15),cbsid varchar2(15),
cbsaccountno varchar(20), 
review_firstyear varchar(22),review_secondyear varchar2(22),review_thirdyear varchar2(22), 
review_fourthyear varchar2(22));
----------------------------------------------------------------------------------------------------------------
@Author : R. Paulraj
@since  : 17-March-2009

   create table mon_revnotecorporatecompany(mon_group varchar2(100),mon_banking varchar2(100),
   mon_review varchar2(100),
    mon_accountclassification varchar2(100), mon_creditrating varchar2(100), mon_status_account varchar(10),
    mon_partner1 varchar2(60),
    mon_partner2 varchar2(60),mon_partner3 varchar2(60),mon_partner4 varchar2(60),mon_partner5 varchar2(60),
    mon_partner6 varchar2(60), mon_partner7 varchar2(60),mon_partner8 varchar2(60),mon_partner9 varchar2(60),
    mon_partner10 varchar2(60));
    
    alter table reviewtermloanfinancial add(reviewofflag varchar2(5));
    
   alter table mon_revnotecorporatecompany add(CBSID varchar2(15), CBSACCOUNTNO varchar2(20), 
   REVIWYEAR varchar2(15));
   
   alter table mon_monitorinformation add(mon_turnover varchar2(5),mon_turnoverreasons varchar2(4000));
@Author: G.Sureshkumar
@Since : 17-March-2009

ALTER TABLE RAMTOLAPS105 
ADD ("LASTSCORE_BASEMODEL" NUMBER(6, 2));

ALTER TABLE RAMTOLAPS105 
ADD ("LASTGRADEF_BASEMODEL" VARCHAR2(1000 CHAR));

ALTER TABLE RAMTOLAPS105 
ADD ("LASTSCORE_DYNAMICMODEL" NUMBER(6, 2));

ALTER TABLE RAMTOLAPS105 
ADD ("LASTGRADEF_DYNAMICMODEL" VARCHAR2(1000 CHAR));

ALTER TABLE RAMTOLAPS105 
ADD ("CURRENTSCORE_BASEMODEL" NUMBER(6, 2));

ALTER TABLE RAMTOLAPS105 
ADD ("CURRENTGRADEF_BASEMODEL" VARCHAR2(1000 CHAR));

ALTER TABLE RAMTOLAPS105 
ADD ("CURRENTSCORE_DYNAMICMODEL" NUMBER(6, 2));

ALTER TABLE RAMTOLAPS105 
ADD ("CURRENTGRADEF_DYNAMICMODEL" VARCHAR2(1000 CHAR));


ALTER TABLE RAMTOLAPS105 
ADD ("LASTCOMBINEDRATING_DM" VARCHAR2(10));

ALTER TABLE RAMTOLAPS105 
ADD ("CURRENTCOMBINEDRATING_DM" VARCHAR2(10));

ALTER TABLE RAMTOLAPS105 
MODIFY ("LASTRATING_BASEMODEL" VARCHAR2(20 BYTE));

ALTER TABLE RAMTOLAPS105 
MODIFY ("LASTRATING_DYNAMICMODEL" VARCHAR2(20 BYTE));

ALTER TABLE RAMTOLAPS105 
MODIFY ("CURRENTRATING_BASEMODEL" VARCHAR2(20 BYTE));

ALTER TABLE RAMTOLAPS105 
MODIFY ("CURRENTRATING_DYNAMICMODEL" VARCHAR2(20 BYTE));

ALTER TABLE RAMTOLAPS105 
MODIFY ("RATINGRATIONALE" CLOB);

ALTER TABLE RAMTOLAPS105 
MODIFY ("RATINGPOOLREMARKS" VARCHAR2(4000 CHAR));


ALTER TABLE RAMTOLAPS105 
ADD ("LASTCOMBINEDRATING_DM" VARCHAR2(10 CHAR));

ALTER TABLE RAMTOLAPS105 
ADD ("CURRENTCOMBINEDRATING_DM" VARCHAR2(10 CHAR));

--------------------------------------------------------------------------------------------------------
@Author : R.PaulRaj
@Since : 17-March-2009

alter table mon_generalinfo add(account_categoryreasons varchar2(4000));
-----------------------------------------------------------------------------------------------------------
@Author : R.PaulRaj
@Since : 18-March-2009

alter table reviewnotetermloan add(daysCredit varchar2(35));
---------------------------------------------------------------------------------------------------------------
@Author : R.PaulRaj
@Since : 20-march-2009

alter table mmr_inspectionreport ADD(mmr_shorfalldeficiency varchar2(4000));

--------------------------------------------------------------------------------------------------------------

@Author : R.PaulRaj
@Since : 25-march-2009

alter table mon_generalinfo drop(presentrateinterest,previousrateinterest,account_categoryreasons);

alter table MON_SECURITYREGISTER add(monsec_shortfallnoticed varchar2(4000));

alter table mon_generalinfo add(mon_deviation varchar2(4000),mon_compliance date);

alter table mon_consortiumMeeting add(mon_noofmeetingheld varchar2(25));

alter table mon_limitregister add(mon_marginbookdebt varchar2(5));

--------------------------------------------------------------------------------------------------------------

@Author: G.Sureshkumar
@Since: 25-March-2009

delete from usr_agrscreens where SCREEN_ID in ('179','180','181');

------------------------------------------------------------------------------------

@Author: R.PaulRaj
@Since: 28-March-2009

alter table reviewnotetermloan add(disbursementdate date);

alter table mmr_monitoringinfo add(mon_salesquarter varchar2(20));

alter table mmr_monitoringinfo add(mon_salesamount varchar2(26));

-------------------------------------------------------------------------------------

@Author: R.PaulRaj
@Since: 30-March-2009

create table mon_accountexcess (mon_excesscbsid VARCHAR2(20),.
mon_excessmonth varchar2(5), mon_excessyear varchar2(5),mon_facility varchar2(150),
mon_duringmonth varchar2(30), mon_currentmonth varchar2(30));

alter table mon_accountexcess add(sno number(30));
------------------------------------------------------------------------------------
@Author: G.Sureshkumar
@Since: 30-March-2009

create table npa_npv (
npa_appno varchar2(20),
npa_securityvalue number(18,4),
npa_roi number(5,2),
npa_years number(7,2),
npa_npv number(18,4)
);

---------------------------------------------------------------------------------
@Author: R.Paulraj
@Since : 02-April-2009

create table mon_borrowerinfo (borrower_bankarrangement varchar2(15),
borrower_contactname varchar2(75), borrower_contperdesign varchar2(75),
borrower_contpermobile varchar2(15), borrower_leadbankvetted varchar2(5));

alter table mon_borrowerinfo add(borrower_stipdocuments varchar2(5), 
borrower_cbsid varchar2(16),borrower_month varchar2(5),borrower_year varchar2(5));

alter table mon_borrowerinfo add(borrower_landline varchar2(35));

------------------------------------------------------------------------------------
@Author: G.Sureshkumar
@Since: 02-April-2009

delete from usr_agrscreens where screen_id in ('265','266');

-------------------------------------------------------------------------------------
@Author: R.Paulraj
@Since : 04-April-2009


alter table mon_mmrsearch  add(org_code varchar2(15),mmrstatus varchar2(5));


-----------------------------------------------------------------------------------
@Author: R.Paulraj
@Since : 05-April-2009

delete from mon_accountexcess;

------------------------------------------------------------------------------------
@Author: R.Paulraj
@Since : 05-April-2009


alter table mon_recovered add(mon_inlandthreemonth
	varchar2(26),mon_foreignthreemonth varchar2(26), mon_inlandsixmonth
	varchar2(26),mon_foreignsixmonth varchar2(26),
	mon_inlandmorethansixmonth varchar2(26),mon_foreignmorethansixmonth
	varchar2(26), mon_inlandtotal varchar2(26),mon_foreigntotal
	varchar2(26));
	
alter table mon_limitregister add(limit_sanctionlevel varchar2(8));
-------------------------------------------------------------------------------
@Author: R.Paulraj
@Since : 08-April-2009


alter table mon_revnotecorporatecompany add(mon_leadbank varchar2(100),
mon_sharepercent varchar2(5));


alter table mon_revnotecorporatecompany add (dateproposal date);

------------------------------------------------------------------------------------
@Author: G.Sureshkumar
@Since : 08-April-2009

ALTER TABLE PROD_BUSINESS MODIFY ("BUSS_BUSSID" VARCHAR2(5 CHAR));

update prod_business set buss_bussid='UHR' where buss_bussid='1';
update prod_business set buss_bussid='UMR' where buss_bussid='2';
update prod_business set buss_bussid='UCR' where buss_bussid='3';
update prod_business set buss_bussid='UER' where buss_bussid='4';
update prod_business set buss_bussid='NOR' where buss_bussid='5';

-----------------------------------------------------------------------------------

@Author: R.Paulraj
@Since : 09-April-2009

alter table reviewnotetermloan add (assetclasification varchar2(5));

-----------------------------------------------------------------------------------
@Author : R.Paulraj
@Since  : 11-April-2009

create table mmr_facilitiesannex (cbsid varchar2(20), fac_month varchar2(20),
fac_year varchar2(20),fac_sno number(22), fac_parent varchar2(50),
fac_facility varchar2(50),fac_group number(22),fac_category char(1),
fac_sancamt varchar2(26),fac_os varchar2(26),fac_overdue varchar2(26),
fac_dp varchar2(26),fac_validupto date);
-----------------------------------------------------------------------------------
@Author : R.Paulraj
@Since  : 11-April-2009

alter table mmr_facilitiesannex add(fac_reasons varchar2(4000));

------------------------------------------------------------------------------------
@Author: G.Sureshkumar
@Since: 18-March-2009

alter table industry_master add(ind_grpcode varchar2(8), ind_exposure number(14,4),
 ind_exp_expirydate date);
------------------------------------------------------------------------------------
@Author : R.Paulraj
@Since  : 17-April-2009

create table mon_mail_comments(mon_cbsid varchar2(15),mon_month varchar2(5),
mon_year varchar2(5),mail_comments varchar2(4000),mail_userid varchar2(40),
mail_date date, mail_touser varchar2(100),mail_pano varchar2(15),mail_commentsclob  clob)
--------------------------------------------------------------------------------------------
@Author: G.Sureshkumar
@Since: 18-March-2009

CREATE TABLE INDGRPEXPDETAILS
   (IND_GRP VARCHAR2(8 BYTE), 
	IND_SANCLIMIT NUMBER(18,4), 
	IND_OSLIMIT NUMBER(18,4)
   );

CREATE TABLE CBS_EXPOSUREDETAILS 
   (CBS_CODE VARCHAR2(20 BYTE) NOT NULL ENABLE, 
	CBS_SANCLIMIT NUMBER(18,4), 
	CBS_OUTSTANDINGAMT NUMBER(18,4)); 
-------------------------------------------------------------------------------------
@Author: V.Prashanth
@Since: 20-April-2009

alter table bank_netfunds add(net_ownedfundsasno date);
alter table bank_netfunds add(net_totbankcreditasno date);
alter table bank_netfunds add(net_totbankcredit number(18,2));
alter table bank_netfunds add(net_singleborrinfra number(18,2));
alter table bank_netfunds add(net_groupborrinfra number(18,2));
alter table bank_netfunds add(net_olicompany number(18,2));
-------------------------------------------------------------------------------------
@Author: G.Sureshkumar
@Since: 21-March-2009

create table consexposure(
exp_sno varchar2(5),
exp_type varchar2(5),
exp_constitution varchar2(5),
exp_publictype varchar2(5),
exp_maxlimit number(16,4)
);
-------------------------------------------------------------------------------------
@Author: G.Sureshkumar
@Since: 24-March-2009

ALTER TABLE MON_LIMITREGISTER 
ADD ("LIMIT_STATUS" VARCHAR2(5 CHAR) DEFAULT 'O');
------------------------------------------------------------------------------------
@Author: G.Sureshkumar
@Since: 25-March-2009

INSERT INTO STATIC_DATA_MASTER (STAT_MAST_ID, STAT_MAST_DESC) VALUES ('24', 'Borrower Category')
INSERT INTO STATIC_DATA_MASTER (STAT_MAST_ID, STAT_MAST_DESC) VALUES ('48', 'Mode of Advance')
INSERT INTO STATIC_DATA_MASTER (STAT_MAST_ID, STAT_MAST_DESC) VALUES ('49', 'Type of Advance')
INSERT INTO STATIC_DATA_MASTER (STAT_MAST_ID, STAT_MAST_DESC) VALUES ('50', 'Industry Type')

alter table additional_parameternew drop (solid, document_date, 
occupation_code, total_emi);

alter table additional_parameternew add(advmode varchar2(8), borrowcat varchar2(8),
advtype varchar2(8), indtype varchar2(8), ACCNTOCCUPATION varchar2(8));

------------------------------------------------------------------------------------
alter table sanction_details add(
cbs_borrowercat varchar2(5),
cbs_advtype varchar2(5),
cbs_advmode varchar2(5),
cbs_indtype varchar2(5),
CBS_ACCNTOCCUPATION varchar2(5)
);

------------------------------------------------------------------------------------
@Author: V.Prashanth
@Since: 29-April-2009
create table com_assessmenttype
(
com_assmenttypeappno varchar2(50),
com_assmenttypecomdivid varchar2(50),
com_assessmenttype varchar2(10)
)

@Author: V.Prashanth
@Since: 02-May-2009
alter table exec_portfolio add(exec_borrowertype varchar2(2));
------------------------------------------------------------------------------------

CREATE SEQUENCE  LAWYERSEQ  MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1156 NOCACHE  ORDER  NOCYCLE ; 

CREATE SEQUENCE  VALUERSEQ  MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 748 NOCACHE  ORDER  NOCYCLE ;


ALTER TABLE VALUERSMASTER 
ADD ("VALUERS_REGIONALCODE" VARCHAR2(9 CHAR))
;

ALTER TABLE VALUERSMASTER 
ADD ("VALUERS_SEQNO" NUMBER(10, 0))
;
--------------------------------------------------------------------------------------



@Author: V.Prashanth
@Since: 12-May-2009
ALTER TABLE AGR_CAPLINSDETAILS 
MODIFY ("CAPL_AMOUNT" VARCHAR2(20 BYTE));

@Author: V.Prashanth
@Since: 13-May-2009
ALTER TABLE AGR_SHEEP_LOANAMOUNTDATA 
MODIFY ("SHEEP_TOTALAMOUNT" VARCHAR2(25 BYTE));


ALTER TABLE AGR_SERI_ECONOMICS 
MODIFY ("AGR_TOTALINCOMEIIYEAR" VARCHAR2(20 BYTE));

ALTER TABLE AGR_CROPPINGPATTERN 
MODIFY ("CROP_GROSSINCOMEE" VARCHAR2(25 BYTE));


ALTER TABLE AGR_CROPPINGPATTERN 
MODIFY ("CROP_NETINCOMEE" VARCHAR2(25 BYTE));

ALTER TABLE AGR_CROPPINGPATTERN 
MODIFY ("CROP_EXITOTINCOME" VARCHAR2(25 BYTE));

ALTER TABLE AGR_CROPPINGPATTERN 
MODIFY ("CROP_PROPTOTINCOME" VARCHAR2(25 BYTE));

ALTER TABLE AGR_CROPPINGPATTERN 
MODIFY ("CROP_GROSSINCOMEP" VARCHAR2(25 BYTE));

ALTER TABLE AGR_CROPPINGPATTERN 
MODIFY ("CROP_NETINCOMEP" VARCHAR2(25 BYTE));

ALTER TABLE AGR_CROPPINGPATTERNDATA 
MODIFY ("TOTNETINCOMEE" VARCHAR2(25 BYTE));

ALTER TABLE AGR_CROPPINGPATTERNDATA 
MODIFY ("TOTNETINCOMEP" VARCHAR2(25 BYTE));


----------------------------------------------------------------------------------------------------

@Author: V.Prashanth
@Since: 25-May-2009
create table com_creditprocesscondition 
   (
   com_crdprocesscondappno varchar2(30),
   com_crdprocesscondvide varchar2(30),
   com_crdprocesscond varchar2(3999),
   com_crdprocessremarks varchar2(3999)
   )
   
create table com_creditprocessaspects 
   (
   com_crdprocessaspectappno varchar2(30),
   com_crdprocessaspectseqno number(5),
   com_crdprocessaspect varchar2(3999),
   com_crdprocessaspectobser varchar2(3),
   com_crdprocessaspectcomments varchar2(3999)
   )

insert into static_data_master (stat_mast_id,stat_mast_desc) values ('51','Credit Process Audit')

create table com_creditmortgageddetail
(
com_creditmortgageddetailappno varchar2(30),
com_creditmortgageddetailseqno number(3),
com_creditmortgageddetailplace varchar2(50),
com_creditmortgageddetaildate date
)

insert into static_data(STAT_DATA_ID,STAT_DATA_SNO,STAT_DATA_DESC, stat_data_desc1)
values ('2','5','CPAO','CREDIT PROCESS AUDIT')
----------------------------------------------------------------------------------------------

@Author: V.Prashanth
@Since: 03-JUNE-2009

ALTER TABLE AGR_SHEEP_ECODATA 
MODIFY ("SHEEP_FEEDADULT1" NUMBER(15, 2));

ALTER TABLE AGR_SHEEP_ECODATA 
MODIFY ("SHEEP_FEEDLAMP1" NUMBER(15, 2));

ALTER TABLE BULLOCK_FINANCIAL 
MODIFY ("BULLOCK_TOTAL" NUMBER(18, 2))
;
@Author: V.Prashanth
@Since: 03-JUNE-2009

ALTER TABLE COM_CREDITMORTGAGEDDETAIL 
MODIFY ("COM_CREDITMORTGAGEDDETAILPLACE" VARCHAR2(100 BYTE));


alter table com_creditprocessaspects add(COM_CRDPROCESSASPECTSLNO varchar2(5));

-------------------------------------------------------------------------------------------------------------------
@Author: V.Prashanth
@Since: 06-JUNE-2009


ALTER TABLE COM_CREDITMORTGAGEDDETAIL MODIFY ("COM_CREDITMORTGAGEDDETAILPLACE" VARCHAR2(200 BYTE));
ALTER TABLE COM_CREDITPROCESSCONDITION MODIFY ("COM_CRDPROCESSCONDVIDE" VARCHAR2(100 BYTE));

---------------------------------------------------------------------------------------------------------
@Author: G.Sureshkumar
@Since: 15-JUNE-2009 

alter table exec_sanctionterms_summmary add(exec_facid varchar2(10),
 exec_factype varchar2(10), exec_sanctionterms varchar2(10), exec_stipearlier varchar2(4000),
 exec_recmdnow varchar2(4000));
 
 alter table com_proposalcomments add(com_propcomdate date);
 
 
 ------------------------------------------------------------------------------------------------
 @Author: G.Sureshkumar
@Since: 18-JUNE-2009 
 
 ALTER TABLE EXEC_FOREIGNCURRENCYEXPOSURE 
RENAME COLUMN "EXEC_DUEDATE1" TO "EXEC_DUEDATE1_OLD" ;

ALTER TABLE EXEC_FOREIGNCURRENCYEXPOSURE 
RENAME COLUMN "EXEC_DUEDATE2" TO "EXEC_DUEDATE2_OLD" ;

ALTER TABLE EXEC_FOREIGNCURRENCYEXPOSURE 
RENAME COLUMN "EXEC_DUEDATE3" TO "EXEC_DUEDATE3_OLD" ;

ALTER TABLE EXEC_FOREIGNCURRENCYEXPOSURE 
RENAME COLUMN "EXEC_DUEDATE4" TO "EXEC_DUEDATE4_OLD" ;

ALTER TABLE EXEC_FOREIGNCURRENCYEXPOSURE 
RENAME COLUMN "EXEC_DUEDATE5" TO "EXEC_DUEDATE5_OLD" ;

ALTER TABLE EXEC_FOREIGNCURRENCYEXPOSURE 
RENAME COLUMN "EXEC_DUEDATE6" TO "EXEC_DUEDATE6_OLD" ;

ALTER TABLE EXEC_FOREIGNCURRENCYEXPOSURE 
RENAME COLUMN "EXEC_DUEDATE7" TO "EXEC_DUEDATE7_OLD" ;

ALTER TABLE EXEC_FOREIGNCURRENCYEXPOSURE 
RENAME COLUMN "EXEC_DUEDATE8" TO "EXEC_DUEDATE8_OLD" ;

ALTER TABLE EXEC_FOREIGNCURRENCYEXPOSURE 
ADD ("EXEC_DUEDATE1" VARCHAR2(1000 CHAR));

ALTER TABLE EXEC_FOREIGNCURRENCYEXPOSURE 
ADD ("EXEC_DUEDATE2" VARCHAR2(1000 CHAR));

ALTER TABLE EXEC_FOREIGNCURRENCYEXPOSURE 
ADD ("EXEC_DUEDATE3" VARCHAR2(1000));

ALTER TABLE EXEC_FOREIGNCURRENCYEXPOSURE 
ADD ("EXEC_DUEDATE4" VARCHAR2(1000));

ALTER TABLE EXEC_FOREIGNCURRENCYEXPOSURE 
ADD ("EXEC_DUEDATE5" VARCHAR2(1000));

ALTER TABLE EXEC_FOREIGNCURRENCYEXPOSURE 
ADD ("EXEC_DUEDATE6" VARCHAR2(1000));

ALTER TABLE EXEC_FOREIGNCURRENCYEXPOSURE 
ADD ("EXEC_DUEDATE7" VARCHAR2(1000));

ALTER TABLE EXEC_FOREIGNCURRENCYEXPOSURE 
ADD ("EXEC_DUEDATE8" VARCHAR2(1000));

update EXEC_FOREIGNCURRENCYEXPOSURE set exec_duedate1= exec_duedate1_old;
update EXEC_FOREIGNCURRENCYEXPOSURE set exec_duedate2= exec_duedate2_old;
update EXEC_FOREIGNCURRENCYEXPOSURE set exec_duedate3= exec_duedate3_old;
update EXEC_FOREIGNCURRENCYEXPOSURE set exec_duedate4= exec_duedate4_old;
update EXEC_FOREIGNCURRENCYEXPOSURE set exec_duedate5= exec_duedate5_old;
update EXEC_FOREIGNCURRENCYEXPOSURE set exec_duedate6= exec_duedate6_old;
update EXEC_FOREIGNCURRENCYEXPOSURE set exec_duedate7= exec_duedate7_old;
update EXEC_FOREIGNCURRENCYEXPOSURE set exec_duedate8= exec_duedate8_old;

ALTER TABLE EXEC_FOREIGNCURRENCYEXPOSURE 
DROP COLUMN "EXEC_DUEDATE1_OLD";

ALTER TABLE EXEC_FOREIGNCURRENCYEXPOSURE 
DROP COLUMN "EXEC_DUEDATE2_OLD";

ALTER TABLE EXEC_FOREIGNCURRENCYEXPOSURE 
DROP COLUMN "EXEC_DUEDATE3_OLD";

ALTER TABLE EXEC_FOREIGNCURRENCYEXPOSURE 
DROP COLUMN "EXEC_DUEDATE4_OLD";

ALTER TABLE EXEC_FOREIGNCURRENCYEXPOSURE 
DROP COLUMN "EXEC_DUEDATE5_OLD";

ALTER TABLE EXEC_FOREIGNCURRENCYEXPOSURE 
DROP COLUMN "EXEC_DUEDATE6_OLD";

ALTER TABLE EXEC_FOREIGNCURRENCYEXPOSURE 
DROP COLUMN "EXEC_DUEDATE7_OLD";

ALTER TABLE EXEC_FOREIGNCURRENCYEXPOSURE 
DROP COLUMN "EXEC_DUEDATE8_OLD";

---------------------------------------------------------------------------------------------------------
 @Author: G.Sureshkumar
@Since: 19-JUNE-2009 

alter table exec_portfolio rename column audit_notes to audit_notes_old;
alter table exec_portfolio add(audit_notes clob);
update exec_portfolio set audit_notes=audit_notes_old;
alter table exec_portfolio drop column audit_notes_old;

-----------------------------------------------------------------

alter table exec_portfolio drop column PORT_FOLIO_RISK;
alter table exec_portfolio drop column PORT_FOLIO_DATAON;
alter table exec_portfolio drop column PORT_FOLIO_SECTOR;
alter table exec_portfolio drop column PORT_FOLIO_INDUSTRY;
alter table exec_portfolio drop column PORT_FOLIO_SUBINDUSTRY;
alter table exec_portfolio drop column PORT_FOLIO_ECOINDSCORE;
alter table exec_portfolio drop column PORT_FOLIO_BANKEXPOSURE;
alter table exec_portfolio drop column PORT_FOLIO_DOMESTICADVANCES;
alter table exec_portfolio drop column PORT_FOLIO_BANKNPASEC;
alter table exec_portfolio drop column PORT_FOLIO_BANKNPABANKEXP;
alter table exec_portfolio drop column PORT_FOLIO_BANKTOTDOMNPA;
alter table exec_portfolio drop column PORT_FOLIO_TOTEXPCOM;
alter table exec_portfolio drop column PORT_FOLIO_TOTGRPEXP;
alter table exec_portfolio drop column PORT_FOLIO_RISKSINBORREXPCEIL;
alter table exec_portfolio drop column PORT_FOLIO_RISKGRPEXPCEIL;
alter table exec_portfolio drop column PORT_FOLIO_SECINDEXPPOLY;
alter table exec_portfolio drop column BUSI_INDU_RISK;
alter table exec_portfolio drop column BUSI_INDU_IMPDEMPOST;
alter table exec_portfolio drop column BUSI_INDU_IMPMARGIN;
alter table exec_portfolio drop column BUSI_INDU_IMPOUTLOOK;
alter table exec_portfolio drop column BUSI_INDU_IMPFISCALPOLICY;
alter table exec_portfolio drop column BUSI_INDU_EXPDEMPOST;
alter table exec_portfolio drop column BUSI_INDU_EXPMARGIN;
alter table exec_portfolio drop column BUSI_INDU_EXPOUTLOOK;
alter table exec_portfolio drop column BUSI_INDU_EXPFISCALPOLICY;
alter table exec_portfolio drop column BUSI_COMP_RISK;
alter table exec_portfolio drop column BUSI_COMP_IMPCAPACITY;
alter table exec_portfolio drop column BUSI_COMP_IMPCOMPETITION;
alter table exec_portfolio drop column BUSI_COMP_IMPEXPPOTENTIONAL;
alter table exec_portfolio drop column BUSI_COMP_IMPCUSTBASE;
alter table exec_portfolio drop column BUSI_COMP_EXPCAPACITY;
alter table exec_portfolio drop column BUSI_COMP_EXPCOMPETITION;
alter table exec_portfolio drop column BUSI_COMP_EXPEXPPOTENTIONAL;
alter table exec_portfolio drop column BUSI_COMP_EXPCUSTBASE;
alter table exec_portfolio drop column BUSI_INDU_RISKREMARKS;
alter table exec_portfolio drop column BUSI_INDU_FACDEMPRKM;
alter table exec_portfolio drop column BUSI_INDU_FACMARGINRKM;
alter table exec_portfolio drop column BUSI_INDU_FACOUTLOOKRKM;
alter table exec_portfolio drop column BUSI_INDU_FACFISCALRKM;
alter table exec_portfolio drop column BUSI_COMP_FACCAPRKM;
alter table exec_portfolio drop column BUSI_COMP_FACCOMPRKM;

-------------------------------------------------------------------------------------------------------------
 @Author: V.Prashanth
@Since: 26-JUNE-2009 



ALTER TABLE MON_BILLS 
RENAME COLUMN "BILLS_STRUC" TO "BILLS_ACCFLAG" ;

ALTER TABLE MON_LIMITREGISTER 
RENAME COLUMN "LIMIT_STRUCTURE" TO "LIMIT_ACCFLAG" ;

ALTER TABLE MON_DOCUMENTREGISTER 
RENAME COLUMN "DOC_RESTRUC" TO "DOC_ACCFLAG" ;

ALTER TABLE INSURANCE_REGISTER 
RENAME COLUMN "INS_STRUC" TO "INS_ACCFLAG" ;

============================================================================================================
@Author: V.Prashanth
@Since: 27-JUNE-2009 

ALTER TABLE mon_sdr_upl 
RENAME COLUMN "MSU_RESTRUC" TO "MSU_ACCFLAG" ;
------------------------------------------------------------------------------------------------
@Author: G.Sureshkumar
@Since: 19-JUNE-2009 
	ALTER TABLE EXEC_SUMMARY_EXTRA DROP COLUMN CMD_ASSESSMENT;
	ALTER TABLE EXEC_SUMMARY_EXTRA DROP COLUMN LEVEL_SALES;
	ALTER TABLE EXEC_SUMMARY_EXTRA DROP COLUMN LOAN_ASSESSMENT;
	ALTER TABLE EXEC_SUMMARY_EXTRA DROP COLUMN ASSESSMENT_NONFUND;
  	ALTER TABLE EXEC_SUMMARY_EXTRA DROP COLUMN CMD_HOLDINGLEVELS;
  	ALTER TABLE EXEC_SUMMARY_EXTRA DROP COLUMN CMD_ASSESSMENT_LEVEL;
  	ALTER TABLE EXEC_SUMMARY_EXTRA DROP COLUMN STATUS_BANKING;
  	ALTER TABLE EXEC_SUMMARY_EXTRA DROP COLUMN CMD_ASSESSMENTCLOB;
  	ALTER TABLE EXEC_SUMMARY_EXTRA DROP COLUMN LEVEL_SALESCLOB;
  	ALTER TABLE EXEC_SUMMARY_EXTRA DROP COLUMN LOAN_ASSESSMENTCLOB;
  	ALTER TABLE EXEC_SUMMARY_EXTRA DROP COLUMN ASSESSMENT_NONFUNDCLOB;
  	ALTER TABLE EXEC_SUMMARY_EXTRA DROP COLUMN CMD_ASSESSMENT_LEVELCLOB;
  	ALTER TABLE EXEC_SUMMARY_EXTRA RENAME COLUMN OTHER_MATTERS TO OTHER_MATTERS_1;
  	ALTER TABLE EXEC_SUMMARY_EXTRA ADD (OTHER_MATTERS CLOB);
  	UPDATE EXEC_SUMMARY_EXTRA SET OTHER_MATTERS=OTHER_MATTERS_1;
  	ALTER TABLE EXEC_SUMMARY_EXTRA DROP COLUMN OTHER_MATTERS_1;
-------------------------------------------------------------------------------------------------------
@Author: G.Sureshkumar
@Since: 2-JULY-2009 
alter table fac_security_details modify SEC_DESC_DETAILS varchar2(200);
-----------------------------------------------------------------------------------
@Author: G.Sureshkumar
@Since: 8-JULY-2009 
alter table exec_portfolio drop column BUSI_COMP_FACEXPRKM;
alter table exec_portfolio drop column BUSI_COMP_FACCUSTRKM; 
alter table exec_portfolio drop column CMD_FINANCIALCASH; 
alter table exec_portfolio drop column TAKE_OVER1; 
alter table exec_portfolio drop column SELTAKE_OVER1; 
alter table exec_portfolio drop column CMDTAKE_OVER; 
alter table exec_portfolio drop column TAKE_OVER2; 
alter table exec_portfolio drop column SELTAKE_OVER2; 
alter table exec_portfolio drop column TAKE_OVER3; 
alter table exec_portfolio drop column SELTAKE_OVER3; 
alter table exec_portfolio drop column CMDTAKE_OVER3; 
alter table exec_portfolio drop column TAKE_OVER4; 
alter table exec_portfolio drop column SELTAKE_OVER4; 
alter table exec_portfolio drop column CMDTAKE_OVER4; 
alter table exec_portfolio drop column TAKE_OVER5; 
alter table exec_portfolio drop column SELTAKE_OVER5; 
alter table exec_portfolio drop column CMDTAKE_OVER5; 
alter table exec_portfolio drop column CMDTAKE_OVER6;
alter table exec_portfolio drop column TAKE_OVER6;
alter table exec_portfolio drop column SELTAKE_OVER6;
alter table exec_portfolio drop column SELTAKE_OVER7;
alter table exec_portfolio drop column TAKE_OVER7;
alter table exec_portfolio drop column CMDTAKE_OVER7;
alter table exec_portfolio drop column EXEC_GUARANTENAME;
alter table exec_portfolio drop column EXEC_GUARANTEEMEANS;
-----------------------------------------------------------------------------------
@Author: G.Sureshkumar
@Since: 9-JULY-2009 
alter table comapplicant add comapp_pubtype varchar2(5);
alter table exec_portfolio add exec_sancauth varchar2(5);


alter table mon_limitregister add(limit_accopendt date);

-----------------------------------------------------------------------------------=======
alter table mon_limitregister add(limit_accopendt date);
--------------------------------------------------------------------------------
@Author: G.Sureshkumar
@Since: 21-JULY-2009 
CREATE TABLE brrecomdFACILITY
   (	brrecmd_inwardno VARCHAR2(20) NOT NULL, 
	brrecmd_facnature VARCHAR2(10), 
	brrecmd_factype VARCHAR2(70), 
	brrecmd_limitapplied NUMBER(14,2), 
	brrecmd_purpose VARCHAR2(70), 
	brrecmd_limitrecmd NUMBER(14,2), 
	brrecmd_facsno NUMBER NOT NULL,
  brrecmd_appno varchar2(20)
   );


    CREATE TABLE brrecmdsecurity 
   (	brrecmd_inwardno VARCHAR2(20) NOT NULL, 
	brrecmd_sectype VARCHAR2(10), 
	brrecmd_secvalue NUMBER(14,2), 
	brrecmd_secdesc VARCHAR2(400), 
	brrecmd_secsno NUMBER NOT NULL,
  brrecmd_appno VARCHAR2(20)
   );
   
---------------------------------------------------------------------------------------------  
   alter table duediligencereport add (
dueapplntrelated varchar2(4000),
dueknewsince varchar2(4000),
duepropdesc varchar2(4000),
duemarketability varchar2(4000),
dueobservations varchar2(4000),
duedatevisit date,
dueinspectorname varchar2(80),
dueinspectordesign varchar2(80));

----------------------------------------------------------------------------------------------------

alter table ops_inspectionreport add(ins_inwardno varchar2(20))
  alter table ops_inspectionfacility add(ins_inwardno varchar2(20))


alter table presanctionvisitreport add(per_inwardno varchar2(20))
alter table duediligencereport add(dueinwardno varchar2(20))

alter table creditreport add(CR_MAINBUSSINESS varchar(400))
alter table creditreport add(CR_SIDELINE varchar2(400))
alter table creditreport add(CR_CONSTITUTION varchar2(5))
alter table creditreport add(CR_ESTABLISHED varchar2(50))

alter table pre_sanction_report add(PRE_INWARDNO varchar2(20))
alter table pre_sanction_report1 add(PRE_INWARDNO varchar2(20))

ALTER TABLE PRE_SANCTION_REPORT1 MODIFY ("PRE_APPNO" NULL);

----------------------------------------------------------------------------------------------------------

alter table creditreport rename column CR_OFFTELNO to CR_OFFTELNO_old;
alter table creditreport rename column CR_RESTELNO to CR_RESTELNO_old;
alter table creditreport rename column CR_PERMTELNO to CR_PERMTELNO_old;

alter table creditreport add CR_OFFTELNO varchar2(20);
alter table creditreport add CR_RESTELNO varchar2(20);
alter table creditreport add CR_PERMTELNO varchar2(20);

update creditreport set CR_OFFTELNO=CR_OFFTELNO_old;
update creditreport set CR_RESTELNO=CR_RESTELNO_old;
update creditreport set CR_PERMTELNO=CR_PERMTELNO_old;

alter table creditreport drop column CR_OFFTELNO_old;
alter table creditreport drop column CR_RESTELNO_old;
alter table creditreport drop column CR_PERMTELNO_old;
===================================================================================================================
alter table appinwardreg add inward_usrid varchar2(10);


alter table duediligencereport drop column duepropdesc;
================================================================================================================
 alter table appinwardreg add( 
    inward_assignusrid varchar2(20),
    inward_modifiedby varchar2(20),
    inward_modifieddate date,
    inward_assigndate date);
=========================================================================================================
  create table saralmailinbox_comments(
saralmail_inwardno varchar2(20), saralmail_comments varchar2(4000), saralmail_fromuser varchar2(50),
saralmail_date date,
saralmail_touser varchar2(50));
==========================================================================================================

create table com_creditlimitsought 
(
creditlimitsought_appno varchar2(20),
creditlimitsought_inwardno varchar2(20),
creditlimitsought_slno number(5),
creditlimitsought_facility varchar2(50),
creditlimitsought_limits number(18,2)
)

create table com_duediligence_report
(
DUEDILIGENCE_APPNO                      VARCHAR2(20),                                                                                                                                                                                  
DUEDILIGENCE_INWARDNO                   VARCHAR2(20),                                                                                                                                                                                  
DUEDILIGENCE_SLNO                       NUMBER(5),                                                                                                                                                                                     
DUEDILIGENCE_INSPECT                    DATE,                                                                                                                                                                                          
DUEDILIGENCE_NAME                       VARCHAR2(150),                                                                                                                                                                                 
DUEDILIGENCE_DESIGNATION                VARCHAR2(50),                                                                                                                                                                                  
DUEDILIGENCE_DOCS                       VARCHAR2(3999),                                                                                                                                                                                
DUEDILIGENCE_ADDRESS                    VARCHAR2(3999),                                                                                                                                                                                
DUEDILIGENCE_PROPERTY                   VARCHAR2(3999),                                                                                                                                                                                
DUEDILIGENCE_PLOT                       VARCHAR2(50),                                                                                                                                                                                  
DUEDILIGENCE_DOOR                       VARCHAR2(50),                                                                                                                                                                                  
DUEDILIGENCE_TSNO                       VARCHAR2(50),                                                                                                                                                                                  
DUEDILIGENCE_WARD                       VARCHAR2(50),                                                                                                                                                                                  
DUEDILIGENCE_MANDAL                     VARCHAR2(50),                                                                                                                                                                                  
DUEDILIGENCE_OTHERS                     VARCHAR2(50),                                                                                                                                                                                  
DUEDILIGENCE_RESIDENTIAL                VARCHAR2(3999),                                                                                                                                                                                
DUEDILIGENCE_CORPORATION                VARCHAR2(3999),                                                                                                                                                                                
DUEDILIGENCE_STATE                      VARCHAR2(3999),                                                                                                                                                                                
DUEDILIGENCE_PLOTSIZE                   VARCHAR2(3999),                                                                                                                                                                                
DUEDILIGENCE_OWNERS                     VARCHAR2(3999),                                                                                                                                                                                
DUEDILIGENCE_SINCEWHEN                  VARCHAR2(399),                                                                                                                                                                                 
DUEDILIGENCE_CIVIC                      VARCHAR2(3999),                                                                                                                                                                                
DUEDILIGENCE_BOUNDARIES                 VARCHAR2(3999),                                                                                                                                                                                
DUEDILIGENCE_SURROUNDING                VARCHAR2(3999),                                                                                                                                                                                
DUEDILIGENCE_CERTIFICATE                VARCHAR2(3999),                                                                                                                                                                                
DUEDILIGENCE_MORTRELATION               VARCHAR2(3999),                                                                                                                                                                                
DUEDILIGENCE_ENQUIRY                    VARCHAR2(3999),                                                                                                                                                                                
DUEDILIGENCE_PROPERTYVALUE              VARCHAR2(3999),                                                                                                                                                                                
DUEDILIGENCE_MARKET                     VARCHAR2(3999)  
);


create table com_duediligence_certificate
(
duecertificate_appno varchar2(20),
duecertificate_inwardno varchar2(20),
duecertificate_comments clob,
duecertificate_enquriedby varchar2(50),
duecertificate_enquried varchar2(50)
);
================================================================================
@Author: G.Sureshkumar
@Since: 31-JULY-2009 

alter table applications add app_applnholder varchar2(15);
===================================================================================
@Author: V.Prashanth
@Since: 01/08/2009


alter table com_pre_sanction_report add(dateofreport date)


alter table com_duediligence_certificate add(duedate date)
alter table com_duediligence_certificate add(dueofficername varchar2(50))
alter table com_duediligence_certificate add(duedesignation varchar2(50))

=====================================================================================
@Author: V.Prashanth
@Since: 06/08/2009

	ALTER TABLE INSURANCE_REGISTER ADD ("INS_DELFLAG" VARCHAR2(5) DEFAULT 'N');

ALTER TABLE CREDITREPORT 
MODIFY ("CR_APPNO" NULL);

alter table CREDITREPORT_TOTMEANS add(cr_inwardno varchar2(20));
alter table CREDITREPORT_TOTMEANS add(cr_slno varchar2(5));
alter table CREDITREPORT_ASSETS add(cr_inwardno varchar2(20));
alter table CREDITREPORT_ASSETS add(cr_slno varchar2(5));

alter table creditreport_assets modify (CR_APPNO null);
alter table CREDITREPORT_TOTMEANS modify (CR_APPNO null);

alter table appinwardreg add (inward_brstatus varchar2(5));

alter table CREDITREPORT_TOTMEANS add(cr_crdinvestigator varchar2(50));
alter table CREDITREPORT_TOTMEANS add(cr_branchmanager varchar2(50));
========================================================================================================
CREATE TABLE appinwardreg(	
  inward_no varchar2(20), inward_sector varchar2(5), 
  inward_createdon date, inward_appliedon DATE, 
	inward_custname varchar2(80), inward_add1 varchar2(45),
  inward_add2 varchar2(45), inward_city varchar2(5),
  inward_state varchar2(5),  inward_zipcode varchar2(8),
  inward_phone varchar2(20),
  inward_mobile varchar2(15), inward_email varchar2(100),
  inward_dob date, inward_pantan varchar2(15),
  inward_purpose varchar2(2000), inward_scheme varchar2(100),
  inward_termloanamt number(18,4), inward_wcloanamt number(18,4), 
  inward_nonwcloanamt number(18,4), inward_ADDITIONALDETAILS VARCHAR2(4000),
  inward_docreceivedon date, inward_docreceived varchar2(5),
  inward_appcreateat varchar2(5), inward_orgscode varchar2(8),
  INWARD_APPLNPROCESSAT varchar2(5), INWARD_APPATACHED varchar2(5) DEFAULT 'N' )  ;
	
	alter table applications add(app_inwardno varchar2(20));
	alter table applications add (app_valuesin varchar2(5));
	update applications set app_valuesin='L' where app_loantype='c';
	update applications set app_valuesin='A' where app_loantype='T';
	update applications set app_valuesin='A' where app_loantype='A';
	update applications set app_valuesin='A' where app_loantype='P';
	
	CREATE SEQUENCE INWARDSEQ INCREMENT BY 1 START WITH 1 MAXVALUE 999999999999999 MINVALUE 1 NOCACHE ORDER;
	CREATE SEQUENCE APPNOSEQ INCREMENT BY 1 START WITH 862 MAXVALUE 9999999 MINVALUE 1 NOCACHE ORDER;
	
	
	
	ALTER TABLE APPLICATIONS ADD APP_ORGLEVEL VARCHAR2(5);
	alter table organisations add(org_issaral varchar2(5), org_saralhead varchar2(10));
	alter table creditreport add cr_inwardno varchar2(20);
	alter table creditreport add cr_slno VARCHAR2(5 BYTE);
alter table ops_inspectionreport add(ins_inwardno varchar2(20));
  alter table ops_inspectionfacility add(ins_inwardno varchar2(20));


alter table presanctionvisitreport add(per_inwardno varchar2(20));
alter table duediligencereport add(dueinwardno varchar2(20));

alter table creditreport add(CR_MAINBUSSINESS varchar(400));
alter table creditreport add(CR_SIDELINE varchar2(400));
alter table creditreport add(CR_CONSTITUTION varchar2(5));
alter table creditreport add(CR_ESTABLISHED varchar2(50));

alter table pre_sanction_report add(PRE_INWARDNO varchar2(20));
alter table pre_sanction_report1 add(PRE_INWARDNO varchar2(20));

ALTER TABLE PRE_SANCTION_REPORT1 MODIFY ("PRE_APPNO" NULL);


alter table presanctionvisitreport rename column per_inwardno to pre_inwardno;

===============================================================================================================
@Author: G.Sureshkumar
@Since: 10-Aug-2009

ALTER TABLE APPINWARDREG 
ADD ("INWARD_BORROWERTYPE" VARCHAR2(5))
;

ALTER TABLE APPINWARDREG 
ADD ("INWARD_CBSCUSTID" VARCHAR2(10))
;
============================================================================================================
@Author: G.Sureshkumar
@Since: 11-Aug-2009

alter table MON_MONTHLYREPORT rename to MON_MONTHLYREPORT1

ALTER TABLE MON_MMRSEARCH ADD(MMR_NO VARCHAR2(25));

ALTER TABLE MON_MMRSEARCH RENAME COLUMN "SEARCH_MONTH" TO "MMR_MONTH" ;

ALTER TABLE MON_MMRSEARCH RENAME COLUMN "SEARCH_YEAR" TO "MMR_YEAR" ;

ALTER TABLE MON_MMRSEARCH RENAME COLUMN "SEARCH_CBSID" TO "MMR_CBSID" ;

ALTER TABLE MON_MMRSEARCH MODIFY ("MMR_CBSID" VARCHAR2(10 CHAR));

ALTER TABLE MON_MMRSEARCH RENAME COLUMN "SEARCH_CBSNAME" TO "MMR_CBSNAME" ;

ALTER TABLE MON_MMRSEARCH RENAME COLUMN "ORG_CODE" TO "MMR_ORGSCODE" ;

ALTER TABLE MON_MMRSEARCH RENAME TO mon_monthlyreport;

ALTER TABLE mon_monthlyreport DROP COLUMN "MMR_CBSNAME";

ALTER TABLE mon_monthlyreport DROP COLUMN "SEARCH_STATUS";

ALTER TABLE mon_monthlyreport RENAME COLUMN "MMRSTATUS" TO "MMR_STATUS" ;

ALTER TABLE mon_monthlyreport ADD ("MMR_USRID" VARCHAR2(15 BYTE));

ALTER TABLE mon_monthlyreport ADD ("MMR_RPTHOLDER" VARCHAR2(15 BYTE));
-------------------------------------------------------------------------------------------------
@Author: G.Sureshkumar
@Since: 13-08-2009

alter table mon_borrowerinfo add(
BORROWER_custname varchar2(80),
BORROWER_natofactivity varchar2(10),
BORROWER_address varchar2(50), 
BORROWER_address1 varchar2(50), 
BORROWER_city varchar2(8), 
BORROWER_state varchar2(8), 
BORROWER_pincode varchar2(8), 
BORROWER_phone varchar2(20), 
BORROWER_mobile varchar2(15), 
BORROWER_constitution varchar2(8)  
);
----------------------------------------------------------------------------------------------
@Author: V.Prashanth
@Since: 14-08-2009

alter table exec_portfolio add(exec_agendano varchar2(50))
alter table exec_portfolio add(exec_mcm date)
create table exec_signatures
  (
  exec_appno VARCHAR2(20),
  exec_signatures VARCHAR2(4000),
  exec_mcmresolution VARCHAR2(4000),
  exec_gridcomments VARCHAR2(4000)
  );
  
----------------------------------------------------------------------------------------


@Author: G.sureshkumar
@Since: 19-08-2009
alter table npa_application add npa_holduser varchar2(15);

----------------------------------------------------------------------------------------
@Author: V.Prashanth
@Since: 19-08-2009

alter table exec_summary_extra 
rename column "COMPANY_RBIDESC" to "COMPANY_RBIDESC_OLD";


ALTER TABLE exec_summary_extra ADD("COMPANY_RBIDESC" CLOB);

UPDATE exec_summary_extra SET COMPANY_RBIDESC=COMPANY_RBIDESC_OLD;

ALTER TABLE exec_summary_extra DROP COLUMN "COMPANY_RBIDESC_OLD";


alter table exec_signatures add(exec_delegated varchar2(4000));

alter table app_deviation add(DEVIATION_SPECIFICATION varchar2(1500));
-------------------------------------------------------------------------------------------------------
@Author: G.sureshkumar
@Since: 25-08-2009


alter table facilities add facility_tenor number(5);

======================================================================================================
@Author: V.Prashanth
@Since: 26-08-2009
alter table reviewnotetermloan add(reveiw_loanpurpose  VARCHAR2(4000))
alter table reviewnotetermloan add(reveiw_datecredit  VARCHAR2(25))
alter table reviewnotetermloan add(reveiw_installremarks varchar2(4000))
alter table reviewnotetermloan add(reveiw_interestremarks varchar2(4000))
alter table reviewnotetermloan add(review_facilityname varchar2(100))
alter table reviewnotetermloan add(review_facilityLimit number(14,4))

   create table reviewfinancialcomments
    (
    reviewfinancialcbsid varchar2(15),
    reviewfinancialcbsaccountno  VARCHAR2(20),
    reviewfinancialvaluesin VARCHAR2(5),
    reviewfinancialcomments varchar2(4000),
    reviwyear  VARCHAR2(15),
    reviewofflag VARCHAR2(5)
    )
alter table facilities add facility_tenor number(5);
-------------------------------------------------------------------------------------------------------
@Author: G.sureshkumar
@Since: 26-08-2009

UPDATE STATIC_DATA_MASTER SET STAT_MAST_DESC = 'Credit Rating for forwarding proposal for Existing Customer' 
WHERE STAT_MAST_ID = '43';
INSERT INTO STATIC_DATA_MASTER (STAT_MAST_ID, STAT_MAST_DESC) VALUES 
('17', 'Credit Rating for forwarding proposal for New Connection');
INSERT INTO STATIC_DATA_MASTER (STAT_MAST_ID, STAT_MAST_DESC) VALUES
 ('52', 'Credit Rating for forwarding proposal for takeover accounts');

------------------------------------------------------------------------------------------------------------

@Author: V.Prashanth(From chennai)
@Since: 27-08-2009

alter table npa_statusSuitfield add (SUIT_MODIFIED_DATE date,SUIT_MODIFIED_USER varchar2(20));
alter table npa_statusSuitfield add suit_decreeamount numeric(18,2);

28-08-2009
alter table reviewnotetermloan add(review_nextreviewdate date);
------------------------------------------------------------------------------------------------------------
@Author: G.sureshkumar
@Since: 26-08-2009
  alter table reviewnotetermloan modify REVIEW_STATUS default 'op';
    update reviewnotetermloan set REVIEW_STATUS='op' where REVIEW_STATUS is null;
  alter table reviewnotetermloan modify activity vachar2(100);  


  ---------------------------------------------------------------------------------------------------------------
@Author: V.Prashanth
@Since: 07-09-2009  
  create table accountoprational
(
accoprationalappno varchar2(20),
accoprationalslno number(5),
accoprationalinwardno VARCHAR2(20),
accoprationalfacility VARCHAR2(100),
accoprationallimit NUMBER(14,2),
accoprationalOutStanding NUMBER(14,2),
accoprationalsecurity NUMBER(14,2),
accoprationaldrawingpower NUMBER(14,2),
accoprationalmaxavailment NUMBER(14,2),
accoprationalminavailment NUMBER(14,2),
accoprationalturnoverdebit NUMBER(14,2),
accoprationalturnovercredit NUMBER(14,2),
accoprationalavgutilization NUMBER(14,2),
accoprationalamtcommission NUMBER(14,2),
accoprationaloverdues NUMBER(14,2)
)



create table businessoperations
(
businessoperationsappno varchar2(20),
businessoperationsslno number(3),
businessoperationsinwardno varchar2(20),
businessoperations number(3),
businessoperationsno number(10),
businessoperationsamt number(14,2)
)

create table brrecmdcomments
(
brrecmdcommentsappno varchar2(20),
businessoperationsinwardno varchar2(20),
brrecmdcommentsmajor varchar2(4000),
brrecmdcommentsutilization  varchar2(4000),
brrecmdcommentsreviewfrom date, 
brrecmdcommentsreviewto date,
brrecmdcommentrecommendation VARCHAR2(4000)
)

==========================================================================================================

  alter table appinwardreg add(inward_appliedfor VARCHAR2(5))
  ALTER TABLE APPINWARDREG MODIFY ("INWARD_APPLIEDFOR" DEFAULT 'N');
  
=========================================================================================================  


alter table exec_port_summary rename column EXEC_EVAL_MAGMT to EXEC_EVAL_MAGMT_old;
alter table exec_port_summary rename column EXEC_EVAL_INDUSTRY to EXEC_EVAL_INDUSTRY_old;
alter table exec_port_summary rename column EXEC_EVAL_BUSSINESSRISK to EXEC_EVAL_BUSSINESSRISK_old;

alter table exec_port_summary add EXEC_EVAL_MAGMT clob;
alter table exec_port_summary add EXEC_EVAL_INDUSTRY clob;
alter table exec_port_summary add EXEC_EVAL_BUSSINESSRISK clob;

update exec_port_summary set EXEC_EVAL_MAGMT=EXEC_EVAL_MAGMT_old;
update exec_port_summary set EXEC_EVAL_INDUSTRY=EXEC_EVAL_INDUSTRY_old;
update exec_port_summary set EXEC_EVAL_BUSSINESSRISK=EXEC_EVAL_BUSSINESSRISK_old;
 
  
======================================================================================
@Author: G.sureshkumar
@Since: 11-09-2009
create table saralmailbox(
mail_inwardno varchar2(20),
mail_fromuser varchar2(15),
mail_touser varchar2(15),
mail_date date,
mail_actionid varchar2(50)
);
==============================================================================================
@Author: G.sureshkumar
@Since: 18-09-2009
alter table agr_com_techdetails add agr_loanfor varchar2(5);

==============================================================================================
@Author: G.sureshkumar
@Since: 25-09-2009

ALTER TABLE mailbox_comments RENAME COLUMN MAIL_COMMENTS TO MAIL_COMMENTS_VARCHAR;
ALTER TABLE mailbox_comments ADD (MAIL_COMMENTS CLOB);
UPDATE mailbox_comments SET MAIL_COMMENTS=MAIL_COMMENTS_VARCHAR;
ALTER TABLE mailbox_comments DROP COLUMN MAIL_COMMENTSCLOB;
ALTER TABLE mailbox_comments DROP COLUMN MAIL_COMMENTS_VARCHAR;


===============================================================================================
@Author: G.sureshkumar
@Since: 27-09-2009
  alter table npa_presentposition add (pre_accno varchar2(16));
  alter table npa_statusSuitfield add (suit_advocatesno varchar2(5));
============================================================================================
@Author: V.Prashanth
@Since: 30-09-2009
 ALTER TABLE AGR_STOCKPARTICULARS ADD("AGR_BATCH_PURCHASED" VARCHAR2(3));

===========================================================================================

@Author: V.Prashanth(FOR DCB and TARGET MASTER FROM KAMAL)
@Since: 30-09-2009
alter table dcb drop column dcb_remark

create table TARGETBranchList(
TARGET_BRANCH VARCHAR2(15),
TARGET_FROM DATE,
TARGET_TO DATE)

=========================================================================================================
@Author: V.Prashanth
@Since: 01-10-2009
      
create table mon_secuinsumap(      
MON_SECUSLRNO NUMBER(5),                                                                                                                                                                                     
MON_SECUINSUMAPACCNO VARCHAR2(50),                                                                                                                                                                                  
MON_SECUINSUMAPCBSID VARCHAR2(20),                                                                                                                                                                                  
MON_INSUSLRNO VARCHAR2(20),                                                                                                                                                                                  
MON_INSUAMT NUMBER(14,4)) 
===========================================================================================

@Author: G.sureshkumar
@Since: 01-10-2009

alter table com_proposalcomments rename column COM_PROPCOMDESC to COM_PROPCOMDESC_varchar;
alter table com_proposalcomments add (COM_PROPCOMDESC clob);
update com_proposalcomments set COM_PROPCOMDESC=COM_PROPCOMDESC_varchar;
alter table com_proposalcomments drop column COM_PROPCOMDESC_varchar;
  commit
=====================================================================================
 @Author: G.sureshkumar
 @Since: 06-10-2009

alter table district_master add(district_srno varchar2(5));
update district_master set district_srno=DISTRICT_CODE;
update district_master set DISTRICT_CODE=null;
alter table district_master modify (DISTRICT_CODE varchar2(5)); 
=====================================================================================
 @Author: V.Prashanth
 @Since: 06-10-2009

alter table companymaster modify ("company_contper_design" varchar2(100 byte));
alter table buildermaster modify ("builder_contper_design" varchar2(100 byte));
alter table valuersmaster modify ("valuers_design" varchar2(100 byte));
ALTER TABLE LAWYERMASTER RENAME COLUMN "LAWYER_DESIGN" TO "LAWYER_DESIGN_OLD" ;
ALTER TABLE LAWYERMASTER ADD ("LAWYER_DESIGN" VARCHAR2(100));
=================================================================================================
 @Author: G.sureshkumar
 @Since: 08-10-2009
delete from mon_auditcomments where mon_audittype is null;
ALTER TABLE MON_AUDITCOMMENTS MODIFY ("MON_AUDITTYPE" NOT NULL);
ALTER TABLE MON_AUDITCOMMENTS MODIFY ("MON_CUSTID" NOT NULL);
ALTER TABLE MON_AUDITCOMMENTS MODIFY ("MON_YEAR" NOT NULL);
ALTER TABLE MON_AUDITCOMMENTS MODIFY ("MON_MONTH" NOT NULL);
================================================================================================
 
==============================================================================================
@Author: V.Prashanth
@Since: 09-10-2009

alter table valuationentry add(valuername varchar2(80));
alter table valuationentry add(branchpanel varchar2(3));
============================================================================================
 @Author: G.sureshkumar
 @Since: 10-10-2009
 
ALTER TABLE FACILITY_MASTER ADD ("FACILITY_DELETED" VARCHAR2(2 CHAR) DEFAULT 'N' NOT NULL);
alter table com_termscond add (terms_facsno varchar2(5));
update com_termscond1 set terms_facsno='0' where terms_facid='0' and terms_factype='0';
select 'update com_termscond1 set TERMS_FACSNO='''|| facility_sno||''' where TERMS_APPNO='''||
facility_appno||''' and TERMS_FACTYPE='''|| facility_id ||''' and TERMS_FACID='''||FACILITY_HEADID
||''';' from facilities;
 =======================================================================================
 @Author: G.Sureshkumar
 @since: 20-10-2009
 
 create table com_bstcustinfo(
bst_companyname varchar2(80),
bst_companygroup varchar2(10), 
bst_brlocation varchar2(10),
bst_modifieddate date, 
bst_modifiedby varchar2(8),
bst_companyid varchar2(10),
bst_companycustid varchar2(10),
bst_renew varchar2(2)  DEFAULT 'N',
bst_custype varchar2(2)
);

create table branchrecomendations (
brrecmd_inwardno varchar2(20),
brrecmd_appno varchar2(20),
brrecmd_recmdations varchar2(4000)
);

alter table brrecomdfacility add BRRECMD_FACgroup number(10);
update brrecomdfacility set BRRECMD_FACGROUP=0;
========================================================================================= 
@Author: V.Prashanth
@Since: 23-10-2009 

ALTER TABLE BUSINESSOPERATIONS MODIFY ("BUSINESSOPERATIONS" VARCHAR2(100));
ALTER TABLE BUSINESSOPERATIONS ADD ("BUSINESSOPERATIONSTYPE" VARCHAR2(5));

======================================================================================
@Author: V.Prashanth
@Since: 26-10-2009 

ALTER TABLE ACCOUNTOPRATIONAL ADD ("ACCOPRATIONALASONDATE" DATE);
ALTER TABLE ACCOUNTOPRATIONAL ADD ("ACCOPRATIONALCBSNO" VARCHAR2(16));
ALTER TABLE BRRECOMDFACILITY ADD ("BRRECMD_LIMITEXIST" number(14,2));

alter table branchrecomendations add(BRRECMD_major VARCHAR2(4000))
alter table branchrecomendations add(BRRECMD_utilization VARCHAR2(4000))
alter table branchrecomendations add(BRRECMD_reviewfrom date)
alter table branchrecomendations add(BRRECMD_reviewto date)
======================================================================================
@Author: V.Prashanth
@Since: 27-10-2009 

create table bst_custprofit
(
bstcp_appno VARCHAR2(30),
bstcp_billscommission number(14,2),
bstcp_processcharges  number(14,2),
bstcp_lgcommission  number(14,2),
bstcp_sb  number(14,2),
bstcp_cd  number(14,2),
bstcp_ownsources  number(14,2),
bstcp_thirdparty  number(14,2)
)
================================================================================================================
@Author: V.Prashanth
@Since: 30-10-2009 

create table com_bstfacilities
(
bstfacilities_appno       varchar2(20),  
bstfacilities_headid      number(14,2),  
bstfacilities_id          number(14,2),  
bstfacilities_existing    number(14,2),  
bstfacilities_proposed    number(14,2),  
bstfacilities_creditint   varchar2(20),             
bstfacilities_propint     varchar2(20),             
bstfacilities_margin      number(14,2),  
bstfacilities_tenor       number(6,2),   
bstfacilities_purpose     varchar2(100), 
bstfacilities_intreset    varchar2(4000),
bstfacilities_createdate  date,          
bstfacilities_sno         VARCHAR2(3),     
bstfacilities_facgroup    number(3)  
)
create table com_broadtermscomments
(
COM_BROADTERMSAPPNO VARCHAR2(20),                                                                                                                                                                                  
COM_BROADTERMSTYPE VARCHAR2(50),                                                                                                                                                                                 
COM_BROADTERMSCOMMENTS CLOB,
com_broadtermsseltype varchar2(3)
)
create table broadtermsfin
(
BROADTERMSFINAPPNO VARCHAR2(50),                                                                                                                                                                                 
BROADTERMSFINSLNO VARCHAR2(3),                                                                                                                                                                                
BROADTERMSFINFIRSTYEAR VARCHAR2(25),                                                                                                                                                                                
BROADTERMSFINSECONDYEAR VARCHAR2(25),                                                                                                                                                                                 
BROADTERMSFINTHIRDYEAR VARCHAR2(25)
)



================================================================================================================
alter table com_takeoverterm add(term_slno number(10));
alter table COM_TAKEOVERWORKING add(working_slno number(10));

================================================================================================================
@Author: V.Prashanth
@Since: 06-11-2009 

create table combst_applications
    (
    bstapp_no varchar2(20),
    bstapp_usrid varchar2(15),
    bstapp_orgscode  varchar2(10), 
    bstapp_applnholder varchar2(15),
    bstapp_createdate date,
    bstapp_processdate date,
    bstapp_approvedby varchar2(15),
    bstapp_processorgscode varchar2(10),
    bstapp_closedby varchar2(15),
    bstapp_closedate date,
    bstapp_sancauthcomments  varchar2(4000),
    bstapp_orglevel varchar2(5),
    bstapp_valuesin varchar2(5),
    bstapp_status varchar2(2),
    bstapp_delflag varchar2(2) DEFAULT 'N',
    bstapp_deldate date,
    bstapp_delusrid varchar2(10)
   )
   
create table bstmailbox
(
BSTMAIL_APPNO                               VARCHAR2(20),                                                                                                                                                                                  
BSTMAIL_FROMUSRID                           VARCHAR2(15),                                                                                                                                                                                  
BSTMAIL_TOUSRID                             VARCHAR2(15),                                                                                                                                                                                  
BSTMAIL_FROMFLOWPOINT                       NUMBER(3),                                                                                                                                                                                    
BSTMAIL_TOFLOWPOINT                         NUMBER(3),                                                                                                                                                                                    
BSTMAIL_DATE                            DATE
)


create table bst_workflow
(
bst_flowpoint number(10),                                                                                                                                                                                    
bst_workid    number(10),                                                                                                                                                                                    
bst_minclass  number(10),                                                                                                                                                                                    
bst_duration  number(10)                                                                                                                                                                                
)

create table combst_mailcomments
(
MAIL_APPNO    VARCHAR2(20),                                                                                                                                                                                  
MAIL_USERID   VARCHAR2(20),                                                                                                                                                                                 
MAIL_DATE     DATE,                                                                                                                                                                                         
MAIL_TOUSER   VARCHAR2(100),                                                                                                                                                                                
MAIL_PANO     VARCHAR2(15),                                                                                                                                                                                 
MAIL_COMMENTS CLOB
)

create table bstsecurity_details
(
bstsec_desc_id                          number(4),                                                                                                                                                                                    
bstsec_desc_details                     varchar2(4000),                                                                                                                                                                                
bstsec_desc_value                       number(18,2),                                                                                                                                                                                  
bstsec_desc_as_on_date                  date,                                                                                                                                                                                          
bstsec_type                             varchar2(15),                                                                                                                                                                                  
bstsec_appno                            varchar2(20),                                                                                                                                                                                  
bstsec_srlno                            varchar2(5),                                                                                                                                                                                   
bstsec_tenor                            varchar2(5),                                                                                                                                                                                   
bstsec_valuersname                      varchar2(80),                                                                                                                                                                                  
bstsec_insuranceamt                     number(14,2),                                                                                                                                                                                  
bstsec_insexpirydate                    date,                                                                                                                                                                                          
bstsec_remarks                          varchar2(4000)                                                                                                                                                                                
);


=============================================================================================================
@aUTHOR: sureshkumar ganapathy
@Since:09-11-2009

ALTER TABLE com_termscond ADD TERMS_facSNO NUMBER(10);
select 'update com_termscond set terms_facsno='''|| facility_sno ||''' where  terms_appno='''|| facility_appno ||''' and terms_facid='''||facility_headid ||''' and terms_factype='''||facility_id||''';' from facilities;
ALTER TABLE com_facdocuments ADD COMDOC_FACSNO number(10);
select 'update com_facdocuments set COMDOC_FACSNO='''|| facility_sno ||''' where  COMDOC_APPNO='''|| facility_appno ||''' and COMDOC_FACHEADID='''||facility_headid ||''' and COMDOC_FACID='''||facility_id||''';' from facilities;
=======================================================================
@Author: Sureshkumar Ganapathy
@Since:16-11-2009

alter table mon_monthlyreport add (mmr_createdate date, mmr_closeddate date);
==================================================================

/*-----------------------------------------------SEND TILL 18-11-2009-----------------------------------------------------*/

ALTER TABLE combst_applications ADD (BSTAPP_COMID VARCHAR2(10))  
=========================================================================

@Author: V.Prashanth
@Since:19-11-2009

ALTER TABLE npacompromisepage1 
RENAME COLUMN "COMPRO_EFFECTPROFIT" TO "COMPRO_EFFECTPROFIT_OLD" ;

ALTER TABLE npacompromisepage1 
ADD ("COMPRO_EFFECTPROFIT" VARCHAR2(100));

update npacompromisepage1 set COMPRO_EFFECTPROFIT= COMPRO_EFFECTPROFIT_OLD;

ALTER TABLE npacompromisepage1 
DROP COLUMN "COMPRO_EFFECTPROFIT_OLD";



alter table npa_suit_history add(fil_regaddr VARCHAR2(100))
alter table npa_suit_history add(fil_facaddr VARCHAR2(100))
alter table npa_suit_history add(fil_regpremises VARCHAR2(2))
alter table npa_suit_history add(fil_facpremises VARCHAR2(2))
=========================================================================================================

ALTER TABLE NPA_STATUSPAGE1_PART2 MODIFY ("STA_APPNO" VARCHAR2(20 BYTE));
ALTER TABLE NPA_PRESENTPOSITION MODIFY ("PRE_APPNO" VARCHAR2(20 BYTE));
ALTER TABLE NPA_STATUSPAGE1_PART1 MODIFY ("STA_APPNO" VARCHAR2(20 BYTE));
=========================================================================================================
@Author: V.Prashanth
@Since : 23-11-2009

alter table npa_application add(npa_orgscode varchar2(6))
ALTER TABLE NPA_BORROWER_DETAILS MODIFY ("APPNO_NPA" VARCHAR2(20 BYTE));
ALTER TABLE NPA_SECURITIES MODIFY ("SECU_APPNO" VARCHAR2(20 BYTE));
ALTER TABLE NPA_STATUSPAGE3 MODIFY ("STA_APPNO" VARCHAR2(20 BYTE));
ALTER TABLE NPA_STATUSNOTEOTS MODIFY ("STA_APPNO" VARCHAR2(20 BYTE));
ALTER TABLE NPA_STATUSPAGESARFAESIA1 MODIFY ("STA_APPNO" VARCHAR2(20 BYTE));
ALTER TABLE NPA_STATUSPAGESARFAESIA2 MODIFY ("STA_APPNO" VARCHAR2(20 BYTE));

create table npa_mailcomments
(
MAIL_APPNO                              VARCHAR2(20),                                                                                                                                                                                  
MAIL_USERID                             VARCHAR2(20),                                                                                                                                                                                  
MAIL_DATE                               DATE,                                                                                                                                                                                          
MAIL_TOUSER                             VARCHAR2(100),                                                                                                                                                                                 
MAIL_PANO                               VARCHAR2(15),                                                                                                                                                                                  
MAIL_COMMENTS                           CLOB
)


==========================================================================================================

alter table mon_branchheadcomments add(mon_commentsmmrno varchar2(25));
select 'update mon_branchheadcomments set mon_commentsmmrno='''||mmr_no||''' where MON_COMMENTSMONTH='''||mmr_month||''' and MON_COMMENTSYEAR='''|| mmr_year||''' and CBS_ID='''||mmr_cbsid||''';' 
from mon_monthlyreport;

alter table mon_auditcomments add mon_auditmmrno varchar2(25);
select 'update mon_branchheadcomments set mon_auditmmrno='''||mmr_no||''' where MON_month='''||mmr_month||''' and MON_YEAR='''|| mmr_year||''' and mon_custid='''||mmr_cbsid||''';' 
from mon_monthlyreport;

create table commst_applications (
mst_appno varchar2(20),
mst_usrid varchar2(15),
mst_createdate date,
mst_orgscode varchar2(8),
mst_processedusrid varchar2(15),
mst_processdate date,
mst_processorgscode varchar2(8),
mst_closeddate date,
mst_closedusrid varchar2(15),
mst_delflag varchar2(1),
mst_delusrid varchar(15),
mst_deldate date,
mst_holduserid varchar2(15),
mst_status varchar2(2),
mst_prdcode varchar2(10));

===========================================================================================================
 alter table duediligencereport add(dueplace varchar2(50));
======================================================================================================================
create table prd_repaycapacity(
repay_prdcode number(10),
repay_id number(10),
repay_incrangefrom number(18,2),
repay_incrangeto number(18,2),
repay_salariedsustanece number(5,2), 
repay_nonsalariedsustanece number(5,2), 
repay_artificialsustanece number(5,2) 
);

====================================================================================================
ALTER TABLE NPA_APPLICATION MODIFY ("NPA_APPNO" NOT NULL);

ALTER TABLE NPA_APPLICATION ADD CONSTRAINT NPA_APPLICATION_PK PRIMARY KEY ("NPA_APPNO") ENABLE;

ALTER TABLE NPA_APPLICATION ADD CONSTRAINT NPA_APPLICATION_USERS_FK1 FOREIGN KEY ("NPA_CREATEDBY") 
REFERENCES USERS ("USR_ID") ENABLE;

ALTER TABLE NPA_APPLICATION ADD CONSTRAINT NPA_APPLICATION_USERS_FK2 FOREIGN KEY ("NPA_PROCESSEDBY") 
REFERENCES USERS ("USR_ID") ENABLE;

ALTER TABLE NPA_APPLICATION ADD CONSTRAINT NPA_APPLICATION_USERS_FK3 FOREIGN KEY ("NPA_CLOSEDBY") 
REFERENCES USERS ("USR_ID") ENABLE;

ALTER TABLE NPA_APPLICATION ADD CONSTRAINT NPA_APPLICATION_ORGANISAT_FK1 FOREIGN KEY ("NPA_ORGCODE") 
REFERENCES ORGANISATIONS ("ORG_CODE") ENABLE;

ALTER TABLE NPA_APPLICATION ADD CONSTRAINT NPA_APPLICATION_USERS_FK4 FOREIGN KEY ("NPA_DELETEDBY") 
REFERENCES USERS ("USR_ID") ENABLE;

ALTER TABLE NPA_APPLICATION ADD CONSTRAINT NPA_APPLICATION_ORGANISAT_FK2 FOREIGN KEY ("NPA_ORGSCODE") 
REFERENCES ORGANISATIONS ("ORG_SCODE") ENABLE;

ALTER TABLE NPA_STATUSPAGE1_PART1 ADD CONSTRAINT NPASTATUSNOTE_APPLN_FK1 FOREIGN KEY ("STA_APPNO") 
REFERENCES NPA_APPLICATION ("NPA_APPNO") ENABLE;

ALTER TABLE NPA_STATUSPAGE1_PART2 ADD CONSTRAINT NPASTATUSNOTE_APPLN_FK2 FOREIGN KEY ("STA_APPNO") REFERENCES NPA_APPLICATION 
("NPA_APPNO") ENABLE;

ALTER TABLE NPA_DEMOGRAPHICS ADD CONSTRAINT NPA_DEMOGRAPHICS_NPA_APPL_FK1 FOREIGN KEY ("NPA_DEMOAPPNO") REFERENCES NPA_APPLICATION 
("NPA_APPNO") ENABLE;

ALTER TABLE NPA_BORROWER_DETAILS ADD CONSTRAINT NPABORROWERDETAILS_APPLN_FK1 FOREIGN KEY ("APPNO_NPA") REFERENCES NPA_APPLICATION 
("NPA_APPNO") ENABLE;

ALTER TABLE STATUSNOTEPAGE2 RENAME TO NPA_STATUSNOTEPAGE2;

alter table STATUSNOTEPAGE21 rename to NPA_STATUSNOTEPAGE21

alter table STATUSNOTEPAGE22 rename to NPA_STATUSNOTEPAGE22;

ALTER TABLE NPA_STATUSNOTEPAGE2 ADD CONSTRAINT NPASTATUSNOTE_APPLN_FK3 FOREIGN KEY ("APPNO") REFERENCES NPA_APPLICATION 
("NPA_APPNO") ENABLE;

ALTER TABLE NPA_STATUSNOTEPAGE21 ADD CONSTRAINT NPASTATUSNOTE_APPLN_FK4 FOREIGN KEY ("APPNO") REFERENCES NPA_APPLICATION 
("NPA_APPNO") ENABLE;

ALTER TABLE NPA_STATUSNOTEPAGE22 ADD CONSTRAINT NPASTATUSNOTE_APPLN_FK5 FOREIGN KEY ("APP_NO") REFERENCES NPA_APPLICATION 
("NPA_APPNO") ENABLE;

ALTER TABLE NPA_PRESENTPOSITION ADD CONSTRAINT NPAPRESENTPOSITION_APPLN_FK1 FOREIGN KEY ("PRE_APPNO") REFERENCES NPA_APPLICATION 
("NPA_APPNO") ENABLE;

ALTER TABLE NPA_SECURITIES ADD CONSTRAINT NPASECURITIES_APPLN_FK1 FOREIGN KEY ("SECU_APPNO") REFERENCES NPA_APPLICATION 
("NPA_APPNO") ENABLE;

ALTER TABLE NPA_STATUSPAGE3 ADD CONSTRAINT NPASTATUSNOTE_APPLN_FK6 FOREIGN KEY ("STA_APPNO") REFERENCES NPA_APPLICATION 
("NPA_APPNO") ENABLE;

ALTER TABLE NPA_STATUSNOTEOTS ADD CONSTRAINT NPASTATUSNOTE_APPLN_FK7 FOREIGN KEY ("STA_APPNO") REFERENCES NPA_APPLICATION 
("NPA_APPNO") ENABLE;

ALTER TABLE NPA_STATUSPAGESARFAESIA1 ADD CONSTRAINT NPASTATUSNOTE_APPLN_FK8 FOREIGN KEY ("STA_APPNO") REFERENCES NPA_APPLICATION 
("NPA_APPNO") ENABLE;

ALTER TABLE NPA_STATUSPAGESARFAESIA2 ADD CONSTRAINT NPASTATUSNOTE_APPLN_FK9 FOREIGN KEY ("STA_APPNO") REFERENCES NPA_APPLICATION 
("NPA_APPNO") ENABLE;

ALTER TABLE NPA_STATUSSUITFIELD ADD CONSTRAINT NPASTATUSNOTE_APPLN_FK10 FOREIGN KEY ("APPNO") REFERENCES NPA_APPLICATION 
("NPA_APPNO") ENABLE;
================================================================================================================================================
@Author: V.Prashanth
@Since:07-12-2009

	   create table commst_otrsancterms
	    (
		    otrsancterms_appno varchar(50),
		    otrsancterms_slrno number(3),
		    otrsancterms_terms varchar(4000),
		    otrsancterms_modification varchar(4000),
		    otrsancterms_justification varchar(4000)
	    )
	    
	 create table commst_valofacct
	    (
		    valofacct_appno varchar2(50),
		    valofacct_slno number(3),
		    valofacct_previous number(14,4),
		    valofacct_current number(14,4)
	    )


		create table commst_remarks
		(
	  		remarks_appno varchar2(50),
			remarks_orglevel varchar2(2),
			remarks_comments clob,
			remarks_signatures clob
		)
		
		create table commst_recommendations
		(
			recmd_appno varchar2(50),
			recmd_srlno varchar2(3),
			recmd_sancterms varchar2(2),
			recmd_stipulated varchar2(4000),
			recmd_details varchar2(4000),
			recmd_recommendRO  varchar2(4000),
			recmd_recommendCO  varchar2(4000)
		)
		
		
		create table commst_facilities
		(
			MSTFACILITIES_APPNO VARCHAR2(50),
			MSTFACILITIES_HEADID NUMBER(3),  
			MSTFACILITIES_ID NUMBER(3),  
			MSTFACILITIES_SANCLIMIT NUMBER(14,4),
			MSTFACILITIES_OUTSTANDING NUMBER(14,4),
			MSTFACILITIES_MARGIN  NUMBER(14,4),                                                                                                                                                                                             
			MSTFACILITIES_OUTSTANDASON DATE,
			MSTFACILITIES_CBSACCNO  VARCHAR2(20),
			MSTFACILITIES_APPINT VARCHAR2(20),
			MSTFACILITIES_EXISTINT VARCHAR2(20),
			MSTFACILITIES_PROPINT VARCHAR2(20),
			MSTFACILITIES_ROREMD VARCHAR2(20),
			MSTFACILITIES_COREMD VARCHAR2(20),
			MSTFACILITIES_CONCESSION VARCHAR2(20),
			MSTFACILITIES_IRREGULARTIES VARCHAR2(4000),
			MSTFACILITIES_CREATEDATE DATE,
			MSTFACILITIES_SNO VARCHAR2(3),  
			MSTFACILITIES_FACGROUP NUMBER(3)                 
		)
		
		create table commst_securitydetails
		(
		mstsec_appno varchar2(20),
		mstsec_srlno varchar2(5),                             
		mstsec_id number(4),                               
		mstsec_details varchar2(4000),                          
		mstsec_value number(18,2),                            
		mstsec_ason date,           
		mstsec_type varchar2(15),                            
		mstsec_tenor varchar2(5),                             
		mstsec_valuersname varchar2(80),                            
		mstsec_insuranceamt number(14,2),                            
		mstsec_insexpirydate date,           
		mstsec_remarks varchar2(4000) 
		)
		
================================================================================================================================================
	    
	    
ALTER TABLE COMBST_APPLICATIONS MODIFY ("BSTAPP_NO" NOT NULL);

ALTER TABLE COMBST_APPLICATIONS ADD CONSTRAINT COMBST_APPLICATIONS_PK PRIMARY KEY ("BSTAPP_NO") ENABLE;

ALTER TABLE COM_BSTFACILITIES RENAME TO COMBST_FACILITIES;

ALTER TABLE COMBST_FACILITIES MODIFY ("BSTFACILITIES_APPNO" NOT NULL);

ALTER TABLE COMBST_FACILITIES MODIFY ("BSTFACILITIES_SNO" NOT NULL);

ALTER TABLE COMBST_FACILITIES ADD CONSTRAINT COMBST_FACILITIES_PK PRIMARY KEY (
"BSTFACILITIES_APPNO",
"BSTFACILITIES_SNO"
) ENABLE;

ALTER TABLE COMBST_FACILITIES ADD CONSTRAINT COMBST_FACILITIES_APPLNS_FK1 FOREIGN KEY (
"BSTFACILITIES_APPNO" ) REFERENCES COMBST_APPLICATIONS ("BSTAPP_NO") ENABLE;
ALTER TABLE BSTSECURITY_DETAILS RENAME TO COMBST_SECURITYDETAILS;

ALTER TABLE COMBST_SECURITYDETAILS MODIFY ("BSTSEC_APPNO" NOT NULL);

ALTER TABLE COMBST_SECURITYDETAILS MODIFY ("BSTSEC_SRLNO" NOT NULL);

ALTER TABLE COMBST_SECURITYDETAILS ADD CONSTRAINT COMBST_SECURITYDETAILS_PK PRIMARY KEY ("BSTSEC_APPNO","BSTSEC_SRLNO") ENABLE;

ALTER TABLE COM_BROADTERMSCOMMENTS RENAME TO COMBST_COMMENTS;

ALTER TABLE COMBST_COMMENTS ADD CONSTRAINT COMBST_COMMENTS_UK1 UNIQUE ("COM_BROADTERMSAPPNO","COM_BROADTERMSTYPE","COM_BROADTERMSSELTYPE") ENABLE;

ALTER TABLE COMBST_COMMENTS ADD CONSTRAINT COMBST_COMMENTS_APPLNS_FK1 FOREIGN KEY ("COM_BROADTERMSAPPNO") REFERENCES COMBST_APPLICATIONS 
("BSTAPP_NO") ENABLE;

ALTER TABLE BROADTERMSFIN RENAME TO COMBST_FINANCIALS;

ALTER TABLE COMBST_FINANCIALS ADD CONSTRAINT COMBST_FINANCIALS_APPLNS_FK1 FOREIGN KEY (
"BROADTERMSFINAPPNO" ) REFERENCES COMBST_APPLICATIONS ("BSTAPP_NO") ENABLE;

ALTER TABLE BST_CUSTPROFIT RENAME TO COMBST_CUSTPROFIT;

ALTER TABLE COMBST_CUSTPROFIT ADD CONSTRAINT COMBST_CUSTPROFIT_APPLNS_FK1 FOREIGN KEY ("BSTCP_APPNO") REFERENCES COMBST_APPLICATIONS 
("BSTAPP_NO") ENABLE;

ALTER TABLE COMBST_MAILCOMMENTS ADD CONSTRAINT COMBST_MAILCOMMENTS_APPLNS_FK1 FOREIGN KEY ("MAIL_APPNO") REFERENCES COMBST_APPLICATIONS ("BSTAPP_NO") ENABLE;
ALTER TABLE COMBST_MAILCOMMENTS ADD CONSTRAINT COMBST_MAILCOMMENTS_USERS_FK1 FOREIGN KEY ("MAIL_USERID") REFERENCES USERS ("USR_ID") ENABLE;

ALTER TABLE BSTMAILBOX RENAME TO COMBST_MAILBOX;
ALTER TABLE COMBST_MAILBOX ADD CONSTRAINT COMBST_MAILBOX_APPLNS_FK1 FOREIGN KEY ("BSTMAIL_APPNO" ) REFERENCES COMBST_APPLICATIONS ("BSTAPP_NO") ENABLE;
ALTER TABLE COMBST_MAILBOX ADD CONSTRAINT COMBST_MAILBOX_USERS_FK1 FOREIGN KEY ("BSTMAIL_FROMUSRID") REFERENCES USERS ("USR_ID") ENABLE;
ALTER TABLE COMBST_MAILBOX ADD CONSTRAINT COMBST_MAILBOX_USERS_FK2 FOREIGN KEY ("BSTMAIL_TOUSRID") REFERENCES USERS ("USR_ID") ENABLE;

================================================================================================================================================

update applications set app_status='op' where app_status='cp' and app_delflag='Y';
update applications set app_delflag='N', app_deldate = null where upper(app_status) !='OP' and app_delflag='Y';
update applications set app_status='op' where app_status='cp';
update applications set app_status='PA' where app_status='pa';
update applications set app_status='CA' where app_status='ca';

==============================================================================================================================================


ALTER TABLE EDU_STUDENT ADD CONSTRAINT EDUSTUDENT_PK PRIMARY KEY ("EDU_APPNO") ENABLE;

ALTER TABLE EDU_STUDENT ADD CONSTRAINT EDUSTUDENT_APPLICATIONS_FK1 FOREIGN KEY ("EDU_APPNO") REFERENCES UBITEST1.APPLICATIONS ("APP_NO") ENABLE;

ALTER TABLE EDU_DETAILS ADD CONSTRAINT EDUDETAILS_PK PRIMARY KEY ("EDUDETAIL_APPNO","EDU_ID") ENABLE;

ALTER TABLE EDU_DETAILS ADD CONSTRAINT EDUDETAILS_APPLICATIONS_FK1 FOREIGN KEY ("EDUDETAIL_APPNO") REFERENCES UBITEST1.APPLICATIONS ("APP_NO") ENABLE;

ALTER TABLE EDU_SCHOLAR ADD CONSTRAINT EDUSCHOLAR_PK PRIMARY KEY ("EDUSCHOLAR_APPNO","EDU_ID") ENABLE;

ALTER TABLE EDU_SCHOLAR ADD CONSTRAINT EDUSCHOLAR_APPLICATIONS_FK1 FOREIGN KEY ("EDUSCHOLAR_APPNO") REFERENCES UBITEST1.APPLICATIONS ("APP_NO") ENABLE;

ALTER TABLE APPLICATIONS ADD CONSTRAINT APPLICATIONS_USERS_FK4 FOREIGN KEY ("APP_DELUSRID") REFERENCES UBITEST1.USERS ("USR_ID") ENABLE;

===============================================================================================================================================
ALTER TABLE STATIC_DATA ADD ("STAT_DATA_DELFLAG" VARCHAR2(1) DEFAULT 'N' NOT NULL);

ALTER TABLE STATIC_DATA ADD ("STAT_DATA_DATEMODIFIED" DATE DEFAULT sysdate NOT NULL);

ALTER TABLE PER_DEMOGRAPHICS ADD CONSTRAINT PER_DEMOGRAPHICS_PK PRIMARY KEY ("DEMO_APPNO","DEMO_APPID","DEMO_TYPE") ENABLE;
==============================================================================================

@Author : Sureshkumar Ganapathy
@Since: 10-12-2009
alter table products add prd_subcode varchar2(10);
============================================================================================

ALTER TABLE COM_DEMOGRAPHICS ADD CONSTRAINT COM_DEMO_APPLICATION_FK1 FOREIGN KEY ("DEMO_APPNO") REFERENCES UBITEST1.APPLICATIONS ("APP_NO") ENABLE;
ALTER TABLE FACILITIES ADD CONSTRAINT FACILITIES_APPLICATIONS_FK1 FOREIGN KEY ("FACILITY_APPNO") REFERENCES UBITEST1.APPLICATIONS ("APP_NO") ENABLE;
ALTER TABLE FACILITIES ADD CONSTRAINT FACILITIES_PK PRIMARY KEY ("FACILITY_APPNO","FACILITY_SNO") ENABLE;
delete from com_companydetails where COM_COMPDTAPPNO not in (select app_no from applications);
ALTER TABLE COM_COMPANYDETAILS ADD CONSTRAINT COM_COMPDET_APPLICATIONS_FK1 FOREIGN KEY ("COM_COMPDTAPPNO") REFERENCES UBITEST1.APPLICATIONS ("APP_NO") ENABLE;
ALTER TABLE COM_COMPANYDETAILS ADD CONSTRAINT COM_COMPANYDETAILS_PK PRIMARY KEY ("COM_COMPDTAPPNO","COM_COMPDTID") ENABLE;
ALTER TABLE EXEC_EXPGROUPCONCERNS ADD CONSTRAINT COM_GROUPCONCERNS_APPLNS_FK1 FOREIGN KEY ("EXEC_GCAPPNO") REFERENCES UBITEST1.APPLICATIONS ("APP_NO") ENABLE;


ALTER TABLE COM_TERMSCOND ADD CONSTRAINT COM_TERMSCOND_APPLICATION_FK1 FOREIGN KEY ("TERMS_APPNO") REFERENCES UBITEST1.APPLICATIONS ("APP_NO") ENABLE;


=====================================================================================================================

V.Prashanth
15-12-2009

create table commst_mailbox
(
mstmail_appno varchar2(20),
mstmail_fromusrid varchar2(15),
mstmail_tousrid varchar2(15),
mstmail_fromflowpoint number(3),
mstmail_toflowpoint number(3),
mstmail_date date 
)


alter table commst_applications add(MST_SANCAUTHCOMMENTS VARCHAR2(4000))



create table commst_mailcomments
(
MAIL_APPNO VARCHAR2(20),                                                                                                                                                                                   
MAIL_USERID VARCHAR2(20),                                                                                                                                                                                  
MAIL_DATE DATE,                                                                                                                                                                                          
MAIL_TOUSER VARCHAR2(100),                                                                                                                                                                                 
MAIL_PANO VARCHAR2(15),                                                                                                                                                                                  
MAIL_COMMENTS CLOB                                                                                                                                                                                         
)

ALTER TABLE commst_applications Add mst_appid number(10);
alter table commst_applications rename column mst_holduserid to mst_holdusrid;
alter table commst_applications add mst_applicationno varchar2(20);
alter table mailbox_comments add mail_tousrid varchar2(15);
alter table commst_applications add mst_mailchkstatus varchar2(1) default 'N' not null;

===============================================================================================================
@Author: Sureshkumar Ganapathy
@Since : 22-12-2009

create table combst_orgrecmdations(
combst_appno varchar2(20),
combst_orglevel varchar2(1),
combst_orgrecmds clob,
combst_orgsignatories varchar2(4000),
combst_refno varchar2(50),
combst_refdate date
);
===================================================================================================

create table commst_fincomments
(
fin_appno varchar2(50),                                                                                                                                                                                  
fin_pagetype  varchar2(6),                                                                                                                                                                                   
fin_divid varchar2(10),                                                                                                                                                                               
fin_comments clob  
)

alter table commst_applications add mst_mailchkstatus varchar2(1) default 'N' not null;

=============================================== Till 22-12-2009 (FOR MST PATCH)  ==================================================================================================
@Author: V.Prashanth
@Since : 24-12-2009

alter table commst_remarks add(remarks_refno varchar2(20))

alter table commst_remarks add(remarks_date date)

alter table commst_facilities add (mstfacilities_zoremd VARCHAR2(20))

alter table  commst_applications add (mst_valuesin VARCHAR2(1))

ALTER TABLE COMMST_APPLICATIONS MODIFY ("MST_DELFLAG" DEFAULT 'N');

alter table commst_facilities add (mstfacilities_zoremd VARCHAR2(20))

ALTER TABLE COMBST_FACILITIES 
MODIFY ("BSTFACILITIES_CREDITINT" VARCHAR2(50 BYTE))
;

ALTER TABLE COMBST_FACILITIES 
MODIFY ("BSTFACILITIES_PROPINT" VARCHAR2(50 BYTE))
;

==========================================================================================================
@Author: Sureshkumar Ganapathy
@Since: 25-12-2009
alter table mon_mmrfundbased add mmrfund_mmrno varchar2(25);
select 'update mon_mmrfundbased set mmrfund_mmrno='''||mmr_no||''' where MMRFUND_MONTH='''||mmr_month||''' and MMRFUND_YEAR='''|| mmr_year||''' and MMRFUND_CUSTID='''||mmr_cbsid||''';' 
from mon_monthlyreport;
alter table mon_accountexcess add mon_mmrno varchar2(25);;
select 'update mon_accountexcess set mon_mmrno='''||mmr_no||''' where MON_EXCESSMONTH='''||mmr_month||''' and MON_EXCESSYEAR='''|| mmr_year||''' and MON_EXCESSCBSID='''||mmr_cbsid||''';' 
from mon_monthlyreport;
alter table MON_EXCESS_REASON add gen_mmrno varchar2(25);
select 'update MON_EXCESS_REASON set gen_mmrno='''||mmr_no||''' where GEN_MONTH='''||mmr_month||''' and GEN_YEAR='''|| mmr_year||''' and GEN_CUSTID='''||mmr_cbsid||''';' 
from mon_monthlyreport;
alter table mmr_facilitiesannex add fac_mmrno varchar2(25);
select 'update mmr_facilitiesannex set FAC_MMRNO='''||mmr_no||''' where FAC_MONTH='''||mmr_month||''' and FAC_YEAR='''|| mmr_year||''' and CBSID='''||mmr_cbsid||''';' 
from mon_monthlyreport;
alter table mon_generalinfo add gen_mmrno varchar2(25);
select 'update mon_generalinfo set GEN_MMRNO='''||mmr_no||''' where GEN_MONTH='''||mmr_month||''' and GEN_YEAR='''|| mmr_year||''' and GEN_CUSTID='''||mmr_cbsid||''';' 
from mon_monthlyreport;
alter table mon_recovered add monrec_mmrno varchar2(25);
select 'update mon_recovered set monrec_mmrno='''||mmr_no||''' where MON_RECMONTH='''||mmr_month||''' and MON_RECYEAR='''|| mmr_year||''' and MON_RECCBSID='''||mmr_cbsid||''';' 
from mon_monthlyreport;
alter table mon_hedgeddetails add mon_hedgeddetailsmmrno varchar2(25);
select 'update mon_recovered set monrec_mmrno='''||mmr_no||''' where MON_HEDGEDDETAILSMONTH='''||mmr_month||''' and MON_HEDGEDDETAILSYEAR='''|| mmr_year||''' and MON_HEDGEDDETAILSCBSID='''||mmr_cbsid||''';' 
from mon_monthlyreport;

alter table com_demographics rename column demo_noteto to demo_finmodel;
alter table com_demographics modify demo_finmodel varchar2(1);
=================================================================================================================
@Author: V.PRASHANTH
@Since: 26-12-2009

alter table reviewnotetermloan add(REVIEW_CREATEDATE date)
alter table reviewnotetermloan add(REVIEW_HOLDERUSRID VARCHAR2(15))
alter table reviewnotetermloan add(REVIEW_USRID VARCHAR2(15))


 CREATE TABLE COMMST_FACSECURITY
   (
     "FACSECURITY_APPNO" VARCHAR2(50 BYTE), 
     "FACSECURITY_FACSNO" NUMBER(10,0), 
     "FACSECURITY_SECSNO" NUMBER(10,0)
   ) ;

==========================================================================================================
@Author: Sureshkumar Ganapathy
@Since: 26-12-2009

alter table mmr_monitoringinfo add mmrinfo_mmrno varchar2(25);
select 'update mmr_monitoringinfo set MMRINFO_MMRNO='''||mmr_no||''' where MMR_INFOMONTH='''||mmr_month||''' and MMR_INFOYEAR='''|| mmr_year||''' and MMR_CBSID='''||mmr_cbsid||''';' 
from mon_monthlyreport;

alter table mon_monitorinformation add mon_monitmmrno varchar2(25);
select 'update mon_monitorinformation set mon_monitmmrno='''||mmr_no||''' where MON_MONITINFMONTH='''||mmr_month||''' and MON_MONITINFYEAR='''|| mmr_year||''' and MON_MONITINFCBSID='''||mmr_cbsid||''';' 
from mon_monthlyreport;

alter table mon_auditcomments add mon_mmrno varchar2(25);
select 'update mon_auditcomments set mon_mmrno='''||mmr_no||''' where MON_MONTH='''||mmr_month||''' and MON_YEAR='''|| mmr_year||''' and MON_CUSTID='''||mmr_cbsid||''';' 
from mon_monthlyreport;

CREATE SEQUENCE BSTCUSTINFOSEQ INCREMENT BY 1 START WITH 11 MAXVALUE 9999999999 MINVALUE 1 NOCACHE ORDER;

ALTER TABLE MON_MONTHLYREPORT ADD CONSTRAINT MON_MONTHLYREPORT_PK PRIMARY KEY ("MMR_NO") ENABLE;

ALTER TABLE MON_MMRFUNDBASED ADD CONSTRAINT MON_FUNDBASED_MTHLYRPT_FK1 FOREIGN KEY (MMRFUND_MMRNO) REFERENCES UBITEST1.MON_MONTHLYREPORT (MMR_NO) ENABLE;
ALTER TABLE MMR_FACILITIESANNEX ADD CONSTRAINT MMR_FACILITYANNEX_MTHLYRPT_FK1 FOREIGN KEY ("FAC_MMRNO") REFERENCES UBITEST1.MON_MONTHLYREPORT ("MMR_NO") ENABLE;


 alter table monmailbox add(MONMAIL_MMRNO VARCHAR2(25))

==========================================================================================================
@Author : Sureshkumar Ganapathy
@Since: 30-12-2009

alter table pre_sanction_report modify (
WATER_AVAIL_DETAILS varchar2(4000),
BENEFIT_AREA varchar2(4000),
CROPS_DETAILS varchar2(4000),
ASSET_DETAILS varchar2(4000),
LIABILITY_DETAILS varchar2(4000),
APPLICANT_ARRANGEMENTS varchar2(4000));

alter table pre_sanction_report rename column RECOMMENDATION to RECOMMENDATION_old;
alter table pre_sanction_report add RECOMMENDATION clob;
update pre_sanction_report set RECOMMENDATION=RECOMMENDATION_old;
alter table pre_sanction_report drop column RECOMMENDATION_old;

===========================================================================================

ALTER TABLE COMBST_APPLICATIONS ADD CONSTRAINT COMBST_APPLICATIONS_USERS_FK1 FOREIGN KEY ("BSTAPP_USRID") REFERENCES UBILAS1.USERS ("USR_ID") ENABLE;

ALTER TABLE COMBST_APPLICATIONS ADD CONSTRAINT COMBST_APPLICATIONS_USERS_FK2 FOREIGN KEY ("BSTAPP_APPROVEDBY") REFERENCES UBILAS1.USERS ("USR_ID") ENABLE;

ALTER TABLE COMBST_APPLICATIONS ADD CONSTRAINT COMBST_APPLICATIONS_USERS_FK3 FOREIGN KEY ("BSTAPP_NO") REFERENCES UBILAS1.USERS ("USR_ID") ENABLE;

ALTER TABLE COMBST_APPLICATIONS ADD CONSTRAINT COMBST_APPLICATIONS_COM_B_FK1 FOREIGN KEY ("BSTAPP_COMID") REFERENCES UBILAS1.COM_BSTCUSTINFO ("BST_COMPANYID") ENABLE;

select 'insert into prd_repaycapacity (repay_prdcode, repay_id, repay_incrangefrom, repay_incrangeto,  repay_salariedsustanece,repay_nonsalariedsustanece, repay_artificialsustanece) values ('''|| prd_code||''',''1'',''1'',''9999999999'','''||nvl((100- prd_collweight),0)||''','''||nvl((100-prd_repayselfemp),0)||''',''0'');' from prd_interest
