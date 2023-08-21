/**
 * RatingSoap.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.kalyptorisk.www.credit.rating;

public interface RatingSoap extends java.rmi.Remote {

    /**
     * Rating upload and evaluation for retail pool customers.
     */
    public java.lang.String retailEvaluation(java.lang.String proposalID) throws java.rmi.RemoteException;

    /**
     * Rating upload for Corporate customers. This evaluation is for
     * Borrower and Facility Rating.
     */
    public java.lang.String corporateRating(java.lang.String proposalID) throws java.rmi.RemoteException;
}
