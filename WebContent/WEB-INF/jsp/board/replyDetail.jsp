<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script type="text/javascript" src="//code.jquery.com/jquery-1.12.4.min.js"></script>

<script type="text/javascript">
$("#btnReplyUpdate").click(function(){
	replyUpdate();
});

function replyUpdate(){
	
	var f = document.form1;
	var result = svcf_Ajax("/reply/update.do", f, {
		async:false,
		procType : "R"
	});
	svcf_SyncCallbackFn(result, replyUpdateCallback);
}

function replyUpdateCallback(status, data){
	$("#modifyReply").css("visibility", "hidden");
	listReply();
}
$("#btnReplyDelete").click(function(){
	if(confirm("�����Ͻðڽ��ϱ�?")){
		$.ajax({
			method : 'delete',
			url : "/reply/delete.do?replyRno=${vo.replyRno}",
			success : function(result){
				alert("�����Ǿ����ϴ�.");
				$("#modifyReply").css("visibility", "hidden");
				listReply();
			},
	        error: function (request,status,error){
	        	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

	        }
		})
	}
});

$("#btnReplyClose").click(function(){
	$("#modifyReply").css("visibility", "hidden");
});
</script>
</head>
<body>
��� ��ȣ : <c:out value="${vo.replyRno }"></c:out><br>
<form name="form1">
<textarea style="width:400px" class="form-control" id="replyText" name="replyText" rows="5" cols="82">
	<c:out value="${vo.replyText}"></c:out>
</textarea>
<input type="hidden" name="replyRno" id = "replyRno" value="${vo.replyRno}">
<div>
	<c:if test="${sessionScope.memberId == vo.replyer }">
		<button style="margin-top:10px" class="btn btn-success btn-xs" type="button" id="btnReplyUpdate">����</button>
		<button style="margin-top:10px"  class="btn btn-success btn-xs"type="button" id="btnReplyDelete">����</button>

	</c:if>
	<button style="margin-top:10px"  class="btn btn-success btn-xs" type="button" id="btnReplyClose">�ݱ�</button>
</div>
</form>
</body>
</html>