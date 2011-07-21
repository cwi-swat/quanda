package nl.cwi.swat.quanda.ast;

import javax.xml.bind.annotation.XmlAttribute;

public abstract class Widget {

	private String label;
	
	@XmlAttribute
	public String getLabel() {
		return label;
	}
	
	public void setLabel(String label) {
		this.label = label;
	}
	
}
