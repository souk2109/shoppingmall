package org.shoppingmall.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.shoppingmall.domain.AttachFileDTO;
import org.shoppingmall.domain.ProductAttachVO;
import org.shoppingmall.service.ProductAttachService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {
	@Autowired
	private ProductAttachService productAttachService;
	
	@PostMapping(value = "/uploadImageAction", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxAction(MultipartFile [] attachFile) {
		String uploadFolder = "C:\\shoppingmall\\products";
		String uploadFolderPath = getFolder();
		List<AttachFileDTO> list = uploadMethod(uploadFolder, uploadFolderPath, attachFile);
		return new ResponseEntity<List<AttachFileDTO>>(list, HttpStatus.OK);
	}

	// 현재 시간을 경로명으로 반환 -> ex) 2020\\03\\01
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		File file = new File("C:\\shoppingmall\\products\\" + fileName);
		ResponseEntity<byte[]> result = null;
		
		HttpHeaders header = new HttpHeaders();
		try {
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
		File file;
		try {
			file = new File("C:\\shoppingmall\\products\\"+URLDecoder.decode(fileName,"UTF-8"));
			file.delete(); // 섬네일 삭제
			if(type.equals("image")) {
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				log.info(largeFileName);
				file = new File(largeFileName);
				file.delete(); // 원본 이미지 삭제
			}else {
				
			}
		} catch (UnsupportedEncodingException e) {
			return new ResponseEntity<String>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
	@ResponseBody
	@GetMapping(value = "/getProductImages/{pno}", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<List<ProductAttachVO>> getProductImages(@PathVariable("pno") int pno) {
		List<ProductAttachVO> list = productAttachService.getProductImages(pno);
		return new ResponseEntity<List<ProductAttachVO>>(list, HttpStatus.OK);
	}
	
	@PostMapping(value = "/uploadReviewImageAction", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadReviewImageAction(MultipartFile [] attachFile) {
		String uploadFolder = "C:\\shoppingmall\\review";
		String uploadFolderPath = getFolder();
		List<AttachFileDTO> list = uploadMethod(uploadFolder,uploadFolderPath, attachFile);
		return new ResponseEntity<List<AttachFileDTO>> (list, HttpStatus.OK);
	}
	
	@GetMapping("/reviewDisplay")
	@ResponseBody
	public ResponseEntity<byte[]> getReviewFile(String fileName){
		File file = new File("C:\\shoppingmall\\review\\" + fileName);
		
		ResponseEntity<byte[]> result = null;
		
		HttpHeaders header = new HttpHeaders();
		try {
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@GetMapping("/businessDisplay")
	@ResponseBody
	public ResponseEntity<byte[]> businessDisplay(String fileName){
		File file = new File("C:\\shoppingmall\\business\\" + fileName);
		ResponseEntity<byte[]> result = null;
		HttpHeaders header = new HttpHeaders();
		try {
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@PostMapping(value = "/uploadBuisnessImageAction", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadBuisnessImageAction(MultipartFile [] attachFile) {
		String uploadFolder = "C:\\shoppingmall\\business";
		String uploadFolderPath = getFolder();
		List<AttachFileDTO> list = uploadMethod(uploadFolder,uploadFolderPath, attachFile);
		return new ResponseEntity<List<AttachFileDTO>> (list, HttpStatus.OK);
	}
	
	@GetMapping("/buisnessDisplay")
	@ResponseBody
	public ResponseEntity<byte[]> getBuisnessFile(String fileName){
		File file = new File("C:\\shoppingmall\\business\\" + fileName);
		
		ResponseEntity<byte[]> result = null;
		
		HttpHeaders header = new HttpHeaders();
		try {
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 업로드할 파일들을 저장할 폴더명, 경로, 파일들을 받아서 저장한다.
	private List<AttachFileDTO> uploadMethod(String uploadFolder, String uploadFolderPath, MultipartFile[] attachFile) {
		List<AttachFileDTO> list = new ArrayList<AttachFileDTO>();
		// 저장할 폴더 생성하기
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		if (!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		for(MultipartFile multipartFile : attachFile) {
			AttachFileDTO attachFileDTO = new AttachFileDTO();
			String uploadFileName = multipartFile.getOriginalFilename();
			UUID uuid = UUID.randomUUID();
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			attachFileDTO.setFileName(uploadFileName);
				
			uploadFileName = uuid.toString() + "_" + uploadFileName; 
				
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				attachFileDTO.setUuid(uuid.toString());
				attachFileDTO.setUploadPath(uploadFolderPath);
				if(checkImageType(saveFile)) {
					attachFileDTO.setImage(true);
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_"+uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 200, 200);
					thumbnail.close();
				}
				list.add(attachFileDTO);
			} catch (IllegalStateException | IOException e) {
				log.error(e.getMessage());
			}
		}
		return list;
	}
}
