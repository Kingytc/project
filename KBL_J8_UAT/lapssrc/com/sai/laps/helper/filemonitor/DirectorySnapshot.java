package com.sai.laps.helper.filemonitor;

import java.util.Map;
import java.util.HashMap;

/**
 * @author S.SATHYA MOORTHY 
 * @SINCE 24/11/2008
 * @PURPOSE : FILE AND FOLDER LISTENER FOR LAPS ARCHITECURE.
 */
public class DirectorySnapshot {

    private static Map files = new HashMap();

    public static void addFile(String fileName){
        files.put(fileName, fileName);
    }

    public static void removeFile(String fileName){
        files.remove(fileName);
    }

    public static boolean containsFile(String fileName){
        return files.containsKey(fileName);
    }
}
