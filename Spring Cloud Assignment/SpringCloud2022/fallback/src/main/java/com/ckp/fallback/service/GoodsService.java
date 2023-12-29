package com.ckp.fallback.service;

import com.ckp.fallback.bean.Goods;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

/**
 * @作者 Ckp
 * @时间 2022/6/2 下午 5:22
 * @描述 无
 */
@FeignClient(value = "provider",fallbackFactory = com.ckp.fallback.config.GoodsServiceFallbackFactory.class)
@Service
public interface GoodsService {

    @RequestMapping(value = "/goods/addGoods/{goodsId}/{goodsName}/{goodsPrice}/{goodsStock}/{goodsFactory}",method = RequestMethod.POST)
    int addGoods(Goods goods) ;

    @RequestMapping(value = "/goods/deleteById/{id}",method = RequestMethod.DELETE)
    public int deleteById(@PathVariable(value = "id") Integer id);

    @RequestMapping(value = "/goods/updateGoods/{goodsId}/{goodsName}/{goodsPrice}/{goodsStock}/{goodsFactory}",method = RequestMethod.PUT)
    public int updateGoods(Goods goods);

    @RequestMapping(value = "/goods/findAll", method = RequestMethod.GET)
    public List<Goods> findAll();

    @RequestMapping(value = "/goods/findById/{goodsId}", method = RequestMethod.GET)
    public Goods findById(@PathVariable(value = "goodsId") Integer goodsId);

    @RequestMapping(value = "/goods/findByFactory/{factory}", method = RequestMethod.GET)
    public List<Goods> findByFactory(@PathVariable(value = "factory") String factory);

    @RequestMapping(value = "/goods/findByPrice/{price}", method = RequestMethod.GET)
    public List<Goods> findByPrice(@PathVariable(value = "price") String price);
}
