package nl.cwi.swat.quanda.ctl;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import nl.cwi.swat.quanda.data.Node;
import nl.cwi.swat.quanda.data.Variable;

public class Group extends Node {
	private final Variable var;

	private Set<Source> sources;
	private Set<Sink> sinks;
	
	public Group(Variable var) {
		this.var = var;
	}
	
	public void addSource(Source s) {
		sources.add(s);
		s.addDependent(this);
	}

	public void addSink(Sink s) {
		sinks.add(s);
	}

	@Override
	protected void update(int n) {
		for (Source source: sources) {
			source.notify(n);
		}
		for (Sink sink: sinks) {
			sink.notify(n);
		}
		Map<String, Object> m = new HashMap<String, Object>();
		for (Source source: sources) {
			Variable v = source.getVariable();
			m.put(v.getName(), v.getValue());
		}
		var.assign(n, m);
	}
	
	
	
	
	
}
