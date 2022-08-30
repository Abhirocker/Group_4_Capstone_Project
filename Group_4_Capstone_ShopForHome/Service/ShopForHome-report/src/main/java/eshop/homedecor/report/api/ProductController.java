package eshop.homedecor.report.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import eshop.homedecor.report.response.ProductInfoResponse;
import eshop.homedecor.report.service.impl.ProductServiceImpl;


@CrossOrigin
@RestController
public class ProductController {
   
    @Autowired
    ProductServiceImpl productService;

    

       
    @GetMapping("/productall")
    public ProductInfoResponse findAll() {
    	ProductInfoResponse response=new ProductInfoResponse();
    	response.setProductList(productService.findAll());
        return response;
    }

   
}
