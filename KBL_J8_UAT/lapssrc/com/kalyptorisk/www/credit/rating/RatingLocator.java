/**
 * RatingLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.kalyptorisk.www.credit.rating;

public class RatingLocator extends org.apache.axis.client.Service implements com.kalyptorisk.www.credit.rating.Rating {

    public RatingLocator() {
    }


    public RatingLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public RatingLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for RatingSoap
    private java.lang.String RatingSoap_address = "http://172.20.107.11/Kalypto.Credit.Test3/interfaces/ratingretail.asmx";

    public java.lang.String getRatingSoapAddress() {
        return RatingSoap_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String RatingSoapWSDDServiceName = "RatingSoap";

    public java.lang.String getRatingSoapWSDDServiceName() {
        return RatingSoapWSDDServiceName;
    }

    public void setRatingSoapWSDDServiceName(java.lang.String name) {
        RatingSoapWSDDServiceName = name;
    }

    public com.kalyptorisk.www.credit.rating.RatingSoap getRatingSoap() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(RatingSoap_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getRatingSoap(endpoint);
    }

    public com.kalyptorisk.www.credit.rating.RatingSoap getRatingSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.kalyptorisk.www.credit.rating.RatingSoapStub _stub = new com.kalyptorisk.www.credit.rating.RatingSoapStub(portAddress, this);
            _stub.setPortName(getRatingSoapWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setRatingSoapEndpointAddress(java.lang.String address) {
        RatingSoap_address = address;
    }


    // Use to get a proxy class for RatingSoap12
    private java.lang.String RatingSoap12_address = "http://172.20.107.11/Kalypto.Credit.Test3/interfaces/ratingretail.asmx";

    public java.lang.String getRatingSoap12Address() {
        return RatingSoap12_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String RatingSoap12WSDDServiceName = "RatingSoap12";

    public java.lang.String getRatingSoap12WSDDServiceName() {
        return RatingSoap12WSDDServiceName;
    }

    public void setRatingSoap12WSDDServiceName(java.lang.String name) {
        RatingSoap12WSDDServiceName = name;
    }

    public com.kalyptorisk.www.credit.rating.RatingSoap getRatingSoap12() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(RatingSoap12_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getRatingSoap12(endpoint);
    }

    public com.kalyptorisk.www.credit.rating.RatingSoap getRatingSoap12(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.kalyptorisk.www.credit.rating.RatingSoap12Stub _stub = new com.kalyptorisk.www.credit.rating.RatingSoap12Stub(portAddress, this);
            _stub.setPortName(getRatingSoap12WSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setRatingSoap12EndpointAddress(java.lang.String address) {
        RatingSoap12_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     * This service has multiple ports for a given interface;
     * the proxy implementation returned may be indeterminate.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (com.kalyptorisk.www.credit.rating.RatingSoap.class.isAssignableFrom(serviceEndpointInterface)) {
                com.kalyptorisk.www.credit.rating.RatingSoapStub _stub = new com.kalyptorisk.www.credit.rating.RatingSoapStub(new java.net.URL(RatingSoap_address), this);
                _stub.setPortName(getRatingSoapWSDDServiceName());
                return _stub;
            }
            if (com.kalyptorisk.www.credit.rating.RatingSoap.class.isAssignableFrom(serviceEndpointInterface)) {
                com.kalyptorisk.www.credit.rating.RatingSoap12Stub _stub = new com.kalyptorisk.www.credit.rating.RatingSoap12Stub(new java.net.URL(RatingSoap12_address), this);
                _stub.setPortName(getRatingSoap12WSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("RatingSoap".equals(inputPortName)) {
            return getRatingSoap();
        }
        else if ("RatingSoap12".equals(inputPortName)) {
            return getRatingSoap12();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://www.kalyptorisk.com/credit/rating", "Rating");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://www.kalyptorisk.com/credit/rating", "RatingSoap"));
            ports.add(new javax.xml.namespace.QName("http://www.kalyptorisk.com/credit/rating", "RatingSoap12"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("RatingSoap".equals(portName)) {
            setRatingSoapEndpointAddress(address);
        }
        else 
if ("RatingSoap12".equals(portName)) {
            setRatingSoap12EndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
