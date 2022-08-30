package eshop.homedecor.discountapi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

@SpringBootApplication
@EnableEurekaClient
public class DiscountApplication {

	public static void main(String[] args) {
		SpringApplication.run(DiscountApplication.class, args);
	}

}
