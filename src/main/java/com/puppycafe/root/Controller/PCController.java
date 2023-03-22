package com.puppycafe.root.Controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.concurrent.LinkedTransferQueue;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.puppycafe.root.Dao.PCDao;
import com.puppycafe.root.Dto.Criteria;
import com.puppycafe.root.Dto.MemberResInfoDto;
import com.puppycafe.root.Dto.PageDto;
import com.puppycafe.root.Dto.PuppyspeciesDto;
import com.puppycafe.root.Dto.ReservedCellDto;
import com.puppycafe.root.Dto.ReservedDto;
import com.puppycafe.root.Dto.ReservedViewDto;

@Controller
public class PCController {

	@Autowired
	SqlSession sqlSession;
	
	// 메인
	@PostMapping("/")
	public String main() {
		
		return "index";
	}
	//메인
	@RequestMapping(value = "/index",method = RequestMethod.POST)
	public String index() {
		
		return "index";
	}
	//카페 소개
	@RequestMapping(value = "/cafeInfo")
	public String cafeInfo() {
		
		return "cafeInfo";
	}

	//펫종류
	@RequestMapping(value = "/petInfo")
	public String pet() {
		
		return "petInfo";
	}
	//커뮤니티
	@RequestMapping(value = "/community")
	public String community(HttpServletRequest request, Model model,Criteria cri) {
		
		int pageNumInt = 0;
		if(request.getParameter("pageNum") == null) {
			pageNumInt = 1;
			cri.setPageNum(pageNumInt);
			
		} else {
			pageNumInt = Integer.parseInt(request.getParameter("pageNum"));
			cri.setPageNum(pageNumInt);
		}
		PCDao dao = sqlSession.getMapper(PCDao.class);
		
		int totalRecord = dao.boardAllCount();
		cri.setAmount(10); // 한 페이지에 보여줄 글 수
		cri.setStartNum(cri.getPageNum()-1 * cri.getAmount());//해당 페이지의 시작번호를 설정
		PageDto pageDto = new PageDto(cri, totalRecord);
		model.addAttribute("pageMaker", pageDto);
		
		model.addAttribute("currPage", pageNumInt);
		
		model.addAttribute("boardDto", dao.boardList(cri));
		return "community";
	}
	//로그인
	@RequestMapping(value = "/login")
	public String login() {
		
		
		return "login";
	}
	//로그아웃
	@RequestMapping(value = "/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		String sessionId = (String) request.getSession().getAttribute("sessionId");
		if(sessionId ==null) {
			try {
				ScriptUtils.alertAndBackPage(response, "로그인 후 이용해주세요");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		HttpSession session = request.getSession();
		session.invalidate();
		return "index";
	}
	//회원가입
	@RequestMapping(value = "/join")
	public String join(Model model) {
		
		PCDao dao = sqlSession.getMapper(PCDao.class);
		
		ArrayList<PuppyspeciesDto> dto=dao.species();
		
		model.addAttribute("dto", dto);
		
		return "join";
	}
	//회원가입Ok
	@RequestMapping(value = "/joinOk")
	public void joinOk(HttpServletRequest request ,HttpServletResponse response) {
		 String mid = request.getParameter("mid");
		 String mpw = request.getParameter("mpw");
		 String mpw_check = request.getParameter("mpw_check");
		 String mname = request.getParameter("mname");
		 String mphone = request.getParameter("mphone");
		 String pmname = request.getParameter("pmname");
		 String pmcharacter = request.getParameter("pmcharacter");
		 String pmspecies = request.getParameter("pmspecies");
		 String pmage = request.getParameter("pmage");
		 String pmbirth = request.getParameter("pmbirth");
//		 System.out.println(mid.trim());
//		 System.out.println(mpw);
//		 System.out.println(mname);
//		 System.out.println(mphone);
//		 System.out.println(pmname);
		try {
		
		 
		 if(mid==null||mid.trim()==null||mid.equals("")) {
			 ScriptUtils.alertAndBackPage(response, "아이디는 필수 입력사항입니다.!");
		 }else if(mpw==null||mpw.trim()==null||mpw.equals("")) {
			 ScriptUtils.alertAndBackPage(response, "비밀번호는 필수 입력사항입니다.!");
		 }
		 else if(mname==null||mname.trim()==null||mname.equals("")) {
			 ScriptUtils.alertAndBackPage(response, "이름은 필수 입력사항입니다.!");
		 }
		 else if(mphone==null||mphone.trim()==null||mphone.equals("")) {
			 ScriptUtils.alertAndBackPage(response, "전화번호 필수 입력사항입니다.!");
		 }
		 else if(pmname==null||pmname.trim()==null||pmname.equals("")) {
			 ScriptUtils.alertAndBackPage(response, "펫 이름은 필수 입력사항입니다.!");
		 }
		 else {
			 if(mpw.equals(mpw_check)) {
				 PCDao dao = sqlSession.getMapper(PCDao.class);
				 dao.memberInsert(mid, mpw, mname, mphone);
				 dao.puppyInsert(mid, pmname, pmcharacter, pmspecies, pmage, pmbirth);
				 ScriptUtils.alertAndMovePage(response,"회원가입 성공!","/login");
			 }else {
				 ScriptUtils.alertAndBackPage(response, "비밀번호를 다시확인해주세요");
			 }
			 
		 }
		 
	 
		 
		 
		 
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	// 로그인 Ok
	@RequestMapping(value = "/loginOk") 
	public String loginOk(HttpServletRequest request, Model model,HttpServletResponse response)  {
		
		String mid = request.getParameter("mid");
		String mpw = request.getParameter("mpw");
		
		PCDao dao = sqlSession.getMapper(PCDao.class);
		int loginCheck = dao.loginOk(mid, mpw);
		if(loginCheck == 1) {
			HttpSession sessionId = request.getSession();
			sessionId.setAttribute("sessionId", mid);
			model.addAttribute("logincheck", "s"); // 성공
			return "index";
		}else {
			model.addAttribute("logincheck", "f"); // 실패
			return "login";
		}
		
		
			
		
		
	}

	//회원정보 수정내용보기
	@RequestMapping(value = "/memberModifyView")	
	public String memberModify(HttpServletRequest request, Model model) {
		String mid = (String) request.getSession().getAttribute("sessionId");

		
		
		PCDao dao = sqlSession.getMapper(PCDao.class);
		ArrayList<PuppyspeciesDto> dto=dao.species();
		
		model.addAttribute("dto", dto);
	
		model.addAttribute("MemberDto", dao.memberModify(mid));
		model.addAttribute("PMemberDto", dao.pmemberModify(mid));
		
		return "memberModifyView";
	}
	//회원정보 수정완료	
	@RequestMapping(value = "/memberModifyOk") 
	public String memberModifyOk(HttpServletRequest request, Model model) {
		 String mid = request.getParameter("mid");
		 String mpw = request.getParameter("mpw");
		 String mpw_check = request.getParameter("mpw_check");
		 String mname = request.getParameter("mname");
		 String mphone = request.getParameter("mphone");
		 String pmname = request.getParameter("pmname");
		 String pmcharacter = request.getParameter("pmcharacter");
		 String pmspecies = request.getParameter("pmspecies");
		 String pmage = request.getParameter("pmage");
		 String pmbirth = request.getParameter("pmbirth");
//		 System.out.println(mid + mphone + pmage );
		 PCDao dao = sqlSession.getMapper(PCDao.class);
		 dao.memberModifyOk(mid, mpw, mname, mphone);
		 dao.puppyModifyOk(mid, pmname, pmcharacter, pmspecies, pmage, pmbirth);
		return "index";
	}
	//게시판 글내용보기
	@RequestMapping(value = "/contentView")
	public String contentView(HttpServletRequest request, Model model) {
		
		
		String bnum = request.getParameter("bnum");
		
		
		
		
		PCDao dao = sqlSession.getMapper(PCDao.class);
		dao.uphit(bnum);
		
		model.addAttribute("bid", dao.contentView(bnum).getBid());
		model.addAttribute("contentView", dao.contentView(bnum));
		model.addAttribute("replys", dao.freeboardreply(bnum));
		
		return "contentView";
		
	}
	//게시판 글 내용 수정view
	@RequestMapping(value = "/boardModifyView")
	public String boardModify(HttpServletRequest request, Model model) {
		String bnum = request.getParameter("bnum");
		
		PCDao dao = sqlSession.getMapper(PCDao.class);
		
		model.addAttribute("contentView", dao.contentView(bnum));
		
		return "boardModifyView";
	}
	
	//게시판 글 내용 수정 Ok
		@RequestMapping(value = "/boardModifyOk")
		public String boardModifyOk(HttpServletRequest request, Model model) {
			String bnum = request.getParameter("bnum");
			String btitle = request.getParameter("btitle");
			String bcontent = request.getParameter("bcontent");
			PCDao dao = sqlSession.getMapper(PCDao.class);
			
			dao.boardModifyOk(bnum, btitle, bcontent);
			
			return "redirect:community";
		}
	//게시판 글 쓰기 view
		@RequestMapping(value = "/boardInsert")
		public String boardInsert(HttpServletRequest request, Model model) {
			String mid = (String) request.getSession().getAttribute("sessionId");
			
			model.addAttribute("mid", mid);
			return "boardInsert";
		}
		
	//게시판 글 쓰기 Ok
		@RequestMapping(value = "/boardInsertOk")
		public String boardInsertOk(HttpServletRequest request, Model model) {
			String bid = request.getParameter("bid");
			String btitle = request.getParameter("btitle");
			String bcontent = request.getParameter("bcontent");
			PCDao dao = sqlSession.getMapper(PCDao.class);
			dao.boardInsertOk(bid, btitle, bcontent, 0);		
				
			return "redirect:community";
		}
	//예약 달력 보기
		@RequestMapping(value = "/reservedcal")
		public String res(HttpServletRequest request, Model model) {
			
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			
			if(year==null || month ==null) {
				java.util.Calendar cal=java.util.Calendar.getInstance(); //Calendar객체 cal생성
			  int currentYear=cal.get(java.util.Calendar.YEAR); //현재 연도 기억
			  int currentMonth=cal.get(java.util.Calendar.MONTH)+1;//현재 달
			  if(currentMonth<9) {month="0"+currentMonth;}
			  else {month = (currentMonth)+"";}
			  
//			  System.out.println(currentMonth);
			  year = currentYear+"";
			  
			}
			else {
				
					int imonth=Integer.parseInt(month);
					imonth++;
					if(imonth<10) {
						month = "0"+imonth;
					}else {
						month = imonth+"";
					}
				
			}
			
//			System.out.println(year);
//			System.out.println(month);
			
			PCDao dao = sqlSession.getMapper(PCDao.class);
			ArrayList<ReservedCellDto> rcellDto = dao.ReservedCell(year+"-"+month);
			model.addAttribute("rcellDtos", rcellDto);
			return "reservedcal";
			
		}
		//예약 상세보기
		@RequestMapping(value = "/reservedView")
		public String reservedView(HttpServletRequest request, Model model) {
			String sessionId = (String) request.getSession().getAttribute("sessionId");
			String syear = request.getParameter("year");
			String smonth = request.getParameter("month");
			String sday = request.getParameter("day");
			String shour = request.getParameter("starthour");
		
			int month = Integer.parseInt(smonth)+1;
			
			int day = Integer.parseInt(sday);
			model.addAttribute("day", day);
//			System.out.println(month);
			if(month<9) {smonth="0"+month;}
			else {smonth = month+"";}
			if(day<10) {sday="0"+day;}
			
			String rdate = syear +"-" +smonth +"-"+ sday;
			
			PCDao dao = sqlSession.getMapper(PCDao.class);
			
			
			ArrayList<ReservedDto> rDto = dao.reservedInfo(rdate); // 안씀
			
			ArrayList<ReservedViewDto> rviewDto = dao.reserved(rdate); // 예약 강아지 
			
			ArrayList<ReservedCellDto> rcellDto = dao.ReservedCell(syear+"-"+smonth); // 달력 예약현황
			if(sessionId != null) {
			ArrayList<Integer> hourcheck = dao.dbhour(sessionId,rdate); // 이미 예약한 시간
			model.addAttribute("hourcheck",hourcheck);
			}
			
			model.addAttribute("starthour", shour);
			model.addAttribute("rvdtos", rviewDto);
			model.addAttribute("rdate", rdate);
			model.addAttribute("rdtos", rDto);
			model.addAttribute("rcellDtos", rcellDto);
			
			
			
			
			
			return "reservedView";
		}
		//예약하기
		@RequestMapping(value = "/reserved")
		public String reserved(HttpServletRequest request,HttpSession session, Model model,HttpServletResponse response) {
			try {
				String sessionId = (String) request.getSession().getAttribute("sessionId");
				if(sessionId ==null) {
					try {
						ScriptUtils.alertAndBackPage(response, "로그인 후 이용해주세요");
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				
				
				
			
			String rdate = request.getParameter("rdate");
			String[] checks=request.getParameterValues("check");
			
			PCDao dao = sqlSession.getMapper(PCDao.class);
//			System.out.println("rdate"+rdate);
			int doublecheck=0;
			for(String check : checks) {
				int rstarthour= Integer.parseInt(check);
				int dbcheck = dao.dbcheck(sessionId,rdate,rstarthour);
				int rendhour = rstarthour+2;
				
				if(dbcheck ==0) {
					
				}
				else {
					doublecheck++;
					
				}
			}
		
			if(doublecheck==0) {
				for(String check : checks) {
					int rstarthour= Integer.parseInt(check);
					dao.cafeReserved(sessionId, rdate, rstarthour,rstarthour+2);
					
				}
				model.addAttribute("asd", "asd");
				ScriptUtils.alertAndMovePage(response, "예약성공", "reservedcal");
				}else {
					ScriptUtils.alertAndBackPage(response, " 이미 예약된 체크박스는 체크를 해제해주세요");
				}
			
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			return "redirect:reservedcal";
		}
		@RequestMapping(value = "/boardDelete")
		public String boardDelete(HttpServletRequest request, HttpServletResponse response) {
			String bnum = request.getParameter("bnum");
		    
		    String sessionId = (String) request.getSession().getAttribute("sessionId");
			if(sessionId ==null) {
				try {
					ScriptUtils.alertAndBackPage(response, "로그인 후 이용해주세요");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		    
		    PCDao dao = sqlSession.getMapper(PCDao.class);
		    dao.boardDelete(bnum);
		    
		    
			return "redirect:community";
		}
		
		@RequestMapping(value = "/memberResInfo")
		public String memberResInfo(HttpServletRequest request, Model model,HttpServletResponse response) {
			java.util.Calendar cal=java.util.Calendar.getInstance(); //Calendar객체 cal생성
			  int currentYear=cal.get(java.util.Calendar.YEAR); //현재 연도 기억
			  int currentMonth=cal.get(java.util.Calendar.MONTH)+1;//현재 달
			  int currentDay = cal.get(java.util.Calendar.DATE);
			
			String sessionId = (String) request.getSession().getAttribute("sessionId");
			
			PCDao dao = sqlSession.getMapper(PCDao.class);
			
			ArrayList<MemberResInfoDto> resinfo = dao.resInfo(sessionId, currentYear, currentMonth, currentDay);
			
			model.addAttribute("resinfo", resinfo);
			
			
			if(request.getSession().getAttribute("sessionId")==null) {
				try {
					ScriptUtils.alertAndMovePage(response, "로그인 후 이용해주세요", "login");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			
			
			
		    
			return "memberResInfo";
		}
		
		@RequestMapping(value = "/addreply")
		public String  addreply(HttpServletRequest request, Model model, HttpServletResponse response) {
			String sessionId = (String)request.getSession().getAttribute("sessionId");
			
			if(sessionId ==null) {
				try {
					ScriptUtils.alertAndBackPage(response, "로그인 후 이용해주세요");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			
			String brcontent = request.getParameter("brcontent");
			String bnum = request.getParameter("bnum");
			
			PCDao dao = sqlSession.getMapper(PCDao.class);
			
			dao.addreply(sessionId, brcontent, bnum);
			
			model.addAttribute("bid", dao.contentView(bnum).getBid());
			model.addAttribute("contentView", dao.contentView(bnum));
			model.addAttribute("replys", dao.freeboardreply(bnum));
			
		    
			return "contentView";
		}
		@RequestMapping(value = "/removereply")
		public String  removereply(HttpServletRequest request, Model model) {
			
			String brnum = request.getParameter("brnum");
			
			String bnum = request.getParameter("bnum");
//			System.out.println(brnum);
			PCDao dao = sqlSession.getMapper(PCDao.class);
			
			dao.removereply(brnum);
			String bid = dao.contentView(bnum).getBid();
			model.addAttribute("bid", bid);
			model.addAttribute("contentView", dao.contentView(bnum));
			model.addAttribute("replys", dao.freeboardreply(bnum));
			
		    
			return "contentView";
		}
		@RequestMapping(value = "/resdelete")
		public String  resdelete(HttpServletRequest request, Model model, HttpServletResponse response) {
			
			String sessionId = (String) request.getSession().getAttribute("sessionId");
			if(sessionId ==null) {
				try {
					ScriptUtils.alertAndBackPage(response, "로그인 후 이용해주세요");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			
			
			
			String rnum = request.getParameter("rnum");

			PCDao dao = sqlSession.getMapper(PCDao.class);
			
			dao.removeres(rnum);
			
			
		    
			return "redirect:memberResInfo";
		}
		
		@RequestMapping(value = "/memberdelete")
		public String memberdelete(HttpServletRequest request, Model model, HttpServletResponse response) {
			
			String sessionId= (String) request.getSession().getAttribute("sessionId");
			
			if(sessionId ==null) {
				try {
					ScriptUtils.alertAndBackPage(response, "로그인 후 이용해주세요");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			PCDao dao = sqlSession.getMapper(PCDao.class);
			
			dao.memberdelete(sessionId);
			request.getSession().invalidate();
			
			
			
			return "index";
		}
		//예약 상세보기
		@RequestMapping(value = "/reservedmodify")
		public String reservedmodify(HttpServletRequest request, Model model, HttpSession session,HttpServletResponse response) {
			String sessionId = (String) request.getSession().getAttribute("sessionId");
			
			
			if(sessionId ==null) {
				try {
					ScriptUtils.alertAndBackPage(response, "로그인 후 이용해주세요");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			
			
			
			String syear = request.getParameter("year");
			String smonth = request.getParameter("month");
			String sday = request.getParameter("day");
			String shour = request.getParameter("starthour");
			String rnum = request.getParameter("rnum");
			int month = Integer.parseInt(smonth)+1;
			
			
			
			
			
			int day = Integer.parseInt(sday);
			model.addAttribute("day", day);
			System.out.println(month);
			if(month<9) {smonth="0"+month;}
			else {smonth = month+"";}
			if(day<10) {sday="0"+day;}
			
			String rdate = syear +"-" +smonth +"-"+ sday;
			
			PCDao dao = sqlSession.getMapper(PCDao.class);
			
			
			ArrayList<ReservedDto> rDto = dao.reservedInfo(rdate); // 안씀
			
			ArrayList<ReservedViewDto> rviewDto = dao.reserved(rdate); // 예약 강아지 
			
			ArrayList<ReservedCellDto> rcellDto = dao.ReservedCell(syear+"-"+smonth); // 달력 예약현황
			
			ArrayList<Integer> hourcheck = dao.dbhour(sessionId,rdate); // 이미 예약한 시간
			for(int i :hourcheck)
//			System.out.println(i);
//			System.out.println(shour);
			if(shour !=null) {
				session.setAttribute("syear", syear);
				session.setAttribute("smonth", smonth);
				session.setAttribute("sday", sday);
				session.setAttribute("rnum", rnum);
				session.setAttribute("shour", shour);
				
			}
			model.addAttribute("starthour", shour);
			model.addAttribute("rvdtos", rviewDto);
			model.addAttribute("rdate", rdate);
			model.addAttribute("rdtos", rDto);
			model.addAttribute("rcellDtos", rcellDto);
			model.addAttribute("hourcheck",hourcheck);
			
			System.out.println(rdate);
			
			
			return "reservedmodify";
		}
		@RequestMapping(value = "/reservedmodifyOk")
		public String reservedmodifyOk(HttpServletRequest request, Model model,HttpSession session,HttpServletResponse response) {
			String rdate = request.getParameter("rdate");
			String shour = (String) request.getSession().getAttribute("shour");
			String rnum = request.getParameter("rnum");
//			System.out.println("rdate :" +rdate);
			String check = request.getParameter("check");
			int icheck = Integer.parseInt(check);
			int starthour = Integer.parseInt(shour);
//			System.out.println("starthour :"+starthour);
			
			PCDao dao = sqlSession.getMapper(PCDao.class);
			
			dao.reservedmodify(rnum,rdate,icheck);
			
			String sessionId = (String)session.getAttribute("sessionId");
			if(sessionId ==null) {
				try {
					ScriptUtils.alertAndBackPage(response, "로그인 후 이용해주세요");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			
			
			
			session.removeAttribute("syear");
			session.removeAttribute("smonth");
			session.removeAttribute("sday");
			session.removeAttribute("rnum");
			
			
			
			
			return "redirect:reservedcal";
		}
			
				
		
}
