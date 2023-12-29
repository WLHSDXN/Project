package com.ckp.provider3.bean;

/**
 * @作者 Ckp
 * @时间 2022/6/1 下午 4:57
 * @描述 无
 */
public class Goods {
    private Integer goodsId;
    private String goodsName;
    private String goodsPrice;
    private String goodsStock;
    private String goodsFactory;
    private String instanceId = "Provider Ⅲ";

    public Integer getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(Integer goodsId) {
        this.goodsId = goodsId;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public String getGoodsPrice() {
        return goodsPrice;
    }

    public void setGoodsPrice(String goodsPrice) {
        this.goodsPrice = goodsPrice;
    }

    public String getGoodsStock() {
        return goodsStock;
    }

    public void setGoodsStock(String goodsStock) {
        this.goodsStock = goodsStock;
    }

    public String getGoodsFactory() {
        return goodsFactory;
    }

    public void setGoodsFactory(String goodsFactory) {
        this.goodsFactory = goodsFactory;
    }

    public String getInstanceId() {
        return instanceId;
    }

    public void setInstanceId(String instanceId) {
        this.instanceId = instanceId;
    }
}
