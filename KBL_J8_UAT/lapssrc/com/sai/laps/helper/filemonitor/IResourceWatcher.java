package com.sai.laps.helper.filemonitor;

/**
 * Representation of an object that watches a resource (directory, database
 * etc...) for any changes and notifies its list of listeners when an event
 * occurs.
 *
 */

/**
 * @author S.SATHYA MOORTHY 
 * @SINCE 24/11/2008
 * @PURPOSE : FILE AND FOLDER LISTENER FOR LAPS ARCHITECURE.
 */
public interface IResourceWatcher {

    /**
     * Start watching the resource.
     */
    public void start();

    /**
     * Add a listener to this watcher.
     *
     * @param listener the listener to add
     */
    public void addListener(IResourceListener listener);

    /**
     * Remove a listener from this watcher.
     *
     * @param listener the listener to remove
     */
    public void removeListener(IResourceListener listener);

    /**
     * Stop the monitoring of the particular resource.
     */
    public void stop();
}


