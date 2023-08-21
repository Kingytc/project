--    Guhan T on 23-06-2015    --

CREATE TABLE FVCMASTER (FVC_SNO      NUMBER(10,0) NULL,
                        FVC_DESC     VARCHAR2(25 BYTE) NULL,
                        FVC_PREMIUM  NUMBER(18,2) NULL,
                        FVC_TYPE     VARCHAR2(10 BYTE) NULL,
                        FVC_TNR_FROM NUMBER(18,0) NULL,
                        FVC_TNR_TO   NUMBER(18,0) NULL);
						
CREATE TABLE FVC_CALCULATION (FVC_PROPOSAL_NO      VARCHAR2(12 BYTE) NULL,
                              FVC_PROPOSAL_SNO     VARCHAR2(2 BYTE) NULL,
                              CBS_ACCOUNTNO        VARCHAR2(30 BYTE) NULL,
                              FVC_CBS_ID           VARCHAR2(10 BYTE) NULL,
                              FVC_BEFORE_XNPV      NUMBER(18,2) NULL,
                              FVC_AFTER_XNPV       NUMBER(18,2) NULL,
                              FVC_PROFIT_LOSS      NUMBER(18,2) NULL,
                              FVC_CALC_DATE        DATE NULL,
                              FVC_PROPOSAL_NO_OLD  VARCHAR2(12 BYTE) NULL,
                              FVC_PROPOSAL_SNO_OLD VARCHAR2(2 BYTE) NULL,
                              CBS_ACCOUNTNO_OLD    VARCHAR2(30 BYTE) NULL,
                              FVC_FITL_ACC         VARCHAR2(5 BYTE) NULL)
							  
CREATE TABLE FVC_DCDATA (FVC_PROPOSAL_NUM    VARCHAR2(12 BYTE) NULL,
                         FVC_PROPOSAL_SNO    NVARCHAR2(2) NULL,
                         CBS_ACCNO           VARCHAR2(30 BYTE) NULL,
                         FVC_BORROWER_NAME   VARCHAR2(100 BYTE) NULL,
                         FVC_CUST_ID         VARCHAR2(10 BYTE) NULL,
                         FVC_OS_BAL          NUMBER(18,2) NULL,
                         FVC_REPAY_TYPE      VARCHAR2(2 BYTE) NULL,
                         FVC_INTRST_CODE     VARCHAR2(50 BYTE) NULL,
                         FVC_TYPE            VARCHAR2(2 BYTE) NULL,
                         FVC_NO_OF_FLOWS     NUMBER(3,0) NULL,
                         FVC_FLOW_AMT        NUMBER(18,2) NULL,
                         FVC_FLOW_START_DATE DATE NULL,
                         FVC_EXP_DATE        DATE NULL,
                         FVC_PAYMENT_FREQ    VARCHAR2(50 BYTE) NULL,
                         FVC_DMD_EFF_DATE    DATE NULL,
                         FVC_INT_RATE        NUMBER(18,2) NULL,
                         FVC_FLOW_SNO        VARCHAR2(2 BYTE) NULL)
                         
                         
<!-- Guhan T on 25/06/2015 -->

CREATE  TABLE App_Post_Sanction(PS_APP_NO VARCHAR2(12) NOT NULL,
                                                  PS_App_SNO VARCHAR2(5) NOT NULL,
                                                  PS_OLD_APP_NO VARCHAR2(12) NOT NULL,
                                                  ps_old_APP_SNO VARCHAR2(5) NOT NULL,
                                                  ps_modify_terms VARCHAR2(100),
                                                  ps_modify_pageid VARCHAR2(100));
                                                  
CREATE  TABLE App_POST_SANC_PAGEMAP(PS_SNO VARCHAR2(5) NOT NULL,
                                                      PS_PARAM_DESC VARCHAR2(150),
                                                      PS_PARAM VARCHAR2(50),
                                                      PS_PAGEID VARCHAR2(200),
                                                      PS_ACTIVE VARCHAR2(5));
<!-- End -->

ALTER TABLE FVC_CALCULATION ADD FVC_FlowStrtDate_Proposal DATE;
ALTER TABLE FVC_CALCULATION ADD FVC_IntDmdDATE_PROPOSAL DATE;
ALTER TABLE FVC_CALCULATION ADD FVC_PROPOSAL VARCHAR2(3);






