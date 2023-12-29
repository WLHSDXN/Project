package com.ckp.feign.service;

import com.ckp.feign.bean.Goods;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * @作者 Ckp
 * @时间 2022/6/2 下午 5:22
 * @描述 无
 */
@Service
@FeignClient("provider")
public interface GoodsService {

    @RequestMapping("/goods/addGoods/{goodsId}/{goodsName}/{goodsPrice}/{goodsStock}/{goodsFactory}")
    int addGoods(Goods goods) ;

    @RequestMapping("/goods/deleteById/{id}")
    public int deleteById(@PathVariable(value = "id") Integer id);

    @RequestMapping("/goods/updateGoods/{goodsId}/{goodsName}/{goodsPrice}/{goodsStock}/{goodsFactory}")
    public int updateGoods(Goods goods);

    @RequestMapping("/goods/findAll")
    public List<Goods> findAll();

    @RequestMapping("/goods/findById/{id}")
    public Goods findById(@PathVariable(value = "id") Integer id);

    @RequestMapping("/goods/findByFactory/{factory}")
    public List<Goods> findByFactory(@PathVariable(value = "factory") String factory);

    @RequestMapping("/goods/findByPrice/{price}")
    public List<Goods> findByPrice(@PathVariable(value = "price") String price);
}
