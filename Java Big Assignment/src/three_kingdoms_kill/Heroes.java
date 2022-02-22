package three_kingdoms_kill;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

public class Heroes {
	public String name;
	public int ordinary_hp;
	public int hp;

	public Heroes() {
		this.hp = 0;
	}

//	public int skills(Players thisplay,Players thatplay, HashMap cardMap,HashMap paiduiMap,ArrayList redCamp,ArrayList blueCamp) {
//		return 0;
//	}
//	public int skills(Players thisplay,Players play[], HashMap cardMap,HashMap paiduiMap,ArrayList redCamp,ArrayList blueCamp) {
//		return 0;
//	}

	public int skills(Players thisplay, Players thatplay, HashMap cardMap) {
		return 0;
	}

	public int skills(Players thisplay, Players play[], HashMap paiduiMap) {
		return 0;
	}

	public int skills(Players thisplay, Players play[], HashMap paiduiMap, ArrayList redCamp, ArrayList blueCamp) {
		return 0;
	}

	public int skills(Players thisplay, HashMap paiduiMap) {
		return 0;
	}

	public int skills(Players thisplay, HashMap cardMap, HashMap paiduiMap) {
		return 0;
	}

	public int skills(Players thisplay, HashMap cardMap, HashMap paiduiMap, ArrayList redCamp, ArrayList blueCamp) {
		return 0;
	}
}

class Liubei extends Heroes {
	public Liubei() {
		this.name = "刘备";
		this.ordinary_hp = this.hp = 4;
	}

//	仁德，出牌阶段，可以将一张手牌以任意分配方式交给其他角色并回复1点体力 ,分出的牌，对方无法拒绝。
	public int skills(Players thisplay, Players play[], HashMap cardMap) {

		if (this.hp < this.ordinary_hp && thisplay.cardNum > 0) {
			System.out.println(this.name + "的【仁德】技能开始-------->");

			Players p = thisplay.select_opponent(thisplay, play);

			System.out.println(this.name + "的血量" + this.hp + "少于" + this.ordinary_hp + "并且有" + thisplay.cardNum + "张牌");
			Set entrySet = thisplay.handCard.entrySet();
			Iterator it = entrySet.iterator();

			while (it.hasNext()) {
				HashMap.Entry entry = (HashMap.Entry) (it.next());
				Object key = entry.getKey();
				System.out.println("交换前的牌" + thisplay.handCard + p.handCard + "血量" + this.hp);
				thisplay.handCard.remove(key);
				thisplay.cardNum--;
				p.handCard.put(key, cardMap.get(key));
				p.cardNum++;
				this.hp++;
				System.out.println("交换后的牌" + thisplay.handCard + p.handCard + "血量" + this.hp);
				break;
			}
			System.out.println(this.name + "的【仁德】技能结束-------->");
		} else
			System.out.println(this.name + "未使用【仁德】技能");

		return 0;
	}
}

class Zhugeliang extends Heroes {
	public Zhugeliang() {
		this.name = "诸葛亮";
		this.ordinary_hp = this.hp = 3;
	}

//	“空城”虽然恢复血量，但诸葛亮一般不需要为了空城而刻意弃光手牌。
	public int skills(Players thisplay, HashMap paiduiMap) {
		if (thisplay.hero.hp < 0 || thisplay.hero.hp < thisplay.hero.ordinary_hp) {
			System.out.println(this.name + "的【空城】技能开始-------->");
			Set entrySet = thisplay.handCard.entrySet();
			Iterator it = entrySet.iterator();
//			System.out.println("空城之前"+thisplay.handCard);
//			for (int i = 0;i < thisplay.cardNum;i++) {//不能循环删除，只能循环删除一次
			while (it.hasNext()) {
				HashMap.Entry entry = (HashMap.Entry) (it.next());
				Object key = entry.getKey();
				Object value = entry.getValue();

				thisplay.handCard.remove(key);
				paiduiMap.put(key, 0);
				thisplay.cardNum--;
				break;
			}
//			}
			thisplay.hero.hp = thisplay.hero.ordinary_hp;
//			System.out.println("空城之后"+thisplay.handCard);
			System.out.println(this.name + "丢弃了所有手牌，【空城】技能结束-------->");
		} else
			System.out.println(this.name + "未使用【空城】技能");

		return 0;
	}
}

