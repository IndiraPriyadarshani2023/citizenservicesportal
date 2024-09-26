<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<c:if test="${not empty successMessage}">
	<script>
		bootbox.alert("${successMessage}");  
	</script>
</c:if>
<c:if test="${not empty failureMessage}">
	<script>
		bootbox.alert("${failureMessage}"); 
	</script> 
</c:if> 

<header class="page-header">
	<h2>Create User</h2> 
	<div class="right-wrapper pull-right">
		<ol class="breadcrumbs">
			<li><a href="${contextPath}/dashBoard.htm"> <i class="fa fa-home"></i> 
			</a></li> 
			<li><span>Dashboard</span></li>
			<li><span>Create User</span></li>
		</ol>
	</div>
</header>
<!-- start: page -->
<div class="row">
	<div class="col-md-12">
		<section class="panel">
			<header class="panel-heading">
				<div class="panel-actions">
					<a href="#" class="fa fa-caret-down"></a>
				</div> 
				<h2 class="panel-title">Create User</h2> 
			</header>
			<div class="panel-body">
				<form action="${contextPath}/addUser.htm" id="addUser" method="post"> 
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />   
					<div class="row">					
						<div class="col-md-3">
							<div class="form-group">
								<label class="col-md-12" for="schemeName">Name</label>
								<div class="col-md-12">
									<input type="text" class="form-control" id="name" name="name" maxlength="500"> 
								</div>
							</div>
						</div>
						<div class="col-md-3">
							<div class="form-group">
								<label class="col-md-10" for="schemeDescription">User Name</label>
								<div class="col-md-10">
									<input type="text" class="form-control" id="userName" name="userName" maxlength="20" onchange="userNameValidation(this.value)"> 
								</div>
							</div>
						</div> 
						<div class="col-md-3">
							<div class="form-group">
								<label class="col-md-10" for="schemeDescription">Password</label>
								<div class="col-md-10">
									<input type="password" class="form-control" id="password" name="password" maxlength="30"> 
								</div>
							</div>
						</div> 
						<div class="col-md-3">
							<div class="form-group">
								<label class="col-md-10" for="schemeDescription">Confirm Password</label>
								<div class="col-md-10">
									<input type="password" class="form-control" id="confirmPassword" name="confirmPassword" maxlength="30"> 
								</div>
							</div>
						</div> 
						<div class="col-md-3">
							<div class="form-group">
								<label class="col-md-10" for="schemeDescription">Mobile Number</label>
								<div class="col-md-10">
									<input type="text" class="form-control" id="mobileNumber" name="mobileNumber" maxlength="10" onkeypress="validateNumber();"> 
								</div>
							</div>
						</div> 
						<div class="col-md-3">
							<div class="form-group">
								<label class="col-md-10" for="schemeDescription">Email Id</label>
								<div class="col-md-10">
									<input type="text" class="form-control" id="emailId" name="emailId" maxlength="100"> 
								</div> 
							</div>
						</div> 
						<div class="col-md-3">
							<div class="form-group">
								<label class="col-md-10">Role</label> 
								<div class="col-md-10"> 
									<select name="roleId" id="roleId" class="form-control populate"> 
										<option value="0">-Select-</option>	
										<c:forEach items="${roleList}" var="role"> 														
											<option value="${role.roleId}">${role.roleType}</option> 																													 
										</c:forEach>		
									</select>
								</div>
							</div> 
						</div>
						<div class="col-md-3">
							<div class="form-group">
								<label class="col-md-10" for="schemeDescription">Address</label> 
								<div class="col-md-10">
									<textarea name="address" rows="2" cols="20" id="address" tabindex="2" class="form-control" maxlength="500"></textarea>                    
								</div> 
							</div>
						</div>
						<div class="col-md-3">
							<div class="form-group">
								<label class="col-md-10" for="schemeDescription">Remark</label> 
								<div class="col-md-10">
									<input type="text" class="form-control" id="remark" name="remark" maxlength="100"> 
								</div> 
							</div>
						</div>
						<div class="col-md-12">
							<div class="text-center">
								<input type="button" name="add" value="Add" id="add" class="btn btn-success" onclick="saveUser();">&nbsp;&nbsp; 
								<a href="${contextPath}/dashBoard.htm" type="button" class="btn btn-warning">Back</a> 
							</div> 
						</div>
					</div>
				</form>
			</div>
		</section>
	</div>
</div>
					
<script>
	function saveUser() {
		var email = $("#emailId").val(); 
		var role = $("#roleId").val(); 
		var password = $("#password").val();
		var confirmPassword = $("#confirmPassword").val(); 
		if ($("#name").val() == "") {
			bootbox.alert("Please Enter Name");
			return false;
		}
		else if ($("#userName").val() == "") {
			bootbox.alert("Please Enter User Name");
			return false;
		}	
		else if ($("#password").val() == "") {
			bootbox.alert("Please Enter Password");
			return false;
		}	
		else if ($("#confirmPassword").val() == "") {
			bootbox.alert("Please Enter Confirm Password");
			return false;
		}	
		else if (password != confirmPassword) { 
			bootbox.alert("Password Mismatch"); 
			$("#password").val("");
			$("#confirmPassword").val("");  
			return false;
		} 
		else if ($("#mobileNumber").val() == "") {
			bootbox.alert("Please Enter Mobile Number");
			return false;
		}	
		else if ($("#emailId").val() == "") {
			bootbox.alert("Please Enter Email Id");
			return false;
		}	
		else if (!ValidateEmail(email)) { 
            return false;
        } 
		else if(role.length == 0 || role == "0"){ 
        	bootbox.alert("Please Choose Role");  
        	return false;
        }  
		else if ($("#address").val() == "") {
			bootbox.alert("Please Enter Address");
			return false;
		}	
        else if ($("#remark").val() == "") {
			bootbox.alert("Please Enter Remark");
			return false;
		}	
		else
		{
			bootbox.confirm("Do you want to save the User?",
		    function(result) {
		       if (result == true) {
		          $("#addUser").submit();
		       }
		    }); 
		}
	}
</script>
<script>
	function userNameValidation(){ 
		var userName = $("#userName").val();
		$.ajax({
			type : "GET",
			url : "validate-user-name.htm",
			data : {
				"userName" : userName,
			},
			success : function(response) {
				var val = JSON.parse(response); 
				if (val[0].duplicateUserName == "User Having This Name Is Already Exist") {
					bootbox.alert("User Having This Name Is Already Exist"); 				
					$("#userName").val("");   
				}  
			}, 
			error : function(error) {
				//alert("Failure");
			} 
		});
	} 
</script>  
<script>
	$(function() {	
		$('#name').keydown(function (e) {	  
			if (e.ctrlKey || e.altKey) {	    
				e.preventDefault();	      
			} else {	    
				var key = e.keyCode;	      
				if (!((key == 8) || (key == 32) || (key == 46) || (key >= 35 && key <= 40) || (key >= 65 && key <= 90))) {	      
					e.preventDefault();	
				} 
			}	
		});         
	});	
	function validateNumber() { 
		if((event.keyCode<48 || event.keyCode>57))
		{
			event.returnValue = false;
		} 
	}  
	function ValidateEmail(email) {
	    if (email != "") {
	        var reg = /^[A-Za-z0-9]([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/
	        if (!reg.test(email)) {
	        	bootbox.alert('Enter a valid email id'); 
	            return false;
	        }
	        else
	            return true;
	    }
	    else
	        return true;
	}; 
</script>