<!-- Guhan for NPA Provisioning on 11.01.2016 -->
CREATE  TABLE NPA_PROV_ACC_DATA(CUST_ID VARCHAR2(10) NOT NULL,
	                              CUST_NAME VARCHAR2(100) NOT NULL,
	                              ACC_NO VARCHAR2(75) NOT NULL,
	                              ORG_SOLDID VARCHAR2(5) NOT NULL,
	                              NPA_DATE DATE NOT NULL,
	                              SANC_LIMIT NUMBER(22,2) NOT NULL,
	                              OS_LIMIT NUMBER(22,2) NOT NULL,
	                              UNREAL_INT_VAL NUMBER(22,2) NOT NULL,
	                              COVERAGE_VAL_SANC NUMBER(22,2) NOT NULL,
	                              COVERAGE_PERCNT NUMBER(22,2) NOT NULL,
	                              COVERAGE_VAL_PReSeNT NUMBER(22,2) NOT NULL,
	                              UNSEC_OS_LIMIT NUMBER(22,2) NOT NULL,
	                              PRIME_SEC_VAL NUMBER(22,2) NOT NULL,
	                              FRAUD_APPLNT VARCHAR2(5) NOT NULL,
	                              AS_ON_DATE DATE NOT NULL,
	                              LOAN_TYPE VARCHAR2(5));
                              
CREATE  TABLE NPA_PROV_CUS_DATA(CUST_ID VARCHAR2(10) NOT NULL,
			                      CUST_NAME VARCHAR2(100) NOT NULL,
			                      ORG_SOLDID VARCHAR2(5) NOT NULL,
			                      NPA_DATE DATE NOT NULL,
			                      OS_LIMIT NUMBER(22,2) NOT NULL,
			                      SEC_VAL_PRIME_CBS NUMBER(22,2) NOT NULL,
			                      SEC_VAL_EXCLUSIVE NUMBER(22,2) NOT NULL,
			                      SEC_VAL_COMMON NUMBER(22,2) NOT NULL,
			                      SEC_VAL_COMM_RESIDL NUMBER(22,2) NOT NULL,
			                      SEC_VAL_TOTAL NUMBER(22,2) NOT NULL,
			                      NORM_STATUS VARCHAR2(50) NOT NULL,
			                      SEC_COVERGE_PERCNT NUMBER(22,2) NOT NULL,
			                      UNSEC_COVERGE_PERCNT NUMBER(22,2) NOT NULL,
			                      SEcured_VAL NUMBER(22,2) NOT NULL,
			                      UNSECURED_VAL NUMBER(22,2) NOT NULL,
			                      TOTAL_PROVISION NUMBER(22,2) NOT NULL,
			                      AS_ON_DATE DATE NOT NULL);
			                      
CREATE  TABLE NPA_PROV_SECURITY(cbs_acc_no VARCHAR2(75) NOT NULL,
                  Proposal_no VARCHAR2(50) NOT NULL,
                  facility_sno VARCHAR2(3) NOT NULL,
                  Sec_ID VARCHAR2(50),
                  Sec_sanc_val NUMBER(22,2) NOT NULL,
                  sec_presnt_val NUMBER(22,2) NOT NULL,
                  sec_type VARCHAR2(3));
                  
ALTER TABLE NPA_PROV_ACC_DATA ADD proposal_no VARCHAR2(12);
ALTER TABLE NPA_PROV_ACC_DATA ADD Proposal_sno VARCHAR2(5);
ALTER TABLE NPA_PROV_SECURITY ADD BORROWER_ID VARCHAR2(15);
ALTER TABLE NPA_PROV_SECURITY ADD SEC_OWNER_ID VARCHAR2(15);
ALTER TABLE NPA_PROV_SECURITY ADD sec_sanc_val_residual NUMBER(22,2);
ALTER TABLE NPA_PROV_SECURITY ADD sec_presnt_val_residual NUMBER(22,2);

CREATE  TABLE KBL_LIVE_05092014.NPA_PROV_CVRGE_MASTER(NPA_SNO NUMBER(3,0) NOT NULL,
                                                      NPA_NORM_STATUS VARCHAR2(10),
                                                      SEC_PERCNT NUMBER(3,2),
                                                      UNSEC_PERCNT NUMBER(3,2))
                                                      
