<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Join</title>
</head>
<script type="text/javascript">
var pattern_Id = /^[a-z0-9]{2,15}$/;
var pattern_gon = /\s/g;
var pattern_Pw = /^[0-9a-zA-Z!@#$%^*+=-]{6,12}$/;
var pattern_spc = /[~!@#$%^&*()_+|<>?:{}]/;
var pattern_num = /^[0-9]{4}$/;
var pattern_addr2 = /[a-zA-Z!@#$%^*+=]/;
var pattern_addr = /^[~!@#$%^&*()_+|<>?:{}]{2,18}$/;

function idchk() {
	var id = $j("input[name=userId]").val();
	
	if(!pattern_Id.test(id)||(pattern_gon.test(id))||){
		alert("영문&숫자만 가능합니다.")
		$j("input[name=userId]").focus();
		return false;
	}

	$j.ajax({
	    url : "/board/idchk.do",
	    dataType: "JSON",
	    type: "post",
	    data : "id="+id,
	    success: function(data, textStatus, jqXHR)
	    {
	    	if (data == 1) {
				alert("사용중인 아이디 입니다.");
				$j("input[name=userId]").focus();
				return false;
			} else {
				alert("사용가능한 아이디 입니다.");
				$j("input[name=userPw]").focus();
				return false;
				
			}
	    },
	    error: function (jqXHR, textStatus, errorThrown)
	    {
	    	alert("실패");
	    }
	}); 
}
function uerpw(){
	var pw = $j("input[name=userPw]").val();
	
	if(!pattern_Pw.test(pw)){
		alert("6~12자리 입력해주세요.공백x")
		$j("input[name=userPw]").focus();
		return false;
	}else{
		$j("input[id=pwchk]").focus();
		return false;			
	}
	
}
function pwChk(){
	var pw = $j("input[name=userPw]").val();
	var pwc = $j("input[id=pwchk]").val();
	
	if($j("input[id=pwchk]").focus()&&$j("input[name=userPw]").val()==""){
		alert("비밀번호를 먼저 입렵해주세요.");
		$j("input[name=userPw]").focus();
		return false;
	}
	if($j("input[name=userPw]").val()!= $j("input[id=pwchk]").val()||pattern_gon.test(pwc)){
		alert("비밀번호와 다릅니다.공백x");
		$j("input[id=pwchk]").focus();
		return false;
	}else{
		$j("input[name=userName]").focus();
		return false;
	}
}
function nameChk(){
	var name = $j("input[name=userName]").val();
	
	if(!pattern_spc.test(name)||pattern_gon.test(name)){
		alert("특수문자, 공백 불가합니다.");
		$j("input[name=userName]").focus();
		return false;
	}else{
		$j("input[name=userPhone1]").focus();
		return false;
	}
}
function phone1(){
	var phone1 = $j("input[name=userPhone2]").val();
	
	if(!pattern_num.test(phone1)){
		alert("4자리 숫자만 입력해 주세요.")
		$j("input[name=userPhone2]").focus();
		return false;
	}else{
		$j("input[name=userPhone3]").focus();
		return false;
	}
}
function phone2(){
	var phone2 = $j("input[name=userPhone3]").val();
	
	if(!pattern_num.test(phone2)){
		alert("4자리 숫자만 입력해 주세요.")
		$j("input[name=userPhone2]").focus();
		return false;
	}else{
		$j("input[name=userAddr1]").focus();
		return false;
	}
}
function addr1(){
	var post = $j("input[name=userAddr1]").val();
	var giho = post.match(/\-/g);
	
	if(pattern_gon.test(post)||pattern_addr2.test(post)||post.length != 7||giho == null){
		alert("***-*** 형식으로 값을 넣어 주새요.");
		$j("input[name=userAddr1]").focus();
		return false;
	}else{
		alert(giho);
		$j("input[name=userAddr2]").focus();
		return false;
	}
}
function addr2(){
	var useraddr = $j("input[name=userAddr2]").val();
	
		if(pattern_addr.test(useraddr)||$j("input[name=userAddr2]").val()==""){
			alert("특수문자 공백 사용불가");
			$j("input[name=userAddr2]").focus();
		}else{
			$j("input[name=userCompany]").focus();
		}
}
function compy(){
	
}
	$j(document).ready(function(){
		
		$j("#submit").on("click",function(){
			var id = $j("input[name=userId]").val();
			var pw = $j("input[name=userPw]").val();
			var phone1 = $j("input[name=userPhone2]").val();
			var phone2 = $j("input[name=userPhone3]").val();
			var name = $j("input[name=userName]").val();
			
			if(!pattern_Id.test(id)||(pattern_gon.test(id))){
				alert("ID란을 확인해 주세요")
				$j("input[name=userId]").focus();
				return false;
			}
			if(!pattern_Pw.test(pw)){
				alert("PW란을 확인해 주세요")
				$j("input[name=userPw]").focus();
				return false;
			}
			if(!pattern_num.test(phone1)){
				alert("PHONE란을 확인해주세요")
				$j("input[name=userPhone2]").focus();
				return false;
			}
			if(!pattern_num.test(phone2)){
				alert("PHONE란을 확인해주세요")
				$j("input[name=userPhone2]").focus();
				return false;
			}
			if(!pattern_spc.test(name)||pattern_gon.test(name)){
				alert("NAMM란을 확인해주세요");
				$j("input[name=userName]").focus();
				return false;
			}
			var $frm = $j('.joinform :input');
			var param = $frm.serialize();
			alert(param)
			 $j.ajax({
			    url : "/board/joinInsert.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
					alert("가입완료");
					
					alert("메세지:"+data.success);
					
					location.href = "/board/boardList.do";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("실패");
			    }
			}); 
		});
	});
	

</script>
<body>
	<form class="joinform">
		<table align="center">
			<tr>
				<td>
				<a href ="/board/boardList.do">list</a>
					<table border="1">
					<tr >
						<td width="80" align="center">id</td>
						<td><input type="text" name="userId" maxlength="15" ></td>
						<td><input type="button" value="중복확인" onclick="idchk()"></td>
					</tr>
					<tr >
						<td width="80" align="center">pw</td>
						<td><input type="password" name="userPw" onchange="uerpw()" maxlength="12" ></td>
					</tr>
					<tr >
						<td width="80" align="center">pw check</td>
						<td><input type="password" id="pwchk" onchange="pwChk()" maxlength="12" ></td>
					</tr>
					<tr >
						<td width="80" align="center">name</td>
						<td><input type="text" name="userName" onchange="nameChk()" maxlength="5" ></td>
					</tr>
					<tr >
						<td width="80" align="center" >phone</td>
						<td>
							<select name="userPhone1">
								<c:forEach items="${codeList}" var="list">
									<option value="${list.codeId }">${list.codeName }</option>	
								</c:forEach>
							</select>
							- <input type="text" name="userPhone2"  maxlength="4" size="1" onchange="phone1()" />
							- <input type="text" name="userPhone3"  maxlength="4" size="1" onchange="phone2()" />
						</td>
					</tr>
					<tr >
						<td width="80" align="center">postNo</td>
						<td>
						<input type="text" name="userAddr1" onchange="addr1()" maxlength="7">
						</td>
					</tr>
					<tr >
						<td width="80" align="center">address</td>
						<td><input type="text" name="userAddr2" onchange="addr2()" maxlength="30"></td>
					</tr>
					<tr >
						<td width="80" align="center">company</td>
						<td><input type="text" name="userCompany" onchange="compy()" maxlength="20"></td>
					</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right">
					<a href ="#" id="submit">join</a>
				</td>
			</tr>
		</table>
	</form>

</body>
</html>