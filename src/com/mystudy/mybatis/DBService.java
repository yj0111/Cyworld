package com.mystudy.mybatis;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

// Mybatis 사용해서 작업할 SqlSession을 만들어줄 
// SqlSessionFactory 객체 생성을 위한 클래스
public class DBService {
	private static SqlSessionFactory factory;
	
	//static 초기화구문
	static {															
		try {															               	
			factory = new SqlSessionFactoryBuilder().build(Resources.getResourceAsReader("com/mystudy/mybatis/config.xml"));
		} catch (IOException e) {
			e.printStackTrace();
		} 
	}
	
	// SqlSessionFactory factory에 메소드를 이용해 접근하도록 ! (바로접근X)
	public static SqlSessionFactory getFactory() {
		return factory;		
	}

}
