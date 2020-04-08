package com.chrisjoakim.azure.atw.models;

import java.util.StringTokenizer;

/**
 * POJO model class for running marathon instances.
 * 
 * @author Chris Joakim
 * @date   2019/12/15
 */

public class Marathon {

	public String rawLine;
	public int    number;
	public String eventDate;
	public String distance;
	public String mph;
	public String pace;	
	public String course;
	
	public Marathon() {
		
		super();
	}
	
	public Marathon(String csvLine, int seq) {
		
		super();
		
		if (csvLine != null) {
			StringTokenizer st = new StringTokenizer(csvLine, "|");
			this.rawLine = csvLine;
			int tokenNumber = 0;
			while (st.hasMoreTokens()) {
				tokenNumber++;
				switch (tokenNumber) {
					case 1:
						this.number = seq;
						this.setEventDate(st.nextToken());
						break;
					case 2:
						this.setDistance(st.nextToken());
						break;
					case 3:
						this.setMph(st.nextToken());
						break;
					case 4:
						this.setPace(st.nextToken());
						break;
					case 5:
						this.setCourse(st.nextToken());
						break;
				}	
			}
		}
	}
	
	public boolean isValid() {
		
		if (this.eventDate.startsWith("2")) {
			return true;
		}
		else {
			return false;
		}
	}
	
	@Override
	public String toString() {
		
		StringBuffer sb = new StringBuffer();
		sb.append("eventDate: " + eventDate);
		sb.append(" distance: " + distance);
		sb.append(" mph: " + mph);
		sb.append(" pace: " + pace);
		sb.append(" course: " + course);
		sb.append(" rawLine: " + rawLine);
		return sb.toString();
	}

	public String getEventDate() {
		return eventDate;
	}

	public void setEventDate(String eventDate) {
		this.eventDate = eventDate;
	}

	public String getDistance() {
		return distance;
	}

	public void setDistance(String distance) {
		this.distance = distance;
	}

	public String getMph() {
		return mph;
	}

	public void setMph(String mph) {
		this.mph = mph;
	}

	public String getPace() {
		return pace;
	}

	public void setPace(String pace) {
		this.pace = pace;
	}

	public String getCourse() {
		return course;
	}

	public void setCourse(String course) {
		this.course = course;
	}
	
}
