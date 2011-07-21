package nl.cwi.swat.quanda.ast;

import java.util.Set;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlIDREF;
import javax.xml.bind.annotation.XmlList;
import javax.xml.bind.annotation.XmlType;

@XmlType
public class Repeat extends Definer implements User {

	private String count;
	private Rule arg;
	private Set<Definer> dependencies;

	@XmlAttribute
	public String getCount() {
		return count;
	}
	
	public void setCount(String count) {
		this.count = count;
	}
	
	public Rule getArg() {
		return arg;
	}
	
	public void setArg(Rule arg) {
		this.arg = arg;
	}

	@XmlAttribute
	@XmlIDREF
	@XmlList
	@Override
	public Set<Definer> getDependencies() {
		return dependencies;
	}

	
}
