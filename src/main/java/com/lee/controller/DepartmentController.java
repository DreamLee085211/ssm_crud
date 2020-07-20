package com.lee.controller;

import com.lee.entity.Department;
import com.lee.entity.Msg;
import com.lee.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController {

    @Autowired
    DepartmentService departmentService;

    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDepts(){
        List<Department> list = departmentService.getDepts();
        return Msg.success().add("depts", list);
    }
}
