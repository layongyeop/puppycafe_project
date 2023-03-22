package com.puppycafe.root.Dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import oracle.sql.TIMESTAMP;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class FreeboardReplyDto {
	private int brnum;
	private String brid;
	private String brcontent;
	private Timestamp brdate;
	private int bnum;
	
	
}
