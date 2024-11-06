package shey;

/**
 * @Project: Default (Template) Project
 * @File: Main.java
 * @PACKAGE_NAME: shey
 * @Version: 1.0.0
 * @Author: Shey
 * @Created: 03/20/24
 * @Modified: 03/20/24
 * @Description: Main.java
 **/
public class Main {
    public static void main(String[] args) {
        String ip = "192.168.5.128";
        String port = "9000";
        String user = "shey";

        HDFSHandle handle = new HDFSHandle(ip, port, user);

//        handle.create("/document/222.txt");
//        handle.read("/document/2024_3_15_23_19remote.txt");
//        handle.fileAttribute("/document/2024_3_15_23_19remote.txt");
//        handle.rename("/document/222.txt", "tessssss.txt");
        handle.upload("43.txt", "/document/");
    }
}