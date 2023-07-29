<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!doctype html>
<html>
<head>
	<meta charset ="utf-8">
	<title>탈퇴 페이지</title>
	
 <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<script>
   function login_go(){
	   location.href="login.jsp"
   }
</script>
<style>
    	#leave table{
    		width: 580px;
    		margin-left: auto; 
    		margin-right: auto;
    		border-collapse: collapse;
    		font-size: 14px;
    	}

       #leave tr, #leave h2 {
    		padding: 4px 10px;
           text-align: center;
        }
    	
    	#leave th{
    	   text-align: right;
            margin: auto;
            padding: 0 0 20px 0px;
            width: 32%;    
    	}
    	#leave td{
    	   text-align: center;
            margin: auto;
            padding: 0 0 20px 0px;
            width: 32%;    
    	}
       .html{
	  position: relative; 
		}  
		.cyworldleave{
		  position: absolute;
		  top: 40%;
		  left: 50%;
		  transform: translate(-50%, -50%);
		}
	.input {
      display: inline-block;
	  cursor: pointer;
	  padding: 10px 20px;
	  font-size: 15px;
	  text-align: left;
	  text-decoration: none;
	  outline: none;
	  color: black;
	  background-color: white;
	  border: none;
	  border-radius: 15px;
    }
    .button {
	  display: inline-block;
	  font-size: 24px;
	  cursor: pointer;
	  text-align: center;
	  text-decoration: none;
	  outline: none;
	  color: #fff;
	  background-color: #E57733;
	  border: none;
	  border-radius: 15px;
	  box-shadow: 0 9px #b4b4b4;
	}
	
	.button:hover {background-color: #E56D29}
	
	.button:active {
	  background-color: #DB631F;
	  box-shadow: 0 5px #666;
	  transform: translateY(4px);
	}
</style>
</head>

<body>
<div id="leave" class="cyworldleave">
	<div style="text-align : center;">
	<p><img src="cyworld.png" alt="싸이월드 로고" width="350px" height="75px" ></p>
	<p><img src="cy_1.png" alt="우는 미니미" width="200px" height="150px" ></p>
	</div>
	<h2>탈퇴 완료 되었습니다. 
		모든 정보가 삭제 되었습니다.
	</h2>
	
	<table>
		<tfoot>
			<tr>
				<td colspan="2">
				    <input type ="button" class="button" style="width:260px;height:40px; font-size:1em;" onclick="login_go()" value="처음으로">
    			</td>
    		</tr>
		</tfoot>
	</table>

</div>
    </body>
</html>