class Guanyu extends Heroes {
	public Guanyu() {
		this.name = "关羽";
		this.ordinary_hp = this.hp = 4;
	}

	// "武圣"可将一切牌转化为杀
	public int skills(Players thisplay, Players play[], HashMap paiduiMap, ArrayList redCamp, ArrayList blueCamp) {
		System.out.println(this.name + "的【武圣】技能开始-------->");
		Set entrySet = thisplay.handCard.entrySet();
		Iterator it = entrySet.iterator();
//		for (int i = 0;i < thisplay.cardNum;i++) {//不能循环删除，只能循环删除一次
		while (it.hasNext()) {

			HashMap.Entry entry = (HashMap.Entry) (it.next());
			Object key = entry.getKey();
			if (thisplay.handCard.size() != 0) {
				System.out.println(thisplay.hero.name + "有【杀】");
				thisplay.attack(thisplay, thisplay.select_opponent(thisplay, play), paiduiMap, redCamp, blueCamp);

				thisplay.handCard.remove(key);
				paiduiMap.put(key, 0);
				thisplay.cardNum--;
				break;
			} else
				System.out.println(thisplay.hero.name + "没有【杀】，不能使用【武圣】技能！");

		}
//		}
		System.out.println(this.name + "的【武圣】技能结束-------->");

		return 0;
	}
}

class Diaochan extends Heroes {

	public Diaochan() {
		this.name = "貂蝉";
		this.ordinary_hp = this.hp = 3;
	}

	// “离间”是一个异常强大的技能，1张牌必然能换敌方1点血量
	public int skills(Players thisplay, Players play[], HashMap paiduiMap, ArrayList redCamp, ArrayList blueCamp) {
		System.out.println(this.name + "的【离间】技能开始-------->");

		Set entrySet = thisplay.handCard.entrySet();
		Iterator it = entrySet.iterator();
//		for (int i = 0;i < thisplay.cardNum;i++) {//不能循环删除，只能循环删除一次
		while (it.hasNext()) {

			HashMap.Entry entry = (HashMap.Entry) (it.next());
			Object key = entry.getKey();
			System.out.println(thisplay.hero.name + "有手牌【" + key + "】");
			//
//			System.out.println(redCamp.size());
//			System.out.println(blueCamp.size());// 2021年1月9日14:59:21
			//
			if ((int) redCamp.size() == 0 || (int) blueCamp.size() == 0)
				break;// 出牌之前先判断结束游戏没有
			Players p = thisplay.select_opponent(thisplay, play);

			System.out.println("并选择了对象" + p.hero.name + "," + p.hero.name + "被扣一滴血");
			p.hero.hp--;

			if (p.die()) {
				if (p.camps == "红方") {
					redCamp.remove(0);
				} else
					blueCamp.remove(0);
				// -----------------------------------------------------
			} // 2021年1月9日15:01:53

			thisplay.handCard.remove(key);
			paiduiMap.put(key, 0);
			thisplay.cardNum--;
			break;
		}
//		}
		System.out.println(this.name + "的【离间】技能结束-------->");
		return 0;
	}
}

class Zhangfei extends Heroes {
	public Zhangfei() {
		this.name = "张飞";
		this.ordinary_hp = this.hp = 4;
	}

