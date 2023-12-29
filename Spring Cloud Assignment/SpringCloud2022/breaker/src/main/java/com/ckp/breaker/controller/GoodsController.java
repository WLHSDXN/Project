package com.ckp.breaker.controller;


import com.ckp.breaker.bean.Goods;
import com.ckp.breaker.service.GoodsService;
import com.netflix.hystrix.contrib.javanica.annotation.HystrixCommand;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

/**
 * @作者 Ckp
 * @时间 2022/6/1 下午 4:59
 * @描述 无
 */
@RestController
@RequestMapping("goods")
public class GoodsController {
    @Autowired
    private GoodsService service;

    @RequestMapping("/addGoods/{goodsId}/{goodsName}/{goodsPrice}/{goodsStock}/{goodsFactory}")
    public int addGoods(@PathVariable Integer goodsId, @PathVariable String goodsName, @PathVariable String goodsPrice, @PathVariable String goodsStock, @PathVariable String goodsFactory) {
        Goods goods = new Goods();
        goods.setGoodsId(goodsId);
        goods.setGoodsName(goodsName);
        goods.setGoodsPrice(goodsPrice);
        goods.setGoodsStock(goodsStock);
        goods.setGoodsFactory(goodsFactory);
        goods.setInstanceId("Provider Ⅰ");
        return service.addGoods(goods);
    }

    @RequestMapping("/deleteById/{goodsId}")
    public int deleteById(@PathVariable Integer goodsId) {
        return service.deleteById(goodsId);
    }

    @RequestMapping("/updateGoods/{goodsId}/{goodsName}/{goodsPrice}/{goodsStock}/{goodsFactory}")
    public int updateGoods(@PathVariable Integer goodsId, @PathVariable String goodsName, @PathVariable String goodsPrice, @PathVariable String goodsStock, @PathVariable String goodsFactory) {
        if(service.findById(goodsId) == null) {
            return -1;
        }else{
            Goods goods = new Goods();
            goods.setGoodsId(goodsId);
            goods.setGoodsName(goodsName);
            goods.setGoodsPrice(goodsPrice);
            goods.setGoodsStock(goodsStock);
            goods.setGoodsFactory(goodsFactory);
            goods.setInstanceId("Provider Ⅰ");
            return service.updateGoods(goods);
        }
    }

    @RequestMapping("/findAll")
    public List<Goods> findAll() {
        return service.findAll();
    }

    @HystrixCommand(fallbackMethod = "fallback")
    @RequestMapping("/findById/{id}")
    public Goods findById(@PathVariable Integer id) throws Exception {
        Goods goods =  service.findById(id);
        if(goods == null)
            throw new Exception();
        return goods;
    }

    @HystrixCommand(fallbackMethod = "fallback")
    @RequestMapping("/findByFactory/{goodsFactory}")
    public List<Goods> findByFactory(@PathVariable String goodsFactory) throws Exception {
        List<Goods> list =  service.findByFactory(goodsFactory);
        if(list == null || list.size() == 0)
            throw new Exception();
        return list;
    }

    @HystrixCommand(fallbackMethod = "fallback")
    @RequestMapping("/findByPrice/{goodsPrice}")
    public List<Goods> findByPrice(@PathVariable String goodsPrice) throws Exception {
        List<Goods> list =  service.findByPrice(goodsPrice);
        if(list == null || list.size() == 0)
            throw new Exception();
        return list;
    }

    public Goods fallback(@PathVariable("id") Integer id){
        Goods goods = new Goods();
        goods.setGoodsId(-1);
        goods.setGoodsName("Not found");
        goods.setGoodsFactory("Not found");
        goods.setGoodsPrice("Not found");
        goods.setGoodsStock("Not found");
        return goods;
    }
    public List<Goods> fallback(@PathVariable("goodsFactory") String goodsFactory){
        Goods goods = new Goods();
        goods.setGoodsId(-1);
        goods.setGoodsName("Not found");
        goods.setGoodsFactory("Not found");
        goods.setGoodsPrice("Not found");
        goods.setGoodsStock("Not found");
        ArrayList<Goods> list = new ArrayList<>();
        return list;
    }
}
