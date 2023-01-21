package com.ckp.breaker.dao;

import com.ckp.breaker.bean.Goods;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * @作者 Ckp
 * @时间 2022/6/1 下午 4:59
 * @描述 无
 */
@Mapper
public interface GoodsDao {

    @Options(useGeneratedKeys = true, keyProperty = "goodsId",keyColumn = "goodsId")
    @Insert("INSERT INTO GOODS (GOODSNAME,GOODSPRICE,GOODSSTOCK,GOODSFACTORY) VALUES (#{goodsName},#{goodsPrice},#{goodsStock},#{goodsFactory})")
    int addGoods(Goods goods);

    @Delete("DELETE FROM GOODS WHERE GOODSID = #{id}")
    int deleteById(Integer id);

    @Update("UPDATE GOODS SET GOODSNAME = #{goodsName},GOODSPRICE = #{goodsPrice},GOODSSTOCK=#{goodsStock},GOODSFACTORY=#{goodsFactory} WHERE GOODSID = #{goodsId}")
    int updateGoods(Goods goods);

    @Select("SELECT * FROM GOODS")
    List<Goods> findAll();

    @Select("select * from GOODS WHERE GOODSID = #{id}")
    Goods findById(Integer id);

    @Select("select * from GOODS WHERE GOODSFACTORY LIKE concat('%', #{factory},'%')")
    List<Goods> findByFactory(String factory);

    @Select("select * from GOODS WHERE GOODSPRICE LIKE concat('%', #{price},'%')")
    List<Goods> findByPrice(String price);

}
