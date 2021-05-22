package org.shoppingmall.service;

import java.util.ArrayList;
import java.util.List;

import org.shoppingmall.domain.Criteria;
import org.shoppingmall.domain.ProductAttachVO;
import org.shoppingmall.domain.ProductInfoVO;
import org.shoppingmall.mapper.ProductAttachMapper;
import org.shoppingmall.mapper.ProductInfoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;
@Log4j
@Service
public class ProductInfoServiceImpl implements ProductInfoService{
	@Autowired 
	private ProductInfoMapper productInfoMapper;
	@Autowired
	private ProductAttachMapper productAttachMapper; 
	
	@Transactional
	@Override
	public int insertProductInfoVO(ProductInfoVO productInfoVO) {
		productInfoMapper.insertProductInfo(productInfoVO);
		int pno = productInfoVO.getPno();
		if(productInfoVO.getAttachList() == null || productInfoVO.getAttachList().size() <= 0) {
			return pno;
		}
		productInfoVO.getAttachList().forEach(attach -> {
			attach.setPno(pno);
			productAttachMapper.insertProductAttachVO(attach);
		});
		return pno;
	}

	@Override
	public List<ProductInfoVO> getProductInfoList(String loginedId) {
		List<ProductInfoVO> list = productInfoMapper.getProductInfoList(loginedId);
		list.forEach(product -> {
			int pno = product.getPno();
			ProductAttachVO mainPicture = productAttachMapper.getMainAttachVO(pno);
			List<ProductAttachVO> ProductAttachList = new ArrayList<ProductAttachVO>();
			ProductAttachList.add(mainPicture);
			product.setAttachList(ProductAttachList);
		});
		return list;
	}

	@Override
	public ProductInfoVO getProductInfo(int pno) {
		ProductInfoVO productInfoVO = new ProductInfoVO();
		productInfoVO = productInfoMapper.getProductInfo(pno);
		List<ProductAttachVO> attachList = productAttachMapper.getAttachsByPno(pno);
		productInfoVO.setAttachList(attachList);
		return productInfoVO;
	}
	
	@Transactional
	@Override
	public void modifyProductInfoVO(ProductInfoVO productInfoVO) {
		productInfoMapper.updateProductInfo(productInfoVO);
		int pno = productInfoVO.getPno();
		// pno의 이미지인 것을 모두 삭제
		// 다시 insert해주면 된다.
		productAttachMapper.deleteProductAttachsByPno(pno);
		
		  if(productInfoVO.getAttachList() == null ||
		  productInfoVO.getAttachList().size() <= 0) { return; }
		 
		productInfoVO.getAttachList().forEach(attach -> {
			attach.setPno(pno);
			log.info("-- ---- -- attach : "+attach);
			productAttachMapper.insertProductAttachVO(attach);;
		});
	}

	// 페이징 처리 전의 모든 상품정보를 가져오는 메소드
	@Override
	public List<ProductInfoVO> getAllProductInfoList() {
		List<ProductInfoVO> list = productInfoMapper.getAllProductInfoList();
		list.forEach(product -> {
			int pno = product.getPno();
			ProductAttachVO mainPicture = productAttachMapper.getMainAttachVO(pno);
			List<ProductAttachVO> ProductAttachList = new ArrayList<ProductAttachVO>();
			ProductAttachList.add(mainPicture);
			product.setAttachList(ProductAttachList);
		});
		return list;
	}

	@Override
	public void minusProductStock(int pno, int count) {
		productInfoMapper.minusProductStock(pno, count);
	}

	@Override
	public int getCount(Criteria criteria) {
		return productInfoMapper.getCount(criteria);
	}

	@Override
	public List<ProductInfoVO> getProductInfoListWithPaging(Criteria criteria) {
		List<ProductInfoVO> list = productInfoMapper.getProductInfoListWithPaging(criteria);
		list.forEach(product -> {
			int pno = product.getPno();
			ProductAttachVO mainPicture = productAttachMapper.getMainAttachVO(pno);
			List<ProductAttachVO> ProductAttachList = new ArrayList<ProductAttachVO>();
			ProductAttachList.add(mainPicture);
			product.setAttachList(ProductAttachList);
		});
		return list;
	}

}
