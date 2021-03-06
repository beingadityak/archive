<!DOCTYPE html>
<html lang="en">
<head>
  <title>EazyDrive - Change Schedule</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
    /* Remove the navbar's default margin-bottom and rounded borders */ 
    .navbar {
      margin-bottom: 0;
      border-radius: 0;
    }
    
    /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    .row.content {height: 450px}
    
    /* Set gray background color and 100% height */
    .sidenav {
      padding-top: 20px;
      background-color: #f1f1f1;
      height: 100%;
    }
    
    /* Set black background color, white text and some padding */
    footer {
      background-color: #555;
      color: white;
      padding: 15px;
    }
    
    /* On small screens, set height to 'auto' for sidenav and grid */
    @media screen and (max-width: 767px) {
      .sidenav {
        height: auto;
        padding: 15px;
      }
      .row.content {height:auto;} 
    }
  </style>
</head>
<body>
    <%
    try
    {
        if(session.getAttribute("type") != null && session.getAttribute("type").equals("learner"))
        {%>

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#">EazyDrive - Learner</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li><a href="index.jsp">Home</a></li>
        <li class="active"><a href="change_schedule.jsp">Change Schedule</a></li>
        <li><a href="test_page.jsp">Attempt Test</a></li>
        <li><a href="req_leave.jsp">Request for Leave</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="../logout"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
      </ul>
    </div>
  </div>
</nav>
  
<div class="container-fluid text-center">    
  <div class="row content">
    <div class="col-sm-2 sidenav">
      <p><a href="index.jsp">Home</a></p>
      <p><a href="#">Profile</a></p>
    </div>
    <div class="col-sm-8 text-left"> 
      <h1>Change Learner's Schedule</h1>

    </div>
  </div>
</div>

<footer class="container-fluid text-center">
  <p>Made By Aditya, Kalpesh & Shaival</p>
</footer>

        <%}
        else
        {
            session.invalidate();
            response.sendRedirect("../login.jsp");
        }
    }
    catch(Exception e)
    {
        e.printStackTrace();
    }
    %>
</body>
</html>
