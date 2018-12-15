<!DOCTYPE html>
<html lang="en">
<head>
  <title>EazyDrive - Signup</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
      .navbar {
      margin-bottom: 0;
      background-color: #f4511e;
      z-index: 9999;
      border: 0;
      font-size: 12px !important;
      line-height: 1.42857143 !important;
      letter-spacing: 4px;
      border-radius: 0;
      font-family: Montserrat, sans-serif;
  }
  .navbar li a, .navbar .navbar-brand {
      color: #fff !important;
  }
  </style>
</head>
<body>
    <nav class="navbar navbar-default navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
            <a class="navbar-brand" href="index.html">EazyDrive</a>
            </div>
        </div>
    </nav>
<br/><br/><br/>
<div class="container">
  <h2>Learner Registration</h2>
  <br/>
  <form class="form-horizontal" method="post" action="<%=request.getContextPath() %>/confirm">
        <div class="form-group">
          <label class="control-label col-sm-2" for="name">Name:</label>
          <div class="col-sm-10">
              <input type="text" class="form-control" name ="name" id="name" placeholder="Enter name" required>
          </div>
        </div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="email">Email:</label>
      <div class="col-sm-10">
        <input type="email" class="form-control" name ="email" id="email" placeholder="Enter email" required>
      </div>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="phno">Phone No.:</label>
      <div class="col-sm-10">
          <input type="number" min="1111111111" max="9999999999" class="form-control" name ="phno" id="phno" placeholder="Enter phone no." required>
      </div>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="dob">Date Of Birth:</label>
      <div class="col-sm-10">
          <input type="date" class="form-control" name ="dob" id="dob" placeholder="Enter email" required>
      </div>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="pwd">Password:</label>
      <div class="col-sm-10">          
          <input type="password" class="form-control" name="pwd" id="pwd" placeholder="Enter password" required>
      </div>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="cnfpwd">Confirm Password:</label>
      <div class="col-sm-10">          
          <input type="password" class="form-control" id="cnfpwd" name="cnfpwd" placeholder="Confirm password" required>
      </div>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="packagelist">Select Package:</label>
      <div class="col-sm-10">        
          
          <select class = "form-control" id = "packagelist" name="packagelist">
            <option>4 weeks</option>
            <option>3 weeks</option>
            <option>2 weeks</option>
        </select>
      </div>
    </div>
    <div class="form-group">        
      <div class="col-sm-offset-2 col-sm-8">
          <input type="submit" class="btn btn-default" value="Register">
      </div>
    </div>
  </form>
</div>

</body>
</html>
