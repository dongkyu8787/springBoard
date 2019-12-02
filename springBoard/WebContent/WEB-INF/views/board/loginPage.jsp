<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>LOGIN</title>
</head>
<script type="text/javascript">
$j(document).ready(function(){
	$j("#submit").on("click",function(){
		var id = $j("input[name='userId']").val();
		var pw = $j("input[name='userPw']").val();
		var pattern_Id = /^[a-z0-9]{2,15}$/;
		var pattern_Pw = /^[0-9a-zA-Z]{2,12}$/;
		
		if($j("input[name='userId']").val() == ""){
			alert("���̵� �Է��� �ּ���.");
			$j("input[name=userId]").focus();
			return false;
		}
		if(!pattern_Id.test(id)){
			alert("�߸��� �Է¹���Դϴ�.");
			$j("input[name=userId]").focus();
			return false;
		}
		if(pw == ""){
			alert("��й�ȣ�� �Է��� �ּ���.");
			$j("input[name=userPw]").focus();
			return false;
		}
		if(!pattern_Pw.test(pw)){
			alert("�߸��� �Է¹���Դϴ�.");
			$j("input[name=userPw]").focus();
			return false;
		}
		$j.ajax({
		    url : "/board/idchk.do",
		    dataType: "JSON",
		    type: "GET",
		    data : "id="+id,
		    success: function(data, textStatus, jqXHR)
		    {
		    	if (data == 0) {
					alert("�������� ���� ���̵� �Դϴ�.");
					return false;
				} else {
					
					var $frm = $j('.loginform :input');
					var param = $frm.serialize();
					 
						$j.ajax({
					    url : "/board/loginres.do",
					    dataType: "JSON",
					    type: "POST",
					    data : param ,
					    success: function(data, textStatus, jqXHR)
					    {
					    	if(data.success == "Y"){
					    		alert("�α��� ����");
								
								alert("�޼���:"+data.success);
								
								location.href = "/board/boardList.do";
					    		
					    	}else{
					    		alert("��й�ȣ�� Ʋ���ϴ�.");
					    		
					    		$j("input[name=userPw]").focus();
					    	}
					    },
					    error: function (jqXHR, textStatus, errorThrown)
					    {
					    	alert("����");
					    }
					});
					
				}
		    },
		    error: function (jqXHR, textStatus, errorThrown)
		    {
		    	alert("����");
		    }
		}); 
		
	});			
});

</script>
<body>
<form class="loginform">
<table align="center">
	<tr>
		<td>
			<table border="1">
			<tr >
				<td width="80" align="center">id</td>
				<td><input type="text" name="userId"></td>
			</tr>
			<tr >
				<td width="80" align="center">pw</td>
				<td><input type="password" name="userPw"></td>
			</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a href ="#" id="submit">login</a>
		</td>
	</tr>
</table>
</form>
</body>
</html>