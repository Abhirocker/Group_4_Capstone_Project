package eshop.homedecor.report.response;

import java.util.List;

import eshop.homedecor.report.entity.ProductInfo;

public class ProductInfoResponse {
	
	private List<ProductInfo> productList;

	public List<ProductInfo> getProductList() {
		return productList;
	}

	public void setProductList(List<ProductInfo> productList) {
		this.productList = productList;
	}
	

}
