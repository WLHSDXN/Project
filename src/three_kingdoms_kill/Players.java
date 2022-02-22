package three_kingdoms_kill;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Random;
import java.util.Set;

public class Players {
	// 死亡
	boolean isdie = false;
//	（属性）名字
	String name;
//	序列号
	int No;
//	（属性）阵营
	String camps;
//	（属性）英雄（对象）
	Heroes hero;
//	（属性）手牌（对象）
	// 记录手牌
	HashMap handCard = new HashMap();
//	（属性）玩家持牌数量
	int cardNum = 0;

	// 选阵营
	void selectCamp(HashMap campMap, ArrayList redCamp, ArrayList blueCamp) {
		int k = new Random().nextInt(2);
		if (k == 0 && redCamp.size() <= 2) {
			redCamp.add(this.camps = (String) campMap.get(k));
		} else if (k == 1 && blueCamp.size() <= 2) {
			blueCamp.add(this.camps = (String) campMap.get(k));
		} else {
			this.selectCamp(campMap, redCamp, blueCamp);
		}
	}

	// 抽英雄
	void selectHero(HashMap heroMap, HashSet heroSet) {
		int k = 0;
		int lenth = heroSet.size();
		while (heroSet.size() == lenth) {
			k = new Random().nextInt(8);
			heroSet.add(heroMap.get(k));
			hero = (Heroes) heroMap.get(k);
		}
		// return (String)heroMap.get(k);
	}

//	得到卡牌2021年1月5日
	void selectCard(HashMap cardMap, int num, HashMap paiduiMap) {
		for (int i = 0; i < num; i++) {
			int lenth = handCard.size();
			while (handCard.size() <= lenth) {
				int k = new Random().nextInt(66) + 1;// (1-66)
				if ((int) paiduiMap.get(k) == 0) {
					handCard.put(k, cardMap.get(k));
					paiduiMap.put(k, 1);
					cardNum++;
				}
			}
		}
//		System.out.println(handCard);//测试
	}

	// 【出牌】
	void chupai(Players thisplay, Players play[], HashMap paiduiMap, ArrayList redCamp, ArrayList blueCamp) {

		if ((int) redCamp.size() == 0 || (int) blueCamp.size() == 0) {
			System.out.println("游戏已结束！");
			return;
		} // 2021年1月9日14:15:40

		if (!thisplay.isdie) {
			// 遍历键值对中的值（杀闪桃）

			System.out.print(thisplay.hero.name + "有手牌");//

			Set entrySet2 = thisplay.handCard.entrySet();
			Iterator it2 = entrySet2.iterator();

			while (it2.hasNext()) {
				HashMap.Entry entry2 = (HashMap.Entry) (it2.next());
				Object value2 = entry2.getValue();
				System.out.print(" 【" + value2 + "】 ");
			}
			System.out.println();

			Set entrySet = thisplay.handCard.entrySet();
			Iterator it = entrySet.iterator();

			while (it.hasNext()) {
				HashMap.Entry entry = (HashMap.Entry) (it.next());
				Object key = entry.getKey();
				Object value = entry.getValue();
//					System.out.println("这次是"+value);
//					System.out.println(key+"+"+value);
				if ((String) value == "杀") {
					//
					System.out.println(thisplay.hero.name + "有【杀】");

					if ((int) redCamp.size() == 0 || (int) blueCamp.size() == 0)
						break;// 出牌之前先判断结束游戏没有

					Players p = select_opponent(thisplay, play);
					System.out.println(thisplay.hero.name + "对" + p.hero.name + "使用了【杀】");
					attack(thisplay, p, paiduiMap, redCamp, blueCamp);
					thisplay.handCard.remove(key);
					paiduiMap.put(key, 0);
					thisplay.cardNum--;
//					defense(select_opponent(play));
					break;
				}
			}

		} else {
			System.out.println(thisplay.hero.name + "已死亡！无法【出牌】");
		}

//		System.out.println(thisplay.name+"的"+thisplay.hero.name+"，手牌"+thisplay.handCard+"，有"+thisplay.cardNum+"张牌");
		System.out.println();
	}

