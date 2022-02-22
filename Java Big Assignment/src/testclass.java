
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

public class testclass {

	public static void main(String[] args) {
			
//			HashMap hm = new HashMap();
//			hm.put(1, 0);
//			hm.put(2, 2);
//			System.out.println(hm.get(2));
			
//			Collection values = hm.values();
//			Iterator it = values.iterator();
//			while(it.hasNext()) {
//				Object value = it.next();
//				System.out.println(value);
//			}
//			Set entrySet = hm.entrySet();
//			Iterator it = entrySet.iterator();
//			while(it.hasNext()) {
//				HashMap.Entry entry = (HashMap.Entry)(it.next());
//				Object key = entry.getKey();
//				Object value = entry.getValue();
//				System.out.println(key+"="+value);
				
				
				
				
				//遍历模板
					/*
					Set entrySet = thisplay.handCard.entrySet();
					Iterator it = entrySet.iterator();
					
					while(it.hasNext()) {
						HashMap.Entry entry = (HashMap.Entry)(it.next());
						Object key = entry.getKey();
						Object value = entry.getValue();
					}
					*/
					
					
						
				
			
			//阵营类2020年12月22日10:43:58
					HashMap campMap = new HashMap();
					campMap.put(0, "红方");
					campMap.put(1, "蓝方");
					System.out.println(campMap);
					//记录选中的阵营
					ArrayList redCamp = new ArrayList();
					ArrayList blueCamp = new ArrayList();
//					
//					
					redCamp.add(campMap.get(0));
					redCamp.add(campMap.get(0));
					redCamp.add(campMap.get(0));
					
					blueCamp.add(campMap.get(1));
					blueCamp.add(campMap.get(1));
					blueCamp.add(campMap.get(1));
					
					System.out.println(redCamp);
					System.out.println(blueCamp);
//					
					redCamp.remove(0);
					System.out.println(redCamp);
					
					

	}
}

