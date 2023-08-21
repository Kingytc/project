/**
 * Rating.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.kalyptorisk.www.credit.rating;

public interface Rating extends javax.xml.rpc.Service {
    public java.lang.String getRatingSoapAddress();

    public com.kalyptorisk.www.credit.rating.RatingSoap getRatingSoap() throws javax.xml.rpc.ServiceException;

    public com.kalyptorisk.www.credit.rating.RatingSoap getRatingSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
    public java.lang.String getRatingSoap12Address();

    public com.kalyptorisk.www.credit.rating.RatingSoap getRatingSoap12() throws javax.xml.rpc.ServiceException;

    public com.kalyptorisk.www.credit.rating.RatingSoap getRatingSoap12(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
}
