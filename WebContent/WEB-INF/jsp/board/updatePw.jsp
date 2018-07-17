<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script type="text/javascript" src="/js/sha1.min.js"></script>
<script type="text/javascript" src="/js/jquery/jquery-1.7.2.min.js" charset="utf-8"></script>
<script type="text/javascript" src="/js/eiwaf/eiwaf-1.0.0.js" charset="utf-8"></script>
<script type="text/javascript" src="/js/util.comn.js" charset="utf-8"></script>
<script type="text/javascript" src="/js/sample.comn.js" charset="utf-8"></script>
<script type="text/javascript" src="/js/sample.menu.js" charset="utf-8"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script>
var pw_validate = false;
var id_validate = false;
$(document).ready(function () {
	//[1] lblError ���̾� Ŭ����
    $('#memberPw').keyup(function () {
        // $('#lblError').remove(); // ����
        $('#lblError').text(''); // Ŭ����
    });
    //[2] ��ȣ Ȯ�� ��� ����
    $('#memberPwCheck').keyup(function () {
    	$('#lblError').text('');
    	if ($('#memberPw').val() != $('#memberPwCheck').val()) {
            $('#lblError').text(''); // Ŭ����
            $('#lblError').html("<b>��ȣ�� Ʋ���ϴ�.</b>"); // ���̾ HTML ���
            pw_validate = false;
        }
        else {
            $('#lblError').text(''); // Ŭ����
            $('#lblError').html("<b>��ȣ�� �½��ϴ�.</b>"); // ���̾ �ؽ�Ʈ ���
            pw_validate = true;
            
        }
    });

});
$(document).on('click', '#idCheck', function(){
  	var f = document.form1;
	var result = svcf_Ajax("/member/idCheck.do", f, {
		async : false,
		procType : "R"
	});
	
	svcf_SyncCallbackFn(result, chkIdCallback);		

});


function chkIdCallback(status, data){

	var pattern = /[^(a-zA-Z0-9)]/;
	
	if(data.cnt =="1"){
			id_validate = true;
			alert("���̵� �����Ǿ����ϴ�.");
			$("#memberPw").focus();
		
	} else {
		alert("���̵� ����� �Է��� �ּ���.");
		id_validate = false;
		return false;
	}
}
$(document).on('click', '#submitBtn', function(){
	
	if($("#memberId").val() == ''){
		alert('���̵�� �ʼ� �Է� �����Դϴ�.');
		return false;
	}
	if($("#memberPw").val() == ''){
		alert('��й�ȣ�� �ʼ� �Է� �����Դϴ�.');
		return false;
	}
	if($("#memberPwCheck").val() == ''){
		alert('��й�ȣȮ���� �ʼ� �Է� �����Դϴ�.');
		return false;
	}
	if(pw_validate == false){
		alert("��й�ȣ�� ����� �Է����ּ���");
		return false;
	} else if(id_validate == false){
		alert("���̵� ����� �Է��ϼ���.")
		return false;
	} else {
		document.getElementById("memberPw").value = b64_sha1($("#memberPw").val());
		var f = document.form1;
		var result = svcf_Ajax("/member/updatePwMember.do", f, {
			
			async : false,
			procType : "R"
		});
		svcf_SyncCallbackFn(result, joinUpdateCallback);
	}
});

function joinUpdateCallback(status, data){
	console.log(data.memberPw);
	alert("�� ��й�ȣ�� ����Ǿ����ϴ�..");
	location.href="/main.do";
}
</script>
<title>�� ��й�ȣ �߱�</title>
</head>
<body style="background-image:url('/img/background2.JPG');background-size:cover;position:absolute;top:50%;left:50%;transform:translate(-50%, -50%)">
<form id="form1" name="form1" method="post">
		<table style="width:400px" class="table">
		<tr>
			<td><strong style="color:white;">���̵�</strong></td>
			<td><input class="form-control"  type="text" id="memberId" name="memberId"></td>
			<td><button type='button' id='idCheck' class="btn btn-default">���̵�Ȯ��</button></td>
		</tr>
		
		<tr>
			<td><strong style="color:white;">���� �߱޹��� ��й�ȣ</strong> </td>
			<td><input class="form-control"  type="password" id="memberPw" name="memberPw"></td>
			<td></td>
		</tr>
		<tr>
			<td><strong style="color:white;">��й�ȣ Ȯ��</strong></td>
			<td><input class="form-control"  type="password" id="memberPwCheck" name="memberPwCheck">
			<div style="margin-top:10px" id="lblError">
				
			</div>
			</td>
			<td></td>
			
		</tr>
		<tr>
			<td><input type="button"  class="btn btn-default" id="submitBtn" value="��й�ȣ ����">
			</td>
			<td></td>
			<td></td>
		</tr>
	</table>
</form>
</body>
</html>