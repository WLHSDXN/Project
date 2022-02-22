package three_kingdoms_kill;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Random;
import java.util.Set;

public class Three_Kingdoms_Kill {

	public static void main(String[] args) {

		System.out.println("--------------------欢迎来到三国杀--------------------");
		System.out.println();
		System.out.println("正在加载阵营……");
		// 阵营类2020年12月22日10:43:58
		HashMap campMap = new HashMap();
		campMap.put(0, "红方");
		campMap.put(1, "蓝方");
		// 记录选中的阵营
		ArrayList redCamp = new ArrayList();
		ArrayList blueCamp = new ArrayList();
		System.out.println("【阵营】：" + campMap.get(0) + "、" + campMap.get(1));
		System.out.println();

		System.out.println("正在加载英雄……");
		// 英雄类2020年12月21日20:31:11
		HashMap heroMap = new HashMap();
		Liubei liub = new Liubei();
		Zhugeliang zhugl = new Zhugeliang();
		Guanyu guany = new Guanyu();
		Diaochan diaoc = new Diaochan();
		Zhangfei zhangf = new Zhangfei();
		Lvbu lvb = new Lvbu();
		Huatuo huat = new Huatuo();
		Huanggai huangg = new Huanggai();

		heroMap.put(0, liub);
		heroMap.put(1, zhugl);
		heroMap.put(2, guany);
		heroMap.put(3, diaoc);
		heroMap.put(4, zhangf);
		heroMap.put(5, lvb);
		heroMap.put(6, huat);
		heroMap.put(7, huangg);
		// 记录选中的英雄
		HashSet heroSet = new HashSet();
		System.out.println("【英雄】：" + liub.name + "、" + zhugl.name + "、" + guany.name + "、" + diaoc.name + "、"
				+ zhangf.name + "、" + lvb.name + "、" + huat.name + "、" + huangg.name);
		System.out.println();

		System.out.println("正在加载手牌……");
		// 加载手牌类
//		三国杀中各种手牌数量,共66：
		HashMap cardMap = new HashMap();
//		1、杀共有30张(1-30)
		for (int i = 1; i <= 30; i++) {
			cardMap.put(i, "杀");
		}
//		2、闪共有24张(31-54)
		for (int i = 31; i <= 54; i++) {
			cardMap.put(i, "闪");
		}
//		3、桃共有12张(55-66)
		for (int i = 55; i <= 66; i++) {
			cardMap.put(i, "桃");
		}
		// 牌堆
		HashMap paiduiMap = new HashMap();
		for (int i = 1; i <= 66; i++) {
			paiduiMap.put(i, 0);
		}
		System.out.println("【手牌】：" + cardMap.get(1) + "、" + cardMap.get(31) + "、" + cardMap.get(55));
		System.out.println();

		System.out.println("正在生成玩家……");
		System.out.print("【玩家】：");
		// 玩家初始化
		Players play[] = new Players[6];
		for (int i = 0; i < 6; i++) {
			play[i] = new Players();
			play[i].No = i + 1;
			play[i].name = "玩家" + play[i].No;
			play[i].selectCamp(campMap, redCamp, blueCamp);
			play[i].selectHero(heroMap, heroSet);
			play[i].selectCard(cardMap, 4, paiduiMap);// 开局每人四张手牌
			if (i == 5) {
				System.out.println(play[i].name);
			} else
				System.out.print(play[i].name + "、");

		}
		System.out.println();

		// 游戏开始--------------------------------------------------------------------------------
		System.out.println("--------------------游戏开始--------------------");
		System.out.println();
		// 顺时针顺序出牌
		int i = 1;// 回合数
		int t = 0;// 循环数（测试）
		while ((int) redCamp.size() != 0 && (int) blueCamp.size() != 0) {

			// (int)redCamp.size()！=0&&(int)blueCamp.size()!=0
			// t < 100
			// 遍历6个玩家
			for (int no = 0; no < 6; no++) {
//				System.out.println(redCamp);
//				System.out.println(blueCamp);//测试1

				if ((int) redCamp.size() == 0 || (int) blueCamp.size() == 0)
					break;
				if (play[no].isdie)
					continue;
				System.out.println("--------------------第" + i + "回合--------------------");
				//
				System.out.println("双方阵营：");
				//
				System.out.print("【" + campMap.get(0) + "】：");
				for (int n = 0, o = 1; n < 6; n++) {
					if (play[n].camps == "红方" && !play[n].isdie) {
						System.out.print(" " + play[n].hero.name + "HP:" + play[n].hero.hp + " ");
//						if (o < 3)
//						System.out.print("、");
//						o++;
					}
				}
				System.out.println();
				//
				System.out.print("【" + campMap.get(1) + "】：");
				for (int n = 0, o = 1; n < 6; n++) {
					if (play[n].camps == "蓝方" && !play[n].isdie) {
						System.out.print(" " + play[n].hero.name + "HP:" + play[n].hero.hp + " ");
//						if (o < 3)
////						System.out.print("、");
////						o++;	
					}
				}
				System.out.println();
				//

//			System.out.println(redCamp);
//			System.out.println(blueCamp);//测试1
				System.out.println();
				// 对于活人
				if (!play[no].isdie) {
					System.out.println("每局抽取一张手牌");
					play[no].selectCard(cardMap, 1, paiduiMap);// 每局抽一张牌。
					int num = play[no].cardNum - play[no].hero.hp;
					if (num > 0) {
						for (int j = 0; j < num; j++) {
							play[no].clearCard(cardMap, paiduiMap, 1);// 抽完牌丢弃多余的牌//由于不能在循环中删除多个，所以循环删除一个
						}

						play[no].clearHpCard(cardMap, paiduiMap);// 血量限制手牌
					}
				}
//			System.out.println(play[no].name+"是"+"【"+play[no].camps+"】"+"【"+play[no].hero.name+"】"+play[no].handCard+play[no].cardNum+"张牌");
				System.out.println(play[no].name + "是" + "【" + play[no].camps + "】" + "【" + play[no].hero.name + "】有"
						+ play[no].cardNum + "张牌");
				// 判断是否死亡，否则出牌
				if (play[no].hero.hp <= 0 && !play[no].isdie) {
					if (play[no].camps == "红方") {
						redCamp.remove(0);
						play[no].isdie = true;

					} else {
						blueCamp.remove(0);
						play[no].isdie = true;

					}
					System.out.println(play[no].hero.name + "死亡");
				} else {
					System.out.println("----【出牌】-------------------");//
					play[no].chupai(play[no], play, paiduiMap, redCamp, blueCamp);
					if ((int) redCamp.size() == 0 || (int) blueCamp.size() == 0)
						break;// 出牌之前先判断结束游戏没有
					// 英雄技能
					if (play[no].hero.name == "刘备" && !play[no].isdie) {

						play[no].hero.skills(play[no], play, cardMap);
					} else if (play[no].hero.name == "诸葛亮" && !play[no].isdie) {
						play[no].hero.skills(play[no], paiduiMap);
					} else if (play[no].hero.name == "关羽" && !play[no].isdie) {
						play[no].hero.skills(play[no], play, paiduiMap, redCamp, blueCamp);
					} else if (play[no].hero.name == "貂蝉" && !play[no].isdie) {
						play[no].hero.skills(play[no], play, paiduiMap, redCamp, blueCamp);
					} else if (play[no].hero.name == "张飞" && !play[no].isdie) {
						play[no].hero.skills(play[no], play, paiduiMap, redCamp, blueCamp);
					} else if (play[no].hero.name == "吕布" && !play[no].isdie) {
						play[no].hero.skills(play[no], play, paiduiMap, redCamp, blueCamp);
					} else if (play[no].hero.name == "华佗" && !play[no].isdie) {
						play[no].hero.skills(play[no], paiduiMap);
					} else if (play[no].hero.name == "黄盖" && !play[no].isdie) {
						play[no].hero.skills(play[no], cardMap, paiduiMap, redCamp, blueCamp);
					}

					System.out.println("----【出牌结束】-------------------");
				}
				System.out.println("--------------------第" + i + "回合结束--------------------");
				i++;
				System.out.println();
				System.out.println();
			}
			t++;

		}
		// 游戏结束--------------------------------------------------------------------------------
		// 遍历所有英雄，找到唯一的存活的人
		if (redCamp.size() == 0) {
//				System.out.println("蓝方获胜");
////				break;
			System.out.print("蓝方：");
			for (int n = 0; n < 6; n++) {
				if (play[n].camps == "蓝方" && !play[n].isdie) {
					System.out.print(" " + play[n].hero.name + " ");
				}

			}
			System.out.print("获胜！！！");
		} else {
//				System.out.println("红方获胜");
			System.out.print("红方：");
			for (int n = 0; n < 6; n++) {
				if (play[n].camps == "红方" && !play[n].isdie) {
					System.out.print(" " + play[n].hero.name + " ");
				}

			}
			System.out.print("获胜！！！");
		}
//			for (int n = 0;n < 6;n++) {
//				if(!play[n].isdie) {
//					System.out.print(play[n].hero.name+"胜利，"+play[n].camps+"胜利!");
//				}
//			}

	}

}
