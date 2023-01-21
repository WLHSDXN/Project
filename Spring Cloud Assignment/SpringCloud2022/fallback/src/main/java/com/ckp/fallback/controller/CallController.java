package com.ckp.fallback.controller;

import com.ckp.fallback.bean.Goods;
import com.ckp.fallback.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("consumer")
public class CallController {

    @Qualifier("com.ckp.fallback.service.GoodsService")
    @Autowired
    GoodsService service;

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

    @RequestMapping("/findById/{goodsId}")
    public Goods findById(@PathVariable Integer goodsId) {
        return service.findById(goodsId);
    }

    @RequestMapping("/findByFactory/{factory}")
    public List<Goods> findByFactory(@PathVariable String factory) {
        return service.findByFactory(factory);
    }

    @RequestMapping("/findByPrice/{price}")
    public List<Goods> findByPrice(@PathVariable String price) {
        return service.findByPrice(price);
    }

}
