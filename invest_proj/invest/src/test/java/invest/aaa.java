package invest;

import java.util.List;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import com.flc.util.PageData;

public class aaa {
	public static void main(String[] args) {
		String str = "{\"leaves\":[{\"student_id\":\"611542876bf9485f96323eebaafd3c53\",\"lessons_id\":\"166f04b60bc44a89829ddd629d830295\",\"leavecause\":\"123\"},{\"student_id\":\"2c02f12849dd4a78bfde17bb7f4e317c\",\"lessons_id\":\"166f04b60bc44a89829ddd629d830295\",\"leavecause\":\"321\"}]}";
		System.out.println("str:" + str);
		PageData pd2 = JSON.parseObject(str, new TypeReference<PageData>() {
		});
		List<PageData> list = (List<PageData>) pd2.get("leaves");
		System.out.println("list:" + list);
		System.out.println(list.get(0));
		JSONObject jo = new JSONObject(list.get(0));
		System.out.println(jo.get("lessons_id"));

		/*
		 * for (PageData pd : list) { JSONObject jo2 = new JSONObject(pd);
		 * System.out.println(jo.get("lessons_id")); }
		 */

		for (int i = 0; i < list.size(); i++) {
			JSONObject jo2 = new JSONObject(list.get(i));
			System.out.println(jo2.get("lessons_id") + "--" + jo2.get("student_id") + "--" + jo2.get("leavecause"));

		}

	}
}
