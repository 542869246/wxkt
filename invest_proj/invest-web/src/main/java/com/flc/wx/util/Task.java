package com.flc.wx.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.TimeUnit;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class Task {
	private Integer index = 1;

	@Scheduled(fixedRate = 5000) // 每5秒执行一次
	public void aTask() {
		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		System.out.println(sdf.format(new Date()) + "*********A任务每5秒执行一次进入测试  第" + index + "次");
		index++;
	}

	@Scheduled(cron = "0/10 * *  * * ? ") // 每10秒执行一次
	public void bTask() {	

		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		System.err.println(sdf.format(new Date()) + "*********B任务10秒执行一次进入测试  第"  + index + "次");
		index++;
	}

}
