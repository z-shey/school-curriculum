package shey;

/**
 * @Project: hadoop-practice
 * @File: HDFSHandle.java
 * @PACKAGE_NAME: shey
 * @Version: 1.0.0
 * @Author: Shey
 * @Created: 03/20/24
 * @Modified: 03/20/24
 * @Description: HDFSHandle.java
 **/

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.*;
import org.apache.hadoop.io.IOUtils;
import org.apache.log4j.Logger;

import java.io.IOException;
import java.net.URI;
import java.text.SimpleDateFormat;
import java.util.Date;

public class HDFSHandle {
    private final String ip; // HDFS服务器IP
    private final String port; // HDFS服务器端口
    private final String user; // HDFS服务器用户名
    private static final String DEFAULT_FS_URI = "hdfs://%s:%s"; // HDFS文件系统URI
    private static final Logger logger = Logger.getLogger(HDFSHandle.class); // 日志记录器

    /**
     * 创建HDFS文件系统
     *
     * @param ip   HDFS服务器IP
     * @param port HDFS服务器端口
     * @param user HDFS服务器用户名
     */
    public HDFSHandle(String ip, String port, String user) {
        this.ip = ip;
        this.port = port;
        this.user = user;
    }

    /**
     * 创建HDFS文件
     *
     * @param filePath 文件路径
     * @param content  文件内容
     */
    public void create(String filePath, String content) {
        try {
            Configuration configuration = new Configuration();
            configuration.set("fs.defaultFS", String.format(DEFAULT_FS_URI, ip, port));

            try (FileSystem fileSystem = FileSystem.get(new URI(String.format(DEFAULT_FS_URI, ip, port)), configuration, user)) {
                if (fileSystem.exists(new Path(filePath))) {
                    System.out.println("文件已存在，无需创建: " + filePath);
                } else {
                    try (FSDataOutputStream fos = fileSystem.create(new Path(filePath))) {
                        if (content != null) {
                            fos.write(content.getBytes());
                        }
                        System.out.println("文件创建成功: " + filePath);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("创建文件时发生错误", e);
        }
    }


    /**
     * 创建HDFS文件
     *
     * @param filePath 文件路径
     * @see #create(String, String)
     */
    public void create(String filePath) {
        create(filePath, null);
    }

    /**
     * 读取HDFS文件
     *
     * @param filePath 文件路径
     */
    public void read(String filePath) {
        try {
            Configuration configuration = new Configuration();
            configuration.set("fs.defaultFS", String.format(DEFAULT_FS_URI, ip, port));

            try (FileSystem fileSystem = FileSystem.get(configuration);
                 FSDataInputStream fsDataInputStream = fileSystem.open(new Path(filePath))) {

                IOUtils.copyBytes(fsDataInputStream, System.out, 4096, false);
            }
            System.out.println("========== 文件读取成功 ==========》 " + filePath);
        } catch (IOException e) {
            e.printStackTrace();
            logger.error("读取文件时发生错误", e);
        }
    }

    /**
     * 删除HDFS文件
     *
     * @param filePath 文件路径
     */
    public void delete(String filePath) {
        try (FileSystem fileSystem = FileSystem.get(new URI(String.format(DEFAULT_FS_URI, ip, port)), new Configuration(), user)) {
            Path path = new Path(filePath);

            fileSystem.delete(path, true);

            System.out.println("========== 删除文件成功 ==========》 " + filePath);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("删除文件时发生错误", e);
        }
    }


    /**
     * 上传文件
     *
     * @param localFilePath  本地文件路径
     * @param remoteFilePath 远程文件路径
     */
    public void upload(String localFilePath, String remoteFilePath) {
        try {
            Configuration configuration = new Configuration();

            try (FileSystem fileSystem = FileSystem.get(new URI(String.format(DEFAULT_FS_URI, ip, port)), configuration, user)) {

                localFilePath = "src/main/resources/" + localFilePath;
                Path localPath = new Path(localFilePath);
                Path remotePath = new Path(remoteFilePath);

                if (fileSystem.exists(remotePath)) {
                    System.out.println("文件已经存在: " + remoteFilePath);
                    return;
                }

                fileSystem.copyFromLocalFile(false, true, localPath, remotePath);

                System.out.println("========== 上传文件成功 ==========》 " + remoteFilePath);
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("上传文件时发生错误", e);
        }
    }


    /**
     * 下载文件
     *
     * @param remoteFilePath 远程文件路径
     * @param localFilePath  本地文件路径
     */
    public void download(String remoteFilePath, String localFilePath) {
        try (FileSystem fileSystem = FileSystem.get(new URI(String.format(DEFAULT_FS_URI, ip, port)), new Configuration(), user)) {
            fileSystem.copyToLocalFile(false, new Path(remoteFilePath), new Path(localFilePath));

            System.out.println("========== 下载文件成功 ==========》 " + localFilePath);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("下载文件时发生错误", e);
        }
    }

    /**
     * 重命名
     *
     * @param filePath 文件路径
     * @param newName  新名称
     */
    public void rename(String filePath, String newName) {
        try (FileSystem fileSystem = FileSystem.get(new URI(String.format(DEFAULT_FS_URI, ip, port)), new Configuration(), user)) {
            Path newPath = new Path(filePath.substring(0, filePath.lastIndexOf("/") + 1) + newName);

            if (fileSystem.exists(newPath)) {
                System.out.println("重命名已存在，无需重命名: " + newPath.toString());
            } else {
                fileSystem.rename(new Path(filePath), newPath);
                System.out.println("重命名成功: " + newPath.toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("重命名文件时发生错误", e);
        }
    }


    /**
     * 查看文件属性
     *
     * @param filePath 文件路径
     */
    public void fileAttribute(String filePath) {
        try (FileSystem fileSystem = FileSystem.get(new URI(String.format(DEFAULT_FS_URI, ip, port)), new Configuration(), user)) {
            FileStatus fileStatus = fileSystem.getFileStatus(new Path(filePath));

            System.out.println("========== 文件属性 ==========");
            System.out.println("| 文件名：" + fileStatus.getPath().getName());
            System.out.println("| 文件大小：" + fileStatus.getLen() + " 字节");
            System.out.println("| 文件块大小：" + fileStatus.getBlockSize() + " 字节");
            System.out.println("| 文件副本数量：" + fileStatus.getReplication() + " 个");
            System.out.println("| 文件权限：" + fileStatus.getPermission());

            // 将时间戳转换为年月日格式
            Date modificationTime = new Date(fileStatus.getModificationTime());
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String formattedModificationTime = dateFormat.format(modificationTime);

            System.out.println("| 文件修改时间：" + formattedModificationTime);
            System.out.println("| 文件拥有者：" + fileStatus.getOwner());
            System.out.println("| 文件拥有者组：" + fileStatus.getGroup());
            System.out.println("| 文件路径：" + fileStatus.getPath());
            System.out.println("=============================");
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("获取文件属性时发生错误", e);
        }
    }
}


