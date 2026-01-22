package com.soomin.myCollection;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = "com.soomin.myCollection") //새로 추가(강제로 읽게 만드는 대목)
public class MyCollectionApplication {

	public static void main(String[] args) {
		SpringApplication.run(MyCollectionApplication.class, args);
	}

}
