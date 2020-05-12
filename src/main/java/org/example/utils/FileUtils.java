package org.example.utils;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.UUID;

public class FileUtils {

    /*
    * Static method that is uploading file in message.
    * Method returns String value. If file has been uploaded, method returns filename. Else, empty string.
    * */
    public static String uploadFile(String uploadPath, MultipartFile file) {
        File uploadDir = new File(uploadPath);
        boolean mkdirResult = true;

        if(!uploadDir.exists()) {
            mkdirResult = uploadDir.mkdir();
        }

        if(!mkdirResult)
            return "";

        String uuidFile = UUID.randomUUID().toString();
        String resultFilename = uuidFile + "." + file.getOriginalFilename();

        try {
            file.transferTo(new File(uploadPath + "/" + resultFilename));
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return "";
        }

        return resultFilename;
    }
}
