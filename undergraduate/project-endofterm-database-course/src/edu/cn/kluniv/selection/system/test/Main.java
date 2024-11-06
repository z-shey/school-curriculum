package edu.cn.kluniv.selection.system.test;

import edu.cn.kluniv.selection.system.util.DBUtil;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class Main {
    public static void main(String[] args) {
        readPropertiesFile();
    }

    public static void readPropertiesFile() {
        InputStream in = DBUtil.class.getResourceAsStream("db.properties");
        Properties p = new Properties();

        try {
            p.load(in);
            for (String key : p.stringPropertyNames()) {
                String value = p.getProperty(key);
                System.out.println(key + " = " + value);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (in != null) {
                try {
                    in.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}