	// 咆哮：锁定技，你使用【杀】无次数限制。
	public int skills(Players thisplay, Players play[], HashMap paiduiMap, ArrayList redCamp, ArrayList blueCamp) {
		System.out.println(this.name + "的【咆哮】技能开始-------->");
		Set entrySet = thisplay.handCard.entrySet();
		Iterator it = entrySet.iterator();

		while (it.hasNext()) {
			HashMap.Entry entry = (HashMap.Entry) (it.next());
			Object key = entry.getKey();
			Object value = entry.getValue();

			if ((String) value == "杀") {
				//
				System.out.println(thisplay.name + "有杀");
				thisplay.attack(thisplay, thisplay.select_opponent(thisplay, play), paiduiMap, redCamp, blueCamp);
				thisplay.handCard.remove(key);
				paiduiMap.put(key, 0);
				thisplay.cardNum--;
//				defense(select_opponent(play));
				break;
			} else
				System.out.println(this.name + "不满足【咆哮】技能");
		}
		System.out.println(this.name + "的【咆哮】技能结束-------->");
		return 0;
	}
}

class Lvbu extends Heroes {
	public Lvbu() {
		this.name = "吕布";
		this.ordinary_hp = this.hp = 4;
	}

	// 无双：锁定技，使用的【杀】需两张【闪】才能抵消；
	public int skills(Players thisplay, Players play[], HashMap paiduiMap, ArrayList redCamp, ArrayList blueCamp) {
		System.out.println(this.name + "的【无双】技能开始-------->");
		Set entrySet = thisplay.handCard.entrySet();
		Iterator it = entrySet.iterator();

		while (it.hasNext()) {
			HashMap.Entry entry = (HashMap.Entry) (it.next());
			Object key = entry.getKey();
			Object value = entry.getValue();

			if ((String) value == "杀") {
				//
				System.out.println(thisplay.hero.name + "有【杀】");
				Players p = thisplay.select_opponent(thisplay, play);
				thisplay.attack(thisplay, p, paiduiMap, redCamp, blueCamp);
				thisplay.attack(thisplay, p, paiduiMap, redCamp, blueCamp);// 攻击两次
				thisplay.handCard.remove(key);
				paiduiMap.put(key, 0);
				thisplay.cardNum--;
//				defense(select_opponent(play));
				break;
			} else
				System.out.println(thisplay.hero.name + "没有【杀】，不能使用【无双】技能！");
		}
		System.out.println(this.name + "的【无双】技能结束-------->");
		return 0;
	}
}

class Huatuo extends Heroes {
	public Huatuo() {
		this.name = "华佗";
		this.ordinary_hp = this.hp = 3;
	}

	// “急救”能让华佗的所有红牌当桃用
	public int skills(Players thisplay, HashMap paiduiMap) {
		System.out.println(this.name + "的【急救】技能开始-------->");
		Set entrySet = thisplay.handCard.entrySet();
		Iterator it = entrySet.iterator();
		int ans = 0;
//		for (int i = 0;i < thisplay.cardNum;i++) {//不能循环删除，只能循环删除一次
		while (it.hasNext()) {

			HashMap.Entry entry = (HashMap.Entry) (it.next());
			Object key = entry.getKey();
			System.out.println(thisplay.name + "有桃，急救成功");
			ans = 1;
			thisplay.handCard.remove(key);
			paiduiMap.put(key, 0);
			thisplay.cardNum--;
			break;
		}
//		}

		System.out.println(this.name + "的【急救】技能结束-------->");
		return ans;// 返回1代表有牌替代桃使用
	}
}

class Huanggai extends Heroes {
	public Huanggai() {
		this.name = "黄盖";
		this.ordinary_hp = this.hp = 4;
	}

	// “苦肉”可以看做是主动发动的“遗计”，1血换2牌，不产生收益。
	public int skills(Players thisplay, HashMap cardMap, HashMap paiduiMap, ArrayList redCamp, ArrayList blueCamp) {
		if (this.hp > 1) {
			System.out.println(this.name + "的【苦肉】技能开始-------->");
			System.out.println(this.name + "使用了【苦肉】技能，损失一滴血，抽取两张牌！");
			thisplay.selectCard(cardMap, 2, paiduiMap);
			this.hp--;

			if (thisplay.die()) {
				if (thisplay.camps == "红方") {
					redCamp.remove(0);
				} else
					blueCamp.remove(0);
				// -----------------------------------------------------
			} // 2021年1月9日15:01:53
			System.out.println(this.name + "的【苦肉】技能结束-------->");
		}
		return 0;
	}
}
