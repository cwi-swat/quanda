package nl.cwi.swat.quanda.ast;

import java.util.List;

import javax.xml.bind.annotation.XmlType;

@XmlType
public class Group extends Stat {

	private List<Rule> rules;
	
	public List<Rule> getRules() {
		return rules;
	}
	
	public void setRules(List<Rule> rules) {
		this.rules = rules;
	}
	
}