	// 【选对手】选择对手阵营英雄（主动）
	Players select_opponent(Players thisplay, Players play[]) {
//		System.out.println("----------【选对手】-------------------");//
		String camp = thisplay.camps;
		System.out.println(thisplay.hero.name + "的阵营是" + camp);
		int k = new Random().nextInt(6);
//		int i = 0;
		while (play[k].camps == camp || play[k].isdie) {
			k = new Random().nextInt(6);
//			if (i > 6) {
//				System.out.println("超时");
//				k = thisplay.No - 1;
//				break;
//			}
//			i++;
		}
		System.out.println(thisplay.hero.name + "选择了" + play[k].camps + "对象" + play[k].hero.name);
//		System.out.println(play[k].hero.name+"的【手牌】"+play[k].handCard);
//		System.out.println("----------【选对手结束】-------------------");//
		return play[k];
	}

	// 【攻击】攻击（主动）
	void attack(Players thisplay, Players thatplay, HashMap paiduiMap, ArrayList redCamp, ArrayList blueCamp) {
//		System.out.println("----------------【攻击】-------------------");//
		if (!(boolean) thatplay.defense(thatplay, paiduiMap, redCamp, blueCamp)) {

			if (thisplay.die()) {
				System.out.println(thisplay.hero.name + "已经死亡");
				if (thisplay.camps == "红方") {
					redCamp.remove(0);
				} else
					blueCamp.remove(0);

				// -----------------------------------------------------
			} // 2021年1月8日21:23:17添加

			if (thatplay.isdie) {
//				if (thatplay.camps=="红方") {
//					redCamp.remove(0);
//				}
//				else blueCamp.remove(0);
				// -----------------------------------------------------2021年1月9日15:01:02
				System.out.println(thatplay.hero.name + "已死亡，无法被攻击");
			} else {
				System.out.println(thatplay.hero.name + "对" + thisplay.hero.name + "防御失败");
				thatplay.hero.hp--;
				if (thatplay.die()) {
					if (thatplay.camps == "红方") {
						redCamp.remove(0);
					} else
						blueCamp.remove(0);
					// -----------------------------------------------------
				} // 2021年1月9日15:01:53

				System.out.println(thatplay.hero.name + "的HP:" + thatplay.hero.hp);

			}

		} else {
			System.out.println(thatplay.hero.name + "对" + thisplay.hero.name + "防御成功");
//			System.out.println(thatplay.hero.name+"的血量"+thatplay.hero.hp);
		}

//		System.out.println("----------------【攻击结束】-------------------");//
	}

	// 【防御】防御（被动）
	boolean defense(Players thisplay, HashMap paiduiMap, ArrayList redCamp, ArrayList blueCamp) {
//		System.out.println("------------------------【防御】-------------------");
		boolean result = false;
		if (!thisplay.isdie) {
//			System.out.println(thisplay.hero.name+"的血量："+thisplay.hero.hp);
			Set entrySet = thisplay.handCard.entrySet();
			Iterator it = entrySet.iterator();

			while (it.hasNext() && result == false) {

				HashMap.Entry entry = (HashMap.Entry) (it.next());
				Object key = entry.getKey();
				Object value = entry.getValue();
//				System.out.println(thisplay.name+"【手牌】"+thisplay.handCard);
				if ((String) value == "闪") {

					System.out.println(thisplay.hero.name + "使用了【闪】，防御成功");
					thisplay.handCard.remove(key);
					paiduiMap.put(key, 0);
					thisplay.cardNum--;
//					System.out.println(thisplay.hero.name+"防御后手牌"+thisplay.handCard);
					result = true;
					break;
				} else if ((String) value == "桃" && thisplay.hero.hp <= 1) {// 最后一血有桃就当做闪
					System.out.println(thisplay.hero.name + "没有【闪】，但使用了【桃】，成功续命");
					thisplay.handCard.remove(key);
					paiduiMap.put(key, 0);
					thisplay.cardNum--;
//					System.out.println(thisplay.hero.name+"防御后手牌"+thisplay.handCard);
					result = true;
					break;
				} else {
//					System.out.println(thisplay.hero.name+"没有【闪】，防御失败");
					result = false;

				}

			}
//			System.out.println(thisplay.hero.name+"的血量："+thisplay.hero.hp);
//			if (thisplay.die()) {
//				if (thisplay.camps=="红方") {
//					redCamp.remove(0);
//				}
//				else blueCamp.remove(1);
//				//-----------------------------------------------------
//			}
		} else
			System.out.println(thisplay.hero.name + "已死亡，无法防御！");
//		System.out.println(thisplay.hero.name+"无手牌，无法防御！");
//		System.out.println("------------------------【防御结束】-------------------");
		return result;
	}

