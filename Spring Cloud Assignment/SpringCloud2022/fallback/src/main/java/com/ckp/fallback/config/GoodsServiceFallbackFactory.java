package com.ckp.fallback.config;

import com.ckp.fallback.bean.Goods;
import com.ckp.fallback.service.GoodsService;
import feign.hystrix.FallbackFactory;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * @作者 Ckp
 * @时间 2022/6/3 下午 6:00
 * @描述 无
 */
@Component
public class GoodsServiceFallbackFactory implements FallbackFactory {
    @Override
    public Object create(Throwable throwable) {
        return new GoodsService(){

            @Override
            public int addGoods(Goods goods) {
                return -1;
            }

            @Override
            public int deleteById(Integer id) {
                return -1;
            }

            @Override
            public int updateGoods(Goods goods) {
                return -1;
            }

            @Override
            public List<Goods> findAll() {
                Goods goods = new Goods();
                goods.setGoodsId(-1);
                goods.setGoodsName("Not found");
                goods.setGoodsFactory("Not found");
                goods.setGoodsPrice("Not found");
                goods.setGoodsStock("Not found");
                ArrayList list = new ArrayList();
                list.add(goods);
                return list;
            }

            @Override
            public Goods findById(Integer id) {
                Goods goods = new Goods();
                goods.setGoodsId(-1);
                goods.setGoodsName(id+"Not found");
                goods.setGoodsFactory(id+"Not found");
                goods.setGoodsPrice(id+"Not found");
                goods.setGoodsStock(id+"Not found");
                return goods;
            }

            @Override
            public List<Goods> findByFactory(String factory) {
                Goods goods = new Goods();
                goods.setGoodsId(-1);
                goods.setGoodsName("Not found");
                goods.setGoodsFactory(factory+"Not found");
                goods.setGoodsPrice("Not found");
                goods.setGoodsStock("Not found");
                ArrayList list = new ArrayList();
                list.add(goods);
                return list;
            }

            @Override
            public List<Goods> findByPrice(String price) {
                Goods goods = new Goods();
                goods.setGoodsId(-1);
                goods.setGoodsName("Not found");
                goods.setGoodsFactory("Not found");
                goods.setGoodsPrice(price+"Not found");
                goods.setGoodsStock("Not found");
                ArrayList list = new ArrayList();
                list.add(goods);
                return list;
            }
        };
    }
}
