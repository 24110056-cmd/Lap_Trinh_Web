package vn.iotstar.utils;

import java.io.IOException;
import java.util.Map;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import jakarta.servlet.http.Part;

public class CloudinaryUtils {

    private static final Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
            "cloud_name", Constant.CLOUDINARY_CLOUD_NAME,
            "api_key", Constant.CLOUDINARY_API_KEY,
            "api_secret", Constant.CLOUDINARY_API_SECRET,
            "secure", true
    ));

    public static String uploadImage(Part filePart) throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }
        byte[] fileBytes = filePart.getInputStream().readAllBytes();
        Map<?, ?> uploadResult = cloudinary.uploader().upload(fileBytes, ObjectUtils.asMap(
                "folder", "iotstar_profiles",
                "resource_type", "image"
        ));
        return uploadResult.get("secure_url").toString();
    }
}