	// 判断是否死亡
	boolean die() {
		if (this.hero.hp <= 0 && !this.isdie) {
			this.isdie = true;
			System.out.println(this.hero.name + "死亡！");
		}

		return this.isdie;
	}

	// 手牌是否大于血量
	boolean selectCardMore() {
		boolean b = false;
		if (this.cardNum > this.hero.hp) {
			b = true;
		}
		return b;
	}

	// 清理手牌
	void clearCard(HashMap cardMap, HashMap paiduiMap, int num) {

//		System.out.println(this.hero.name+"的血量"+this.hero.hp+"，清理前的手牌"+this.handCard+"有："+this.cardNum+"张牌");
		// 测试2
		int i = 1;
		Set entrySet = this.handCard.entrySet();
		Iterator it = entrySet.iterator();

		while (it.hasNext() && i <= num) {
			HashMap.Entry entry = (HashMap.Entry) (it.next());
			Object key = entry.getKey();
			this.handCard.remove(key);
			paiduiMap.put(key, 0);
			this.cardNum--;
			i++;
		}
//		System.out.print(this.hero.name+"的血HP"+this.hero.hp+"，清理后的手牌");
//		//测试3			
//			
//		Set entrySet2 = this.handCard.entrySet();
//		Iterator it2 = entrySet2.iterator();
//		
//		while(it2.hasNext()) {
//			HashMap.Entry entry2 = (HashMap.Entry)(it2.next());
//			Object value2 = entry2.getValue();
//			System.out.print(" 【"+value2+"】 ");
//		}
//		System.out.println();

	}

	// 血量限制手牌
	void clearHpCard(HashMap cardMap, HashMap paiduiMap) {
//		System.out.println(this.hero.name+"的血量"+this.hero.hp+"，清理前的手牌"+this.handCard+"有："+this.cardNum+"张牌");
		// 测试4
		int num = this.cardNum - this.hero.hp;
		if (num > 0) {
			int i = 1;
			Set entrySet = this.handCard.entrySet();
			Iterator it = entrySet.iterator();

			while (it.hasNext() && i <= num) {
				HashMap.Entry entry = (HashMap.Entry) (it.next());
				Object key = entry.getKey();
				this.handCard.remove(key);
				paiduiMap.put(key, 0);
				this.cardNum--;
				i++;
			}
		}

		System.out.print(this.hero.name + "的HP:" + this.hero.hp + "，清理后的手牌");// 测试5

		Set entrySet2 = this.handCard.entrySet();
		Iterator it2 = entrySet2.iterator();

		while (it2.hasNext()) {
			HashMap.Entry entry2 = (HashMap.Entry) (it2.next());
			Object value2 = entry2.getValue();
			System.out.print(" 【" + value2 + "】 ");
		}
		System.out.println();

	}
//	void remove() {}

}
