package com.zhangsc.service.impl;

import com.zhangsc.dao.sys.TSysUserCustomMapper;
import com.zhangsc.dao.sys.TSysUserMapper;
import com.zhangsc.dao.sys.TSysUserRoleMapper;
import com.zhangsc.pojo.sys.*;
import com.zhangsc.service.SysUserService;
import com.zhangsc.utils.CustomException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-02-13
 */
@Service
public class SysUserServiceImpl implements SysUserService {

    /**用户mapper*/
    @Autowired
    private TSysUserMapper userMapper;
    /**自定义的用户mapper*/
    @Autowired
    private TSysUserCustomMapper userCustomMapper;

    /**用户角色mapper*/
    @Autowired
    private TSysUserRoleMapper userRoleMapper;
    @Override
    public List<TSysUser> query(TSysUser user) {
        TSysUserExample example = new TSysUserExample();
        TSysUserExample.Criteria criteria = example.createCriteria();
        /*条件查询*/
        //账号不为空
        if(user.getAccount() != null){
            criteria.andAccountLike(user.getAccount());
        }
        //状态不为null
        if(user.getStatus() != null){
            criteria.andStatusEqualTo(user.getStatus());
        }
        //姓名不为空
        if(user.getName() != null){
            criteria.andNameLike(user.getName());
        }
        //手机号不为空
        if(user.getMobilePhone() != null){
            criteria.andMobilePhoneLike(user.getMobilePhone());
        }
        List<TSysUser> tSysUsers = userMapper.selectByExample(example);

        return tSysUsers;
    }

    @Override
    public List<TSysUserCustom> query(TSysUserCustom userCustom) {
        return userCustomMapper.queryUserCustom(userCustom);
    }

    @Override
    public TSysUser queryById(Long id) {
        TSysUser user = userMapper.selectByPrimaryKey(id);
        return user;
    }

    @Override
    public TSysUserCustom queryById2(Long id) {
        return userCustomMapper.queryUserCustomById(id);
    }

    @Override
    public void save(TSysUser user) {
        userMapper.insert(user);
    }

    @Override
    public void update(TSysUser user) {
        userMapper.updateByPrimaryKeySelective(user);
    }

    @Override
    public void delete(Long id) {
        TSysUser tSysUser = queryById(id);
        tSysUser.setStatus(0);
        update(tSysUser);
    }

    @Override
    public List<TSysUserRole> getUserRolesByUserId(Long userId) {
        TSysUserRoleExample example = new TSysUserRoleExample();
        TSysUserRoleExample.Criteria criteria = example.createCriteria();
        criteria.andUserIdEqualTo(userId);
        List<TSysUserRole> list = userRoleMapper.selectByExample(example);
        return list;
    }

    @Override
    public void delUserRolesByUserId(Long userId) {
        TSysUserRoleExample example = new TSysUserRoleExample();
        TSysUserRoleExample.Criteria criteria = example.createCriteria();
        criteria.andUserIdEqualTo(userId);
        userRoleMapper.deleteByExample(example);
    }

    @Override
    public void save(TSysUserRole userRole) {
        userRoleMapper.insert(userRole);
    }

    @Override
    public void updatePwd(TSysUserCustom userCustom) {
        //校验旧密码是否正确
        TSysUser tSysUser = queryById(userCustom.getId());
        if(!tSysUser.getPassword().equals(userCustom.getPassword())){
            throw  new CustomException("旧密码错误！");
        }
        //更新密码
        TSysUser user = new TSysUser();
        user.setId(userCustom.getId());
        user.setPassword(userCustom.getNewPwd());
        update(user);
    }
}
