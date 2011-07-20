package nl.cwi.swat.quanda.eval;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.mozilla.javascript.Scriptable;
import org.mozilla.javascript.ScriptableObject;

public class Env {

	
	private Map<String, List<Object>> table;

	public Env() {
		this.table = new HashMap<String, List<Object>>();
	}
	
	public Object get(String var) {
		init(var);
		if (table.get(var).isEmpty()) {
			return null;
		}
		List<Object> list = table.get(var);
		return list.get(list.size() - 1);
	}
	
	public void put(String var, Object val) {
		init(var);
		table.get(var).add(val);
	}

	private void init(String var) {
		if (!table.containsKey(var)) {
			table.put(var, new ArrayList<Object>());
		}
	}
	
	public Set<String> keySet() {
		return table.keySet();
	}

	public void define(Scriptable scope) {
		for (String name: keySet()) {
			ScriptableObject.defineProperty(scope, name, get(name), 0);
		}
	}
	
	@Override
	public String toString() {
		return table.toString();
	}
	
}
