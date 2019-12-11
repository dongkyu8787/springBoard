<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
</head>
<script type="text/javascript">

	$j(document).ready(function(){
		
		$j("#checkall").click(function(){
			
	        if($j("#checkall").is(":checked")){
	            $j(".chk").prop("checked",true);
	        }else{
	            $j(".chk").prop("checked",false);
	        }
	    });
		$j(".chk").click(function(){
			
	        if($j("input[name='chk']:checked").length == 4){
	            $j("#checkall").prop("checked",true);
	        }else{
	            $j("#checkall").prop("checked",false);
	        }
	    });
		
		$j("#submit").on("click",function(){
			var arrayParam =[];
			
			$j("input:checkbox[name=chk]:checked").each(function(i){

				arrayParam.push($j(this).val());

			});
			
			if($j("input:checkbox[name=chk]:checked").length == 0){
				alert("하나이상 선택해 주세요.");
				return false;
			}else{
				
					$j.ajax({
					    url : "/board/boardListAjax.do",
					    dataType: "html",
					    type: "POST",
					    data : "arrayParam="+arrayParam,
					    success: function(data, textStatus, jqXHR)
					    {
					    	var Table = $j(data).find("#boardTable");
					    	var total = $j(data).find("#total");
					    	var page = $j(data).find("#pageing");
					    	$j("#boardTable").html(Table);
					    	$j("#total").html(total);
					    	$j("#pageing").html(page);

					    },
					    error: function (jqXHR, textStatus, errorThrown)
					    {
					    	alert("실패");
					    }
					});
				}
		});

	});

</script>
<body>
<div id="test1">
<table  align="center">
	<tr>
		<c:choose>
			<c:when test="${ empty userInfo }">
				<td align="left">${userInfo.userId}</td>
			</c:when>
			<c:otherwise>
				<td align="left"><a href="/board/loginPage.do">login</a> <a href="/board/joinPage.do">join</a></td>
			</c:otherwise>
		</c:choose>
		
		<td align="right" id="total">
			total : ${totalCnt}
		</td>
	</tr>
	<tr>
		<td>
			<table id="boardTable" border = "1">
				<tr>
					<td width="80" align="center">
						Type
					</td>
					<td width="40" align="center">
						No
					</td>
					<td width="300" align="center">
						Title
					</td>
				</tr>
				<c:forEach items="${boardList}" var="list">
					<tr id=CBList>
						<td align="center">
							${list.comcode.codeName}
						</td>
						<td>
							${list.boardNum}
						</td>
						<td>
							<a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
						</td>
					</tr>	
				</c:forEach>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
		<c:choose>
			<c:when test="${ empty userInfo }">
				<a href="/board/logout.do" id="logout">로그아웃</a>
				<a href ="/board/boardWrite.do">글쓰기</a>
			</c:when>
			<c:otherwise>
				<a href ="/board/boardWrite.do">글쓰기</a>
			</c:otherwise>
		</c:choose>
		</td>
	</tr>
	<tr>
		<td>
		<label><input type="checkbox" class="chk" id="checkall">전체</label>
		<c:forEach items="${codeList}" var="list">
		<label><input type="checkbox" class="chk" name="chk" value="${list.codeId }">${list.codeName}</label>
		</c:forEach>
		<input type="button" value="조회" id="submit">
		</td>
	</tr>
	<tr>
		<td id="pageing">
		<c:choose>
		<c:when test="${ empty arrayParam}">
			<c:if test="${pageNo>1}">
				<a href="/board/boardList.do?pageNo=${pageNo-1}">&lt;</a>
			</c:if>
			<c:choose>
				<c:when test="${totalCnt % 10 == 0}">
					<c:forEach var="i" begin="1" end="${totalCnt / 10 }">
						<a href="/board/boardList.do?pageNo=${ i }">${ i }</a>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach var="i" begin="1" end="${totalCnt / 10 +1}">
						<a href="/board/boardList.do?pageNo=${ i }">${ i }</a>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			
			<c:if test="${pageNo<totalCnt / 10}">
				<a href="/board/boardList.do?pageNo=${pageNo+1}">&gt;</a>
			</c:if>
		</c:when>
		<c:otherwise>
			<c:if test="${pageNo>1}">
				<a href="/board/boardList.do?arrayParam=${arrayParam}&pageNo=${pageNo-1}">&lt;</a>
			</c:if>
			<c:choose>
				<c:when test="${totalCnt % 10 == 0}">
					<c:forEach var="i" begin="1" end="${totalCnt / 10 }">
						<a href="/board/boardList.do?arrayParam=${arrayParam}&pageNo=${ i }">${ i }</a>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach var="i" begin="1" end="${totalCnt / 10 +1}">
						<a href="/board/boardList.do?arrayParam=${arrayParam}&pageNo=${ i }">${ i }</a>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			
			<c:if test="${pageNo<totalCnt / 10}">
				<a href="/board/boardList.do?arrayParam=${arrayParam}&pageNo=${pageNo+1}">&gt;</a>
			</c:if>
		</c:otherwise>
		</c:choose>
		</td>
	</tr>
	</table>
	</div>
</body>
</html>