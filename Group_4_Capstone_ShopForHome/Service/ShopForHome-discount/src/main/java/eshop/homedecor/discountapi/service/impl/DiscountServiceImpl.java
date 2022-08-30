package eshop.homedecor.discountapi.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import eshop.homedecor.discountapi.entity.Discount;
import eshop.homedecor.discountapi.repository.DiscountRepository;
import eshop.homedecor.discountapi.service.DiscountService;

@Service
public class DiscountServiceImpl implements DiscountService {
	
	@Autowired
	DiscountRepository discountRepository;

	
	@Transactional
	public Discount createCoupon(String code) {
		Integer status=0;
		Discount coupon=new Discount();
		coupon.setCoupon(code);
		coupon.setStatus(status.longValue());
		return discountRepository.save(coupon);
	}

	@Override
	@Transactional
	public Page<Discount> findAll(PageRequest request) {
		return discountRepository.findAll(request);
		
	}

	@Override
	@Transactional
	public void deleteCoupon(Long code) {
		
		 discountRepository.deleteById(code);
	}

	@Override
	@Transactional
	public List<Discount> findAll() {
		return discountRepository.findAll();
	}

	@Override
	@Transactional
	public void createCoupon(String code, List<String> emails) {
		Integer status=0;
		List<Discount> discountList = new ArrayList<Discount>();
		for(String email:emails) {
		 Discount coupon=new Discount();
		 coupon.setCoupon(code);
		 coupon.setStatus(status.longValue());
		 coupon.setEmail(email);
		 discountList.add(coupon);
		}
		discountRepository.saveAll(discountList);
	}

	@Override
	@Transactional
	public List<Discount> findAll(String email) {
		
		return discountRepository.findByEmail(email);
	}

}