CREATE  TABLE SET_MCLRMSME_EXPOSURE(mclrmsme_SNO NUMBER(22,0) NOT NULL,
                                                      mclrmsme_amt_FROM NUMBER(22,2) NOT NULL,
                                                      mclrmsme_amt_TO NUMBER(22,2) NOT NULL,
                                                      mclrmsme_int_rate NUMBER(22,2) NOT NULL,
                                                      mclrmsme_userid VARCHAR2(50),
                                                      mclrmsme_mod_date DATE)
                                                      
ALTER TABLE APP_SECURITYDETAILS ADD APP_SEC_DESCRIPTION CLOB;
update APP_SECURITYDETAILS set APP_SEC_DESCRIPTION=(select CUS_SEC_SECURITY_DESCRIPTION from CUS_SECURITIES where APP_SEC_SECID=CUS_SEC_ID);

ALTER TABLE SOLVENCY ADD SOl_APPROVE_DATE DATE;
update SOLVENCY set SOL_APPROVE_DATE=(select max(AS_DATE) from APPMAILBOX_SOLVENCY where SOL_APPL_NO=AS_APPNO);

ALTER TABLE FACILITIES ADD FACILITY_MSME_EXPOSURE NUMBER(22,2);

INSERT INTO STATIC_DATA_MASTER (STAT_MAST_ID, STAT_MAST_DESC) VALUES (187, 'Status of Account (SHG)');
INSERT INTO STATIC_DATA (STAT_DATA_ID, STAT_DATA_SNO, STAT_DATA_DESC, STAT_DATA_DESC1, STAT_DATA_ACTIVE, STAT_DATA_DATEMODIFIED, STAT_DATA_CBS_ID) VALUES (187, 1, '1', 'REGULAR', 'Y', null, null);
INSERT INTO STATIC_DATA (STAT_DATA_ID, STAT_DATA_SNO, STAT_DATA_DESC, STAT_DATA_DESC1, STAT_DATA_ACTIVE, STAT_DATA_DATEMODIFIED, STAT_DATA_CBS_ID) VALUES (187, 2, '2', 'DEFAULTER', 'Y', null, null);
INSERT INTO STATIC_DATA (STAT_DATA_ID, STAT_DATA_SNO, STAT_DATA_DESC, STAT_DATA_DESC1, STAT_DATA_ACTIVE, STAT_DATA_DATEMODIFIED, STAT_DATA_CBS_ID) VALUES (187, 3, '3', 'SETTLED', 'Y', null, null);
INSERT INTO STATIC_DATA (STAT_DATA_ID, STAT_DATA_SNO, STAT_DATA_DESC, STAT_DATA_DESC1, STAT_DATA_ACTIVE, STAT_DATA_DATEMODIFIED, STAT_DATA_CBS_ID) VALUES (187, 4, '4', 'SUB-JUDICE', 'Y', null, null);

CREATE TABLE PERAPP_SHGMEMBERS (SHG_ID           VARCHAR2(50 BYTE) NULL,
                                SHG_MEM_SNO      VARCHAR2(10 BYTE) NULL,
                                SHG_MEM_CBSID    VARCHAR2(50 BYTE) NULL,
                                SHG_MEM_LAPSID   VARCHAR2(20 BYTE) NULL,
                                SHG_MEM_NAME     VARCHAR2(100 BYTE) NULL,
                                SHG_MEM_DOB      DATE NULL,
                                SHG_MEM_PAN      VARCHAR2(15 BYTE) NULL,
                                SHG_MEM_EXISTING VARCHAR2(5 BYTE) NULL,
                                SHG_MEM_DEFAULT  VARCHAR2(5 BYTE) NULL)
                                
CREATE  TABLE PERAPP_SHG_ADDNINFO(SHGINFO_APPID VARCHAR2(50) NOT NULL,
                    SHGINFO_SNO VARCHAR2(10),
                    SHGINFO_TYPE VARCHAR2(5),
                    SHGINFO_NAME VARCHAR2(50),
                    SHGINFO_BANK VARCHAR2(50),
                    SHGINFO_ACCNO VARCHAR2(50),
                    SHGINFO_BORROW NUMBER(22,2),
                    SHGINFO_OS NUMBER(22,2),
                    SHGINFO_STATUS VARCHAR2(5))
                    
