package eshop.homedecor.discountapi.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import eshop.homedecor.discountapi.entity.Discount;
import eshop.homedecor.discountapi.response.ResponseMessage;
import eshop.homedecor.discountapi.service.DiscountService;

@CrossOrigin
@RestController
public class DiscountController {
	
	@Autowired
	DiscountService discountService;
	
    @PostMapping("/add/coupon/{code}")
	public void createCoupon(@PathVariable("code") String code,@RequestBody List<String> emails) {
    	
    	 discountService.createCoupon(code,emails); 
    	
    }
    
    @GetMapping("/coupon/list")
    public Page<Discount> couponList(@RequestParam(value = "page", defaultValue = "1") Integer page,
                                     @RequestParam(value = "size", defaultValue = "10") Integer size
                                    ) {
        PageRequest request = PageRequest.of(page - 1, size);
        Page<Discount> discountPage;
        discountPage = discountService.findAll(request);
        return discountPage;
    }
    
    @GetMapping("/coupon/alllist")
    public List<Discount> orderList() {
        
        
         
        return discountService.findAll();
    }
    
    @PostMapping("/delete/coupon/{code}")
	public ResponseEntity<Discount> deleteCoupon(@PathVariable("code") Long code) {
    	discountService.deleteCoupon(code);
    	return ResponseEntity.ok(null); 
    }
    
    @GetMapping("/coupon/alllist/{email}")
    public List<Discount> couponList(@PathVariable("email") String email){
    	return discountService.findAll(email);
    }
    



}
