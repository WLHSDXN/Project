package three_kingdoms_kill;

public class Cards{
	String name;
//	（方法）杀	攻击对方如果成功掉一点血
//	（方法）闪	在对方使用杀时可以用闪躲避
//	（方法）药	给自己加一点血
}
class Sha extends Cards{
	public Sha() {
		this.name = "杀";
	}
	public Sha(Players play) {
		play.hero.hp--;
	}
}
class Shan extends Cards{
	public Shan() {
		this.name = "闪";
	}
	public Shan(Players play) {
		
	}
}
class Tao extends Cards{
	public Tao() {
		this.name = "杀";
	}
	public Tao(Players play) {
		play.hero.hp++;
	}
}


