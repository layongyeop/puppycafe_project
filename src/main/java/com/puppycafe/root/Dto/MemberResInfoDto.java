package com.puppycafe.root.Dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberResInfoDto {
	private int rnum;
	private String year;
	private String month;
	private String day;
	private int rstarthour;
	
	
}
