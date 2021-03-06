<%@page import="com.mvc.common.util.PageInfo"%>
<%@page import="com.mvc.project.model.vo.CarryProject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>

<%
	List<CarryProject> list = (ArrayList)request.getAttribute("list");
	PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
%>    

         <section>
            <!-- 2021/01/23 이슬 content_2 안에있던 protitle1 밖으로 뺌 -->
                <div id="protitle1">
                    <hr id="hr1">
                        <h3>성공 임박 프로젝트</h3>
                    <hr id="hr2">
                </div>
                
            <div id="content_2">
                <% if(list.isEmpty()) { %>
                <form class="prodform">
                    <div class="prod" id="prod1"><img src="../resources/logo.PNG" alt=""></div>
                    <p>조회된 프로젝트가 없습니다.</p>
                    <p>달성률(%)</p>
                </form>
                <% } else {
                   for(CarryProject project : list) {%>
                 
                <form class="prodform">
                    <div class="prod" id="prod1"><img src="<%= request.getContextPath() %>/upload/proFile/<%= project.getImgRenamedName() %>" id="home_logo" width="250px"></div>
                    <p><a href="<%= request.getContextPath() %>/project/view?projectNo=<%= project.getProjectNo()%>">
						<%= project.getProjectTitle() %>
					</a></p>
                    <p>달성률(<%= project.getAttainmentPercent()%> %)</p>
                </form>
                <%	}
                } %>
            </div>
        
        <!-- 1.19 페이지 처리하는 html 추가 -->    
		<div id="pageBar1">
			<!-- 맨 처음으로 -->
			<button onclick="location.href='<%= request.getContextPath() %>/project/list?page=1'">&lt;&lt;</button>
			
			<!-- 이전 페이지로 -->
			<button onclick="location.href='<%= request.getContextPath() %>/project/list?page=<%= pageInfo.getPrvePage() %>'">&lt;</button>
			
			<!-- 페이지 목록 -->
			<% for(int p = pageInfo.getStartPage(); p <= pageInfo.getEndPage(); p++){ %>
				<% if(p == pageInfo.getCurrentPage()){ %>
					<button disabled><%= p %></button>
				<% } else { %>
					<button onclick="location.href='<%= request.getContextPath() %>/project/list?page=<%= p %>'"><%= p %></button>
				<% } %>
			<% } %>
			
			<!-- 다음 페이지로 -->
			<button onclick="location.href='<%= request.getContextPath() %>/project/list?page=<%= pageInfo.getNextPage() %>'">&gt;</button>
			
			<!-- 맨 끝으로 -->
			<button onclick="location.href='<%= request.getContextPath() %>/project/list?page=<%= pageInfo.getMaxPage() %>'">&gt;&gt;</button>
		</div>
            
        </section>

<%@ include file="/views/common/footer.jsp" %>
