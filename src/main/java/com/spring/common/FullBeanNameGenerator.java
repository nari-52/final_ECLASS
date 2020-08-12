package com.spring.common;

import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.support.BeanDefinitionRegistry;

public class FullBeanNameGenerator implements org.springframework.beans.factory.support.BeanNameGenerator {

	@Override
	public String generateBeanName(BeanDefinition definition, BeanDefinitionRegistry registry) {
		return definition.getBeanClassName(); 
	}
	// 클래스명이 동일해도 충돌하지 않도록 해줌

}
