package nl.cwi.swat.quanda.ast;

import java.util.List;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlIDREF;
import javax.xml.bind.annotation.XmlList;
import javax.xml.bind.annotation.XmlType;

@XmlType
public class Rule {

	
	private String condition;
	private Stat statement;
	
	private List<Binder> dependencies;
	
	@XmlAttribute
	public String getCondition() {
		return condition;
	}
	
	public void setCondition(String condition) {
		this.condition = condition;
	}
	
	public Stat getStatement() {
		return statement;
	}
	
	public void setStatement(Stat statement) {
		this.statement = statement;
	}

	@XmlAttribute
	@XmlIDREF
	@XmlList
	public List<Binder> getDependencies() {
		return dependencies;
	}
	
}
