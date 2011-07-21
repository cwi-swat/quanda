package nl.cwi.swat.quanda.ast;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlID;

public abstract class Binder extends Stat {

	private String id;
	private String var;
	
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

	
}
