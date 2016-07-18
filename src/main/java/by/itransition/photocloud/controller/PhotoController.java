package by.itransition.photocloud.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/photo")
public class PhotoController {

    @GetMapping
    public String photos() {
        return "photos/photos";
    }

    @GetMapping("/upload")
    public String uploadPhoto(Model model) {
        return "photos/upload";
    }

}


//        long unixTime = System.currentTimeMillis() / 1000L;

//        String unsignedData = "&quot;api_key&quot;:&quot;891695265656755&quot;,&quot;timestamp&quot;:&quot;" + unixTime + "&quot;";
//        String unsignedDataForSHA = "timestamp="+unixTime;
//        String apiSecret = "IgVMXOvT6dWU8tQZIPf5bukwyHw";
//        String unsignedDataSecret = unsignedDataForSHA + apiSecret;
//        String signedData = unsignedData + ",&quot;signature&quot;:&quot;" + DigestUtils.shaHex(unsignedDataSecret.getBytes()) + "&quot;";

//        String unsignedData = "&quot;api_key&quot;:&quot;891695265656755&quot;,&quot;callback&quot;:&quot;http://localhost:8080/resources/cloudinary_cors.html&quot;,&quot;timestamp&quot;:&quot;" + unixTime + "&quot;";
//        String unsignedDataForSHA = "timestamp="+unixTime;
//        String apiSecret = "IgVMXOvT6dWU8tQZIPf5bukwyHw";
//        String unsignedDataSecret = unsignedDataForSHA + apiSecret;
//        String signedData = unsignedData + ",&quot;signature&quot;:&quot;" + DigestUtils.shaHex(unsignedDataSecret.getBytes()) + "&quot;";
//
//        JSONObject jsonObject = new JSONObject("{" + signedData.replaceAll("&quot;", "\"") + "}");
//
//        model.addAttribute("cloudinaryData", jsonObject);

