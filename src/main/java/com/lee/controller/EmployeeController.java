package com.lee.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lee.dao.EmployeeMapper;
import com.lee.entity.Employee;
import com.lee.entity.Msg;
import com.lee.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.security.Key;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    @ResponseBody
    @RequestMapping(value = "/emp/{empIds}",method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("empIds") String ids){
        if(ids.contains("-")){
            List<Integer> batch = new ArrayList<>();
            String[] del_ids = ids.split("-");
            for (String id : del_ids){
                batch.add(Integer.parseInt(id));
            }
            employeeService.deleteBatch(batch);
        }else{
            int id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }


    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg updateEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }


    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee emp = employeeService.getEmp(id);
        return Msg.success().add("emp",emp);
    }

    @ResponseBody
    @RequestMapping("/checkUser")
    public Msg checkUser(@RequestParam("empName") String empName){
        String regName = "(^[A-Za-z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
        boolean matches = empName.matches(regName);
        if(!matches){
            return Msg.fail().add("va_msg","用户名不可用");
        }
        boolean checkUser = employeeService.checkUser(empName);
        if(checkUser){
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg","用户名被占用");
        }
    }

    @ResponseBody
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    public Msg saveEmp(@Validated Employee employee, BindingResult result){
        if(result.hasErrors()){
            //校验失败，应该返回失败，在模态框中显示错误信息
            Map<String, Object> map =  new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for(FieldError fieldError : fieldErrors){
                String field = fieldError.getField();
                String message = fieldError.getDefaultMessage();
                map.put(field,message);
            }
            return Msg.fail().add("errorFields",map);
        }else{
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

//    @RequestMapping("/emps")
//    public String getEmps(@RequestParam(value = "pn" , defaultValue = "1")Integer pn, Model model){
          //这不是一个分页查询
          //引入PageHelper分页插件
          //在查询之前只需要调用，传入页码，以及每页的大小
//        PageHelper.startPage(pn, 5);
          //startPage后面紧跟的这个查询就是一个分页查询
//        List<Employee> emps = employeeService.getAll();
          //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了
          //封装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数
//        PageInfo pageInfo = new PageInfo(emps,5);
//        model.addAttribute("pageInfo",pageInfo);
//        return "list";
//    }
    /*
    新的方法返回json
     */
    //@ResponseBody的作用其实是将java对象转为json格式的数据
    @ResponseBody
    @RequestMapping("/emps")
    public Msg getEmpsWithJson(@RequestParam(value = "pn" , defaultValue = "1")Integer pn){
        PageHelper.startPage(pn, 5);
        List<Employee> emps = employeeService.getAll();
        PageInfo pageInfo = new PageInfo(emps,5);
        return Msg.success().add("pageInfo",pageInfo);
    }

}
