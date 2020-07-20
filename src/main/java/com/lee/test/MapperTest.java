package com.lee.test;

import com.lee.dao.DepartmentMapper;
import com.lee.dao.EmployeeMapper;
import com.lee.entity.Department;
import com.lee.entity.Employee;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;
/*
推荐Spring的项目就可以使用Spring的单元测试，可以自动注入我们需要的组件
1、导入SpringTest模块
2、@ContextConfiguration指定Spring配置文件的位置
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSessionTemplate sessionTemplate;

    @Test
    public void testCRUD(){
        System.out.println(departmentMapper);

        //1、插入几个部门
        /*departmentMapper.insertSelective(new Department(null,"开发部"));
        departmentMapper.insertSelective(new Department(null,"测试部"));*/

        //2、插入几个人员
        //employeeMapper.insertSelective(new Employee(null,"lee","M","384711962@qq.com"));

        //employeeMapper.insertSelective(new Employee(null,"tosm","G","ddddfasdf",5));

        EmployeeMapper mapper = sessionTemplate.getMapper(EmployeeMapper.class);
        for (int i = 0;i < 1000;i++){
            String uid = UUID.randomUUID().toString().substring(0,5)+1;
            mapper.insertSelective(new Employee(null, uid, "M", uid+"@lee.com", 5));
        }

    }
}
