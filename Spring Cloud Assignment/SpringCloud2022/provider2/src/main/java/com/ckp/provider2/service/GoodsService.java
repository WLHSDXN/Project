package com.ckp.provider2.service;

import com.ckp.provider2.bean.Goods;
import com.ckp.provider2.dao.GoodsDao;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @作者 Ckp
 * @时间 2022/6/1 下午 4:59
 * @描述 无
 */
@Service
public class GoodsService {
    @Resource
    private GoodsDao dao;

    public int addGoods(Goods goods) {
        return dao.addGoods(goods);
    }

    public int deleteById(Integer id) {
        return dao.deleteById(id);
    }

    public int updateGoods(Goods goods) {
        return dao.updateGoods(goods);
    }

    public List<Goods> findAll() { return dao.findAll(); }

    public Goods findById(Integer id) {
        return dao.findById(id);
    }

    public List<Goods> findByFactory(String factory) {
        return dao.findByFactory(factory);
    }

    public List<Goods> findByPrice(String price) {
        return dao.findByPrice(price);
    }
}
