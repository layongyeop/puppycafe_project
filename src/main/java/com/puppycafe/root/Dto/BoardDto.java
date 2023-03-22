package com.puppycafe.root.Dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardDto {
	private int bnum; // 게시판번호
	private String bid; // 글쓴아이디
	private String btitle; // 글제목
	private String bcontent; // 글내용 
	private String bdate; // 글적은시간
	private int bhit; // 조회수
	private int bcomment; //댓글수
	
	
	
	
	
}
