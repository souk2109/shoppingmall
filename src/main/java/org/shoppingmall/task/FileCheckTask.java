package org.shoppingmall.task;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.extern.log4j.Log4j;

@Component
@Log4j
public class FileCheckTask {
	
	@Scheduled(cron="0 * * * * *")  //주기 제어
	public void checkFiles() throws Exception{
		log.warn("File Check Task run................");
		log.warn("===================================");
	}
}
