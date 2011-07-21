package nl.cwi.swat.quanda.ast;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlType;

@XmlType
public class Repeat extends Binder {

	private String count;
	private Rule arg;

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
	
	
	
}
