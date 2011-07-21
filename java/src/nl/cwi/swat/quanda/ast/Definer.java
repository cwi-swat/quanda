package nl.cwi.swat.quanda.ast;

import java.util.List;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlID;
import javax.xml.bind.annotation.XmlIDREF;
import javax.xml.bind.annotation.XmlList;

public abstract class Definer extends Stat {

	private String id;
	private String var;
	
	private List<User> dependents;
	
	@XmlAttribute
	@XmlID
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	@XmlAttribute
	public String getVar() {
		return var;
	}

	public void setVar(String var) {
		this.var = var;
	}

	@XmlAttribute
	@XmlIDREF
	@XmlList
	public List<User> getDependents() {
		return dependents;
	}
	
}
