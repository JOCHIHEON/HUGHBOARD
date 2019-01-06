package com.board.hugh.vo;

public class SearchCriteria extends Criteria {
	private String query;
	private String sort;
	
	public SearchCriteria() {
		this.query = "";
		this.sort = "bno";
	}
	
	public String getQuery() {
		return query;
	}
	public void setQuery(String query) {
		this.query = query;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	
	@Override
	public String toString() {
		return "SearchCriteria [query=" + query + ", sort=" + sort + "]";
	}
	
}