CREATE  TABLE FAC_SHG_SHARE(FAC_APPNO VARCHAR2(50) NOT NULL,
                          FAC_MEM_SNO VARCHAR2(5) NOT NULL,
                          FAC_MEM_SHARE NUMBER(22,2),
                          FAC_LOAN_TAKEN VARCHAR2(5),
                          FAC_LOAN_AMT NUMBER(22,2),
                          FAC_LOAN_BANK VARCHAR2(5),
                          FAC_SNO VARCHAR2(5))
                          
INSERT INTO STATIC_DATA_MASTER (STAT_MAST_ID, STAT_MAST_DESC) VALUES (188, 'Income Certificate Issuing Authority');

ALTER TABLE EDU_LOAN ADD EDU_OTHR_SUBSIDY VARCHAR2(5);
ALTER TABLE EDU_LOAN ADD EDU_INC_CERT VARCHAR2(5);
ALTER TABLE EDU_LOAN ADD EDU_INC_CERT_NUMBER VARCHAR2(50);
ALTER TABLE EDU_LOAN ADD EDU_INC_CERT_DATE DATE;
ALTER TABLE EDU_LOAN ADD EDU_INC_CERT_AUTHORITY VARCHAR2(50);
ALTER TABLE EDU_LOAN ADD EDU_COURSE_EXTEND VARCHAR2(10);
ALTER TABLE EDU_LOAN ADD EDU_COURSE_STRTDATE DATE;

INSERT INTO STATIC_DATA_MASTER (STAT_MAST_ID, STAT_MAST_DESC) VALUES (190, 'Course Specialization');
INSERT INTO STATIC_DATA_MASTER (STAT_MAST_ID, STAT_MAST_DESC) VALUES (189, 'Education Qualification Proposed');

INSERT INTO STATIC_DATA (STAT_DATA_ID, STAT_DATA_SNO, STAT_DATA_DESC, STAT_DATA_DESC1, STAT_DATA_ACTIVE, STAT_DATA_DATEMODIFIED, STAT_DATA_CBS_ID) VALUES (189, 1, '1', 'DOCTORATE ' || chr(47) || 'OTHER PROFESSIONAL', 'Y', null, null);
INSERT INTO STATIC_DATA (STAT_DATA_ID, STAT_DATA_SNO, STAT_DATA_DESC, STAT_DATA_DESC1, STAT_DATA_ACTIVE, STAT_DATA_DATEMODIFIED, STAT_DATA_CBS_ID) VALUES (189, 2, '2', 'POST GRADUATE', 'Y', null, null);
INSERT INTO STATIC_DATA (STAT_DATA_ID, STAT_DATA_SNO, STAT_DATA_DESC, STAT_DATA_DESC1, STAT_DATA_ACTIVE, STAT_DATA_DATEMODIFIED, STAT_DATA_CBS_ID) VALUES (189, 3, '3', 'GRADUATE', 'Y', null, null);
INSERT INTO STATIC_DATA (STAT_DATA_ID, STAT_DATA_SNO, STAT_DATA_DESC, STAT_DATA_DESC1, STAT_DATA_ACTIVE, STAT_DATA_DATEMODIFIED, STAT_DATA_CBS_ID) VALUES (189, 4, '4', 'DIPLOMA' || chr(47) || 'CERTIFICATION', 'Y', null, null);
INSERT INTO STATIC_DATA (STAT_DATA_ID, STAT_DATA_SNO, STAT_DATA_DESC, STAT_DATA_DESC1, STAT_DATA_ACTIVE, STAT_DATA_DATEMODIFIED, STAT_DATA_CBS_ID) VALUES (189, 5, '5', 'HIGHER SECONDARY', 'Y', null, null);
INSERT INTO STATIC_DATA (STAT_DATA_ID, STAT_DATA_SNO, STAT_DATA_DESC, STAT_DATA_DESC1, STAT_DATA_ACTIVE, STAT_DATA_DATEMODIFIED, STAT_DATA_CBS_ID) VALUES (189, 6, '6', 'BELOW HIGHER SECONDARY', 'Y', null, null);
INSERT INTO STATIC_DATA (STAT_DATA_ID, STAT_DATA_SNO, STAT_DATA_DESC, STAT_DATA_DESC1, STAT_DATA_ACTIVE, STAT_DATA_DATEMODIFIED, STAT_DATA_CBS_ID) VALUES (189, 7, '7', 'PG-DEGREE', 'Y', null, null);
INSERT INTO STATIC_DATA (STAT_DATA_ID, STAT_DATA_SNO, STAT_DATA_DESC, STAT_DATA_DESC1, STAT_DATA_ACTIVE, STAT_DATA_DATEMODIFIED, STAT_DATA_CBS_ID) VALUES (189, 8, '8', 'PG-DIPLOMA', 'Y', null, null);

