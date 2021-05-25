package org.shoppingmall.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.shoppingmall.domain.ProductAttachVO;
import org.shoppingmall.domain.ReviewAttachVO;
import org.shoppingmall.mapper.ProductAttachMapper;
import org.shoppingmall.mapper.ReviewAttachMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.extern.log4j.Log4j;

@Component
@Log4j
public class FileCheckTask {
	@Autowired
	private ProductAttachMapper productAttachMapper;
	
	@Autowired
	private ReviewAttachMapper reviewAttachMapper;
	
	private String getFolderYesterDay() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		String str = sdf.format(cal.getTime());
		return str.replace("-", File.separator);
	}
	
	@Scheduled(cron="0 10 * * * *")  // 매시 10분에 실행
	public void deleteProductAttaches() throws Exception{
		log.warn("File Check Task run................");
		log.warn(new Date());

		// 어제 업로드 된 첨부파일 목록
		List<ProductAttachVO> fileList = productAttachMapper.getYesterDayAttaches();
		
		// 어제 업로드 된 첨부파일 목록으로 파일경로 구함
		// ready for check file in directory with DB file list
		List<Path> fileListPaths = fileList.stream()
				.map(
					vo -> Paths.get("C:\\shoppingmall\\products",vo.getPath(),
							vo.getUuid()+"_" + vo.getFileName())
					)
				.collect(Collectors.toList());
				

		// 이미지인 경우 썸네일 파일의 경로 목록
		fileList.stream().filter(vo -> vo.isFileType() == true)
		      .map(
		            vo -> Paths.get(
		                  "C:\\shoppingmall\\products", 
		                  vo.getPath(), 
		                  "s_" + vo.getUuid() + "_" + vo.getFileName())
		      )
		      .forEach(p -> fileListPaths.add(p));

		
		log.warn("================ 어제 상품관련 모든 첨부 파일 ======================");
		fileListPaths.forEach(p -> log.warn(p));

		// 어제 디렉토리 경로
		// files in yesterday directory
		File targetDir = Paths.get("C:\\shoppingmall\\products", getFolderYesterDay()).toFile();
		
		// 어제 디렉토리와 비교해서 삭제할 파일 경로 구하기
		// attach 테이블에 없는 파일목록 구하기
		File[] removeFiles = targetDir.listFiles(
				file -> fileListPaths.contains(file.toPath()) == false);

		log.warn("================ db에 없어서 삭제할 파일 ======================");
		// 하나씩 삭제
		if(removeFiles != null) {
			for (File file : removeFiles) {
				log.warn(file.getAbsolutePath());
				file.delete();
			}
		}
	}
	
	@Scheduled(cron="0 10 * * * *")  // // 매시 10분에 실행
	public void deleteReviewAttaches() throws Exception{
		log.warn("File Check Task run................");
		log.warn(new Date());

		// 어제 업로드 된 첨부파일 목록
		List<ReviewAttachVO> fileList = reviewAttachMapper.getYesterDayAttaches();
		// 어제 업로드 된 첨부파일 목록으로 파일경로 구함
		// ready for check file in directory with DB file list
		List<Path> fileListPaths = fileList.stream()
				.map(
					vo -> Paths.get("C:\\shoppingmall\\review",vo.getPath(),
							vo.getUuid()+"_" + vo.getFileName())
					)
				.collect(Collectors.toList());
				

		// 이미지인 경우 썸네일 파일의 경로 목록
		fileList.stream().filter(vo -> vo.isFileType() == true)
		      .map(
		            vo -> Paths.get(
		                  "C:\\shoppingmall\\review", 
		                  vo.getPath(), 
		                  "s_" + vo.getUuid() + "_" + vo.getFileName())
		      )
		      .forEach(p -> fileListPaths.add(p));

		
		log.warn("================ 어제 리뷰관련 모든 첨부 파일 ======================");
		fileListPaths.forEach(p -> log.warn(p));

		// 어제 디렉토리 경로
		// files in yesterday directory
		File targetDir = Paths.get("C:\\shoppingmall\\review", getFolderYesterDay()).toFile();
		
		// 어제 디렉토리와 비교해서 삭제할 파일 경로 구하기
		// attach 테이블에 없는 파일목록 구하기
		File[] removeFiles = targetDir.listFiles(
				file -> fileListPaths.contains(file.toPath()) == false);

		log.warn("================ db에 없어서 삭제할 파일 ======================");
		if(removeFiles != null) {
			for (File file : removeFiles) {
				log.warn(file.getAbsolutePath());
				file.delete();
			}
		}
	}
}