INSERT INTO STATIC_DATA (STAT_DATA_ID, STAT_DATA_SNO, STAT_DATA_DESC, STAT_DATA_DESC1, STAT_DATA_ACTIVE, STAT_DATA_DATEMODIFIED, STAT_DATA_CBS_ID) VALUES (190, 1, '1', 'ENGINEERING', 'Y', null, null);
INSERT INTO STATIC_DATA (STAT_DATA_ID, STAT_DATA_SNO, STAT_DATA_DESC, STAT_DATA_DESC1, STAT_DATA_ACTIVE, STAT_DATA_DATEMODIFIED, STAT_DATA_CBS_ID) VALUES (190, 2, '2', 'MEDICAL', 'Y', null, null);
INSERT INTO STATIC_DATA (STAT_DATA_ID, STAT_DATA_SNO, STAT_DATA_DESC, STAT_DATA_DESC1, STAT_DATA_ACTIVE, STAT_DATA_DATEMODIFIED, STAT_DATA_CBS_ID) VALUES (190, 3, '3', 'NURSING AND OTHER PROFESSIONAL COURSES', 'Y', null, null);
INSERT INTO STATIC_DATA (STAT_DATA_ID, STAT_DATA_SNO, STAT_DATA_DESC, STAT_DATA_DESC1, STAT_DATA_ACTIVE, STAT_DATA_DATEMODIFIED, STAT_DATA_CBS_ID) VALUES (190, 4, '4', 'MANAGEMENT', 'Y', null, null);
INSERT INTO STATIC_DATA (STAT_DATA_ID, STAT_DATA_SNO, STAT_DATA_DESC, STAT_DATA_DESC1, STAT_DATA_ACTIVE, STAT_DATA_DATEMODIFIED, STAT_DATA_CBS_ID) VALUES (190, 5, '5', 'OTHERS', 'Y', null, null);
INSERT INTO STATIC_DATA (STAT_DATA_ID, STAT_DATA_SNO, STAT_DATA_DESC, STAT_DATA_DESC1, STAT_DATA_ACTIVE, STAT_DATA_DATEMODIFIED, STAT_DATA_CBS_ID) VALUES (190, 6, '6', 'LAW', 'Y', null, null);

INSERT INTO APP_POST_SANC_PAGEMAP (PS_SNO, PS_PARAM_DESC, PS_PARAM, PS_PAGEID, PS_ACTIVE, PS_MODULETYPE) VALUES ('32', 'Miscellaneous changes ' || chr(47) || ' Modifications', 'MISMOD', '1@2@4@7@8@9@10@11@', 'Y', 'P');
INSERT INTO APP_POST_SANC_PAGEMAP (PS_SNO, PS_PARAM_DESC, PS_PARAM, PS_PAGEID, PS_ACTIVE, PS_MODULETYPE) VALUES ('31', 'Extension of Course period(Only for Education Loans)', 'COEX', '1@7@9@', 'Y', 'P ');
INSERT INTO OTHER_PARAMETERS (LOAN_PARAMVAL, LOAN_PARAMSLNO) VALUES ('', 'KALYPTO');


ALTER TABLE APPLICATIONS ADD APP_ROHODATE DATE;

CREATE TABLE LOAN_DRAWDOWN (APP_NO         VARCHAR2(22 BYTE) NOT NULL,
                            FAC_SNO        NUMBER(22,0) NOT NULL,
                            QTR_START_DATE DATE NOT NULL,
                            QTR_END_DATE   DATE NOT NULL,
                            TOT_QTR        NUMBER(22,2) NOT NULL,
                            AMT_QTR        NUMBER(22,2) NOT NULL,
                            DD_SNO         VARCHAR2(5 BYTE) NULL);
                            
ALTER TABLE NPA_PROV_EXEC_STATUS ADD EXE_EXCEPTION VARCHAR2(4000);
